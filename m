Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF396F46124
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fry-0003G1-IZ; Mon, 23 Mar 2026 10:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fph-00017j-Oi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:45 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fpV-0007Jl-6Z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:31 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id B723320B6F0C;
 Mon, 23 Mar 2026 07:00:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B723320B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274417;
 bh=ZOKMgpZvx3abEQdJCz++yqLR/8YcM3C1DO/6gvmwcn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RzbTvFBnANB0PBLvvjyPiezmuOZ8V87zlr4HkR+zgBsOkUCO+4NSdoFLwNOnhlyd9
 JukQlPZtRvXBTWcxe3sxvaIxynSBnT7P2ehejkdWif5w2PYn3Rq1qDQFXG6EKU+WHf
 pwyw8Jj0V7csMTmyUH+AmQ8fCE2lCEGWIrUtbuyA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 32/32] accel/mshv: enable dirty page tracking
Date: Mon, 23 Mar 2026 14:58:12 +0100
Message-Id: <20260323135812.383509-33-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

This change introduces the functions required to perform dirty page
tracking to speed up migrations. We are using the sync, global_start,
and global_stop hooks.

The sync is implemented in batches.

Before we can disable the dirty page tracking we have to set all dirty bits.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c          | 211 ++++++++++++++++++++++++++++++++++++++
 accel/mshv/mshv-all.c     |   3 +
 include/system/mshv_int.h |   5 +
 3 files changed, 219 insertions(+)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index e55c38d4db..820f87ef0c 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -12,10 +12,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
 #include "system/mshv_int.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "system/physmem.h"
 #include "exec/memattrs.h"
 #include <sys/ioctl.h>
 #include "trace.h"
@@ -211,3 +214,211 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
         abort();
     }
 }
+
+static int enable_dirty_page_tracking(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING;
+    in.property_value = 1;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to enable dirty page tracking: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * Retrieve dirty page bitmap for a GPA range, clearing the dirty bits
+ * atomically. Large ranges are handled in batches.
+ */
+static int get_dirty_log(int vm_fd, uint64_t base_pfn, uint64_t page_count,
+                         unsigned long *bitmap, size_t bitmap_size)
+{
+    uint64_t batch, bitmap_offset, completed = 0;
+    struct mshv_gpap_access_bitmap args = {0};
+    int ret;
+
+    QEMU_BUILD_BUG_ON(MSHV_DIRTY_PAGES_BATCH_SIZE % BITS_PER_LONG != 0);
+    assert(bitmap_size >= ROUND_UP(page_count, BITS_PER_LONG) / 8);
+
+    while (completed < page_count) {
+        batch = MIN(MSHV_DIRTY_PAGES_BATCH_SIZE, page_count - completed);
+        bitmap_offset = completed / BITS_PER_LONG;
+
+        args.access_type = MSHV_GPAP_ACCESS_TYPE_DIRTY;
+        args.access_op   = MSHV_GPAP_ACCESS_OP_CLEAR;
+        args.page_count  = batch;
+        args.gpap_base   = base_pfn + completed;
+        args.bitmap_ptr  = (uint64_t)(bitmap + bitmap_offset);
+
+        ret = ioctl(vm_fd, MSHV_GET_GPAP_ACCESS_BITMAP, &args);
+        if (ret < 0) {
+            error_report("Failed to get dirty log (base_pfn=0x%" PRIx64
+                         " batch=%" PRIu64 "): %s",
+                         base_pfn + completed, batch, strerror(errno));
+            return -1;
+        }
+        completed += batch;
+    }
+
+    return 0;
+}
+
+bool mshv_log_global_start(MemoryListener *listener, Error **errp)
+{
+    int ret;
+
+    ret = enable_dirty_page_tracking(mshv_state->vm);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to enable dirty page tracking");
+        return false;
+    }
+    return true;
+}
+
+static int disable_dirty_page_tracking(int vm_fd)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING;
+    in.property_value = 0;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to disable dirty page tracking: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_dirty_pages(int vm_fd, uint64_t base_pfn, uint64_t page_count)
+{
+    uint64_t batch, completed = 0;
+    unsigned long bitmap[MSHV_DIRTY_PAGES_BATCH_SIZE / BITS_PER_LONG];
+    struct mshv_gpap_access_bitmap args = {0};
+    int ret;
+
+    while (completed < page_count) {
+        batch = MIN(MSHV_DIRTY_PAGES_BATCH_SIZE, page_count - completed);
+
+        args.access_type = MSHV_GPAP_ACCESS_TYPE_DIRTY;
+        args.access_op   = MSHV_GPAP_ACCESS_OP_SET;
+        args.page_count  = batch;
+        args.gpap_base   = base_pfn + completed;
+        args.bitmap_ptr  = (uint64_t)bitmap;
+
+        ret = ioctl(vm_fd, MSHV_GET_GPAP_ACCESS_BITMAP, &args);
+        if (ret < 0) {
+            error_report("Failed to set dirty pages (base_pfn=0x%" PRIx64
+                         " batch=%" PRIu64 "): %s",
+                         base_pfn + completed, batch, strerror(errno));
+            return -1;
+        }
+        completed += batch;
+    }
+
+    return 0;
+}
+
+static bool set_dirty_bits_cb(Int128 start, Int128 len, const MemoryRegion *mr,
+                              hwaddr offset_in_region, void *opaque)
+{
+    int ret, *errp = opaque;
+    hwaddr gpa, size;
+    uint64_t page_count, base_pfn;
+
+    gpa = int128_get64(start);
+    size = int128_get64(len);
+    page_count = size >> MSHV_PAGE_SHIFT;
+    base_pfn = gpa >> MSHV_PAGE_SHIFT;
+
+    if (!mr->ram || mr->readonly) {
+        return false;
+    }
+
+    if (page_count == 0) {
+        return false;
+    }
+
+    ret = set_dirty_pages(mshv_state->vm, base_pfn, page_count);
+
+    /* true aborts the iteration, which is what we want if there's an error */
+    if (ret < 0) {
+        *errp = ret;
+        return true;
+    }
+
+    return false;
+}
+
+void mshv_log_global_stop(MemoryListener *listener)
+{
+    int err = 0;
+    /* MSHV requires all dirty bits to be set before disabling tracking. */
+    FlatView *fv = address_space_to_flatview(&address_space_memory);
+    flatview_for_each_range(fv, set_dirty_bits_cb, &err);
+
+    if (err < 0) {
+        error_report("Failed to set dirty bits before disabling tracking");
+    }
+
+    disable_dirty_page_tracking(mshv_state->vm);
+}
+
+void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section)
+{
+    hwaddr size, start_addr, mr_offset;
+    uint64_t page_count, base_pfn;
+    size_t bitmap_size;
+    unsigned long *bitmap;
+    ram_addr_t ram_addr;
+    int ret;
+    MemoryRegion *mr = section->mr;
+
+    if (!memory_region_is_ram(mr) || memory_region_is_rom(mr)) {
+        return;
+    }
+
+    size = align_section(section, &start_addr);
+    if (!size) {
+        return;
+    }
+
+    page_count = size >> MSHV_PAGE_SHIFT;
+    base_pfn = start_addr >> MSHV_PAGE_SHIFT;
+    bitmap_size = ROUND_UP(page_count, BITS_PER_LONG) / 8;
+    bitmap = g_malloc0(bitmap_size);
+
+    ret = get_dirty_log(mshv_state->vm, base_pfn, page_count, bitmap,
+                        bitmap_size);
+    if (ret < 0) {
+        g_free(bitmap);
+        return;
+    }
+
+    mr_offset = section->offset_within_region + start_addr -
+                section->offset_within_address_space;
+    ram_addr = memory_region_get_ram_addr(mr) + mr_offset;
+
+    physical_memory_set_dirty_lebitmap(bitmap, ram_addr, page_count);
+    g_free(bitmap);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 45fe1ef468..87ed785302 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -546,6 +546,9 @@ static MemoryListener mshv_memory_listener = {
     .region_del = mem_region_del,
     .eventfd_add = mem_ioeventfd_add,
     .eventfd_del = mem_ioeventfd_del,
+    .log_sync = mshv_log_sync,
+    .log_global_start = mshv_log_global_start,
+    .log_global_stop = mshv_log_global_stop,
 };
 
 static MemoryListener mshv_io_listener = {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index c24efc8675..ddbdd76076 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -31,6 +31,8 @@ struct mshv_get_set_vp_state;
 #define MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC 5
 #define MSHV_HV_INTERRUPTION_TYPE_SW_EXC      6
 
+#define MSHV_DIRTY_PAGES_BATCH_SIZE 0x10000
+
 typedef struct hyperv_message hv_message;
 
 typedef struct MshvHvCallArgs {
@@ -128,6 +130,9 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
                          bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
+void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section);
+bool mshv_log_global_start(MemoryListener *listener, Error **errp);
+void mshv_log_global_stop(MemoryListener *listener);
 
 /* msr */
 int mshv_init_msrs(const CPUState *cpu);
-- 
2.34.1


