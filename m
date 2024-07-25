Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184A9C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsoW-0006RO-0w; Thu, 25 Jul 2024 03:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoP-00060b-Hg
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:53 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoM-0001Gw-Rn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892171; x=1753428171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PzDthdOyXi8jqps5YCnKqKm2ZMk1q6Qbjz/AdVU9fYE=;
 b=e4fM1FUJLzU/+FWrqn4xTI4YNCVqmHxEnvREricLtOy+KqoR4vKxFDlj
 I841c0xBhyy65RtdvwLpc//JwwLZjRjTfr806ZPtchGqD8QbuCb2pdO8n
 tAG/Ol0XsOneQeCyRxLgOyfmlUEDN+Sp5Nlqnr0QVqwXs78vWW73PWaKd
 m2oR5mp0vEIeb5Mq+u1qnH/tBUbSDhw2JfKASqVdRdmtl3+WR3wnYHwNo
 i6Y2KwV2t7ACw1BorDrAz1ul4GlwmZGpgmRVxp48VO9GH7FAJX1g9pcif
 3VqH4Sls4A4oPMoRRYvtpS39+GsXmNt6B0a2wtZHeqhFQWRVSqmuh8vlh A==;
X-CSE-ConnectionGUID: pUPC0BqpRneFXvz0blCSwQ==
X-CSE-MsgGUID: 4/rO0yr2TCWijGeQf7/Y3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30753963"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30753963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:50 -0700
X-CSE-ConnectionGUID: BmOnfm53TROM4l4nb2FKiw==
X-CSE-MsgGUID: 1Cs7+M5qSK6v2R8gqF5zBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858161"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:46 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH 3/6] KVM: Notify the state change via RamDiscardManager
 helper during shared/private conversion
Date: Thu, 25 Jul 2024 03:21:12 -0400
Message-ID: <20240725072118.358923-4-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240725072118.358923-1-chenyi.qiang@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Once exit to userspace to convert the page from private to shared or
vice versa at runtime, notify the state change via the
guest_memfd_state_change() helper so that other registered subsystems
like VFIO can be notified.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 accel/kvm/kvm-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 854cb86b22..94bbbbd2de 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -48,6 +48,7 @@
 #include "kvm-cpus.h"
 #include "sysemu/dirtylimit.h"
 #include "qemu/range.h"
+#include "sysemu/guest-memfd-manager.h"
 
 #include "hw/boards.h"
 #include "sysemu/stats.h"
@@ -2852,6 +2853,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     RAMBlock *rb;
     void *addr;
     int ret = -1;
+    GuestMemfdManager *gmm;
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
 
@@ -2914,6 +2916,11 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    gmm = GUEST_MEMFD_MANAGER(mr->rdm);
+    if (gmm) {
+        guest_memfd_state_change(gmm, offset, size, to_private);
+    }
+
     if (to_private) {
         if (rb->page_size != qemu_real_host_page_size()) {
             /*
-- 
2.43.5


