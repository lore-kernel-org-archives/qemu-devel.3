Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE11BD277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLUx-0004bV-OQ; Fri, 09 Jan 2026 18:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLUt-0004aa-Rs
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:02:24 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLUq-0002y2-G3
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:02:23 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81f223c70d8so360368b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767999733; x=1768604533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQ/F4tx06UNR9u6NyOK0BRYoNhAsTPiYga+nPVyIwAI=;
 b=U1remKz6XmIdA5utvAp/pzISzDBUqKqMnzFwG+1tKAPB5vLZEYcoYsRbiJnp2gcBig
 SAEQsDyEDGZp0zfPcvXB7dO7vdeN6V9aTBaZLMFsE4YmHc2izrIbpVPcF3GFfbzzk+hR
 Ri3nCns6IaMG7TiETwh0f5spOqvDcBaBJ+w5khgrB31EuM+biUsFdEozQhe8RiM1b09Q
 33est3uOPXwj2ixS2mWGRF2lm3BWN2C+6R+DfW6SxFLLktf/fjDpFQ7Y8JX8QbrOso9W
 r4Hh1J0zJbvujnFXS0ZzmnYp4AhOFUe1uvbUzCJZ1f5+1gHAxg0BacaKbDCSlE/W7Cne
 RS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767999733; x=1768604533;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OQ/F4tx06UNR9u6NyOK0BRYoNhAsTPiYga+nPVyIwAI=;
 b=Lea505h5Mi6no01l6uKz07xZMB629P1OID4aod9psgOpNo1z5d8oSqUV4E7ZoGpH6B
 rnE+0rAIcDxCp08DIQezotdSqME5S+YqPIAoqDm50vOd9gkSzAyAu1ZUcTYMffx6CDRT
 vX7T5ZxopdH8waHQ40dUiyLoJLpgJNmMNlWpbzQuxd2PGZPEkjrEZz5/4fsKHTPH3IQ1
 Eo/nIaRgxYQXs9A3u/vmZFFgz9kkuGzziSdppX0T/Kn1KxSYGBIWStQ5nCm6tsjtnqSm
 j0eYGSqQHuJN/RwEX6KtZLgRM1KUhILBU+lNmEN2o8veAzn1QKtvEQX9tEm2O64Yw1+G
 UoSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJwcN9rHqZV9wlkIIrXK7FukQuRH0NZnkVnBUPyguirHvi45rdQC+YYoGd4nr91YzQOj0LzRxYaLMm@nongnu.org
X-Gm-Message-State: AOJu0YwSvZKAbsgoIfsm3pqk/Z5yfI6gWdU+CPoVF+5vCH0v5axoUbys
 0FI9jyGZJLcyhgKJZ1YBjNAB++MMWIAhtify7gC22FX6/IrtwQfqT0atbVKvGeiumsY=
X-Gm-Gg: AY/fxX7rptkCFzsl//6M7KfjGDiPJ9uwxEiz0uVcFy16t8DnaS9Lg+zS9Iy24iXD/nf
 ZrCHgfyKBc86ueN6WfZFZWcDtZwFyFKRyFZ7AcUuDwEVMEJaUt4xruvk3YCwCoBqLFZp8K8AIVV
 ik9rWw12Gw2U2yMs06zq+H2oIeQS4hCo3w1u45ZmoKZwbcJaoEyO8i7gBhos6KT48ddvqDoMg1N
 0+blb6NNsrqdi8WSLu1ZPE9AtgOPObIGu7OjD+QmoUXkaM9yiaCbGBkVTeLGSolj/GIhINxWOSG
 vSfLUQVslGuBmS8YoPM7usfP/GIUQoeKycM3zrYBBvKZI75lEIuxXN+Yz0yVoORBjJ6gzpb3NjQ
 XlrWYt8IkLLcU1Y9VqCDVThHDDn8YhEW/y8UOaU6ZVM7RhQX0nAdMH6IK/Xv9z8wPhyVHwAdvBY
 uva4Ha28EIuFRFg3SrAV1ciiI/wg==
X-Google-Smtp-Source: AGHT+IFzfLQ3EJc77CB6eRJUPuVv3jHPgqfS84XjO1kPGkN7DZbPl8Ttiyh066A/1zTgjsmzHAVLYQ==
X-Received: by 2002:a05:6a00:1d85:b0:81f:3461:9f78 with SMTP id
 d2e1a72fcca58-81f3461a204mr1070837b3a.48.1767999732829; 
 Fri, 09 Jan 2026 15:02:12 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f39a3f676sm445263b3a.14.2026.01.09.15.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:02:12 -0800 (PST)
Message-ID: <5e0960d8-27c4-473b-8d12-9e1fbde3bf12@linaro.org>
Date: Sat, 10 Jan 2026 10:02:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/29] target/arm/tcg/translate.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-30-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-30-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> We can finally make translate.c common.
> 
> This is the only file using TCGv as well, so we need to set .tcgv_type
> in arm_get_tb_cpu_state() accordingly, to not break bisection with this
> series. Indeed, we will now have a different TCGv type at runtime when
> calling gen_aa32_*_internal_*() compared to before for aarch64 targets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/hflags.c    | 1 +
>   target/arm/tcg/translate.c | 1 +
>   target/arm/tcg/meson.build | 7 ++++++-
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 5c9b9bec3b2..2b06b75b581 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -693,5 +693,6 @@ TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs)
>           .pc = pc,
>           .flags = flags.flags,
>           .cs_base = flags.flags2,
> +        .tcgv_type = is_a64(env) ? TCGV_TYPE_I64 : TCGV_TYPE_I32
>       };
>   }

Except this,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 3cd05682ce8..1bd763025e8 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -20,6 +20,7 @@
>    */
>   #include "qemu/osdep.h"
>   
> +#define TARGET_ADDRESS_BITS 32
>   #include "translate.h"
>   #include "translate-a32.h"
>   #include "qemu/log.h"
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index a2a636ef14a..9d50f8b5001 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -25,7 +25,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
>   
>   arm_ss.add(files(
>     'cpu32.c',
> -  'translate.c',
>     'm_helper.c',
>     'mve_helper.c',
>   ))
> @@ -55,6 +54,10 @@ arm_common_ss.add(files(
>   ))
>   
>   arm_common_system_ss.add(
> +  decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
> +  decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
> +  decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
> +  decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
>     decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
>     decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
>     decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
> @@ -71,6 +74,7 @@ arm_common_system_ss.add(
>     'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
> +  'translate.c',
>     'translate-m-nocp.c',
>     'translate-mve.c',
>     'translate-neon.c',
> @@ -84,6 +88,7 @@ arm_user_ss.add(files(
>     'neon_helper.c',
>     'op_helper.c',
>     'tlb_helper.c',
> +  'translate.c',
>     'translate-m-nocp.c',
>     'translate-mve.c',
>     'translate-neon.c',


