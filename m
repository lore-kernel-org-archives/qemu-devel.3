Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68B6C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCey-0005dS-4W; Mon, 17 Mar 2025 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCed-0005b6-4D
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:45:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCea-0007CK-Ji
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:45:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso16321995e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226320; x=1742831120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMg8UhcXQHvIEqIXGuOtUyJGW27mx+wg6KBctft4FEM=;
 b=MtR//itHsUlhEYQQeeTT8xDcNGJPXab86WfzLBDTGR8ENtZ5hykscUDNwcHBjBfXco
 WM9Jar4BK/VDA+VIaIgDDURelNSF00K3HMq4R7SMZfkoR7rxgnQtRTQ8fwCNvhhpYuBv
 fxlfTyvIUFJP9EIMdiUMHeC+kERGZV02BxQR1jJz0BzqTcYuz2/iGL1pYCorqCwLVjft
 14VW5mM9pZx363tJv5cD7e4PSabkTE+h3/fOjt8Qiy+OpZXe0vzTEBJvVYJC72H9SR15
 xvU09bPboMk3AVupH0otV32+IRsg7DlK6bZpy//4WjAAQaIVyfCRmqHq/z2BKpBJxDEG
 Wcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226320; x=1742831120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gMg8UhcXQHvIEqIXGuOtUyJGW27mx+wg6KBctft4FEM=;
 b=biMlDH0ie4DETZ4IcS74AfLnClxdTALQvGv5DNoKksvtM2g0RdKBKCegkL+9z61Su3
 +YfDB0wX3R/e9CUOvcV3d2u1Utn6t2cU2cCD8SRFHMYQMvgH9Tg6o3x/E9foWTrGRAK1
 fWNKYdP3ZH4JFJhPxx/idYirWWGX8dGtpA7ALCTPD11l2xVmim8rvG9sFGtQ20dhedjU
 ck3rMqe+1+Q+jOfD9PWruux2yTaRLien9PJEulPKPFv06YY08u3nqEeQfNchNSSf4EML
 ooyQV0Pt472JbYbBeBg8sfSH/MGr4HDdDhZUbb4QhMssDQM/LOYRxxdtNWWQLL2N7nWm
 /kAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVblEE3Q3l3tzTIA0rYduTbUzwWw4cxQSOFMwNrNFt27Dtvs6Gr9ZA+pf0CoWkCg2hXlrGsO0QIk3nf@nongnu.org
X-Gm-Message-State: AOJu0Yw486K56TjpU0cOg/BzlOIk5SMBdPw2oHigTOMdgxF9/VYYDaZH
 Hrm1Jee30MyHh5lHxrMTpzh3o1tmxph3qC4wc4aOuSLruD/1k6BxgywRMT9bgQs=
X-Gm-Gg: ASbGncu/txWUeA8IjjXul4QAmyc5zBTwqdCJSlC9m4EtDngUV3rCxrG46D8tGmjo+BL
 Gm9WL4axCqkeXGA0f95KzU4M4f48pi65dbARCJ/9AaRitbAtqQ0QF/+5P94BFIBVbpgCKPOmdt/
 r/z+GDKcFjsZoTHQxlxh8ux+DsxstdlVVEvQTiQr3/XgtLEDU808QzzpR82WKUU/YdsAz/JXKcr
 bE9vEDkcjwI5p6+JGCh4jnLcgztkhN8p6dnVPDgKsZbz0CWpGwSorgVCXTbRTDarVV7eqRgw43p
 t+ucN6D6spaSYwmuUhNSJ8qucXN6ROw23OV0D5m4oL2B8iDZBwxll31gcrMNnxlQfCoGNmD8IgV
 W5kSDf95sN0ef6zVPH10o
X-Google-Smtp-Source: AGHT+IEhSjxLtQ3SHYn2xp4nctIdpTPMfJRSTceC0WctXEVqNS6P4pryVwDSLiJ1BHBdxBv7xQrbJQ==
X-Received: by 2002:a05:600c:3c8b:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43d1ed22601mr131368045e9.31.1742226320172; 
 Mon, 17 Mar 2025 08:45:20 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea197sm15103229f8f.84.2025.03.17.08.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:45:19 -0700 (PDT)
Message-ID: <6fdf3825-bf14-4054-a7f2-a2cd78cfcabc@linaro.org>
Date: Mon, 17 Mar 2025 16:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 6/9] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> Currently we provide an AArch64 gdbstub for CPUs which are
> TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
> TYPE_ARM_CPU.  This mostly does the right thing, except in the
> corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
> which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
> and which to the guest is in AArch32 mode.
> 
> Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
> behaviour into TYPE_ARM_CPU we can change the condition we use for
> whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
> This will mean that we now correctly provide an AArch32 gdbstub for
> aarch64=off CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index a14c269fa5a..a18d87fa28b 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1694,7 +1694,7 @@ void aarch64_add_sme_properties(Object *obj);
>   /* Return true if the gdbstub is presenting an AArch64 CPU */
>   static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)

4 uses, maybe worth removing (directly inlining) as a cleanup
patch on top of this conversion series.

>   {
> -    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
> +    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
>   }
>   
>   /* Read the CONTROL register as the MRS instruction would. */


