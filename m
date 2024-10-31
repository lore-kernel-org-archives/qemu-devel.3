Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23A1E68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 09:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0h-0000ic-PG; Thu, 31 Oct 2024 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0g-0000iI-NL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:30 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0f-0003Df-7g
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365109; x=1761901109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9VjjJYDFcgFlWNJ1FOvFU9s2rvOXHSEg5LYj3IBDpC4=;
 b=emWixkBKKuSuQwRXqK1lyxwbnTBoOxgEOFVarzwjbZj/NbBaI5KyQXgn
 MdHotUPlF2ZeIXTSp0CEn2zcZxaKtDKaj9pXpGIoqxRNyhc5uU2Bn95wl
 EAWy1qGnTfL+JUNR8aUFjU7XtzH2QxgE0GYg3E0sBkcs+BAMZazqh94pY
 6h+jIoV8F2FODuFr9QXRnGr+dsZDRHKKiX0KvkLU4f7S5j0NKj7u39MvY
 OFmnH39KQ3fwSRIOXpmxRpOEvPLWIHhQI7FtIcTBskVUoYzHfGKHsF7pm
 hipJqDbxzBqWF0AV4z9r15osq00XeNHT69TFNsMMjTBNCCsjRQ7uPV+uG w==;
X-CSE-ConnectionGUID: YwknYi9UQmCbi1vRkpSl5Q==
X-CSE-MsgGUID: jR/35ci4Qs+JwO5s57IUqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492678"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492678"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:27 -0700
X-CSE-ConnectionGUID: egAIj5/iTq6fwvHykiUjiA==
X-CSE-MsgGUID: Q9e0wZbwRwG9rLtFGutQNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489510"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:25 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 3/8] target/i386: return bool from x86_cpu_filter_features
Date: Thu, 31 Oct 2024 16:52:28 +0800
Message-Id: <20241031085233.425388-4-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031085233.425388-1-tao1.su@linux.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Prepare for filtering non-boolean features such as AVX10 version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f8b5c28caf..8fbbf1fd9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5818,7 +5818,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -7523,9 +7523,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
  * Finishes initialization of CPUID data, filters CPU feature
  * words based on host availability of each feature.
  *
- * Returns: 0 if all flags are supported by the host, non-zero otherwise.
+ * Returns: true if any flag is not supported by the host, false otherwise.
  */
-static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
@@ -7577,6 +7577,8 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
+
+    return x86_cpu_have_filtered_features(cpu);
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
@@ -7674,14 +7676,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
-
-    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
-        error_setg(&local_err,
-                   accel_uses_host_cpuid() ?
+    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+        if (cpu->enforce_cpuid) {
+            error_setg(&local_err,
+                       accel_uses_host_cpuid() ?
                        "Host doesn't support requested features" :
                        "TCG doesn't support requested features");
-        goto out;
+            goto out;
+        }
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
2.34.1


