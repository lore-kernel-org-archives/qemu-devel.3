Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7229C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ9-0005Z6-Bf; Wed, 29 May 2024 02:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ8-0005Yu-Hv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ6-0002te-SF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962659; x=1748498659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sKnaB96zUT2GRUKPpBosCjG9gjJ7DP45HVk50XGB9gc=;
 b=FB4lhdDCCoNS+Dp16TGYn/g7D0+/quBJRmTF0eiTY33Ne0sWzhOdYKJC
 HghnRuRuVXfogXJDR4r/n9ahj5r8UXk4k6mQXQfQ7tQxC8rn0siCoxW40
 W7DGClRieM1OC5QBi/jGBCeYgGdS9Sdlre6u7YDpAowL/G/eUvnH0Il+M
 NlLtfLYJB2I/eD97UvXZXvaDWI30MC0UiKrvDF+l564lZGeZc3SFRd//g
 xdEdCHAjKzdvzb34CYLoQwiEP4x36QsB7fdBnEBYxD4tei5ik/kaCGPtk
 78dFOfWTfSaXlxl2ZZI+2F3rlaFI4k0EFqJa1Hc1MQUjHLQsof6IYu6Rz Q==;
X-CSE-ConnectionGUID: 2sNcvyczTgGtezkeagRWQw==
X-CSE-MsgGUID: bU41UlJRTfO2MHC4tHPIdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187493"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187493"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:18 -0700
X-CSE-ConnectionGUID: wBni+W+cSOeAz0j9URQCEQ==
X-CSE-MsgGUID: DdTmXGP5SweZCK5maPmhHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144739"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:15 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/8] tests/unit/test-smp-parse: Make test cases aware of
 module level
Date: Wed, 29 May 2024 14:19:22 +0800
Message-Id: <20240529061925.350323-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently, -smp supports module level.

It is necessary to consider the effects of module in the test cases to
ensure that the calculations are correct. This is also the preparation
to add module test cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index e3a0a9d12d05..2214e47ba9c0 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -629,6 +629,7 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         "    .has_sockets  = %5s, sockets  = %" PRId64 ",\n"
         "    .has_dies     = %5s, dies     = %" PRId64 ",\n"
         "    .has_clusters = %5s, clusters = %" PRId64 ",\n"
+        "    .has_modules  = %5s, modules  = %" PRId64 ",\n"
         "    .has_cores    = %5s, cores    = %" PRId64 ",\n"
         "    .has_threads  = %5s, threads  = %" PRId64 ",\n"
         "    .has_maxcpus  = %5s, maxcpus  = %" PRId64 ",\n"
@@ -639,6 +640,7 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         config->has_sockets ? "true" : "false", config->sockets,
         config->has_dies ? "true" : "false", config->dies,
         config->has_clusters ? "true" : "false", config->clusters,
+        config->has_modules ? "true" : "false", config->modules,
         config->has_cores ? "true" : "false", config->cores,
         config->has_threads ? "true" : "false", config->threads,
         config->has_maxcpus ? "true" : "false", config->maxcpus);
@@ -679,6 +681,7 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .sockets            = %u,\n"
         "    .dies               = %u,\n"
         "    .clusters           = %u,\n"
+        "    .modules            = %u,\n"
         "    .cores              = %u,\n"
         "    .threads            = %u,\n"
         "    .max_cpus           = %u,\n"
@@ -688,8 +691,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "}",
         topo->cpus, topo->drawers, topo->books,
         topo->sockets, topo->dies, topo->clusters,
-        topo->cores, topo->threads, topo->max_cpus,
-        threads_per_socket, cores_per_socket,
+        topo->modules, topo->cores, topo->threads,
+        topo->max_cpus, threads_per_socket, cores_per_socket,
         has_clusters ? "true" : "false");
 }
 
@@ -732,6 +735,7 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
             (ms->smp.sockets == expect_topo->sockets) &&
             (ms->smp.dies == expect_topo->dies) &&
             (ms->smp.clusters == expect_topo->clusters) &&
+            (ms->smp.modules == expect_topo->modules) &&
             (ms->smp.cores == expect_topo->cores) &&
             (ms->smp.threads == expect_topo->threads) &&
             (ms->smp.max_cpus == expect_topo->max_cpus) &&
@@ -812,6 +816,11 @@ static void smp_parse_test(MachineState *ms, SMPTestData *data, bool is_valid)
 /* The parsed results of the unsupported parameters should be 1 */
 static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
 {
+    if (!mc->smp_props.modules_supported) {
+        data->expect_prefer_sockets.modules = 1;
+        data->expect_prefer_cores.modules = 1;
+    }
+
     if (!mc->smp_props.dies_supported) {
         data->expect_prefer_sockets.dies = 1;
         data->expect_prefer_cores.dies = 1;
-- 
2.34.1


