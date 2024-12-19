Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB5E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVq-0004bV-GL; Thu, 19 Dec 2024 06:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVo-0004aG-V1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:13 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVn-0005Jo-Ca
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606972; x=1766142972;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXysrcQtxF3+DT6qASzZRMSb17Gh/uEz3CgCSTb5hj8=;
 b=YHRvakkyno+pr3dQ73ko6le6FYephJAV0Kw1Hqh11pbT36zDT1NTkJLM
 IPFxuO1fw/RHhbH53gpc8SdNO/AveWBDYeQTwXU5EH/+2X1oZurE5RX58
 RXJQdGxF7ppAPXmGea7aHGEcuDkQn2AJSnLiJbJ2FXQqBa7ProfaQcqh8
 ByiVVo8aM3ZG426ZW4TYalsfQaqAzO10up7dkHOz9osg8Wzqj0VNMhcVd
 ppx1nv7u3IIcTR5ZQHrwP0m75XfrAaiJ3uof2+1UouwcrZ6cVEwav3NTc
 3RgVNu74OmldRYex5MOVAF4Aob2Sw2ikwdwb2ifQ3qelcv+THZ8f2UlS/ A==;
X-CSE-ConnectionGUID: MyaX/2gQS/2yBXrl2rjewg==
X-CSE-MsgGUID: bHfqIfKZQbGV/hMyLAnUcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994971"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994971"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:11 -0800
X-CSE-ConnectionGUID: e5mPFWv7TCOYVV25bSbAjA==
X-CSE-MsgGUID: mRrOHL98S2+G6UNLTtQTuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956174"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:08 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 07/10] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT against
 threads_per_core
Date: Thu, 19 Dec 2024 06:01:22 -0500
Message-Id: <20241219110125.1266461-8-xiaoyao.li@intel.com>
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

Now it changes to use env->topo_info.threads_per_core and doesn't depend
on qemu_init_vcpu() anymore. Drop the comment of the order dependency on
qemu_init_vcpu() and hoist code to put it together with other feature
checking.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d41768648ab9..fd59da5d445d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7880,6 +7880,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
+        env->nr_threads > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", env->nr_threads);
+    }
+
     /* For 64bit systems think about the number of physical bits to present.
      * ideally this should be the same as the host; anything other than matching
      * the host can cause incorrect guest behaviour.
@@ -7984,21 +7999,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     x86_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 
-    /*
-     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
-     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
-     * based on inputs (sockets,cores,threads), it is still better to give
-     * users a warning.
-     */
-    if (IS_AMD_CPU(env) &&
-        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        env->topo_info.threads_per_core > 1) {
-            warn_report_once("This family of AMD CPU doesn't support "
-                             "hyperthreading(%d). Please configure -smp "
-                             "options properly or try enabling topoext "
-                             "feature.", env->topo_info.threads_per_core);
-    }
-
 #ifndef CONFIG_USER_ONLY
     x86_cpu_apic_realize(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.34.1


