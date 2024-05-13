Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D4C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SeZ-0005tJ-Ur; Mon, 13 May 2024 06:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeS-0005p5-ED; Mon, 13 May 2024 06:11:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeQ-0006Oh-MD; Mon, 13 May 2024 06:11:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5a2d0d8644so825774466b.1; 
 Mon, 13 May 2024 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715595080; x=1716199880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUtc2P5wiu3xmmXd/GBLH801a72H5QY+oBtjsuwYI28=;
 b=mb759xq4rnEe/ZuU4Ld3afXejl8uCwjv8+DfKV0mq4EvQTFs/yjRuLNo+v5EriczfZ
 k86JvM5aN/JM2uHD6Rm77CRoqC63miabAzZLg8E4bSVcwGMWHzIDsz1ssve/RT4pUatJ
 Ef5Z/xGB+wqz+i86+1ZoLlUMqxVVnHH9+7zYvgt6gpl0BmQrE43CNz630DfcQUqAJe/c
 wkV7lb/aNscF0hrgM9G09u6VQw9sGO/9nZeWXVeeDBsEwRV8oEsAduNZAaSXHFkCOL17
 yAbhI0oJX4F/2WI+uwvRWSL2Op6Kkiq9jotAYOK0UiDgIE3wJrgy9S5X/wcOsU3y1Npl
 CF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595080; x=1716199880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUtc2P5wiu3xmmXd/GBLH801a72H5QY+oBtjsuwYI28=;
 b=Xd7yf93ivdspOkeH8LiCjG5YNp3uzJG0FqEifbyfpdwrrrSsuOrxS8F4z//BIMg5z6
 lOEI8WQ2qDAhJSdbfjmXwsKUnpFESoBBo+xqb7u45ShorHyPT0V2ObBBZA2M3Q3NJzoO
 S2889vEufABr+A0bmKgfOk2vJm63ywmqrv/h3MRzClPP6VCLUjZ4s80S/oPlKVowV0i2
 MApvk0/m7nlUPJ6nJNhvtqq/hHFSUYjhtsGOKh+rHeMpTzQHwSLRS+X+1pNUj1yxKbTj
 edPPU7FktqC33A28KFAeuKJrptmLphDV1DRF7sDcBQeVh6Or5E2kp9djFb5n0t0g9NUl
 8Vbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJESi3O9pi/W6pG08V/dLzFWIkHsCxIbf/5AvNmaCCtbCXeHSQuTUKA7jNnjfejf4+vEVDgWFoFJ9rnSGSzUZhOcz2acqniFyigVR99gqZijHwd1MeDMV6u8sGw==
X-Gm-Message-State: AOJu0Ywe1d3oXWHNEDC27zAzOpbxAgoKpqo/i66jiKXSkg2cgYoo/haV
 Nur6OP2rfkLjs5PSlJKph0sq3IMeJKYjuwJN5OrGPFBpRvNA/revzz1QMg==
X-Google-Smtp-Source: AGHT+IFDtbqqeNzLK4reqnTP+WC926m1NYJQtEWZfxnSrKA9TQH9evXC4Q0sDH5B0MBh3fDxL1FWzQ==
X-Received: by 2002:a17:906:394e:b0:a59:cb29:3fac with SMTP id
 a640c23a62f3a-a5a2d68aad7mr655064066b.65.1715595079841; 
 Mon, 13 May 2024 03:11:19 -0700 (PDT)
Received: from archlinux.. (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d2asm574906666b.87.2024.05.13.03.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 03:11:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] hw/watchdog/wdt_imx2: Remove redundant assignment
Date: Mon, 13 May 2024 12:11:08 +0200
Message-ID: <20240513101108.5237-4-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513101108.5237-1-shentey@gmail.com>
References: <20240513101108.5237-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The same statement is executed unconditionally right before the if statement.

Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>

---

The duplicate line may indicate a bug. I'm not familiar with the code, so this
patch may go into the wrong direction. Please check!
---
 hw/watchdog/wdt_imx2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 6452fc4721..f9a7ea287f 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -39,7 +39,6 @@ static void imx2_wdt_expired(void *opaque)
 
     /* Perform watchdog action if watchdog is enabled */
     if (s->wcr & IMX2_WDT_WCR_WDE) {
-        s->wrsr = IMX2_WDT_WRSR_TOUT;
         watchdog_perform_action();
     }
 }
-- 
2.45.0


