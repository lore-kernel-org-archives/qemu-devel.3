Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F109C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrrc-0005Yw-Ej; Mon, 05 May 2025 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnP-00087u-PZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnN-0006Nc-E4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyN8mO5eHNpryPzAY8OWo3baYhXDZOPGGteVl7+2vfg=;
 b=BJdiBTTaRU7HKGbqjDgU3iHD5Nc/FVFVxNKzdm/4dzgsv14sQW2m5Zq6Q58FY2rP+Dmlv6
 +Nz9Je+wq04Pu4M8Npd9oCqJ57k/0+Usf+FmP+ZZvJvjQoGaLiBEHQQj1iFzHFJa4EZCGa
 ftkNkFpRH+s22Q8ezITopJg17pIHc3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-lbhY_TUuM2CP0nyvZp3iFQ-1; Mon,
 05 May 2025 05:07:27 -0400
X-MC-Unique: lbhY_TUuM2CP0nyvZp3iFQ-1
X-Mimecast-MFC-AGG-ID: lbhY_TUuM2CP0nyvZp3iFQ_1746436046
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74AF51800360; Mon,  5 May 2025 09:07:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D086F30001A2; Mon,  5 May 2025 09:07:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/23] hw/intc/aspeed: Add support for AST2700 SSP INTC
Date: Mon,  5 May 2025 11:06:29 +0200
Message-ID: <20250505090635.778785-18-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Steven Lee <steven_lee@aspeedtech.com>

- Define new types for ast2700ssp INTC and INTCIO
- Add register definitions for SSP INTC and INTCIO
- Implement write handlers for SSP INTC and INTCIO
- Register new types in aspeed_intc_register_types

The design of the SSP INTC and INTCIO controllers is similar to
AST2700, with the following differences:

- AST2700
  Support GICINT128 to GICINT136 in INTC
  The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
    Bit 0 -> GIC 192
    Bit 1 -> GIC 193
    Bit 2 -> GIC 194
    Bit 3 -> GIC 195
    Bit 4 -> GIC 196

- AST2700-ssp
  Support SSPINT128 to SSPINT136 in INTC
  The INTCIO SSPINT_160_169 has 10 output pins, mapped as follows:
    Bit 0 -> SSPINT 160
    Bit 1 -> SSPINT 161
    Bit 2 -> SSPINT 162
    Bit 3 -> SSPINT 163
    Bit 4 -> SSPINT 164

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Ib8cb0e264505cef48e17f173e057f3b2d1ea35c4
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250502103449.3091642-4-steven_lee@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h |   3 +
 hw/intc/aspeed_intc.c         | 211 ++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 3727ba24be72..746f159bf335 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -15,6 +15,9 @@
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
+#define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
+#define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
+
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
 #define ASPEED_INTC_MAX_INPINS 10
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index be7f516a3b1b..e889246951f7 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -62,6 +62,50 @@ REG32(GICINT196_STATUS,     0x44)
 REG32(GICINT197_EN,         0x50)
 REG32(GICINT197_STATUS,     0x54)
 
+/*
+ * SSP INTC Registers
+ */
+REG32(SSPINT128_EN,             0x2000)
+REG32(SSPINT128_STATUS,         0x2004)
+REG32(SSPINT129_EN,             0x2100)
+REG32(SSPINT129_STATUS,         0x2104)
+REG32(SSPINT130_EN,             0x2200)
+REG32(SSPINT130_STATUS,         0x2204)
+REG32(SSPINT131_EN,             0x2300)
+REG32(SSPINT131_STATUS,         0x2304)
+REG32(SSPINT132_EN,             0x2400)
+REG32(SSPINT132_STATUS,         0x2404)
+REG32(SSPINT133_EN,             0x2500)
+REG32(SSPINT133_STATUS,         0x2504)
+REG32(SSPINT134_EN,             0x2600)
+REG32(SSPINT134_STATUS,         0x2604)
+REG32(SSPINT135_EN,             0x2700)
+REG32(SSPINT135_STATUS,         0x2704)
+REG32(SSPINT136_EN,             0x2800)
+REG32(SSPINT136_STATUS,         0x2804)
+REG32(SSPINT137_EN,             0x2900)
+REG32(SSPINT137_STATUS,         0x2904)
+REG32(SSPINT138_EN,             0x2A00)
+REG32(SSPINT138_STATUS,         0x2A04)
+REG32(SSPINT160_169_EN,         0x2B00)
+REG32(SSPINT160_169_STATUS,     0x2B04)
+
+/*
+ * SSP INTCIO Registers
+ */
+REG32(SSPINT160_EN,         0x180)
+REG32(SSPINT160_STATUS,     0x184)
+REG32(SSPINT161_EN,         0x190)
+REG32(SSPINT161_STATUS,     0x194)
+REG32(SSPINT162_EN,         0x1A0)
+REG32(SSPINT162_STATUS,     0x1A4)
+REG32(SSPINT163_EN,         0x1B0)
+REG32(SSPINT163_STATUS,     0x1B4)
+REG32(SSPINT164_EN,         0x1C0)
+REG32(SSPINT164_STATUS,     0x1C4)
+REG32(SSPINT165_EN,         0x1D0)
+REG32(SSPINT165_STATUS,     0x1D4)
+
 static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
                                                 uint32_t reg)
 {
@@ -450,6 +494,50 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     }
 }
 
+static void aspeed_ssp_intc_write(void *opaque, hwaddr offset, uint64_t data,
+                                        unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
+    uint32_t reg = offset >> 2;
+
+    trace_aspeed_intc_write(name, offset, size, data);
+
+    switch (reg) {
+    case R_SSPINT128_EN:
+    case R_SSPINT129_EN:
+    case R_SSPINT130_EN:
+    case R_SSPINT131_EN:
+    case R_SSPINT132_EN:
+    case R_SSPINT133_EN:
+    case R_SSPINT134_EN:
+    case R_SSPINT135_EN:
+    case R_SSPINT136_EN:
+    case R_SSPINT160_169_EN:
+        aspeed_intc_enable_handler(s, offset, data);
+        break;
+    case R_SSPINT128_STATUS:
+    case R_SSPINT129_STATUS:
+    case R_SSPINT130_STATUS:
+    case R_SSPINT131_STATUS:
+    case R_SSPINT132_STATUS:
+    case R_SSPINT133_STATUS:
+    case R_SSPINT134_STATUS:
+    case R_SSPINT135_STATUS:
+    case R_SSPINT136_STATUS:
+        aspeed_intc_status_handler(s, offset, data);
+        break;
+    case R_SSPINT160_169_STATUS:
+        aspeed_intc_status_handler_multi_outpins(s, offset, data);
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+
+    return;
+}
+
 static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
                                    unsigned int size)
 {
@@ -496,6 +584,39 @@ static void aspeed_intcio_write(void *opaque, hwaddr offset, uint64_t data,
     }
 }
 
+static void aspeed_ssp_intcio_write(void *opaque, hwaddr offset, uint64_t data,
+                                unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
+    uint32_t reg = offset >> 2;
+
+    trace_aspeed_intc_write(name, offset, size, data);
+
+    switch (reg) {
+    case R_SSPINT160_EN:
+    case R_SSPINT161_EN:
+    case R_SSPINT162_EN:
+    case R_SSPINT163_EN:
+    case R_SSPINT164_EN:
+    case R_SSPINT165_EN:
+        aspeed_intc_enable_handler(s, offset, data);
+        break;
+    case R_SSPINT160_STATUS:
+    case R_SSPINT161_STATUS:
+    case R_SSPINT162_STATUS:
+    case R_SSPINT163_STATUS:
+    case R_SSPINT164_STATUS:
+    case R_SSPINT165_STATUS:
+        aspeed_intc_status_handler(s, offset, data);
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+
+    return;
+}
 
 static const MemoryRegionOps aspeed_intc_ops = {
     .read = aspeed_intc_read,
@@ -517,6 +638,26 @@ static const MemoryRegionOps aspeed_intcio_ops = {
     }
 };
 
+static const MemoryRegionOps aspeed_ssp_intc_ops = {
+    .read = aspeed_intc_read,
+    .write = aspeed_ssp_intc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static const MemoryRegionOps aspeed_ssp_intcio_ops = {
+    .read = aspeed_intcio_read,
+    .write = aspeed_ssp_intcio_write,
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
@@ -674,11 +815,81 @@ static const TypeInfo aspeed_2700_intcio_info = {
     .class_init = aspeed_2700_intcio_class_init,
 };
 
+static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},
+    {1, 10, 1, R_SSPINT128_EN, R_SSPINT128_STATUS},
+    {2, 11, 1, R_SSPINT129_EN, R_SSPINT129_STATUS},
+    {3, 12, 1, R_SSPINT130_EN, R_SSPINT130_STATUS},
+    {4, 13, 1, R_SSPINT131_EN, R_SSPINT131_STATUS},
+    {5, 14, 1, R_SSPINT132_EN, R_SSPINT132_STATUS},
+    {6, 15, 1, R_SSPINT133_EN, R_SSPINT133_STATUS},
+    {7, 16, 1, R_SSPINT134_EN, R_SSPINT134_STATUS},
+    {8, 17, 1, R_SSPINT135_EN, R_SSPINT135_STATUS},
+    {9, 18, 1, R_SSPINT136_EN, R_SSPINT136_STATUS},
+};
+
+static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 SSP INTC Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 10;
+    aic->num_outpins = 19;
+    aic->mem_size = 0x4000;
+    aic->nr_regs = 0x2B08 >> 2;
+    aic->reg_offset = 0x0;
+    aic->reg_ops = &aspeed_ssp_intc_ops;
+    aic->irq_table = aspeed_2700ssp_intc_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700ssp_intc_irqs);
+}
+
+static const TypeInfo aspeed_2700ssp_intc_info = {
+    .name = TYPE_ASPEED_2700SSP_INTC,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700ssp_intc_class_init,
+};
+
+static AspeedINTCIRQ aspeed_2700ssp_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 1, R_SSPINT160_EN, R_SSPINT160_STATUS},
+    {1, 1, 1, R_SSPINT161_EN, R_SSPINT161_STATUS},
+    {2, 2, 1, R_SSPINT162_EN, R_SSPINT162_STATUS},
+    {3, 3, 1, R_SSPINT163_EN, R_SSPINT163_STATUS},
+    {4, 4, 1, R_SSPINT164_EN, R_SSPINT164_STATUS},
+    {5, 5, 1, R_SSPINT165_EN, R_SSPINT165_STATUS},
+};
+
+static void aspeed_2700ssp_intcio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 SSP INTC IO Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 6;
+    aic->num_outpins = 6;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x1d8 >> 2;
+    aic->reg_offset = 0;
+    aic->reg_ops = &aspeed_ssp_intcio_ops;
+    aic->irq_table = aspeed_2700ssp_intcio_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700ssp_intcio_irqs);
+}
+
+static const TypeInfo aspeed_2700ssp_intcio_info = {
+    .name = TYPE_ASPEED_2700SSP_INTCIO,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700ssp_intcio_class_init,
+};
+
 static void aspeed_intc_register_types(void)
 {
     type_register_static(&aspeed_intc_info);
     type_register_static(&aspeed_2700_intc_info);
     type_register_static(&aspeed_2700_intcio_info);
+    type_register_static(&aspeed_2700ssp_intc_info);
+    type_register_static(&aspeed_2700ssp_intcio_info);
 }
 
 type_init(aspeed_intc_register_types);
-- 
2.49.0


