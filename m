Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A131C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIZv-0004fh-O8; Wed, 12 Mar 2025 05:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIZk-0004L5-6i; Wed, 12 Mar 2025 05:40:32 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIZg-0001ED-3n; Wed, 12 Mar 2025 05:40:31 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 52C9cUGe070270
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 17:38:30 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 12 Mar 2025
 17:40:01 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v11 7/8] hw/misc/riscv_iopmp_dispatcher: Device for redirect
 IOPMP transaction infomation
Date: Wed, 12 Mar 2025 17:37:31 +0800
Message-ID: <20250312093735.1517740-8-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20250312093735.1517740-1-ethan84@andestech.com>
References: <20250312093735.1517740-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52C9cUGe070270
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This device determines the target IOPMP device for forwarding information
based on:
* Address: For parallel IOPMP devices
* Stage: For cascading IOPMP devices

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 hw/misc/meson.build                      |   1 +
 hw/misc/riscv_iopmp_dispatcher.c         | 139 +++++++++++++++++++++++
 include/hw/misc/riscv_iopmp_dispatcher.h |  61 ++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 hw/misc/riscv_iopmp_dispatcher.c
 create mode 100644 include/hw/misc/riscv_iopmp_dispatcher.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 50f7d14650..a5f6b9621a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_iopmp.c'))
+specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_iopmp_dispatcher.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/riscv_iopmp_dispatcher.c b/hw/misc/riscv_iopmp_dispatcher.c
new file mode 100644
index 0000000000..3d52806ab7
--- /dev/null
+++ b/hw/misc/riscv_iopmp_dispatcher.c
@@ -0,0 +1,139 @@
+/*
+ * QEMU RISC-V IOPMP dispatcher
+ *
+ * Receives transaction information from the requestor and forwards it to the
+ * corresponding IOPMP device.
+ *
+ * Copyright (c) 2023-2025 Andes Tech. Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "exec/exec-all.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_iopmp_dispatcher.h"
+#include "memory.h"
+#include "hw/irq.h"
+#include "hw/misc/riscv_iopmp_txn_info.h"
+
+static void riscv_iopmp_dispatcher_realize(DeviceState *dev, Error **errp)
+{
+    int i;
+    RISCVIOPMPDispState *s = RISCV_IOPMP_DISP(dev);
+
+    s->SinkMemMap = g_new(SinkMemMapEntry *, s->stage_num);
+    for (i = 0; i < s->stage_num; i++) {
+        s->SinkMemMap[i] = g_new(SinkMemMapEntry, s->target_num);
+    }
+
+    object_initialize_child(OBJECT(s), "iopmp_dispatcher_txn_info",
+                            &s->txn_info_sink,
+                            TYPE_RISCV_IOPMP_DISP_SS);
+}
+
+static const Property iopmp_dispatcher_properties[] = {
+    DEFINE_PROP_UINT32("stage-num", RISCVIOPMPDispState, stage_num, 2),
+    DEFINE_PROP_UINT32("target-num", RISCVIOPMPDispState, target_num, 10),
+};
+
+static void riscv_iopmp_dispatcher_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, iopmp_dispatcher_properties);
+    dc->realize = riscv_iopmp_dispatcher_realize;
+}
+
+static const TypeInfo riscv_iopmp_dispatcher_info = {
+    .name = TYPE_RISCV_IOPMP_DISP,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(RISCVIOPMPDispState),
+    .class_init = riscv_iopmp_dispatcher_class_init,
+};
+
+static size_t dispatcher_txn_info_push(StreamSink *txn_info_sink,
+                                       unsigned char *buf,
+                                       size_t len, bool eop)
+{
+    uint64_t addr;
+    uint32_t stage;
+    int i, j;
+    riscv_iopmp_disp_ss *ss =
+        RISCV_IOPMP_DISP_SS(txn_info_sink);
+    RISCVIOPMPDispState *s = RISCV_IOPMP_DISP(container_of(ss,
+        RISCVIOPMPDispState, txn_info_sink));
+    RISCVIOPMPTxnInfo *signal;
+    if (len != sizeof(RISCVIOPMPTxnInfo)) {
+        return 0;
+    }
+    signal = (RISCVIOPMPTxnInfo *)buf;
+    addr = signal->start_addr;
+    stage = signal->stage;
+    for (i = stage; i < s->stage_num; i++) {
+        for (j = 0; j < s->target_num; j++) {
+            if (s->SinkMemMap[i][j].map.base <= addr &&
+                addr < s->SinkMemMap[i][j].map.base
+                + s->SinkMemMap[i][j].map.size) {
+                    return stream_push(s->SinkMemMap[i][j].sink, buf, len, eop);
+            }
+        }
+    }
+    /* Always pass if target is not protected by IOPMP*/
+    return 1;
+}
+
+static void riscv_iopmp_disp_ss_class_init(
+    ObjectClass *klass, void *data)
+{
+    StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
+    ssc->push = dispatcher_txn_info_push;
+}
+
+static const TypeInfo riscv_iopmp_disp_ss_info = {
+    .name = TYPE_RISCV_IOPMP_DISP_SS,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(riscv_iopmp_disp_ss),
+    .class_init = riscv_iopmp_disp_ss_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_STREAM_SINK },
+        { }
+    },
+};
+
+void iopmp_dispatcher_add_target(DeviceState *dev, StreamSink *sink,
+    uint64_t base, uint64_t size, uint32_t stage, uint32_t id)
+{
+    RISCVIOPMPDispState *s = RISCV_IOPMP_DISP(dev);
+    if (stage < s->stage_num && id < s->target_num) {
+        s->SinkMemMap[stage][id].map.base = base;
+        s->SinkMemMap[stage][id].map.size = size;
+        s->SinkMemMap[stage][id].sink = sink;
+    }
+}
+
+static void
+iopmp_dispatcher_register_types(void)
+{
+    type_register_static(&riscv_iopmp_dispatcher_info);
+    type_register_static(&riscv_iopmp_disp_ss_info);
+}
+
+type_init(iopmp_dispatcher_register_types);
+
diff --git a/include/hw/misc/riscv_iopmp_dispatcher.h b/include/hw/misc/riscv_iopmp_dispatcher.h
new file mode 100644
index 0000000000..bbaa76507b
--- /dev/null
+++ b/include/hw/misc/riscv_iopmp_dispatcher.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU RISC-V IOPMP dispatcher
+ *
+ * Receives transaction information from the requestor and forwards it to the
+ * corresponding IOPMP device.
+ *
+ * Copyright (c) 2023-2024 Andes Tech. Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_IOPMP_DISPATCHER_H
+#define RISCV_IOPMP_DISPATCHER_H
+
+#include "hw/sysbus.h"
+#include "qemu/typedefs.h"
+#include "memory.h"
+#include "hw/stream.h"
+#include "hw/misc/riscv_iopmp_txn_info.h"
+#include "exec/hwaddr.h"
+
+#define TYPE_RISCV_IOPMP_DISP "riscv-iopmp-dispatcher"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOPMPDispState, RISCV_IOPMP_DISP)
+
+#define TYPE_RISCV_IOPMP_DISP_SS "riscv-iopmp-dispatcher-streamsink"
+OBJECT_DECLARE_SIMPLE_TYPE(riscv_iopmp_disp_ss, RISCV_IOPMP_DISP_SS)
+
+typedef struct riscv_iopmp_disp_ss {
+    Object parent;
+} riscv_iopmp_disp_ss;
+
+typedef struct SinkMemMapEntry {
+    StreamSink *sink;
+    MemMapEntry map;
+} SinkMemMapEntry;
+
+typedef struct RISCVIOPMPDispState {
+    SysBusDevice parent_obj;
+    riscv_iopmp_disp_ss txn_info_sink;
+    SinkMemMapEntry **SinkMemMap;
+    /* The maximum number of cascading stages of IOPMP */
+    uint32_t stage_num;
+    /* The maximum number of parallel IOPMP devices within a single stage. */
+    uint32_t target_num;
+} RISCVIOPMPDispState;
+
+void iopmp_dispatcher_add_target(DeviceState *dev, StreamSink *sink,
+    uint64_t base, uint64_t size, uint32_t stage, uint32_t id);
+#endif
-- 
2.34.1


