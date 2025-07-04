Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0210C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbvp-0006hk-SD; Fri, 04 Jul 2025 04:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvn-0006g8-SG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvl-0004U6-1B
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2bbsQFGODvJUi7hyzlyVZ8gaZ2CaJ+2gOJB6Sy5CrI=;
 b=gs9wDBMdIkO2iJgLssEdUPbVaKhcW2/bEvYYlJkNl2QfOItLvTXdW6OT4fz3AmoMfBkDw0
 QoIl5dZxkUFre2Gxg11A5ELFdAw+nuS7mpzQzplFIl5PztlOEUa1nl9EqlV4AfMECUO2Jq
 2GEGrF7HBAbapBce30WWZFLRbVoDr3o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-wXaPMOaSOAOc0HnJVUfE4g-1; Fri,
 04 Jul 2025 04:37:55 -0400
X-MC-Unique: wXaPMOaSOAOc0HnJVUfE4g-1
X-Mimecast-MFC-AGG-ID: wXaPMOaSOAOc0HnJVUfE4g_1751618274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7DA1955EC1; Fri,  4 Jul 2025 08:37:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8956B18046C8; Fri,  4 Jul 2025 08:37:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Ed Tanous <etanous@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/11] hw/arm/aspeed: Add GB200 BMC target
Date: Fri,  4 Jul 2025 10:37:22 +0200
Message-ID: <20250704083723.1410455-11-clg@redhat.com>
In-Reply-To: <20250704083723.1410455-1-clg@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Ed Tanous <etanous@nvidia.com>

GB200nvl72 is a system for for accelerated compute.  This is a model for
the BMC target within the system.

This is based on the device tree aspeed-bmc-nvidia-gb200nvl-bmc.dts
from:

[1] https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts

Signed-off-by: Ed Tanous <etanous@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-4-etanous@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_eeprom.h |  3 ++
 hw/arm/aspeed.c        | 78 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c | 21 ++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index f08c16ef5062..3ed9bc1d9a82 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -26,4 +26,7 @@ extern const size_t rainier_bb_fruid_len;
 extern const uint8_t rainier_bmc_fruid[];
 extern const size_t rainier_bmc_fruid_len;
 
+extern const uint8_t gb200nvl_bmc_fruid[];
+extern const size_t gb200nvl_bmc_fruid_len;
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8d7757e11f1c..c31bbe770138 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -201,6 +201,10 @@ struct AspeedMachineState {
 #define BLETCHLEY_BMC_HW_STRAP1 0x00002000
 #define BLETCHLEY_BMC_HW_STRAP2 0x00000801
 
+/* GB200NVL hardware value */
+#define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
+#define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
+
 /* Qualcomm DC-SCM hardware value */
 #define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
 #define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
@@ -647,6 +651,12 @@ static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9552, addr);
 }
 
+static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
+{
+    return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
+                            TYPE_PCA9554, addr);
+}
+
 static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1226,6 +1236,45 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
 }
 
+
+static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[15] = {};
+    DeviceState *dev;
+    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
+        if ((i == 11) || (i == 12) || (i == 13)) {
+            continue;
+        }
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Bus 5 Expander */
+    create_pca9554(soc, 4, 0x21);
+
+    /* Mux I2c Expanders */
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
+
+    /* Bus 10 */
+    dev = DEVICE(create_pca9554(soc, 9, 0x20));
+
+    /* Set FPGA_READY */
+    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
+
+    create_pca9554(soc, 9, 0x21);
+    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
+    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
+
+    /* Bus 11 */
+    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
+                          gb200nvl_bmc_fruid_len);
+}
+
 static void fby35_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1782,6 +1831,31 @@ static void aspeed_machine_catalina_class_init(ObjectClass *oc,
     aspeed_machine_ast2600_class_emmc_init(oc);
 }
 
+#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
+
+static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
+    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66u51235f";
+    amc->spi_model = "mx66u51235f";
+    amc->num_cs    = 2;
+
+    amc->spi2_model = "mx66u51235f";
+    amc->num_cs2   = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = gb200nvl_bmc_i2c_init;
+    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+}
+
 static void fby35_reset(MachineState *state, ResetType type)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(state);
@@ -2074,6 +2148,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_gb200nvl_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index daa3d329d10b..8bbbdec8349b 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -162,6 +162,25 @@ const uint8_t rainier_bmc_fruid[] = {
     0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
+const uint8_t gb200nvl_bmc_fruid[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
+    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
+    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
+    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
+    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
+    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
+    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
+    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
+    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
+    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
+    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
+    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
+    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+
+};
+
 const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
 const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
 const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
@@ -169,3 +188,5 @@ const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
 const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
 const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
 const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
+const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
+
-- 
2.50.0


