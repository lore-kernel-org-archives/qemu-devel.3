Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD63ED1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DCi-0006wn-Kj; Tue, 05 Nov 2024 01:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DCY-0006qW-Po
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:07 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DCW-0001w0-Nk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788685; x=1762324685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+bsng0OpqwNAjJu2viZcM1uSHuVeOnU2MBD79mzkgE=;
 b=PUZBP6zLhSPTE2x7zaapKFJML+dBcd9elxC554SRoPtFvJWSZeoFPSLh
 rfr0Nr+O7VtG5EFVOGMnp8+6TuZppwBSrGl1jts1LMracpEDjLp1QeR9a
 cUJD8twJIKUL/p2vR+nF72yDNVG8W4VefLqJnTTqxVVNEYyIpqZtZEEkn
 66kxDgJ9BAxXNIFaHiYBGiywOzSjSD9WwZVaiSG7f40X1RMFjYSlJJrb7
 YrGOonus1hr4DNUa5SwZyla9dgf07VgmM+rNnoALc8qWLxemQbXTsRsfF
 U6AZ7ePh8nimLfpatF9o2TESyfEqixSE6Li7bYiiyEgM9RX9HvFIDNNXM A==;
X-CSE-ConnectionGUID: LTsvNPZcTAuvR8l1Thm0Xg==
X-CSE-MsgGUID: SxWbRQ7zQqSP4jOF0LI4Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689533"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689533"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:37:53 -0800
X-CSE-ConnectionGUID: igX+T3kWQlmGCs/qvn4FXA==
X-CSE-MsgGUID: flkki1dAQsOAxyMp0EcImg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988983"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:37:49 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 21/60] i386/tdx: Track mem_ptr for each firmware entry of
 TDVF
Date: Tue,  5 Nov 2024 01:23:29 -0500
Message-Id: <20241105062408.3533704-22-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

For each TDVF sections, QEMU needs to copy the content to guest
private memory via KVM API (KVM_TDX_INIT_MEM_REGION).

Introduce a field @mem_ptr for TdxFirmwareEntry to track the memory
pointer of each TDVF sections. So that QEMU can add/copy them to guest
private memory later.

TDVF sections can be classified into two groups:
 - Firmware itself, e.g., TDVF BFV and CFV, that located separately from
   guest RAM. Its memory pointer is the bios pointer.

 - Sections located at guest RAM, e.g., TEMP_MEM and TD_HOB.
   mmap a new memory range for them.

Register a machine_init_done callback to do the stuff.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/tdvf.c         |  1 +
 include/hw/i386/tdvf.h |  7 +++++++
 target/i386/kvm/tdx.c  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
index 4afa636bfa0e..535409f34b41 100644
--- a/hw/i386/tdvf.c
+++ b/hw/i386/tdvf.c
@@ -190,6 +190,7 @@ int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size)
     }
     g_free(sections);
 
+    fw->mem_ptr = flash_ptr;
     return 0;
 
 err:
diff --git a/include/hw/i386/tdvf.h b/include/hw/i386/tdvf.h
index 593341eb2e93..d880af245a73 100644
--- a/include/hw/i386/tdvf.h
+++ b/include/hw/i386/tdvf.h
@@ -39,13 +39,20 @@ typedef struct TdxFirmwareEntry {
     uint64_t size;
     uint32_t type;
     uint32_t attributes;
+
+    void *mem_ptr;
 } TdxFirmwareEntry;
 
 typedef struct TdxFirmware {
+    void *mem_ptr;
+
     uint32_t nr_entries;
     TdxFirmwareEntry *entries;
 } TdxFirmware;
 
+#define for_each_tdx_fw_entry(fw, e)    \
+    for (e = (fw)->entries; e != (fw)->entries + (fw)->nr_entries; e++)
+
 int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size);
 
 #endif /* HW_I386_TDVF_H */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 334dbe95cc77..6777f66a6451 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,9 +14,13 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/base64.h"
+#include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
+#include "sysemu/sysemu.h"
 
+#include "hw/i386/x86.h"
+#include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
@@ -126,6 +130,33 @@ void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
     tdx_guest->tdvf_mr = tdvf_mr;
 }
 
+static void tdx_finalize_vm(Notifier *notifier, void *unused)
+{
+    TdxFirmware *tdvf = &tdx_guest->tdvf;
+    TdxFirmwareEntry *entry;
+
+    for_each_tdx_fw_entry(tdvf, entry) {
+        switch (entry->type) {
+        case TDVF_SECTION_TYPE_BFV:
+        case TDVF_SECTION_TYPE_CFV:
+            entry->mem_ptr = tdvf->mem_ptr + entry->data_offset;
+            break;
+        case TDVF_SECTION_TYPE_TD_HOB:
+        case TDVF_SECTION_TYPE_TEMP_MEM:
+            entry->mem_ptr = qemu_ram_mmap(-1, entry->size,
+                                           qemu_real_host_page_size(), 0, 0);
+            break;
+        default:
+            error_report("Unsupported TDVF section %d", entry->type);
+            exit(1);
+        }
+    }
+}
+
+static Notifier tdx_machine_done_notify = {
+    .notify = tdx_finalize_vm,
+};
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(cgs);
@@ -140,6 +171,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
+
     tdx_guest = tdx;
     return 0;
 }
-- 
2.34.1


