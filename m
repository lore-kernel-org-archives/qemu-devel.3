Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E1CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSs6-000211-8j; Mon, 08 Jun 2026 01:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrX-0001YY-Qs
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrV-0000Z2-Vs
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNdM16FWNbr7TVbxZ52lQx341yc8VjhPTKPcYHWqqDg=;
 b=Kxg1eZSp7Hx/fdBah8GXH8l8nF/9yZ21BTS/ovzdejKoKuCkTUCe0A0bdmiVTi6mIOz0Sl
 s1sG7xYN+xZNftBXg9J7XSENOS8ju4FCxBZCN802X1jCJWObE1VUnXBaPqm4zPVhxTPS0A
 FtA2pr/7gdYJQs+XVT4zakWFLxpVWZ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-kOOmblXtP7Sql1cr-AeMcw-1; Mon,
 08 Jun 2026 01:49:24 -0400
X-MC-Unique: kOOmblXtP7Sql1cr-AeMcw-1
X-Mimecast-MFC-AGG-ID: kOOmblXtP7Sql1cr-AeMcw_1780897763
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECA261956059; Mon,  8 Jun 2026 05:49:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6099427A; Mon,  8 Jun 2026 05:49:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/37] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size and
 adjust offset
Date: Mon,  8 Jun 2026 07:48:15 +0200
Message-ID: <20260608054826.346488-27-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Update the AST2700 I2C buffer mode configuration to match
the latest firmware definition:
- Increase buffer mode pool size from 0x20 to 0x40
- Adjust buffer mode base offset to 0x1c0

Since the buffer mode region size changes, the migration state
layout is also modified. Bump the VMState version numbers to
prevent incompatible migration between old and new machine states.

Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST2700 support")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  2 +-
 hw/i2c/aspeed_i2c.c         | 46 ++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 1fc229f69919..b2e4d2fb9dcb 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -35,7 +35,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 
 #define ASPEED_I2C_NR_BUSSES 16
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
-#define ASPEED_I2C_BUS_POOL_SIZE 0x20
+#define ASPEED_I2C_BUS_POOL_SIZE 0x40
 #define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)
 
 #define A_I2CD_M_STOP_CMD       BIT(5)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 9d4e72c8585e..856d5dc1db64 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1132,8 +1132,8 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
 
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 7,
-    .minimum_version_id = 6,
+    .version_id = 8,
+    .minimum_version_id = 8,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
         VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),
@@ -1145,8 +1145,8 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
 
 static const VMStateDescription aspeed_i2c_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intr_status, AspeedI2CState),
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
@@ -1250,37 +1250,37 @@ static void aspeed_i2c_instance_init(Object *obj)
  * Address Definitions (AST2700)
  *   0x000 ... 0x0FF: Global Register
  *   0x100 ... 0x19F: Device 0
- *   0x1A0 ... 0x1BF: Device 0 buffer
+ *   0x1C0 ... 0x1FF: Device 0 buffer
  *   0x200 ... 0x29F: Device 1
- *   0x2A0 ... 0x2BF: Device 1 buffer
+ *   0x2C0 ... 0x2FF: Device 1 buffer
  *   0x300 ... 0x39F: Device 2
- *   0x3A0 ... 0x3BF: Device 2 buffer
+ *   0x3C0 ... 0x3FF: Device 2 buffer
  *   0x400 ... 0x49F: Device 3
- *   0x4A0 ... 0x4BF: Device 3 buffer
+ *   0x4C0 ... 0x4FF: Device 3 buffer
  *   0x500 ... 0x59F: Device 4
- *   0x5A0 ... 0x5BF: Device 4 buffer
+ *   0x5C0 ... 0x5FF: Device 4 buffer
  *   0x600 ... 0x69F: Device 5
- *   0x6A0 ... 0x6BF: Device 5 buffer
+ *   0x6C0 ... 0x6FF: Device 5 buffer
  *   0x700 ... 0x79F: Device 6
- *   0x7A0 ... 0x7BF: Device 6 buffer
+ *   0x7C0 ... 0x7FF: Device 6 buffer
  *   0x800 ... 0x89F: Device 7
- *   0x8A0 ... 0x8BF: Device 7 buffer
+ *   0x8C0 ... 0x8FF: Device 7 buffer
  *   0x900 ... 0x99F: Device 8
- *   0x9A0 ... 0x9BF: Device 8 buffer
+ *   0x9C0 ... 0x9FF: Device 8 buffer
  *   0xA00 ... 0xA9F: Device 9
- *   0xAA0 ... 0xABF: Device 9 buffer
+ *   0xAC0 ... 0xAFF: Device 9 buffer
  *   0xB00 ... 0xB9F: Device 10
- *   0xBA0 ... 0xBBF: Device 10 buffer
+ *   0xBC0 ... 0xBFF: Device 10 buffer
  *   0xC00 ... 0xC9F: Device 11
- *   0xCA0 ... 0xCBF: Device 11 buffer
+ *   0xCC0 ... 0xCFF: Device 11 buffer
  *   0xD00 ... 0xD9F: Device 12
- *   0xDA0 ... 0xDBF: Device 12 buffer
+ *   0xDC0 ... 0xDFF: Device 12 buffer
  *   0xE00 ... 0xE9F: Device 13
- *   0xEA0 ... 0xEBF: Device 13 buffer
+ *   0xEC0 ... 0xEFF: Device 13 buffer
  *   0xF00 ... 0xF9F: Device 14
- *   0xFA0 ... 0xFBF: Device 14 buffer
+ *   0xFC0 ... 0xFFF: Device 14 buffer
  *   0x1000 ... 0x109F: Device 15
- *   0x10A0 ... 0x10BF: Device 15 buffer
+ *   0x10C0 ... 0x10BF: Device 15 buffer
  */
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 {
@@ -1666,9 +1666,9 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
     aic->reg_gap_size = 0x60;
     aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
-    aic->pool_size = 0x20;
-    aic->pool_gap_size = 0xe0;
-    aic->pool_base = 0x1a0;
+    aic->pool_size = 0x40;
+    aic->pool_gap_size = 0xc0;
+    aic->pool_base = 0x1c0;
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x2000;
-- 
2.54.0


