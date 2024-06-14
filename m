Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733FCC27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1La-0003ET-DI; Fri, 14 Jun 2024 03:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LY-0003Dp-O8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LW-0000ke-Um
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYWGjfqdWTHN73mpwY5Vg/n4nswDcBeE67iGIGD6bgk=;
 b=gHSmv0/VsOk2lrBKD9ekG+SLki0YPWNHb1J2ry/um6xSkmKEaG08+T2014MK4jWVROCp2E
 Uf4YJ9lBE6L8F/MIiHuXW1wQI7wuTFCbJwPLC77BcDKnm+vstFNFQIFUWdJHyPcgYsoMyn
 LJXNxduzBYq3ugmyVMXeB9uRI5R2yBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-bFlG5q9YMfGOxBAEzY7hWA-1; Fri,
 14 Jun 2024 03:27:31 -0400
X-MC-Unique: bFlG5q9YMfGOxBAEzY7hWA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAA9019560AB; Fri, 14 Jun 2024 07:27:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 815DB300021A; Fri, 14 Jun 2024 07:27:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 03/19] aspeed/sli: Add AST2700 support
Date: Fri, 14 Jun 2024 09:26:04 +0200
Message-ID: <20240614072620.1262053-4-clg@redhat.com>
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

AST2700 SLI engine is designed to accelerate the
throughput between cross-die connections.
It have CPU_SLI at CPU die and IO_SLI at IO die.

Introduce dummy AST2700 SLI and SLIIO models.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_sli.h |  27 ++++++
 hw/misc/aspeed_sli.c         | 177 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   3 +-
 hw/misc/trace-events         |   7 ++
 4 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/aspeed_sli.h
 create mode 100644 hw/misc/aspeed_sli.c

diff --git a/include/hw/misc/aspeed_sli.h b/include/hw/misc/aspeed_sli.h
new file mode 100644
index 000000000000..23f346ab934b
--- /dev/null
+++ b/include/hw/misc/aspeed_sli.h
@@ -0,0 +1,27 @@
+/*
+ * ASPEED SLI Controller
+ *
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_SLI_H
+#define ASPEED_SLI_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_SLI "aspeed.sli"
+#define TYPE_ASPEED_2700_SLI TYPE_ASPEED_SLI "-ast2700"
+#define TYPE_ASPEED_2700_SLIIO TYPE_ASPEED_SLI "io" "-ast2700"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedSLIState, ASPEED_SLI)
+
+#define ASPEED_SLI_NR_REGS  (0x500 >> 2)
+
+struct AspeedSLIState {
+    SysBusDevice parent;
+    MemoryRegion iomem;
+
+    uint32_t regs[ASPEED_SLI_NR_REGS];
+};
+
+#endif /* ASPEED_SLI_H */
diff --git a/hw/misc/aspeed_sli.c b/hw/misc/aspeed_sli.c
new file mode 100644
index 000000000000..fe720ead5094
--- /dev/null
+++ b/hw/misc/aspeed_sli.c
@@ -0,0 +1,177 @@
+/*
+ * ASPEED SLI Controller
+ *
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/aspeed_sli.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define SLI_REGION_SIZE 0x500
+#define TO_REG(addr) ((addr) >> 2)
+
+static uint64_t aspeed_sli_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    AspeedSLIState *s = ASPEED_SLI(opaque);
+    int reg = TO_REG(addr);
+
+    if (reg >= ARRAY_SIZE(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+    }
+
+    trace_aspeed_sli_read(addr, size, s->regs[reg]);
+    return s->regs[reg];
+}
+
+static void aspeed_sli_write(void *opaque, hwaddr addr, uint64_t data,
+                              unsigned int size)
+{
+    AspeedSLIState *s = ASPEED_SLI(opaque);
+    int reg = TO_REG(addr);
+
+    if (reg >= ARRAY_SIZE(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return;
+    }
+
+    trace_aspeed_sli_write(addr, size, data);
+    s->regs[reg] = data;
+}
+
+static uint64_t aspeed_sliio_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    AspeedSLIState *s = ASPEED_SLI(opaque);
+    int reg = TO_REG(addr);
+
+    if (reg >= ARRAY_SIZE(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+    }
+
+    trace_aspeed_sliio_read(addr, size, s->regs[reg]);
+    return s->regs[reg];
+}
+
+static void aspeed_sliio_write(void *opaque, hwaddr addr, uint64_t data,
+                              unsigned int size)
+{
+    AspeedSLIState *s = ASPEED_SLI(opaque);
+    int reg = TO_REG(addr);
+
+    if (reg >= ARRAY_SIZE(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return;
+    }
+
+    trace_aspeed_sliio_write(addr, size, data);
+    s->regs[reg] = data;
+}
+
+static const MemoryRegionOps aspeed_sli_ops = {
+    .read = aspeed_sli_read,
+    .write = aspeed_sli_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps aspeed_sliio_ops = {
+    .read = aspeed_sliio_read,
+    .write = aspeed_sliio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_sli_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSLIState *s = ASPEED_SLI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sli_ops, s,
+                          TYPE_ASPEED_SLI, SLI_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_sliio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSLIState *s = ASPEED_SLI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sliio_ops, s,
+                          TYPE_ASPEED_SLI, SLI_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_sli_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Aspeed SLI Controller";
+    dc->realize = aspeed_sli_realize;
+}
+
+static const TypeInfo aspeed_sli_info = {
+    .name          = TYPE_ASPEED_SLI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedSLIState),
+    .class_init    = aspeed_sli_class_init,
+    .abstract      = true,
+};
+
+static void aspeed_2700_sli_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "AST2700 SLI Controller";
+}
+
+static void aspeed_2700_sliio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "AST2700 I/O SLI Controller";
+    dc->realize = aspeed_sliio_realize;
+}
+
+static const TypeInfo aspeed_2700_sli_info = {
+    .name           = TYPE_ASPEED_2700_SLI,
+    .parent         = TYPE_ASPEED_SLI,
+    .class_init     = aspeed_2700_sli_class_init,
+};
+
+static const TypeInfo aspeed_2700_sliio_info = {
+    .name           = TYPE_ASPEED_2700_SLIIO,
+    .parent         = TYPE_ASPEED_SLI,
+    .class_init     = aspeed_2700_sliio_class_init,
+};
+
+static void aspeed_sli_register_types(void)
+{
+    type_register_static(&aspeed_sli_info);
+    type_register_static(&aspeed_2700_sli_info);
+    type_register_static(&aspeed_2700_sliio_info);
+}
+
+type_init(aspeed_sli_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 86596a388812..2ca8717be286 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -136,7 +136,8 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
   'aspeed_xdma.c',
-  'aspeed_peci.c'))
+  'aspeed_peci.c',
+  'aspeed_sli.c'))
 
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5d241cb40aab..e13b64822110 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -351,3 +351,10 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 # iosb.c
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+
+# aspeed_sli.c
+aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_sliio_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_sliio_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+
-- 
2.45.2


