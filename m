Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BE0CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9Q-0006k0-2e; Mon, 29 Sep 2025 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8P-0003kz-5D
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8G-0002wy-EH
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GagznEVqq3qrVaD9fDERH0P5fCKpE+192rOBJ8VlL+M=;
 b=PTfunSAYYRTFoShRpcHsEE9xinnmmVSFJQIAKEKoxNzrAX76NF/F0Wdgm8UcbnPDppCAzy
 uwTTzNah5oa6cDYkO4AkW3ATOAQd5eWSxgWjMu6nYlg4wvkGbQi2JybKF/ZzsHKm4/vRbw
 1DpdLhDnE0pF2BqsuyQE3jrgN41r2MA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-X4Tp7c6gNvqs_NCc-Grl_A-1; Mon,
 29 Sep 2025 12:53:44 -0400
X-MC-Unique: X4Tp7c6gNvqs_NCc-Grl_A-1
X-Mimecast-MFC-AGG-ID: X4Tp7c6gNvqs_NCc-Grl_A_1759164823
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DA35195608A; Mon, 29 Sep 2025 16:53:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA0911800446; Mon, 29 Sep 2025 16:53:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/32] hw/arm/aspeed: Move aspeed_load_vbootrom to common SoC
 code
Date: Mon, 29 Sep 2025 18:52:28 +0200
Message-ID: <20250929165230.797471-31-clg@redhat.com>
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

Move the vbootrom loader helper into common SoC code so it can be reused
by all ASPEED boards, and decouple the API from AspeedMachineState.

Specifically:
- Move aspeed_load_vbootrom() to hw/arm/aspeed_soc_common.c and
declare it in include/hw/arm/aspeed_soc.h.
- Change the helper’s signature to take AspeedSoCState * instead of
AspeedMachineState *.
- Update aspeed_machine_init() call sites accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  4 ++++
 hw/arm/aspeed.c             | 31 +------------------------------
 hw/arm/aspeed_soc_common.c  | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index aea210a8e2ec..ed32efb543f4 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -43,6 +43,8 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
 
+#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
+
 #define ASPEED_SPIS_NUM  3
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
@@ -316,6 +318,8 @@ void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
                            Error **errp);
 void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
                              MemoryRegion *boot_rom, uint64_t rom_size);
+void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
+                          Error **errp);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 429f4c6d7781..6046ec0bb2a2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -26,9 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "system/block-backend.h"
 #include "system/reset.h"
-#include "hw/loader.h"
 #include "qemu/error-report.h"
-#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
 #include "system/system.h"
@@ -263,33 +261,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
-
-/*
- * This function locates the vbootrom image file specified via the command line
- * using the -bios option. It loads the specified image into the vbootrom
- * memory region and handles errors if the file cannot be found or loaded.
- */
-static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
-                                 Error **errp)
-{
-    g_autofree char *filename = NULL;
-    AspeedSoCState *soc = bmc->soc;
-    int ret;
-
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (!filename) {
-        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
-        return;
-    }
-
-    ret = load_image_mr(filename, &soc->vbootrom);
-    if (ret < 0) {
-        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
-        return;
-    }
-}
-
 static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
                                bool boot_emmc)
 {
@@ -451,7 +422,7 @@ static void aspeed_machine_init(MachineState *machine)
 
     if (amc->vbootrom) {
         bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
-        aspeed_load_vbootrom(bmc, bios_name, &error_abort);
+        aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
     }
 
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 7f104f8de517..bc70e864fba7 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -19,6 +19,7 @@
 #include "system/blockdev.h"
 #include "system/block-backend.h"
 #include "hw/loader.h"
+#include "qemu/datadir.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
@@ -195,6 +196,30 @@ void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
                           &error_abort);
 }
 
+/*
+ * This function locates the vbootrom image file specified via the command line
+ * using the -bios option. It loads the specified image into the vbootrom
+ * memory region and handles errors if the file cannot be found or loaded.
+ */
+void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
+                          Error **errp)
+{
+    g_autofree char *filename = NULL;
+    int ret;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
+        return;
+    }
+
+    ret = load_image_mr(filename, &soc->vbootrom);
+    if (ret < 0) {
+        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
+        return;
+    }
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.51.0


