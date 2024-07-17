Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9907C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTyBo-0006A0-Ft; Wed, 17 Jul 2024 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyBj-0005oy-8p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyBh-0002xs-QH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721197852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QZoUUVcnKJ2D/VFCs+20/ZqOIheN3b4TVFT74qsvEQ=;
 b=dhUTbzQm8J93O5dylyiDVq82U99vOB1NsmexLwMMX0d5QEyVU85KtCcaNLGkPTWuAqM4sa
 s4FuQtcmJhibDNUoSUGXBGB4/EDMkQO0GGYNoY49dk+X6olwCuYtiJ/V7gjTX9gduhXJBt
 p8uDGTDYkoBcikhLNpj64CxdTCE+TJQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-ooB9s5v6Oe625-IdIzcnwQ-1; Wed,
 17 Jul 2024 02:30:46 -0400
X-MC-Unique: ooB9s5v6Oe625-IdIzcnwQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DC6A1955D4A; Wed, 17 Jul 2024 06:30:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CF941955F65; Wed, 17 Jul 2024 06:30:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/8] aspeed: Load eMMC first boot area as a boot rom
Date: Wed, 17 Jul 2024 08:30:16 +0200
Message-ID: <20240717063022.549849-3-clg@redhat.com>
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

The first boot area partition (64K) of the eMMC device should contain
an initial boot loader (u-boot SPL). Load it as a ROM only if an eMMC
device is available to boot from but no flash device is.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/arm/aspeed.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 105b990233fa..756deb91efd1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -364,6 +364,7 @@ static void aspeed_machine_init(MachineState *machine)
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
     AspeedSoCClass *sc;
     int i;
+    DriveInfo *emmc0 = NULL;
 
     bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
@@ -440,9 +441,8 @@ static void aspeed_machine_init(MachineState *machine)
     }
 
     if (bmc->soc->emmc.num_slots) {
-        sdhci_attach_drive(&bmc->soc->emmc.slots[0],
-                           drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots),
-                           true);
+        emmc0 = drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots);
+        sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true);
     }
 
     if (!bmc->mmio_exec) {
@@ -452,6 +452,8 @@ static void aspeed_machine_init(MachineState *machine)
         if (fmc0) {
             uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
             aspeed_install_boot_rom(bmc, fmc0, rom_size);
+        } else if (emmc0) {
+            aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(emmc0), 64 * KiB);
         }
     }
 
-- 
2.45.2


