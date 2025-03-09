Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B213C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5o-0002XR-UX; Sun, 09 Mar 2025 09:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5Z-0001ZK-BO
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5W-0003vK-JJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93oC26XmqibhZHwyuuMatuqVW8WjpFxwoG9WKju+BqI=;
 b=IuKMhbzTRwuqnfpcOxR6J3Sm70XppiiY9ULtYgef11O96nlVFnS1028wuYVDugaGJEfFH8
 ktwfMQSweqlTeG8sbwb/2H4If5vaincSqqcCZQdNrso7JAMUPe8ePb0sNDGfVIij9G8Usn
 4dV2h59cgywVla5PXRwWW1bXIOyt+ro=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-0gFepZ_tPHilFGr4WmNgww-1; Sun,
 09 Mar 2025 09:53:02 -0400
X-MC-Unique: 0gFepZ_tPHilFGr4WmNgww-1
X-Mimecast-MFC-AGG-ID: 0gFepZ_tPHilFGr4WmNgww_1741528381
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5379180025C; Sun,  9 Mar 2025 13:53:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2335B1956094; Sun,  9 Mar 2025 13:52:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/46] hw/intc/aspeed: Add Support for AST2700 INTCIO Controller
Date: Sun,  9 Mar 2025 14:51:18 +0100
Message-ID: <20250309135130.545764-35-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a new ast2700 INTCIO class to support AST2700 INTCIO.
Added new register definitions for INTCIO, including enable and status
registers for IRQs GICINT192 through GICINT197.
Created a dedicated IRQ array for INTCIO, supporting six input pins and six
output pins, aligning with the newly defined registers.
Implemented "aspeed_intcio_read" and "aspeed_intcio_write" to handle
INTCIO-specific register access.

 To GICINT196                                                                                |

       ETH1    |-----------|                    |--------------------------|
      -------->|0          |                    |         INTCIO           |
       ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|
      -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|
       ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|
      -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|
       UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|
      -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|
       UART1   |         22|                    |--------------------------|
      -------->|8        23|
       UART2   |         24|
      -------->|9        25|
       UART3   |         26|
      ---------|10       27|
       UART5   |         28|
      -------->|11       29|
       UART6   |           |
      -------->|12       30|
       UART7   |         31|
      -------->|13         |
       UART8   |  OR[0:31] |
      -------->|14         |
       UART9   |           |
      -------->|15         |
       UART10  |           |
      -------->|16         |
       UART11  |           |
      -------->|17         |
       UART12  |           |
      -------->|18         |
               |-----------|

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-18-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h |   1 +
 hw/intc/aspeed_intc.c         | 112 ++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 85df8c6be94f..3727ba24be72 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -14,6 +14,7 @@
 
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
+#define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
 #define ASPEED_INTC_MAX_INPINS 10
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index f2ca9237ea9a..3fd417084f5b 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -42,6 +42,26 @@ REG32(GICINT136_STATUS,     0x804)
 REG32(GICINT192_201_EN,         0xB00)
 REG32(GICINT192_201_STATUS,     0xB04)
 
+/*
+ * INTCIO Registers
+ *
+ * values below are offset by - 0x100 from datasheet
+ * because its memory region is start at 0x100
+ *
+ */
+REG32(GICINT192_EN,         0x00)
+REG32(GICINT192_STATUS,     0x04)
+REG32(GICINT193_EN,         0x10)
+REG32(GICINT193_STATUS,     0x14)
+REG32(GICINT194_EN,         0x20)
+REG32(GICINT194_STATUS,     0x24)
+REG32(GICINT195_EN,         0x30)
+REG32(GICINT195_STATUS,     0x34)
+REG32(GICINT196_EN,         0x40)
+REG32(GICINT196_STATUS,     0x44)
+REG32(GICINT197_EN,         0x50)
+REG32(GICINT197_STATUS,     0x54)
+
 static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
                                                 uint32_t reg)
 {
@@ -432,6 +452,55 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     return;
 }
 
+static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
+                                   unsigned int size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
+    uint32_t reg = offset >> 2;
+    uint32_t value = 0;
+
+    value = s->regs[reg];
+    trace_aspeed_intc_read(name, offset, size, value);
+
+    return value;
+}
+
+static void aspeed_intcio_write(void *opaque, hwaddr offset, uint64_t data,
+                                unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
+    uint32_t reg = offset >> 2;
+
+    trace_aspeed_intc_write(name, offset, size, data);
+
+    switch (reg) {
+    case R_GICINT192_EN:
+    case R_GICINT193_EN:
+    case R_GICINT194_EN:
+    case R_GICINT195_EN:
+    case R_GICINT196_EN:
+    case R_GICINT197_EN:
+        aspeed_intc_enable_handler(s, offset, data);
+        break;
+    case R_GICINT192_STATUS:
+    case R_GICINT193_STATUS:
+    case R_GICINT194_STATUS:
+    case R_GICINT195_STATUS:
+    case R_GICINT196_STATUS:
+    case R_GICINT197_STATUS:
+        aspeed_intc_status_handler(s, offset, data);
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+
+    return;
+}
+
+
 static const MemoryRegionOps aspeed_intc_ops = {
     .read = aspeed_intc_read,
     .write = aspeed_intc_write,
@@ -442,6 +511,16 @@ static const MemoryRegionOps aspeed_intc_ops = {
     }
 };
 
+static const MemoryRegionOps aspeed_intcio_ops = {
+    .read = aspeed_intcio_read,
+    .write = aspeed_intcio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
 static void aspeed_intc_instance_init(Object *obj)
 {
     AspeedINTCState *s = ASPEED_INTC(obj);
@@ -567,10 +646,43 @@ static const TypeInfo aspeed_2700_intc_info = {
     .class_init = aspeed_2700_intc_class_init,
 };
 
+static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
+    {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
+    {2, 2, 1, R_GICINT194_EN, R_GICINT194_STATUS},
+    {3, 3, 1, R_GICINT195_EN, R_GICINT195_STATUS},
+    {4, 4, 1, R_GICINT196_EN, R_GICINT196_STATUS},
+    {5, 5, 1, R_GICINT197_EN, R_GICINT197_STATUS},
+};
+
+static void aspeed_2700_intcio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 INTC IO Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 6;
+    aic->num_outpins = 6;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x58 >> 2;
+    aic->reg_offset = 0x100;
+    aic->reg_ops = &aspeed_intcio_ops;
+    aic->irq_table = aspeed_2700_intcio_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcio_irqs);
+}
+
+static const TypeInfo aspeed_2700_intcio_info = {
+    .name = TYPE_ASPEED_2700_INTCIO,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intcio_class_init,
+};
+
 static void aspeed_intc_register_types(void)
 {
     type_register_static(&aspeed_intc_info);
     type_register_static(&aspeed_2700_intc_info);
+    type_register_static(&aspeed_2700_intcio_info);
 }
 
 type_init(aspeed_intc_register_types);
-- 
2.48.1


