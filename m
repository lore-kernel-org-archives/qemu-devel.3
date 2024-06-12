Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78FC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvc-0001kx-Op; Wed, 12 Jun 2024 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNv3-0000XT-1L
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuy-0003yT-Jn
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrBycxmXKZRJrolXCFLanmpcSgTCZTkm0Z2V99WJj/s=;
 b=EvxsG7k5hxax972W5opcqp9BkmuR/kqIrxchvIsNqsj7oHHnzMtuP0qDt/HEWZR7MCcj5l
 94XL9CCmjR4Zl2+o0oUB0MBDZYUVGN5Zc9++C/8zo4ih3ZNdSc77V1yOITky8iipNfJn1R
 9m2WlzVAOSGWyY67NxEmKPwOuCwkRYw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-6FCLyDMsNJmfylXjVtynBA-1; Wed,
 12 Jun 2024 09:21:32 -0400
X-MC-Unique: 6FCLyDMsNJmfylXjVtynBA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68951955E89; Wed, 12 Jun 2024 13:21:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDA741956087; Wed, 12 Jun 2024 13:21:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 11/15] tests/unit/test-smp-parse: Make test cases aware of
 module level
Date: Wed, 12 Jun 2024 15:20:51 +0200
Message-ID: <20240612132055.326889-12-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Currently, -smp supports module level.

It is necessary to consider the effects of module in the test cases to
ensure that the calculations are correct. This is also the preparation
to add module test cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-6-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index e3a0a9d12d..2214e47ba9 100644
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
2.45.2


