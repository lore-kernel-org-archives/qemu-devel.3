Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB9606A884
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=nA8A6r7/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRF9G-0001PL-LX; Wed, 11 Nov 2026 15:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xRF9E-0001Nv-HO
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:24 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xRF9C-0005w6-QF
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:24 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 009C120B7168;
 Wed, 11 Nov 2026 12:42:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 009C120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794429738;
 bh=oN0BFQE0r9iYoJZoaoOolLeu+FIg48QtzzEE8ItBUdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nA8A6r7/Mp3NcmhTLYHnEDpFrVQAg9TrTRWXnAcaeXv9XKnyTWMM3BYCeTUMKA2vq
 mwZuMqikCy2cRkyGkp8rhcFHEEZK9saIW5lZa0KwrlxcNu85iabKvd93i1RFc5jxM5
 TN3Xg0ZHuDprZ1mJnD2Y5wDzHclZvYTlZW+cHn6Q=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Doru Blanzeanu <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/4] accel/mshv: skip double unmap of mem regions
Date: Wed, 11 Nov 2026 21:41:52 +0100
Message-Id: <20261111204155.36683-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
References: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This change addresses a regression that was introduced when the dynamic
mapping handler was removed, from the MSHV controller, breaking OVMF
support.

We introduce a small uaddr-indexed table to track mapped regions. The
current logic turns an add into a remove op if a rom-device region is
currently not in romd_mode.

We could ignore both map + unmap for this condition, but this misses a
the case of a region transitioning from romd_mode=true => false. In this
case we still do want to unmap a region.

Fixes: 626e5dc99935 ("accel/mshv: Remove remap overlapping mappings code")

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mem.c          | 41 ++++++++++++++++++++++++++++++++++++---
 accel/mshv/mshv-all.c     |  1 +
 include/system/mshv_int.h |  1 +
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index 820f87ef0c..00d69fca8d 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
@@ -168,6 +169,25 @@ static hwaddr align_section(MemoryRegionSection *section, hwaddr *start)
     return (size - delta) & qemu_real_host_page_mask();
 }
 
+static bool uaddr_is_mapped(MshvMemoryListener *mml, hwaddr start_addr)
+{
+    assert(bql_locked());
+
+    return g_hash_table_contains(mml->mapped_regions,
+                                 GINT_TO_POINTER(start_addr));
+}
+
+static void track_region(MshvMemoryListener *mml, hwaddr start_addr, bool add)
+{
+    assert(bql_locked());
+
+    if (add) {
+        g_hash_table_add(mml->mapped_regions, GINT_TO_POINTER(start_addr));
+    } else {
+        g_hash_table_remove(mml->mapped_regions, GINT_TO_POINTER(start_addr));
+    }
+}
+
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add)
 {
@@ -176,15 +196,19 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
     bool writable = !area->readonly && !area->rom_device;
     hwaddr start_addr, mr_offset, size;
     void *ram;
+    bool is_mapped;
     MshvMemoryRegion mshv_mr = {0};
 
     size = align_section(section, &start_addr);
     trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
 
     /*
-     * If the memory device is a writable non-ram area, we do not
-     * want to map it into the guest memory. If it is not a ROM device,
-     * we want to remove mshv memory mapping, so accesses will trap.
+     * ROM devices (e.g. pflash) have ram=false, rom_device=true.
+     * In romd_mode, they behave like RAM and should be mapped.
+     * Outside romd_mode, accesses should trap to QEMU for emulation.
+     *
+     * For non-RAM, non-rom_device regions (writable MMIO), we never map.
+     * For rom_device regions not in romd_mode, we want them unmapped.
      */
     if (!memory_region_is_ram(area)) {
         if (writable) {
@@ -198,6 +222,15 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
         return;
     }
 
+    is_mapped = uaddr_is_mapped(mml, start_addr);
+
+    if (add && is_mapped) {
+        return;
+    }
+    if (!add && !is_mapped) {
+        return;
+    }
+
     mr_offset = section->offset_within_region + start_addr -
                 section->offset_within_address_space;
 
@@ -213,6 +246,8 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
         error_report("Failed to set memory region");
         abort();
     }
+
+    track_region(mml, start_addr, add);
 }
 
 static int enable_dirty_page_tracking(int vm_fd)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d820a67b95..be3abb0824 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -479,6 +479,7 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
 
     mml->listener = mshv_memory_listener;
     mml->listener.name = name;
+    mml->mapped_regions = g_hash_table_new(g_direct_hash, g_direct_equal);
     memory_listener_register(&mml->listener, as);
     for (i = 0; i < s->nr_as; ++i) {
         if (!s->as[i].as) {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 1f77ffd152..89b44f387a 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -49,6 +49,7 @@ struct AccelCPUState {
 
 typedef struct MshvMemoryListener {
     MemoryListener listener;
+    GHashTable *mapped_regions;
     int as_id;
 } MshvMemoryListener;
 
-- 
2.34.1


