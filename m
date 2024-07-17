Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB39C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTyC1-0007JR-PI; Wed, 17 Jul 2024 02:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyC0-000797-BV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyBy-00031G-Hl
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721197869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tg878PEggQ9yjP8hwvC2hflD3G9fDs60xIb0uRWaszE=;
 b=SSf3v7rXpQetKATst6ab8ta/JksW6f0b/bexKhimBvWH02yD8YhwUQNw/l+8bwubzmqFzI
 Zd+QFN+pkpWLR8w1X2FiYFRj4ALiOzQNqUO/PurtL782cJHyTooFXIZFt3Q5y2QE034VXQ
 kGRI3Mn4bkx7hZ45s1A3BSJEpdV1m9c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-mw6U6T1XOF2aY5gZCE7FXA-1; Wed,
 17 Jul 2024 02:31:02 -0400
X-MC-Unique: mw6U6T1XOF2aY5gZCE7FXA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4DD019560B6; Wed, 17 Jul 2024 06:31:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0092F19560B2; Wed, 17 Jul 2024 06:30:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 5/8] aspeed: Tune eMMC device properties to reflect HW
 strapping
Date: Wed, 17 Jul 2024 08:30:19 +0200
Message-ID: <20240717063022.549849-6-clg@redhat.com>
In-Reply-To: <20240717063022.549849-1-clg@redhat.com>
References: <20240717063022.549849-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
property to set the boot config register to boot from the first boot
area partition of the eMMC device. Also set the boot partition size
of the device.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/arm/aspeed.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 756deb91efd1..bc4ca1754213 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
-static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
+static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
+                               bool boot_emmc)
 {
         DeviceState *card;
 
@@ -335,6 +336,11 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc)
             return;
         }
         card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
+        if (emmc) {
+            qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
+            qdev_prop_set_uint8(card, "boot-config",
+                                boot_emmc ? 0x1 << 3 : 0x0);
+        }
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         qdev_realize_and_unref(card,
@@ -365,6 +371,7 @@ static void aspeed_machine_init(MachineState *machine)
     AspeedSoCClass *sc;
     int i;
     DriveInfo *emmc0 = NULL;
+    bool boot_emmc;
 
     bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
@@ -437,19 +444,21 @@ static void aspeed_machine_init(MachineState *machine)
 
     for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
         sdhci_attach_drive(&bmc->soc->sdhci.slots[i],
-                           drive_get(IF_SD, 0, i), false);
+                           drive_get(IF_SD, 0, i), false, false);
     }
 
+    boot_emmc = sc->boot_from_emmc(bmc->soc);
+
     if (bmc->soc->emmc.num_slots) {
         emmc0 = drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots);
-        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true);
+        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true, boot_emmc);
     }
 
     if (!bmc->mmio_exec) {
         DeviceState *dev = ssi_get_cs(bmc->soc->fmc.spi, 0);
         BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
 
-        if (fmc0) {
+        if (fmc0 && !boot_emmc) {
             uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
             aspeed_install_boot_rom(bmc, fmc0, rom_size);
         } else if (emmc0) {
-- 
2.45.2


