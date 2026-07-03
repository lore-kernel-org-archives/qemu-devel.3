Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158CCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVna-00057O-0Q; Fri, 03 Jul 2026 00:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wfVnT-00056j-Ob; Fri, 03 Jul 2026 00:46:40 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wfVnQ-0003fq-3U; Fri, 03 Jul 2026 00:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1783053974; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=qzs9ALibZW7VsZCljvnmtNltM1TUFkp7BF8Hb8wbgKs=;
 b=vYUl0uk+k+L2Je51Zl982E5OT/axPCJHo2zGQxyWGXXBmsS9lyd+YRiAmLMRkmZRx9v2eHWouKO+8HWci+d5VkTVQ7rDm+WWl7lI4k3jN6OB8vNVJPtvwLyEuU6r3Er9aKotVDCN66O2TEddwk/LEOgqCGCa/bFr28Jfz8YtHAA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X6Htt9k_1783053971; 
Received: from 30.166.80.210(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X6Htt9k_1783053971 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 03 Jul 2026 12:46:11 +0800
Message-ID: <46288f84-7168-425e-8f81-0824f3f2c22d@linux.alibaba.com>
Date: Fri, 3 Jul 2026 12:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] disas/riscv: Use extract helpers for operand fields
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org
References: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
 <20260701-b4-disas-xthead-fix-riscv-next-v3-5-fc4f5f1b6c15@linux.alibaba.com>
 <87qzlmu51h.fsf@draig.linaro.org>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <87qzlmu51h.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


在 2026/7/1 23:02, Alex Bennée 写道:
> TANG Tiancheng <lyndra@linux.alibaba.com> writes:
>
>> Replace shift-based operand extraction with extract32() and sextract32().
>> For signed immediates, use sextract32() on the field that carries the sign
>> bit and combine it with the remaining extract32() fields.
>>
>> The RISC-V disassembler currently follows target/riscv/internals.h:
>> insn_len() and decodes only 16-bit or 32-bit instruction lengths, so the
>> converted fields are all in the low 32 bits of rv_inst.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   disas/riscv.c | 216 +++++++++++++++++++++++++++++-----------------------------
>>   1 file changed, 108 insertions(+), 108 deletions(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index 4b3f90418f8f17dd3fcb71f70c39607fa293eb0e..2ba0a6a73ad36c6263eed62119d2c4c864b61cb6 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -4202,82 +4202,82 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>>   
>>   static uint32_t operand_rd(rv_inst inst)
>>   {
>> -    return (inst << 52) >> 59;
>> +    return extract32(inst, 7, 5);
>>   }
>>   
>>   static uint32_t operand_rs1(rv_inst inst)
>>   {
>> -    return (inst << 44) >> 59;
>> +    return extract32(inst, 15, 5);
>>   }
>>   
>>   static uint32_t operand_rs2(rv_inst inst)
>>   {
>> -    return (inst << 39) >> 59;
>> +    return extract32(inst, 20, 5);
>>   }
>>   
>>   static uint32_t operand_rs3(rv_inst inst)
>>   {
>> -    return (inst << 32) >> 59;
>> +    return extract32(inst, 27, 5);
>>   }
>>   
>>   static uint32_t operand_aq(rv_inst inst)
>>   {
>> -    return (inst << 37) >> 63;
>> +    return extract32(inst, 26, 1);
>>   }
>>   
>>   static uint32_t operand_rl(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 63;
>> +    return extract32(inst, 25, 1);
>>   }
>>   
>>   static uint32_t operand_pred(rv_inst inst)
>>   {
>> -    return (inst << 36) >> 60;
>> +    return extract32(inst, 24, 4);
>>   }
>>   
>>   static uint32_t operand_succ(rv_inst inst)
>>   {
>> -    return (inst << 40) >> 60;
>> +    return extract32(inst, 20, 4);
>>   }
>>   
>>   static uint32_t operand_rm(rv_inst inst)
>>   {
>> -    return (inst << 49) >> 61;
>> +    return extract32(inst, 12, 3);
>>   }
>>   
>>   static uint32_t operand_shamt5(rv_inst inst)
>>   {
>> -    return (inst << 39) >> 59;
>> +    return extract32(inst, 20, 5);
>>   }
>>   
>>   static uint32_t operand_shamt6(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 58;
>> +    return extract32(inst, 20, 6);
>>   }
>>   
>>   static uint32_t operand_shamt7(rv_inst inst)
>>   {
>> -    return (inst << 37) >> 57;
>> +    return extract32(inst, 20, 7);
>>   }
>>   
>>   static uint32_t operand_crdq(rv_inst inst)
>>   {
>> -    return (inst << 59) >> 61;
>> +    return extract32(inst, 2, 3);
>>   }
>>   
>>   static uint32_t operand_crs1q(rv_inst inst)
>>   {
>> -    return (inst << 54) >> 61;
>> +    return extract32(inst, 7, 3);
>>   }
>>   
>>   static uint32_t operand_crs1rdq(rv_inst inst)
>>   {
>> -    return (inst << 54) >> 61;
>> +    return extract32(inst, 7, 3);
>>   }
>>   
>>   static uint32_t operand_crs2q(rv_inst inst)
>>   {
>> -    return (inst << 59) >> 61;
>> +    return extract32(inst, 2, 3);
>>   }
>>   
>>   static uint32_t calculate_xreg(uint32_t sreg)
>> @@ -4287,80 +4287,80 @@ static uint32_t calculate_xreg(uint32_t sreg)
>>   
>>   static uint32_t operand_sreg1(rv_inst inst)
>>   {
>> -    return calculate_xreg((inst << 54) >> 61);
>> +    return calculate_xreg(extract32(inst, 7, 3));
>>   }
>>   
>>   static uint32_t operand_sreg2(rv_inst inst)
>>   {
>> -    return calculate_xreg((inst << 59) >> 61);
>> +    return calculate_xreg(extract32(inst, 2, 3));
>>   }
>>   
>>   static uint32_t operand_crd(rv_inst inst)
>>   {
>> -    return (inst << 52) >> 59;
>> +    return extract32(inst, 7, 5);
>>   }
>>   
>>   static uint32_t operand_crs1(rv_inst inst)
>>   {
>> -    return (inst << 52) >> 59;
>> +    return extract32(inst, 7, 5);
>>   }
>>   
>>   static uint32_t operand_crs1rd(rv_inst inst)
>>   {
>> -    return (inst << 52) >> 59;
>> +    return extract32(inst, 7, 5);
>>   }
>>   
>>   static uint32_t operand_crs2(rv_inst inst)
>>   {
>> -    return (inst << 57) >> 59;
>> +    return extract32(inst, 2, 5);
>>   }
>>   
>>   static uint32_t operand_cimmsh5(rv_inst inst)
>>   {
>> -    return (inst << 57) >> 59;
>> +    return extract32(inst, 2, 5);
>>   }
>>   
>>   static uint32_t operand_csr12(rv_inst inst)
>>   {
>> -    return (inst << 32) >> 52;
>> +    return extract32(inst, 20, 12);
>>   }
>>   
>>   static int32_t operand_imm12(rv_inst inst)
>>   {
>> -    return ((int64_t)inst << 32) >> 52;
>> +    return sextract32(inst, 20, 12);
>>   }
>>   
>>   static int32_t operand_imm20(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 44) << 12;
>> +    return sextract32(inst, 12, 20) << 12;
>>   }
>>   
>>   static int32_t operand_jimm20(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 63) << 20 |
>> -        ((inst << 33) >> 54) << 1 |
>> -        ((inst << 43) >> 63) << 11 |
>> -        ((inst << 44) >> 56) << 12;
>> +    return sextract32(inst, 31, 1) << 20 |
>> +        extract32(inst, 21, 10) << 1 |
>> +        extract32(inst, 20, 1) << 11 |
>> +        extract32(inst, 12, 8) << 12;
>>   }
>>   
>>   static int32_t operand_simm12(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 57) << 5 |
>> -        (inst << 52) >> 59;
>> +    return sextract32(inst, 25, 7) << 5 |
>> +        extract32(inst, 7, 5);
>>   }
>>   
>>   static int32_t operand_sbimm12(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 63) << 12 |
>> -        ((inst << 33) >> 58) << 5 |
>> -        ((inst << 52) >> 60) << 1 |
>> -        ((inst << 56) >> 63) << 11;
>> +    return sextract32(inst, 31, 1) << 12 |
>> +        extract32(inst, 25, 6) << 5 |
>> +        extract32(inst, 8, 4) << 1 |
>> +        extract32(inst, 7, 1) << 11;
>>   }
>>   
>>   static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
>>   {
>> -    int imm = ((inst << 51) >> 63) << 5 |
>> -        (inst << 57) >> 59;
>> +    int imm = extract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 2, 5);
>>       if (isa == rv128) {
>>           imm = imm ? imm : 64;
>>       }
>> @@ -4369,8 +4369,8 @@ static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
>>   
>>   static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
>>   {
>> -    int imm = ((inst << 51) >> 63) << 5 |
>> -        (inst << 57) >> 59;
>> +    int imm = extract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 2, 5);
>>       if (isa == rv128) {
>>           imm = imm | (imm & 32) << 1;
>>           imm = imm ? imm : 64;
>> @@ -4380,116 +4380,116 @@ static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
>>   
>>   static int32_t operand_cimmi(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 51) >> 63) << 5 |
>> -        (inst << 57) >> 59;
>> +    return sextract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 2, 5);
>>   }
>>   
>>   static int32_t operand_cimmui(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 51) >> 63) << 17 |
>> -        ((inst << 57) >> 59) << 12;
>> +    return sextract32(inst, 12, 1) << 17 |
>> +        extract32(inst, 2, 5) << 12;
>>   }
>>   
>>   static uint32_t operand_cimmlwsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 63) << 5 |
>> -        ((inst << 57) >> 61) << 2 |
>> -        ((inst << 60) >> 62) << 6;
>> +    return extract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 4, 3) << 2 |
>> +        extract32(inst, 2, 2) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmldsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 63) << 5 |
>> -        ((inst << 57) >> 62) << 3 |
>> -        ((inst << 59) >> 61) << 6;
>> +    return extract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 5, 2) << 3 |
>> +        extract32(inst, 2, 3) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmlqsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 63) << 5 |
>> -        ((inst << 57) >> 63) << 4 |
>> -        ((inst << 58) >> 60) << 6;
>> +    return extract32(inst, 12, 1) << 5 |
>> +        extract32(inst, 6, 1) << 4 |
>> +        extract32(inst, 2, 4) << 6;
>>   }
>>   
>>   static int32_t operand_cimm16sp(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 51) >> 63) << 9 |
>> -        ((inst << 57) >> 63) << 4 |
>> -        ((inst << 58) >> 63) << 6 |
>> -        ((inst << 59) >> 62) << 7 |
>> -        ((inst << 61) >> 63) << 5;
>> +    return sextract32(inst, 12, 1) << 9 |
>> +        extract32(inst, 6, 1) << 4 |
>> +        extract32(inst, 5, 1) << 6 |
>> +        extract32(inst, 3, 2) << 7 |
>> +        extract32(inst, 2, 1) << 5;
>>   }
>>   
>>   static int32_t operand_cimmj(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 51) >> 63) << 11 |
>> -        ((inst << 52) >> 63) << 4 |
>> -        ((inst << 53) >> 62) << 8 |
>> -        ((inst << 55) >> 63) << 10 |
>> -        ((inst << 56) >> 63) << 6 |
>> -        ((inst << 57) >> 63) << 7 |
>> -        ((inst << 58) >> 61) << 1 |
>> -        ((inst << 61) >> 63) << 5;
>> +    return sextract32(inst, 12, 1) << 11 |
>> +        extract32(inst, 11, 1) << 4 |
>> +        extract32(inst, 9, 2) << 8 |
>> +        extract32(inst, 8, 1) << 10 |
>> +        extract32(inst, 7, 1) << 6 |
>> +        extract32(inst, 6, 1) << 7 |
>> +        extract32(inst, 3, 3) << 1 |
>> +        extract32(inst, 2, 1) << 5;
>>   }
>>   
>>   static int32_t operand_cimmb(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 51) >> 63) << 8 |
>> -        ((inst << 52) >> 62) << 3 |
>> -        ((inst << 57) >> 62) << 6 |
>> -        ((inst << 59) >> 62) << 1 |
>> -        ((inst << 61) >> 63) << 5;
>> +    return sextract32(inst, 12, 1) << 8 |
>> +        extract32(inst, 10, 2) << 3 |
>> +        extract32(inst, 5, 2) << 6 |
>> +        extract32(inst, 3, 2) << 1 |
>> +        extract32(inst, 2, 1) << 5;
>>   }
>>   
>>   static uint32_t operand_cimmswsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 60) << 2 |
>> -        ((inst << 55) >> 62) << 6;
>> +    return extract32(inst, 9, 4) << 2 |
>> +        extract32(inst, 7, 2) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmsdsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 61) << 3 |
>> -        ((inst << 54) >> 61) << 6;
>> +    return extract32(inst, 10, 3) << 3 |
>> +        extract32(inst, 7, 3) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmsqsp(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 62) << 4 |
>> -        ((inst << 53) >> 60) << 6;
>> +    return extract32(inst, 11, 2) << 4 |
>> +        extract32(inst, 7, 4) << 6;
>>   }
>>   
>>   static uint32_t operand_cimm4spn(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 62) << 4 |
>> -        ((inst << 53) >> 60) << 6 |
>> -        ((inst << 57) >> 63) << 2 |
>> -        ((inst << 58) >> 63) << 3;
>> +    return extract32(inst, 11, 2) << 4 |
>> +        extract32(inst, 7, 4) << 6 |
>> +        extract32(inst, 6, 1) << 2 |
>> +        extract32(inst, 5, 1) << 3;
>>   }
>>   
>>   static uint32_t operand_cimmw(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 61) << 3 |
>> -        ((inst << 57) >> 63) << 2 |
>> -        ((inst << 58) >> 63) << 6;
>> +    return extract32(inst, 10, 3) << 3 |
>> +        extract32(inst, 6, 1) << 2 |
>> +        extract32(inst, 5, 1) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmd(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 61) << 3 |
>> -        ((inst << 57) >> 62) << 6;
>> +    return extract32(inst, 10, 3) << 3 |
>> +        extract32(inst, 5, 2) << 6;
>>   }
>>   
>>   static uint32_t operand_cimmq(rv_inst inst)
>>   {
>> -    return ((inst << 51) >> 62) << 4 |
>> -        ((inst << 53) >> 63) << 8 |
>> -        ((inst << 57) >> 62) << 6;
>> +    return extract32(inst, 11, 2) << 4 |
>> +        extract32(inst, 10, 1) << 8 |
>> +        extract32(inst, 5, 2) << 6;
>>   }
>>   
>>   static int32_t operand_vimm(rv_inst inst)
>>   {
>> -    return (int64_t)(inst << 44) >> 59;
>> +    return sextract32(inst, 15, 5);
>>   }
>>   
>>   static uint32_t operand_vuimm(rv_inst inst)
>> @@ -4499,74 +4499,74 @@ static uint32_t operand_vuimm(rv_inst inst)
>>   
>>   static uint32_t operand_vzimm11(rv_inst inst)
>>   {
>> -    return (inst << 33) >> 53;
>> +    return extract32(inst, 20, 11);
>>   }
>>   
>>   static uint32_t operand_vzimm10(rv_inst inst)
>>   {
>> -    return (inst << 34) >> 54;
>> +    return extract32(inst, 20, 10);
>>   }
>>   
>>   static uint32_t operand_vzimm6(rv_inst inst)
>>   {
>> -    return ((inst << 37) >> 63) << 5 |
>> -        ((inst << 44) >> 59);
>> +    return extract32(inst, 26, 1) << 5 |
>> +        extract32(inst, 15, 5);
>>   }
>>   
>>   static uint32_t operand_bs(rv_inst inst)
>>   {
>> -    return (inst << 32) >> 62;
>> +    return extract32(inst, 30, 2);
>>   }
>>   
>>   static uint32_t operand_rnum(rv_inst inst)
>>   {
>> -    return (inst << 40) >> 60;
>> +    return extract32(inst, 20, 4);
>>   }
>>   
>>   static uint32_t operand_vm(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 63;
>> +    return extract32(inst, 25, 1);
>>   }
>>   
>>   static uint32_t operand_uimm_c_lb(rv_inst inst)
>>   {
>> -    return (((inst << 58) >> 63) << 1) |
>> -        ((inst << 57) >> 63);
>> +    return extract32(inst, 5, 1) << 1 |
>> +        extract32(inst, 6, 1);
>>   }
>>   
>>   static uint32_t operand_uimm_c_lh(rv_inst inst)
>>   {
>> -    return (((inst << 58) >> 63) << 1);
>> +    return extract32(inst, 5, 1) << 1;
>>   }
>>   
>>   static uint32_t operand_zcmp_spimm(rv_inst inst)
>>   {
>> -    return ((inst << 60) >> 62) << 4;
>> +    return extract32(inst, 2, 2) << 4;
>>   }
>>   
>>   static uint32_t operand_zcmp_rlist(rv_inst inst)
>>   {
>> -    return ((inst << 56) >> 60);
>> +    return extract32(inst, 4, 4);
>>   }
>>   
>>   static uint32_t operand_imm6(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 58;
>> +    return extract32(inst, 20, 6);
>>   }
> Ahh there it is, I would have just fixed it directly.
Good point, I'll do that in v4.

I'll make the fix patch use extract32(inst, 20, 6) directly, instead of
adding the shift-based fix first and converting it in the cleanup patch.

I'll add your Suggested-by tag there too.

Thanks,
TianCheng
>
>>   
>>   static uint32_t operand_imm2(rv_inst inst)
>>   {
>> -    return (inst << 37) >> 62;
>> +    return extract32(inst, 25, 2);
>>   }
>>   
>>   static uint32_t operand_immh(rv_inst inst)
>>   {
>> -    return (inst << 32) >> 58;
>> +    return extract32(inst, 26, 6);
>>   }
>>   
>>   static uint32_t operand_imml(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 58;
>> +    return extract32(inst, 20, 6);
>>   }
>>   
>>   static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t spimm)
>> @@ -4585,12 +4585,12 @@ static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
>>   
>>   static uint32_t operand_tbl_index(rv_inst inst)
>>   {
>> -    return ((inst << 54) >> 56);
>> +    return extract32(inst, 2, 8);
>>   }
>>   
>>   static uint32_t operand_lpl(rv_inst inst)
>>   {
>> -    return inst >> 12;
>> +    return extract32(inst, 12, 20);
>>   }
>>   
>>   /* decode operands */

