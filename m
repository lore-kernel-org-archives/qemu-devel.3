Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933ACE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9k-0001dY-0b; Thu, 19 Sep 2024 01:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9V-000850-Nn; Thu, 19 Sep 2024 01:56:31 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9T-0007Pn-Jo; Thu, 19 Sep 2024 01:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725388; x=1758261388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qJ6NOfIv6xlTy3/VIJhTGfDVU1kuzHahvjHb/mzi/Yo=;
 b=LsmKbLxpZTAkAH9jt6PBGr6/UZknrMPlgV6vV+3bld22PrV2K89H1iZH
 /yb6HdebgURDLpI6ejbtntqueouJwq2u/tqo/Mq5R1oFHyYywU/5zDGhT
 oXYQxriK/yDKGrYS0n4tjudxDRSDFt1ANMC9TZc3CfQ7m0VLZn1ze9mBn
 8cX8RyrCoWhZnrWat8XHHb52cHB0uFWkT2d1ijIcoy8n8yug8xvC/GXNR
 OGeceFlhLzOnpK++qXc6ishUOkh/N45J65h6GZlfqnplfDG/9KPOU1rBO
 dDaQuxdbKe8sHNM4UMTCglp40qu7ig/EqbaYC7OzVuvGyM2mRR7bRc2Pm w==;
X-CSE-ConnectionGUID: A4doQjUaRy6y9668g3yoeA==
X-CSE-MsgGUID: lUA6d5dLSu2HgYTyDokJPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813697"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:56:26 -0700
X-CSE-ConnectionGUID: RNragx4JQm++GP/Zqhw+Sw==
X-CSE-MsgGUID: ix81mjh5Tfy9LecwpDpOIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418793"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:56:20 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 09/12] i386: Introduce x86 CPU core abstractions
Date: Thu, 19 Sep 2024 14:11:25 +0800
Message-Id: <20240919061128.769139-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
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

Abstract 3 core types for i386: common core, Intel Core (P-core) and
Intel atom (E-core). This is in preparation for creating the hybrid
topology from the CLI.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/core.c      | 56 +++++++++++++++++++++++++++++++++++++++++
 target/i386/core.h      | 53 ++++++++++++++++++++++++++++++++++++++
 target/i386/meson.build |  1 +
 3 files changed, 110 insertions(+)
 create mode 100644 target/i386/core.c
 create mode 100644 target/i386/core.h

diff --git a/target/i386/core.c b/target/i386/core.c
new file mode 100644
index 000000000000..d76186a6a070
--- /dev/null
+++ b/target/i386/core.c
@@ -0,0 +1,56 @@
+/*
+ * x86 CPU core
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
+#include "core.h"
+
+static void x86_common_core_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUCoreClass *cc = X86_CPU_CORE_CLASS(oc);
+
+    cc->core_type = COMMON_CORE;
+}
+
+static void x86_intel_atom_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUCoreClass *cc = X86_CPU_CORE_CLASS(oc);
+
+    cc->core_type = INTEL_ATOM;
+}
+
+static void x86_intel_core_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUCoreClass *cc = X86_CPU_CORE_CLASS(oc);
+
+    cc->core_type = INTEL_CORE;
+}
+
+static const TypeInfo x86_cpu_core_infos[] = {
+    {
+        .name = TYPE_X86_CPU_CORE,
+        .parent = TYPE_CPU_CORE,
+        .class_size = sizeof(X86CPUCoreClass),
+        .class_init = x86_common_core_class_init,
+        .instance_size = sizeof(X86CPUCore),
+    },
+    {
+        .parent = TYPE_X86_CPU_CORE,
+        .name = X86_CPU_CORE_TYPE_NAME("intel-atom"),
+        .class_init = x86_intel_atom_class_init,
+    },
+    {
+        .parent = TYPE_X86_CPU_CORE,
+        .name = X86_CPU_CORE_TYPE_NAME("intel-core"),
+        .class_init = x86_intel_core_class_init,
+    },
+};
+
+DEFINE_TYPES(x86_cpu_core_infos)
diff --git a/target/i386/core.h b/target/i386/core.h
new file mode 100644
index 000000000000..b942153b2c0d
--- /dev/null
+++ b/target/i386/core.h
@@ -0,0 +1,53 @@
+/*
+ * x86 CPU core header
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "hw/cpu/core.h"
+#include "hw/cpu/cpu-topology.h"
+#include "qom/object.h"
+
+#ifndef I386_CORE_H
+#define I386_CORE_H
+
+#ifdef TARGET_X86_64
+#define TYPE_X86_PREFIX "x86-"
+#else
+#define TYPE_X86_PREFIX "i386-"
+#endif
+
+#define TYPE_X86_CPU_CORE TYPE_X86_PREFIX "core"
+
+OBJECT_DECLARE_TYPE(X86CPUCore, X86CPUCoreClass, X86_CPU_CORE)
+
+typedef enum {
+    COMMON_CORE = 0,
+    INTEL_ATOM,
+    INTEL_CORE,
+} X86CoreType;
+
+struct X86CPUCoreClass {
+    /*< private >*/
+    CPUTopoClass parent_class;
+
+    /*< public >*/
+    DeviceRealize parent_realize;
+    X86CoreType core_type;
+};
+
+struct X86CPUCore {
+    /*< private >*/
+    CPUCore parent_obj;
+
+    /*< public >*/
+};
+
+#define X86_CPU_CORE_TYPE_NAME(core_type_str) (TYPE_X86_PREFIX core_type_str)
+
+#endif /* I386_CORE_H */
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 075117989b9d..80a32526d98b 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -18,6 +18,7 @@ i386_system_ss.add(files(
   'arch_memory_mapping.c',
   'machine.c',
   'monitor.c',
+  'core.c',
   'cpu-apic.c',
   'cpu-sysemu.c',
 ))
-- 
2.34.1


