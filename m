Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5EAC54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lj-00019B-4P; Sat, 09 Mar 2024 14:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Kw-0007t9-23
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:30 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Ks-0003Xb-Mc
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:25 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so26152331fa.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012375; x=1710617175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipIrH8V6fqbpfd1iET2bFWtuJpnYjFZjo9qFhl65CP8=;
 b=GjhEr7fNWmXoOTRlmKiVY2V+oTPMg8eEC1Ogo7zYxZuQER1irqaFXDdIHVCOQpu5dB
 ROv/MBJ4Wquqqt+y6zgR+mW9sB0urhNCaTS0/UxGKdwsfCLNanXJpz2m/QVuMtZZ43pK
 Vxmy+jnJqTMSSiRdoGbJa6snV3U1QXpg0Sub1CcStRMWuGk5MYlGlB7pcbNaO0zLxoaP
 WjhfOa0BTFKWbUZtHTeYgEQn9wXbCOoH7ETmI2ioZCSakjVfKOzgtR3QWyOoOUSVBG7A
 NocOMxpDmeKXXS+H2etCZVfHurySsJj9Ps8kpZNx3344Gu8jqTZ2WiX2x7J4DjT8msFD
 pmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012375; x=1710617175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipIrH8V6fqbpfd1iET2bFWtuJpnYjFZjo9qFhl65CP8=;
 b=qwFfWOUA+36pXSBGRa3sJQIxIzWRBqUUTp6U71Whtqs63HR6fP07xyUVwsOzaHFDt/
 zKVLsMU7eAw2bf/xm0zziw8+eT0BTY51kMYB94cMUuyGOLcRorIHod3tE5qUynWldQdh
 Fvaw+4Fb5af9OkC2cjZj1vzuyvxJ7txpySzSkPm6UojTjfE9A2QMXGkWrj8AXSJrstRL
 091XmoBGN7to8bWYjAt1QEaro7yAEaNVnUq0dCySeLqziOydkPDLrjciVo2JI1uH7L6V
 IgfHOyZIcSdUgv2HMA9LE0OJlXKCKeaejxWz9woniyc7x9FlG2+uszQeq/TRv3HdOMIk
 s0FA==
X-Gm-Message-State: AOJu0YytlyetFbElNuqpTv39o7oB0pT0KDn2lfQl5v6tuCOLy3ThQWW+
 YnD0XrFV+F2SY/UkcsuS9paslfOKUQ0eaSPxguaZhroDTIvJqCeQ1jUhGmJjLxPsoYcOAJK7sbo
 v
X-Google-Smtp-Source: AGHT+IHKomGq3s52KVeoPjbaaT5z9zxBv4f5WlH3twWusv3U10muGTJfS2g/L5msV+GYscPHwNvxew==
X-Received: by 2002:a2e:bea2:0:b0:2d3:2242:990 with SMTP id
 a34-20020a2ebea2000000b002d322420990mr1810214ljr.42.1710012375478; 
 Sat, 09 Mar 2024 11:26:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a50e703000000b005661badcccesm1151185edn.87.2024.03.09.11.26.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:26:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 40/43] tests/unit/test-smp-parse: Test the full 7-levels
 topology hierarchy
Date: Sat,  9 Mar 2024 20:22:07 +0100
Message-ID: <20240309192213.23420-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

Currently, -smp supports up to 7-levels topology hierarchy:
  -drawers/books/sockets/dies/clusters/cores/threads.

Though no machine supports all these 7 levels yet, these 7 levels have
the strict containment relationship and together form the generic CPU
topology representation of QEMU.

Also, note that the maxcpus is calculated by multiplying all 7 levels:

  maxcpus = drawers * books * sockets * dies * clusters *
            cores * threads.

To cover this code path, it is necessary to test the full topology case
(with all 7 levels). This also helps to avoid introducing new issues by
further expanding the CPU topology in the future.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-12-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 0cf6115198..7558169171 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -91,6 +91,24 @@
             .has_maxcpus  = hg, .maxcpus  = g,                 \
         }
 
+/*
+ * Currently QEMU supports up to a 7-level topology hierarchy, which is the
+ * QEMU's unified abstract representation of CPU topology.
+ *  -drawers/books/sockets/dies/clusters/cores/threads
+ */
+#define SMP_CONFIG_WITH_FULL_TOPO(a, b, c, d, e, f, g, h, i)    \
+        {                                                       \
+            .has_cpus     = true, .cpus     = a,                \
+            .has_drawers  = true, .drawers  = b,                \
+            .has_books    = true, .books    = c,                \
+            .has_sockets  = true, .sockets  = d,                \
+            .has_dies     = true, .dies     = e,                \
+            .has_clusters = true, .clusters = f,                \
+            .has_cores    = true, .cores    = g,                \
+            .has_threads  = true, .threads  = h,                \
+            .has_maxcpus  = true, .maxcpus  = i,                \
+        }
+
 /**
  * @config - the given SMP configuration
  * @expect_prefer_sockets - the expected parsing result for the
@@ -472,6 +490,40 @@ static const struct SMPTestData data_with_drawers_books_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_full_topo_invalid[] = {
+    {
+        /*
+         * config: -smp 200,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=2,maxcpus=200
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(200, 3, 5, 2, 4, 2, 7, 2, 200),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (3) * books (5) * sockets (2) * dies (4) * "
+                        "clusters (2) * cores (7) * threads (2) "
+                        "!= maxcpus (200)",
+    }, {
+        /*
+         * config: -smp 3361,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=2,maxcpus=3360
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 2, 3360),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (3) * books (5) * sockets (2) * dies (4) * "
+                        "clusters (2) * cores (7) * threads (2) "
+                        "== maxcpus (3360) < smp_cpus (3361)",
+    }, {
+        /*
+         * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=3,maxcpus=5040
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 3, 5040),
+        .expect_error = "Invalid SMP CPUs 5040. The max CPUs supported "
+                        "by machine '" SMP_MACHINE_NAME "' is 4096",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -733,6 +785,16 @@ static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
 }
 
+static void machine_full_topo_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+    mc->smp_props.books_supported = true;
+    mc->smp_props.dies_supported = true;
+    mc->smp_props.clusters_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -1032,6 +1094,80 @@ static void test_with_drawers_books(const void *opaque)
     object_unref(obj);
 }
 
+static void test_full_topo(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int drawers = 5, books = 3, dies = 2, clusters = 7, multiplier;
+    int i;
+
+    multiplier = drawers * books * dies * clusters;
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /*
+         * when drawers, books, dies and clusters parameters are omitted,
+         * they will be set as 1.
+         */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_sockets.dies = 1;
+        data.expect_prefer_sockets.clusters = 1;
+        data.expect_prefer_cores.drawers = 1;
+        data.expect_prefer_cores.books = 1;
+        data.expect_prefer_cores.dies = 1;
+        data.expect_prefer_cores.clusters = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers, books, dies and clusters parameters are specified. */
+        data.config.has_drawers = true;
+        data.config.drawers = drawers;
+        data.config.has_books = true;
+        data.config.books = books;
+        data.config.has_dies = true;
+        data.config.dies = dies;
+        data.config.has_clusters = true;
+        data.config.clusters = clusters;
+
+        if (data.config.has_cpus) {
+            data.config.cpus *= multiplier;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= multiplier;
+        }
+
+        data.expect_prefer_sockets.drawers = drawers;
+        data.expect_prefer_sockets.books = books;
+        data.expect_prefer_sockets.dies = dies;
+        data.expect_prefer_sockets.clusters = clusters;
+        data.expect_prefer_sockets.cpus *= multiplier;
+        data.expect_prefer_sockets.max_cpus *= multiplier;
+
+        data.expect_prefer_cores.drawers = drawers;
+        data.expect_prefer_cores.books = books;
+        data.expect_prefer_cores.dies = dies;
+        data.expect_prefer_cores.clusters = clusters;
+        data.expect_prefer_cores.cpus *= multiplier;
+        data.expect_prefer_cores.max_cpus *= multiplier;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_full_topo_invalid); i++) {
+        data = data_full_topo_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
+    object_unref(obj);
+}
+
 /* Type info of the tested machine */
 static const TypeInfo smp_machine_types[] = {
     {
@@ -1068,6 +1204,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-drawers-books"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_drawers_books_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-full-topo"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_full_topo_class_init,
     }
 };
 
@@ -1100,6 +1240,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_drawers_books",
                          MACHINE_TYPE_NAME("smp-with-drawers-books"),
                          test_with_drawers_books);
+    g_test_add_data_func("/test-smp-parse/full",
+                         MACHINE_TYPE_NAME("smp-full-topo"),
+                         test_full_topo);
 
     g_test_run();
 
-- 
2.41.0


