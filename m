Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72913C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUznK-0002ii-3G; Thu, 26 Jun 2025 23:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUznG-0002i3-Pq
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUznE-0007Uq-Nt
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750995025; x=1782531025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HOHLAI5RhOkZcHb0DpFGdSaVgH4ihzFmplldEQusHAo=;
 b=M3vIkiCx6D0U5iGlROuBCWvc7Zn428ECWB21idyrBxFXss1+eIphRa6w
 UEjB25b7pXSywFNG5oW/mqq1qcew/KgRSXYSQCknzz5ZRpS3bFCc4FveT
 QtTxzgirieUEZ8MEoPhDe7S7A+Xn6HayvwJYqlYoHxNuUhqWqvsha6wyN
 id8FsFIf1faFI/1Q41eZDLXFEKU9SUMK4FRZtYcEKZ7/fZMFswCFz5yoN
 jN7sb0OiHerIWChMt1Bh8mmC7ax0zyHATDn4rc4YZQDHHzw2V/Sq2BRGU
 ZIG8oHQzPKppSlAExWz9KFaUnVH/IyBPiEDDXCiLFfejbEwIPfwx8/UCG g==;
X-CSE-ConnectionGUID: APqy9T7nSO61pZwZKDRHxA==
X-CSE-MsgGUID: NCzrYM8vRlKx3ELTPSAmKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53247146"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="53247146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 20:30:23 -0700
X-CSE-ConnectionGUID: ygSOAq+HS/mOg7y5gPINfA==
X-CSE-MsgGUID: 1YPQI+KvS/+bdvb046Yuwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="157084660"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 20:30:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/4] i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
Date: Fri, 27 Jun 2025 11:51:29 +0800
Message-Id: <20250627035129.2755537-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Sort the CPUID leaves strictly by index to facilitate checking and
changing.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5d5a227d4c8a..18bb0e9cf9f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8052,21 +8052,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
-    case 0x1C:
-        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
-            *edx = 0;
-        }
-        break;
-    case 0x1F:
-        /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_cpuid_0x1f(cpu)) {
-            *eax = *ebx = *ecx = *edx = 0;
-            break;
-        }
-
-        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
-        break;
     case 0xD: {
         /* Processor Extended State */
         *eax = 0;
@@ -8207,6 +8192,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x1C:
+        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
+            *edx = 0;
+        }
+        break;
     case 0x1D: {
         /* AMX TILE, for now hardcoded for Sapphire Rapids*/
         *eax = 0;
@@ -8244,6 +8235,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x1F:
+        /* V2 Extended Topology Enumeration Leaf */
+        if (!x86_has_cpuid_0x1f(cpu)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
+        break;
     case 0x24: {
         *eax = 0;
         *ebx = 0;
@@ -8465,6 +8465,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001F:
+        *eax = *ebx = *ecx = *edx = 0;
+        if (sev_enabled()) {
+            *eax = 0x2;
+            *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
+            *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
+            *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
+        }
+        break;
+    case 0x80000021:
+        *eax = *ebx = *ecx = *edx = 0;
+        *eax = env->features[FEAT_8000_0021_EAX];
+        *ebx = env->features[FEAT_8000_0021_EBX];
+        break;
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
@@ -8497,21 +8512,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         break;
-    case 0x8000001F:
-        *eax = *ebx = *ecx = *edx = 0;
-        if (sev_enabled()) {
-            *eax = 0x2;
-            *eax |= sev_es_enabled() ? 0x8 : 0;
-            *eax |= sev_snp_enabled() ? 0x10 : 0;
-            *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
-            *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
-        }
-        break;
-    case 0x80000021:
-        *eax = *ebx = *ecx = *edx = 0;
-        *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = env->features[FEAT_8000_0021_EBX];
-        break;
     default:
         /* reserved values: zero */
         *eax = 0;
-- 
2.34.1


