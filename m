Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711ED5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JGu-0006X4-Qi; Fri, 08 Nov 2024 02:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGg-0006QA-QH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:55 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGe-0007Po-5n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731050332; x=1762586332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UomARFnS0nQKCvmXO47RhasSQBfQMFc85ip6MKMZ2SM=;
 b=B7J1NqVznJevdURtj6nvPNlerKSPKLoAG5DyuoRcdlwF5ndS0H8WV9tj
 0RYqrA453i/NbpxgwnURsvGNDacTOkhtSdmveCUTr19f1hn6gtmvxdo6l
 DS6bpJ9+iiZB5Fk9XtqqctNusRAKVetfOsUaHYaRFwwU+qP/GbDjECeA1
 ROAeXyikF2/nt+fGkzb41omAMuf4bObos1X7RmrgGv2TtV52btbMuDOwh
 r3Mqo4f0SPx4aJPVeKmTeKd6p2IzqyL/57xFlzP8NbVZdG/UYITmQ3oH3
 aBuaCvnMjAF6TgzRZzBmOMLUfQBBYcoWAIxqIEYpM5KZ48SaggA/uHwqQ Q==;
X-CSE-ConnectionGUID: otc9tAmfQp+sxVhyo5mXHg==
X-CSE-MsgGUID: qHLRXI7qR0Km9S2vxtHoEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31082949"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31082949"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 23:18:51 -0800
X-CSE-ConnectionGUID: UG4tvoAGQMSOaJzwCJltbQ==
X-CSE-MsgGUID: ZH7HAklYR6mY4wh8GR5bkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="86240988"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 07 Nov 2024 23:18:47 -0800
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
Subject: [PATCH v1 4/4] i386/cpu: Rectify the comment on order dependency on
 qemu_init_vcpu()
Date: Fri,  8 Nov 2024 02:06:09 -0500
Message-Id: <20241108070609.3653085-5-xiaoyao.li@intel.com>
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

Now cs->nr_threads is initialized in qemu_early_init_vcpu() which is
called at the begining of realizef(). Drop the comment of the order
dependcy on qemu_init_vcpu() and hoist code to put it together with
other feature checking.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 015e085fa66c..98910fa49250 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7887,6 +7887,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
 
+    /*
+     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
+     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
+     * based on inputs (sockets,cores,threads), it is still better to give
+     * users a warning.
+     */
+    if (IS_AMD_CPU(env) &&
+        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+        cs->nr_threads > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", cs->nr_threads);
+    }
+
     /* For 64bit systems think about the number of physical bits to present.
      * ideally this should be the same as the host; anything other than matching
      * the host can cause incorrect guest behaviour.
@@ -7991,24 +8006,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     x86_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 
-    /*
-     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
-     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
-     * based on inputs (sockets,cores,threads), it is still better to give
-     * users a warning.
-     *
-     * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
-     * cs->nr_threads hasn't be populated yet and the checking is incorrect.
-     */
-    if (IS_AMD_CPU(env) &&
-        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        cs->nr_threads > 1) {
-            warn_report_once("This family of AMD CPU doesn't support "
-                             "hyperthreading(%d). Please configure -smp "
-                             "options properly or try enabling topoext "
-                             "feature.", cs->nr_threads);
-    }
-
 #ifndef CONFIG_USER_ONLY
     x86_cpu_apic_realize(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.34.1


