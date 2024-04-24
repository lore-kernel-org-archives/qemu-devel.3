Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C39C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzefR-0004OS-AV; Wed, 24 Apr 2024 11:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzefL-0004OH-Tb
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:36:13 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzefJ-0005bU-OC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713972970; x=1745508970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NAiHZpGVOqwrzQp+rlbSyO5VMtyvYLfh5u8un67PwEg=;
 b=AnOjxk6OlPbIy7edltW6qGscz/9MHlWkOnwKxR2PSBe1ornKJ9Sovf5e
 wo2+grbKiKTRbQc41gT3Bw/Xf1LAtvg9MYTJ5NjSBpvJbWo+2tFvOyWeY
 nhuN/aUVlT/MdAyaXP2xmesYg4/dLSy6+xclVsqK+Oz9oVqgqOKZTrgHV
 LE0yY2H1crgL9Brgmq3tHlglOgJkTvKiIzFTkW0HzGYe0CF9ZwGra0jpE
 yktaWnsaMQxEWKRQWKs/tIDhSn3uZTSllenG8Ej+2QRJUvcKGzlRkGgnZ
 1ohIbMvCT1EejI4zl1a/SmFRsgz37TmVCpslMvxbijKSv3IpcxxzVrrLr w==;
X-CSE-ConnectionGUID: T8jjt19kQ+a2xdDXG3bDbw==
X-CSE-MsgGUID: ecLXWoUKSpmtuWN5UWy4kA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12545585"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="12545585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:36:08 -0700
X-CSE-ConnectionGUID: LIGYrk/kSjCy2mHABXcGiQ==
X-CSE-MsgGUID: 2+g92xsNSa+uTK1qqGRnTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="25363044"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2024 08:36:03 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v11 02/21] hw/core/machine: Support modules in -smp
Date: Wed, 24 Apr 2024 23:49:10 +0800
Message-Id: <20240424154929.1487382-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add "modules" parameter parsing support in -smp.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes since v9:
 * Rebased on the SMP changes about unsupported "parameter=1"
   configurations. (Philippe)
 * Fixed typo about topology field. (Dapeng)

Changes since v8:
 * Added module description in qemu_smp_opts.

Changes since v7:
 * New commit to introduce module level in -smp.
---
 hw/core/machine-smp.c | 39 +++++++++++++++++++++++++++++++++------
 hw/core/machine.c     |  1 +
 qapi/machine.json     |  3 +++
 system/vl.c           |  3 +++
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 2e68fcfdfd79..2b93fa99c943 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -51,6 +51,10 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
         g_string_append_printf(s, " * clusters (%u)", ms->smp.clusters);
     }
 
+    if (mc->smp_props.modules_supported) {
+        g_string_append_printf(s, " * modules (%u)", ms->smp.modules);
+    }
+
     g_string_append_printf(s, " * cores (%u)", ms->smp.cores);
     g_string_append_printf(s, " * threads (%u)", ms->smp.threads);
 
@@ -88,6 +92,7 @@ void machine_parse_smp_config(MachineState *ms,
     unsigned sockets = config->has_sockets ? config->sockets : 0;
     unsigned dies    = config->has_dies ? config->dies : 0;
     unsigned clusters = config->has_clusters ? config->clusters : 0;
+    unsigned modules = config->has_modules ? config->modules : 0;
     unsigned cores   = config->has_cores ? config->cores : 0;
     unsigned threads = config->has_threads ? config->threads : 0;
     unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
@@ -103,6 +108,7 @@ void machine_parse_smp_config(MachineState *ms,
         (config->has_sockets && config->sockets == 0) ||
         (config->has_dies && config->dies == 0) ||
         (config->has_clusters && config->clusters == 0) ||
+        (config->has_modules && config->modules == 0) ||
         (config->has_cores && config->cores == 0) ||
         (config->has_threads && config->threads == 0) ||
         (config->has_maxcpus && config->maxcpus == 0)) {
@@ -115,6 +121,20 @@ void machine_parse_smp_config(MachineState *ms,
      * If not supported by the machine, a topology parameter must be
      * omitted.
      */
+    if (!mc->smp_props.modules_supported && config->has_modules) {
+        if (config->modules > 1) {
+            error_setg(errp, "modules not supported by this "
+                       "machine's CPU topology");
+            return;
+        } else {
+            /* Here modules only equals 1 since we've checked zero case. */
+            warn_report("Deprecated CPU topology (considered invalid): "
+                        "Unsupported modules parameter mustn't be "
+                        "specified as 1");
+        }
+    }
+    modules = modules > 0 ? modules : 1;
+
     if (!mc->smp_props.clusters_supported && config->has_clusters) {
         if (config->clusters > 1) {
             error_setg(errp, "clusters not supported by this "
@@ -185,11 +205,13 @@ void machine_parse_smp_config(MachineState *ms,
                 cores = cores > 0 ? cores : 1;
                 threads = threads > 0 ? threads : 1;
                 sockets = maxcpus /
-                          (drawers * books * dies * clusters * cores * threads);
+                          (drawers * books * dies * clusters *
+                           modules * cores * threads);
             } else if (cores == 0) {
                 threads = threads > 0 ? threads : 1;
                 cores = maxcpus /
-                        (drawers * books * sockets * dies * clusters * threads);
+                        (drawers * books * sockets * dies *
+                         clusters * modules * threads);
             }
         } else {
             /* prefer cores over sockets since 6.2 */
@@ -197,22 +219,26 @@ void machine_parse_smp_config(MachineState *ms,
                 sockets = sockets > 0 ? sockets : 1;
                 threads = threads > 0 ? threads : 1;
                 cores = maxcpus /
-                        (drawers * books * sockets * dies * clusters * threads);
+                        (drawers * books * sockets * dies *
+                         clusters * modules * threads);
             } else if (sockets == 0) {
                 threads = threads > 0 ? threads : 1;
                 sockets = maxcpus /
-                          (drawers * books * dies * clusters * cores * threads);
+                          (drawers * books * dies * clusters *
+                           modules * cores * threads);
             }
         }
 
         /* try to calculate omitted threads at last */
         if (threads == 0) {
             threads = maxcpus /
-                      (drawers * books * sockets * dies * clusters * cores);
+                      (drawers * books * sockets * dies *
+                       clusters * modules * cores);
         }
     }
 
-    total_cpus = drawers * books * sockets * dies * clusters * cores * threads;
+    total_cpus = drawers * books * sockets * dies *
+                 clusters * modules * cores * threads;
     maxcpus = maxcpus > 0 ? maxcpus : total_cpus;
     cpus = cpus > 0 ? cpus : maxcpus;
 
@@ -222,6 +248,7 @@ void machine_parse_smp_config(MachineState *ms,
     ms->smp.sockets = sockets;
     ms->smp.dies = dies;
     ms->smp.clusters = clusters;
+    ms->smp.modules = modules;
     ms->smp.cores = cores;
     ms->smp.threads = threads;
     ms->smp.max_cpus = maxcpus;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 996664115939..494b712a7638 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -881,6 +881,7 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
         .has_sockets = true, .sockets = ms->smp.sockets,
         .has_dies = true, .dies = ms->smp.dies,
         .has_clusters = true, .clusters = ms->smp.clusters,
+        .has_modules = true, .modules = ms->smp.modules,
         .has_cores = true, .cores = ms->smp.cores,
         .has_threads = true, .threads = ms->smp.threads,
         .has_maxcpus = true, .maxcpus = ms->smp.max_cpus,
diff --git a/qapi/machine.json b/qapi/machine.json
index e8b60641f23d..252cd019f62e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1633,6 +1633,8 @@
 #
 # @clusters: number of clusters per parent container (since 7.0)
 #
+# @modules: number of modules per parent container (since 9.1)
+#
 # @cores: number of cores per parent container
 #
 # @threads: number of threads per core
@@ -1646,6 +1648,7 @@
      '*sockets': 'int',
      '*dies': 'int',
      '*clusters': 'int',
+     '*modules': 'int',
      '*cores': 'int',
      '*threads': 'int',
      '*maxcpus': 'int' } }
diff --git a/system/vl.c b/system/vl.c
index c64422298245..7756eac81e48 100644
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
-- 
2.34.1


