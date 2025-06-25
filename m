Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA34C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 07:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUKkU-0004Dw-W4; Wed, 25 Jun 2025 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUKkE-0004DJ-IX
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 03:40:35 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUKk7-0006gS-88
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 03:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750837227; x=1782373227;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G6HYr5021qYC8Jwty3FPFK0+w6C9NkgpVHvpgjHdxKI=;
 b=Yp57hp5IoguxfC7/epVEJ0vKMtFSIwvRqakh4d2J/3CuEii9wD0eSZiq
 3BihybhOI4Ed63+dUhbGL1BeHhRJ7NQS2POh2suIJafH31R9S4xyYFGEF
 EJ3H2wJWUHeTJysiXCuvh9yE7pecDFIYNyZoNAzapzuyAepVtTPjZdTd3
 7JsQLtVv155lxzGyqg3HCrPWfEVNnrXwUKi+ZK4gnXvoSNnLrY+8upz4N
 i4A7piawpDuX2tOxmsxdhg4BPPRZ3eJMdzT6rM2JZDT3J17xrDqMM20oI
 XwEOrcMJyOWwdPm8Sk12UpXUMmW1nl0bGPqCNi4rcMn5j5P4QpU5HfTqN Q==;
X-CSE-ConnectionGUID: v2izJwP1TXyHJCfarsLv2Q==
X-CSE-MsgGUID: /ThKiGy5THORMW7D3FXHrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56896431"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="56896431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 00:40:22 -0700
X-CSE-ConnectionGUID: FFF/qJsIS8aroVr8/RBTuA==
X-CSE-MsgGUID: gmyleX3LR4Sr0ngpOWAmww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="152837655"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 00:40:19 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v2] i386/tdx: Build TDX only for 64-bit target
Date: Wed, 25 Jun 2025 15:33:10 +0800
Message-ID: <20250625073310.2796298-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Build errors related to TDX were reported when QEMU built on 32-bit
host[1][2].

Since TDX cannot work on 32-bit host and it's also not worth supporting
TDX with 32-bit QEMU, limit TDX to 64-bit target only.

[1] https://lore.kernel.org/qemu-devel/20250602173101.1052983-1-clg@redhat.com/
[2] https://lore.kernel.org/qemu-devel/b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org/

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eb65bda6e071..14d23e27b580 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -13,7 +13,7 @@ config SGX
 config TDX
     bool
     select X86_FW_OVMF
-    depends on KVM
+    depends on KVM && X86_64
 
 config PC
     bool
-- 
2.43.0


