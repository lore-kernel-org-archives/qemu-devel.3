Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B2C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2zd-0000to-Ac; Mon, 17 Feb 2025 10:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tk2zZ-0000qS-L1; Mon, 17 Feb 2025 10:25:06 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tk2zW-0001Z7-4X; Mon, 17 Feb 2025 10:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739805902; x=1771341902;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=65SZffwoMTSntLiIhNbwF6RI3IKpjp+8ZDZjNVWEOpc=;
 b=QqerKs6nuRf/ykNFu6cNZvCli01lBU1W7HIUvtsl0idYl2b3ApGXlLr4
 6pd2e6tGPMGsE1HtwbfH7pXNNd0A3N98GDHCrrxU7+ewXTNQp0uCVcizp
 lZ7+eqYzmeAuMFn4I63IarXrMLPih63TRjct+b7xtcuyrzatLkPcCnYSN
 6n7sfCuiASZGBPmIJ8MOhBsFr/jq1jHcwz2w5TJVi0epCz7nIiv4CfQ5O
 U35c1Zi8W5RkXXSh3Uc3L1cnEvuTEoL+mkfCJ1fquIFOnzLjKq0JLeIr1
 PRkvPJ/G4qPb39dHiBh8WCCds0Hrr56gcf5VaIyfXws/0shQqeOcu1nN/ Q==;
X-CSE-ConnectionGUID: zLNwCCMIQ7K7LQ+EZTIi1w==
X-CSE-MsgGUID: Q4jTZbstTZG8EyJUeQL9Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39720960"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39720960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 07:24:58 -0800
X-CSE-ConnectionGUID: qLLzdg8/TJG3C2bryaSVAA==
X-CSE-MsgGUID: eebk0HSxQw6T/rNprmKaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115038418"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2025 07:24:57 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] i386: Fix the missing Rust HPET configuration option
Date: Mon, 17 Feb 2025 23:44:16 +0800
Message-Id: <20250217154416.3144571-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The configuration option of Rust HPET is missing, so that PC machine
can't boot with "hpet=on" when QEMU Rust support is enabled.

Add the Rust HPET configuration option.

Fixes: d128c341a744 ("i386: enable rust hpet for pc when rust is enabled")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/timer/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 9ac008453408..c051597180f4 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -13,6 +13,10 @@ config HPET
     bool
     default y if PC && !HAVE_RUST
 
+config X_HPET_RUST
+    bool
+    default y if PC && HAVE_RUST
+
 config I8254
     bool
     depends on ISA_BUS
-- 
2.34.1


