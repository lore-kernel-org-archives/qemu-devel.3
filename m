Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25544CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9n-0002Fx-1E; Thu, 19 Sep 2024 01:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9Q-0007dY-1N; Thu, 19 Sep 2024 01:56:27 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9N-0007Oq-V7; Thu, 19 Sep 2024 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725382; x=1758261382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=swUKe7Dk5Q6yJ5VJiLcmgO4PNjWAtrL0i/B6l+A1Xbk=;
 b=PCTomY9s02qTh2irRjUlZtOAs0KmV94xFPUJZmAQwjbtxHYziWOXmkr+
 XsGU32kuV4piwtik0NW0U45joOaklIRSdtdTHtq/E7sjRdcxtExuan1N6
 dDbOJShM9uyNfPLkhjNw38xrJCMaumtQZxDS6/S3mBANFxYNMsFL7MfTx
 swmgEmIHuUZGSiwZ5/Cj8VdcI9Rp6yPUVYuu73GJBcvGxcZFN2ByB6bu3
 61mmwNnc15T06wC7WtSMaFClnCmfb9pMTyyYUHzWEdlwhCIHjlJOWd4Hr
 UeWCuKCKA7vwIi4pPqmWs9Kn1ICE8j78lLxy0MveV5lv0Du7YfAmOwvgB w==;
X-CSE-ConnectionGUID: yQTJvgCVTyumXg8iz06Biw==
X-CSE-MsgGUID: vXVJ8n8KRg6JHpnYBs4KFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813668"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813668"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:56:20 -0700
X-CSE-ConnectionGUID: 0tIfENWWT32Xu6SDNpEnXA==
X-CSE-MsgGUID: OO4hh/zZRMaI4/Pt2zCRAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418778"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:56:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 08/12] hw/i386: Use get_max_topo_by_level() to get topology
 information
Date: Thu, 19 Sep 2024 14:11:24 +0800
Message-Id: <20240919061128.769139-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

To honor the custom topology case and generate correct APIC ID for
hybrid CPU topology, Use get_max_topo_by_level() to get topology
information instead of accessing MachineState.smp directly.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/x86-common.c | 19 +++++++++++++------
 hw/i386/x86.c        | 20 +++++++++++++-------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 75d4b2f3d43a..58591e015569 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -202,11 +202,15 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 
 static void x86_fixup_topo_ids(MachineState *ms, X86CPU *cpu)
 {
+    int max_modules, max_dies;
+
+    max_modules = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_MODULE);
+    max_dies = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_DIE);
     /*
      * die-id was optional in QEMU 4.0 and older, so keep it optional
      * if there's only one die per socket.
      */
-    if (cpu->module_id < 0 && ms->smp.modules == 1) {
+    if (cpu->module_id < 0 && max_modules == 1) {
         cpu->module_id = 0;
     }
 
@@ -214,7 +218,7 @@ static void x86_fixup_topo_ids(MachineState *ms, X86CPU *cpu)
      * module-id was optional in QEMU 9.0 and older, so keep it optional
      * if there's only one module per die.
      */
-    if (cpu->die_id < 0 && ms->smp.dies == 1) {
+    if (cpu->die_id < 0 && max_dies == 1) {
         cpu->die_id = 0;
     }
 }
@@ -393,6 +397,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     MachineState *ms = MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     X86CPUTopoInfo topo_info;
+    int max_modules, max_dies;
 
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -413,13 +418,15 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
-    if (ms->smp.modules > 1) {
-        env->nr_modules = ms->smp.modules;
+    max_modules = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_MODULE);
+    if (max_modules > 1) {
+        env->nr_modules = max_modules;
         set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
-    if (ms->smp.dies > 1) {
-        env->nr_dies = ms->smp.dies;
+    max_dies = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_DIE);
+    if (max_dies > 1) {
+        env->nr_dies = max_dies;
         set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
     }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index cdf7b81ad0e3..55904b545d84 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -44,16 +44,20 @@ void init_topo_info(X86CPUTopoInfo *topo_info,
 {
     MachineState *ms = MACHINE(x86ms);
 
-    topo_info->dies_per_pkg = ms->smp.dies;
+    topo_info->dies_per_pkg =
+        get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_DIE);
     /*
      * Though smp.modules means the number of modules in one cluster,
      * i386 doesn't support cluster level so that the smp.clusters
      * always defaults to 1, therefore using smp.modules directly is
      * fine here.
      */
-    topo_info->modules_per_die = ms->smp.modules;
-    topo_info->cores_per_module = ms->smp.cores;
-    topo_info->threads_per_core = ms->smp.threads;
+    topo_info->modules_per_die =
+        get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_MODULE);
+    topo_info->cores_per_module =
+        get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_CORE);
+    topo_info->threads_per_core =
+        get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_THREAD);
 }
 
 /*
@@ -103,7 +107,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     X86MachineState *x86ms = X86_MACHINE(ms);
     unsigned int max_cpus = ms->smp.max_cpus;
     X86CPUTopoInfo topo_info;
-    int i;
+    int i, max_dies, max_modules;
 
     if (ms->possible_cpus) {
         /*
@@ -120,6 +124,8 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
     init_topo_info(&topo_info, x86ms);
 
+    max_dies = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_DIE);
+    max_modules = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_MODULE);
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;
 
@@ -131,11 +137,11 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
                                  &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
-        if (ms->smp.dies > 1) {
+        if (max_dies > 1) {
             ms->possible_cpus->cpus[i].props.has_die_id = true;
             ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
         }
-        if (ms->smp.modules > 1) {
+        if (max_modules > 1) {
             ms->possible_cpus->cpus[i].props.has_module_id = true;
             ms->possible_cpus->cpus[i].props.module_id = topo_ids.module_id;
         }
-- 
2.34.1


