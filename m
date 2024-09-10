Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4542AECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuvo-0005Xe-QU; Tue, 10 Sep 2024 03:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snuvb-0005WV-Gl; Tue, 10 Sep 2024 03:04:47 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snuvY-0008Aw-HK; Tue, 10 Sep 2024 03:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725951871; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=OqSkdS3ZE9eoXelpW7ViWQJZpRMVIVU56JbZWyHRoq0=;
 b=Cf6hCkuVLxbbbimcHPmc6zvYbOta3n+AUsZNQ0z0SWkt8lB83QDoTt6Q12joktaR2RCk3cP6v5ybBA45ukI4Kcl8PzabT/9OXtE/Y4xzym+vvfdbVaCj3alHeVCf+qG4G23uCelrl9PwXvemrmANiZn1/mYLfngNm9kBFSPL/Y4=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEjLopo_1725951870) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 15:04:30 +0800
Message-ID: <e83dc952-d25d-4944-8c07-e55a68a969cb@linux.alibaba.com>
Date: Tue, 10 Sep 2024 15:03:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] tcg/riscv: Add riscv vset{i}vli support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-5-zhiwei_liu@linux.alibaba.com>
 <efa2bcd4-3ed6-4943-8dee-f764ee5afe87@linaro.org>
 <ca6c39e0-0b29-4dff-9e89-93db342ae9af@linux.alibaba.com>
 <04500d38-0869-4e02-8281-d1f577fcb000@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <04500d38-0869-4e02-8281-d1f577fcb000@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2024/9/10 12:34, Richard Henderson wrote:
> On 9/9/24 19:46, LIU Zhiwei wrote:
>>>     lmul = type - riscv_lg2_vlenb;
>>>     if (lmul < -3) {
>>>         /* Host VLEN >= 1024 bits. */
>>>         vlmul = VLMUL_M1;
>> I am not sure if we should use VLMUL_MF8,
>
> Perhaps.  See below.
>
>>>     } else if (lmul < 3) {
>>>         /* 1/8 ... 1 ... 8 */
>>>         vlmul = lmul & 7;
>>>         lmul_eq_avl = true;
>>>     } else {
>>>         /* Guaranteed by Zve64x. */
>>>         g_assert_not_reached();
>>>     }
>>>
>>>     avl = tcg_type_size(type) >> vsew;
>>>     vtype = encode_vtype(true, true, vsew, vlmul);
>>>
>>>     if (avl < 32) {
>>>         insn = encode_i(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
>> Which may benifit here? we usually use  lmul as smallest as we can 
>> for macro ops split.
>
> lmul is unchanged, just explicitly setting AVL as well.
> The "benefit" is that AVL is visible in the disassembly,
> and that we are able to discard the result.
>
> There doesn't appear to be a down side.  Is there one?
>
>>>     } else if (lmul_eq_avl) {
>>>         /* rd != 0 and rs1 == 0 uses vlmax */
>>>         insn = encode_i(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, 
>>> vtype);
>
> As opposed to here, where we must clobber a register.
> It is a scratch reg, sure, and probably affects nothing
> in any microarch which does register renaming.
>
>>>     } else {
>>>         tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
>>>         insn = encode_i(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, 
>>> vtype);
>> And perhaps here.
>
> Here, lmul does *not* equal avl, and so we must set it, and because of 
> non-use of VSETIVLI we also know that it does not fit in uimm5.
>
> But here's a follow-up question regarding current micro-architectures:
>
>   How much benefit is there from adjusting LMUL < 1, or AVL < VLMAX?

It may reduce some macro ops for LMUL < 1 than LMUL = 1. For example, on 
host with 128-bit vector,

1) LMUL = 1/2, only one macro ops.

vsetivli x0, 8, e32, mf2
vadd.v.v  x2, x4, x5


2) LMUL = 1, two macro ops.

vsetivli x0, 8, e32, m1
vadd.v.v x2, x4, x5

>
> For instance, on other hosts with 128-bit vectors, we also promise 
> support for 64-bit registers, just so we can support guests which have 
> 64-bit vector operations.  In existing hosts (x86, ppc, s390x, 
> loongarch) we accept that the host instruction will operate on all 
> 128-bits; we simply ignore half of any result.
>
> Thus the question becomes: can we minimize the number of vset* 
> instructions by bounding minimal lmul to 1 (or whatever) and always 
> leaving avl as the full register? 

I think the question we are talking about is when TCG_TYPE_V* is smaller 
than vlen, should we use fraction lmul?

1) Fraction lmul leads to less macro ops. (Depend on micro-architectures).

2) LMUL = 1 leads to less vset*.

I like to use the 1), because vset*vli we are using can be fusion-ed 
probably.

Thanks,
Zhiwei

> If so, the only vset* changes are for SEW changes, or for load/store 
> that are smaller than V*1REG64.
>
>
> r~

