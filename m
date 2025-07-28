Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2842EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNKS-000102-50; Mon, 28 Jul 2025 08:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcQ-0007gH-1q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:15 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcG-0006fq-Rw
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753704365; x=1785240365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RGlSGzGkbqVhDC4KFQQiXuDi9zm1hRpG1NVXQpKek9Q=;
 b=dglAUdAW9s64KBAZB1esblBo5UkaLjlM6Ey0+loxXPuunswupcxtw9cK
 MGZdqiYKcZiSCuLGFerh2WEUTuEiWTi6nspYkaAam2uR5XcNsxTYEnpH4
 V2Az1HKrb8E7YwLYB4k07JDbe+6BL22KKfwdoDj4ThXhtIg8d+vidwFQz
 UpTAcOIHCrEJJ2eSenMg4rrMzTvcH+gy9aNCO10U9y6bnwpdFFUJbsk3x
 cEEigjdiDetEDp6gmMpp7MY0xjux4vYxNTGKnMKhVn9BZHq2HmEh+3pOz
 RiH0MXTVRF5sM50SaIKqu5skmcl3KVOZIOL568qNLzyAPYYETgMNiNp75 A==;
X-CSE-ConnectionGUID: PwWc3KQlTeOYXvqgzXRZ4Q==
X-CSE-MsgGUID: l7dj0tJdTJyiU8CNk8qNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59755643"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59755643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:05:58 -0700
X-CSE-ConnectionGUID: pVtzO6kKSuaKuxxq845gjw==
X-CSE-MsgGUID: SCwLSxMeQGehbj74rlDn3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162448041"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Jul 2025 05:05:57 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 1/3] accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
 KVM_CAP_USER_MEMORY2 on VM
Date: Mon, 28 Jul 2025 19:57:05 +0800
Message-ID: <20250728115707.1374614-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728115707.1374614-1-xiaoyao.li@intel.com>
References: <20250728115707.1374614-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


