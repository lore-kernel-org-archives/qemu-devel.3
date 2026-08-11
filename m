Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D13C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNh-0001KS-Op; Tue, 11 Aug 2026 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNV-0000Zn-TV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNT-0000iD-CO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TlJ5uLE8Bvis6TmXPlTY38yDOEYbZWVcEVHGfqiIyI=;
 b=ETkOwvRyPkMOVUQp+pgI+A5P14G7e3VY+6+uaeP5qp+nXrQYb9gSWG4oEkPlPMBCOlwh+1
 KnFv3JONPzWIgAvNysyT7EwZ23n+BGOToweMgr5rKBCLQT4PtjHqNidpFcIrj3YBYNK/I/
 JlbvutsSeVCoNQ0SaKHVbAOp4aTzWts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-JtM_P1RbM-W16nXfcU3Rgw-1; Tue,
 11 Aug 2026 12:30:55 -0400
X-MC-Unique: JtM_P1RbM-W16nXfcU3Rgw-1
X-Mimecast-MFC-AGG-ID: JtM_P1RbM-W16nXfcU3Rgw_1786465854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FA3E19560B3; Tue, 11 Aug 2026 16:30:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A54DE195DF98; Tue, 11 Aug 2026 16:30:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/83] hw/arm: anacapa: add ADC128D818 devices
Date: Tue, 11 Aug 2026 18:28:48 +0200
Message-ID: <20260811162938.1403216-34-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Wire up the two ADC128D818 instances that appear in the Anacapa DTS:
one on i2c8 mux channel 0 and one on i2c13 mux channel 3.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707091609.97759-9-emmanuel.blot@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_anacapa.c | 21 +++++++++++++++++----
 hw/arm/Kconfig                  |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index bd6cc0068602..65d6b0faa2de 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -1,13 +1,14 @@
 /*
  * Facebook Anacapa
  *
- * Copyright (c) Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/sensor/adc128d818.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
@@ -15,7 +16,6 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
 
-/* Anacapa hardware value */
 #define ANACAPA_BMC_HW_STRAP1 0x00002002
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
 #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
@@ -221,6 +221,17 @@ static const uint8_t hpm_brd_id_eeprom[] = {
 };
 static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
 
+static void anacapa_add_adc128d818(I2CBus *bus, uint8_t addr,
+                                   const char *description)
+{
+    DeviceState *dev = DEVICE(i2c_slave_new(TYPE_ADC128D818, addr));
+    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
+
+    qdev_prop_set_string(dev, "description", description);
+    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
+}
+
 static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference: aspeed-bmc-facebook-anacapa.dts */
@@ -259,7 +270,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
-    /* adc128d818@1f - no model */
+    /* adc128d818@1f - R-PDB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -320,7 +332,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
-    /* adc128d818@1f - no model */
+    /* adc128d818@1f - MB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
 
     /* i2c13mux ch4 */
     /* eeprom@51 */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5869f0f9e895..c502e8284769 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -558,6 +558,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select ADC128D818
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
-- 
2.55.0


