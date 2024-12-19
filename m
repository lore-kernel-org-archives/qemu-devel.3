Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027CFE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVo-0004aC-RS; Thu, 19 Dec 2024 06:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVk-0004YO-Cf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:08 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVh-0005H9-Gg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606966; x=1766142966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yyWt+MVGY6xtOd7DTZ9vugv8QqO6/xf7WS/1tfjrRyc=;
 b=TYwRVA1JKNK6mSMXoJVpz5mTI8qHNGlD3Mew76xTfRIev4QbEcfpo84Q
 EtxrqL7J66mzAO9q1oiMiPIAulAH3YLFwfhbxxyXrDhwINSFMQzSQ97A3
 cn7zNR04VAasWT0Atay+fMk2ozrmP9m4nhuqt4eHWmFaiDWgcmw9Gec8U
 arTTYmjQbeoFPNsB97b+ga8XgNxOhxTMZmW8xZODdb1thDoDwTxFopGpb
 dVtlnpFJZ3/iHSyXrA9LE/Rxk/lVKeQs3tFvjPfbT8y3GmCHJQvI74W3P
 12ehdh0vnnJV95HzwKkZ3drT1nd0zuIax90qdlZrgRVAzihA8i3uw55Iv A==;
X-CSE-ConnectionGUID: a6GbkZT4RAiioLTft7pBig==
X-CSE-MsgGUID: OHGwgQMoQjKkYfebTsZ4pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994959"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994959"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:05 -0800
X-CSE-ConnectionGUID: DmifpDBQRhqirTrWD1H3cA==
X-CSE-MsgGUID: fg6EgXzbSjacaI+dUdo4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956164"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:02 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 05/10] i386/topology: Introduce helpers for various
 topology info of different level
Date: Thu, 19 Dec 2024 06:01:20 -0500
Message-Id: <20241219110125.1266461-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

Introduce various helpers for getting the topology info of different
semantics. Using the helper is more self-explanatory.

Besides, the semantic of the helper will stay unchanged even when new
topology is added in the future. At that time, updating the
implementation of the helper without affecting the callers.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/hw/i386/topology.h | 25 +++++++++++++++++++++++++
 target/i386/cpu.c          | 11 ++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 21b65219a5ca..f6380f1ed756 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -203,4 +203,29 @@ static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
            test_bit(CPU_TOPOLOGY_LEVEL_DIE, topo_bitmap);
 }
 
+static inline unsigned x86_module_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->modules_per_die * topo_info->dies_per_pkg;
+}
+
+static inline unsigned x86_cores_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->cores_per_module * x86_module_per_pkg(topo_info);
+}
+
+static inline unsigned x86_threads_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->threads_per_core * x86_cores_per_pkg(topo_info);
+}
+
+static inline unsigned x86_threads_per_module(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->threads_per_core * topo_info->cores_per_module;
+}
+
+static inline unsigned x86_threads_per_die(X86CPUTopoInfo *topo_info)
+{
+    return x86_threads_per_module(topo_info) * topo_info->modules_per_die;
+}
+
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ad6889abdf5e..f11b5d401a77 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -311,13 +311,11 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
     case CPU_TOPOLOGY_LEVEL_CORE:
         return topo_info->threads_per_core;
     case CPU_TOPOLOGY_LEVEL_MODULE:
-        return topo_info->threads_per_core * topo_info->cores_per_module;
+        return x86_threads_per_module(topo_info);
     case CPU_TOPOLOGY_LEVEL_DIE:
-        return topo_info->threads_per_core * topo_info->cores_per_module *
-               topo_info->modules_per_die;
+        return x86_threads_per_die(topo_info);
     case CPU_TOPOLOGY_LEVEL_SOCKET:
-        return topo_info->threads_per_core * topo_info->cores_per_module *
-               topo_info->modules_per_die * topo_info->dies_per_pkg;
+        return x86_threads_per_pkg(topo_info);
     default:
         g_assert_not_reached();
     }
@@ -6505,8 +6503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    threads_per_pkg = topo_info.threads_per_core * topo_info.cores_per_module *
-                      topo_info.modules_per_die * topo_info.dies_per_pkg;
+    threads_per_pkg = x86_threads_per_pkg(&topo_info);
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
-- 
2.34.1


