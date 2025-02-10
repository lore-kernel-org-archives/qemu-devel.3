Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA1C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 23:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thdM1-0000s0-5W; Mon, 10 Feb 2025 18:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thdLz-0000rK-CK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 18:38:15 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thdLx-0001Ha-Hj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 18:38:15 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so7543395a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 15:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739230691; x=1739835491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=StsB3S9Tgh2SGvc+WCIefccd7ZPEsviJiZvgWQBs900=;
 b=d/pCbQSD7CMB9238TU9Gv2nc0RXVpIcZmad2WL8oZClgaS22KFXU65POzPynP6/tCw
 bhNU1kKrVkwkCGD2ty/JIjsug4sX5jzGNqa0nscXR3mho9MAvjLSf/A+21mkfdDn2BDo
 LxgjUkRyN+zh5u7vv2JlU2Tfl05v46TOp7pdl5t/TckxYjBQ4+Upc7BwlQ1ulYck9Jqo
 CrS4BzjAC4wPwlLiDyw1tqBSX2Nllr+qqtbpcAAhXMA4XmHhYpFm8QSq/wjUsRyGFfXM
 eoz9xjXfiMQLsNKPblB/BHlotyDTiBAJg2y5WPClJYeiyqj/Mv6wps/7FYEv0hT7Hgf9
 nNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739230691; x=1739835491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=StsB3S9Tgh2SGvc+WCIefccd7ZPEsviJiZvgWQBs900=;
 b=HWGHjLtFEVWO+mVwoP0YlmUxwZBE+mTr2IplaKJMe1bh4nVDgawlYNYsU45x7CO4Xi
 LUrbapdD6fWB0yQKEDeIu6BpwYPHkKjJNp5KBRdokOOhok+D+h3NIyevGsqKEE061qSn
 fbPDvnNXFM38slw/iRIMIkOphwKD6/IQ/vSdsohvyQQFK9NlsXJsThGID5/2xi6qkXGP
 fyxQvxrj1EMj8uCI1wUGsdqcGCk2TmbKgCdipGMs9lxax5X0vaaVcWML8wQdsCASbv33
 njkXBHPAqhoNamZTZeEVJkSN9ekZkp5XJtKAapVpv1cfHD72vpuyx4aqcGRwYcHjzSPl
 QIbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBV3YzGfYookXAfxpbDUviC65dWYUMis8dZ0coSAITTESZrjwFs0zfFxph3s4q35kB9PH6k4qGFV/k@nongnu.org
X-Gm-Message-State: AOJu0Yy/qGPI1sGA439AntQrG3D8Hktghn4EqfJyIHwb3hj/AUpvCWel
 chtQ2PRPqYue7Tl4oWGgM6OT75R8Q+VoetMUR66fYxLszkQLOEIl7AYrUEFBVSM=
X-Gm-Gg: ASbGncsxZL8+gtFUntt2E/xMSiPdfWaNXAo1mwQOVPcW2/RH2IYA4qec5dB5M9IcCBU
 8MNfUWWlDF4ytpZoU/fqpBZTL0Jx+jZLoYyeQdMtlvCxzmdim0idY9485gwDALPSX0lkIMXWF3v
 3o6fyz2npk/mtaF39Yofe59THCumH/ojmygE9jC5caB79CVIezNvBgYOD56vCtsQz+bBEJF6zyy
 VePUtC6MRvcdllXUN5D1qqmQLtZV389baJtInnt68DMuVCQaQQgo96c2fDRVbtrQl4zKLXaSoD8
 jbJSnzN8t74QKB1R4RoeJfUWQNd0a8HZ+vq0Wlt7LOn035D4MVA/93w=
X-Google-Smtp-Source: AGHT+IEnUSAWwk5potqIIbIIRe3jOJm3LqeVp/llhlD+f1Ktqx35FPJoIdON6AxEQr5K19+PbhnWGw==
X-Received: by 2002:a05:6a00:1890:b0:730:a40f:e6f1 with SMTP id
 d2e1a72fcca58-730a40febc2mr4597418b3a.21.1739230670806; 
 Mon, 10 Feb 2025 15:37:50 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730882d214fsm3283800b3a.18.2025.02.10.15.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 15:37:50 -0800 (PST)
Message-ID: <81656309-3b6f-45bd-8519-070a366c27cb@linaro.org>
Date: Mon, 10 Feb 2025 15:37:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] target/arm: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-4-philmd@linaro.org>
 <7056fbfc-58eb-4881-a6ee-67b3e608a336@linaro.org>
 <d831600a-9a61-45c1-a535-f75bb64cdff4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d831600a-9a61-45c1-a535-f75bb64cdff4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/10/25 14:59, Philippe Mathieu-Daudé wrote:
> On 10/2/25 23:10, Richard Henderson wrote:
>> On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
>>> Have the CPUClass::disas_set_info() callback set the
>>> disassemble_info::endian field.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/arm/cpu.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 94f1c55622b..68b3a9d3ab0 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1188,7 +1188,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info 
>>> *info)
>>>   {
>>>       ARMCPU *ac = ARM_CPU(cpu);
>>>       CPUARMState *env = &ac->env;
>>> -    bool sctlr_b;
>>> +    bool sctlr_b = arm_sctlr_b(env);
>>>       if (is_a64(env)) {
>>>           info->cap_arch = CS_ARCH_ARM64;
>>> @@ -1215,13 +1215,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info 
>>> *info)
>>>           info->cap_mode = cap_mode;
>>>       }
>>> -    sctlr_b = arm_sctlr_b(env);
>>> +    info->endian = BFD_ENDIAN_LITTLE;
>>>       if (bswap_code(sctlr_b)) {
>>> -#if TARGET_BIG_ENDIAN
>>> -        info->endian = BFD_ENDIAN_LITTLE;
>>> -#else
>>> -        info->endian = BFD_ENDIAN_BIG;
>>> -#endif
>>> +        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>>>       }
>>>       info->flags &= ~INSN_ARM_BE32;
>>>   #ifndef CONFIG_USER_ONLY
>>
>> This is a faithful adjustment to the existing code, so,
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> However:
>>
>> (1) aarch64 code is always little-endian,
>> (2) sctlr_b is always false from armv7 (and thus always false for aarch64)
>> (3) I think the BE32 logic is wrong -- CONFIG_USER_ONLY is irrelevant.
>>      See linux-user/arm/cpu_loop.c, target_cpu_copy_regs.
> 
> What about v7-R [*]? I don't see SCTLR_IE defined as 1<<31 for AArch32,
> only:

BE32 was a really old arm thingy, and I it was removed in armv7 (see arm_sctlr_b).
With BE8 (armv6+), instructions are always little-endian, only data accesses change.

> For the Cortex-r5* we have, SCTLR_IE is always 0 in reset_sctlr.
> 
> Is it OK to consider v7-R implemented as little-endian in QEMU?

Yes.


r~

