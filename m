Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10784C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngvY-0007mH-Mr; Thu, 27 Feb 2025 11:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngvE-0007gG-WB; Thu, 27 Feb 2025 11:39:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngv1-0006I7-AL; Thu, 27 Feb 2025 11:39:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A3DAD4E61D5;
 Thu, 27 Feb 2025 17:39:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YG_7W4Zus48i; Thu, 27 Feb 2025 17:39:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 430D84E6035; Thu, 27 Feb 2025 17:39:17 +0100 (CET)
Message-Id: <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740673173.git.balaton@eik.bme.hu>
References: <cover.1740673173.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 3/5] ppc/amigaone: Add default environment
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 27 Feb 2025 17:39:17 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Initialise empty NVRAM with default values. This also enables IDE UDMA
mode in AmigaOS that is faster but has to be enabled in environment
due to problems with real hardware but that does not affect emulation
so we can use faster defaults here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 849c9fc6e0..5c5585d39a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -52,6 +52,28 @@ static const char dummy_fw[] = {
 #define NVRAM_ADDR 0xfd0e0000
 #define NVRAM_SIZE (4 * KiB)
 
+static char default_env[] =
+    "baudrate=115200\0"
+    "stdout=vga\0"
+    "stdin=ps2kbd\0"
+    "bootcmd=boota; menu; run menuboot_cmd\0"
+    "boot1=ide\0"
+    "boot2=cdrom\0"
+    "boota_timeout=3\0"
+    "ide_doreset=on\0"
+    "pci_irqa=9\0"
+    "pci_irqa_select=level\0"
+    "pci_irqb=10\0"
+    "pci_irqb_select=level\0"
+    "pci_irqc=11\0"
+    "pci_irqc_select=level\0"
+    "pci_irqd=7\0"
+    "pci_irqd_select=level\0"
+    "a1ide_irq=1111\0"
+    "a1ide_xfer=FFFF\0";
+#define CRC32_DEFAULT_ENV 0xb5548481
+#define CRC32_ALL_ZEROS   0x603b0489
+
 #define TYPE_A1_NVRAM "a1-nvram"
 OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
 
@@ -94,7 +116,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
 {
     A1NVRAMState *s = A1_NVRAM(dev);
     void *p;
-    uint32_t *c;
+    uint32_t crc, *c;
 
     memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
                                   NVRAM_SIZE, &error_fatal);
@@ -113,12 +135,25 @@ static void nvram_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
+    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
+        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
+        /* Also copies terminating \0 as env is terminated by \0\0 */
+        memcpy(p + 4, default_env, sizeof(default_env));
+        if (s->blk) {
+            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
+        }
+        return;
+    }
     if (*c == 0) {
         *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
         if (s->blk) {
             blk_pwrite(s->blk, 0, 4, p, 0);
         }
     }
+    if (be32_to_cpu(*c) != crc) {
+        warn_report("NVRAM checksum mismatch");
+    }
 }
 
 static const Property nvram_properties[] = {
-- 
2.30.9


