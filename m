Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CB4C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5p3-0001xJ-Oe; Wed, 13 Aug 2025 03:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5og-0001uS-Ht
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:22:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5oY-0005ee-DD
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:22:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so56795605e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755069743; x=1755674543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7rwFIJFWEw1JqoHi0jsToh6aXNoS+t1RMBGkKnJaj4I=;
 b=v0hIdO82CbEMINuuREglZ+ldFwyhQoPBulN7PtF1AfgYccpToD4/xzImQAV6KN/WgY
 c/RcjrE2m2GZmOAHbvaFd/WKEFb2Qua0TGySTODebEYWguTzbIfqrdn3OdmsU4tY/WMq
 F+2zCWfXyM38LB2puPSxyft/gipXt8hAR1AuXkopBt1EkAH/mapGSnQYkSWzkvWe3Xyw
 5YfLm8z9Y3LKluE+pbW8Op+YrZpHmmp8k8Ae/Z02/TyS6MtMgZaTmG2fVR3pRSEw4gnN
 Zl2OdaRPhf7kvUx6gWEdjiU/dk/XnAB/GBBzF2ybFNIieMKPku7SmIoGl3uEFDHk+6bs
 xZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755069743; x=1755674543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7rwFIJFWEw1JqoHi0jsToh6aXNoS+t1RMBGkKnJaj4I=;
 b=cI4wgpFBehzDfZ085IdzTQRLS94ZazyAuPXwTu8sOWD7d8eDZe7Kbqs0aHVbQVSDhR
 W0k0azLvbiKHij0vZQ9fHm4eRvBRcL5sLw/lv+zB0IqW8zsbCFuVLHLnqk8Zoj+31hej
 Hg8bZohVwztWzCq952EzPQc4FaJa+ymhJav1Ju/6qVFwr/L2pcju688231DF2js0oXtG
 6GV2dffxvUGFB41X5QRJyySjsSsCtFt4uocSL9ldUWH1+szU08NoxR6CKkkuJVpzkWK6
 0OzjqdTmVcyG/nTBkXJgfM2L4yKJNuuczF5LRJvT2fwTjAcEp5pWVC1QKEt+36F8Alrv
 JGcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJdguC0Fi0kFSvDukYg8b8lJjdB38DRCIoqlFPflBtY2y+stIkQBP0he5utSfQ+QZpT3fVM4lJUbun@nongnu.org
X-Gm-Message-State: AOJu0YxerPv3w1HWI1x6qomSuh1dg7iXznulGzgOeWp4unCVJAOqYucZ
 RM8trU9pwh561F5Q9lkZxiChusEcZJGESj2Mg9U9EDowOYLm0U5yzRbXJThPcoChe0Y=
X-Gm-Gg: ASbGnctvLA2bH8EcFoik54H7jejpPMJi93Om8cd2p8CLhCbU6HIwaoVn9RLDFANkX9b
 o/UpvVYSp4XZ32P0thhlFFborHwtaF2K2S+pLVowFdq1RaWXmtDgpODBSCwU3/OVtRBhykmjMkC
 TAtmr70yXbufTA8Z3ZAkdkGqRaB06a8JMCqF/jNezouUO57QVmBX2lUGDAE9tE4rxxjIYnYnCcs
 O6LU9Jbu2hWcfr7lhIn8sEbNu4dKvY2KmivhfkJ2pAlQ2dnZC2aTcR1tNpC01TiuTmDaVbLvmy+
 d2MM2IejjkpDuKkvfUNLQhfceEYYs5WLyISIoBC7cp85rfRcdlwOVYzVxWJobhbpD9OSwPIV7PV
 cF9kbNU1o4x4fVF0sulL1CY2PM0vgasdnktnsKgefp5mOA3pK2IEuhNXbO9QMdA8fAA==
X-Google-Smtp-Source: AGHT+IFAn7ETOWdX9OHpHoSSKcmgnGVRDEJAMf8iJ+WZqvKtQB0VAGIKQjsa/ewcbuLXr41MSeLkxQ==
X-Received: by 2002:a05:600c:46c9:b0:459:e048:af42 with SMTP id
 5b1f17b1804b1-45a1660b46bmr14169505e9.24.1755069743204; 
 Wed, 13 Aug 2025 00:22:23 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e009e465sm38426660f8f.43.2025.08.13.00.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 00:22:22 -0700 (PDT)
Message-ID: <90f3ed96-fd24-4d51-a9af-cc6dd3f0a058@linaro.org>
Date: Wed, 13 Aug 2025 09:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] hw/sd/ssi-sd: Return noise (dummy byte) when no card
 connected
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250812165642.81157-1-philmd@linaro.org>
 <20250812165642.81157-2-philmd@linaro.org>
 <92ee0558-81c6-45dc-8942-f344a279d637@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <92ee0558-81c6-45dc-8942-f344a279d637@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 13/8/25 08:16, Michael Tokarev wrote:
> On 12.08.2025 19:56, Philippe Mathieu-Daudé wrote:
>> Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
>> code") exposed a bug in the SPI adapter: if no SD card is plugged,
>> we are returning "there is a card with an error". This is wrong,
>> we shouldn't return any particular packet response, but the noise
>> shifted on the MISO line. Return the dummy byte, otherwise we get:
>>
>>    qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: 
>> Assertion `s->arglen > 0' failed.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> 
> While the commit which exposed the bug is in 10.1, it looks to me like
> this is a qemu-stable material (7.2 & 10.0), because the bug is there,
> it just does not result in qemu assertion failure.  Please let me know
> if it is not.

You are correct!


