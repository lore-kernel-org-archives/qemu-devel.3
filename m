Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE20E9D831
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 03:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9acm-000245-Uv; Sun, 05 Apr 2026 23:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huzy4@chinatelecom.cn>)
 id 1w9aKA-0003H2-Ud
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:08:26 -0400
Received: from smtph3-04.21cn.com ([150.223.194.106])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <huzy4@chinatelecom.cn>) id 1w9aK7-00063R-4N
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:08:26 -0400
HMM_SOURCE_IP: 172.27.0.101:0.1262061526
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-58.37.193.6 (unknown [172.27.0.101])
 by smtph3-04.21cn.com (HERMES) with SMTP id 08853C00D314;
 Mon,  6 Apr 2026 10:59:11 +0800 (CST)
X-189-SAVE-TO-SEND: +huzy4@chinatelecom.cn
Received: from  ([58.37.193.6])
 by gateway-ssl-dep-548b9f977f-v2mf7 with ESMTP id
 e731eab87c1e44fc871898a7b02ae7df for qemu-devel@nongnu.org; 
 Mon, 06 Apr 2026 10:59:22 CST
X-Transaction-ID: e731eab87c1e44fc871898a7b02ae7df
X-Real-From: huzy4@chinatelecom.cn
X-Receive-IP: 58.37.193.6
X-MEDUSA-Status: 0
From: Zhiyu Hu <huzy4@chinatelecom.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, philmd@linaro.org,
 Zhiyu Hu <huzy4@chinatelecom.cn>
Subject: [RFC PATCH] hw/i386/pc: split ram-below-4g at 1MB and prevent
 cross-boundary merging
Date: Mon,  6 Apr 2026 02:58:28 +0000
Message-ID: <20260406025828.22909-1-huzy4@chinatelecom.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.223.194.106;
 envelope-from=huzy4@chinatelecom.cn; helo=smtph3-04.21cn.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 05 Apr 2026 23:27:38 -0400
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

Split ram-below-4g into ram-below-1m and ram-1m-to-below-4g at the
1MB boundary in pc_memory_init().

Also prevent flatview_simplify() from merging FlatRanges across the
1MB boundary by adding a boundary check in can_merge(). Without this,
PAM attribute changes below 1MB cause the below-1MB range to re-merge
with the above-1MB range, triggering VFIO to unmap/remap the entire
merged region and creating a transient IOMMU mapping hole for active
device DMA (e.g. virtio-blk virtqueues) above 1MB.

Signed-off-by: Zhiyu Hu <huzy4@chinatelecom.cn>
---
 hw/i386/pc.c    | 30 +++++++++++++++++++++++++++---
 system/memory.c | 13 +++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b53b5be4a..4e9823e46f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -790,11 +790,35 @@ void pc_memory_init(PCMachineState *pcms,
     /*
      * Split single memory region and use aliases to address portions of it,
      * done for backwards compatibility with older qemus.
+     *
+     * Further split the below-4g region at the 1MB boundary so that PAM
+     * register updates (which only affect 0xC0000-0xFFFFF) do not cause
+     * the VFIO DMA listener to unmap/remap the entire below-4g range.
+     * This avoids a transient IOMMU mapping hole for virtqueue memory
+     * (above 1MB) when the BIOS reconfigures PAM during early boot.
      */
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
-                             0, x86ms->below_4g_mem_size);
-    memory_region_add_subregion(system_memory, 0, ram_below_4g);
+    if (x86ms->below_4g_mem_size <= 0x100000) {
+        memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g",
+                                 machine->ram,
+                                 0, x86ms->below_4g_mem_size);
+        memory_region_add_subregion(system_memory, 0, ram_below_4g);
+    } else {
+        MemoryRegion *ram_above_1m = g_malloc(sizeof(*ram_above_1m));
+
+        /* 0 ~ 1MB: affected by PAM/SMRAM overlays */
+        memory_region_init_alias(ram_below_4g, NULL, "ram-below-1m",
+                                 machine->ram,
+                                 0, 0x100000);
+        memory_region_add_subregion(system_memory, 0, ram_below_4g);
+
+        /* 1MB ~ below_4g_mem_size: not affected by PAM updates */
+        memory_region_init_alias(ram_above_1m, NULL, "ram-1m-to-below-4g",
+                                 machine->ram,
+                                 0x100000,
+                                 x86ms->below_4g_mem_size - 0x100000);
+        memory_region_add_subregion(system_memory, 0x100000, ram_above_1m);
+    }
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
diff --git a/system/memory.c b/system/memory.c
index 56f3225b21..28fc12e992 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -321,6 +321,19 @@ void flatview_unref(FlatView *view)
 
 static bool can_merge(FlatRange *r1, FlatRange *r2)
 {
+    /*
+     * Do not merge ranges across the 1MB (0x100000) boundary.
+     * PAM/SMRAM overlays frequently change attributes below 1MB,
+     * and merging with the large RAM region above 1MB would cause
+     * VFIO to unmap/remap the entire merged range on every PAM
+     * update, creating a transient IOMMU mapping hole for device
+     * DMA (e.g. virtio-blk virtqueues) in the above-1MB region.
+     */
+    if (int128_lt(r1->addr.start, int128_make64(0x100000))
+        && int128_ge(r2->addr.start, int128_make64(0x100000))) {
+        return false;
+    }
+
     return int128_eq(addrrange_end(r1->addr), r2->addr.start)
         && r1->mr == r2->mr
         && int128_eq(int128_add(int128_make64(r1->offset_in_region),
-- 
2.43.0


