Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F8CC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNKK-000736-2d; Mon, 28 Jul 2025 08:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcQ-0007ih-4B
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:15 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugMcF-0006f6-Mc
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753704364; x=1785240364;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tzNi7t4LhpAlF0rapU9gaQyfEYFMocUq0uyY2q8ltuQ=;
 b=c37x9TxegtTUJbYbey/aQgzdIrMw/82dkzlpKSAZPEkPSV1imqy75DW3
 vtc6kOtgi9VUDTv4z4tyxDUHKvOA1mSpHolmO0DC7AJh/zvGPfu6em8oX
 wicYojdIiuObg8sG6Q/wLhUebEAvUZ7ur0+2DVAoPABx53utH3vpy/9fY
 gQU3r4qmv2eCM9O6AV/yiO7ClFaQuf7p9C3p9NHkVykvBdLcZzAaziumq
 Q6cSzBcxwI9OASdhM3xEAr3xCkgSMJY7i8xA15PH58NVqaKL9uE3e69Bx
 9ev04wBhL1DKcWOTFxZAs52Vo3AW2X+HMyfTRLnDCVn7u/jOD++fQ6jWo Q==;
X-CSE-ConnectionGUID: ehK1UC8LTFy8Yrc1TNMPUA==
X-CSE-MsgGUID: zzkL/E0WQwuVoaLYa22yBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59755635"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59755635"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:05:57 -0700
X-CSE-ConnectionGUID: wOj7H5t/R8uUeBzIkO748w==
X-CSE-MsgGUID: q/D8dfMORjyWZ7swjHmOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162448033"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Jul 2025 05:05:56 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 0/3] kvm: guest_memfd enhancement and fix for
 KVM_SET_USER_MEMORY_REGION2
Date: Mon, 28 Jul 2025 19:57:04 +0800
Message-ID: <20250728115707.1374614-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patch 1 changes to check guest memfd CAP on VM instance.

Patch 2 is a fix for KVM_SET_USER_MEMORY_REGION2.

Patch 3 is an enhancement for guest_memfd_offset.

---
Changes in v2:
- Collect R-B tags;
- Use {} to zero out the struct instead of memset() in patch2;
- Initialize guest_memfd_offset at the original source in patch3;

Xiaoyao Li (3):
  accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
    KVM_CAP_USER_MEMORY2 on VM
  accel/kvm: Zero out mem explicitly in kvm_set_user_memory_region()
  accel/kvm: Set guest_memfd_offset to non-zero value only when
    guest_memfd is valid

 accel/kvm/kvm-all.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.0


