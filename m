Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D47C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSp-0000ln-Mo; Fri, 08 Mar 2024 10:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSn-0000lF-K2
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:49 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSl-000449-Re
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912928; x=1741448928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9CNNd6/FqGn+vADBzcQTmk8SQKEglbZAI6+rVVgSS7Q=;
 b=JE4ewhKX0iWNxzxw/NpsDtppS3aKErfc1yIsqkwmv+52J0Sxkl4eTbPW
 hZRD6RCb2riinegVsTLeW/QVEn8zBtK3gzCRCihsIsSR2XF79GA95bOU7
 WmZwRKR32+mjVtE8vEZuTa2Y5IvkKXRMcPIhApEUDwtDZSFBksYp53apq
 ALeszjbjYtJada5So6d0OjdFSs8fuizgwOUtbcNUtaqos9eqy1zQn1AuM
 tFJ2WjmNwQHG9ljEbwbYtqwyuCSikUv8GmgQSxt/7bwM610P5kGMsYkx3
 pLDSvQ1Zhl5ADptKa7LeWcnH7Mr2b+GeSQRHyzcAWSMjB40o3CngJUDSk A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561121"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400364"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:44 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 12/13] tests/unit/test-smp-parse: Test
 smp_props.has_clusters
Date: Sat,  9 Mar 2024 00:01:47 +0800
Message-Id: <20240308160148.3130837-13-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The smp_props.has_clusters in MachineClass is not a user configured
field, and it indicates if user specifies "clusters" in -smp.

After -smp parsing, other module could aware if the cluster level
is configured by user. This is used when the machine has only 1 cluster
since there's only 1 cluster by default.

Add the check to cover this field.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 75581691713c..d39cfdc19bfe 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -573,7 +573,8 @@ static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
 
 static char *cpu_topology_to_string(const CpuTopology *topo,
                                     unsigned int threads_per_socket,
-                                    unsigned int cores_per_socket)
+                                    unsigned int cores_per_socket,
+                                    bool has_clusters)
 {
     return g_strdup_printf(
         "(CpuTopology) {\n"
@@ -588,17 +589,20 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .max_cpus           = %u,\n"
         "    .threads_per_socket = %u,\n"
         "    .cores_per_socket   = %u,\n"
+        "    .has_clusters       = %s,\n"
         "}",
         topo->cpus, topo->drawers, topo->books,
         topo->sockets, topo->dies, topo->clusters,
         topo->cores, topo->threads, topo->max_cpus,
-        threads_per_socket, cores_per_socket);
+        threads_per_socket, cores_per_socket,
+        has_clusters ? "true" : "false");
 }
 
 static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         const CpuTopology *expect_topo, const char *expect_err,
                         bool is_valid)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     g_autofree char *config_str = smp_config_to_string(config);
     g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
     unsigned int expect_threads_per_socket, expect_cores_per_socket;
@@ -611,15 +615,18 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
                         cpu_topology_get_cores_per_socket(expect_topo);
     expect_topo_str = cpu_topology_to_string(expect_topo,
                                              expect_threads_per_socket,
-                                             expect_cores_per_socket);
+                                             expect_cores_per_socket,
+                                             config->has_clusters);
 
     /* call the generic parser */
     machine_parse_smp_config(ms, config, &err);
 
     ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
     ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
-    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
-                                             ms_cores_per_socket);
+    output_topo_str = cpu_topology_to_string(&ms->smp,
+                                             ms_threads_per_socket,
+                                             ms_cores_per_socket,
+                                             mc->smp_props.has_clusters);
 
     /* when the configuration is supposed to be valid */
     if (is_valid) {
@@ -634,7 +641,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
             (ms->smp.threads == expect_topo->threads) &&
             (ms->smp.max_cpus == expect_topo->max_cpus) &&
             (ms_threads_per_socket == expect_threads_per_socket) &&
-            (ms_cores_per_socket == expect_cores_per_socket)) {
+            (ms_cores_per_socket == expect_cores_per_socket) &&
+            (mc->smp_props.has_clusters == config->has_clusters)) {
             return;
         }
 
-- 
2.34.1


