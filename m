Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCEED11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alA-0006aH-Av; Sun, 03 Nov 2024 08:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al7-0006YO-QM; Sun, 03 Nov 2024 08:35:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al6-0001VD-06; Sun, 03 Nov 2024 08:35:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ceca0ec4e7so1290699a12.0; 
 Sun, 03 Nov 2024 05:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640909; x=1731245709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cYHnxTWw7p4cqvKVRM0bYbFOPLVh9Od6lWVKQFFgqU=;
 b=S7An9rWAeW/Cs7cl5O766mDeeAWJ6Q1XTfJV+rAUw6GdNTYOSPeSdFguXSiFgrrpJ/
 9XY9eE2VpKVR63/v5DE4kWcRfiVxWCuMCkKGleIjUukpB0jb/41I8Ykm9qOYID0M32mk
 FA0xxhApJkQIAfCzBFS5GzAjiukZH4HrHCcXNWlrHlBfa0k/E/RD9dERoI7YKfV3oZQp
 3jNVL6SFT4Lth3bDpkPmCb41hdmbHU2RuLeQxRoJjjFM89tmS4370MupmDGrLi0rMEGv
 yyImtR1ivmg2QaX8hdCSWwx+V7DgJKlCiuGNG6BekF47XbKEKmh/JWgXAFHnYmGBpjhL
 SyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640909; x=1731245709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cYHnxTWw7p4cqvKVRM0bYbFOPLVh9Od6lWVKQFFgqU=;
 b=v8n7oakFJed4RFbWcelL0sItB1OqGM0cr7u5vMly5R9+blr1TMsCo0OMxCGOkHpbYu
 iHBFDH3l6Hl3Cy6pBTgInFpan2LrWXA+qsR8CGiMweKKT62MFt81Ufq/blK4ibw1GbLq
 BeBZI63Lx8sEoAUB8lHmhED22ssvq2sPct04Zug1VVq2f/XcqIjTWzLEbin0ISux57jZ
 S5B2qL9EnFFrRZWK2vTikfjIRzzPBlKjatY2o7QkTAy9j3dV9nj0dibRgKXHZN/wgEzV
 AQEFmUCY9W7ljLRBKP10tNiaWDBVKFuy9SlqlwML+C3VKiaqLyikb5UuW+McSXMbwBGJ
 mm9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC9JgqtbY+3Z3/NIWk0uEWW97kJAuYmMMUn/H3NodqYTIAx16V7BOcfyhXI4TqcpSMxrRr0yIMK1a9@nongnu.org,
 AJvYcCW0y1IGWPaf0RSF9Ic4NYxEEADDGNnJb0LAMeITflhT7DQbNfrV9PdjiUk4TLFAXkVcNe/mDepWmpc=@nongnu.org
X-Gm-Message-State: AOJu0YxHhrPxvbmvs+hHWcmvpPBLN8V7meQsbH3zbF2fvoSacZKmV8rX
 HAI1UO0Hzxp4J2vBmBAYP7639yI5EG8A4fpSYwkuH/S/rYKNS3NNaT72SA==
X-Google-Smtp-Source: AGHT+IFi714sznYZ6C7nJF2EK5NZfV2pJsBfD6ZoRdXCYBhBUxg6DLcUQ1gtpdJpFrSympm2bfiYtQ==
X-Received: by 2002:a17:906:6a15:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-a9de616dfeamr3071373366b.50.1730640909199; 
 Sun, 03 Nov 2024 05:35:09 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:08 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 20/26] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:06 +0100
Message-ID: <20241103133412.73536-21-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ed01499391..dbe5c2340c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -37,7 +37,6 @@
 #include "migration/vmstate.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -1598,15 +1597,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     sdhci_common_class_init(klass, data);
 }
 
-static const TypeInfo sdhci_sysbus_info = {
-    .name = TYPE_SYSBUS_SDHCI,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SDHCIState),
-    .instance_init = sdhci_sysbus_init,
-    .instance_finalize = sdhci_sysbus_finalize,
-    .class_init = sdhci_sysbus_class_init,
-};
-
 /* --- qdev bus master --- */
 
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
@@ -1617,13 +1607,6 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
     sbc->set_readonly = sdhci_set_readonly;
 }
 
-static const TypeInfo sdhci_bus_info = {
-    .name = TYPE_SDHCI_BUS,
-    .parent = TYPE_SD_BUS,
-    .instance_size = sizeof(SDBus),
-    .class_init = sdhci_bus_class_init,
-};
-
 /* --- qdev i.MX eSDHC --- */
 
 #define USDHC_MIX_CTRL                  0x48
@@ -1882,12 +1865,6 @@ static void imx_usdhc_init(Object *obj)
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
-static const TypeInfo imx_usdhc_info = {
-    .name = TYPE_IMX_USDHC,
-    .parent = TYPE_SYSBUS_SDHCI,
-    .instance_init = imx_usdhc_init,
-};
-
 /* --- qdev Samsung s3c --- */
 
 #define S3C_SDHCI_CONTROL2      0x80
@@ -1946,18 +1923,31 @@ static void sdhci_s3c_init(Object *obj)
     s->io_ops = &sdhci_s3c_mmio_ops;
 }
 
-static const TypeInfo sdhci_s3c_info = {
-    .name = TYPE_S3C_SDHCI  ,
-    .parent = TYPE_SYSBUS_SDHCI,
-    .instance_init = sdhci_s3c_init,
+static const TypeInfo sdhci_types[] = {
+    {
+        .name = TYPE_SDHCI_BUS,
+        .parent = TYPE_SD_BUS,
+        .instance_size = sizeof(SDBus),
+        .class_init = sdhci_bus_class_init,
+    },
+    {
+        .name = TYPE_SYSBUS_SDHCI,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SDHCIState),
+        .instance_init = sdhci_sysbus_init,
+        .instance_finalize = sdhci_sysbus_finalize,
+        .class_init = sdhci_sysbus_class_init,
+    },
+    {
+        .name = TYPE_IMX_USDHC,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = imx_usdhc_init,
+    },
+    {
+        .name = TYPE_S3C_SDHCI,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = sdhci_s3c_init,
+    },
 };
 
-static void sdhci_register_types(void)
-{
-    type_register_static(&sdhci_sysbus_info);
-    type_register_static(&sdhci_bus_info);
-    type_register_static(&imx_usdhc_info);
-    type_register_static(&sdhci_s3c_info);
-}
-
-type_init(sdhci_register_types)
+DEFINE_TYPES(sdhci_types)
-- 
2.47.0


