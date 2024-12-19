Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB206E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVo-0004a1-8c; Thu, 19 Dec 2024 06:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVb-0004Vy-UV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:00 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVZ-0005Hq-O1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606958; x=1766142958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hGrOY+aNrIOBOmNFWeGMrcHfpcpocdtMH4I0QQYaVbU=;
 b=gv1BFoMFLXIO0vp2k9mtC5B/8EKzi2Rm1pzaWmL+ZW17P6FVZOhHDXuw
 yk/s7WcayS34/L0AWLwSX2Fsx7Ln5BVPyOlHN6E0Nc4Kim4u+aa5frBz1
 Rjnocf4XObyY77UvnesdkqIjZnV9LiUkdMEBAgVmceFQbmQYeuVPHu4IN
 ETpP6JfuYm8Ix8MvW7creQhYv2z17Azodvp/HXrKT7HVq740JBpepBVM4
 vhiUkGp0qW0fiAyz19qDqiBpbgezDwB2nktgRA8rx3H/2IGd86FkRWcI1
 UwjcAufHU9JPJb/BJsRZ3GBM3Cf4VTUKNK5PmvF1xeJNsFt3NyVAJiPls g==;
X-CSE-ConnectionGUID: j1Z6gqtaQKO1A4uBRcD5uQ==
X-CSE-MsgGUID: brA0zVM6Q5iyt/kXFRtkEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994936"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:15:57 -0800
X-CSE-ConnectionGUID: 5rMX38JKSW25WC+VA1ccpg==
X-CSE-MsgGUID: 8lFa2maCSp+EKjOnCa9BEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956125"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:15:53 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 02/10] i386/cpu: Drop the variable smp_cores and
 smp_threads in x86_cpu_pre_plug()
Date: Thu, 19 Dec 2024 06:01:17 -0500
Message-Id: <20241219110125.1266461-3-xiaoyao.li@intel.com>
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

No need to define smp_cores and smp_threads, just using ms->smp.cores
and ms->smp.threads is straightforward. It's also consistent with other
checks of socket/die/module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 3f7818269234..32a8d7a9db87 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -248,8 +248,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    unsigned int smp_cores = ms->smp.cores;
-    unsigned int smp_threads = ms->smp.threads;
     X86CPUTopoInfo topo_info;
 
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
@@ -329,17 +327,17 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
             return;
-        } else if (cpu->core_id > (smp_cores - 1)) {
+        } else if (cpu->core_id > (ms->smp.cores - 1)) {
             error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
-                       cpu->core_id, smp_cores - 1);
+                       cpu->core_id, ms->smp.cores - 1);
             return;
         }
         if (cpu->thread_id < 0) {
             error_setg(errp, "CPU thread-id is not set");
             return;
-        } else if (cpu->thread_id > (smp_threads - 1)) {
+        } else if (cpu->thread_id > (ms->smp.threads - 1)) {
             error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
-                       cpu->thread_id, smp_threads - 1);
+                       cpu->thread_id, ms->smp.threads - 1);
             return;
         }
 
-- 
2.34.1


