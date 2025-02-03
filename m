Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB743C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0Ce-0006Cs-DA; Mon, 03 Feb 2025 12:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf0Ca-00069k-Bk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:25:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf0CY-0004mh-BK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:25:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso32256315e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738603536; x=1739208336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f1qk/YkLRT02+ON310wkt9KYiBH+73GAyu2gfxVI1lU=;
 b=GI8VmyXKFnW61G/ZHTiJiy4G5XkEpWtuMmE/f659FHYrDk3nq1IOlZ2a8QtxDyK6wt
 0czY6EVp18egkIuw7d20VRwXcKF/bOIBEEE/VcfLPKQaM29RF4+2oaIxJBvstBNNXvSB
 f9PK87DrKWq23ENAe43qpRJAs4rLK8Id9ABclz0V99EH2BsxCtCJOovwLONNRSGEaMq9
 hK1z5u3aLmKrpM+iYary2XiqKFqm79Ep9sgeJAexuQZsGtAYEgPKIQDoYaY2i8ZAsHQW
 XC/34DuGmhIySmtFF1jwTJ4pHIhjQtQ/kW4E9IfncegSfOCh/Rg3762TroAQElciqmgi
 eENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738603536; x=1739208336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1qk/YkLRT02+ON310wkt9KYiBH+73GAyu2gfxVI1lU=;
 b=VEKDDLhu9h/qm3asKrFq9h3p/kUgjc8sZDsOX7V8uwl9O8NprfYU/3SJ1CMEhdT+5y
 x4M6WAHOLiP/NdjW/rudWdPkXeQY8ng2h1lK5+f82RHEkcpKDzSfwSfiEd0oo2JAuF6Q
 vJKuksTwZveoMq6SK2o72r+aeRO2foc6v1MbZdFLSyeWpoFzyH0KFpwnwLmtSnnEQAWJ
 Tw6uB2VurTQp0Bxv12UBLK1vjALgdpkAq93hUWk+RkU+lHs5DtLbAuxf31IMJBQ2xnFl
 yevH7vuXB6Uabj7smxymXVoc0KbWNqFBlsJ7iYnXi/fHlYREITykoJz8t4TjdRGm905C
 ZxNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNZfnShq2J2HNcZIPnbdr6A1qDfvk11jeNQrvojXlABdxiu90tbZZ8y77D+O7EREEcPr/pmX3hADG@nongnu.org
X-Gm-Message-State: AOJu0YwcIJtRtP0ZEMgPNi8qPuAfk7H3IjIN/gykfRrd2LZsUImh8YEx
 8WBU0o0afat0tayDUc62WqCPfUr2YjWUmYQZRjl5zVp8iQULtG0d+7vxjo634oQ=
X-Gm-Gg: ASbGnctNCmNSeHxPB9u1+9X3WSRW5URzU/gYjB7Z4a/tc8XE90rvnm/iaT9sNWgPC75
 hp0Vr2uLMYUo8O3EXDdwtKhlZRbdk/iBQ24IE1Uay+YCVj8oewBqq/UbvhFaBW4wqng3GZaHifY
 9h3es6s5NOVLaBpqXEMwnG8+ptIbg92wYxbGlwUVPRHwlbxlbALVWoptJsJYFcHUyB+Rc37pvR6
 G9lLq7PWPwgsGBK4bUNO3Mg/lDR+p3qfN3O2HkOeG711qCXc+NH0AunNBXJcaa/fFT4alexqP5I
 DwLAypxu6g4TcDzme52ce1UQKeWLr3Ys9lmAByxg8hx5j7nov/IE1ATC5U8=
X-Google-Smtp-Source: AGHT+IEbn+17I6jMeyAyMSX+ojfNGIbof4KeE5G9t45nCYDyrM4EAdbEhRSUfeuwaXXWaeymu4r5pw==
X-Received: by 2002:a05:6000:1865:b0:386:1cf9:b993 with SMTP id
 ffacd0b85a97d-38c51974311mr17895726f8f.26.1738603536050; 
 Mon, 03 Feb 2025 09:25:36 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm163778835e9.27.2025.02.03.09.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:25:35 -0800 (PST)
Message-ID: <f5f62fd7-0d42-4f0c-b8bf-cbcdd9dc54ab@linaro.org>
Date: Mon, 3 Feb 2025 18:25:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/mips: Protect objects with CONFIG_TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203031821.741477-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Richard,

On 3/2/25 04:18, Richard Henderson wrote:
> Hack around mips32 host allowing kvm acceleration
> of mips64 guest, but tcg is disabled.

We have in target/mips/meson.build:

if 'CONFIG_TCG' in config_all_accel
   subdir('tcg')
endif

What is the problem you are trying to address here?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/meson.build        | 4 ++--
>   target/mips/tcg/system/meson.build | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
> index fff9cd6c7f..e5574f177b 100644
> --- a/target/mips/tcg/meson.build
> +++ b/target/mips/tcg/meson.build
> @@ -10,7 +10,7 @@ gen = [
>   ]
>   
>   mips_ss.add(gen)
> -mips_ss.add(files(
> +mips_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'dsp_helper.c',
>     'exception.c',
>     'fpu_helper.c',
> @@ -26,7 +26,7 @@ mips_ss.add(files(
>     'vr54xx_helper.c',
>     'vr54xx_translate.c',
>   ))
> -mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
> +mips_ss.add(when: ['CONFIG_TCG', 'TARGET_MIPS64'], if_true: files(
>     'tx79_translate.c',
>     'octeon_translate.c',
>     'lcsr_translate.c',
> diff --git a/target/mips/tcg/system/meson.build b/target/mips/tcg/system/meson.build
> index 911341ac37..606ccacebc 100644
> --- a/target/mips/tcg/system/meson.build
> +++ b/target/mips/tcg/system/meson.build
> @@ -1,12 +1,12 @@
> -mips_system_ss.add(files(
> +mips_system_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'cp0_helper.c',
>     'special_helper.c',
>     'tlb_helper.c',
>   ))
> -mips_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
> +mips_system_ss.add(when: ['CONFIG_TCG', 'CONFIG_SEMIHOSTING'],
>     if_true: files('mips-semi.c'),
>     if_false: files('semihosting-stub.c')
>   )
> -mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
> +mips_system_ss.add(when: ['CONFIG_TCG', 'TARGET_MIPS64'], if_true: files(
>     'lcsr_helper.c',
>   ))


