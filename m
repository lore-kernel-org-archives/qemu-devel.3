Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD7C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVOM-00086F-Ng; Wed, 26 Mar 2025 14:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txVOK-000862-FV
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:22:16 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txVOI-0002Fj-5l
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:22:15 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so64379fac.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743013331; x=1743618131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AcXJ7fq0Dl3Kd4BIHX1PKV/gHpCOgUzmQq36/CNy9eM=;
 b=tUOGb7VjgYCQRLY9UkRj0McZ5rKf4yk8YjL0/LBovBozZiMv7FUOq/kLnAmeM8Vceq
 I3OmE6YUre8qsWNNxgR32i89l6HB0hoaKlshS5eTcsa85SX1fkqO7ZThpQcN7EV3l1yg
 iZpdJ7YWOgWI7WSVylbzCvQ0fL40fsDz+EGtDTsM7G8Zraq9Mb3ytmjhDSyvt/KNIsoK
 Xb95bY2G9OWspkHXlEMAFHkxRrDdHD3iAlUo9qrFTbzQu7PUDHWCdaPkzLJMO1lngR0y
 APjsiNBlSpYp2K8Kq9C2+Ix71eCGeUlbrwILhVaVzrRUcIaTz4DLTG/eXMvdWAD8s79R
 1P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743013331; x=1743618131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcXJ7fq0Dl3Kd4BIHX1PKV/gHpCOgUzmQq36/CNy9eM=;
 b=GoKUNKhYi09TR6hOz4F+0Qq3GkHw//iUC73FOhh6K9lT1mVsGnqTflXpxjVrhlNRsD
 w0GTPi/C+G6jGU8gxerh1DLi7IAN+apM16oOhqhFyDbgCTSaIlt85SXzJWKsaahkBuRi
 Mrh/TArkVxmXwiifCkJbrbH3v6sph1i+3umD/B09uBzCba4QMDruRgCTwnRWkFe1PNnZ
 LY3Nn+LKwWGv3J0mjR4/KuzVEbZnVanRHcadSyZrWyIoAvNwmiKpG7T6eeFVNTgx4uwm
 J+xYHOJ6t3uapJHnAAs5ZNnq47VDay3YHd7pdoIyxzPdda8QgISfm+JYbOwc+UJVHnj3
 duYQ==
X-Gm-Message-State: AOJu0YxV+ddoPgOQbVhCDZ0PxmLp1bZ5ZPBI5WoMW5wvECEEIqWa5ydY
 V2b4svln6FwArnU7ACOOQHC5/2Na/8sfYWVEoqWxFJQFfR7gEbjJabesln+y5/ByF/mwBziaSf0
 u
X-Gm-Gg: ASbGncskp1VWmCY4QQy0w3OQSOMCdPXLFvR5UHLQhqfHnxQhm1DCDVdYHYUMwWG/avk
 hvYYanULFDdOPgVIc7P0ktxDebjj4hOYdsSiwlwo+LeUOYMI745ejh3wZ5BK7kS1RSE9VvrirOC
 QICDmTjKKqkVqiZIghGgS8e/v5FfcPTHG5nIX5RiMnohMYiCezK/KRXyBs8DxkVlI/R5aCFvljJ
 g7cUIB49bA3Fn0BC6xMHYfMuJ38SAfJkYsxInpN7I2h/rTbeBw8JrfesjOXeDiCY5BPSwMpZ3p6
 Gr7Alt4pwe+ysaPF3Keah3Wz/b9ONZXEyUw92u70HMcLoXwNo5rORz28aMgXPG96Yz2w1o/lCwd
 Et4eVFwboCq+axV0nrPDKcA==
X-Google-Smtp-Source: AGHT+IHLeECy/7I6UrgP/XYltmIuHqhewYPhqASI+In8S29HxkhHT1/jJRJ2SdS5NbhztNj69fww3Q==
X-Received: by 2002:a05:6870:b51f:b0:2c2:cd87:7521 with SMTP id
 586e51a60fabf-2c847eebf26mr308009fac.4.1743013330674; 
 Wed, 26 Mar 2025 11:22:10 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77f05d2dbsm3178876fac.39.2025.03.26.11.22.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 11:22:10 -0700 (PDT)
Message-ID: <1ba52ba5-6d68-483b-88ef-727fd369e4c0@linaro.org>
Date: Wed, 26 Mar 2025 13:22:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 6/8] target/mips: Introduce mips_cpu_is_64bit()
 helper
To: qemu-devel@nongnu.org
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325154058.92735-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 3/25/25 10:40, Philippe Mathieu-Daudé wrote:
> mips_cpu_is_64bit() returns whether the CPU is a
> 32-bit or a 64-bit one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu-qom.h | 2 ++
>   target/mips/cpu.c     | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index 9acf647420c..52996e7c354 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -33,4 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
>   
> +bool mips_cpu_is_64bit(MIPSCPU *cpu);
> +
>   #endif
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index d8930468b7d..05b3ce42af5 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -516,6 +516,12 @@ static void mips_cpu_initfn(Object *obj)
>   #endif
>   }
>   
> +bool mips_cpu_is_64bit(MIPSCPU *cpu)
> +{
> +    return !!object_class_dynamic_cast(OBJECT_CLASS(CPU(cpu)->cc),
> +                                       TYPE_MIPS64_CPU);
> +}

This is very nearly object_dynamic_cast.  So why not just

   return object_dynamic_cast(OBJECT(cpu), TYPE_MIPS64_CPU);

?


r~

