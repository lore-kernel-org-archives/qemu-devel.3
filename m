Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD01BC54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lh-00012V-FM; Sat, 09 Mar 2024 14:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KR-0007Qj-5m
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:03 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KP-0003OS-HI
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:54 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a4604c8bd61so45709166b.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012351; x=1710617151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8i9QPEOlWhmU7xWF5BCURrysJXNiI85mOLr+pl+Sq0=;
 b=y4zrCr6NEJnj7wLuGdTWAvRnxx1fixFoDxypupMViHonccW3SwDnTGeJdGvu3+mzPk
 Kzf5h7ottiBT01ztt/V8/cXhSXfxjZ/be5eoNh3MZRBTrwqpr0jGGJhwZjd57wlyQcMq
 3n+XEHhxy9/3K/zLEP8PbS1X4El+1X/KEUzT2viklt02T0nlDXerB283M/aQhplOgsS3
 bF69AaDWEvKc+QL3uX4eU5PKqlw33hbnxRG4lRV0MGmZWR4YtE5beW76cI6FhhVvIZq4
 3zXoUPXQuJwhFPXGrNiLZNiqD2heIUzXML7VqInfDn5Z7BTpQEt9MZ9rzzRZgMer+wIj
 k9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012351; x=1710617151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8i9QPEOlWhmU7xWF5BCURrysJXNiI85mOLr+pl+Sq0=;
 b=PqIriR2bn7YFzUHJtgomHRyIh8cYHokhoAM8VtVLAfGRG2C1yvhxvSyAynUM1Ap5aZ
 XXjvuXPzUzOOEbubjvnS72zgEH1SdtvILOo9RMdu0ZLuZlcJuPzDIgbVCLnYWr05P0vk
 JQlm9skbfSfWTSZRmPK822y+w1rND+xl2J/IXvdTTkP1xpsv7aHfIy4e4+ahMDuhYcM2
 FeCJU2M/MzwQNcMYd0HYWsOXS2kRjJkrrus60gKNI1yd50sZKX+29Eli/RDCZLaaOrQ5
 kJ9n1loPOBLdQatRZlI05RfBZ+WDEQUhnmt+jZjWURM1cQgKahSWcxvnVRVaeaCYpC+3
 x6zw==
X-Gm-Message-State: AOJu0YwsJTtL6goT3yY7eTCNZRuMYxjWt2ilIWm56EQ3S+8dO7YSa2BO
 4amYlWzyzMAx6hdPLfsVOciHnk3n6DpuTbLa+I8cuMSfqyYzxsX92oC/bIUc5QVP99F9VjRPgPX
 9
X-Google-Smtp-Source: AGHT+IHPWCYsTTLJR3Y5I7K9wr+9PlPTMOFzDgbyILfwcOWY9+UAhabN+Yjbc55cmBThQVWEk8mPng==
X-Received: by 2002:a17:906:390:b0:a45:9347:e3d6 with SMTP id
 b16-20020a170906039000b00a459347e3d6mr1362000eja.66.1710012351548; 
 Sat, 09 Mar 2024 11:25:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 lr1-20020a170906fb8100b00a442e2940fdsm1186112ejb.179.2024.03.09.11.25.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 36/43] tests/unit/test-smp-parse: Make test cases aware of the
 book/drawer
Date: Sat,  9 Mar 2024 20:22:03 +0100
Message-ID: <20240309192213.23420-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently, -smp supports 2 more new levels: book and drawer.

It is necessary to consider the effects of book and drawer in the test
cases to ensure that the calculations are correct. This is also the
preparation to add new book and drawer test cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-8-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2eb9533bc5..f656bbb6da 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -384,6 +384,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
     return g_strdup_printf(
         "(SMPConfiguration) {\n"
         "    .has_cpus     = %5s, cpus     = %" PRId64 ",\n"
+        "    .has_drawers  = %5s, drawers  = %" PRId64 ",\n"
+        "    .has_books    = %5s, books    = %" PRId64 ",\n"
         "    .has_sockets  = %5s, sockets  = %" PRId64 ",\n"
         "    .has_dies     = %5s, dies     = %" PRId64 ",\n"
         "    .has_clusters = %5s, clusters = %" PRId64 ",\n"
@@ -392,6 +394,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         "    .has_maxcpus  = %5s, maxcpus  = %" PRId64 ",\n"
         "}",
         config->has_cpus ? "true" : "false", config->cpus,
+        config->has_drawers ? "true" : "false", config->drawers,
+        config->has_books ? "true" : "false", config->books,
         config->has_sockets ? "true" : "false", config->sockets,
         config->has_dies ? "true" : "false", config->dies,
         config->has_clusters ? "true" : "false", config->clusters,
@@ -404,10 +408,10 @@ static char *smp_config_to_string(const SMPConfiguration *config)
 static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
 {
     /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
-    if (!topo->sockets) {
+    if (!topo->drawers || !topo->books || !topo->sockets) {
         return 0;
     } else {
-        return topo->max_cpus / topo->sockets;
+        return topo->max_cpus / topo->drawers / topo->books / topo->sockets;
     }
 }
 
@@ -429,6 +433,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
     return g_strdup_printf(
         "(CpuTopology) {\n"
         "    .cpus               = %u,\n"
+        "    .drawers            = %u,\n"
+        "    .books              = %u,\n"
         "    .sockets            = %u,\n"
         "    .dies               = %u,\n"
         "    .clusters           = %u,\n"
@@ -438,7 +444,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .threads_per_socket = %u,\n"
         "    .cores_per_socket   = %u,\n"
         "}",
-        topo->cpus, topo->sockets, topo->dies, topo->clusters,
+        topo->cpus, topo->drawers, topo->books,
+        topo->sockets, topo->dies, topo->clusters,
         topo->cores, topo->threads, topo->max_cpus,
         threads_per_socket, cores_per_socket);
 }
@@ -473,6 +480,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
     if (is_valid) {
         if ((err == NULL) &&
             (ms->smp.cpus == expect_topo->cpus) &&
+            (ms->smp.drawers == expect_topo->drawers) &&
+            (ms->smp.books == expect_topo->books) &&
             (ms->smp.sockets == expect_topo->sockets) &&
             (ms->smp.dies == expect_topo->dies) &&
             (ms->smp.clusters == expect_topo->clusters) &&
@@ -564,6 +573,16 @@ static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
         data->expect_prefer_sockets.clusters = 1;
         data->expect_prefer_cores.clusters = 1;
     }
+
+    if (!mc->smp_props.books_supported) {
+        data->expect_prefer_sockets.books = 1;
+        data->expect_prefer_cores.books = 1;
+    }
+
+    if (!mc->smp_props.drawers_supported) {
+        data->expect_prefer_sockets.drawers = 1;
+        data->expect_prefer_cores.drawers = 1;
+    }
 }
 
 static void machine_base_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


