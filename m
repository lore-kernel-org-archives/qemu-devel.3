Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FF3CDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr6A8-0001N6-4k; Wed, 18 Sep 2024 21:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6A5-0000v0-00; Wed, 18 Sep 2024 21:40:49 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6A2-0004sM-PF; Wed, 18 Sep 2024 21:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710047; x=1758246047;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Lv6y5pVsU6DtDjzxhv1VCs53XCauucInvDj9vyaeKw=;
 b=awy2/xxSsHTmH5XOq1GV1w9kbwIKMC7Nw/v4pvsU1iiX0sHFLpcCVKo0
 /Czs0+kznTAYgCo9Qu4EZq4ybfjnoM0naAThTrnP0ACEBMJff9V64DXdy
 mjxbN+I9zIvdPx7F66qLn4l853ow9b/Yt0NDAm49Wl6x7hzMME7SUhh1L
 xYGBriwAJoM/lT3ZK+/Nn7YoAV4lVBIbvRt9MTJOxL2k206O9LkuamvF2
 f32go8w7BbF6Y7FXWs5n7TWokdurk8KDZNhhTsi2sGY4wq0D87rCerpEr
 rDw6Po2fWhcOdu63An4MwjcG6jT/9gVWzQkoPXxtDK9FgrenXCt7t33DQ w==;
X-CSE-ConnectionGUID: XIyDjPVqQOS3U2OsVEdkwg==
X-CSE-MsgGUID: zCUem+QJTyOmuQ3hbP9VZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797982"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:45 -0700
X-CSE-ConnectionGUID: oRBjSbnIQmSIHRcM58FHEg==
X-CSE-MsgGUID: BCnW7jNJTSGl38Hi7C4luQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058880"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:39 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 09/15] hw/cpu: Abstract module/die/socket levels as topology
 devices
Date: Thu, 19 Sep 2024 09:55:27 +0800
Message-Id: <20240919015533.766754-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919015533.766754-1-zhao1.liu@intel.com>
References: <20240919015533.766754-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Abstract module/die/socket levels as the cpu-module/cpu-die/cpu-socket
topology devices then they can be inserted into topology tree.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS             |  6 ++++++
 hw/cpu/die.c            | 34 ++++++++++++++++++++++++++++++++++
 hw/cpu/meson.build      |  3 +++
 hw/cpu/module.c         | 34 ++++++++++++++++++++++++++++++++++
 hw/cpu/socket.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/cpu/die.h    | 29 +++++++++++++++++++++++++++++
 include/hw/cpu/module.h | 29 +++++++++++++++++++++++++++++
 include/hw/cpu/socket.h | 29 +++++++++++++++++++++++++++++
 8 files changed, 198 insertions(+)
 create mode 100644 hw/cpu/die.c
 create mode 100644 hw/cpu/module.c
 create mode 100644 hw/cpu/socket.c
 create mode 100644 include/hw/cpu/die.h
 create mode 100644 include/hw/cpu/module.h
 create mode 100644 include/hw/cpu/socket.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e5b2cd91dca..03c1a13de074 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1886,6 +1886,9 @@ F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: hw/cpu/cpu-slot.c
 F: hw/cpu/cpu-topology.c
+F: hw/cpu/die.c
+F: hw/cpu/module.c
+F: hw/cpu/socket.c
 F: qapi/machine.json
 F: qapi/machine-common.json
 F: qapi/machine-target.json
@@ -1894,6 +1897,9 @@ F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/hw/cpu/cpu-slot.h
 F: include/hw/cpu/cpu-topology.h
+F: include/hw/cpu/die.h
+F: include/hw/cpu/module.h
+F: include/hw/cpu/socket.h
 F: include/sysemu/numa.h
 F: tests/functional/test_cpu_queries.py
 F: tests/functional/test_empty_cpu_model.py
diff --git a/hw/cpu/die.c b/hw/cpu/die.c
new file mode 100644
index 000000000000..f00907ffd78b
--- /dev/null
+++ b/hw/cpu/die.c
@@ -0,0 +1,34 @@
+/*
+ * CPU die abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cpu/die.h"
+
+static void cpu_die_class_init(ObjectClass *oc, void *data)
+{
+    CPUTopoClass *tc = CPU_TOPO_CLASS(oc);
+
+    tc->level = CPU_TOPOLOGY_LEVEL_DIE;
+}
+
+static const TypeInfo cpu_die_type_info = {
+    .name = TYPE_CPU_DIE,
+    .parent = TYPE_CPU_TOPO,
+    .class_init = cpu_die_class_init,
+    .instance_size = sizeof(CPUDie),
+};
+
+static void cpu_die_register_types(void)
+{
+    type_register_static(&cpu_die_type_info);
+}
+
+type_init(cpu_die_register_types)
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 358e2b3960fa..c64eec4460d8 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -3,6 +3,9 @@ common_ss.add(files('cpu-topology.c'))
 system_ss.add(files('core.c'))
 system_ss.add(files('cpu-slot.c'))
 system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
+system_ss.add(files('die.c'))
+system_ss.add(files('module.c'))
+system_ss.add(files('socket.c'))
 
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
diff --git a/hw/cpu/module.c b/hw/cpu/module.c
new file mode 100644
index 000000000000..b6f50a2ba588
--- /dev/null
+++ b/hw/cpu/module.c
@@ -0,0 +1,34 @@
+/*
+ * CPU module abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cpu/module.h"
+
+static void cpu_module_class_init(ObjectClass *oc, void *data)
+{
+    CPUTopoClass *tc = CPU_TOPO_CLASS(oc);
+
+    tc->level = CPU_TOPOLOGY_LEVEL_MODULE;
+}
+
+static const TypeInfo cpu_module_type_info = {
+    .name = TYPE_CPU_MODULE,
+    .parent = TYPE_CPU_TOPO,
+    .class_init = cpu_module_class_init,
+    .instance_size = sizeof(CPUModule),
+};
+
+static void cpu_module_register_types(void)
+{
+    type_register_static(&cpu_module_type_info);
+}
+
+type_init(cpu_module_register_types)
diff --git a/hw/cpu/socket.c b/hw/cpu/socket.c
new file mode 100644
index 000000000000..516e93389e11
--- /dev/null
+++ b/hw/cpu/socket.c
@@ -0,0 +1,34 @@
+/*
+ * CPU socket abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cpu/socket.h"
+
+static void cpu_socket_class_init(ObjectClass *oc, void *data)
+{
+    CPUTopoClass *tc = CPU_TOPO_CLASS(oc);
+
+    tc->level = CPU_TOPOLOGY_LEVEL_SOCKET;
+}
+
+static const TypeInfo cpu_socket_type_info = {
+    .name = TYPE_CPU_SOCKET,
+    .parent = TYPE_CPU_TOPO,
+    .class_init = cpu_socket_class_init,
+    .instance_size = sizeof(CPUSocket),
+};
+
+static void cpu_socket_register_types(void)
+{
+    type_register_static(&cpu_socket_type_info);
+}
+
+type_init(cpu_socket_register_types)
diff --git a/include/hw/cpu/die.h b/include/hw/cpu/die.h
new file mode 100644
index 000000000000..682e226ac569
--- /dev/null
+++ b/include/hw/cpu/die.h
@@ -0,0 +1,29 @@
+/*
+ * CPU die abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CPU_DIE_H
+#define HW_CPU_DIE_H
+
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_CPU_DIE "cpu-die"
+
+OBJECT_DECLARE_SIMPLE_TYPE(CPUDie, CPU_DIE)
+
+struct CPUDie {
+    /*< private >*/
+    CPUTopoState obj;
+
+    /*< public >*/
+};
+
+#endif /* HW_CPU_DIE_H */
diff --git a/include/hw/cpu/module.h b/include/hw/cpu/module.h
new file mode 100644
index 000000000000..242cd623a3b3
--- /dev/null
+++ b/include/hw/cpu/module.h
@@ -0,0 +1,29 @@
+/*
+ * CPU module abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CPU_MODULE_H
+#define HW_CPU_MODULE_H
+
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_CPU_MODULE "cpu-module"
+
+OBJECT_DECLARE_SIMPLE_TYPE(CPUModule, CPU_MODULE)
+
+struct CPUModule {
+    /*< private >*/
+    CPUTopoState obj;
+
+    /*< public >*/
+};
+
+#endif /* HW_CPU_MODULE_H */
diff --git a/include/hw/cpu/socket.h b/include/hw/cpu/socket.h
new file mode 100644
index 000000000000..a25bf8727a22
--- /dev/null
+++ b/include/hw/cpu/socket.h
@@ -0,0 +1,29 @@
+/*
+ * CPU socket abstract device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CPU_SOCKET_H
+#define HW_CPU_SOCKET_H
+
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_CPU_SOCKET "cpu-socket"
+
+OBJECT_DECLARE_SIMPLE_TYPE(CPUSocket, CPU_SOCKET)
+
+struct CPUSocket {
+    /*< private >*/
+    CPUTopoState parent_obj;
+
+    /*< public >*/
+};
+
+#endif /* HW_CPU_SOCKET_H */
-- 
2.34.1


