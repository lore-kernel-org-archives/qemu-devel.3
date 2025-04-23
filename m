Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D5BC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wpl-000407-5y; Wed, 23 Apr 2025 05:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wpj-0003zi-Kq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:55:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wpg-0001Uz-T1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:55:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4227751f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402154; x=1746006954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+d5Xeuv2uc3jzoOkpR2m9HcjFPvh4dr/Q5xaXQowe20=;
 b=Q1AK2XzRziJKbe+U6BA6Y8GpawRDC5zYyigr7dDfbCTGQgKJrMbsYxrjqprJ3esoQC
 9PGst8CVthTn0dr2kL/eey2R1+FBjBTEkhSTx85xIqh75mNxUPQMNQsiqgFi/rKBUs1O
 cA+dqfS9TZqcg/oKXuK9pb23nzVNs6fnTEY7X+QagPFfDLsC0Rhz8QOMIvnWt3kmWUyJ
 OllKU8qcbKjVdrELKIbnWgJpLZ1K81f8kVq01hKwIIde7q2RBDIul2RrbB5ibQc7hxGc
 YkuMc+hPi5T5VXf/CWTkGK9x4Dwwd/TeAjBUyBjHN4DEAYXja6GbIcJYf9z02rVXWCHd
 2gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402154; x=1746006954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+d5Xeuv2uc3jzoOkpR2m9HcjFPvh4dr/Q5xaXQowe20=;
 b=kBHWKcUzoTHB/rMBV12lLLCrnm/KpDQmxldrc4ZvSUjrxNLCCDJY6rZ/sTRJrDRavK
 tECmyd9go3k1UY9uqqU4tGkka7nYzx2G8spp1Zyp2Hi+RTq+nSN6Clb5qaD4TumMmYCY
 ku3di2zRr+JGz8ZdPfMgWhhg13z4sSHxVWKD7jDMj5/ESqtoZkFE/aNHsqdNOXY0o/fr
 UF/9/HJ3+KlzxdyuDwX8PRUyTV7krWdoXFdPXR9RcZns/gzvLTBIEW+Ft5gLIO9M2bRb
 VPobOCpJp0JKigyp2D9JM6qp6N67cA+AHJuw497Qz1o0A/sE/caK9w9YinguiWmC62f9
 9xEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqoRZ2jeqv1OALIY8g9lKMfvV5xN/8kU1fQes4yQn6blgNBHk3lSoj0VL8gNTFNTajcEZUP49mpIcA@nongnu.org
X-Gm-Message-State: AOJu0YzU4iiMI0lCcncHPJja1wzdWeV3Q/7177dFJD3IvOLJV3LRyfuh
 BSvJ2JZXXhxmr+t7SR5kccMH/6hLhGS74jzHvfdU+mHg0kiJeSby53xGRTiYQq0=
X-Gm-Gg: ASbGncs/TqnLyaA8pkRWUDVdTyw2tkyCeCwp4U/wiCF4BZIz1ZZk4m756pzXQvXAzFc
 2jnoEjbqi3EvmG34S4ToV9hXwkIl7jTIL0i9g3pJKSV4X1Qlepjj9th9B7vgNhgAo6xjRX5my7+
 TmhCBG/pBWjS0rxemcDlT7XY4YMxlGuGebODRnZVAKHUX9LI/2sVsNgbwVXqvYwnoYrauI/E8kF
 skBzRzYhJK7rDrO0ETKvqY77AQuKQzE45QRIyGg63ef5X9MBUSJhRxwJ8Mm6igEkrjoEbzjRQk2
 pyNexczVlyLPLYq7gXmAwY427/djL9EjToaZ0Y951QEcGZBrfQGsAnr4rLy+Wlhb8AxM2PM3Cm1
 dLf6h74B9
X-Google-Smtp-Source: AGHT+IELR1UZcQxr1bz4iuBjB5ahNMr2eHLw1X9vqZ96HIt6V8g33eWzfzNYi9wLwVuPa9sjXgJFiw==
X-Received: by 2002:a05:6000:188d:b0:39c:1424:2827 with SMTP id
 ffacd0b85a97d-39efba4657amr14980814f8f.15.1745402154626; 
 Wed, 23 Apr 2025 02:55:54 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207e6sm18014732f8f.7.2025.04.23.02.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:55:54 -0700 (PDT)
Message-ID: <a9b4087f-7cb5-41a1-b5d2-f97707cf0356@linaro.org>
Date: Wed, 23 Apr 2025 11:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 054/147] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-55-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-55-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> We were hiding a number of declarations from user-only,
> although it hurts nothing to allow them.  The inlines
> for user-only are unused.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/intc/armv7m_nvic.h | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
> index 89fe8aedaa..7b9964fe7e 100644
> --- a/include/hw/intc/armv7m_nvic.h
> +++ b/include/hw/intc/armv7m_nvic.h
> @@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
>    * @secure: the security state to test
>    * This corresponds to the pseudocode IsReqExecPriNeg().
>    */
> -#ifndef CONFIG_USER_ONLY
>   bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
> -#else
> -static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
> -{
> -    return false;
> -}
> -#endif
> -#ifndef CONFIG_USER_ONLY
>   bool armv7m_nvic_can_take_pending_exception(NVICState *s);
> -#else
> -static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
> -{
> -    return true;
> -}
> -#endif
>   
>   #endif

This code was pulled in user emulation via cpu_mmu_index() in commit
5d4791991d4 ("target/arm: Handle banking in negative-execution-priority
check in cpu_mmu_index()"). We fought with Thomas to disentangle the
Cortex-M HW from user-emulation. I think I got rid of it in range
9b772b19fcc..165876f22cd ("target/arm: Declare CPU <-> NVIC helpers in
'hw/intc/armv7m_nvic.h'") but neglected to drop the stubs it that final
commit. Anyway, "hw/intc/armv7m_nvic.h" is not used anymore on *USER so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


