Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FAAE95377
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBo-0001rJ-4N; Wed, 04 Feb 2026 05:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBg-0001aa-WA
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBc-00046O-V7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL55vYoNa94ka4HEiZ/wtz9mVM+3qKLm4cgwbFBku2Y=;
 b=AR2ZXfRLi/GWKm7lhexObcupI5zNfxeer0dwkWAUkRneo9bBDclzBSvGgwAjxHKBdsmI7I
 j3zbwn0C24cuL/MljGOINcLZfvrgLgPcjXzCXgINg1JqYnlk+Waa4jaWwHMsz70U/eGhXF
 pLSbQG7D7IyHWTKYfg04G9cqxAhyDjg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-bT6NNkzeNJKpS26DKn4sag-1; Wed,
 04 Feb 2026 05:32:38 -0500
X-MC-Unique: bT6NNkzeNJKpS26DKn4sag-1
X-Mimecast-MFC-AGG-ID: bT6NNkzeNJKpS26DKn4sag_1770201157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F38C18003F5; Wed,  4 Feb 2026 10:32:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C860818004AD; Wed,  4 Feb 2026 10:32:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 27/45] hw/arm/aspeed: Add AST1700 LTPI expander device model
Date: Wed,  4 Feb 2026 11:31:18 +0100
Message-ID: <20260204103136.1795455-28-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

Introduce a minimal QEMU device model for the ASPEED AST1700, an
MCU-less I/O expander used in the LTPI topology defined by the
DC-SCM 2.0 specification (see figure 2):
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf

This initial implementation includes:

* Definition of aspeed.ast1700 as a SysBusDevice

* Setup of a basic memory region to reserve I/O space for future
  peripheral modeling

This stub establishes the foundation for LTPI-related device emulation,
without implementing any functional peripherals at this stage.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-5-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h | 23 +++++++++++++++++
 hw/arm/aspeed_ast1700.c         | 46 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 include/hw/arm/aspeed_ast1700.h
 create mode 100644 hw/arm/aspeed_ast1700.c

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
new file mode 100644
index 000000000000..378dcb437a78
--- /dev/null
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -0,0 +1,23 @@
+/*
+ * ASPEED AST1700 IO Expander
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_AST1700_H
+#define ASPEED_AST1700_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_ASPEED_AST1700 "aspeed.ast1700"
+
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
+
+struct AspeedAST1700SoCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
new file mode 100644
index 000000000000..dd38b819b864
--- /dev/null
+++ b/hw/arm/aspeed_ast1700.c
@@ -0,0 +1,46 @@
+/*
+ * ASPEED AST1700 IO Expander
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/boards.h"
+#include "qom/object.h"
+#include "hw/arm/aspeed_ast1700.h"
+
+#define AST2700_SOC_LTPI_SIZE        0x01000000
+
+static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
+{
+    AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Occupy memory space for all controllers in AST1700 */
+    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
+                       AST2700_SOC_LTPI_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_ast1700_realize;
+}
+
+static const TypeInfo aspeed_ast1700_info = {
+    .name          = TYPE_ASPEED_AST1700,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedAST1700SoCState),
+    .class_init    = aspeed_ast1700_class_init,
+};
+
+static void aspeed_ast1700_register_types(void)
+{
+    type_register_static(&aspeed_ast1700_info);
+}
+
+type_init(aspeed_ast1700_register_types);
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c250487e6486..47cdc51d135a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -70,6 +70,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0_evb.c',
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
   'aspeed_ast27x0-fc.c',
-- 
2.52.0


