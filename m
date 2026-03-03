Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEDEEC047E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM11-0003r7-Sb; Tue, 03 Mar 2026 04:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0o-0003iA-G8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0k-0004OA-2x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEjyaQ/WiNyM94I3xXQBC4kfpcQUqZHnB4E47is1W6o=;
 b=NvpQuFUxwV7hOc9sT9u0y22JAAq8PJ3Feu8jVrV63n7utoQ7sb5rgQ4lEi9ELX23ju6mtf
 SypViQJR0xgcSyKYcqLi/FP3cU8cICFCJCZOdivwWB6q4mrsn4+fk9aFWSJo3pah/3fDf2
 wYxgA/zdVtHBotHJ9z33r6iucGMguBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-dT6IPha_POKAmp--9ujiNQ-1; Tue,
 03 Mar 2026 04:25:43 -0500
X-MC-Unique: dT6IPha_POKAmp--9ujiNQ-1
X-Mimecast-MFC-AGG-ID: dT6IPha_POKAmp--9ujiNQ_1772529942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187A719560B2; Tue,  3 Mar 2026 09:25:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BCC130001B9; Tue,  3 Mar 2026 09:25:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 01/21] acpi: add API to build WDAT instructions
Date: Tue,  3 Mar 2026 10:25:12 +0100
Message-ID: <20260303092532.2410177-2-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
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

Add definitions for WDAT[1] actions/instructions
and build_append_wdat_ins() API to build table entries.

1)
"Hardware Watchdog Timers Design Specification"
  https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
 hw/acpi/aml-build.c    |  14 +++++
 2 files changed, 132 insertions(+)
 create mode 100644 include/hw/acpi/wdat.h

diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
new file mode 100644
index 0000000000..89803eef4b
--- /dev/null
+++ b/include/hw/acpi/wdat.h
@@ -0,0 +1,118 @@
+/*
+ * Watchdog Action Table (WDAT) definitions
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_H
+#define QEMU_HW_ACPI_WDAT_H
+
+#include "hw/acpi/acpi-defs.h"
+
+/*
+ * Watchdog actions as described in
+ *  "Hardware Watchdog Timers Design Specification"
+ * for link to spec see https://uefi.org/acpi
+ *     'Watchdog Action Table (WDAT)'
+ */
+typedef enum {
+    /*
+     * Restarts the watchdog timer's countdown. This action is
+     * required.
+     */
+    WDAT_ACTION_RESET = 0x1,
+    /*
+     * Returns the current countdown value of the watchdog hardware
+     * (in count intervals).
+     */
+    WDAT_ACTION_QUERY_CURRENT_COUNTDOWN_PERIOD = 0x4,
+    /*
+     * Returns the countdown value the watchdog hardware is
+     * configured to use when reset (in count intervals).
+     */
+    WDAT_ACTION_QUERY_COUNTDOWN_PERIOD = 0x5,
+    /*
+     * Sets the countdown value (in count intervals) to be used when
+     * the watchdog timer is reset. This action is required if
+     * WDAT_ACTION_RESET does not explicitly write a new
+     * countdown value to a register during a reset. Otherwise, this
+     * action is optional.
+     */
+    WDAT_ACTION_SET_COUNTDOWN_PERIOD = 0x6,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * running state. The same result must occur when performed from
+     * both from enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_RUNNING_STATE = 0x8,
+    /*
+     * Starts the watchdog, if not already in running state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_RUNNING_STATE = 0x9,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * stopped state. The same result must occur when performed from
+     * both the enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_STOPPED_STATE = 0xA,
+    /*
+     * Stops the watchdog, if not already in stopped state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_STOPPED_STATE = 0xB,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * reboot when the watchdog is fired.
+     */
+    WDAT_ACTION_QUERY_REBOOT = 0x10,
+    /*
+     * Configures the watchdog hardware to perform a reboot when it
+     * is fired.
+     */
+    WDAT_ACTION_SET_REBOOT = 0x11,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * system shutdown when fired.
+     */
+    WDAT_ACTION_QUERY_SHUTDOWN = 0x12,
+    /*
+     * Configures the watchdog hardware to perform a system shutdown
+     * when fired.
+     */
+    WDAT_ACTION_SET_SHUTDOWN = 0x13,
+    /*
+     * Determines if the current boot was caused by the watchdog
+     * firing. The boot status is required to be set if the watchdog
+     * fired and caused a reboot. It is recommended that the
+     * Watchdog Status be set if the watchdog fired and caused a
+     * shutdown. This action is required.
+     */
+    WDAT_ACTION_QUERY_WATCHDOG_STATUS = 0x20,
+    /*
+     * Sets the watchdog's boot status to the default value. This
+     * action is required.
+     */
+    WDAT_ACTION_SET_WATCHDOG_STATUS = 0x21,
+} WDATAction;
+
+#define WDAT_INS_READ_VALUE 0x0
+#define WDAT_INS_READ_COUNTDOWN 0x1
+#define WDAT_INS_WRITE_VALUE 0x2
+#define WDAT_INS_WRITE_COUNTDOWN 0x3
+#define WDAT_INS_PRESERVE_REGISTER 0x80
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask);
+
+#endif /* QEMU_HW_ACPI_WDAT_H */
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea1c415b21..9f9ce28dcc 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/cutils.h"
+#include "hw/acpi/wdat.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2647,3 +2648,16 @@ Aml *aml_error_device(void)
 
     return dev;
 }
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask)
+{
+    build_append_int_noprefix(table_data, action, 1);    /* Watchdog Action */
+    build_append_int_noprefix(table_data, flags, 1);     /* Instruction Flags */
+    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
+    build_append_gas_from_struct(table_data, &as);       /* Register Region */
+    build_append_int_noprefix(table_data, val, 4);       /* Value */
+    build_append_int_noprefix(table_data, mask, 4);      /* Mask */
+}
-- 
2.47.3


