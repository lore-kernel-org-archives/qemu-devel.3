Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF71CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkU-0005aU-Kr; Sat, 05 Oct 2024 15:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkO-0005Qv-17; Sat, 05 Oct 2024 15:47:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkL-0007io-Fx; Sat, 05 Oct 2024 15:47:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so31427405e9.1; 
 Sat, 05 Oct 2024 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157639; x=1728762439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evt0YZ7xXYDWP6QHRFCyD0Jf+AgpLDKyhozVkVjfLSU=;
 b=ifeYQPtJBm9O07TLm2z0E8oWZe6o+1Ev3sE145oCQbhMd9T02yf8IHK+hwRAjucOxX
 EoU1xJwbkvK1IzqmxUkzhQLu+TjrbiAB2FnuKF0kxd20cNMXW/REA4RztZNINosXyI3F
 O2n1gBksuLPQ7aX7TrrNcTAtWMX/rRr05wsbKFvoXcPhtVUC9wRamTWWt2ENbgPqySzN
 avBFf2Eg7pCuoqH2lLMVU/3bENevmEjde6Q0wCBkSbzp//aaZTGKFfeCCcy6KXfFmb9t
 S/HPvuA3b6n7bQpDy18VPMPGIIrZF3TP02siIk4x4C6nH1Rc9uBrFfg62H4KT4zlCukP
 ZQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157639; x=1728762439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evt0YZ7xXYDWP6QHRFCyD0Jf+AgpLDKyhozVkVjfLSU=;
 b=W0PSEV7aED05rEINZnmNWgUWMnFYeTg1ZWDMAdwM0HAIy5ph0tXXBA+00sqq8LuK7U
 rfX7/5LAfHDg0iTlaIGFExFwDKWfQMmv+MZQ84+NgsPgSM2BNd+TUADaAV+M96yCbxQ5
 iNpluA2DeKniyPdADFC+JLzmHsUhxwSS6ncOPtvVygQ8BYPcT8hL3pYd3m17UdzHkIXK
 jstR25HWJ0K5llCcvIvsZekTycG6tVZsLGuNQ462qxoO+TRzO52u+3rGqeWiDrenDcow
 E64SU6s6TipHO5JR9PWL8JIEkSrNTbQOp4qwbRYJCA8l6QfTjbFgoTBoE2y11RqGLQSr
 aHsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPiYlhAvN2geL8joN+mbJ3AgtNmiTXDxPTG18Qb38czSvBn2+gF3IVwdvBV110675xHQrON1fbEwg=@nongnu.org,
 AJvYcCWZNjWiu4V7qu9lSOmspuH++audxzVUDYm9u5zwzZv6T9SPO1UbE1Ey+jIUSCjjMt1wm7usPfxHDHIT@nongnu.org
X-Gm-Message-State: AOJu0Yzn6q8afKjrid2j9yma4kcxXhwDch4R01KAphkDv14YhsGuyAm7
 SxfuuvVOgDu0om5sfJBjIrEXMj/tB0Z8PkhvhcJNc/mbKTagYWOyT6n5Eg==
X-Google-Smtp-Source: AGHT+IGP1MEtOCWvVqMRVVuGcqk0jRG07ZsEoxD7mwiHZr6jR3AEMDhv8PSmSTtQBq7tsdb/kNaebA==
X-Received: by 2002:a05:600c:511d:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42f85ab7b98mr50429575e9.18.1728157638561; 
 Sat, 05 Oct 2024 12:47:18 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 18/23] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:58 +0200
Message-ID: <20241005194603.23139-19-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
index ed01499391..aa89513796 100644
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
+static const TypeInfo types[] = {
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
+DEFINE_TYPES(types)
-- 
2.46.2


