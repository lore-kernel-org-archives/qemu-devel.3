Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8ys-00040A-3K; Wed, 14 Aug 2024 04:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yT-0002tK-1H
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:23 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yJ-0007sc-4T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622587; x=1755158587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y3Zdg2gkuvf92qw6n0gEjAnA5h7Gl2EFlz23K8pA8v4=;
 b=KGe73R7DX4BnQUffUvnNcOxkBUWOjTD6Mq7+41oQuyL9qYX+5cSS/up0
 B7ybgXIAT30okQj7We8muph8ao3hCrjCZXckmwexhCfVzqVBSEjPVykxP
 G6hy5f3q2IrF1v4R0pBWCnEk1/uw3wp6bqQhrQzRHZS0E+MZ4LdF+nOew
 tX9hM6w9+UYxquVuc9OmzZnssrAC5cK/ztqB1kzVbFf9he2a8GNSZfivG
 EoOTPzOs295eC/W4ZBvZEb9ZC0HysUZkhAgNi2nbTssntqaXTSqkGjOsG
 yRvabzv5OTVaq39MaUe9FSirJAUHSxcjFAav5aEJwUhgNWHWgm9WGhYgz A==;
X-CSE-ConnectionGUID: GwpXFdTARb6RHq0SMBPuuw==
X-CSE-MsgGUID: mHGtlY0rRVqiR+tTU+5u9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584490"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584490"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:41 -0700
X-CSE-ConnectionGUID: sbz+iBpqTWSIEzia/8Shwg==
X-CSE-MsgGUID: X6d4oiFnSamnUzsFLavRKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048958"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:40 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 6/9] i386/cpu: Set topology info in 0x80000008.ECX only for
 AMD CPUs
Date: Wed, 14 Aug 2024 03:54:28 -0400
Message-Id: <20240814075431.339209-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The whole ECX of CPUID 0x80000008 is reserved for Intel.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5bee84333089..7a4835289760 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6944,7 +6944,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        if (threads_per_pkg > 1) {
+        if (threads_per_pkg > 1 && IS_AMD_CPU(env)) {
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
-- 
2.34.1


