Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCB2C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEEm-0007M6-Lf; Mon, 14 Jul 2025 04:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDug-0004fB-Jf
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:53 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDub-0007Nf-Rs
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479266; x=1784015266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hvh/A+yOwx0QCfyh4UllySxlS3/GqY27LJpwlrbxYuw=;
 b=TsgHl5lJP3Op/srSj3Ijrebk6BKLq6JKxI2Zk8hYSvnmV36eqoMLAtdd
 ayNcRXJFei0KgpPOAHHQlaEqawIYGbceqVVhwbgCHH7y19TiJZJGwnwgc
 Rm4ADNF4E6+RxlvmJy0O/vMKkwovNCfB58WD9ZkXRjMWL7nDeUNPau+WY
 oQJLPcqWz9qloym2ilgHgEaFNQnd7Jl4eG/JhXxdEvMGzHMo0hj61+6nz
 DSSZ2fk93a21slYyNLQq9u8Iw1XxDaUUIw1ggPpsgNb9fxRZjcL+eF1Ds
 XfxWOGT5bSAlqPLocRHTNxiJgELaSjkzmhGf6QgYexUbxOoHUKLiyVS2r A==;
X-CSE-ConnectionGUID: 2jYWYuaURre5U0OkQO8maQ==
X-CSE-MsgGUID: e3QJKrZvRM6NTDiXYmknjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324661"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324661"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:42 -0700
X-CSE-ConnectionGUID: R6L+n91VQ0KH47xfzwEVlQ==
X-CSE-MsgGUID: sKB9RHYfQx2EJpRwCDcT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952198"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:40 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/7] i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
Date: Mon, 14 Jul 2025 16:08:55 +0800
Message-Id: <20250714080859.1960104-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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
index abd529d587ba..9e110e49ab8a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8050,21 +8050,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -8205,6 +8190,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -8242,6 +8233,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


