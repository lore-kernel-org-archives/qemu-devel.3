Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CC9C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNL3-0005n3-L5; Mon, 28 Jul 2025 08:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcM-0006Qg-OI
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:11 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcF-0006gd-UO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753704364; x=1785240364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IV8iEfmq1zTpbU9+OYQ73jjYB45ZmpcAWAnHj52uhSY=;
 b=QuCclYvfpEz0zVZet174XniG8Lj9w3KBmpcmvjfr/SBhj11HKE8kZ/yd
 nmHUdlGpHQriuqzzfamFVxQwt0f/fKxYVYGZkONWmi043wj0FzvB6wyAd
 fLizbYWDyD1iw8WqwWtqXwC5eXpabphQ4XgAGbg3IQY2gOCN9nXXdhK2A
 QvXBpkJofOsB9wCYCw4zXKpGfafciG4Pieeu4uXwE1hNocFVKDuHXIxWo
 rCu30c86RwDmOR2ky8v1DK4joyywi1v8ehpS12gbBcMboKFBpPv0tIaHC
 HlSza+hVTqlMQ8IHaiZ3wu4PLbeMYIrXrMgmE7/X7+db6aXJQfYcEbfpP A==;
X-CSE-ConnectionGUID: sJR5uebeSG2CgkqbpSexSA==
X-CSE-MsgGUID: l0ngZA/LSV6eKHF4Jh+1fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59755648"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59755648"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:06:00 -0700
X-CSE-ConnectionGUID: v3+v0K1xT9eFGE5QbQoSUQ==
X-CSE-MsgGUID: ObnGkewGQuCBt2Tqo2PhRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162448051"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Jul 2025 05:05:59 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 2/3] accel/kvm: Zero out mem explicitly in
 kvm_set_user_memory_region()
Date: Mon, 28 Jul 2025 19:57:06 +0800
Message-ID: <20250728115707.1374614-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728115707.1374614-1-xiaoyao.li@intel.com>
References: <20250728115707.1374614-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
changes in v2:
- using {} instead of memset(); (suggested by Philippe)
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 14d47246ca63..90f3b177a1ff 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -358,7 +358,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
-    struct kvm_userspace_memory_region2 mem;
+    struct kvm_userspace_memory_region2 mem = {};
     int ret;
 
     mem.slot = slot->slot | (kml->as_id << 16);
-- 
2.43.0


