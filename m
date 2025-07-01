Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669BCC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWens-0004Bh-9j; Tue, 01 Jul 2025 13:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWenn-00047U-RW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:51 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWenl-0006nQ-4j
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:51 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 69B102112235;
 Tue,  1 Jul 2025 10:29:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69B102112235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390987;
 bh=6zIGOx5vf3yl1XsgSb8tjWh62etNn82izmqXHhOSkEk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QmJ23jA9BT5XF3f33XvxZUyFeQcQHeiZNUsguWmU7bF0tykMoDujjXoy+YbYB9nJp
 R0N3m8SqQaRpR3djDfBXTVj67BFiIPIPu3z4zoTas9xsahzVmZvIXzUhW9oAQnK17t
 LiscfpyYpj3lF0YvQmM9VUo1vMZbGwdaO73jv7xg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 11/27] accel/mshv: Add basic interrupt injection support
Date: Tue,  1 Jul 2025 19:28:18 +0200
Message-Id: <20250701172834.44849-12-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Implement initial interrupt handling logic in the MSHV backend. This
includes management of MSI and un/registering of irqfd mechanisms.

Co-authored-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c        | 369 ++++++++++++++++++++++++++++++++++++++++
 accel/mshv/meson.build  |   1 +
 accel/mshv/mshv-all.c   |   4 +-
 accel/mshv/trace-events |   1 +
 hw/intc/apic.c          |   9 +
 include/system/mshv.h   |  24 +--
 6 files changed, 395 insertions(+), 13 deletions(-)
 create mode 100644 accel/mshv/irq.c

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
new file mode 100644
index 0000000000..9c2647fa06
--- /dev/null
+++ b/accel/mshv/irq.c
@@ -0,0 +1,369 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *          Stanislav Kinsburskii <skinsburskii@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "linux/mshv.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "system/mshv.h"
+#include "trace.h"
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#define MSHV_IRQFD_RESAMPLE_FLAG (1 << MSHV_IRQFD_BIT_RESAMPLE)
+#define MSHV_IRQFD_BIT_DEASSIGN_FLAG (1 << MSHV_IRQFD_BIT_DEASSIGN)
+
+static MshvMsiControl *msi_control;
+static QemuMutex msi_control_mutex;
+
+void mshv_init_msicontrol(void)
+{
+    qemu_mutex_init(&msi_control_mutex);
+    msi_control = g_new0(MshvMsiControl, 1);
+    msi_control->gsi_routes = g_hash_table_new(g_direct_hash, g_direct_equal);
+    msi_control->updated = false;
+}
+
+static int set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data)
+{
+    struct mshv_user_irq_entry *entry;
+    uint32_t high_addr = addr >> 32;
+    uint32_t low_addr = addr & 0xFFFFFFFF;
+    GHashTable *gsi_routes;
+
+    trace_mshv_set_msi_routing(gsi, addr, data);
+
+    if (gsi >= MSHV_MAX_MSI_ROUTES) {
+        error_report("gsi >= MSHV_MAX_MSI_ROUTES");
+        return -1;
+    }
+
+    assert(msi_control);
+
+    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
+        gsi_routes = msi_control->gsi_routes;
+        entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
+
+        if (entry
+            && entry->address_hi == high_addr
+            && entry->address_lo == low_addr
+            && entry->data == data)
+        {
+            /* nothing to update */
+            return 0;
+        }
+
+        /* free old entry */
+        g_free(entry);
+
+        /* create new entry */
+        entry = g_new0(mshv_user_irq_entry, 1);
+        entry->gsi = gsi;
+        entry->address_hi = high_addr;
+        entry->address_lo = low_addr;
+        entry->data = data;
+
+        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), entry);
+        msi_control->updated = true;
+    }
+
+    return 0;
+}
+
+static int add_msi_routing(uint64_t addr, uint32_t data)
+{
+    struct mshv_user_irq_entry *route_entry;
+    uint32_t high_addr = addr >> 32;
+    uint32_t low_addr = addr & 0xFFFFFFFF;
+    int gsi;
+    GHashTable *gsi_routes;
+
+    trace_mshv_add_msi_routing(addr, data);
+
+    assert(msi_control);
+
+    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
+        /* find an empty slot */
+        gsi = 0;
+        gsi_routes = msi_control->gsi_routes;
+        while (gsi < MSHV_MAX_MSI_ROUTES) {
+            route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
+            if (!route_entry) {
+                break;
+            }
+            gsi++;
+        }
+        if (gsi >= MSHV_MAX_MSI_ROUTES) {
+            error_report("No empty gsi slot available");
+            return -1;
+        }
+
+        /* create new entry */
+        route_entry = g_new0(struct mshv_user_irq_entry, 1);
+        route_entry->gsi = gsi;
+        route_entry->address_hi = high_addr;
+        route_entry->address_lo = low_addr;
+        route_entry->data = data;
+
+        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), route_entry);
+        msi_control->updated = true;
+    }
+
+    return gsi;
+}
+
+static int commit_msi_routing_table(void)
+{
+    guint len;
+    int i, ret;
+    size_t table_size;
+    struct mshv_user_irq_table *table;
+    GHashTableIter iter;
+    gpointer key, value;
+    int vm_fd = mshv_state->vm;
+
+    assert(msi_control);
+
+    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
+        if (!msi_control->updated) {
+            /* nothing to update */
+            return 0;
+        }
+
+        /* Calculate the size of the table */
+        len = g_hash_table_size(msi_control->gsi_routes);
+        table_size = sizeof(struct mshv_user_irq_table)
+                     + len * sizeof(struct mshv_user_irq_entry);
+        table = g_malloc0(table_size);
+
+        g_hash_table_iter_init(&iter, msi_control->gsi_routes);
+        i = 0;
+        while (g_hash_table_iter_next(&iter, &key, &value)) {
+            struct mshv_user_irq_entry *entry = value;
+            table->entries[i] = *entry;
+            i++;
+        }
+        table->nr = i;
+
+        trace_mshv_commit_msi_routing_table(vm_fd, len);
+
+        ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, table);
+        g_free(table);
+        if (ret < 0) {
+            error_report("Failed to commit msi routing table");
+            return -1;
+        }
+        msi_control->updated = false;
+    }
+    return 0;
+}
+
+static int remove_msi_routing(uint32_t gsi)
+{
+    struct mshv_user_irq_entry *route_entry;
+    GHashTable *gsi_routes;
+
+    trace_mshv_remove_msi_routing(gsi);
+
+    if (gsi >= MSHV_MAX_MSI_ROUTES) {
+        error_report("Invalid GSI: %u", gsi);
+        return -1;
+    }
+
+    assert(msi_control);
+
+    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
+        gsi_routes = msi_control->gsi_routes;
+        route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
+        if (route_entry) {
+            g_hash_table_remove(gsi_routes, GINT_TO_POINTER(gsi));
+            g_free(route_entry);
+            msi_control->updated = true;
+        }
+    }
+
+    return 0;
+}
+
+/* Pass an eventfd which is to be used for injecting interrupts from userland */
+static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
+                 uint32_t flags)
+{
+    int ret;
+    struct mshv_user_irqfd arg = {
+        .fd = fd,
+        .resamplefd = resample_fd,
+        .gsi = gsi,
+        .flags = flags,
+    };
+
+    ret = ioctl(vm_fd, MSHV_IRQFD, &arg);
+    if (ret < 0) {
+        error_report("Failed to set irqfd: gsi=%u, fd=%d", gsi, fd);
+        return -1;
+    }
+    return ret;
+}
+
+static int register_irqfd(int vm_fd, int event_fd, uint32_t gsi)
+{
+    int ret;
+
+    trace_mshv_register_irqfd(vm_fd, event_fd, gsi);
+
+    ret = irqfd(vm_fd, event_fd, 0, gsi, 0);
+    if (ret < 0) {
+        error_report("Failed to register irqfd: gsi=%u", gsi);
+        return -1;
+    }
+    return 0;
+}
+
+static int register_irqfd_with_resample(int vm_fd, int event_fd,
+                                        int resample_fd, uint32_t gsi)
+{
+    int ret;
+    uint32_t flags = MSHV_IRQFD_RESAMPLE_FLAG;
+
+    ret = irqfd(vm_fd, event_fd, resample_fd, gsi, flags);
+    if (ret < 0) {
+        error_report("Failed to register irqfd with resample: gsi=%u", gsi);
+        return -errno;
+    }
+    return 0;
+}
+
+static int unregister_irqfd(int vm_fd, int event_fd, uint32_t gsi)
+{
+    int ret;
+    uint32_t flags = MSHV_IRQFD_BIT_DEASSIGN_FLAG;
+
+    ret = irqfd(vm_fd, event_fd, 0, gsi, flags);
+    if (ret < 0) {
+        error_report("Failed to unregister irqfd: gsi=%u", gsi);
+        return -errno;
+    }
+    return 0;
+}
+
+static int irqchip_update_irqfd_notifier_gsi(const EventNotifier *event,
+                                             const EventNotifier *resample,
+                                             int virq, bool add)
+{
+    int fd = event_notifier_get_fd(event);
+    int rfd = resample ? event_notifier_get_fd(resample) : -1;
+    int vm_fd = mshv_state->vm;
+
+    trace_mshv_irqchip_update_irqfd_notifier_gsi(fd, rfd, virq, add);
+
+    if (!add) {
+        return unregister_irqfd(vm_fd, fd, virq);
+    }
+
+    if (rfd > 0) {
+        return register_irqfd_with_resample(vm_fd, fd, rfd, virq);
+    }
+
+    return register_irqfd(vm_fd, fd, virq);
+}
+
+
+int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+{
+    MSIMessage msg = { 0, 0 };
+    int virq = 0;
+
+    if (pci_available && dev) {
+        msg = pci_get_msi_message(dev, vector);
+        virq = add_msi_routing(msg.address, le32_to_cpu(msg.data));
+    }
+
+    return virq;
+}
+
+void mshv_irqchip_release_virq(int virq)
+{
+    remove_msi_routing(virq);
+}
+
+int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
+{
+    int ret;
+
+    ret = set_msi_routing(virq, msg.address, le32_to_cpu(msg.data));
+    if (ret < 0) {
+        error_report("Failed to set msi routing");
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_request_interrupt(int vm_fd, uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_dest_mode,
+                           bool level_triggered)
+{
+    int ret;
+
+    if (vector == 0) {
+        warn_report("Ignoring request for interrupt vector 0");
+        return 0;
+    }
+
+    union hv_interrupt_control control = {
+        .interrupt_type = interrupt_type,
+        .level_triggered = level_triggered,
+        .logical_dest_mode = logical_dest_mode,
+        .rsvd = 0,
+    };
+
+    struct hv_input_assert_virtual_interrupt arg = {0};
+    arg.control = control;
+    arg.dest_addr = (uint64_t)vp_index;
+    arg.vector = vector;
+
+    struct mshv_root_hvcall args = {0};
+    args.code   = HVCALL_ASSERT_VIRTUAL_INTERRUPT;
+    args.in_sz  = sizeof(arg);
+    args.in_ptr = (uint64_t)&arg;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to request interrupt");
+        return -errno;
+    }
+    return 0;
+}
+
+void mshv_irqchip_commit_routes(void)
+{
+    int ret;
+
+    ret = commit_msi_routing_table();
+    if (ret < 0) {
+        error_report("Failed to commit msi routing table");
+        abort();
+    }
+}
+
+int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *event,
+                                        const EventNotifier *resample,
+                                        int virq)
+{
+    return irqchip_update_irqfd_notifier_gsi(event, resample, virq, true);
+}
+
+int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *event,
+                                           int virq)
+{
+    return irqchip_update_irqfd_notifier_gsi(event, NULL, virq, false);
+}
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index 8a6beb3fb1..f88fc8678c 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
+  'irq.c',
   'mem.c',
   'mshv-all.c'
 ))
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 2ae9d1cffa..9f6dcacf33 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -353,10 +353,8 @@ static MemoryListener mshv_memory_listener = {
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
     .region_add = mem_region_add,
     .region_del = mem_region_del,
-#ifdef MSHV_USE_IOEVENTFD
     .eventfd_add = mem_ioeventfd_add,
     .eventfd_del = mem_ioeventfd_del,
-#endif
 };
 
 static MemoryListener mshv_io_listener = {
@@ -416,6 +414,8 @@ static int mshv_init(MachineState *ms)
         return -1;
     }
 
+    mshv_init_msicontrol();
+
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index b49a5b1702..66f5057caa 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -1,5 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+mshv_handle_interrupt(uint32_t cpu, int mask) "cpu_index %d mask %x"
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "[add = %d] gpa = %lx size = %lx user = %lx readonly = %d result = %d"
 mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
 mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bcb103560c..4d1fe7cdd1 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
 #include "system/kvm.h"
+#include "system/mshv.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
@@ -932,6 +933,14 @@ static void apic_send_msi(MSIMessage *msi)
     uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
     uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
     /* XXX: Ignore redirection hint. */
+#ifdef CONFIG_MSHV
+    if (mshv_enabled()) {
+		/* TODO: error handling? */
+        mshv_request_interrupt(mshv_state->vm, delivery, vector, dest,
+                               dest_mode, trigger_mode);
+        return;
+    }
+#endif
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index c2b0414c85..8a03a89b0c 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -30,13 +30,9 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
-/*
- * Set to 0 if we do not want to use eventfd to optimize the MMIO events.
- * Set to 1 so that mshv kernel driver receives doorbell when the VM access
- * MMIO memory and then signal eventfd to notify the qemu device
- * without extra switching to qemu to emulate mmio access.
- */
-#define MSHV_USE_IOEVENTFD 1
+typedef struct hyperv_message hv_message;
+
+#define MSHV_MAX_MSI_ROUTES 4096
 
 #define MSHV_PAGE_SHIFT 12
 
@@ -70,14 +66,15 @@ struct AccelCPUState {
     bool dirty;
 };
 
+typedef struct MshvMsiControl {
+    bool updated;
+    GHashTable *gsi_routes;
+} MshvMsiControl;
+
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
 #endif
-#ifdef MSHV_USE_KERNEL_GSI_IRQFD
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
-#else
-#define mshv_msi_via_irqfd_enabled() false
-#endif
 
 /* cpu */
 void mshv_arch_amend_proc_features(
@@ -100,6 +97,11 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
 /* interrupt */
+void mshv_init_msicontrol(void);
+int mshv_request_interrupt(int vm_fd, uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_destination_mode,
+                           bool level_triggered);
+
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
-- 
2.34.1


