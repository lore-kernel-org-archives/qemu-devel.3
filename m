Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459CFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsoV-0006R5-Ur; Thu, 25 Jul 2024 03:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoT-0006I1-W3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:58 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoR-0001Gw-Nn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892176; x=1753428176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PifPO2VLSml++/yyEHfyB9LD6kSBnEg6UWh8hpYvOM8=;
 b=eYmZfkh5hE4npvdwm3MiVwt7mMUbQjxrExr7yytsqRWKE8oFstwHROAo
 QHOe+DqJ3MnCRTJ+d1KYSpGssIp4F6yKWI0eWyHmJHL0vOGLXElvAwTdl
 eB+ITclFUJ9pUPR7MitmMSt8mbmjtpG/DMcjXYgpPE02tl3Q/x+6gA5Sq
 QU0J08rNkwwFgaoJYPU2TYD+TybP1KqRqEWtg3Yo3zj2urdxmCXJLK+8o
 on9fm8j/e3Z4qaOjHCFMHvb6jYnSM5D1OPmesBGm04C/84i660CBiYawm
 7Ry0YG12ZoWCgOTawIzbYZTUQeYitLHZAVx9ROEJ4qWZhvdGrReR4USNF g==;
X-CSE-ConnectionGUID: zJDEY3W1TEOjA7TJ+Sg0ag==
X-CSE-MsgGUID: MN/BdN2tQcaRi1jHrB4BeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30753988"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30753988"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:53 -0700
X-CSE-ConnectionGUID: gFgeME1KR7eAyTzj7cKk1A==
X-CSE-MsgGUID: xo48P9PiTWaGNySerO1iQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858168"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:50 -0700
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
Subject: [RFC PATCH 4/6] memory: Register the RamDiscardManager instance upon
 guest_memfd creation
Date: Thu, 25 Jul 2024 03:21:13 -0400
Message-ID: <20240725072118.358923-5-chenyi.qiang@intel.com>
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

Instantiate a new guest_memfd_manager object and register it in the
target MemoryRegion. From this point, other subsystems such as VFIO can
register their listeners in guest_memfd_manager and receive conversion
events through RamDiscardManager.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/physmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 33d09f7571..98072ae246 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,6 +53,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
+#include "sysemu/guest-memfd-manager.h"
 #include "trace/trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1861,6 +1862,12 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(object_new(TYPE_GUEST_MEMFD_MANAGER));
+        GuestMemfdManagerClass *gmmc = GUEST_MEMFD_MANAGER_GET_CLASS(gmm);
+        g_assert(new_block->mr);
+        gmmc->realize(OBJECT(gmm), new_block->mr, new_block->mr->size);
+        memory_region_set_ram_discard_manager(gmm->mr, RAM_DISCARD_MANAGER(gmm));
     }
 
     new_ram_size = MAX(old_ram_size,
@@ -2118,6 +2125,8 @@ static void reclaim_ramblock(RAMBlock *block)
 
     if (block->guest_memfd >= 0) {
         close(block->guest_memfd);
+        g_assert(block->mr);
+        object_unref(OBJECT(block->mr->rdm));
         ram_block_discard_require(false);
     }
 
-- 
2.43.5


