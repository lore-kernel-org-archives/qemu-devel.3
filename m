Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGq9-0000Ue-Gs; Wed, 12 Feb 2025 12:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGq5-0000U0-Ky
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:47:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGq2-00075v-Ul
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:47:56 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso123421905ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739382473; x=1739987273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33iNXKx0X9TIpAIiIXk/qxg059LdQln7JRaM0zT3LQs=;
 b=Crt+m5jdoDNtx24Uw2Bn69Z5cPZseJ3dz80mcmSAI0dopM9oqDmLGk5qgBcTicrNho
 s8d65WyBLaw47+AjWVI6H3eV81e0zOQGd0QqaNyYAm6uFjD6c0CDzHkHJPntHBrhlCJU
 4D9euj/2k12+fS+ssJiy25s5f3uuUg5DlWp+eTTaggl2oiYr3ksfTLVyIuKuJrWwjS7l
 8576cj4IYJAeKx1r77nuc+c+LwtvMF5rbpw81t4JIb5ZSQZlOKQ9AqfRsAZx5QNERzjx
 NYZWoypn003gFMtLD1ggYKz9sBHIO0XLWVly4wdrGJcI+UsdaUWmY9sOGHoKfrSaxYQZ
 A8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382473; x=1739987273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=33iNXKx0X9TIpAIiIXk/qxg059LdQln7JRaM0zT3LQs=;
 b=p4CrDMGa7pG2s1K1WKeuolziqxdgPkmrvcnuvmVtQUcw69U3SMPrJL1Q0JWNPvfgAu
 E3cWkpeEvlICihP/izWbm+wBYpRZwtg7tYTUQfHZEry0H3I9BWco0HTg6BQHDOyadiYG
 E3vcht2L3tj9rp+5pehG7kMJcjm/GDuqno8SEqI4nH7rjNwa17AVG6RT960Cm90W42mD
 SaGKy+5ZrSldKEv9Drs+wlJwXF5T0tOiTseMNH/uG7s7Xtt+n06AtBI2v5Mj3HBlFIsr
 Ku8cZ1ooH4IjsZR3GGpEngN6lklzjuFJGAmWcstDIcUHMUzX5qRSl53ps++q099kVVC6
 LsWA==
X-Gm-Message-State: AOJu0Yx9C7YjvfYBm2NAGvg600YCP7LB2IIbZe5LZ3eRaeUNENMPVsUP
 dvxZDVwSHkw5A6tePirSRw5AvmajDMgFun9DznQGARLds1IsgjFozpQrEWOIh1RQ67kacqQVWGc
 O
X-Gm-Gg: ASbGncun2OOJlkJlaNgRywcFhkjTDojz03BlFVJNo8KLtG1YmxoDM45SVDrqxcYJU5b
 oPSaMy6WDz5sQBKryJLl3cfs2V9+BaLsRf0j4AWe5N89BMc09pL6aVE+p8OhOeZesdZAR2sgEHK
 8hAM9i2yxrAPQ5Slt8IFPFHxk2mUgj5bsuviNI6RPyhv0JHLeFTJzsDU+e6lSNwhSd82acdnebn
 ScgbE+KbVSoQjLowct8/uFxSD9ZI4tjKJDW3NuWb12/qWYPtGLGaGbAPmZbNlDJzHqkxnTfye9x
 zsckqfbtgsGAYNtIULC4GdmbiHqdl2lHyuZPu9AHPqFKvlp18JyozVw=
X-Google-Smtp-Source: AGHT+IHc280XuXIr3P2+X4O27bGc/OCSrFt1ujtHMSXqhVYgx+j202W6X7Zr70z30RredJ6WpXCbsQ==
X-Received: by 2002:a05:6a00:178d:b0:725:cfa3:bc6b with SMTP id
 d2e1a72fcca58-7322c3754admr7255188b3a.3.1739382473135; 
 Wed, 12 Feb 2025 09:47:53 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730840e842bsm6737505b3a.88.2025.02.12.09.47.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:47:52 -0800 (PST)
Message-ID: <7be4a73c-6fc4-4f60-8b29-4cbc9026557b@linaro.org>
Date: Wed, 12 Feb 2025 09:47:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/arm: Mark Allwinner Technology devices as
 little-endian
To: qemu-devel@nongnu.org
References: <20250212113938.38692-1-philmd@linaro.org>
 <20250212113938.38692-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212113938.38692-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/12/25 03:39, Philippe Mathieu-Daudé wrote:
> These devices are only used by the ARM targets, which are
> only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
> DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/allwinner-a10.c         |  2 +-
>   hw/arm/allwinner-h3.c          |  8 ++++----
>   hw/arm/allwinner-r40.c         |  2 +-
>   hw/i2c/allwinner-i2c.c         |  2 +-
>   hw/intc/allwinner-a10-pic.c    |  2 +-
>   hw/misc/allwinner-a10-ccm.c    |  2 +-
>   hw/misc/allwinner-a10-dramc.c  |  2 +-
>   hw/misc/allwinner-cpucfg.c     |  2 +-
>   hw/misc/allwinner-h3-ccu.c     |  2 +-
>   hw/misc/allwinner-h3-dramc.c   |  6 +++---
>   hw/misc/allwinner-h3-sysctrl.c |  2 +-
>   hw/misc/allwinner-r40-ccu.c    |  2 +-
>   hw/misc/allwinner-r40-dramc.c  | 10 +++++-----
>   hw/misc/allwinner-sid.c        |  2 +-
>   hw/misc/allwinner-sramc.c      |  2 +-
>   hw/net/allwinner-sun8i-emac.c  |  2 +-
>   hw/net/allwinner_emac.c        |  2 +-
>   hw/rtc/allwinner-rtc.c         |  2 +-
>   hw/sd/allwinner-sdhost.c       |  2 +-
>   hw/ssi/allwinner-a10-spi.c     |  2 +-
>   hw/timer/allwinner-a10-pit.c   |  2 +-
>   hw/watchdog/allwinner-wdt.c    |  2 +-
>   22 files changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

