Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E160C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 07:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTmm-0004fH-NO; Wed, 23 Jul 2025 03:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkQ-0003LA-CX
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:48 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkM-00045r-TO
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753255119; x=1784791119;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=52oT5Itnfiv37Yuay+npj8js5KUzQMhQ5rorHPwD6W0=;
 b=WjoC7klbyXTAOxP7Pgvmw/PInskhH4WleynwPXBRnZS234vcZQs+MyXH
 TQr9b9rgziHIOdnmdGnvVdllAqSPoJbyl6FFf5862yWzOli/gH4aXb4QK
 D8Bf8YlFfowPLfREBNdOy2lc2J4r/2eLgQyBWGp24X/PRH5jRJA/sAQB6
 6ZH3pCg457JNSvq5cXtI6HW1c46qU+RUQrmgrO0FTFfDWG8Vzc2aLzQa4
 Ol6sZ8Ywqq2QaL7TvWXk66emDS+ZTaa5Ad21A9tej2lVOTDrW5UGLwU0+
 d29V3PEw/afNDsq3oPWnkCHdIJaULUSCLOxq8YEU6SPerZdpjuz3vNxX8 g==;
X-CSE-ConnectionGUID: gkSq5w0eRTqkpxjJCYoqjA==
X-CSE-MsgGUID: GtnUo8lxR7eZcDn7zTzNog==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55480932"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55480932"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 00:18:28 -0700
X-CSE-ConnectionGUID: 65/Bv/Q6RaKIHJy/0Rxgww==
X-CSE-MsgGUID: Eu7Bn4nmSw2igAIZ/X7Atw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="158662236"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 23 Jul 2025 00:18:27 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 3/3] accel/kvm: Set mem.guest_memfd_offset only when
 guest_memfd is valid
Date: Wed, 23 Jul 2025 15:09:51 +0800
Message-ID: <20250723070951.1134374-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723070951.1134374-1-xiaoyao.li@intel.com>
References: <20250723070951.1134374-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

Current QEMU unconditionally sets the mmem.guest_memfd_offset in
kvm_set_user_memory_region(), which leads to the trace of kvm_set_user_memory
look as:

kvm_set_user_memory AddrSpace#0 Slot#4 flags=0x2 gpa=0xe0000 size=0x20000 ua=0x7f5840de0000 guest_memfd=-1 guest_memfd_offset=0x3e0000 ret=0

It's confusing that the guest_memfd_offset has a non-zero value while
the guest_memfd is invalid (-1).

Change to only set guest_memfd_offset when guest_memfd is valid.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4f4c30fc84b2..2b6fbf58a127 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -367,7 +367,9 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
     mem.guest_memfd = slot->guest_memfd;
-    mem.guest_memfd_offset = slot->guest_memfd_offset;
+    if (slot->guest_memfd >= 0) {
+        mem.guest_memfd_offset = slot->guest_memfd_offset;
+    }
 
     if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
-- 
2.43.0


