Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1F3CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9k-0001de-0r; Thu, 19 Sep 2024 01:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9L-0007Hq-TN; Thu, 19 Sep 2024 01:56:21 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9I-0007Oq-Kw; Thu, 19 Sep 2024 01:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725377; x=1758261377;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NEuBE48juMTcQ/dJZHqJkRWuT1BVDd+3siUk37y9rsM=;
 b=DRNRvqMQTNE3O3IwDeJJcblYC/f99+LaLlNpNqinxDNAMmheAyC6r/bs
 +qXs68DSsp2Czvr3V/LSb/w+RQlpbWN6ukQeBJ7kw0kw1TqisIEmqfpxb
 6NF3aI43zgopRTvhd41DsNelAgAmZbqHbEYTB6s9zldXJl75qFybdpQh+
 K8XrckbiLemy83IRzZ4lrPGw7xiRfBy5tMI7G/ilcP2SYKP8H2B0ELam/
 aIetsNFFeN5uCNrh3DZgJFQ7ZmmvIB5YIzKLq7yjacGAdMj9vMuDOL8S6
 cTR7r108qzOCcjot0sQPU+enxWBDFHSrR1ySgnwgHgTZ/NvouWWpvwiTT A==;
X-CSE-ConnectionGUID: LzdMyRNRQiC9btrEmAi6eg==
X-CSE-MsgGUID: NjSE/fQUSrqTZJfpMm4/qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813638"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:56:14 -0700
X-CSE-ConnectionGUID: uRrDVkRIRWuVWkVS9YAxng==
X-CSE-MsgGUID: NLGU4weHTJKIgFAW97vQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418749"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:56:07 -0700
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
Subject: [RFC v2 07/12] hw/core: Re-implement topology helpers to honor max
 limitations
Date: Thu, 19 Sep 2024 14:11:23 +0800
Message-Id: <20240919061128.769139-8-zhao1.liu@intel.com>
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

For custom topology case, the valid and reliable topology information
be obtained from topology max limitations.

Therefore, re-implement machine_topo_get_cores_per_socket() and
machine_topo_get_threads_per_socket() to consider the custom topology
case. And further, use the wrapped helper to set CPUState.nr_threads/
nr_cores, avoiding topology mismatches in custom topology scenarios.

Additionally, since test-smp-parse needs more stubs to compile with
cpu-slot.c, keep the old helpers for test-smp-parse' use for now. The
legacy old helpers will be cleaned up when full compilation support is
added later on.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c       |  8 +++++---
 hw/cpu/cpu-slot.c           | 18 ++++++++++++++++++
 include/hw/boards.h         |  9 +++++++--
 include/hw/cpu/cpu-slot.h   |  2 ++
 system/cpus.c               |  2 +-
 tests/unit/test-smp-parse.c |  4 ++--
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index d3be4352267d..2965b042fd92 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -376,14 +376,16 @@ bool machine_parse_smp_cache(MachineState *ms,
     return true;
 }
 
-unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+unsigned int machine_topo_get_cores_per_socket_old(const MachineState *ms)
 {
+    assert(!ms->topo);
     return ms->smp.cores * ms->smp.modules * ms->smp.clusters * ms->smp.dies;
 }
 
-unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+unsigned int machine_topo_get_threads_per_socket_old(const MachineState *ms)
 {
-    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
+    assert(!ms->topo);
+    return ms->smp.threads * machine_topo_get_cores_per_socket_old(ms);
 }
 
 CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
index f2b9c412926f..8c0d55e835e2 100644
--- a/hw/cpu/cpu-slot.c
+++ b/hw/cpu/cpu-slot.c
@@ -204,6 +204,8 @@ static int get_smp_info_by_level(const CpuTopology *smp_info,
         return smp_info->cores;
     case CPU_TOPOLOGY_LEVEL_MODULE:
         return smp_info->modules;
+    case CPU_TOPOLOGY_LEVEL_CLUSTER:
+        return smp_info->clusters;
     case CPU_TOPOLOGY_LEVEL_DIE:
         return smp_info->dies;
     case CPU_TOPOLOGY_LEVEL_SOCKET:
@@ -356,6 +358,22 @@ int get_max_topo_by_level(const MachineState *ms, CpuTopologyLevel level)
     return ms->topo->stat.entries[level].max_limit;
 }
 
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+{
+    int cores = 1, i;
+
+    for (i = CPU_TOPOLOGY_LEVEL_CORE; i < CPU_TOPOLOGY_LEVEL_SOCKET; i++) {
+        cores *= get_max_topo_by_level(ms, i);
+    }
+    return cores;
+}
+
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+{
+    return get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_THREAD) *
+           machine_topo_get_cores_per_socket(ms);
+}
+
 bool machine_parse_custom_topo_config(MachineState *ms,
                                       const SMPConfiguration *config,
                                       Error **errp)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6ef4ea322590..faf7859debdd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -48,8 +48,13 @@ void machine_parse_smp_config(MachineState *ms,
 bool machine_parse_smp_cache(MachineState *ms,
                              const SmpCachePropertiesList *caches,
                              Error **errp);
-unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
-unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
+/*
+ * TODO: Drop these old helpers when cpu-slot.c could be compiled for
+ * test-smp-parse. Pls use machine_topo_get_cores_per_socket() and
+ * machine_topo_get_threads_per_socket() instead.
+ */
+unsigned int machine_topo_get_cores_per_socket_old(const MachineState *ms);
+unsigned int machine_topo_get_threads_per_socket_old(const MachineState *ms);
 CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
                                               CacheLevelAndType cache);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
diff --git a/include/hw/cpu/cpu-slot.h b/include/hw/cpu/cpu-slot.h
index f56a0b08dca4..230309b67fe1 100644
--- a/include/hw/cpu/cpu-slot.h
+++ b/include/hw/cpu/cpu-slot.h
@@ -81,6 +81,8 @@ struct CPUSlot {
 void machine_plug_cpu_slot(MachineState *ms);
 bool machine_create_topo_tree(MachineState *ms, Error **errp);
 int get_max_topo_by_level(const MachineState *ms, CpuTopologyLevel level);
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
 bool machine_parse_custom_topo_config(MachineState *ms,
                                       const SMPConfiguration *config,
                                       Error **errp);
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828c..53e7cfb8a55f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -667,7 +667,7 @@ void qemu_init_vcpu(CPUState *cpu)
     MachineState *ms = MACHINE(qdev_get_machine());
 
     cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
-    cpu->nr_threads =  ms->smp.threads;
+    cpu->nr_threads = get_max_topo_by_level(ms, CPU_TOPOLOGY_LEVEL_THREAD);
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index f9bccb56abc7..44d2213a7163 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -801,8 +801,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
     /* call the generic parser */
     machine_parse_smp_config(ms, config, &err);
 
-    ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
-    ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
+    ms_threads_per_socket = machine_topo_get_threads_per_socket_old(ms);
+    ms_cores_per_socket = machine_topo_get_cores_per_socket_old(ms);
     output_topo_str = cpu_topology_to_string(&ms->smp,
                                              ms_threads_per_socket,
                                              ms_cores_per_socket,
-- 
2.34.1


