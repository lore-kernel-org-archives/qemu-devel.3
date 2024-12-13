Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D635E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 07:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLznu-0007Yh-H2; Fri, 13 Dec 2024 02:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLzns-0007YN-RK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:36 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLznn-000714-SU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734073772; x=1765609772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vCYpc1Vq5+niHLJ2a/1T5SIiwGkK2cfUHuX+/Tv813o=;
 b=OmVWp7xSeSgq1bc79yRi9ylhu31WRnTKciOR9K35ng/vMf3YW20kPl0X
 KzlmjdlcX0S3sn4FRNfOhSJlnU1h3mYUwNLqMhK4mzvQIWboIPyJKBo+E
 ZKN8vXw9Qek7WvTEskGGtYaKFPm+FVNVJhNtDcrNo9TQwIQLXJesaLlLs
 EiqnCelr8rFz2vJkyEMuNjhdVtHsNyS7cBXSZNRG1QGe0FTUzbFHcAn6F
 mJtNTjeJQ7MmC79Nevq7PnYbCnqvRlAjjDdDVMukXpfCMXp79vu0IFgEW
 YYACjx3CB+x/rnesmmOBcGUyYtYxJYWUG4L65FZzNMeYIXilHgUny+rRg g==;
X-CSE-ConnectionGUID: TfZodG4rR66MXpO8Ej5K5w==
X-CSE-MsgGUID: 8CcSyo1tTiCFOd7vWpFZvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51937087"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="51937087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:29 -0800
X-CSE-ConnectionGUID: PkxAlT9xTnSNCm03DXVOsw==
X-CSE-MsgGUID: Z1jMnQXCQzuVd9eD3SkzhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="96365565"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:26 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 4/7] KVM: Notify the state change event during shared/private
 conversion
Date: Fri, 13 Dec 2024 15:08:46 +0800
Message-ID: <20241213070852.106092-5-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213070852.106092-1-chenyi.qiang@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce a helper to trigger the state_change() callback of the class.
Once exit to userspace to convert the page from private to shared or
vice versa at runtime, notify the event via the helper so that other
registered subsystems like VFIO can be notified.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 accel/kvm/kvm-all.c                  |  4 ++++
 include/sysemu/guest-memfd-manager.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 52425af534..38f41a98a5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -48,6 +48,7 @@
 #include "kvm-cpus.h"
 #include "sysemu/dirtylimit.h"
 #include "qemu/range.h"
+#include "sysemu/guest-memfd-manager.h"
 
 #include "hw/boards.h"
 #include "sysemu/stats.h"
@@ -3080,6 +3081,9 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    guest_memfd_manager_state_change(GUEST_MEMFD_MANAGER(mr->rdm), offset,
+                                     size, to_private);
+
     if (to_private) {
         if (rb->page_size != qemu_real_host_page_size()) {
             /*
diff --git a/include/sysemu/guest-memfd-manager.h b/include/sysemu/guest-memfd-manager.h
index f4b175529b..9dc4e0346d 100644
--- a/include/sysemu/guest-memfd-manager.h
+++ b/include/sysemu/guest-memfd-manager.h
@@ -46,4 +46,19 @@ struct GuestMemfdManagerClass {
                         bool shared_to_private);
 };
 
+static inline int guest_memfd_manager_state_change(GuestMemfdManager *gmm, uint64_t offset,
+                                                   uint64_t size, bool shared_to_private)
+{
+    GuestMemfdManagerClass *klass;
+
+    g_assert(gmm);
+    klass = GUEST_MEMFD_MANAGER_GET_CLASS(gmm);
+
+    if (klass->state_change) {
+        return klass->state_change(gmm, offset, size, shared_to_private);
+    }
+
+    return 0;
+}
+
 #endif
-- 
2.43.5


