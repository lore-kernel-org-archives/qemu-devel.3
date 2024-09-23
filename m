Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B73CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPt-0003eA-Dp; Mon, 23 Sep 2024 05:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPr-0003V6-B7; Mon, 23 Sep 2024 05:31:35 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPp-00071i-C8; Mon, 23 Sep 2024 05:31:34 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso610137966b.1; 
 Mon, 23 Sep 2024 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083890; x=1727688690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEqt+B/rZIxMfU9E+WiGg5KsOPuW4FR5+eD/WT3GDlU=;
 b=HEQKLQUIJgQnCWo6SPZYMhEIPM1W5wvYb8q9/RL2ADJPbKQMkorGzNzcDpWKRAXVBq
 ZmWoBx0bFf0rgUc+1YPNtGlKs6dT01HhfF0X7CiwRxlMEyT1wIDBjA2do4ye5HqzjHwk
 7UUptFgjV4uLrRRJL7hARl0Nc69x1WZDCkGWcw7yChYwACVL8cLAUrk5mn136mAabfE8
 oKxrj2EPKz7TCt732m8957vabuwhxE7ED6didRJZO/tn/pY/Ys0XJlfx9EEaYw8kIJ6b
 MT/5DN6o2upd8HXjlsfD/GxOHnnsps1Ii9N7hqZcSYlY8+fdkmX8l72ga+kKB/33QU5T
 uiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083890; x=1727688690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEqt+B/rZIxMfU9E+WiGg5KsOPuW4FR5+eD/WT3GDlU=;
 b=iAnMo5XM5TUaa0GNSPSka8Fx+URqxbhUXoV/zONV0NJY5yQuhz3ZP+PmI+ccsF6RWL
 oQyGNf3NR0Bt0t0COsGnA+jD++U+4Kt+PDS1wCgWBfks+txxeN0bUnWyraohVRU4USoB
 7sjkJc71ozKfQKXOy+XN67Vvej2+jBAa9zRxPbmsiA5BEE0M9FF1BiKe2A0JWae4IQgp
 Z6K+5Oe2mk8T2n7uVJm/bKDRYXDmLI8G3qJmk5/KRh1HlCOqp/hXMR05CtM9iDuypLMi
 2df3HWZaK0R7lFFpsJA9bW+PCXtJjjZPjYyXiSCphyOs4dm70D0tRLndvookvzgbRMg4
 GkgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVEZmNjqvEK9pjpmDZ7HvDiuKRP+wop+nMKh/tdYNdNe28LekVqT26XB7IH/FtcXzP02a1shGHJKbJ@nongnu.org,
 AJvYcCX9B2vAESRmRrSasllVIbEsDRyhGJRKW0Ip5O4gNrvOdazto9tiW8lIlGI8gPgrW5o+mpFmYqWEwCg=@nongnu.org
X-Gm-Message-State: AOJu0Yxnss38cNF3HfBdOchfc8v5oifks8Mcz9QT1eFh0wHdxjHzwu9I
 dDv1pEKXcdqxz5ejFTPoaJOmhMsVIm64nrIn0YTd+ltOtC/WrC7yiThKAQ==
X-Google-Smtp-Source: AGHT+IGPs86AeQbW3UBi24h3sOmCWRRsJfhjcOsSwwgsnpFlauMcEEzR1MYD2C8rEAjfyxYwJIFCpA==
X-Received: by 2002:a17:907:d3e1:b0:a8a:71d5:1094 with SMTP id
 a640c23a62f3a-a90d50eec25mr1022663666b.46.1727083890042; 
 Mon, 23 Sep 2024 02:31:30 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 18/23] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:11 +0200
Message-ID: <20240923093016.66437-19-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 87122e4245..3ed2d8658a 100644
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
2.46.1


