Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB92C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2pr-0003yF-0K; Thu, 08 May 2025 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pZ-0003Q5-L7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:40 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pW-0007RF-Sl
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716795; x=1778252795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D4IRLcKZtl5/KG1JlFXyQKH3kpmLXgl1SrfSklWW7eE=;
 b=O9w3N2nse0GLxyZjRmpfR9MtxnIzigWmG3MiG29qsjzRgf9gMxaNgR6j
 fplZGCxO8LAT9P6vj42TFQD4fQ+tL62KFBUwLiS4AypUkV+fqmJ++SgKZ
 YLvv0zmSuTs0kvXOktDsCxrg6UpJIQyJFXR8zpaEJ6tbf5spCJKi4I1rz
 IblCEZEizfh622dLWfbIzLpcqbENUP7FipBFRFoqXm6nLPNSQ2ssHE/MH
 llJT96EOnYTak5U05MEiRHT82SeDVdqjL+075RgBIe9e1pfgxuz79dZ5J
 gtcocTM48TeouQ/R0Ju7PqFfrPXx9Ds7h8A+8YZkeqoZa1lhNpfBFfWoO w==;
X-CSE-ConnectionGUID: trjhHS4OR4qlbyZ+qGdDZA==
X-CSE-MsgGUID: 5CHZ7g3QTOemuZsdvv04ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888197"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:09 -0700
X-CSE-ConnectionGUID: OMZyKA3QRXSqyXN3LLQ5jQ==
X-CSE-MsgGUID: 8l6jpUgeRjWjKw70km2Wzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440025"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:06 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 24/55] i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
Date: Thu,  8 May 2025 10:59:30 -0400
Message-ID: <20250508150002.689633-25-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDVF firmware (CODE and VARS) needs to be copied to TD's private
memory via KVM_TDX_INIT_MEM_REGION, as well as TD HOB and TEMP memory.

If the TDVF section has TDVF_SECTION_ATTRIBUTES_MR_EXTEND set in the
flag, calling KVM_TDX_EXTEND_MEMORY to extend the measurement.

After populating the TDVF memory, the original image located in shared
ramblock can be discarded.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v6:
 - switch back to use KVM_TDX_INIT_MEM_REGION according to KVM's change;
---
 target/i386/kvm/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index de682a93e51c..6a9215d9f0d7 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -17,6 +17,7 @@
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
 #include "system/system.h"
+#include "exec/ramblock.h"
 
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
@@ -269,6 +270,9 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
+    RAMBlock *ram_block;
+    Error *local_err = NULL;
+    int r;
 
     tdx_init_ram_entries();
 
@@ -304,6 +308,44 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
           sizeof(TdxRamEntry), &tdx_ram_entry_compare);
 
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
+
+    for_each_tdx_fw_entry(tdvf, entry) {
+        struct kvm_tdx_init_mem_region region;
+        uint32_t flags;
+
+        region = (struct kvm_tdx_init_mem_region) {
+            .source_addr = (uint64_t)entry->mem_ptr,
+            .gpa = entry->address,
+            .nr_pages = entry->size >> 12,
+        };
+
+        flags = entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND ?
+                KVM_TDX_MEASURE_MEMORY_REGION : 0;
+
+        do {
+            error_free(local_err);
+            local_err = NULL;
+            r = tdx_vcpu_ioctl(first_cpu, KVM_TDX_INIT_MEM_REGION, flags,
+                               &region, &local_err);
+        } while (r == -EAGAIN || r == -EINTR);
+        if (r < 0) {
+            error_report_err(local_err);
+            exit(1);
+        }
+
+        if (entry->type == TDVF_SECTION_TYPE_TD_HOB ||
+            entry->type == TDVF_SECTION_TYPE_TEMP_MEM) {
+            qemu_ram_munmap(-1, entry->mem_ptr, entry->size);
+            entry->mem_ptr = NULL;
+        }
+    }
+
+    /*
+     * TDVF image has been copied into private region above via
+     * KVM_MEMORY_MAPPING. It becomes useless.
+     */
+    ram_block = tdx_guest->tdvf_mr->ram_block;
+    ram_block_discard_range(ram_block, 0, ram_block->max_length);
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.43.0


