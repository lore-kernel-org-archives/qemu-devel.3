Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EA7EA3C22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmBI-0000ce-KM; Thu, 09 Apr 2026 06:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAmBH-0000cE-8t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:00:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAmBF-0006hT-3Q
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:00:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso9305025e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775728807; x=1776333607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNMNL8feFzExP+rnObtMB2KrTgEpYRmiJuWGlbqUIy0=;
 b=zNZU07dJZvVl6lyiDOCyP/dEm6iLfZZe4W/FgcjLuDTIkthrP2PEcbeOHxEntbSkoX
 bazqkQX2drYMvHN3wuic1s8ezmM4l1+Iv7x5C1ZTrsqZ1aYF1haZSUQM9w8fv8gBp8jq
 +i+mx+THeQhtLlWPpwo3ior5Kq3kqej0u7ufF0mqbcm4pd4/hGnUVUJ6NKpFHRDsSJXn
 iduVIwdYVv+9edycciHIHreDqtsI8x2u2eBDJ1KzQSXKHaRausPYeJ6ed7Tn6CG121pc
 /mafu+eshfqU4265FV7KhffGU94MUeUHgXekyDNRmN5n75ITXI4kKt0AaI9Tm9eCWQHn
 obdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728807; x=1776333607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNMNL8feFzExP+rnObtMB2KrTgEpYRmiJuWGlbqUIy0=;
 b=qmKvwKIHQjmwMZc20/Wjt6q4xbGmRsgx26NFL7UWivRz0S8aySs/y21ybYsOTh4Rn/
 XVKpmw3txCCwMn+OmeBy8Tcn9bId6sHbWttXgdw2GWBTtqJvO4t+FV3dyaZXdxcpGcDv
 0dF7D/5kFwXRSLa2nYcsn+C1lrNnoNCmvfi9DQmz1vesLyyMKeoidCeV9wmaGLnvPG5D
 S/6ctEkOI6LUPVg8Vwiewfp2xFyNpWKMgPnNcBovHHuxQ13tUDwdAvk7sBzMWFHzKUk/
 bQ9kUiAB9AdNNO/YdodUIiCXeItmEXsb9nWMw2HHoQB/CUPww4mxhJqkX+f/cyCaRWXl
 8mCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKa1Qnn221mtDBI9MtqPgi9dFQjCVAHJkLPHMh2FH2KqvdY/bfvE0Ozr9uLCo6oavZxd09miS/x9Ig@nongnu.org
X-Gm-Message-State: AOJu0YwF+JpOuhgK0s+BAbnM/AJ9IMUDZqhIP5+AbnP1HmTiFSDE1OPB
 7DkidffOVusgnKvPXmA3lWzZwqp+QIW4xqPtZTAn8JbybEqtZY27E388Ker1AyqWqtg=
X-Gm-Gg: AeBDievvZ8WFJ5Bd+44cr1HK/X/Z6HAqeJqwB1gNxZso/8LxqQ+8yT4TpvfFaPMZIIp
 fWAZFfRq5i3M6gIykYovo1X/7YW7+FvfYtMUMBzHRcrtjIyM2J3dMMKN6QgnyUE75iIiYrjQ86c
 ffUOaK5K6PrvtR0CbJEwLhLFFlzgmChM0DSIsbOJnfiVManVZIo+d1+h3LVhM9v1eVEcJAGY/C1
 RpF1BIdc9tyFAv5wfti4HJm1ufF4QUqwfV3OlJs8Jgge9tarlKC9WRI+TAxbELE7iDcB/W8rjN2
 ua0TZuuT2MJilL6REMK3h0SWmtwIUJBvjGvNhVc8i2flqiTC65roniyBAAVJ86OF9pRgFRiHari
 brS0evIgSBAhLzaFEi5cNDOWsOSdC9Rf7H2O5RWw2XL5ohpKqUAjp0JEyyB7srikhx6nzEi52KZ
 Xg0JOgzFWVMAHIWrmzqT1VleVFtRMAxJKNgBmGp10W2tMjgrEhYdSIBW91SYSiY+GsNQ==
X-Received: by 2002:a05:600c:8710:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-488996b0589mr389272745e9.5.1775728806634; 
 Thu, 09 Apr 2026 03:00:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd151cd7sm28775365e9.5.2026.04.09.03.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 03:00:05 -0700 (PDT)
Message-ID: <bcfbec03-1916-4181-a4ce-5775b39a0a91@linaro.org>
Date: Thu, 9 Apr 2026 12:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
 <09cf72c9-7333-4f1f-bb2a-bc88b668b294@linaro.org>
 <CAKmqyKOP-69j14DiaWUbZSL-_5nytjgsDhXA6tmTVvLBzrxgSQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKOP-69j14DiaWUbZSL-_5nytjgsDhXA6tmTVvLBzrxgSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/4/26 08:21, Alistair Francis wrote:
> On Wed, Apr 8, 2026 at 6:48 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 7/4/26 11:38, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>
>>>> The RISC-V spec states:
>>>>
>>>> "For the purposes of memory protection, a failed SC.W may be treated
>>>> like a store."
>>>>
>>>> So if the comparison in sc.w fails we should still check for alignment
>>>> and do a probe access to check permissions.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
>>>> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
>>>
>>> Typo: "Resoves"
>>>
>>>
>>> Also, IIRC the bug URL that automatically closes Gitlab issues when
>>> merging the patch is on the format:
>>>
>>> "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"
>>>
>>>
>>> Maybe this URL with "work_items" also works, but even with the regular
>>> URL Gitlab fails to autoclose the bug sometimes.  I suggest changing the
>>> "work_items" to "issues" in all those URLs to be safe.
>>
>> FWIW I concur :)
>>
>>>
>>>
>>> That said,
>>>
>>>
>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>>    target/riscv/helper.h                   |  3 +++
>>>>    target/riscv/op_helper.c                | 14 ++++++++++++++
>>>>    target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>>>>    3 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>>> index b785456ee0..af6cfcfc27 100644
>>>> --- a/target/riscv/helper.h
>>>> +++ b/target/riscv/helper.h
>>>> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>>>>    #ifndef CONFIG_USER_ONLY
>>>>    DEF_HELPER_1(ssamoswap_disabled, void, env)
>>>>    #endif
>>>> +
>>>> +/* Zalrsc" SC write probe */
>>>> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>>>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>>> index 6ccc127c30..b569366369 100644
>>>> --- a/target/riscv/op_helper.c
>>>> +++ b/target/riscv/op_helper.c
>>>> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env,
>>>> target_ulong address)
>>>>        /* We don't emulate the cache-hierarchy, so we're done. */
>>>>    }
>>>> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
>>>> +                           target_ulong size)
>>
>> We could directly use uint64_t for @size. Then after the release the
>> @addr argument will be converted to vaddr type [*]. We could do that
>> directly now:
>>
>>
>> DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, vaddr, i64)
>>
>> void helper_sc_probe_write(CPURISCVState *env, vaddr addr,
>>                              uint64_t size)
> 
> That fails for RV32 linux-user
> 
> ../target/riscv/insn_trans/trans_rva.c.inc:97:40: error: passing
> argument 2 of ‘gen_helper_sc_probe_write’ from incompatible pointer
> type [-Wincompatible-po
> inter-types]
>    97 |     gen_helper_sc_probe_write(tcg_env, src1,
>       |                                        ^~~~
>       |                                        |
>       |                                        TCGv {aka struct TCGv_i32_d *}
> In file included from
> /var/mnt/scratch/alistair/software/qemu/include/qemu/osdep.h:53,
>                  from ../target/riscv/translate.c:19:
> /var/mnt/scratch/alistair/software/qemu/include/exec/helper-head.h.inc:128:57:
> note: expected ‘TCGv_i64’ {aka ‘struct TCGv_i64_d *’} but argument is
> of type
> ‘TCGv’ {aka ‘struct TCGv_i32_d *’}
>   128 | #define dh_arg_decl(t, n) glue(TCGv_, dh_alias(t)) glue(arg, n)
>       |                                                         ^
> /var/mnt/scratch/alistair/software/qemu/include/qemu/compiler.h:29:21:
> note: in definition of macro ‘xglue’
>    29 | #define xglue(x, y) x ## y
>       |                     ^
> /var/mnt/scratch/alistair/software/qemu/include/exec/helper-head.h.inc:128:52:
> note: in expansion of macro ‘glue’
>   128 | #define dh_arg_decl(t, n) glue(TCGv_, dh_alias(t)) glue(arg, n)
>       |                                                    ^~~~
> /var/mnt/scratch/alistair/software/qemu/include/exec/helper-gen.h.inc:44:25:
> note: in expansion of macro ‘dh_arg_decl’
>    44 |     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
>       |                         ^~~~~~~~~~~
> ../target/riscv/helper.h:1294:1: note: in expansion of macro
> ‘DEF_HELPER_FLAGS_3’
> 1294 | DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, vaddr, i64)
>       | ^~~~~~~~~~~~~~~~~~
> In file included from
> /var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op-common.h:11,
>                  from
> /var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op.h:11,
>                  from ../target/riscv/translate.c:22:
> /var/mnt/scratch/alistair/software/qemu/include/tcg/tcg.h:202:28:
> note: ‘TCGv_i64’ declared here
>   202 | typedef struct TCGv_i64_d *TCGv_i64;
>       |                            ^~~~~~~~
> /var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op.h:32:18:
> note: ‘TCGv’ declared here
>    32 | typedef TCGv_i32 TCGv;
>       |                  ^~~~
> 
> Am I missing something?

Oh, RISCV needs more work than :( Discard my suggestion then,
thanks for trying it and sorry for the delay.

Regards,

Phil.

