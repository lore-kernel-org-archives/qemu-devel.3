Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D28CF64BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyT9-0005CM-TV; Thu, 20 Nov 2025 01:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLySz-00055E-Ci
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:30 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLySr-0005ql-NR
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621301; x=1795157301;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YymZpa1JDPwZJAi9YVFaRnL59lBXfY6Irs8c2nT16hU=;
 b=ZR0mpHRt21l8AF9jfvbEsben0sSK8OiteqPe2Rz0hpkNvALRInF0VfRO
 NN2uxsAl18dhu6pF5QB8k3oPdeVQLaJRYVo2YQ0u7pKvcKSgugBWiKf7y
 XddC6sGAmuCII5/FTBNXgk3I5AHZ1t+dZF6PVlL++xVrH+SAkzqhDAtyL
 2rLznuUdEmW1ImnQBQk/4NRXAoXa7pObraCwFmWDTJ6lM7nMXVP7cehX7
 W7C3FJqKIYtVJOefPeK1rdqluozNAoRXQyrB9PY7amU/ndQFVtkLRhDSR
 TvJMnt8XlLRu80ti9lS4YsGfCXGl5OV1qIbzwtMGthdnbV5TV5fY/STyQ g==;
X-CSE-ConnectionGUID: oWYvI5BxRFyfpVlOfPcX8w==
X-CSE-MsgGUID: JDiUM31cQv2Cv8y+G16g9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572525"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:18 -0800
X-CSE-ConnectionGUID: zPS4Qx/IRG2T52i59D8z8Q==
X-CSE-MsgGUID: jsUkFvnUR9q41AC2lBa6VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296100"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:16 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/10] i386/cpu: Add new instructions & CPU model for Intel
 Diamond Rapids
Date: Thu, 20 Nov 2025 15:10:20 +0800
Message-Id: <20251120071030.961230-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

This series addes new instrucions and CPU model support for Intel
Diamond Rapids.

This series mainly includes:
 * MOVRS CPUID
 * new AMX CPUIDs
 * AVX10.2 & AVX10_VNNI_INT
 * DMR CPU model & topology documentation

This series is based on the previous minor cleanup:

https://lore.kernel.org/qemu-devel/20251118080837.837505-1-zhao1.liu@intel.com/

And you can find the code here:

https://gitlab.com/zhao.liu/qemu/-/tree/i386-all-for-dmr-v1.1-11-17-2025


One Thing More
==============

I'm a bit unsure about the AVX10 model (patch 4). In principle, AVX10.1
should be allowed to run on an AVX10.2 host. For similarly version
drived features, introducing a model might be a preferable way. However,
PMU doesn't serve as a good example here.


Thanks for your review!

Best Regards,
Zhao
---
Zhao Liu (10):
  i386/cpu: Add support for MOVRS in CPUID enumeration
  i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX instructions
  i386/cpu: Add support for AVX10_VNNI_INT in CPUID enumeration
  i386/cpu: Support AVX10.2 with AVX10 feature models
  i386/cpu: Add a helper to get host avx10 version
  i386/cpu: Allow cache to be shared at thread level
  i386/cpu: Add an option in X86CPUDefinition to control CPUID 0x1f
  i386/cpu: Define dependency for VMX_VM_ENTRY_LOAD_IA32_FRED
  i386/cpu: Add CPU model for Diamond Rapids
  dosc/cpu-models-x86: Add documentation for DiamondRapids

 docs/system/cpu-models-x86.rst.inc |  20 ++
 target/i386/cpu.c                  | 443 +++++++++++++++++++++++++----
 target/i386/cpu.h                  |  27 ++
 3 files changed, 441 insertions(+), 49 deletions(-)

-- 
2.34.1


