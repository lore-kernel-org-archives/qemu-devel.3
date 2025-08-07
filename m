Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E0C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1nm-0007nJ-1m; Thu, 07 Aug 2025 10:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1nj-0007iA-R6
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:03 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1ni-0000y1-2Y
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:03 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8CE01201BC73;
 Thu,  7 Aug 2025 07:40:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CE01201BC73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577660;
 bh=gI13jGwHxhzOeKPxlYT6kPvxWpB0OnEI3BfrT+GvtiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o9oUbZSOhTuAF6QQ90xWlMg8p+q62DgZCroHOtm3gpFVjPSHhyqXl50GIY8lR6lWh
 WJbNctziKEgduC3OC6OYZJqmY2BwJ/KllDr1YEEm2v0eBv+OjMpg+V24RyO2pt6r/B
 vnZSFVz0aL3io34siXXB+JR+uH5cPx3H/XMeLBrA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/26] accel/mshv: Register memory region listeners
Date: Thu,  7 Aug 2025 16:39:33 +0200
Message-Id: <20250807143951.1154713-9-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Add memory listener hooks for the MSHV accelerator to track guest
memory regions. This enables the backend to respond to region
additions, removals and will be used to manage guest memory mappings
inside the hypervisor.

Actually registering physical memory in the hypervisor is still stubbed
out.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c       | 24 +++++++++++++++
 accel/mshv/meson.build |  1 +
 accel/mshv/mshv-all.c  | 67 ++++++++++++++++++++++++++++++++++++++++--
 include/system/mshv.h  |  4 +++
 4 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 accel/mshv/mem.c

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
new file mode 100644
index 0000000000..ad5e62c89c
--- /dev/null
+++ b/accel/mshv/mem.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add)
+{
+    error_report("unimplemented");
+    abort();
+}
+
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index 4c03ac7921..8a6beb3fb1 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
+  'mem.c',
   'mshv-all.c'
 ))
 
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index f548b1187b..2094966c8c 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -48,10 +48,73 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static void mem_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    memory_region_ref(section->mr);
+    mshv_set_phys_mem(mml, section, true);
+}
+
+static void mem_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    mshv_set_phys_mem(mml, section, false);
+    memory_region_unref(section->mr);
+}
+
+static MemoryListener mshv_memory_listener = {
+    .name = "mshv",
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+    .region_add = mem_region_add,
+    .region_del = mem_region_del,
+};
+
+static MemoryListener mshv_io_listener = {
+    .name = "mshv", .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
+    /* MSHV does not support PIO eventfd */
+};
+
+static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
+                                          AddressSpace *as, int as_id,
+                                          const char *name)
+{
+    int i;
+
+    mml->listener = mshv_memory_listener;
+    mml->listener.name = name;
+    memory_listener_register(&mml->listener, as);
+    for (i = 0; i < s->nr_as; ++i) {
+        if (!s->as[i].as) {
+            s->as[i].as = as;
+            s->as[i].ml = mml;
+            break;
+        }
+    }
+}
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
-    error_report("unimplemented");
-    abort();
+    MshvState *s;
+    s = MSHV_STATE(as);
+
+    accel_blocker_init();
+
+    s->vm = 0;
+
+    s->nr_as = 1;
+    s->as = g_new0(MshvAddressSpace, s->nr_as);
+
+    mshv_state = s;
+
+    register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
+                                  0, "mshv-memory");
+    memory_listener_register(&mshv_io_listener, &address_space_io);
+
+    return 0;
 }
 
 static void mshv_start_vcpu_thread(CPUState *cpu)
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 45808c5c50..c5d33cd990 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -69,6 +69,10 @@ struct AccelCPUState {
 #define mshv_msi_via_irqfd_enabled() false
 #endif
 
+/* memory */
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add);
+
 /* interrupt */
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
-- 
2.34.1


