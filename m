Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB1EC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 07:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTnP-00055x-KJ; Wed, 23 Jul 2025 03:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkM-0003Kg-HP
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:41 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkD-000462-5E
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753255109; x=1784791109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RGlSGzGkbqVhDC4KFQQiXuDi9zm1hRpG1NVXQpKek9Q=;
 b=J5GavlPy86R9VVIDACBJ7dq2hLOVfrhABmvAKZZ54fnYcqnVzg7hXmKw
 NoeOSxfRfvjRJ9zlBQCt3vSCMAT3pbJDxq0xcetUoNNA3uGj+eHT7ztBI
 g959MtCbXWkpP6PKsa0yx3TLe8y/R9ZOhLyHaEEAGeftTF9cNBBzrhLfH
 rtIKL9NEMAeUOWOxFOw+n/bslu3kjak7AR2ToxmWTRf4IsOqnLkA++zux
 fn5z625O+UNSoecIWOy3voH83TUmCs/7V/FvyBL01d0XcZyQkY2zcWkic
 t4jMHPfKKdYDdikg1f0i0S5bSMv3e3eaMj66ZJ+cJvvhhXYwDbCUGW+oV g==;
X-CSE-ConnectionGUID: jE/VpIETTL6EDAwy3q5mgQ==
X-CSE-MsgGUID: 3ogMPxIoQj6A3ETMTZyr2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55480927"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55480927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 00:18:25 -0700
X-CSE-ConnectionGUID: 4uwKOySYRaemS04dhPyBgQ==
X-CSE-MsgGUID: rWvhmVwzRNOdFVYyKrTDSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="158662230"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 23 Jul 2025 00:18:24 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/3] accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
 KVM_CAP_USER_MEMORY2 on VM
Date: Wed, 23 Jul 2025 15:09:49 +0800
Message-ID: <20250723070951.1134374-2-xiaoyao.li@intel.com>
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

It returns more accruate result on checking KVM_CAP_GUEST_MEMFD and
KVM_CAP_USER_MEMORY2 on VM instance instead of on KVM platform.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f865..14d47246ca63 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2776,8 +2776,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
 
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
-        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
-- 
2.43.0


