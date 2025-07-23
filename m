Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512B4C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 07:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTmx-0004qo-4Y; Wed, 23 Jul 2025 03:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkM-0003Kh-Hc
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:41 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkG-00046A-KL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753255113; x=1784791113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qJZpNmIiyzLZ+1AQHuc1dq2zIeu4XixLkbA12OZ7a+k=;
 b=PRb1drwd3w0XEsSzXHk6m2gjferbhaSKpQT8XABN9VyStaotCHPOhupH
 59PyhWUXBodx4UEv+2GBU0JyIDGnhKZUd5CO/O8EtYISY5LazGXfrsZA0
 efADUSremSv44o8kyqF1J2wAaEp+gJTD3abWWL0HTmMlrTSiAdHeFPCD2
 fwcx1ZFs65rGra+zcQzATePyN+IbK25TPJy1kbsoU1tbK3tW2nXEB9Wi9
 nmN0+18LMhR7t+x5PgfAH/O664MRAClNawIjPF7CN+NQUfWkRk2nSU6go
 M4ssfMW2J5Fz+5/5hNWJXAMtNzo0KC75rdb1vHuEbrTrAZ0qRIdwgBVFk Q==;
X-CSE-ConnectionGUID: Txvnx8XQSG+oI/MrV0ss1g==
X-CSE-MsgGUID: JvBZ8XwpR+yNfgh9PNoG1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55480929"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55480929"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 00:18:27 -0700
X-CSE-ConnectionGUID: fJ4CRkcgQTKpSoww9sNvFg==
X-CSE-MsgGUID: tC4EPSiJR4mPv5b1062cEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="158662233"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 23 Jul 2025 00:18:25 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/3] accel/kvm: Zero out mem explicitly in
 kvm_set_user_memory_region()
Date: Wed, 23 Jul 2025 15:09:50 +0800
Message-ID: <20250723070951.1134374-3-xiaoyao.li@intel.com>
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

Zero out the entire mem explicitly before it's used, to ensure the unused
feilds (pad1, pad2) are all zeros. Otherwise, it might cause problem when
the pad fields are extended by future KVM.

Fixes: ce5a983233b4 ("kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 14d47246ca63..4f4c30fc84b2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -361,6 +361,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
     struct kvm_userspace_memory_region2 mem;
     int ret;
 
+    memset(&mem, 0, sizeof(mem));
     mem.slot = slot->slot | (kml->as_id << 16);
     mem.guest_phys_addr = slot->start_addr;
     mem.userspace_addr = (unsigned long)slot->ram;
-- 
2.43.0


