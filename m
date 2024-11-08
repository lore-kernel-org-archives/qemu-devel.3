Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88365D5E144
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JGn-0006Sg-FA; Fri, 08 Nov 2024 02:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGX-0006MQ-VH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:46 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGV-0007Po-U4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731050324; x=1762586324;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a6VnkIJWzXWOZ9b+43lACAM3/4OzVnDFwwVjAPUfL5U=;
 b=OE+y7bjlOmoCpX7gjii2AX+1H97Vsb4JMpSmlrqx+JOEpe/9ffsuiNkm
 n65U6WTpH5hoAt+nPzTdM2FijJESq6ZsKf/r+Okig399o9akFeU7l2uWB
 uE2iWVaXFwl4BE3N/0qc9/qvqwvIjlXkyFjS9b5dUCRDHeVtiyVbrmPQH
 46B0ds4wVDz6lMCrYKBAOnEW8Ku9YQSlw0BgskmuFkFY5EbS8KqCpWY8B
 LH7rAofq0MyF0QsnsHkxnRvrP9TDD/p/NkwJYD3GZAj51AHCMrcnGaDh8
 d2mref5KSPQzZRKq6ZRBZLqs3CIrgFsKaWdJBQ64FZru89p1Olqd24G7h g==;
X-CSE-ConnectionGUID: nIwW9Xr+R+m92JU1r/Pagw==
X-CSE-MsgGUID: pI4+0M+TRla6525hadsfFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31082920"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31082920"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 23:18:42 -0800
X-CSE-ConnectionGUID: TlXPCfgiRLWE96MY6ximKw==
X-CSE-MsgGUID: WCA84hHqRCSnCnicoDPeFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="86240949"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 07 Nov 2024 23:18:38 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in x86_cpu_expand_features()
 instead of cpu_x86_cpuid()
Date: Fri,  8 Nov 2024 02:06:07 -0500
Message-Id: <20241108070609.3653085-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108070609.3653085-1-xiaoyao.li@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

Track CPUID_HT in env->features[FEAT_1_EDX] instead of evaluating it
each time in cpu_x86_cpuid(). env->features[] should be set up in cpu's
realizefn() and cpu_x86_cpuid() should be the consumer of it.

Beside, TDX support also depends on it because TDX is going to validate
the feature configuration by comparing what TDX module reports with
env->features[]. If not tracking CPUID_HT in env->features[], it gets
warnings like below when number of vcpus > 1:

  warning: TDX enforces set the feature: CPUID.01H:EDX.ht [bit 28]

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1179b7a3ce62..e0c5a61ff615 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6544,7 +6544,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
-            *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
@@ -7490,6 +7489,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
 void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     FeatureWord w;
     int i;
     GList *l;
@@ -7531,6 +7531,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (cs->nr_cores * cs->nr_threads > 1) {
+        env->features[FEAT_1_EDX] |= CPUID_HT;
+    }
+
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.34.1


