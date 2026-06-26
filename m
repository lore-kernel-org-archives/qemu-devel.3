Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300FCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eR-0000Dh-8d; Fri, 26 Jun 2026 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eL-0007uo-Fz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eJ-0005Ly-Dq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0u6ciU5ce4UtTHQKayfuwLUVLLB0WirqzZ3GmCWZzlE=;
 b=Qs+XDaKjM4luc/hIAhoKKVNBkMZU5qgULliVTgFk+IH0SV3oIYy8F2nRtzDXbocz8tfEWx
 N87UQeBoflp4LOHqcr7aMSywDaNp0nb4oaJNdhPKkAdx22LtLD3zuOZ5blk9IxLcl5XyfK
 bmpo+N7/4+MVHFDSoCK0+6SevL1iZcg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-tvjc_KBRM4aBdWoqIbpd-A-1; Fri, 26 Jun 2026 06:19:01 -0400
X-MC-Unique: tvjc_KBRM4aBdWoqIbpd-A-1
X-Mimecast-MFC-AGG-ID: tvjc_KBRM4aBdWoqIbpd-A_1782469140
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b61243easo9180635e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469140; x=1783073940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0u6ciU5ce4UtTHQKayfuwLUVLLB0WirqzZ3GmCWZzlE=;
 b=I/BNsW3pNc2TB0YREV2qBMazWGv+7emE7HiRLE7c1kAVhcMfXMMoH4UtIniWxCy7Cq
 R6JG1tOvXGoN6LmqaBxSQyz8ScpNvasbJHVVL1uJ0Ha9DbtvJ78kIzEbjIB4CUP9v7bh
 ZPfAEkS3th/+IA7xND+Z+JawcAVUQrxcypB0erqrtGtDYyuHrzAhA7aDHNCHcUhMdmGF
 cW5MCBMHEIr4n/zTWJkWdxLlydVsOpU2bNGOZgTbeYmACOqy4dRuVpUG49F7bIIafknG
 PML4QM5nDJgX2HeqSHTri6hJpT/sB2FihUokl+RasTRT0hvCTWFteQfC52BSADFWDjlo
 mW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469140; x=1783073940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0u6ciU5ce4UtTHQKayfuwLUVLLB0WirqzZ3GmCWZzlE=;
 b=tER9VI4skLiOCtk5XsLqmySMcXb5IgljwVHM7FspAY4rhEk9WnDc7Ma/c83SgGP/6l
 p4H6KoFxgMwp71SyCzGyUvQJa9yNTCakPsWLUEouqPvbAiapBK1UZONTN3VC5hEa6es7
 poJEHxs3hDNan17WF9aEF2pPun98QJ1jADYEs3gVz/ZrX7VaEoHppjbQSWESo6Dp6EXp
 KuoINgQWfpmUv/tkYkj1PPf3/b2lPqRypaCl7SXbllhP55PgMxEu9NuVTPN9Xf9wksPf
 GgmrvOmx8n3rQQ9cz/eHvOisobONjY5gMlgHlIGkl+izst0f/2o1sGN16kXb7RngHyuZ
 KyTg==
X-Gm-Message-State: AOJu0YyJuejjY3oXg+BoCRft/xCZvA/6utLP5aBo9+aqJHnsGh0sxOcA
 5Jg8VElKBo7/AVDargOfsC/p4J70mGDcojaGssMD/FAsQheDuMp4BmvEJ7iX2zNbaaayl6cfSjS
 ShMHX3vI48FHYc28vVbsL2QJxckE2b2GF9j/hD6xCbPHDCP+Psmb71iFljsg9zEk8tuU4yf4ka/
 ClMgW6QOBO3Sx+AfIy/s6s8vuPtBo/tVMQtH/fa5Hl
X-Gm-Gg: AfdE7cm0SNe2G95MdWtdjDvcz2l+F1sV5Hxwpj+8FQmAzsLypyk3UIjUxemsVz/7nBK
 WQeXxtd1nQ2ZHc0ifvG575HnYukuFBfagqt6V1Z8U+APkdRXKjVlqTh2mGTvxTQa5LIKwukJgRU
 iFA8lO6Al3Wt2VMz0zKybn9KqaDQ3m0jLKBpXIKlLo8AVAuS/Yw4sVjrRhz9cz4eh2YWX4H+som
 0+A47Qo5VkGMi8K4BJJSpHKLO+yj+XklXAwOXNjtDr/e+Ua1JCQ/nMs5134eDY1ckN5Q1bacKQJ
 y2wct7WD/aARxHvs2YTqy3DW69qsQywZ+aMEI60y/aSTqKABzr9z51pABGJcoyGzYXwkU/0YbOA
 iFLNLnFSiXApZzW5V9cSUYmFg5sITn7Moa52RsW68RysrhyaTPa9cxxigDeSgF2YBu0eIB5fbI6
 8K64b9u8Jte1xsljvs
X-Received: by 2002:a05:600c:3f06:b0:492:33a8:5499 with SMTP id
 5b1f17b1804b1-492668858a8mr93112855e9.17.1782469139907; 
 Fri, 26 Jun 2026 03:18:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:492:33a8:5499 with SMTP id
 5b1f17b1804b1-492668858a8mr93112185e9.17.1782469139279; 
 Fri, 26 Jun 2026 03:18:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269086ab7sm96897515e9.13.2026.06.26.03.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 25/45] accel/mshv: enable dirty page tracking
Date: Fri, 26 Jun 2026 12:17:28 +0200
Message-ID: <20260626101748.1728079-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This change introduces the functions required to perform dirty page
tracking to speed up migrations. We are using the sync, global_start,
and global_stop hooks.

The sync is implemented in batches.

Before we can disable the dirty page tracking we have to set all dirty bits.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-35-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h |   4 +
 accel/mshv/mem.c          | 211 ++++++++++++++++++++++++++++++++++++++
 accel/mshv/mshv-all.c     |   3 +
 3 files changed, 218 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ac26bfafe48..3bdf16ecd35 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -17,6 +17,7 @@
 #include "hw/hyperv/hvhdk.h"
 
 #define MSHV_MSR_ENTRIES_COUNT 64
+#define MSHV_DIRTY_PAGES_BATCH_SIZE 0x10000
 
 typedef struct hyperv_message hv_message;
 
@@ -109,6 +110,9 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
                          bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
+void mshv_log_sync(MemoryListener *listener, MemoryRegionSection *section);
+bool mshv_log_global_start(MemoryListener *listener, Error **errp);
+void mshv_log_global_stop(MemoryListener *listener);
 
 /* msr */
 typedef struct MshvMsrEntry {
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index e55c38d4db9..820f87ef0c9 100644
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
index d939982eb79..9452504ac28 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -477,6 +477,9 @@ static MemoryListener mshv_memory_listener = {
     .region_del = mem_region_del,
     .eventfd_add = mem_ioeventfd_add,
     .eventfd_del = mem_ioeventfd_del,
+    .log_sync = mshv_log_sync,
+    .log_global_start = mshv_log_global_start,
+    .log_global_stop = mshv_log_global_stop,
 };
 
 static MemoryListener mshv_io_listener = {
-- 
2.54.0


