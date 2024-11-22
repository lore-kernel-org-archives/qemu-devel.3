Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7869BE6916C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEWKa-0002Rx-Jg; Fri, 22 Nov 2024 11:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tEWKZ-0002Qj-4G
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:16:27 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tEWKW-0002Bg-J8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732292184; x=1763828184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZSrBNdu2H3L1tG9PQWDqIPUmn/HWuxKpxHuQjxIZ3Nc=;
 b=DVpU24v/0JNcGzmikyFBclCVzb9FwmgYnpxZXzxkHO2k8Xjf347xEOAI
 HYmZqJbI5rld+2OmWEL2fmURMo+Ytj0T3NxOfIxt0KAM9r4+2fI950Bw7
 FN1BReRVC1uG406XWy9qNi1TujfsGEDukKIjq77hQxMGPprcwno11Q+MG
 Wz2Y7OQ2+ptkgHnHlT2t4z9vdgtk/RFDb++0lGIz2WZdS9KQBCfxk/iqK
 aiPjNbRwJbUb+2GXqUR32W7lJKzJD2QN4jRv3Aw5N+5Mn75cULy6e7Do+
 WwQur7qspQLX+mzxTI66yyvLnDnaslFy1E+4AJxx1CCgkadJ/pQJTkOY5 Q==;
X-CSE-ConnectionGUID: 4z4yuDtRRLuhCA2vr9iccQ==
X-CSE-MsgGUID: NXe7wGQ5QCqtUwomhK6fuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49969720"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; d="scan'208";a="49969720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2024 08:16:21 -0800
X-CSE-ConnectionGUID: QaGw/B4ISiKo2Ofia7xV0w==
X-CSE-MsgGUID: Kvz6Ymm6TjCg8R1H2tv3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; d="scan'208";a="91030800"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 22 Nov 2024 08:16:20 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	xiaoyao.li@intel.com
Subject: [PATCH] cpu: Initialize nr_cores and nr_threads in cpu_common_initfn()
Date: Fri, 22 Nov 2024 11:03:17 -0500
Message-Id: <20241122160317.4070177-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108070609.3653085-2-xiaoyao.li@intel.com>
References: <20241108070609.3653085-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.551, RCVD_IN_DNSWL_MED=-2.3,
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

Currently cpu->nr_cores and cpu->nr_threads are initialized in
qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
each ARCHes.

x86 arch would like to use nr_cores and nr_threads earlier in its
realizefn(). To serve this purpose, initialize nr_cores and nr_threads
in cpu_common_initfn(), which is earlier than *cpu_realizefn().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/core/cpu-common.c | 10 +++++++++-
 system/cpus.c        |  4 ----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c79035949b..6de92ed854bc 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -237,14 +237,22 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
+    Object *machine = qdev_get_machine();
+    MachineState *ms;
 
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     /* user-mode doesn't have configurable SMP topology */
-    /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
+#ifndef CONFIG_USER_ONLY
+    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
+        ms = MACHINE(machine);
+        cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
+        cpu->nr_threads = ms->smp.threads;
+    }
+#endif
     cpu->cflags_next_tb = -1;
 
     /* allocate storage for thread info, initialise condition variables */
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828c..c1547fbfd39b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -664,10 +664,6 @@ const AccelOpsClass *cpus_get_accel(void)
 
 void qemu_init_vcpu(CPUState *cpu)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-
-    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
-    cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
-- 
2.34.1


