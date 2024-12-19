Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE5EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEW0-0004of-VM; Thu, 19 Dec 2024 06:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVy-0004ly-AD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:23 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVv-0005Lm-TH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606980; x=1766142980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3aacQW4Go5h00Zo2AHmCDChkTH3OubD3GyFn8d6eHoo=;
 b=kIUvQCHNW7aI0/UruYL4DXukO3jR7JKKvTw7bJmgLCbawFp1AZfchVgQ
 CYOuQga1+xnkmTRJDvV0hIRGibXmEJ3aZ1E/ghLb4l+3/Pr3BXFCNlvML
 exKnHQP7X9+SAho8vGx3gZ9zZpZTcPq2zV3Lu4ZvAiSEPT1r4Ftjh1DRF
 mOE+XNGkFl04Yun7tAj2kk1exCFvHHZrk8jEsL4dt95zFg6Zf8axxpL5J
 qIp980yj71kl0krdM2P3/L3sPwpVQHW2UFT4tvjknA2z7DP00pJ+xNaBx
 Jz+vR8mQqUfiOrgQYrDNR3s1GG357QGm8XWtiJ5YT4c9gpzF3NtH0w0iC Q==;
X-CSE-ConnectionGUID: 6PewRgOaTbiy0K6LD5j11g==
X-CSE-MsgGUID: k54lDruQR2m7+974RH1rjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34995001"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34995001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:19 -0800
X-CSE-ConnectionGUID: wWQf+0NXSiadEMlzbe6Tmg==
X-CSE-MsgGUID: d4h8tPa1Qh2o4FI+C5kYaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956217"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:15 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 10/10] i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
 env->features[FEAT_8000_0001_ECX]
Date: Thu, 19 Dec 2024 06:01:25 -0500
Message-Id: <20241219110125.1266461-11-xiaoyao.li@intel.com>
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

The correct usage is tracking and maintaining features in env->features[]
instead of manually set it in cpu_x86_cpuid().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bee494bdd029..8d3744aa6d26 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6952,17 +6952,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
-        /* The Linux kernel checks for the CMPLegacy bit and
-         * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
-         */
-        if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
-                *ecx |= 1 << 1;    /* CmpLegacy bit */
-            }
-        }
         if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
@@ -7529,6 +7518,15 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     if (x86_threads_per_pkg(&env->topo_info) > 1) {
         env->features[FEAT_1_EDX] |= CPUID_HT;
+
+        /*
+         * The Linux kernel checks for the CMPLegacy bit and
+         * discards multiple thread information if it is set.
+         * So don't set it here for Intel to make Linux guests happy.
+         */
+        if (!IS_INTEL_CPU(env)) {
+            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.34.1


