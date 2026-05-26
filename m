Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64DBCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0Z-0005On-5N; Tue, 26 May 2026 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0W-0005LG-GN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0U-0007i8-Hx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ84ZUCdRMHtrAzzN1AYmiHiROWg5wDN6WXkCLnqlsE=;
 b=F6mbeHdSkthwezT1mxuEoE1S093KAHoPJMwcXwebemqu3I69WiLsPkMdt2nmCl8NBljP+z
 VmY7ANOBv2G18+NqVdrkRVBSuWCqznQBxB0BJCOqdST+q6r+fG5OI2yCeLoMHS6VEKROgy
 jDsy4E3D1yvIRqCMoFiwco65OWIjx68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-jZSkN3JGPeWCWBDHEHtG5A-1; Tue,
 26 May 2026 04:19:18 -0400
X-MC-Unique: jZSkN3JGPeWCWBDHEHtG5A-1
X-Mimecast-MFC-AGG-ID: jZSkN3JGPeWCWBDHEHtG5A_1779783557
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AA9B18002EE; Tue, 26 May 2026 08:19:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B357C1800357; Tue, 26 May 2026 08:19:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/37] hw/arm/aspeed: Add AST1040 EVB machine model
Date: Tue, 26 May 2026 10:18:23 +0200
Message-ID: <20260526081848.651835-13-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AST1040 is the next-generation device following AST1030 and is
primarily designed as a bridge/BIC controller platform. Introduce
a dedicated AST1040 EVB machine implementation for firmware
development and validation.

Although the existing ast10x0 EVB machine code already provides
a reusable minibmc initialization flow, AST1040 requires
different platform settings, including:

  - Different SYSCLK frequency
  - Different internal flash size

To avoid overloading the existing AST1030-specific helper,
introduce a separate aspeed_bic_machine_init() implementation in
a dedicated source file.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040_evb.c | 73 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  3 +-
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast1040_evb.c

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
new file mode 100644
index 000000000000..1d9b55247f07
--- /dev/null
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -0,0 +1,73 @@
+/*
+ * ASPEED AST1040 EVB
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/core/qdev-clock.h"
+#include "system/system.h"
+
+#define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)
+/* Main SYSCLK frequency in Hz (400MHz) */
+#define SYSCLK_FRQ 400000000ULL
+
+static void aspeed_bic_machine_init(MachineState *machine)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
+    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
+    object_unref(OBJECT(bmc->soc));
+    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
+
+    object_property_set_link(OBJECT(bmc->soc), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    aspeed_connect_serial_hds_to_uarts(bmc);
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0,
+                       AST1040_INTERNAL_FLASH_SIZE);
+}
+
+static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST1040 BIC EVB (Cortex-M4F)";
+    amc->soc_name = "ast1040-a0";
+    amc->hw_strap1 = 0;
+    amc->hw_strap2 = 0;
+    mc->init = aspeed_bic_machine_init;
+    mc->default_ram_size = 0;
+    amc->macs_mask = 0;
+    amc->uart_default = ASPEED_DEV_UART12;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast1040_evb_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("ast1040-evb"),
+        .parent         = TYPE_ASPEED_MACHINE,
+        .class_init     = aspeed_machine_ast1040_evb_class_init,
+        .interfaces     = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast1040_evb_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1da08d198bee..68d204bb4ebf 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -64,7 +64,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
-  'aspeed_ast1040.c'))
+  'aspeed_ast1040.c',
+  'aspeed_ast1040_evb.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
-- 
2.54.0


