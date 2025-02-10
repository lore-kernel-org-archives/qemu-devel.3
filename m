Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956CEC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc1j-0003Ab-JH; Mon, 10 Feb 2025 17:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1b-0002XU-Sh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:13:08 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1Z-0001P5-0W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:13:07 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa4493a695so3669059a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225583; x=1739830383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QYvuY9brvW/86UeuXvq6ZyHgttSJJxXK/2vTLDgyMtY=;
 b=eU9q4Cn6EJQSRGjfM2+mk7zrIZej2xoCKUXOvIqx7kCuw0vE9mCr0NAsc/vEBTmCY/
 xKW8UPAVn04bpVYNNX3us3aPbP7pJNLdqwR61cGnBWJ6hCIn9+EwtFhG4iF5OR/TjHbk
 mR2BTMetLX9NHFK55rB7G8cm86DyfMsFPnyIhUDyTXmBu69sf+bkgHTW9OD6h5X13Ieq
 EoU9mhTgGSMsAnLMCH15gcu8LQE4qoEW2vIrwmH0yBm3L+6jNAuSfyLFbeVbeCvKRPq8
 TZu5OptJeeNlIbYFNIvN1CNIGhYCiRP4eItG4XDTmiO+Tky6raySIKuEFNqvydPKZAuS
 SDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225583; x=1739830383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYvuY9brvW/86UeuXvq6ZyHgttSJJxXK/2vTLDgyMtY=;
 b=ctgooDohkRLsR8U7uyfn7taSUFyb28UuMdASisGM3E1+7uOWhLepE9dkGaBBdjQPMS
 VO9cOttfdtfThHJ8nM7BqNl1l3a6IVLxSsDoYh7uTiG1GFBmlnrpPnQ0dgHBxNyQBkWR
 bu7TMp489SWaEo0WY2CezT/P5lwd85ZSBQG5kf7V1RlZzcYMdd/z0pg5c/OvM4gT2rwq
 PwvYqOpejceKwM4CV0qF6fwCSlf3YNUlTW8IwG2GvDW4GcT6+1CSbBS93wGTOu2OFHmi
 yMIUgVVVBY45SjY574X1XZc4LSZiFvIVTpCXfMzVby/+ZGop/VjsFoMgAjLG+H+7cjza
 pPEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEISCynrhKD63Dnn98DeLZ1M8AZN/U0TdjEMu/x9XbDkTFPdZDt8ER09HdmNJsbB9vhrtpdB5b7VJc@nongnu.org
X-Gm-Message-State: AOJu0YzC2Yoch/Donc8ShEXZ/thiQ8bYX879/2cjFDOo/W/WsLV7cdJn
 pvZHrDPTkKLGMl5gsR+uzSDtoiz2mRizxrrJUA9Uhy1zPiGeZL607A4o8Kdno2k=
X-Gm-Gg: ASbGncu/zT+R0j2wwXWzu+xD+8vDWBPUdu6u2y9xuW8rONXPRdQjTEWJlTXrYrUjaPh
 XquwYrr2NQ+Z32aC1iMefL2DeSPb/NIWBcZzDzsBK5Mq8ta8Ay039L1cdjuUjl0MxiHBZeLpssl
 9xNGutMzpm0eRN1H5ncNndNraO0M4eJqZ8KS/TPI68RqyOgLdP4ibsXq0jsctQQWlDrphvAn+ZN
 pT9lDo04/yJq8FjnbhcyIKFvfoIV21R08hDbPiKEZHFWa1NoyCO8rCCYYt73Lzw6D+97SBA7yVJ
 W7+kjg/76nwvuv4SoLuDQGo5IMqGrnNGqPHtTo099iOPdDwi8PwI6WU=
X-Google-Smtp-Source: AGHT+IFHFYIuBSQlVqY4NAt0bxjOVF91mSkpnyefvrQws9gzKaYcA7RtlAvG+ksDdmsUihatgVGBtQ==
X-Received: by 2002:a17:90b:1d52:b0:2ee:8358:385 with SMTP id
 98e67ed59e1d1-2fa23f55dc2mr23890488a91.4.1739225583375; 
 Mon, 10 Feb 2025 14:13:03 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b5c692sm9329310a91.42.2025.02.10.14.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:13:02 -0800 (PST)
Message-ID: <ff20cdea-f09c-4c5a-a937-1c97eee1af4d@linaro.org>
Date: Mon, 10 Feb 2025 14:13:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/sh4: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/sh4/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index e3c2aea1a64..9d3e6cb2fd7 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -134,6 +134,11 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
>   
>   static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>   {
> +#if TARGET_BIG_ENDIAN
> +    info->endian = BFD_ENDIAN_BIG;
> +#else
> +    info->endian = BFD_ENDIAN_LITTLE;
> +#endif

?:

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

