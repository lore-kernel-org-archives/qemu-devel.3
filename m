Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D66CC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNKl-0002ve-FP; Mon, 28 Jul 2025 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcU-0000er-D5
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:18 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcO-0006gd-NL
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753704373; x=1785240373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A8X/oNNt3W+yZsMLySvP4Wg+djHSi0ZYoJCDENTqZvs=;
 b=Nv4Wz3yTdNfGRBp+s3vxTpvaAVuchURKh7wCJc+MuRoKlqtmF8RCl5HX
 IwmyRwarfoH2FEu4VjoxItgFt7HpF431im+xkHC6C/I7NdZr6zdKdENAy
 tdCdjI4cL3DKoI2tPTgCAQLyYsvMour/nrX/7CpC48VfpECfHZwoEilJg
 gn+Kv9/FDtNPvyHIIxeGLw9o/EUcw4R9v3wf1QwsSeCBsBhlFraRQHUEZ
 8TEl8gwZB2vTpMCCUoJHwv9GxUJA0b2Kr5THFzSAH1d3Fxtl8pfnkGRFT
 s4a5FNSMmAm+5OZK4HOy9j10vZRu6AZmVHLVUGmYS65qIl+2ZT8FF7FME A==;
X-CSE-ConnectionGUID: z24kcERdR4O3+wcNPizKPg==
X-CSE-MsgGUID: jNCL0Hl0SeKXc1otdT1WTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59755656"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59755656"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:06:01 -0700
X-CSE-ConnectionGUID: HkfYL0nIQwiitS+4JV2Ppg==
X-CSE-MsgGUID: 7+vw4gQbSKySyQeB8tBoKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162448062"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Jul 2025 05:06:00 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 3/3] accel/kvm: Set guest_memfd_offset to non-zero value
 only when guest_memfd is valid
Date: Mon, 28 Jul 2025 19:57:07 +0800
Message-ID: <20250728115707.1374614-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728115707.1374614-1-xiaoyao.li@intel.com>
References: <20250728115707.1374614-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Current QEMU unconditionally sets the guest_memfd_offset of KVMSlot in
kvm_set_phys_mem(), which leads to the trace of kvm_set_user_memory looks:

kvm_set_user_memory AddrSpace#0 Slot#4 flags=0x2 gpa=0xe0000 size=0x20000 ua=0x7f5840de0000 guest_memfd=-1 guest_memfd_offset=0x3e0000 ret=0

It's confusing that the guest_memfd_offset has a non-zero value while
the guest_memfd is invalid (-1).

Change to only set guest_memfd_offset when guest_memfd is valid and
leave it as 0 when no valid guest_memfd.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v2:
- initialize guest_memfd_offset in kvm_set_phys_mem(); (Phillippe)
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 90f3b177a1ff..cc694fe3c3a9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1595,7 +1595,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
         mem->guest_memfd = mr->ram_block->guest_memfd;
-        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
+        mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
+                                  (uint8_t*)ram - mr->ram_block->host : 0;
 
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
-- 
2.43.0


