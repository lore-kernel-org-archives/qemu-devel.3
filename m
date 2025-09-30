Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E144ACCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bIE-0003WH-Kp; Tue, 30 Sep 2025 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3bIC-0003Vm-If
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3bHx-0003Ba-S7
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759242303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tZ5Ysy5aelVtvjkhbK4uZaQ/sQIniAcLB7CInUkiE84=;
 b=XHdGasTka0q5wR+4G6P0dxSWKElMhVSJRkXYQo5LeXpigWGICCgJBMqrZEkY5dhIpq2KJu
 o1Hs9YUZakrQcaLQVgF9WN68tDZCOVUbd3keZ/a8GGi/ROlAYsq2tyC16XuIhHWgkP4PJ0
 FlEwU3l9TDeEzldtDPYFvE5344DmSGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-SZHfD-14PdOscC5W_VoyaA-1; Tue,
 30 Sep 2025 10:24:57 -0400
X-MC-Unique: SZHfD-14PdOscC5W_VoyaA-1
X-Mimecast-MFC-AGG-ID: SZHfD-14PdOscC5W_VoyaA_1759242296
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BF62195605B; Tue, 30 Sep 2025 14:24:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00B581801420; Tue, 30 Sep 2025 14:24:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] aspeed: Set 'auto_create_sdcard' to false
Date: Tue, 30 Sep 2025 16:24:48 +0200
Message-ID: <20250930142448.1030476-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Don't create a default SD card device at init time.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: cdc8d7cadaac ("hw/boards: Rename no_sdcard -> auto_create_sdcard")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a3659ffea475..0d1f043ac214 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1450,7 +1450,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1468,7 +1468,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1487,7 +1487,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1506,7 +1506,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1524,7 +1524,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1543,7 +1543,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1561,7 +1561,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1580,7 +1580,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1598,7 +1598,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1616,7 +1616,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1638,7 +1638,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1657,7 +1657,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1676,7 +1676,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1695,7 +1695,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1718,7 +1718,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1740,7 +1740,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1760,7 +1760,7 @@ static void aspeed_machine_catalina_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = catalina_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1828,7 +1828,7 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1941,7 +1941,7 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1964,7 +1964,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1985,7 +1985,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -2005,7 +2005,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->auto_create_sdcard = true;
+    mc->auto_create_sdcard = false;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
-- 
2.51.0


