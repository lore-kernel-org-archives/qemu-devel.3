Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB1EDE994
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 02:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snqvx-0005ML-5l; Mon, 09 Sep 2024 22:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqvv-0005GB-K2; Mon, 09 Sep 2024 22:48:47 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1snqvt-0007eE-Ch; Mon, 09 Sep 2024 22:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725936520; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=XEijes8Y0Jsg3d7z3vl7uDnH04h2KGkvypbAmWdJUtI=;
 b=YecvGKWMcDipeagDq90HrhXtw9I5MMPFOTIsLlAbx2wJ9681Q6BhtmLa/Wxjgfsg65BhH0Wpp6j1HmWhgnrm/zu++LMMYYCARC/ndWjWfk7p4PoAjbtTznedN0/veQ5a6UVBbzpWIONUcx0uBVRWg1opE6PCg+EaD3JaIczXb2w=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEic5pe_1725936518) by smtp.aliyun-inc.com;
 Tue, 10 Sep 2024 10:48:39 +0800
Message-ID: <fad67093-e815-48fe-82b4-c9c417796b95@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:47:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-3-zhiwei_liu@linux.alibaba.com>
 <286685da-74e3-401a-afe4-fed0831fd97c@linaro.org>
 <5fc48f87-b233-40b9-a0e1-4de920d97957@linux.alibaba.com>
 <0475550c-53c4-4166-bb04-1ff21f5d11b9@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <0475550c-53c4-4166-bb04-1ff21f5d11b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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


On 2024/9/9 23:45, Richard Henderson wrote:
> On 9/9/24 00:18, LIU Zhiwei wrote:
>>
>> On 2024/9/5 11:34, Richard Henderson wrote:
>>> On 9/4/24 07:27, LIU Zhiwei wrote:
>>>> +    if (info & CPUINFO_ZVE64X) {
>>>> +        /*
>>>> +         * Get vlenb for Vector: vsetvli rd, x0, e64.
>>>> +         * VLMAX = LMUL * VLEN / SEW.
>>>> +         * The "vsetvli rd, x0, e64" means "LMUL = 1, SEW = 64, rd 
>>>> = VLMAX",
>>>> +         * so "vlenb = VLMAX * 64 / 8".
>>>> +         */
>>>> +        unsigned long vlmax = 0;
>>>> +        asm volatile(".insn i 0x57, 7, %0, zero, (3 << 3)" : 
>>>> "=r"(vlmax));
>>>> +        if (vlmax) {
>>>> +            riscv_vlenb = vlmax * 8;
>>>> +            assert(riscv_vlen >= 64 && !(riscv_vlen & (riscv_vlen 
>>>> - 1)));
>>>> +        } else {
>>>> +            info &= ~CPUINFO_ZVE64X;
>>>> +        }
>>>> +    }
>>>
>>> Surely this does not compile, since the riscv_vlen referenced in the 
>>> assert does not exist.
>> riscv_vlen is macro about riscv_vlenb. I think you miss it.
>
> I did miss the macro.  But there's also no need for it to exist.
>
>>>
>>> That said, I've done some experimentation and I believe there is a 
>>> further simplification to be had in instead saving log2(vlenb).
>>>
>>>     if (info & CPUINFO_ZVE64X) {
>>>         /*
>>>          * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
>>>          * We are guaranteed by Zve64x that VLEN >= 64, and that
>>>          * EEW of {8,16,32,64} are supported.
>>>          *
>>>          * Cache VLEN in a convenient form.
>>>          */
>>>         unsigned long vlenb;
>>>         asm("csrr %0, vlenb" : "=r"(vlenb));
>>
>> Should we use the .insn format here? Maybe we are having a compiler 
>> doesn't support vector.
>
> Neither gcc nor clang requires V be enabled at compile time in order 
> to access the CSR.
> It does seem like a mistake, but I'm happy to use it.

Can we follow you here? 🙂

Zhiwei

>
>
> r~

