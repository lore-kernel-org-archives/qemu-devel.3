Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FB9C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhgU-00027O-GZ; Thu, 26 Jun 2025 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgJ-00021Y-4X
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:03 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgG-0006NO-Um
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750925401; x=1782461401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=spF5Ym7rIdLUPB3+GkW2V4Vz63PDYYIvyYxxqNBqo/8=;
 b=Mr4IvW2u7RJXxz5GNru8zjlrEeocgdC6V5eV5GoLpY/bS0AEBVOxs5Up
 pjjAZJeJNYSuByAWJYDrBtkFm+TW8veo1cFo6A/pK655PfHGM79FDP8hK
 LG3mq3FjZd7AiF5xudpkmKbVAStjsgTqvxDDIkYuk3KBTb2Jn1FhQXtUJ
 jy05stHyjF+pFL3GmNPLjRkKVEIsh5E85URkOiwPs6B2tRmxK46kLr3ij
 ulxbsnLuQmIL4akmlAeQUDu8DzuNO0oXX8NOb9j28zjj6VnTepxOBjgIQ
 zXZkUa/2wGRuTi0heembXZ6C7iVGh+deC/uPIwrYz6iNneKTx5pwha/Se A==;
X-CSE-ConnectionGUID: DV9MWSVaSUW53NmYZueGXQ==
X-CSE-MsgGUID: 4CkCn8KdScOcwbCKG0tH0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63902057"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="63902057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:09:59 -0700
X-CSE-ConnectionGUID: 6wmsAzQMS0m1xhwy97dlDA==
X-CSE-MsgGUID: zXBlVcPKR7W1aEJ2Wlifeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152949768"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 01:09:56 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/8] i386/cpu: Introduce cache model for GraniteRapids
Date: Thu, 26 Jun 2025 16:30:59 +0800
Message-Id: <20250626083105.2581859-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626083105.2581859-1-zhao1.liu@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the cache model to GraniteRapids (v3) to better emulate its
environment.

The cache model is based on GraniteRapids-SP (Scalable Performance):

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0xc (12)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 49152 (48 KB)
      --- cache 1 ---
      cache type                         = instruction cache (2)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
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
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x800 (2048)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 2048
      (size synth)                       = 2097152 (2 MB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0xff (255)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x48000 (294912)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = true
      number of sets (s)                 = 294912
      (size synth)                       = 301989888 (288 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Suggested-by: Tejus GK <tejus.gk@nutanix.com>
Suggested-by: Jason Zeng <jason.zeng@intel.com>
Suggested-by: "Daniel P . Berrangé" <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fcaa2625b023..b40f1a5b6648 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2886,6 +2886,97 @@ static const CPUCaches epyc_turin_cache_info = {
     }
 };
 
+static const CPUCaches xeon_gnr_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 12,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 48 * KiB,
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
+        .size = 64 * KiB,
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
+        .associativity = 16,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 2048,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 2 * MiB,
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
+        .sets = 294912,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = true,
+
+        .size = 288 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
+    },
+};
+
 static const CPUCaches xeon_srf_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -4954,6 +5045,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .note = "with gnr-sp cache model",
+                .cache_info = &xeon_gnr_cache_info,
+            },
             { /* end of list */ },
         },
     },
-- 
2.34.1


