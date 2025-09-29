Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41EDCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H99-0005wr-Kx; Mon, 29 Sep 2025 12:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8J-0003dz-1i
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8C-0002w2-35
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dw5+HRMXQxmLbLvv5eWjtDjPDQLcbeAsb7Fx0HFJnWg=;
 b=Yoq+uTgk/fKS6fnXHO3PcyHefilMyMc4PKT9dYt1XftLsf6A6lnnjszb3lHRWc7VOxiNvA
 oFi2mxJH9XivrmdNKZizlUiM21XI+BMfu6pG0O/pjJYxX/rjOcQDIKqWrIQlUlGuUoliaH
 Gtu4i7IvB80iPHR8TQq9F6+HnsuyQYk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-i8JPLj7pMl6PkSDc-dqhNA-1; Mon,
 29 Sep 2025 12:53:40 -0400
X-MC-Unique: i8JPLj7pMl6PkSDc-dqhNA-1
X-Mimecast-MFC-AGG-ID: i8JPLj7pMl6PkSDc-dqhNA_1759164819
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4838A19560B0; Mon, 29 Sep 2025 16:53:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D4271800446; Mon, 29 Sep 2025 16:53:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/32] hw/arm/aspeed: Move write_boot_rom to common SoC code
Date: Mon, 29 Sep 2025 18:52:26 +0200
Message-ID: <20250929165230.797471-29-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Move the write_boot_rom helper from hw/arm/aspeed.c into
hw/arm/aspeed_soc_common.c so it can be reused by all ASPEED
machines. Export the API as aspeed_write_boot_rom() in
include/hw/arm/aspeed_soc.h and update the existing call site
to use the new helper.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 33 ++-------------------------------
 hw/arm/aspeed_soc_common.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index aaf518d1799e..5567bdcb699f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -312,6 +312,8 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                    uint64_t size);
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                unsigned int count, int unit0);
+void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
+                           Error **errp);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 55f0afe0a499..4d0d93583659 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -263,35 +263,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
-                           Error **errp)
-{
-    g_autofree void *storage = NULL;
-    int64_t size;
-
-    /*
-     * The block backend size should have already been 'validated' by
-     * the creation of the m25p80 object.
-     */
-    size = blk_getlength(blk);
-    if (size <= 0) {
-        error_setg(errp, "failed to get flash size");
-        return;
-    }
-
-    if (rom_size > size) {
-        rom_size = size;
-    }
-
-    storage = g_malloc0(rom_size);
-    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
-        error_setg(errp, "failed to read the initial flash content");
-        return;
-    }
-
-    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
-}
-
 /*
  * Create a ROM and copy the flash contents at the expected address
  * (0x0). Boots faster than execute-in-place.
@@ -306,8 +277,8 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                            &error_abort);
     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
                                         &bmc->boot_rom, 1);
-    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
-                   rom_size, &error_abort);
+    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
+                          &error_abort);
 }
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 31b1e683c375..d0a400725f24 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -17,6 +17,8 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial-mm.h"
 #include "system/blockdev.h"
+#include "system/block-backend.h"
+#include "hw/loader.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
@@ -147,6 +149,35 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
+void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
+                           Error **errp)
+{
+    g_autofree void *storage = NULL;
+    int64_t size;
+
+    /*
+     * The block backend size should have already been 'validated' by
+     * the creation of the m25p80 object.
+     */
+    size = blk_getlength(blk);
+    if (size <= 0) {
+        error_setg(errp, "failed to get flash size");
+        return;
+    }
+
+    if (rom_size > size) {
+        rom_size = size;
+    }
+
+    storage = g_malloc0(rom_size);
+    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
+        error_setg(errp, "failed to read the initial flash content");
+        return;
+    }
+
+    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.51.0


