Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD1C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7sZ-0007Yz-UK; Tue, 25 Jun 2024 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sM7sY-0007Yj-Tv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:14:42 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sM7sW-00082z-Sn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:14:42 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so2282261b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719328479; x=1719933279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v8CQodUEsJ8wrSh+aicDqfHJszLhKGqWXGJGC/q4lmA=;
 b=UGCcCw19t70KqwXlZIxIbFMfZr7DWbjDka+2ncav3w9F9aUEWC04SlfZRe1q8Z6Qq6
 HbdAv7D6d5eXXd8S/gJQ39LZD7q7Lsr7bm26g4hQ2y5Zg1TA/vq0a67KNaaYY1SWPWfy
 jc4sqT5xR8hRpvVlNWCkToXWYsFvYf1o1ILCZMbPAboAedQ53vDeNc+9MHAOVm2Udzs2
 jaKk4sONNQzFa8Z7Eq/1oyD97qjIgdkl3y59u89G1WVFLFoYCoiW7uBJa0B2VzWfDqoP
 Z4vbKP2zIUtBzJVNaU4lz5bHla8+y8llRNMiBu1xpETVlsni26oSE2oj/LshfpYo4rVw
 epAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328479; x=1719933279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8CQodUEsJ8wrSh+aicDqfHJszLhKGqWXGJGC/q4lmA=;
 b=n+Cr6eQpm6KRNWGkf1OZnntanEXEllM/yBvu3S/2OqzcDGywyWzmfW49oEPNRVBWrd
 6soYrp78cgGRWA8qHbB4FKwD6brl2KpR7Gt8tj9ZVrQO2G9bIvSpdoamWuDGW7Aqj+LS
 DNbgORB1SKee8qNr9jYGrEJ3ZXbQPuETif/YVhqpBnuTziDTutMQLLIV1BTOVA97yEdO
 enlwTnj3tS3VemtZrw6YKhfPVHjs9/4KrLyitdHKuWTS6WXeg2gCvk8jP57nIPMrsGuS
 D58W+npzQVFzZ0FlMbCBTR0dOzapvuYhknyXmeoa6/6ceR05fQ4eKM3zXKSMR3otAsTc
 nEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMjhEPQDa+uL8DCH1XWQ7QfRRm6r20AqqAWDgz1ebrMRHDFkc107naNpJaLuorTEHpbnEzVlx4R3M5+KjZDLFLWm3cu1Q=
X-Gm-Message-State: AOJu0YyAiEnJMfU2bUewyeiJsT2bg79Vr7B819wTBeC3b5+bHOhmFvVw
 dyUXBJUgcQWdrMhe64X0LUvyyH1jCSKVdJTo25EGiY2VTp2+sA2rQKUiantV+WM=
X-Google-Smtp-Source: AGHT+IGt8yp2Zq43FZu650IJBlb24eslDkyrMT5/8zRgxuIwrlwRIgGU9KeaUtESBbtW2c+YkpndBA==
X-Received: by 2002:a05:6a21:7899:b0:1b7:77ef:b121 with SMTP id
 adf61e73a8af0-1bcf4446ef4mr8912021637.13.1719328477979; 
 Tue, 25 Jun 2024 08:14:37 -0700 (PDT)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb320b33sm82759735ad.83.2024.06.25.08.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 08:14:37 -0700 (PDT)
Message-ID: <6e7ca292-3c96-4aa4-ab74-2f9328033aa4@sifive.com>
Date: Tue, 25 Jun 2024 23:14:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-3-max.chou@sifive.com>
 <4d7d0813-2ba3-416e-9bb9-3f0ef00818f1@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <4d7d0813-2ba3-416e-9bb9-3f0ef00818f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/6/20 12:29 PM, Richard Henderson wrote:

> On 6/13/24 10:51, Max Chou wrote:
>> This commit references the sve_ldN_r/sve_stN_r helper functions in ARM
>> target to optimize the vector unmasked unit-stride load/store
>> instructions by following items:
>>
>> * Get the loose bound of activate elements
>> * Probing pages/resolving host memory address/handling watchpoint at 
>> beginning
>> * Provide new interface to direct access host memory
>>
>> The original element load/store interface is replaced by the new element
>> load/store functions with _tlb & _host postfix that means doing the
>> element load/store through the original softmmu flow and the direct
>> access host memory flow.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc |   3 +
>>   target/riscv/vector_helper.c            | 637 +++++++++++++++++++-----
>>   target/riscv/vector_internals.h         |  48 ++
>>   3 files changed, 551 insertions(+), 137 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc 
>> b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 3a3896ba06c..14e10568bd7 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, 
>> arg_vlm_v *a, uint8_t eew)
>>       /* Mask destination register are always tail-agnostic */
>>       data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
>>       data = FIELD_DP32(data, VDATA, VMA, s->vma);
>> +    data = FIELD_DP32(data, VDATA, VM, 1);
>>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
>>   }
>>   @@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, 
>> arg_vsm_v *a, uint8_t eew)
>>       /* EMUL = 1, NFIELDS = 1 */
>>       data = FIELD_DP32(data, VDATA, LMUL, 0);
>>       data = FIELD_DP32(data, VDATA, NF, 1);
>> +    data = FIELD_DP32(data, VDATA, VM, 1);
>>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
>>   }
>>   @@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, 
>> uint32_t rs1, uint32_t nf,
>>       TCGv_i32 desc;
>>         uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
>> +    data = FIELD_DP32(data, VDATA, VM, 1);
>>       dest = tcg_temp_new_ptr();
>>       desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>>                                         s->cfg_ptr->vlenb, data));
>
> This is ok, and would warrant a separate patch.
Ok, I'll split this part to a separate patch at next version.
Thanks.

>
>
>> +    if (vm == 0) {
>> +        for (i = vstart; i < evl; ++i) {
>> +            if (vext_elem_mask(v0, i)) {
>> +                reg_idx_last = i;
>> +                if (reg_idx_first < 0) {
>> +                    reg_idx_first = i;
>> +                }
>> +            }
>> +        }
>
> This isn't great, and isn't used for now, since only unmasked 
> unit-stride is handled so far.  I think this first patch should be 
> simpler and *assume* VM is set.
Indeed. I'll remove this part at next version.
I agree that this first patch should be simpler and assume VM is set.
Thank you for the suggestion.

>
>> +/*
>> + * Resolve the guest virtual addresses to info->page[].
>> + * Control the generation of page faults with @fault.  Return false if
>> + * there is no work to do, which can only happen with @fault == 
>> FAULT_NO.
>> + */
>> +static bool vext_cont_ldst_pages(CPURISCVState *env, RVVContLdSt *info,
>> +                                 target_ulong addr, bool is_load,
>> +                                 uint32_t desc, uint32_t esz, 
>> uintptr_t ra,
>> +                                 bool is_us_whole)
>> +{
>> +    uint32_t vm = vext_vm(desc);
>> +    uint32_t nf = vext_nf(desc);
>> +    bool nofault = (vm == 1 ? false : true);
>
> Why is nofault == "!vm"?
>
> Also, it's silly to use ?: with true/false -- use the proper boolean 
> expression in the first place.
>
> That said... faults with RVV must interact with vstart.
>
> I'm not sure what the best code organization is.
>
> Perhaps a subroutine, passed the first and last elements for a single 
> page.
>
>   Update vstart, resolve the page, allowing the exception.
>   If watchpoints, one call to cpu_check_watchpoint for the entire 
> memory range.
>   If ram, iterate through the rest of the page using host accesses; 
> otherwise,
>   iterate through the rest of the page using tlb accesses, making sure 
> vstart
>   is always up-to-date.
>
> The main routine looks for the page_split, invokes the subroutine for 
> the first (and likely only) page.  Special case any split-page 
> element.  Invoke the subroutine for the second page.
>
>
> r~
According to the v spec, the vector unit-stride and constant-stride 
memory accesses do not guarantee ordering between individual element 
accesses.
So it may affects how we handle the precise vector traps here.
I'll replace the nofault part and try to update the subroutine flow with 
the suggestion and think about how to update vstart here.
Thanks you for the suggestions.

