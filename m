Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7PS-0004Wo-Tr; Wed, 31 Jan 2024 05:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7PO-0004TX-Bh
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:31 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7PM-0008Qp-HE
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695288; x=1738231288;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UM7ZZqMgruDN7ot3TMcwFYXsOFWdcg8mETgGBxArI7I=;
 b=G7K6Hd7FYGsLnZLDwOeAU5RiPpyHcc1cqkqfpGx1jMGm1/8LlqIPS4Ic
 38eOXEYddjz8hgTz2ZbbQ+LRcnpzS40wgvpd6otvyENfRK0oW1NBAjYC7
 znIoxuumhry7Wu1VQVpgwgJBJAVFhbCM3tOVpDDzMLtAGM1487N2RuT8F
 dVPUbfXJBLfE3GCn4nUfQnTRWB5pezfTlJaqgsuApwPleKK0iscyjvYm5
 4oHzJVJY8gbtHQucsJcAoTToLeaVdFPzJlNNWHvIthFyjpkf8IiZZMT+l
 7Wc53FhaQBPSC3NtibssyrgJjbtJHZTzDVolg0wsZd0L4BNs9J1kSqyjl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25032823"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25032823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4036080"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:01:22 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 10/21] i386: Split topology types of CPUID[0x1F] from the
 definitions of CPUID[0xB]
Date: Wed, 31 Jan 2024 18:13:39 +0800
Message-Id: <20240131101350.109512-11-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID[0xB] defines SMT, Core and Invalid types, and this leaf is shared
by Intel and AMD CPUs.

But for extended topology levels, Intel CPU (in CPUID[0x1F]) and AMD CPU
(in CPUID[0x80000026]) have the different definitions with different
enumeration values.

Though CPUID[0x80000026] hasn't been implemented in QEMU, to avoid
possible misunderstanding, split topology types of CPUID[0x1F] from the
definitions of CPUID[0xB] and introduce CPUID[0x1F]-specific topology
types.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * New commit to prepare to refactor CPUID[0x1F] encoding.
---
 target/i386/cpu.c | 14 +++++++-------
 target/i386/cpu.h | 13 +++++++++----
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 607d8eff017b..4e5feb153152 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6257,17 +6257,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = threads_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
         }
 
         assert(!(*eax & ~0x1f));
@@ -6292,22 +6292,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_die_offset(&topo_info);
             *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = threads_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
         }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f341affd5a59..8a7450f265a1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1010,10 +1010,15 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
 /* CPUID[0xB].ECX level types */
-#define CPUID_TOPOLOGY_LEVEL_INVALID  (0U << 8)
-#define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
-#define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
-#define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
+#define CPUID_B_ECX_TOPO_LEVEL_INVALID  0
+#define CPUID_B_ECX_TOPO_LEVEL_SMT      1
+#define CPUID_B_ECX_TOPO_LEVEL_CORE     2
+
+/* COUID[0x1F].ECX level types */
+#define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
+#define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
+#define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
 #define MSR_ARCH_CAP_RDCL_NO            (1U << 0)
-- 
2.34.1


