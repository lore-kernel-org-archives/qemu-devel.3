Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596B5C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lk-0001Gy-G4; Sat, 09 Mar 2024 14:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Kx-0007tI-B1
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:30 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Kt-0003YB-KE
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:27 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso3383658a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012381; x=1710617181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXXCTTKtOqKGIkFeLbdf6BFuAhbM9FIUumQwfVgSOrQ=;
 b=NnxAPgg+MaI2MhPlQKj+BaKniQJ0Rv0no4GvooxGVwQXEn3V+wl60vioL77E+V7Bxe
 cSijFcXFXnfovMX5T7leg2Ne1pN0bxDBj5gcvIKn6VHJ3XqPtx/D8hRfkCM9s1xQref1
 gepzhwyLHcpTBkgoZ1pj3Q1lLN+EY1cXQ4OyJJIjxHbJNuAQjpX+QJm1aeL4F6j5rGpx
 DR/ULNhxeKnJC4asKq7B+megyxkmHviFFIiUJguf0cdpuI/puVOxSnMgG9djEKXeAWL3
 b2wjEnNoMRO/jlFaW3PEBSXTTtamzjuLr21pa25BTfEJUpsQRgoPn+9w6HZsXI+p4IUm
 qx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012381; x=1710617181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXXCTTKtOqKGIkFeLbdf6BFuAhbM9FIUumQwfVgSOrQ=;
 b=vXp0uZaYiegavFY0eQz+mj6rSFyQWgWJkVZC7cxmwUCF7Bfzd/pnmulsy2wwQKuGhE
 MHGFmVCVsHyWDd5uZsD6UviK+l81cvMtYqoCuwxTb9gYpxc6LbR3p8FbwRBuI8IaIXxZ
 t3Dy1nVyvotpsL1OchFgVLgbzSvZm1VrfkJU6hL62FF/MWE2ccHeaINsX11hAom31W3M
 vzkqRDOCaA2ckXny0x1fZEe9QZc8DkVmrPzfBOIDi5MftGobEJMLohrNd/8dFxc3scrd
 SYIbKMVNDB68lL7ROdHAHn8woAGdiYmm80wvzmK7j52O4SCqwP+BNB3AwJKadIJEVjEG
 akrw==
X-Gm-Message-State: AOJu0YwDo/Wp7AFh9SWmkZVTyk4S0OjDeCExjV52Qaxxh79tdLLj48ga
 1UD4W/iYXNfMTBPkK1tlfzS2ln3ud5FuKUkkvKw4ySfK+7tbXgRQOvHkToAmCi21rdnF71+qrTV
 I
X-Google-Smtp-Source: AGHT+IHHy8yH/1QEmz2EVUG4EtjwdEKmNz65w1h7i1yXUQaKHE69RGj7NANGhbsWnd9MqRRk5yBhTw==
X-Received: by 2002:a50:aad2:0:b0:567:f643:fc5c with SMTP id
 r18-20020a50aad2000000b00567f643fc5cmr1867041edc.20.1710012381554; 
 Sat, 09 Mar 2024 11:26:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 et8-20020a056402378800b00566a4dec01fsm1156535edb.11.2024.03.09.11.26.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:26:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 41/43] tests/unit/test-smp-parse: Test smp_props.has_clusters
Date: Sat,  9 Mar 2024 20:22:08 +0100
Message-ID: <20240309192213.23420-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-ID: <20240308160148.3130837-13-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 7558169171..d39cfdc19b 100644
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
2.41.0


