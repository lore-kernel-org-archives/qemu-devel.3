Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A3CA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDw-0005Jo-5w; Wed, 20 Aug 2025 17:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDt-0005HW-8g; Wed, 20 Aug 2025 17:19:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDq-00050N-Re; Wed, 20 Aug 2025 17:19:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6188b5be5deso486645a12.0; 
 Wed, 20 Aug 2025 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724792; x=1756329592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YJr7HnvTI2L5V2VOYjQO2NQfngAH/j+ZgHqnkWMtYI=;
 b=IG1HKTvzTLzHsWTicVOjgwUDuy5zFJ0rDZRZKAQA8b4O43OuKg9BX6Bog38DlncLR8
 zyrp/VN7taRw3PXmtl47kR1ne0zj4P44bkezpAJcPdwMJ06Zmw5O0cHZQ0oIGfQ8zhy+
 Ykham+7LPxhgLvxpYs89vLmT4lKOTGd55XxeeJytFSCEv5ZGlwaKBCotj5IHjniwceZ5
 r+d22XXAxoTvVrejGDPzVyWs158txxlDOyEJ8YZAfoVtxqrO/ZyWsMevRQxoo4oxTED0
 X6KQEnN64ZtH4oua+B2zb9+GHDv/nefslmDaPqItyJOjKUgoGj0fiY2x1iIPyQo+ZP+j
 RTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724792; x=1756329592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YJr7HnvTI2L5V2VOYjQO2NQfngAH/j+ZgHqnkWMtYI=;
 b=R8t2CgM3rT6mcES87HGdWYxYz2q65aBQQ5b78j9kBDEGTY7lba09a0PfxFrzjg0xgN
 kDErkBwmo1ND3K6bgRHkGQ27YacLz/ojsR1k2DefTSHqWF5F05lGIp6996Fd4Zyfwx1s
 qfTFovbTfSm3lechJlLqZT/qZ5BH+tiy3AisK/KT5nEaT0Ug0m63ya6Q1A01271oIuBf
 twyZMOMbKCUUN/kWuxadldMfO6t+eQTIuZTHphPHYH7ZRpqozuDKfMzJVrLnkHRNdd6l
 SzfbaQfzHWwebrdJau6Q94wAAnWTIY63w+7zBjlY3Ovgp36WShid/NJlTfm0mAL7uWO9
 5isA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwd0O1um+4eqF4VXXvISTKY7tpvavwcZI2j3qg1kslzZpwYJD4y0Iy8d/5D7/+3ddcwfZAnK4Kjg==@nongnu.org
X-Gm-Message-State: AOJu0YyFTrG2aTnXMTxZXpcyel0D5PllHHgbJsP1HSxbOpup/2kmuPQr
 A5CLKxtp/pkTdb1CW58oD/knsoLgViQZwvgjnzag0BA/okHH/A4nPvkikUcazVDM
X-Gm-Gg: ASbGncviHudb5B1AzxNKb88eAMB7wPOPVVFf0KZ3Ej1BAJZMdkWrGOv7JTIR3UejZ4Y
 JFYCT6Fx5djyT+9z/DUpv+gTK/tlHnpakI0ZCamaSxY1DnlL/4W5IhztDFBy+NxToD36Fbk3hcq
 TQY4wv1OngTgclzazjjdISRhc4CeSgeQPWt8ft/ecxBP5EQR12tbGPTVwS/rGD5ZhZnnF5G1UIb
 8vhsEGurn3rvJ2pfpgMK3cWjFqujBTyyVsMbD2HmeH1AGQwBO1GDBnpmQElim92MN9Gop3jZDt7
 TQnPxsK6TVLZoIOCUC5Wu3IV/htzMj+Os8hjU65jfDon9Vvqsha5x4r+bWLDIMsOjWYcRAbXQgx
 03Pd2dtRLWb22duFxaCt73NOWPM9PHIszUmM6BAWeRgbyxN5VOYPOeWX7qQ3cLyXDRfgv/wiOda
 5rms1RagjVbYMuzbdgqwzjyv5XjNTcAC9aNgmbEmQWTb8=
X-Google-Smtp-Source: AGHT+IH63uGdlgaoL0L2Gf64QLQr9qOImnp5sQ4hQtAOnigxRKxMo+03U++LTt6qokt2o+7ATwWlVw==
X-Received: by 2002:a05:6402:270b:b0:618:6a59:5500 with SMTP id
 4fb4d7f45d1cf-61bf86dfae7mr115773a12.1.1755724792245; 
 Wed, 20 Aug 2025 14:19:52 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/10] hw/pci-host/designware: Distinguish stronger between
 viewport memory types
Date: Wed, 20 Aug 2025 23:19:26 +0200
Message-ID: <20250820211932.27302-5-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

This is a preparation for implementing I/O space support. At the same
time, unimplemented memory types and guest errors are logged.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 2a676c65a2..5ad7574924 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -44,7 +44,11 @@
 #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
 #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
 #define DESIGNWARE_PCIE_ATU_CR1                    0x904
-#define DESIGNWARE_PCIE_ATU_TYPE_MEM               (0x0 << 0)
+#define DESIGNWARE_PCIE_ATU_TYPE_MEM               0x0
+#define DESIGNWARE_PCIE_ATU_TYPE_IO                0x2
+#define DESIGNWARE_PCIE_ATU_TYPE_CFG0              0x4
+#define DESIGNWARE_PCIE_ATU_TYPE_CFG1              0x5
+#define DESIGNWARE_PCIE_ATU_TYPE_MSG               0x10
 #define DESIGNWARE_PCIE_ATU_CR2                    0x908
 #define DESIGNWARE_PCIE_ATU_ENABLE                 BIT(31)
 #define DESIGNWARE_PCIE_ATU_LOWER_BASE             0x90C
@@ -268,6 +272,7 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
     const uint64_t target = viewport->target;
     const uint64_t base   = viewport->base;
     const uint64_t size   = (uint64_t)viewport->limit - base + 1;
+    const int iatu_type   = viewport->cr[0];
     const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
 
     if (memory_region_is_mapped(&viewport->mem)) {
@@ -276,7 +281,8 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
     object_unparent(OBJECT(&viewport->mem));
 
     if (enabled) {
-        if (viewport->cr[0] == DESIGNWARE_PCIE_ATU_TYPE_MEM) {
+        switch (iatu_type) {
+        case DESIGNWARE_PCIE_ATU_TYPE_MEM:
             if (viewport->inbound) {
                 /*
                  * Configure MemoryRegion implementing PCI -> CPU memory
@@ -298,7 +304,10 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
                 memory_region_add_subregion(get_system_memory(), base,
                                             &viewport->mem);
             }
-        } else {
+            break;
+
+        case DESIGNWARE_PCIE_ATU_TYPE_CFG0:
+        case DESIGNWARE_PCIE_ATU_TYPE_CFG1:
             if (!viewport->inbound) {
                 /*
                  * Configure MemoryRegion implementing access to configuration
@@ -321,6 +330,18 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
                                   (int)busnum, (int)devfn);
                 }
             }
+            break;
+
+        case DESIGNWARE_PCIE_ATU_TYPE_IO:
+        case DESIGNWARE_PCIE_ATU_TYPE_MSG:
+            qemu_log_mask(LOG_UNIMP, "%s: Unimplemented iATU type %d", __func__,
+                          iatu_type);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Illegal iATU type %d", __func__,
+                          iatu_type);
+            break;
         }
     }
 }
-- 
2.50.1


