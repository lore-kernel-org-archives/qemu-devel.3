Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03800C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhgY-00029Y-Ej; Thu, 26 Jun 2025 04:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgW-00028A-Bm
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:16 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgQ-0006bl-Gu
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750925410; x=1782461410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ePXk+kbZrGdfZdNQYDBZizKJR0y5RVneBkz+gFtm/qs=;
 b=kEU5x+WLqlU/fqJo/MaCaG1MDwlny+h2qkxNlRsI1mrVNB5noq1nQPH9
 MY1wo/9mVPNTrhCmLX7H/lmQUE+Oupku6R7NUBSJVasd+Ub4NQcOA8KYr
 75zfgFt0Jt+8Dg0dVANriIBTOH3G863fINflJ3EB5ubKjvG82Rf7ayKyO
 RdHz6skRzC2VwmQCxHxPZPO3V1BsDqhWrd9W2qXvJYC+MJLIN9tUi8njU
 QqaPd/9zv/1xDQ4RuLDy/GKrFQVozXlEcjJ3DxMwnzD1EekymWG8zkLYl
 IVno/obexNbNhnAiVyOM8W54zC8KyNFZZNtc0tnIrrG2giJ/Gfo/skKPW w==;
X-CSE-ConnectionGUID: wOGaC2VjRt23uxM9JXYfOw==
X-CSE-MsgGUID: wODGIPnpRjmuxgH1YFZPfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63902086"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="63902086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:10:07 -0700
X-CSE-ConnectionGUID: +O7jDiJXR1mmxVWxi1XLZw==
X-CSE-MsgGUID: 2NaTzzVRTnGUVkRoYUzjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152949874"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 01:10:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
Date: Thu, 26 Jun 2025 16:31:01 +0800
Message-Id: <20250626083105.2581859-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626083105.2581859-1-zhao1.liu@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Ewan Hai <ewanhai-oc@zhaoxin.com>

Add the cache model to YongFeng (v3) to better emulate its
environment.

Note, although YongFeng v2 was added after v10.0, it was also back
ported to v10.0.2. Therefore, the new version (v3) is needed to avoid
conflict.

The cache model is as follows:

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 32768 (32 KB)
      --- cache 1 ---
      cache type                         = instruction cache (2)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 65536 (64 KB)
      --- cache 2 ---
      cache type                         = unified cache (3)
      cache level                        = 0x2 (2)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x200 (512)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = true
      complex cache indexing             = false
      number of sets (s)                 = 512
      (size synth)                       = 262144 (256 KB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x0 (0)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x2000 (8192)
      WBINVD/INVD acts on lower caches   = true
      inclusive to lower caches          = true
      complex cache indexing             = false
      number of sets (s)                 = 8192
      (size synth)                       = 8388608 (8 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes on the original codes:
 * Rearrange cache model fields to make them easier to check.
 * And add explanation of why v3 is needed.
 * Drop lines_per_tag field for L2 & L3.
---
 target/i386/cpu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a7f2e5dd3fcb..08c84ba90f52 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3159,6 +3159,105 @@ static const CPUCaches xeon_srf_cache_info = {
     },
 };
 
+static const CPUCaches yongfeng_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000005.ECX */
+        .lines_per_tag = 1,
+        .size = 32 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x1.EAX */
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x1.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000005.EDX */
+        .lines_per_tag = 1,
+        .size = 64 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x2.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .self_init = true,
+
+        /* CPUID 0x4.0x2.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 512,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000006.ECX */
+        .size = 256 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x3.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .self_init = true,
+
+        /* CPUID 0x4.0x3.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 8192,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = true,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        .size = 8 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -6438,6 +6537,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .note = "with the cache info",
+                .cache_info = &yongfeng_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


