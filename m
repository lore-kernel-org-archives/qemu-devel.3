Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0BBC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQt-0005Ua-9A; Wed, 19 Aug 2026 14:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQr-0005Ta-Hn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQo-0007NL-W4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49978908b35so9744665e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787165673; x=1787770473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+OidqFmgxqDLOch1X954fO+xBtTG297VTbgXxOojjA4=;
 b=kLSVHqwRMq5EX6VaPaEqhsGqD8NyEJMPOm6PxqwpgaJ2A7CAWhFDFkIDgeHbin5ZDN
 5WuEfAwCByKlC9DfP2E+VpMkm8knI3jYWG/FRF5hXs/nIQF5rlNvJ7yiSwQTlG3ey0pn
 Rdnq6Wl9rRmYZiOe9E/aGjU/cYp4Tu9a0Ezoxy0I0KmdY5EVChwpvs4p5n11Dr7sJUaP
 XI5PQzWbEwcj6/SsjG+KHwWd/pFiTNJzkTyYeoDDu1WwhCaVuv33NtAZDfYdsCcCPp34
 DK8IDBt5yOgrOq9+YJSHFNo5phLKgIS7Vo7Vd9vxpuDKevGyk1cTQX1RmWkvSAfs8rfi
 JfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165673; x=1787770473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+OidqFmgxqDLOch1X954fO+xBtTG297VTbgXxOojjA4=;
 b=VZH2TfmXW1uElkM9tplzIyd8o5rAq48uO8vMKrFYbcjAcz4yQuDgpqSn+d26QD24Pc
 x4NzN5mhju4kxtaQRyAnVOCQdPFkt90rHYWBpWWMK4sn9b3W0xsR10eCp9djkOZtN1fV
 67vCPT6cwjbV0PwIxOzh/rTHgxUgNHqxkIyUhSaJAhXoODDwZkaa3Ve5Dv9yQJIdBpVe
 ycfF1T8U3laLKTj+K4QCQke/ytCY9RW5FIHqaN+5hLqkce1f/JTuNpyUNdgjvyTn+Kmz
 ljv4r6p/7pB+qawUUbIowGnX0u0JWtSQ3PI70eFu5zIKcrxxFZzjgkHGaJMTDdqE8yuN
 h3DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzCNAq44tuUzpRq9muFLmDYRchn0e07yasDbvOjlAI+LA+4YL2jLVDwyPaumzDpBUldQOtCH8MTu8v@nongnu.org
X-Gm-Message-State: AOJu0YyfpRkmZY3OBLsBDkY75FLVOCJa15E4HU2E7i3qa+3Zp/O6iOmf
 oLWQlZrd1bxkk8g5ovnIo3MTiM1Qr2L0Bgq4NvPxOQjxr3hAnRTrVdxWeLh3Nt61toA=
X-Gm-Gg: AR+sD13Q1l3Ozuoge19dNdxLyHS/CSOWSgU3UaPDKgvtLDn53Ul+H5CJsdDFW269aHe
 4TOdUogumjHrRkjRsQNN++Q/QFRqyIsO9TVU6J+2/dKa+u5oy8xB8tPAMYw7JzcNir2e8EGZAfN
 dlI1TESkgIs924vFp/gTgVkzrG6y9V14/sqEcdxpgmYgfGozJ7tLyuHovhzJYQXFRnB5zHFX7o3
 fsPc5KxWahJLpXldzpOutZ9UeMljvxyMNn4SMck1lbIJ/0L3CkP8TZ2isS8epg/AyyP13KTo97s
 SNxZy8g7CWGUePQ2q/vpOWL6Xc2EgAIcb/uyDPZ6bAueKp0UxPjMaUZ7r5GiaXs90eRiLHgO8cz
 CZZ9kUroS3wJpTU54wbCx2zTB0ZONKb75JCigg5j+ILy1vq9fm1uuNnA4HQ9WmC+lABvjmqeL+s
 gQhkZHIBzlY04X3nY7RRwscLkJpTyoqeZqiZ6XilZH1HWSIw/1871wOQkRYIRhrt45qikcyA9c7
 DGOdy2aDctGFChk1hQGBLUWxSZeuqY4ue735U8OvmMgC3C2al7YxLNhTvktbXP2KY60Fw==
X-Received: by 2002:a05:600c:4e94:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499aa1b549cmr124054865e9.11.1787165673424; 
 Wed, 19 Aug 2026 11:54:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145c9d7sm7995048f8f.15.2026.08.19.11.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:54:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 1/5] tests/qtest/pflash-cfi02-test: Don't use musicpal machine
 for testing
Date: Wed, 19 Aug 2026 19:54:26 +0100
Message-ID: <20260819185430.3467629-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819185430.3467629-1-peter.maydell@linaro.org>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We currently use the musicpal machine for testing the pflash-cfi02
device.  We'd like to remove that machine, so switch the tests to the
sh4 r2d board type instead.

We use r2d because it happens to have the same "2 bank" config that
musicpal did.  (Of our other options, xilinx-zynq-a9 has only a
1-bank setup so wouldn't allow the same range of testing, and the
canon-a1100 board both doesn't support specifying a flash drive via
-drive if=pflash, plus it seems likely it too might be a candidate
for deprecate-and-drop.)

The r2d flash device is not quite the same config as the musicpal
one: it has a different base address and size, and different
ID values. So we need to update the test to match.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build         |  6 +++---
 tests/qtest/pflash-cfi02-test.c | 38 ++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..1f0f04e36c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -196,7 +196,9 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +         \
   qtests_pci + ['migration-test', 'cpu-plug-test', 'drive_del-test']
 
-qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
+qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
+   config_all_devices.has_key('CONFIG_R2D') ? ['pflash-cfi02-test'] : [])
 qtests_sh4eb = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
 
 qtests_sparc = ['prom-env-test', 'm48t59-test', 'boot-serial-test'] + \
@@ -243,8 +245,6 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STELLARIS') or
    config_all_devices.has_key('CONFIG_MPS2') ? ['cmsdk-apb-watchdog-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
-   config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
diff --git a/tests/qtest/pflash-cfi02-test.c b/tests/qtest/pflash-cfi02-test.c
index 8c073efcb4..fe630c9c16 100644
--- a/tests/qtest/pflash-cfi02-test.c
+++ b/tests/qtest/pflash-cfi02-test.c
@@ -11,17 +11,25 @@
 #include "libqtest.h"
 
 /*
- * To test the pflash_cfi02 device, we run QEMU with the musicpal machine with
+ * To test the pflash_cfi02 device, we run QEMU with the sh4 r2d machine with
  * a pflash drive. This enables us to test some flash configurations, but not
  * all. In particular, we're limited to a 16-bit wide flash device.
  */
 
-#define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
-#define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
+/*
+ * These need to match the flash size and address in r2d.c.
+ * If the flash size changes then the sector_len[] and nb_blocs[]
+ * values in configuration[] below will need to be updated to match.
+ */
+#define BASE_ADDR 0x00000000
 
-#define UNIFORM_FLASH_SIZE (8 * 1024 * 1024)
+#define UNIFORM_FLASH_SIZE (16 * 1024 * 1024)
 #define UNIFORM_FLASH_SECTOR_SIZE (64 * 1024)
 
+/* These must match the id0, id1 args to pflash_cfi02_register() in r2d.c */
+#define FLASH_ID0 0x0001
+#define FLASH_ID1 0x227E
+
 /* Use a newtype to keep flash addresses separate from byte addresses. */
 typedef struct {
     uint64_t addr;
@@ -260,7 +268,7 @@ static void test_geometry(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal"
+    qtest = qtest_initf("-M r2d"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read=on"
                         /* Device geometry properties. */
                         " -global driver=cfi.pflash02,"
@@ -295,16 +303,16 @@ static void test_geometry(const void *opaque)
     /* Check the IDs. */
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
-    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, FLASH_ID0));
     if (c->bank_width >= 2) {
         /*
-         * XXX: The ID returned by the musicpal flash chip is 16 bits which
+         * XXX: The ID returned by the r2d flash chip is 16 bits which
          * wouldn't happen with an 8-bit device. It would probably be best to
          * prohibit addresses larger than the device width in pflash_cfi02.c,
          * but then we couldn't test smaller device widths at all.
          */
         g_assert_cmphex(flash_query(c, FLASH_ADDR(1)), ==,
-                        replicate(c, 0x236D));
+                        replicate(c, FLASH_ID1));
     }
     reset(c);
 
@@ -436,7 +444,7 @@ static void test_geometry(const void *opaque)
     flash_cmd(c, FLASH_ADDR(0x5555), UNLOCK0_CMD);
     flash_cmd(c, FLASH_ADDR(0x2AAA), UNLOCK1_CMD);
     flash_cmd(c, FLASH_ADDR(0x5555), AUTOSELECT_CMD);
-    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, FLASH_ID0));
     reset(c);
 
     /*
@@ -580,7 +588,7 @@ static void test_cfi_in_autoselect(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal"
+    qtest = qtest_initf("-M r2d"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read=on",
                         image_path);
     FlashConfig explicit_config = expand_config_defaults(config);
@@ -590,7 +598,7 @@ static void test_cfi_in_autoselect(const void *opaque)
     /* 1. Enter autoselect. */
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
-    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, FLASH_ID0));
 
     /* 2. Enter CFI. */
     flash_cmd(c, CFI_ADDR, CFI_CMD);
@@ -600,7 +608,7 @@ static void test_cfi_in_autoselect(const void *opaque)
 
     /* 3. Exit CFI. */
     reset(c);
-    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, FLASH_ID0));
 
     qtest_quit(qtest);
 }
@@ -613,7 +621,7 @@ static void cleanup(void *opaque)
 
 /*
  * XXX: Tests are limited to bank_width = 2 for now because that's what
- * hw/arm/musicpal.c has.
+ * hw/sh4/r2d.c has.
  */
 static const FlashConfig configuration[] = {
     /* One x16 device. */
@@ -624,13 +632,13 @@ static const FlashConfig configuration[] = {
     {
         .bank_width = 2,
         .nb_blocs = { 127, 1, 2, 1 },
-        .sector_len = { 0x10000, 0x08000, 0x02000, 0x04000 },
+        .sector_len = { 0x20000, 0x10000, 0x04000, 0x08000 },
     },
     /* Nonuniform sectors (bottom boot). */
     {
         .bank_width = 2,
         .nb_blocs = { 1, 2, 1, 127 },
-        .sector_len = { 0x04000, 0x02000, 0x08000, 0x10000 },
+        .sector_len = { 0x08000, 0x04000, 0x10000, 0x20000 },
     },
 };
 
-- 
2.43.0


