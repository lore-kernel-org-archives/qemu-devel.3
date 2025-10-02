Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41560CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4MvM-0000uV-2k; Thu, 02 Oct 2025 13:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mur-0000lY-Jy
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuY-0005jo-Mf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANE8haKuhnow+DBTgv9qpx1KUZ7eH0zvSCpwdVX4jVo=;
 b=EQNpYQ5TPFGtQooNfndqVnV+pctoIxG+YfmAJYco2X/a05E6uR6mcmDBXnPApzS8KTR12C
 kqTAG5vMpFPJxXgOgco1VDfqCPjGRgR7OSi4ju8l3TE2htceMForUhIpbV1qCmhvQC+T4G
 TgnmxpkH0WGdQPLuA4yMv0D67de+JTk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-SiP981q7M7yhFeOKiaDT5A-1; Thu, 02 Oct 2025 13:16:05 -0400
X-MC-Unique: SiP981q7M7yhFeOKiaDT5A-1
X-Mimecast-MFC-AGG-ID: SiP981q7M7yhFeOKiaDT5A_1759425364
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-63723f2c1e7so1428963a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425363; x=1760030163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANE8haKuhnow+DBTgv9qpx1KUZ7eH0zvSCpwdVX4jVo=;
 b=ntm/n3oy/u3JtXefY3AB05NcQF1HSHiee4W0ajeOpGE60HnBmK/jGtuxzxAgQl2MUo
 Hgl6pVxJSjWWjfBoOE4UT8iPmoUXUI4eYi+qaYwdXzum0JOVmu6CS4/2ltrb4pwF9Uow
 qNuc/THA6pKk6sjgV85oEutBSvztUj5Ek/Sev/50F7TC9DSlkNBGMKQEMzQVXDFw3VWu
 5pvp5gIO+UAGKh42ZIXMuZOhtCKthXA0Nr3eHRWNBcgRWqZzoOd2SrkJT1VlfH9ZPWUO
 QIKPosXIYzHFy4VI9NEhxtQGYa4lcRcyWaPdlYzhRmyo4WXcxcNxt8nH/pz+stAbCzal
 8bnA==
X-Gm-Message-State: AOJu0YzoEgxAj73l2RDuFXycnF55qTSUkSUYlNCbGpQGR3X+YmIDUi7g
 eEuVBWnGEj1ZXzzxs5jiB6hKZQf+ScC9rf3qqi9E5JRH7Vo7bs3VXt0J6Xk1RDEV4MvuAfKlAX+
 b4vOKiqjiK7hJlzhp8Ry5lGUILPI3429xZySU7boHI2GQnDCvNT0LvbwY7/IjJiC2xMILJTtO4K
 60CqiVUHQjd0C6cJ07qHlNl5sz/jZu0OxDblc4gmOQ
X-Gm-Gg: ASbGncsqxzX7AdN0tMGtMDqizNE4J5HYEMlD9zYKFpJpfxuUqM0B02VXfCuBz2aYC1H
 QIDQWmsuy6zHddTpFqNoRbAtKLyMnaD6d1GXn/Wj0xSMeAbLq9K5fUuZ3e4kwc1IoaLBEni2Dg6
 VeCmq1lvZ02binVEGr9s65k94+DAefSRstLc41rMx399RbFRJTtDixGSZG6PgePG8iAMSTT0tbU
 CLm5IyIPNacjSnqAFIO/1Rl+7VoH1i6/1HNdj9RE/cr3dsTiQdLKpGDKpN0QPHO/Gk1pH2nhEpp
 hreFkGKrcWOeGyFeH3npyERXZtXIHJX0o28bIVwKYNA7nfnj7/FHH/jgoI6xe7ETjItAvzSxv3P
 K7LAhzjk+OG+ppetsj0j7cfUuxhkfxTtFgSqpt1Czy8AtPAsC
X-Received: by 2002:a05:6402:4307:b0:637:e490:4600 with SMTP id
 4fb4d7f45d1cf-637e4904903mr3458123a12.16.1759425362430; 
 Thu, 02 Oct 2025 10:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEirjRWgDrZHcHNpZioGReosQduk1FPH/wmB/x2YW3hjCKpZlX7e7q/VIKJsTeRstd0LsEE2g==
X-Received: by 2002:a05:6402:4307:b0:637:e490:4600 with SMTP id
 4fb4d7f45d1cf-637e4904903mr3458073a12.16.1759425361705; 
 Thu, 02 Oct 2025 10:16:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63788110de2sm2266009a12.35.2025.10.02.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 09/27] accel/mshv: Initialize VM partition
Date: Thu,  2 Oct 2025 19:15:18 +0200
Message-ID: <20251002171536.1460049-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Create the MSHV virtual machine by opening a partition and issuing
the necessary ioctl to initialize it. This sets up the basic VM
structure and initial configuration used by MSHV to manage guest state.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-10-magnuskulke@linux.microsoft.com
[Add stubs; fix format strings for trace-events; make mshv_hvcall
 available only in per-target files; mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  |   1 +
 accel/mshv/trace.h           |  14 ++
 include/system/mshv.h        |  11 +-
 include/system/mshv_int.h    |  25 +++
 accel/mshv/irq.c             | 399 +++++++++++++++++++++++++++++++++++
 accel/mshv/mem.c             | 129 ++++++++++-
 accel/mshv/mshv-all.c        | 326 ++++++++++++++++++++++++++++
 accel/stubs/mshv-stub.c      |  44 ++++
 hw/intc/apic.c               |   8 +
 target/i386/mshv/mshv-cpu.c  |  72 +++++++
 accel/mshv/meson.build       |   1 +
 accel/mshv/trace-events      |  26 +++
 accel/stubs/meson.build      |   1 +
 target/i386/mshv/meson.build |   1 +
 14 files changed, 1054 insertions(+), 4 deletions(-)
 create mode 100644 accel/mshv/trace.h
 create mode 100644 accel/mshv/irq.c
 create mode 100644 accel/stubs/mshv-stub.c
 create mode 100644 target/i386/mshv/mshv-cpu.c
 create mode 100644 accel/mshv/trace-events

diff --git a/meson.build b/meson.build
index 31ddce93a38..0595e9c0ea9 100644
--- a/meson.build
+++ b/meson.build
@@ -3668,6 +3668,7 @@ if have_system
   trace_events_subdirs += [
     'accel/hvf',
     'accel/kvm',
+    'accel/mshv',
     'audio',
     'backends',
     'backends/tpm',
diff --git a/accel/mshv/trace.h b/accel/mshv/trace.h
new file mode 100644
index 00000000000..0dca48f9179
--- /dev/null
+++ b/accel/mshv/trace.h
@@ -0,0 +1,14 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "trace/trace-accel_mshv.h"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 434ea9682e1..1011e81df47 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -31,18 +31,27 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
+#define MSHV_MAX_MSI_ROUTES 4096
+
+#define MSHV_PAGE_SHIFT 12
+
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
+#define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
-#endif
 #define mshv_msi_via_irqfd_enabled() false
+#endif
 
 typedef struct MshvState MshvState;
 extern MshvState *mshv_state;
 
 /* interrupt */
+int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_destination_mode,
+                           bool level_triggered);
+
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index cfa177ff72f..b36124a0ea7 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -36,10 +36,35 @@ struct MshvState {
     /* number of listeners */
     int nr_as;
     MshvAddressSpace *as;
+    int fd;
 };
 
+typedef struct MshvMsiControl {
+    bool updated;
+    GHashTable *gsi_routes;
+} MshvMsiControl;
+
+void mshv_arch_amend_proc_features(
+    union hv_partition_synthetic_processor_features *features);
+int mshv_arch_post_init_vm(int vm_fd);
+
+#if defined COMPILING_PER_TARGET && defined CONFIG_MSHV_IS_POSSIBLE
+int mshv_hvcall(int fd, const struct mshv_root_hvcall *args);
+#endif
+
 /* memory */
+typedef struct MshvMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    bool readonly;
+} MshvMemoryRegion;
+
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
+/* interrupt */
+void mshv_init_msicontrol(void);
+int mshv_reserve_ioapic_msi_routes(int vm_fd);
+
 #endif
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
new file mode 100644
index 00000000000..adf8f337d9c
--- /dev/null
+++ b/accel/mshv/irq.c
@@ -0,0 +1,399 @@
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
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "hw/intc/ioapic.h"
+#include "hw/pci/msi.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
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
+        entry = g_new0(struct mshv_user_irq_entry, 1);
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
+static int commit_msi_routing_table(int vm_fd)
+{
+    guint len;
+    int i, ret;
+    size_t table_size;
+    struct mshv_user_irq_table *table;
+    GHashTableIter iter;
+    gpointer key, value;
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
+int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_dest_mode,
+                           bool level_triggered)
+{
+    int ret;
+    int vm_fd = mshv_state->vm;
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
+    int vm_fd = mshv_state->vm;
+
+    ret = commit_msi_routing_table(vm_fd);
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
+
+int mshv_reserve_ioapic_msi_routes(int vm_fd)
+{
+    int ret, gsi;
+
+    /*
+     * Reserve GSI 0-23 for IOAPIC pins, to avoid conflicts of legacy
+     * peripherals with MSI-X devices
+     */
+    for (gsi = 0; gsi < IOAPIC_NUM_PINS; gsi++) {
+        ret = add_msi_routing(0, 0);
+        if (ret < 0) {
+            error_report("Failed to reserve GSI %d", gsi);
+            return -1;
+        }
+    }
+
+    ret = commit_msi_routing_table(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to commit reserved IOAPIC MSI routes");
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index 9889918c31f..a0a40eb3333 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -12,14 +12,137 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
 #include "system/mshv_int.h"
+#include "exec/memattrs.h"
+#include <sys/ioctl.h>
+#include "trace.h"
+
+static int set_guest_memory(int vm_fd,
+                            const struct mshv_user_mem_region *region)
+{
+    int ret;
+
+    ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
+    if (ret < 0) {
+        error_report("failed to set guest memory");
+        return -errno;
+    }
+
+    return 0;
+}
+
+static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
+{
+    struct mshv_user_mem_region region = {0};
+
+    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
+    region.size = mr->memory_size;
+    region.userspace_addr = mr->userspace_addr;
+
+    if (!map) {
+        region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);
+        trace_mshv_unmap_memory(mr->userspace_addr, mr->guest_phys_addr,
+                                mr->memory_size);
+        return set_guest_memory(vm_fd, &region);
+    }
+
+    region.flags = BIT(MSHV_SET_MEM_BIT_EXECUTABLE);
+    if (!mr->readonly) {
+        region.flags |= BIT(MSHV_SET_MEM_BIT_WRITABLE);
+    }
+
+    trace_mshv_map_memory(mr->userspace_addr, mr->guest_phys_addr,
+                          mr->memory_size);
+    return set_guest_memory(vm_fd, &region);
+}
+
+static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
+{
+    int ret = 0;
+
+    if (!mshv_mr) {
+        error_report("Invalid mshv_mr");
+        return -1;
+    }
+
+    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
+                          mshv_mr->memory_size,
+                          mshv_mr->userspace_addr, mshv_mr->readonly,
+                          ret);
+    return map_or_unmap(mshv_state->vm, mshv_mr, add);
+}
+
+/*
+ * Calculate and align the start address and the size of the section.
+ * Return the size. If the size is 0, the aligned section is empty.
+ */
+static hwaddr align_section(MemoryRegionSection *section, hwaddr *start)
+{
+    hwaddr size = int128_get64(section->size);
+    hwaddr delta, aligned;
+
+    /*
+     * works in page size chunks, but the function may be called
+     * with sub-page size and unaligned start address. Pad the start
+     * address to next and truncate size to previous page boundary.
+     */
+    aligned = ROUND_UP(section->offset_within_address_space,
+                       qemu_real_host_page_size());
+    delta = aligned - section->offset_within_address_space;
+    *start = aligned;
+    if (delta > size) {
+        return 0;
+    }
+
+    return (size - delta) & qemu_real_host_page_mask();
+}
 
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add)
 {
-    error_report("unimplemented");
-    abort();
-}
+    int ret = 0;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    hwaddr start_addr, mr_offset, size;
+    void *ram;
+    MshvMemoryRegion mshv_mr = {0};
 
+    size = align_section(section, &start_addr);
+    trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
+
+    /*
+     * If the memory device is a writable non-ram area, we do not
+     * want to map it into the guest memory. If it is not a ROM device,
+     * we want to remove mshv memory mapping, so accesses will trap.
+     */
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!area->romd_mode) {
+            add = false;
+        }
+    }
+
+    if (!size) {
+        return;
+    }
+
+    mr_offset = section->offset_within_region + start_addr -
+                section->offset_within_address_space;
+
+    ram = memory_region_get_ram_ptr(area) + mr_offset;
+
+    mshv_mr.guest_phys_addr = start_addr;
+    mshv_mr.memory_size = size;
+    mshv_mr.readonly = !writable;
+    mshv_mr.userspace_addr = (uint64_t)ram;
+
+    ret = set_memory(&mshv_mr, add);
+    if (ret < 0) {
+        error_report("Failed to set memory region");
+        abort();
+    }
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index a684a366775..653195c57c9 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -7,6 +7,7 @@
  *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
  *  Magnus Kulke      <magnuskulke@microsoft.com>
  *  Jinank Jain       <jinankjain@microsoft.com>
+ *  Wei Liu           <liuwe@microsoft.com>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
@@ -23,6 +24,7 @@
 #include "hw/hyperv/hvhdk.h"
 #include "hw/hyperv/hvhdk_mini.h"
 #include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "linux/mshv.h"
 
 #include "qemu/accel.h"
@@ -49,6 +51,175 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static int init_mshv(int *mshv_fd)
+{
+    int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
+    if (fd < 0) {
+        error_report("Failed to open /dev/mshv: %s", strerror(errno));
+        return -1;
+    }
+    *mshv_fd = fd;
+    return 0;
+}
+
+/* freeze 1 to pause, 0 to resume */
+static int set_time_freeze(int vm_fd, int freeze)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    in.property_code = HV_PARTITION_PROPERTY_TIME_FREEZE;
+    in.property_value = freeze;
+
+    struct mshv_root_hvcall args = {0};
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set time freeze");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int pause_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_time_freeze(vm_fd, 1);
+    if (ret < 0) {
+        error_report("Failed to pause partition: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int resume_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_time_freeze(vm_fd, 0);
+    if (ret < 0) {
+        error_report("Failed to resume partition: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int create_partition(int mshv_fd, int *vm_fd)
+{
+    int ret;
+    struct mshv_create_partition args = {0};
+
+    /* Initialize pt_flags with the desired features */
+    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
+                        (1ULL << MSHV_PT_BIT_X2APIC) |
+                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
+
+    /* Set default isolation type */
+    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
+
+    args.pt_flags = pt_flags;
+    args.pt_isolation = pt_isolation;
+
+    ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
+    if (ret < 0) {
+        error_report("Failed to create partition: %s", strerror(errno));
+        return -1;
+    }
+
+    *vm_fd = ret;
+    return 0;
+}
+
+static int set_synthetic_proc_features(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    union hv_partition_synthetic_processor_features features = {0};
+
+    /* Access the bitfield and set the desired features */
+    features.hypervisor_present = 1;
+    features.hv1 = 1;
+    features.access_partition_reference_counter = 1;
+    features.access_synic_regs = 1;
+    features.access_synthetic_timer_regs = 1;
+    features.access_partition_reference_tsc = 1;
+    features.access_frequency_regs = 1;
+    features.access_intr_ctrl_regs = 1;
+    features.access_vp_index = 1;
+    features.access_hypercall_regs = 1;
+    features.tb_flush_hypercalls = 1;
+    features.synthetic_cluster_ipi = 1;
+    features.direct_synthetic_timers = 1;
+
+    mshv_arch_amend_proc_features(&features);
+
+    in.property_code = HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES;
+    in.property_value = features.as_uint64[0];
+
+    struct mshv_root_hvcall args = {0};
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    trace_mshv_hvcall_args("synthetic_proc_features", args.code, args.in_sz);
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set synthethic proc features");
+        return -errno;
+    }
+    return 0;
+}
+
+static int initialize_vm(int vm_fd)
+{
+    int ret = ioctl(vm_fd, MSHV_INITIALIZE_PARTITION);
+    if (ret < 0) {
+        error_report("Failed to initialize partition: %s", strerror(errno));
+        return -1;
+    }
+    return 0;
+}
+
+static int create_vm(int mshv_fd, int *vm_fd)
+{
+    int ret = create_partition(mshv_fd, vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = set_synthetic_proc_features(*vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = initialize_vm(*vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = mshv_reserve_ioapic_msi_routes(*vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = mshv_arch_post_init_vm(*vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    /* Always create a frozen partition */
+    pause_vm(*vm_fd);
+
+    return 0;
+}
+
 static void mem_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
@@ -67,11 +238,124 @@ static void mem_region_del(MemoryListener *listener,
     memory_region_unref(section->mr);
 }
 
+typedef enum {
+    DATAMATCH_NONE,
+    DATAMATCH_U32,
+    DATAMATCH_U64,
+} DatamatchTag;
+
+typedef struct {
+    DatamatchTag tag;
+    union {
+        uint32_t u32;
+        uint64_t u64;
+    } value;
+} Datamatch;
+
+/* flags: determine whether to de/assign */
+static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
+                     uint32_t flags)
+{
+    struct mshv_user_ioeventfd args = {0};
+    args.fd = event_fd;
+    args.addr = addr;
+    args.flags = flags;
+
+    if (dm.tag == DATAMATCH_NONE) {
+        args.datamatch = 0;
+    } else {
+        flags |= BIT(MSHV_IOEVENTFD_BIT_DATAMATCH);
+        args.flags = flags;
+        if (dm.tag == DATAMATCH_U64) {
+            args.len = sizeof(uint64_t);
+            args.datamatch = dm.value.u64;
+        } else {
+            args.len = sizeof(uint32_t);
+            args.datamatch = dm.value.u32;
+        }
+    }
+
+    return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+}
+
+static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr)
+{
+    uint32_t flags = 0;
+    Datamatch dm = {0};
+
+    flags |= BIT(MSHV_IOEVENTFD_BIT_DEASSIGN);
+    dm.tag = DATAMATCH_NONE;
+
+    return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
+}
+
+static int register_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,
+                            uint64_t val, bool is_64bit, bool is_datamatch)
+{
+    uint32_t flags = 0;
+    Datamatch dm = {0};
+
+    if (!is_datamatch) {
+        dm.tag = DATAMATCH_NONE;
+    } else if (is_64bit) {
+        dm.tag = DATAMATCH_U64;
+        dm.value.u64 = val;
+    } else {
+        dm.tag = DATAMATCH_U32;
+        dm.value.u32 = val;
+    }
+
+    return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
+}
+
+static void mem_ioeventfd_add(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data,
+                              EventNotifier *e)
+{
+    int fd = event_notifier_get_fd(e);
+    int ret;
+    bool is_64 = int128_get64(section->size) == 8;
+    uint64_t addr = section->offset_within_address_space;
+
+    trace_mshv_mem_ioeventfd_add(addr, int128_get64(section->size), data);
+
+    ret = register_ioevent(mshv_state->vm, fd, addr, data, is_64, match_data);
+
+    if (ret < 0) {
+        error_report("Failed to register ioeventfd: %s (%d)", strerror(-ret),
+                     -ret);
+        abort();
+    }
+}
+
+static void mem_ioeventfd_del(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data,
+                              EventNotifier *e)
+{
+    int fd = event_notifier_get_fd(e);
+    int ret;
+    uint64_t addr = section->offset_within_address_space;
+
+    trace_mshv_mem_ioeventfd_del(section->offset_within_address_space,
+                                 int128_get64(section->size), data);
+
+    ret = unregister_ioevent(mshv_state->vm, fd, addr);
+    if (ret < 0) {
+        error_report("Failed to unregister ioeventfd: %s (%d)", strerror(-ret),
+                     -ret);
+        abort();
+    }
+}
+
 static MemoryListener mshv_memory_listener = {
     .name = "mshv",
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
     .region_add = mem_region_add,
     .region_del = mem_region_del,
+    .eventfd_add = mem_ioeventfd_add,
+    .eventfd_del = mem_ioeventfd_del,
 };
 
 static MemoryListener mshv_io_listener = {
@@ -97,15 +381,57 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
     }
 }
 
+int mshv_hvcall(int fd, const struct mshv_root_hvcall *args)
+{
+    int ret = 0;
+
+    ret = ioctl(fd, MSHV_ROOT_HVCALL, args);
+    if (ret < 0) {
+        error_report("Failed to perform hvcall: %s", strerror(errno));
+        return -1;
+    }
+    return ret;
+}
+
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
     MshvState *s;
+    int mshv_fd, vm_fd, ret;
+
+    if (mshv_state) {
+        warn_report("MSHV accelerator already initialized");
+        return 0;
+    }
+
     s = MSHV_STATE(as);
 
     accel_blocker_init();
 
     s->vm = 0;
 
+    ret = init_mshv(&mshv_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    mshv_init_msicontrol();
+
+    ret = create_vm(mshv_fd, &vm_fd);
+    if (ret < 0) {
+        close(mshv_fd);
+        return -1;
+    }
+
+    ret = resume_vm(vm_fd);
+    if (ret < 0) {
+        close(mshv_fd);
+        close(vm_fd);
+        return -1;
+    }
+
+    s->vm = vm_fd;
+    s->fd = mshv_fd;
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
new file mode 100644
index 00000000000..e499b199d9d
--- /dev/null
+++ b/accel/stubs/mshv-stub.c
@@ -0,0 +1,44 @@
+/*
+ * QEMU MSHV stub
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * Author: Paolo Bonzini     <pbonzini@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "system/mshv.h"
+
+bool mshv_allowed;
+
+int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+{
+    return -ENOSYS;
+}
+
+void mshv_irqchip_release_virq(int virq)
+{
+}
+
+int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
+{
+    return -ENOSYS;
+}
+
+void mshv_irqchip_commit_routes(void)
+{
+}
+
+int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
+                                        const EventNotifier *rn, int virq)
+{
+    return -ENOSYS;
+}
+
+int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq)
+{
+    return -ENOSYS;
+}
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bcb103560c7..6d7859640c2 100644
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
@@ -932,6 +933,13 @@ static void apic_send_msi(MSIMessage *msi)
     uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
     uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
     /* XXX: Ignore redirection hint. */
+#ifdef CONFIG_MSHV
+    if (mshv_enabled()) {
+        mshv_request_interrupt(mshv_state, delivery, vector, dest,
+                               dest_mode, trigger_mode);
+        return;
+    }
+#endif
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
new file mode 100644
index 00000000000..de0c26bc6c6
--- /dev/null
+++ b/target/i386/mshv/mshv-cpu.c
@@ -0,0 +1,72 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou   <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke  <magnuskulke@microsoft.com>
+ *          Jinank Jain   <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/typedefs.h"
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+#include "system/address-spaces.h"
+#include "linux/mshv.h"
+#include "hw/hyperv/hvgdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "hw/hyperv/hvhdk_mini.h"
+
+#include "trace-accel_mshv.h"
+#include "trace.h"
+
+void mshv_arch_amend_proc_features(
+    union hv_partition_synthetic_processor_features *features)
+{
+    features->access_guest_idle_reg = 1;
+}
+
+/*
+ * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
+ * fault to the guest if it tries to access it. It is possible to override
+ * this behavior with a more suitable option i.e., ignore writes from the guest
+ * and return zero in attempt to read unimplemented.
+ */
+static int set_unimplemented_msr_action(int vm_fd)
+{
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code  = HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION;
+    in.property_value = HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO;
+
+    args.code   = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz  = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    trace_mshv_hvcall_args("unimplemented_msr_action", args.code, args.in_sz);
+
+    int ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set unimplemented MSR action");
+        return -1;
+    }
+    return 0;
+}
+
+int mshv_arch_post_init_vm(int vm_fd)
+{
+    int ret;
+
+    ret = set_unimplemented_msr_action(vm_fd);
+    if (ret < 0) {
+        error_report("Failed to set unimplemented MSR action");
+    }
+
+    return ret;
+}
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index 8a6beb3fb1e..f88fc8678c3 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
+  'irq.c',
   'mem.c',
   'mshv-all.c'
 ))
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
new file mode 100644
index 00000000000..6130c4abf8a
--- /dev/null
+++ b/accel/mshv/trace-events
@@ -0,0 +1,26 @@
+# Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
+#          Magnus Kulke <magnuskulke@microsoft.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "add=%d gpa=0x%" PRIx64 " size=0x%" PRIx64 " user=0x%" PRIx64 " readonly=%d result=%d"
+mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
+mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
+
+mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
+
+mshv_handle_interrupt(uint32_t cpu, int mask) "cpu_index=%d mask=0x%x"
+mshv_set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data) "gsi=%d addr=0x%" PRIx64 " data=0x%x"
+mshv_remove_msi_routing(uint32_t gsi) "gsi=%d"
+mshv_add_msi_routing(uint64_t addr, uint32_t data) "addr=0x%" PRIx64 " data=0x%x"
+mshv_commit_msi_routing_table(int vm_fd, int len) "vm_fd=%d table_size=%d"
+mshv_register_irqfd(int vm_fd, int event_fd, uint32_t gsi) "vm_fd=%d event_fd=%d gsi=%d"
+mshv_irqchip_update_irqfd_notifier_gsi(int event_fd, int resample_fd, int virq, bool add) "event_fd=%d resample_fd=%d virq=%d add=%d"
+
+mshv_insn_fetch(uint64_t addr, size_t size) "gpa=0x%" PRIx64 " size=%zu"
+mshv_mem_write(uint64_t addr, size_t size) "\tgpa=0x%" PRIx64 " size=%zu"
+mshv_mem_read(uint64_t addr, size_t size) "\tgpa=0x%" PRIx64 " size=%zu"
+mshv_map_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
+mshv_unmap_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
+mshv_set_phys_mem(bool add, const char *name, uint64_t gpa) "\tadd=%d name=%s gpa=0x%010" PRIx64
+mshv_handle_mmio(uint64_t gva, uint64_t gpa, uint64_t size, uint8_t access_type) "\tgva=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%" PRIx64 " access_type=%d"
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 9dfc4f9ddaf..48eccd1b861 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -5,5 +5,6 @@ system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_MSHV', if_false: files('mshv-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 8ddaa7c11dc..647e5dafb77 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -1,6 +1,7 @@
 i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
+  'mshv-cpu.c',
   'x86.c',
 ))
 
-- 
2.51.0


