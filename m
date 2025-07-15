Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F4CC83F10
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 03:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubWWa-0004Ak-Ed; Mon, 14 Jul 2025 23:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWX-00049S-T0
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:10 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWV-0006Rk-Rh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752550808; x=1784086808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=337nkqGcMNjO0TXjHY3O+IoJvy4v6WC372UutXb1xJ4=;
 b=Fvz5MghPudgFqGuGi/U+ekKWXxP6Gqbnl22Pna5L88KmH/pNwdEFZC5Z
 +zL5eo5knTh58pPgEHUz3SF5XzZkSDfHAI4Hvp0+qb+m+eo0uwezVM5MR
 zgvWbw9JWwq+FY6EH2g1vbphjs68+BdL5RDlNEfOmAl5vZFud7eI0iqEv
 0HUgJFD61VI26FpuHCzuPJ5rD/G9jPThCRzjYyU8drIqSV1NgqIN51Kdj
 OprEGwW3xhtN+Gg7BKDsTnhzO/k0qpr7i8OuxMaF0/a7qitPpGYmMx9dW
 d+mIRbCF9m4TrMaAwos4iE7teU4BptjOB5AlW56twOAxMGYxuyoku5CTq g==;
X-CSE-ConnectionGUID: B4Dpc/shSM+G2Yg3LWzn5A==
X-CSE-MsgGUID: EeU0YNXySK6DBAD4z0TLsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72334940"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="72334940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 20:40:07 -0700
X-CSE-ConnectionGUID: BySPT4tMS0OtYrtHF6wKWQ==
X-CSE-MsgGUID: WfFHQ5O7Q6qMylZNFgEpnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="180808164"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 14 Jul 2025 20:40:04 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 ackerleytng@google.com, seanjc@google.com
Cc: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>,
 rick.p.edgecombe@intel.com, Kai Huang <kai.huang@intel.com>,
 binbin.wu@linux.intel.com, yan.y.zhao@intel.com, ira.weiny@intel.com,
 michael.roth@amd.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [POC PATCH 4/5] memory/guest_memfd: Enable hugetlb support
Date: Tue, 15 Jul 2025 11:31:40 +0800
Message-ID: <20250715033141.517457-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715033141.517457-1-xiaoyao.li@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <20250715033141.517457-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

(This is just the POC code to use gmem with hugetlb.)

Try with hugetlb first when hugetlb is supported by gmem. If hugetlb
cannot afford the requested memory size and returns -ENOMEM, fallback to
create gmem withtout hugetlb.

The hugetlb size is hardcoded as GUESTMEM_HUGETLB_FLAG_2MB. I'm not sure
if it will be better if gmem can report the supported hugetlb size.
But look at the current implementation of memfd, it just tries with
the requested hugetlb size from user and fail when not supported.
Hence gmem can do the same way without the supported size being
enuemrated.

For a upstreamable solution, the hugetlb support of gmem can be
implemented as "hugetlb" and "hugetlbsize" properties of
memory-backend-guestmemfd as similar of memory-backend-memfd. (It
requires memory-backed-guestmemfd introduced for in-place conversion
gmem at first)

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c    |  3 ++-
 accel/stubs/kvm-stub.c |  1 +
 include/system/kvm.h   |  1 +
 system/physmem.c       | 13 +++++++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 609537738d38..2d18e961714e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -106,6 +106,7 @@ static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
 bool kvm_guest_memfd_inplace_supported;
+bool kvm_guest_memfd_hugetlb_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2808,6 +2809,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_guest_memfd_inplace_supported =
         kvm_check_extension(s, KVM_CAP_GMEM_SHARED_MEM) &&
         kvm_check_extension(s, KVM_CAP_GMEM_CONVERSION);
+    kvm_guest_memfd_hugetlb_supported = kvm_check_extension(s, KVM_CAP_GMEM_HUGETLB);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
@@ -4536,7 +4538,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-        return -1;
     }
 
     return fd;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index bf0ccae27b62..fbc1d7c4e9b5 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -25,6 +25,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_msi_use_devid;
 bool kvm_guest_memfd_inplace_supported;
+bool kvm_guest_memfd_hugetlb_supported;
 
 void kvm_flush_coalesced_mmio_buffer(void)
 {
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 32f2be5f92e1..d1d79510ee26 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -44,6 +44,7 @@ extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
 extern bool kvm_pre_fault_memory_supported;
 extern bool kvm_guest_memfd_inplace_supported;
+extern bool kvm_guest_memfd_hugetlb_supported;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
diff --git a/system/physmem.c b/system/physmem.c
index 955480685310..ea1c27ea2b99 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1940,8 +1940,21 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                             GUEST_MEMFD_FLAG_INIT_PRIVATE;
         }
 
+        if (kvm_guest_memfd_hugetlb_supported) {
+            new_block->guest_memfd_flags |= GUEST_MEMFD_FLAG_HUGETLB |
+                                            GUESTMEM_HUGETLB_FLAG_2MB;
+        }
+
+        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
+                                 new_block->guest_memfd_flags, &err);
+        if (new_block->guest_memfd == -ENOMEM) {
+            error_free(err);
+            new_block->guest_memfd_flags &= ~(GUEST_MEMFD_FLAG_HUGETLB |
+                                              GUESTMEM_HUGETLB_FLAG_2MB);
+        }
         new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
                                  new_block->guest_memfd_flags, errp);
+
         if (new_block->guest_memfd < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
-- 
2.43.0


