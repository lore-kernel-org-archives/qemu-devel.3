Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF13CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9D-00062S-0D; Mon, 29 Sep 2025 12:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8L-0003fb-Ph
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8G-0002wh-NY
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m90kDUDYuYve6SmDo6FTwBW7e6HCMcYMDXVtfLWwzpY=;
 b=Fn9Qq3WFs8aELfgbEIZSQRBzgCE9IXI/pR3Azgbl3Vx5V5F9ZnGPyQfciU+ETFVS8qaD0H
 Kyms11qrpn95lPTLFp2KCJdUEhG7qFVBBYABUF0xWuWmqpc3PdB+C2gQYsaeaJmhCy2G3L
 8JINrbfXRG7pkqH3LgaI+qCvscuVq3o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-b-FetW65OnWnr1dg7C4OJg-1; Mon,
 29 Sep 2025 12:53:42 -0400
X-MC-Unique: b-FetW65OnWnr1dg7C4OJg-1
X-Mimecast-MFC-AGG-ID: b-FetW65OnWnr1dg7C4OJg_1759164821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B8CD195609E; Mon, 29 Sep 2025 16:53:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F2711800446; Mon, 29 Sep 2025 16:53:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/32] hw/arm/aspeed: Move aspeed_install_boot_rom to common
 SoC code
Date: Mon, 29 Sep 2025 18:52:27 +0200
Message-ID: <20250929165230.797471-30-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move the boot ROM install helper into common SoC code so it can be reused
by all ASPEED boards, and decouple the API from AspeedMachineState.

Specifically:
 - Move aspeed_install_boot_rom() to hw/arm/aspeed_soc_common.c and
   declare it in include/hw/arm/aspeed_soc.h.
 - Change the helper’s signature to take AspeedSoCState * and a
   MemoryRegion * provided by the caller, instead of AspeedMachineState *.
 - Update aspeed_machine_init() call sites accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 23 +++--------------------
 hw/arm/aspeed_soc_common.c  | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5567bdcb699f..aea210a8e2ec 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -314,6 +314,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                unsigned int count, int unit0);
 void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
                            Error **errp);
+void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
+                             MemoryRegion *boot_rom, uint64_t rom_size);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4d0d93583659..429f4c6d7781 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -263,24 +263,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-/*
- * Create a ROM and copy the flash contents at the expected address
- * (0x0). Boots faster than execute-in-place.
- */
-static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
-                                    uint64_t rom_size)
-{
-    AspeedSoCState *soc = bmc->soc;
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
-
-    memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
-                           &error_abort);
-    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
-                                        &bmc->boot_rom, 1);
-    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
-                          &error_abort);
-}
-
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
 /*
@@ -460,9 +442,10 @@ static void aspeed_machine_init(MachineState *machine)
 
         if (fmc0 && !boot_emmc) {
             uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
-            aspeed_install_boot_rom(bmc, fmc0, rom_size);
+            aspeed_install_boot_rom(bmc->soc, fmc0, &bmc->boot_rom, rom_size);
         } else if (emmc0) {
-            aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(emmc0), 64 * KiB);
+            aspeed_install_boot_rom(bmc->soc, blk_by_legacy_dinfo(emmc0),
+                                    &bmc->boot_rom, 64 * KiB);
         }
     }
 
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index d0a400725f24..7f104f8de517 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -178,6 +178,23 @@ void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
     rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
 }
 
+/*
+ * Create a ROM and copy the flash contents at the expected address
+ * (0x0). Boots faster than execute-in-place.
+ */
+void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
+                             MemoryRegion *boot_rom, uint64_t rom_size)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom", rom_size,
+                           &error_abort);
+    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
+                                        boot_rom, 1);
+    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
+                          &error_abort);
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.51.0


