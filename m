Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE65C83028
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW9eB-0003yz-BO; Mon, 30 Jun 2025 04:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9eA-0003vd-24
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:50 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9e3-0008Fh-CM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751271223; x=1782807223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=huJnZK6/VFdFTS+MtsTCfXogRK27ANF61hUOOHmIvh0=;
 b=GHKUw2Jf1g+xa8govwK9PHBcbtiflgFf5efEI+zSxNSsMW3ty61sypMb
 Az4mKeJtT9u6cFTXB+UPX68q87GXpj8vQicwX5CpzXQAVgf5UGD30UQi0
 brn6CH1XeRyOJusYS+tV4W9bBnP55FTgB7Eo0oSJ+9mpoNY7mZ9USHOtF
 dr6966EIhFZ6vrvrTNQyy3KQf2ljdp61VGTp+jKplzkQj+zby1SzLoejH
 envGmQf1Mte4gZEec8u/eRcIJK+6+lULPfbU18xyOOjvYf7i7oXg2S6Ap
 BIVJfwJ6M7r6Vyh3qzqSObn+UpnwpMWOP7X0Z21jUDUHk7XrrwANe9IY/ g==;
X-CSE-ConnectionGUID: 9DaoTr13QQe61R1YEw95CA==
X-CSE-MsgGUID: hDs72dupTN+2eW0jbHcHnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53637397"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="53637397"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 01:13:37 -0700
X-CSE-ConnectionGUID: KrpeSJEhTNqnmt//GeESdA==
X-CSE-MsgGUID: qNkGmzTSTTaNHEGwCXxPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="152777285"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 01:13:36 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 1/4] i386/cpu: Use CPUID_MODEL_ID_SZ instead of hardcoded 48
Date: Mon, 30 Jun 2025 16:06:07 +0800
Message-ID: <20250630080610.3151956-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630080610.3151956-1-xiaoyao.li@intel.com>
References: <20250630080610.3151956-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
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

There is already the MACRO CPUID_MODEL_ID_SZ defined in QEMU. Use it to
replace all the hardcoded 48.

Opportunistically fix the indentation of CPUID_VENDOR_SZ.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c      | 8 ++++----
 target/i386/cpu.h      | 3 ++-
 target/i386/host-cpu.c | 1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..d80e57d0cc0d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6468,11 +6468,11 @@ static char *x86_cpuid_get_model_id(Object *obj, Error **errp)
     char *value;
     int i;
 
-    value = g_malloc(48 + 1);
-    for (i = 0; i < 48; i++) {
+    value = g_malloc(CPUID_MODEL_ID_SZ + 1);
+    for (i = 0; i < CPUID_MODEL_ID_SZ; i++) {
         value[i] = env->cpuid_model[i >> 2] >> (8 * (i & 3));
     }
-    value[48] = '\0';
+    value[CPUID_MODEL_ID_SZ] = '\0';
     return value;
 }
 
@@ -6487,7 +6487,7 @@ static void x86_cpuid_set_model_id(Object *obj, const char *model_id,
         model_id = "";
     }
     len = strlen(model_id);
-    memset(env->cpuid_model, 0, 48);
+    memset(env->cpuid_model, 0, CPUID_MODEL_ID_SZ);
     for (i = 0; i < 48; i++) {
         if (i >= len) {
             c = '\0';
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..b83c521d9fbb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1159,7 +1159,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* PMM enabled */
 #define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
 
-#define CPUID_VENDOR_SZ      12
+#define CPUID_VENDOR_SZ     12
+#define CPUID_MODEL_ID_SZ   48
 
 #define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
 #define CPUID_VENDOR_INTEL_2 0x49656e69 /* "ineI" */
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 7512567298bc..16c236478e2b 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -80,7 +80,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
     return true;
 }
 
-#define CPUID_MODEL_ID_SZ 48
 /**
  * cpu_x86_fill_model_id:
  * Get CPUID model ID string from host CPU.
-- 
2.43.0


