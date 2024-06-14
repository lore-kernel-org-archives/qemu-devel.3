Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6246C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1Le-0003FV-Fk; Fri, 14 Jun 2024 03:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lc-0003FD-FT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1La-0000lH-DY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVauzJlq/HXfFCqWNRACgoXKiJL7bsNX476B58kQzdU=;
 b=J0G86ugJfmUl/oLu9/5Nefk2HRKt6WGYVJ7O9wz1QkeQE2QgE/rCRcEPj72R1k/YVm9IhD
 5plKMjtey+gCyeuPeW8yIRPgGZpjF6RO6bFuWQGJVb8iJK1k7hkCLNCIAtlySMaXeRzPf4
 N6JymGOhwAK5l/nGiIqMw7AumPyA8RY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-i85xMG2PNrWzX6Mzy20GOg-1; Fri,
 14 Jun 2024 03:27:39 -0400
X-MC-Unique: i85xMG2PNrWzX6Mzy20GOg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2673F1956083; Fri, 14 Jun 2024 07:27:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7488B3000219; Fri, 14 Jun 2024 07:27:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 06/19] aspeed/sdmc: Add AST2700 support
Date: Fri, 14 Jun 2024 09:26:07 +0200
Message-ID: <20240614072620.1262053-7-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The SDRAM memory controller(DRAMC) controls the access to external
DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.

The DRAM memory controller of AST2700 is not backward compatible
to previous chips such AST2600, AST2500 and AST2400.

Max memory is now 8GiB on the AST2700. Introduce new
aspeed_2700_sdmc and class with read/write operation and
reset handlers.

Define DRAMC necessary protected registers and
unprotected registers for AST2700 and increase
the register set to 0x1000.

Add unlocked property to change controller protected status.

Incrementing the version of vmstate to 2.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_sdmc.h |   5 +-
 hw/misc/aspeed_sdmc.c         | 194 +++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index ec2d59a14f57..61c979583ae1 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
 #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
 #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
 #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
+#define TYPE_ASPEED_2700_SDMC TYPE_ASPEED_SDMC "-ast2700"
 
 /*
  * SDMC has 174 documented registers. In addition the u-boot device tree
@@ -29,7 +30,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
  * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
  * training.
  */
-#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
+#define ASPEED_SDMC_NR_REGS (0x1000 >> 2)
 
 struct AspeedSDMCState {
     /*< private >*/
@@ -41,6 +42,7 @@ struct AspeedSDMCState {
     uint32_t regs[ASPEED_SDMC_NR_REGS];
     uint64_t ram_size;
     uint64_t max_ram_size;
+    bool unlocked;
 };
 
 
@@ -51,6 +53,7 @@ struct AspeedSDMCClass {
     const uint64_t *valid_ram_sizes;
     uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
     void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
+    bool is_bus64bit;
 };
 
 #endif /* ASPEED_SDMC_H */
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 873d67c592d8..93e2e29ead87 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -27,6 +27,7 @@
 #define   PROT_SOFTLOCKED    0x00
 
 #define   PROT_KEY_UNLOCK     0xFC600309
+#define   PROT_2700_KEY_UNLOCK  0x1688A8A8
 #define   PROT_KEY_HARDLOCK   0xDEADDEAD /* AST2600 */
 
 /* Configuration Register */
@@ -54,6 +55,46 @@
 #define R_DRAM_TIME       (0x8c / 4)
 #define R_ECC_ERR_INJECT  (0xb4 / 4)
 
+/* AST2700 Register */
+#define R_2700_PROT                 (0x00 / 4)
+#define R_INT_STATUS                (0x04 / 4)
+#define R_INT_CLEAR                 (0x08 / 4)
+#define R_INT_MASK                  (0x0c / 4)
+#define R_MAIN_CONF                 (0x10 / 4)
+#define R_MAIN_CONTROL              (0x14 / 4)
+#define R_MAIN_STATUS               (0x18 / 4)
+#define R_ERR_STATUS                (0x1c / 4)
+#define R_ECC_FAIL_STATUS           (0x78 / 4)
+#define R_ECC_FAIL_ADDR             (0x7c / 4)
+#define R_ECC_TESTING_CONTROL       (0x80 / 4)
+#define R_PROT_REGION_LOCK_STATUS   (0x94 / 4)
+#define R_TEST_FAIL_ADDR            (0xd4 / 4)
+#define R_TEST_FAIL_D0              (0xd8 / 4)
+#define R_TEST_FAIL_D1              (0xdc / 4)
+#define R_TEST_FAIL_D2              (0xe0 / 4)
+#define R_TEST_FAIL_D3              (0xe4 / 4)
+#define R_DBG_STATUS                (0xf4 / 4)
+#define R_PHY_INTERFACE_STATUS      (0xf8 / 4)
+#define R_GRAPHIC_MEM_BASE_ADDR     (0x10c / 4)
+#define R_PORT0_INTERFACE_MONITOR0  (0x240 / 4)
+#define R_PORT0_INTERFACE_MONITOR1  (0x244 / 4)
+#define R_PORT0_INTERFACE_MONITOR2  (0x248 / 4)
+#define R_PORT1_INTERFACE_MONITOR0  (0x2c0 / 4)
+#define R_PORT1_INTERFACE_MONITOR1  (0x2c4 / 4)
+#define R_PORT1_INTERFACE_MONITOR2  (0x2c8 / 4)
+#define R_PORT2_INTERFACE_MONITOR0  (0x340 / 4)
+#define R_PORT2_INTERFACE_MONITOR1  (0x344 / 4)
+#define R_PORT2_INTERFACE_MONITOR2  (0x348 / 4)
+#define R_PORT3_INTERFACE_MONITOR0  (0x3c0 / 4)
+#define R_PORT3_INTERFACE_MONITOR1  (0x3c4 / 4)
+#define R_PORT3_INTERFACE_MONITOR2  (0x3c8 / 4)
+#define R_PORT4_INTERFACE_MONITOR0  (0x440 / 4)
+#define R_PORT4_INTERFACE_MONITOR1  (0x444 / 4)
+#define R_PORT4_INTERFACE_MONITOR2  (0x448 / 4)
+#define R_PORT5_INTERFACE_MONITOR0  (0x4c0 / 4)
+#define R_PORT5_INTERFACE_MONITOR1  (0x4c4 / 4)
+#define R_PORT5_INTERFACE_MONITOR2  (0x4c8 / 4)
+
 /*
  * Configuration register Ox4 (for Aspeed AST2400 SOC)
  *
@@ -101,6 +142,19 @@
      ASPEED_SDMC_AST2500_RESERVED | ASPEED_SDMC_VGA_COMPAT |            \
      ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB))
 
+/*
+ * Main Configuration register Ox10 (for Aspeed AST2700 SOC and higher)
+ *
+ */
+#define ASPEED_SDMC_AST2700_RESERVED        0xFFFF2082 /* 31:16, 13, 7, 1 */
+#define ASPEED_SDMC_AST2700_DATA_SCRAMBLE           (1 << 8)
+#define ASPEED_SDMC_AST2700_ECC_ENABLE              (1 << 6)
+#define ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE    (1 << 5)
+#define ASPEED_SDMC_AST2700_DRAM_SIZE(x)            ((x & 0x7) << 2)
+
+#define ASPEED_SDMC_AST2700_READONLY_MASK   \
+     (ASPEED_SDMC_AST2700_RESERVED)
+
 static uint64_t aspeed_sdmc_read(void *opaque, hwaddr addr, unsigned size)
 {
     AspeedSDMCState *s = ASPEED_SDMC(opaque);
@@ -216,7 +270,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     AspeedSDMCState *s = ASPEED_SDMC(dev);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
-    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
+    assert(asc->max_ram_size < 4 * GiB || asc->is_bus64bit);
     s->max_ram_size = asc->max_ram_size;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
@@ -226,8 +280,8 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_sdmc = {
     .name = "aspeed.sdmc",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSDMCState, ASPEED_SDMC_NR_REGS),
         VMSTATE_END_OF_LIST()
@@ -236,6 +290,7 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
 
 static Property aspeed_sdmc_properties[] = {
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
+    DEFINE_PROP_BOOL("unlocked", AspeedSDMCState, unlocked, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -500,12 +555,145 @@ static const TypeInfo aspeed_2600_sdmc_info = {
     .class_init = aspeed_2600_sdmc_class_init,
 };
 
+static void aspeed_2700_sdmc_reset(DeviceState *dev)
+{
+    AspeedSDMCState *s = ASPEED_SDMC(dev);
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /* Set ram size bit and defaults values */
+    s->regs[R_MAIN_CONF] = asc->compute_conf(s, 0);
+
+    if (s->unlocked) {
+        s->regs[R_2700_PROT] = PROT_UNLOCKED;
+    }
+}
+
+static uint32_t aspeed_2700_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
+{
+    uint32_t fixed_conf = ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE |
+        ASPEED_SDMC_AST2700_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
+
+    /* Make sure readonly bits are kept */
+    data &= ~ASPEED_SDMC_AST2700_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2700_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    /* Unprotected registers */
+    switch (reg) {
+    case R_INT_STATUS:
+    case R_INT_CLEAR:
+    case R_INT_MASK:
+    case R_MAIN_STATUS:
+    case R_ERR_STATUS:
+    case R_ECC_FAIL_STATUS:
+    case R_ECC_FAIL_ADDR:
+    case R_PROT_REGION_LOCK_STATUS:
+    case R_TEST_FAIL_ADDR:
+    case R_TEST_FAIL_D0:
+    case R_TEST_FAIL_D1:
+    case R_TEST_FAIL_D2:
+    case R_TEST_FAIL_D3:
+    case R_DBG_STATUS:
+    case R_PHY_INTERFACE_STATUS:
+    case R_GRAPHIC_MEM_BASE_ADDR:
+    case R_PORT0_INTERFACE_MONITOR0:
+    case R_PORT0_INTERFACE_MONITOR1:
+    case R_PORT0_INTERFACE_MONITOR2:
+    case R_PORT1_INTERFACE_MONITOR0:
+    case R_PORT1_INTERFACE_MONITOR1:
+    case R_PORT1_INTERFACE_MONITOR2:
+    case R_PORT2_INTERFACE_MONITOR0:
+    case R_PORT2_INTERFACE_MONITOR1:
+    case R_PORT2_INTERFACE_MONITOR2:
+    case R_PORT3_INTERFACE_MONITOR0:
+    case R_PORT3_INTERFACE_MONITOR1:
+    case R_PORT3_INTERFACE_MONITOR2:
+    case R_PORT4_INTERFACE_MONITOR0:
+    case R_PORT4_INTERFACE_MONITOR1:
+    case R_PORT4_INTERFACE_MONITOR2:
+    case R_PORT5_INTERFACE_MONITOR0:
+    case R_PORT5_INTERFACE_MONITOR1:
+    case R_PORT5_INTERFACE_MONITOR2:
+        s->regs[reg] = data;
+        return;
+    }
+
+    if (s->regs[R_2700_PROT] == PROT_HARDLOCKED) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SDMC is locked until system reset!\n",
+                      __func__);
+        return;
+    }
+
+    if (reg != R_2700_PROT && s->regs[R_2700_PROT] == PROT_SOFTLOCKED) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SDMC is locked! (write to MCR%02x blocked)\n",
+                      __func__, reg * 4);
+        return;
+    }
+
+    switch (reg) {
+    case R_2700_PROT:
+        if (data == PROT_2700_KEY_UNLOCK)  {
+            data = PROT_UNLOCKED;
+        } else if (data == PROT_KEY_HARDLOCK) {
+            data = PROT_HARDLOCKED;
+        } else {
+            data = PROT_SOFTLOCKED;
+        }
+        break;
+    case R_MAIN_CONF:
+        data = aspeed_2700_sdmc_compute_conf(s, data);
+        break;
+    case R_MAIN_STATUS:
+        /* Will never return 'busy'. */
+        data &= ~PHY_BUSY_STATE;
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] = data;
+}
+
+static const uint64_t
+    aspeed_2700_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB,
+                                2048 * MiB, 4096 * MiB, 8192 * MiB, 0};
+
+static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 SDRAM Memory Controller";
+    dc->reset = aspeed_2700_sdmc_reset;
+
+    asc->is_bus64bit = true;
+    asc->max_ram_size = 8 * GiB;
+    asc->compute_conf = aspeed_2700_sdmc_compute_conf;
+    asc->write = aspeed_2700_sdmc_write;
+    asc->valid_ram_sizes = aspeed_2700_ram_sizes;
+}
+
+static const TypeInfo aspeed_2700_sdmc_info = {
+    .name = TYPE_ASPEED_2700_SDMC,
+    .parent = TYPE_ASPEED_SDMC,
+    .class_init = aspeed_2700_sdmc_class_init,
+};
+
 static void aspeed_sdmc_register_types(void)
 {
     type_register_static(&aspeed_sdmc_info);
     type_register_static(&aspeed_2400_sdmc_info);
     type_register_static(&aspeed_2500_sdmc_info);
     type_register_static(&aspeed_2600_sdmc_info);
+    type_register_static(&aspeed_2700_sdmc_info);
 }
 
 type_init(aspeed_sdmc_register_types);
-- 
2.45.2


