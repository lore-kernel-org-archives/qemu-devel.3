Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9324BC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMAk-0000px-Bj; Tue, 20 Feb 2024 04:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAd-0000kU-0P; Tue, 20 Feb 2024 04:12:11 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAb-0003Nd-2j; Tue, 20 Feb 2024 04:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708420329; x=1739956329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eqNjZBlNcC8WFXOhViSe+F312lyqzht+4UXK0ymAVGc=;
 b=lVFPRw7ViOnDrm2MDKS/5U7GvaDzFtErf6HrOfnt6i69oy4ATskLcxDY
 FRIMrBAeC7vhQDTQXEd3B2QpRzZs33JbpWqWJ2RNdXp4ha8Wt5x6jZWtz
 2/IOCa1aFq/OsICeDWcV8w8sOcXQQKnOJale3LwGzr3tmJLe/wRWuokv7
 Y6P8h4dov6YA1X/yyj4eGWp6bAZSnEj47fjiiGzxA7rL96+Z4x2Q7uSO6
 nO64V0AqBLUxiEYF0REOWDtBoWnyxKzjmMxcvtvuts+P2imRDdWIEIZ+F
 S732rjDDDSwutwTqKpm9tPiypGO1yKixb87AZtpuG7CFZEaeDnHmpE9pC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2374996"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2374996"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 01:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5012989"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 01:12:01 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 4/8] hw/core: Add cache topology options in -smp
Date: Tue, 20 Feb 2024 17:25:00 +0800
Message-Id: <20240220092504.726064-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
-smp to define the cache topology for SMP system.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c | 128 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c     |   4 ++
 qapi/machine.json     |  14 ++++-
 system/vl.c           |  15 +++++
 4 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 8a8296b0d05b..2cbd19f4aa57 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -61,6 +61,132 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
     return g_string_free(s, false);
 }
 
+static bool machine_check_topo_support(MachineState *ms,
+                                       CPUTopoLevel topo)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (topo == CPU_TOPO_LEVEL_MODULE && !mc->smp_props.modules_supported) {
+        return false;
+    }
+
+    if (topo == CPU_TOPO_LEVEL_CLUSTER && !mc->smp_props.clusters_supported) {
+        return false;
+    }
+
+    if (topo == CPU_TOPO_LEVEL_DIE && !mc->smp_props.dies_supported) {
+        return false;
+    }
+
+    if (topo == CPU_TOPO_LEVEL_BOOK && !mc->smp_props.books_supported) {
+        return false;
+    }
+
+    if (topo == CPU_TOPO_LEVEL_DRAWER && !mc->smp_props.drawers_supported) {
+        return false;
+    }
+
+    return true;
+}
+
+static int smp_cache_string_to_topology(MachineState *ms,
+                                        char *topo_str,
+                                        CPUTopoLevel *topo,
+                                        Error **errp)
+{
+    *topo = string_to_cpu_topo(topo_str);
+
+    if (*topo == CPU_TOPO_LEVEL_MAX || *topo == CPU_TOPO_LEVEL_INVALID) {
+        error_setg(errp, "Invalid cache topology level: %s. The cache "
+                   "topology should match the CPU topology level", topo_str);
+        return -1;
+    }
+
+    if (!machine_check_topo_support(ms, *topo)) {
+        error_setg(errp, "Invalid cache topology level: %s. The topology "
+                   "level is not supported by this machine", topo_str);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void machine_parse_smp_cache_config(MachineState *ms,
+                                           const SMPConfiguration *config,
+                                           Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (config->l1d_cache) {
+        if (!mc->smp_props.l1_separated_cache_supported) {
+            error_setg(errp, "L1 D-cache topology not "
+                       "supported by this machine");
+            return;
+        }
+
+        if (smp_cache_string_to_topology(ms, config->l1d_cache,
+            &ms->smp_cache.l1d, errp)) {
+            return;
+        }
+    }
+
+    if (config->l1i_cache) {
+        if (!mc->smp_props.l1_separated_cache_supported) {
+            error_setg(errp, "L1 I-cache topology not "
+                       "supported by this machine");
+            return;
+        }
+
+        if (smp_cache_string_to_topology(ms, config->l1i_cache,
+            &ms->smp_cache.l1i, errp)) {
+            return;
+        }
+    }
+
+    if (config->l2_cache) {
+        if (!mc->smp_props.l2_unified_cache_supported) {
+            error_setg(errp, "L2 cache topology not "
+                       "supported by this machine");
+            return;
+        }
+
+        if (smp_cache_string_to_topology(ms, config->l2_cache,
+            &ms->smp_cache.l2, errp)) {
+            return;
+        }
+
+        if (ms->smp_cache.l1d > ms->smp_cache.l2 ||
+            ms->smp_cache.l1i > ms->smp_cache.l2) {
+            error_setg(errp, "Invalid L2 cache topology. "
+                       "L2 cache topology level should not be "
+                       "lower than L1 D-cache/L1 I-cache");
+            return;
+        }
+    }
+
+    if (config->l3_cache) {
+        if (!mc->smp_props.l2_unified_cache_supported) {
+            error_setg(errp, "L3 cache topology not "
+                       "supported by this machine");
+            return;
+        }
+
+        if (smp_cache_string_to_topology(ms, config->l3_cache,
+            &ms->smp_cache.l3, errp)) {
+            return;
+        }
+
+        if (ms->smp_cache.l1d > ms->smp_cache.l3 ||
+            ms->smp_cache.l1i > ms->smp_cache.l3 ||
+            ms->smp_cache.l2 > ms->smp_cache.l3) {
+            error_setg(errp, "Invalid L3 cache topology. "
+                       "L3 cache topology level should not be "
+                       "lower than L1 D-cache/L1 I-cache/L2 cache");
+            return;
+        }
+    }
+}
+
 /*
  * machine_parse_smp_config: Generic function used to parse the given
  *                           SMP configuration
@@ -249,6 +375,8 @@ void machine_parse_smp_config(MachineState *ms,
                    mc->name, mc->max_cpus);
         return;
     }
+
+    machine_parse_smp_cache_config(ms, config, errp);
 }
 
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 426f71770a84..cb5173927b0d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -886,6 +886,10 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
         .has_cores = true, .cores = ms->smp.cores,
         .has_threads = true, .threads = ms->smp.threads,
         .has_maxcpus = true, .maxcpus = ms->smp.max_cpus,
+        .l1d_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l1d)),
+        .l1i_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l1i)),
+        .l2_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l2)),
+        .l3_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l3)),
     };
 
     if (!visit_type_SMPConfiguration(v, name, &config, &error_abort)) {
diff --git a/qapi/machine.json b/qapi/machine.json
index d0e7f1f615f3..0a923ac38803 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1650,6 +1650,14 @@
 #
 # @threads: number of threads per core
 #
+# @l1d-cache: topology hierarchy of L1 data cache (since 9.0)
+#
+# @l1i-cache: topology hierarchy of L1 instruction cache (since 9.0)
+#
+# @l2-cache: topology hierarchy of L2 unified cache (since 9.0)
+#
+# @l3-cache: topology hierarchy of L3 unified cache (since 9.0)
+#
 # Since: 6.1
 ##
 { 'struct': 'SMPConfiguration', 'data': {
@@ -1662,7 +1670,11 @@
      '*modules': 'int',
      '*cores': 'int',
      '*threads': 'int',
-     '*maxcpus': 'int' } }
+     '*maxcpus': 'int',
+     '*l1d-cache': 'str',
+     '*l1i-cache': 'str',
+     '*l2-cache': 'str',
+     '*l3-cache': 'str' } }
 
 ##
 # @x-query-irq:
diff --git a/system/vl.c b/system/vl.c
index a82555ae1558..ac95e5ddb656 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -741,6 +741,9 @@ static QemuOptsList qemu_smp_opts = {
         }, {
             .name = "clusters",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "modules",
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "cores",
             .type = QEMU_OPT_NUMBER,
@@ -750,6 +753,18 @@ static QemuOptsList qemu_smp_opts = {
         }, {
             .name = "maxcpus",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "l1d-cache",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "l1i-cache",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "l2-cache",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "l3-cache",
+            .type = QEMU_OPT_STRING,
         },
         { /*End of list */ }
     },
-- 
2.34.1


