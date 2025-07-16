Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F6CC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvnj-0004dM-Ra; Wed, 16 Jul 2025 02:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvnh-0004b4-63
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:39:33 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvnf-00062e-B7
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752647971; x=1784183971;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kFzCOpkYypMZjXL1Pr1JBszJJpZJEsQKw6+73PhJuxg=;
 b=jQZbXgqG8dfMlAOc8IAMZgljkII9+cvkNTqpmSmVqXrFWDFChu7J9gcO
 VJ86xj0OtUGFsmwBGhQ9JRSVUCav5R9GNrJclBwtE8bNvEkDxlccDX4X7
 hSh3vcC+bfOrTXTxCFrJN8zYPCeyKeutnKWsGF79jE5eP2IRLlx23reml
 qLBz4Bx2G+afYA3BGgju6d+FWwzPuwGocR7sKsND4tHxY9YuNoJ+IzCx6
 fzl7PXKlnXK7iRMc+0Aos4NMC5hugKdpk21R6YlNyqdo1fieSm3j2bVn9
 gqVVqHcO9uK4mb5zPp18176HoLmzksTEzEUmGqBjmryUTCLO5qWbeJEW9 Q==;
X-CSE-ConnectionGUID: r99op0IKSjSqTTH4V26NSQ==
X-CSE-MsgGUID: rW4jhaJjQTyCxp6LN6suHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65577281"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="65577281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:39:29 -0700
X-CSE-ConnectionGUID: vBRq+lw6TAGiQ9E+MkYhkg==
X-CSE-MsgGUID: VkrwoS06TX2XmzQH/QW43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="161444023"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2025 23:39:28 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] i386/cpu: Cleanup host_cpu_max_instance_init()
Date: Wed, 16 Jul 2025 14:31:16 +0800
Message-ID: <20250716063117.602050-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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

The implementation of host_cpu_max_instance_init() was merged into
host_cpu_instance_init() by commit 29f1ba338baf ("target/i386: merge
host_cpu_instance_init() and host_cpu_max_instance_init()"), while the
declaration of it remains in host-cpu.h.

Clean it up.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/host-cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 10df4b3a3a74..ee6532422548 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -12,7 +12,6 @@
 
 uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
-void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
 void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
-- 
2.43.0


