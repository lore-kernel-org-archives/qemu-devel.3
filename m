Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C6C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 05:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMJx6-0006tl-4H; Tue, 03 Jun 2025 01:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx3-0006t9-Br
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:42 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJwz-0003ON-UA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748927558; x=1780463558;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1daquS88+pL2GYt/WM9lP4x7yGMhY9E8MMBEJY/DgMY=;
 b=PksCCakTWWeZjMtbLb/4pYjyUhqWVnfmeZPMiFvMw0YCLnTui965glcH
 FcPmaUYkPuSljQz2JTGlxJcsf8IB+RI549EcPMI4CcT0QXhLAHlr9GXHJ
 iphQyS1zh0/QXoDXhVgR23H9GHjiqDqC1yJWmiQeh1KIIHPsLZIJSORJ2
 tL7l/qVNVP5FSncnEEP2ByLVXc6tajVS0j/IaZpdMQJyc8BshkCbCP2Q/
 yVolIe1lXQhYBtUZYQL4h6PU2qvaPSOrvGbxxzz6bNS+hKcfnnekO+fbm
 WkgR8WFdvd9GV5rww5zRNiLtu4t9CzqqPkYZ8/ogWmlquL65BqXAv1Pwr A==;
X-CSE-ConnectionGUID: gvJn/SHjQ+CmN2wfg+urPA==
X-CSE-MsgGUID: vgeI2TAzTMWB9ysAieiUpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62007518"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="62007518"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 22:09:10 -0700
X-CSE-ConnectionGUID: cE+50tjBTn6SDUVVAojYQQ==
X-CSE-MsgGUID: ZiSTxmQSSeiSJx1epZDyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="175700634"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 02 Jun 2025 22:09:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/3] TDX: Fix and enhancement
Date: Tue,  3 Jun 2025 01:03:02 -0400
Message-ID: <20250603050305.1704586-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

Patch 1 and patch 3 are the left review feedback of TDX QEMU v9 series.

Patch 2 is caught during preparing patch 3. 

Xiaoyao Li (3):
  i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
  i386/tdx: Fix the typo of the comment of struct TdxGuest
  i386/tdx: Clarify the error message of
    mrconfigid/mrowner/mrownerconfig

 target/i386/cpu.h     |  4 ++--
 target/i386/kvm/tdx.c | 14 ++++++++++----
 target/i386/kvm/tdx.h |  6 +++---
 3 files changed, 15 insertions(+), 9 deletions(-)


base-commit: 6322b753f798337835e205b6d805356bea582c86
-- 
2.43.0


