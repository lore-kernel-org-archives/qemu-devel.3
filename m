Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9E8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa7y-0000XI-Tq; Thu, 29 Feb 2024 01:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa7o-0000Ns-2q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:42:37 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa7l-0004qw-8T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188953; x=1740724953;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z/FfjECQSUX/uPyyzFkqQxNReR6RwWQF44mKqaJHFI0=;
 b=dC6SzoAi7bSVAzS4af/piFN3tiS09wILJDRF0pegjXskXAYXqYAVTZXB
 x2OdGH0FOavPHvhIgOKduopTnMysnAQKgZHn4KDi7aP3F4yuDOH+GRtP2
 I35ad4mJKUhSfiyKl4+QuTrKhE2wC3q2KIERa4FQI1oF7L3gMdi02Y/CV
 kCMG9gG3/8aVL+cLila+2K/sUieAisngjNkWwnyI5iPeQM09qRqVPq8ra
 0YOvk9S0mZZWAKUUn5VoAinHEH9K3xsaUYfD+sVSnoH+vuG9YZeQHYrNt
 xn10BIA24r3V9wxgBhbcXupGHtNqeYpvALjkwGcqbla1VUEvUQkjPtuux Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3803033"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3803033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8076054"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:42:24 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 45/65] i386/tdx: Populate TDVF private memory via
 KVM_MEMORY_MAPPING
Date: Thu, 29 Feb 2024 01:37:06 -0500
Message-Id: <20240229063726.610065-46-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
memory, as well as TD HOB and TEMP memory.

If the TDVF section has TDVF_SECTION_ATTRIBUTES_MR_EXTEND set in the
flag, calling KVM_TDX_EXTEND_MEMORY to extend the measurement.

After populating the TDVF memory, the original image located in shared
ramblock can be discarded.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>

---
Changes in v1:
  - rename variable @metadata to @flags
---
 target/i386/kvm/tdx.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fb9c60172fde..dcabe359eda5 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -595,6 +595,8 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
+    RAMBlock *ram_block;
+    int r;
 
     tdx_init_ram_entries();
 
@@ -620,6 +622,51 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
           sizeof(TdxRamEntry), &tdx_ram_entry_compare);
 
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
+
+    for_each_tdx_fw_entry(tdvf, entry) {
+        struct kvm_memory_mapping mapping = {
+            .base_gfn = entry->address >> 12,
+            .nr_pages = entry->size >> 12,
+            .source = (__u64)entry->mem_ptr,
+        };
+
+        do {
+            r = kvm_vcpu_ioctl(first_cpu, KVM_MEMORY_MAPPING, &mapping);
+        } while (r == -EAGAIN);
+
+        if (r < 0) {
+             error_report("KVM_MEMORY_MAPPING failed %s", strerror(-r));
+             exit(1);
+        }
+
+        if (entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND) {
+            mapping = (struct kvm_memory_mapping) {
+                .base_gfn = entry->address >> 12,
+                .nr_pages = entry->size >> 12,
+            };
+
+            do {
+                r = tdx_vm_ioctl(KVM_TDX_EXTEND_MEMORY, 0, &mapping);
+            } while (r == -EAGAIN);
+            if (r < 0) {
+                error_report("KVM_TDX_EXTEND_MEMORY failed %s", strerror(-r));
+                exit(1);
+            }
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
2.34.1


