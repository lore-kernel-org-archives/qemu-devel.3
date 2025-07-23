Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD32CC83F25
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 07:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTmc-0004Wz-1R; Wed, 23 Jul 2025 03:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkM-0003Kf-HA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:41 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueTkD-00045r-7E
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753255109; x=1784791109;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mG8HNQ5gUZouxSUB4pHZ0UHUMMbwatThaCOeCpIlc9o=;
 b=Gkzb3+uZl5ofVUZXbkCyn6HFLM+zURQo4o53kn7Yc3V/0IP1j3hzWr2A
 0RFTKJSdxvQxUHVKWhK4FsgDkuiiZBiXQTPIBgELNrp5H7L6QsQxSmi30
 HjF3W1bfAnSFhMiGTn1QmKtvFvNbb5vXuugDXZ7c/H1oZOSyqTuOaJNfB
 aXAEQy85xcVi7DFr7mWQMLhNBsPG09p2n/yDmCm81C8hIQiFof/ZTqXBI
 A8BvIZ76ia69dDF0KzKiVN0J+Uc0zmf+MKm26LnAW/rAydJDRSdMEVCKw
 EVZotgMi5etbSkNPzL8DUQP24Ip+DhkPSWTkz6xGEUCnlkvnHDXznNg8e A==;
X-CSE-ConnectionGUID: WI1AqMJcQNGYK+4EdP7z+A==
X-CSE-MsgGUID: 7UsmxfDdRFusCAoVRYqb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55480925"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55480925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 00:18:24 -0700
X-CSE-ConnectionGUID: 1RJo7LWYQ5iusssSGKFNsg==
X-CSE-MsgGUID: rID3q3orSXCJPnObkCZyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="158662227"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 23 Jul 2025 00:18:23 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/3] kvm: Guet_memfd enhancement and fix for
 KVM_SET_USER_MEMORY_REGION2
Date: Wed, 23 Jul 2025 15:09:48 +0800
Message-ID: <20250723070951.1134374-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Patch 1 changes to check guest memfd CAP on VM instance.

Patch 2 is a fix for KVM_SET_USER_MEMORY_REGION2.

Patch 3 is an enhancement for guest_memfd_offset.

Xiaoyao Li (3):
  accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
    KVM_CAP_USER_MEMORY2 on VM
  accel/kvm: Zero out mem explicitly in kvm_set_user_memory_region()
  accel/kvm: Set mem.guest_memfd_offset only when guest_memfd is valid

 accel/kvm/kvm-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


