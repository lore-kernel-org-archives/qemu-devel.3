Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92C5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwu4-0002Ku-SB; Thu, 25 Apr 2024 07:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtd-0000LH-PR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtZ-0000MP-9W
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b51ee24f9so2088585e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043034; x=1714647834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g96vdGUPlIMAMR0tgpTdGd3qjyGWYgQDQCU+2PoDhEA=;
 b=lXLKlDz+kj0vrE/FQpclKomG+nbgEYsQfQzMsUyDCTJwlryROR7hW3iY179ObPbiyP
 t0vI9mCSNlAvvhHTG1DaqPrtPOqqKNyTsbOGxJy8S7wV4+T+yBdZpGGWkME0UenRJwNj
 oxJ+ofX5FPu1k2s/pVt9xcvmbAATR/osfMBI1v73u8LhKyjtpfVQhGXX/Hdr3zAm7ptE
 pQPHpXJWUaeZ+FXm1bMKop5BsgdPXYKR2imr/AHiZ5a1/NWyoxc5tFYN0vSl2vBomU5W
 9hMaeuepLAz+95qUq3H0T7MlR7848nP5uD7EH9WTb6FidI1/iGVUgZHBpVERx440mi+a
 HvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043034; x=1714647834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g96vdGUPlIMAMR0tgpTdGd3qjyGWYgQDQCU+2PoDhEA=;
 b=t99PqGslavUEw9/zZlfptwwHfON+gCONro1ttPwl1Yz0vIuQUdGCRVJgVwzdo7mKJQ
 slQnjecVtcmKTq3LDoM0WBkIdTQzW5by1H5bhpw5vPl0luxcGxUXlL6uXKfaK5yBlE9o
 izDjafCU9cJ6YvfGW6tF8pQpNOxeMoez8cII/KP0qei87m6LPJRYRIuuwlNydDlV8n0A
 z4+hELKM5LUL/tFMtPt/BIkhJlDaw6WoC7w5k48zV7Uxrq8WrYs5/3s/csApMoRY/e97
 qR6lVWLNfqgNDIv2AWrO4uIUNbMHW2cHrgnc6ydsG4Kuk829qRPsXl+0aCg4MdjvyDWg
 BTpA==
X-Gm-Message-State: AOJu0YyGHeGX+U/Md3Qi7AOocSX+q6i2YHYEroFIoc4NLacrVpsoFdZa
 y9u8IwTAJUmszaZO4oEYoJoEi/2wJc4hIM/k+HzRa+JO4SqSaEFettYq+D3ZulwsoTjbdAwtfLK
 8
X-Google-Smtp-Source: AGHT+IGjQzm6j03xu7otoMVLUkfmm4z/psoO2x+hsMHYrcIwQPKyBdHoI4vAt2n90sdZN9DGeD4D4g==
X-Received: by 2002:a05:600c:4fc6:b0:41a:3369:61a3 with SMTP id
 o6-20020a05600c4fc600b0041a336961a3mr2073458wmq.5.1714043033731; 
 Thu, 25 Apr 2024 04:03:53 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a05600c46c600b0041892857924sm27165769wmo.36.2024.04.25.04.03.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/22] hw/core/machine: Support modules in -smp
Date: Thu, 25 Apr 2024 13:01:53 +0200
Message-ID: <20240425110157.20328-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add "modules" parameter parsing support in -smp.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240424154929.1487382-3-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json     |  3 +++
 hw/core/machine-smp.c | 39 +++++++++++++++++++++++++++++++++------
 hw/core/machine.c     |  1 +
 system/vl.c           |  3 +++
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 3e9cc3f17d..48f98e7d9f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1696,6 +1696,8 @@
 #
 # @clusters: number of clusters per parent container (since 7.0)
 #
+# @modules: number of modules per parent container (since 9.1)
+#
 # @cores: number of cores per parent container
 #
 # @threads: number of threads per core
@@ -1709,6 +1711,7 @@
      '*sockets': 'int',
      '*dies': 'int',
      '*clusters': 'int',
+     '*modules': 'int',
      '*cores': 'int',
      '*threads': 'int',
      '*maxcpus': 'int' } }
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 2e68fcfdfd..2b93fa99c9 100644
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
index 9966641159..494b712a76 100644
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
diff --git a/system/vl.c b/system/vl.c
index c644222982..7756eac81e 100644
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
2.41.0


