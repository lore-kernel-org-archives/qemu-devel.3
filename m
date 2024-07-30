Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CF6C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeek-0002OI-A7; Tue, 30 Jul 2024 00:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeei-0002Ni-LS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:12 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeeg-0006BM-A6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722314410; x=1753850410;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1pw4Jsu1ILrO/dGMaUNJB827hqwXpZAbNErTEXUBHKw=;
 b=bQfEN43bou2FLYgC5RB4iquWb/We3/bMK2PqiZpA9BDX8taOCmTcuSNo
 trcdTaPjE3hlNltoiU4hyD+ZG7fnIAJImSUhA9B5L3oFTlGclIuA2bT+0
 gIYR+DUH46NBQ/5umi7Z3oY9TLZsyGnD/VRF+r+BD/Cq7avS0oFfmsA2S
 68gU6LfoorbrqlOdzuooJ06dFqAO1ZcmUuqXJKuw1aLJhR3jW2yRnvMhR
 eanXclsqm0R+eB0fYBrjDWj2Pp+uFUm1TAZ1cpWjbiFKGeOfQnuZzV5a8
 V9aDY5Tb8d0b1WDMaL6jI4vY/wojQv/fQx+WVUM/AV//c9MT45xXUTc5E w==;
X-CSE-ConnectionGUID: uMNvJDWkSQGGcJOe7VQ9RQ==
X-CSE-MsgGUID: cz/1XoIfSQKyJzuROZPckA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20288532"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="20288532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 21:40:07 -0700
X-CSE-ConnectionGUID: RGxuQF7UQBq3Bb0OBJxoQg==
X-CSE-MsgGUID: NMIZz7C1RmCsvMLkXCJNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="77429904"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 21:40:05 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/4] i386: Clean up SGX for microvm, completely
Date: Tue, 30 Jul 2024 12:55:40 +0800
Message-Id: <20240730045544.2516284-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Currently, only PC machine supports SGX and microvm doesn't.

The commit 13be929aff80 ("target/i386: do not crash if microvm guest
uses SGX CPUID leaves") has cleaned up the CPUID 0x12.{0x2..N} for
microvm to avoid Guest crash.

Per my comment on that commit [1], microvm deserves more cleanup to
mask off CPUID 0x12.{0x0,0x1} subleaves as well. But once I actually got
my hands on this, I realized not only we need to clean up CPUID 0x12,
but also we should clean up CPUID 0x7.0.ebx[SGX] for microvm.

Thus, I have this series to completely clean up SGX for microvm.

[1]: https://lore.kernel.org/qemu-devel/Zpcz0cFjW8extm9T@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (4):
  target/i386/cpu: Remove unnecessary SGX feature words checks
  target/i386/cpu: Explicitly express SGX_LC and SGX feature words
    dependency
  target/i386/cpu: Add dependencies of CPUID 0x12 leaves
  target/i386/cpu: Mask off SGX/SGX_LC feature words for non-PC machine

 hw/i386/sgx-stub.c        |  5 ++++
 hw/i386/sgx.c             |  8 +++++++
 include/hw/i386/sgx-epc.h |  1 +
 target/i386/cpu.c         | 50 ++++++++++++++++++++++++---------------
 4 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.34.1


