Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E0C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yn-0003YB-Rh; Wed, 14 Aug 2024 04:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8ya-0002zY-RL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:25 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yU-0007sc-Cc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622598; x=1755158598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CS43UzH48cjlmpX92LFl+4C3u5GSWZlxQ4JoVqNlFE8=;
 b=QTcBRXfyGu4ISDitLQ+pGe2MhuyWUq2NhdiMkAzEVz3DAlhJ3GnAMw2g
 Cdl9JCiYVnN2Hcg7i8BpSqUuDtO6cNrAqLvJeVgc2Xvh8pZXDa70HCWRW
 uiM7q/UR+AqMMU1NEKiF+PBqXiFFVfFlNXisJ9xfbre3PYoc54sk/Tlzf
 693zxw10hZd7eeVR558fwoY3bQhmq5MWtBz9OCuLhoO1US+gtUTAuBde/
 hDg9RuV/1Sl+iwUL52cHflJ0shu7gM0htmWWT5GnIXsI3Bx0DkTUuDS5q
 Xp1FJmtUX4L/NVi6yP3qmQrAkUWjZpbse0bh0PEpMpNZiCHj5Gu0SthpZ Q==;
X-CSE-ConnectionGUID: N3wz2giGRvu8A4G27wOWZA==
X-CSE-MsgGUID: bmBPMeC7Ss6JWOUnJnxTQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584510"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584510"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:46 -0700
X-CSE-ConnectionGUID: KgvttIVYRdeLtaOXm/+pdw==
X-CSE-MsgGUID: prB1e/MfTna/Sx4+fuK1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048969"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:45 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 9/9] i386/cpu: Make invtsc migratable when user sets tsc-khz
 explicitly
Date: Wed, 14 Aug 2024 03:54:31 -0400
Message-Id: <20240814075431.339209-10-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When user sets tsc-frequency explicitly, the invtsc feature is actually
migratable because the tsc-frequency is supposed to be fixed during the
migration.

See commit d99569d9d856 ("kvm: Allow invtsc migration if tsc-khz
is set explicitly") for referrence.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ce405ece80..fb3519fc6836 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1865,9 +1865,10 @@ static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
  */
-static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
+static uint64_t x86_cpu_get_migratable_flags(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
+    CPUX86State *env = &cpu->env;
     uint64_t r = 0;
     int i;
 
@@ -1881,6 +1882,12 @@ static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
             r |= f;
         }
     }
+
+    /* when tsc-khz is set explicitly, invtsc is migratable */
+    if ((w == FEAT_8000_0007_EDX) && env->user_tsc_khz) {
+        r |= CPUID_APM_INVTSC;
+    }
+
     return r;
 }
 
@@ -6129,7 +6136,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 
     r &= ~unavail;
     if (cpu && cpu->migratable) {
-        r &= x86_cpu_get_migratable_flags(w);
+        r &= x86_cpu_get_migratable_flags(cpu, w);
     }
     return r;
 }
-- 
2.34.1


