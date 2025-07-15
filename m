Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797D7C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 03:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubWWS-00046Z-UY; Mon, 14 Jul 2025 23:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWR-00045J-1G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:03 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWO-0006Rk-Vy
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752550801; x=1784086801;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q4SUK8FgUWLQ+4A301fwccsLC3/hT+jdFcVfpJvYn+8=;
 b=mv2jQ3l+hDHFdztn9cVsxN0L/PssMjyQseLJZHylZQ+MZjN6x8/hCUsq
 5xMhxMj2NNF3P7b2crbw57ubGT3nWCwAmW3UBkbEDFbscsorPyyEz+r0k
 KEq0YwSdYvg8Wp93ZJQ4jCQQt8a6xs3o2jmE+xFon70YiVOf0cOaMawk6
 yQr7uWSTk1UX+gqOKBYD2VmPKX7wz56I74MUySlmg7St0BuPKMsu3EebU
 8vkfpF2Oc8DTbFc0TPihOzGzUO/mTgWImKDp+4XtTQhFXqTKxpQ+AtVD7
 2YQtdAK/u1VSiaH35Is+F+N5+E833plss6Uy/e2d5p0cOZTQUn9mSpYS3 w==;
X-CSE-ConnectionGUID: OIa+c+qqTrWpv/GcbcJdEA==
X-CSE-MsgGUID: cMOcKwo+Sc2kexls5ARLgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72334926"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="72334926"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 20:40:00 -0700
X-CSE-ConnectionGUID: xwHQgJYWS6Waa1s9cAT7Hg==
X-CSE-MsgGUID: C+4jFUV2S3CD/bdO7Y/0qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="180808100"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 14 Jul 2025 20:39:56 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 ackerleytng@google.com, seanjc@google.com
Cc: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>,
 rick.p.edgecombe@intel.com, Kai Huang <kai.huang@intel.com>,
 binbin.wu@linux.intel.com, yan.y.zhao@intel.com, ira.weiny@intel.com,
 michael.roth@amd.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [POC PATCH 2/5] headers: Fetch gmem updates
Date: Tue, 15 Jul 2025 11:31:38 +0800
Message-ID: <20250715033141.517457-3-xiaoyao.li@intel.com>
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 linux-headers/linux/guestmem.h | 29 +++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h      | 18 ++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 linux-headers/linux/guestmem.h

diff --git a/linux-headers/linux/guestmem.h b/linux-headers/linux/guestmem.h
new file mode 100644
index 000000000000..be045fbad230
--- /dev/null
+++ b/linux-headers/linux/guestmem.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_GUESTMEM_H
+#define _LINUX_GUESTMEM_H
+
+/*
+ * Huge page size must be explicitly defined when using the guestmem_hugetlb
+ * allocator for guest_memfd.  It is the responsibility of the application to
+ * know which sizes are supported on the running system.  See mmap(2) man page
+ * for details.
+ */
+
+#define GUESTMEM_HUGETLB_FLAG_SHIFT	58
+#define GUESTMEM_HUGETLB_FLAG_MASK	0x3fUL
+
+#define GUESTMEM_HUGETLB_FLAG_16KB	(14UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_64KB	(16UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_512KB	(19UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_1MB	(20UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_2MB	(21UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_8MB	(23UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_16MB	(24UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_32MB	(25UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_256MB	(28UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_512MB	(29UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_1GB	(30UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_2GB	(31UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_16GB	(34UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+
+#endif /* _LINUX_GUESTMEM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 32c5885a3c20..ff9ef5fb37c5 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -952,6 +952,9 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
+#define KVM_CAP_GMEM_SHARED_MEM 240
+#define KVM_CAP_GMEM_CONVERSION 241
+#define KVM_CAP_GMEM_HUGETLB 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1589,12 +1592,27 @@ struct kvm_memory_attributes {
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 
+#define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
+#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
+#define GUEST_MEMFD_FLAG_HUGETLB	(1UL << 2)
+
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
 	__u64 reserved[6];
 };
 
+#define KVM_GMEM_IO 0xAF
+#define KVM_GMEM_CONVERT_SHARED		_IOWR(KVM_GMEM_IO,  0x41, struct kvm_gmem_convert)
+#define KVM_GMEM_CONVERT_PRIVATE	_IOWR(KVM_GMEM_IO,  0x42, struct kvm_gmem_convert)
+
+struct kvm_gmem_convert {
+	__u64 offset;
+	__u64 size;
+	__u64 error_offset;
+	__u64 reserved[5];
+};
+
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
 
 struct kvm_pre_fault_memory {
-- 
2.43.0


