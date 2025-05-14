Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A0C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 03:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF2h5-0005vy-EO; Tue, 13 May 2025 23:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h3-0005vL-Mi
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h1-0004vx-9A
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747192924; x=1778728924;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vQ+kV0GyjeXQoFqSu9jcYsHFUjM3twb0GecfPZtUU9U=;
 b=PFFhGr/4MLYRBFdj5JdS6YBsZeNPXuju00tBqjVjAH3K+PUblr4mleCu
 7AT5TF6hNgyqNOfjSo22SAruvwqpXw3Qy5uqZiGoY4zMN6OLx+3fdj4mf
 fdQ0gVq921OTBBdXaAmrDZ+nBsOnNbggl4ujjFfGkri1/+H0T4qq/Tpsi
 arsH5G3pM2v/kDeK1HTfjXAQ21WVq1EWUfHPZtaScHEdzb74YUBPoPABN
 qahACGBWwQHUsQUrYR8sSZNH1ZXJo96Oyu7Wi4RKBJGqWV7BBUmO+O4uj
 BFsPQMadB6KD8Ocf0qyaPs+xn0SpWDdOXEa368DyokWeUIdklWaAjywjr g==;
X-CSE-ConnectionGUID: yhyFSY7FT3+sDHDDzsULkg==
X-CSE-MsgGUID: HWO7uqDIQ6CeFmPJwS6rXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59296753"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="59296753"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 20:21:58 -0700
X-CSE-ConnectionGUID: BeisNnThT0G87lLUU4irgg==
X-CSE-MsgGUID: FzSSics9RB+qmChvgP7NDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="161203395"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 13 May 2025 20:21:55 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/2] Fixes for TCG/HVF warning of CPUID_HT and
 CPUID_EXT3_CMP_LEG
Date: Tue, 13 May 2025 23:16:50 -0400
Message-ID: <20250514031652.838763-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

Starting from QEMU v10.0.0, QEMU hits warnings when vcpus >= 2 with TCG

 qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
 qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.cmp-legacy [bit 1]

For HVF, it should have the same warning of CPUID.01H:EDX.ht [bit 28].

This series tries to fix them.

Xiaoyao Li (2):
  i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported
  i386/hvf: Make CPUID_HT supported

 target/i386/cpu.c           | 8 +++++---
 target/i386/hvf/x86_cpuid.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0


