Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE55CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d45-0005Xt-9s; Fri, 03 Oct 2025 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d3w-0005XM-VM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d3m-0004E2-FL
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=71UmFcRBVHAAOboEh5c10f3jv9aQCq84rqg/90LDDdc=;
 b=Z+xK7Pk23egCpzOZ7a+e8gZBFUniDTCU5M3kwiImSW+djEcC97QQRNbES0lbWqQ7n/vLbU
 AjRQcwixxPQumnaE5gElx0GqucBMYm3a5TBN1Yp4D7vQwjIr84ZptQkdtZ8cgBKQHCJtRx
 sXA/w+kuOv0GhsQ8BpqBg3yyjh8MYUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-m0EGy2LeMu2RfUPpJgbMwA-1; Fri,
 03 Oct 2025 06:30:34 -0400
X-MC-Unique: m0EGy2LeMu2RfUPpJgbMwA-1
X-Mimecast-MFC-AGG-ID: m0EGy2LeMu2RfUPpJgbMwA_1759487432
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D67180045C; Fri,  3 Oct 2025 10:30:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2A061800576; Fri,  3 Oct 2025 10:30:27 +0000 (UTC)
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
Subject: [PATCH v2] aspeed: Don't set 'auto_create_sdcard'
Date: Fri,  3 Oct 2025 12:30:24 +0200
Message-ID: <20251003103024.1863551-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The Aspeed machines inherited from a 'no_sdcard' attribute when first
introduced in QEMU. This attribute was later renamed to
'auto_create_sdcard' by commit cdc8d7cadaac ("hw/boards: Rename
no_sdcard -> auto_create_sdcard") and set to 'true'. This has the
indesirable efect to automatically create SD cards at init time.

Remove 'auto_create_sdcard' to avoid creating a SD card device.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250930142448.1030476-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6046ec0bb2a2..58cfbc713794 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1418,7 +1418,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1436,7 +1435,6 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1455,7 +1453,6 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1474,7 +1471,6 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1492,7 +1488,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1511,7 +1506,6 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1529,7 +1523,6 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1548,7 +1541,6 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1566,7 +1558,6 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1584,7 +1575,6 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1606,7 +1596,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1625,7 +1614,6 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1644,7 +1632,6 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1663,7 +1650,6 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1686,7 +1672,6 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1708,7 +1693,6 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1728,7 +1712,6 @@ static void aspeed_machine_catalina_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = catalina_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1796,7 +1779,6 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
-    mc->auto_create_sdcard = true;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1909,7 +1891,6 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1932,7 +1913,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1953,7 +1933,6 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1973,7 +1952,6 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
-- 
2.51.0


