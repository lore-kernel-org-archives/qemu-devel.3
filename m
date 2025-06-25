Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF71CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 03:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUHFG-0002sx-CM; Tue, 24 Jun 2025 23:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFE-0002se-Ad
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFC-0002EY-GY
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750823778; x=1782359778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qynfft1D3oOHzHCeV9CxuYI60grWqkunhRCqIXpNJ6k=;
 b=lymCWWlvbwFNjYvZ7DC4ZkQC+fABTrZnGcA1/2MowosxndZew3f0/vUW
 ZetZL4ZhkK32fGYV/z0N2dMWDrkRq88gyT4BlH57BcPd6oivajIXfAWKW
 NNUQTLgfJVwLKwDgDifehIzX78v9MW91LS90UfBPu30BDDsbmlwqpbLRy
 8bqzp5XkzTakmUn+efi4AhOVjsr0Vj/f/OvZ8CXKDbCzwi5Izl7Ia4soN
 GnK7G+rpJ63iaE8s0gfUjn/ocxuyM6+lliO4RcecAD1HkUO6wVWoGpcvP
 YB/4XGh8HxCdhZCnk3ivMjSFFa0cCC8QiTjpbo+xrJNp3tC6wioMXk0tF Q==;
X-CSE-ConnectionGUID: VpUqlwzyQPWhWedxr27BaQ==
X-CSE-MsgGUID: xD+7da4ITX+A3MPC5kJb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52800075"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="52800075"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 20:56:16 -0700
X-CSE-ConnectionGUID: uMk9+b7ERd+C3ycx2YwpAg==
X-CSE-MsgGUID: BcOAbfXdSledAxHk3fLgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="151848924"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa009.jf.intel.com with ESMTP; 24 Jun 2025 20:56:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org
Subject: [PATCH 2/2] i386/tdx: Don't build TDX for 32bit target
Date: Wed, 25 Jun 2025 11:49:03 +0800
Message-ID: <20250625034903.2770272-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625034903.2770272-1-xiaoyao.li@intel.com>
References: <20250625034903.2770272-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
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

TDX cannot work on 32-bit host. It's also not worth supported TDX with
32-bit QEMU.

Thus, make TDX depends on !I386.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 6fc353930985..c58802462a45 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -13,7 +13,7 @@ config SGX
 config TDX
     bool
     select X86_FW_OVMF
-    depends on KVM
+    depends on KVM && !I386
 
 config PC
     bool
-- 
2.43.0


