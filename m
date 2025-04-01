Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCE5C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbt7-0006RC-NK; Tue, 01 Apr 2025 09:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsw-0005sI-9V
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbss-0006ZP-PA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514950; x=1775050950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L0fA5jNVBrqO1OEsWr7LmOE7WG7UbY1S/6Fi3HN47DQ=;
 b=G1dARIoNWJpYtw8mFJDavYX9ng8U/gHvCyo/7rQ1sM8BbdDTbDXgfS8I
 8/kPb/tA0Y/bOtLZXFuGaIxBdYql9dxOzpGIg3GNtBOMgJrf9w/nyurU9
 K7wX+sTGbudJ1UWs4csBAvXcWuYUosm98322XYKIUdQoc6hXpQzwR6AoU
 ZHRjKM91tsAEVizGk1GQxXf27fLpVuFPA2nmS9jRtOjlGxfReZWwr8QcR
 cMVD06Jjhzwnb2tkTZUjJvAF64sOb2xbziPD77yn/fJxkKtEaFf+qE6f9
 wsHwiDUnCTFoFtz+ndge2JIJ4Kwqh5j8j3yjFhUFqU1Qd6FbmrE+xKncL Q==;
X-CSE-ConnectionGUID: S4df1yt6QfOdD6BWJ5Ztwg==
X-CSE-MsgGUID: 1RE/OVxPR6ejvpSmv8hhJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433323"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433323"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:05 -0700
X-CSE-ConnectionGUID: d5XoA9MNR5qfrubGKFIiRA==
X-CSE-MsgGUID: xUYwL9paRGiW6pdTcF896A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640039"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:03 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 21/55] i386/tdx: Track RAM entries for TDX VM
Date: Tue,  1 Apr 2025 09:01:31 -0400
Message-Id: <20250401130205.2198253-22-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The RAM of TDX VM can be classified into two types:

 - TDX_RAM_UNACCEPTED: default type of TDX memory, which needs to be
   accepted by TDX guest before it can be used and will be all-zeros
   after being accepted.

 - TDX_RAM_ADDED: the RAM that is ADD'ed to TD guest before running, and
   can be used directly. E.g., TD HOB and TEMP MEM that needed by TDVF.

Maintain TdxRamEntries[] which grabs the initial RAM info from e820 table
and mark each RAM range as default type TDX_RAM_UNACCEPTED.

Then turn the range of TD HOB and TEMP MEM to TDX_RAM_ADDED since these
ranges will be ADD'ed before TD runs and no need to be accepted runtime.

The TdxRamEntries[] are later used to setup the memory TD resource HOB
that passes memory info from QEMU to TDVF.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v3:
- use enum TdxRamType in struct TdxRamEntry; (Isaku)
- Fix the indention; (Daniel)

Changes in v1:
  - simplify the algorithm of tdx_accept_ram_range() (Suggested-by: Gerd Hoffman)
    (1) Change the existing entry to cover the accepted ram range.
    (2) If there is room before the accepted ram range add a
	TDX_RAM_UNACCEPTED entry for that.
    (3) If there is room after the accepted ram range add a
	TDX_RAM_UNACCEPTED entry for that.
---
 target/i386/kvm/tdx.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |  14 ++++++
 2 files changed, 125 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0885b99cfb88..072ffcdfb41d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,6 +18,7 @@
 #include "crypto/hash.h"
 #include "system/system.h"
 
+#include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -146,11 +147,117 @@ void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
     tdx_guest->tdvf_mr = tdvf_mr;
 }
 
+static void tdx_add_ram_entry(uint64_t address, uint64_t length,
+                              enum TdxRamType type)
+{
+    uint32_t nr_entries = tdx_guest->nr_ram_entries;
+    tdx_guest->ram_entries = g_renew(TdxRamEntry, tdx_guest->ram_entries,
+                                     nr_entries + 1);
+
+    tdx_guest->ram_entries[nr_entries].address = address;
+    tdx_guest->ram_entries[nr_entries].length = length;
+    tdx_guest->ram_entries[nr_entries].type = type;
+    tdx_guest->nr_ram_entries++;
+}
+
+static int tdx_accept_ram_range(uint64_t address, uint64_t length)
+{
+    uint64_t head_start, tail_start, head_length, tail_length;
+    uint64_t tmp_address, tmp_length;
+    TdxRamEntry *e;
+    int i;
+
+    for (i = 0; i < tdx_guest->nr_ram_entries; i++) {
+        e = &tdx_guest->ram_entries[i];
+
+        if (address + length <= e->address ||
+            e->address + e->length <= address) {
+            continue;
+        }
+
+        /*
+         * The to-be-accepted ram range must be fully contained by one
+         * RAM entry.
+         */
+        if (e->address > address ||
+            e->address + e->length < address + length) {
+            return -EINVAL;
+        }
+
+        if (e->type == TDX_RAM_ADDED) {
+            return -EINVAL;
+        }
+
+        break;
+    }
+
+    if (i == tdx_guest->nr_ram_entries) {
+        return -1;
+    }
+
+    tmp_address = e->address;
+    tmp_length = e->length;
+
+    e->address = address;
+    e->length = length;
+    e->type = TDX_RAM_ADDED;
+
+    head_length = address - tmp_address;
+    if (head_length > 0) {
+        head_start = tmp_address;
+        tdx_add_ram_entry(head_start, head_length, TDX_RAM_UNACCEPTED);
+    }
+
+    tail_start = address + length;
+    if (tail_start < tmp_address + tmp_length) {
+        tail_length = tmp_address + tmp_length - tail_start;
+        tdx_add_ram_entry(tail_start, tail_length, TDX_RAM_UNACCEPTED);
+    }
+
+    return 0;
+}
+
+static int tdx_ram_entry_compare(const void *lhs_, const void* rhs_)
+{
+    const TdxRamEntry *lhs = lhs_;
+    const TdxRamEntry *rhs = rhs_;
+
+    if (lhs->address == rhs->address) {
+        return 0;
+    }
+    if (le64_to_cpu(lhs->address) > le64_to_cpu(rhs->address)) {
+        return 1;
+    }
+    return -1;
+}
+
+static void tdx_init_ram_entries(void)
+{
+    unsigned i, j, nr_e820_entries;
+
+    nr_e820_entries = e820_get_table(NULL);
+    tdx_guest->ram_entries = g_new(TdxRamEntry, nr_e820_entries);
+
+    for (i = 0, j = 0; i < nr_e820_entries; i++) {
+        uint64_t addr, len;
+
+        if (e820_get_entry(i, E820_RAM, &addr, &len)) {
+            tdx_guest->ram_entries[j].address = addr;
+            tdx_guest->ram_entries[j].length = len;
+            tdx_guest->ram_entries[j].type = TDX_RAM_UNACCEPTED;
+            j++;
+        }
+    }
+    tdx_guest->nr_ram_entries = j;
+}
+
 static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
 
+    tdx_init_ram_entries();
+
     for_each_tdx_fw_entry(tdvf, entry) {
         switch (entry->type) {
         case TDVF_SECTION_TYPE_BFV:
@@ -166,12 +273,16 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
                              entry->type);
                 exit(1);
             }
+            tdx_accept_ram_range(entry->address, entry->size);
             break;
         default:
             error_report("Unsupported TDVF section %d", entry->type);
             exit(1);
         }
     }
+
+    qsort(tdx_guest->ram_entries, tdx_guest->nr_ram_entries,
+          sizeof(TdxRamEntry), &tdx_ram_entry_compare);
 }
 
 static Notifier tdx_machine_done_notify = {
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 28a03c2a7b82..36a7400e7480 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -20,6 +20,17 @@ typedef struct TdxGuestClass {
 /* TDX requires bus frequency 25MHz */
 #define TDX_APIC_BUS_CYCLES_NS 40
 
+enum TdxRamType {
+    TDX_RAM_UNACCEPTED,
+    TDX_RAM_ADDED,
+};
+
+typedef struct TdxRamEntry {
+    uint64_t address;
+    uint64_t length;
+    enum TdxRamType type;
+} TdxRamEntry;
+
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
@@ -34,6 +45,9 @@ typedef struct TdxGuest {
 
     MemoryRegion *tdvf_mr;
     TdxFirmware tdvf;
+
+    uint32_t nr_ram_entries;
+    TdxRamEntry *ram_entries;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.34.1


