Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC89AD591D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 07:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDIRG-0006SR-Of; Tue, 19 Nov 2024 02:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDIRF-0006Ri-3u
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 02:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDIRC-0006rO-H6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 02:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732000452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lfVWciJ5XWrCsZ/jTE6GO+DmnVLkUEBcKy04Nc6alps=;
 b=P/E5SuO91tIKsFxEby2x41ZDJGgbA0N922+vmPDsK4B581mCf5vepD7Bjcs2+UG5pUe4o/
 gO0B87lyxxIRPyGnoZbCzRBx8YRiKVl+R3MCmVzt017vWJplhXpFn0J+GbOC33cGleGRfq
 iNn2iFOTkkf/Nqg2lRgK/LT4tMXu3Kk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-swZxrtGdPnyQKJAVk_FXYw-1; Tue,
 19 Nov 2024 02:14:08 -0500
X-MC-Unique: swZxrtGdPnyQKJAVk_FXYw-1
X-Mimecast-MFC-AGG-ID: swZxrtGdPnyQKJAVk_FXYw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8693E19560AE; Tue, 19 Nov 2024 07:14:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4431195DF81; Tue, 19 Nov 2024 07:13:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] arm: Remove tacoma-bmc machine
Date: Tue, 19 Nov 2024 08:13:52 +0100
Message-ID: <20241119071352.515790-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Removal was scheduled for 10.0. Use the rainier-bmc machine or the
ast2600-evb as a replacement.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst       |  8 --------
 docs/about/removed-features.rst | 10 ++++++++++
 docs/system/arm/aspeed.rst      |  1 -
 hw/arm/aspeed.c                 | 28 ----------------------------
 4 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d8dc29d0a4ee..267892b62f23 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -263,14 +263,6 @@ images are not available, OpenWRT dropped support in 2019, U-Boot in
 2017, Linux also is dropping support in 2024. It is time to let go of
 this ancient hardware and focus on newer CPUs and platforms.
 
-Arm ``tacoma-bmc`` machine (since 9.1)
-''''''''''''''''''''''''''''''''''''''''
-
-The ``tacoma-bmc`` machine was a board including an AST2600 SoC based
-BMC and a witherspoon like OpenPOWER system. It was used for bring up
-of the AST2600 SoC in labs.  It can be easily replaced by the
-``rainier-bmc`` machine which is a real product.
-
 Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines (since 9.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index ee6455aeeebe..9bebee795c0e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1019,6 +1019,16 @@ Aspeed ``swift-bmc`` machine (removed in 7.0)
 This machine was removed because it was unused. Alternative AST2500 based
 OpenPOWER machines are ``witherspoon-bmc`` and ``romulus-bmc``.
 
+Aspeed ``tacoma-bmc`` machine (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``tacoma-bmc`` machine was removed because it didn't bring much
+compared to the ``rainier-bmc`` machine. Also, the ``tacoma-bmc`` was
+a board used for bring up of the AST2600 SoC that never left the
+labs. It can be easily replaced by the ``rainier-bmc`` machine, which
+was the actual final product, or by the ``ast2600-evb`` with some
+tweaks.
+
 ppc ``taihu`` machine (removed in 7.2)
 '''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2e9ba12f7ae8..ab66ea6268fc 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -31,7 +31,6 @@ AST2500 SoC based machines :
 AST2600 SoC based machines :
 
 - ``ast2600-evb``          Aspeed AST2600 Evaluation board (Cortex-A7)
-- ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
 - ``rainier-bmc``          IBM Rainier POWER10 BMC
 - ``fuji-bmc``             Facebook Fuji BMC
 - ``bletchley-bmc``        Facebook Bletchley BMC
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6ca145362cbd..556498f2a061 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -185,10 +185,6 @@ struct AspeedMachineState {
 #define AST2700_EVB_HW_STRAP2 0x00000003
 #endif
 
-/* Tacoma hardware value */
-#define TACOMA_BMC_HW_STRAP1  0x00000000
-#define TACOMA_BMC_HW_STRAP2  0x00000040
-
 /* Rainier hardware value: (QEMU prototype) */
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
 #define RAINIER_BMC_HW_STRAP2 0x80000848
@@ -1425,26 +1421,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OpenPOWER Tacoma BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = TACOMA_BMC_HW_STRAP1;
-    amc->hw_strap2 = TACOMA_BMC_HW_STRAP2;
-    amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->macs_mask  = ASPEED_MAC2_ON;
-    amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-
-    mc->deprecation_reason = "Please use the similar 'rainier-bmc' machine";
-};
-
 static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1766,10 +1742,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("tacoma-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_tacoma_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.47.0


