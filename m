Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E4C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lk-0001Hr-Kx; Sat, 09 Mar 2024 14:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KZ-0007Um-Lu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:07 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KW-0003Ox-5j
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:02 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a45ba1f8e89so379473266b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012357; x=1710617157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81Sv1vN+6ujCHrYNAV0wa7bFS6ihhdM5ooxz7PBUBM8=;
 b=fKeoVA4gWnUf5UNcyQSH89SyThg7TU9J/i+i/72XTDUES6vMKjUD+SKx0LF8WqVYBR
 dXJqgyADJlUTROu/OORCev5+fYkSU49SC915XU9FNzb0pNimhjyIiHSQzJO6X2EB2z92
 wen8Mj8kSpLuVkW2Pven6UpJTLeBfsaWyaww/oU9UACAkp32nFmS2xapskgiDscb7hcr
 qLJkKFLXhBByzevGTA9xEXJVj/6c8v/FqXHWs7TPRhcPkpcC46ogTPdC0rKUN6t72+Hl
 0EXSVtf8+X75cUCJ48+1RaTbnH10x91gH5PZemtnPDJuo5rUoiMamufbCvFtcj12PweH
 cybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012357; x=1710617157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81Sv1vN+6ujCHrYNAV0wa7bFS6ihhdM5ooxz7PBUBM8=;
 b=bB92xkgODswx6KcyEeiWlm5mpTLaYzVZ822YNRtQ3k+DhShC704VMz4Mz9g0THz/Fk
 zjMrwPUCKsP+BXRUE67x06UdbvSI3HVqVWeox3fkqFeWOLTcZuhvebz8c6GUOBNM4tSF
 +0GnqEfMzXJUeI6zQyrARCuSjGgzciWjoeyXN8MXG52g6IQKS9CuUDOka4sFat5ss5N9
 fQgqZdQlmkOoW6w4rcpmodapOGtCyNUdbFi6as1oc6S50yXbDo3ra4kts61cbyyid5/J
 3/2yTNVNQtUSRKU/R1C1odviLvmHDwmMmo1tqqOdljVjTDdmrLAzk8SgQbkRWBSa/9n3
 Vw2g==
X-Gm-Message-State: AOJu0Yw8dXScIIBlzJnzdSzzc3wvODG+z5IlruEvlW2kauswbCXdvyrW
 75dlmtZtCplCoKOutCN553RjgLVTNCuKDGSX8SnfWN35Gso5qrmWxVHyr8mxjUWRMHIWLzlFD0r
 e
X-Google-Smtp-Source: AGHT+IGpFc4c3zWQ4HmMBDiLXLuln4/bMpyIXJn3WJUnAZk9JTk56gyPEpQHUl/2DK4OdZ6xBEy1Vg==
X-Received: by 2002:a17:906:ad94:b0:a45:8ab6:5f3c with SMTP id
 la20-20020a170906ad9400b00a458ab65f3cmr1404683ejb.45.1710012357525; 
 Sat, 09 Mar 2024 11:25:57 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 zh16-20020a170906881000b00a44d01aff81sm1178678ejb.97.2024.03.09.11.25.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 37/43] tests/unit/test-smp-parse: Test "books" parameter in -smp
Date: Sat,  9 Mar 2024 20:22:04 +0100
Message-ID: <20240309192213.23420-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Although book was introduced to -smp along with drawer by s390 machine,
as a general topology level in QEMU that may be reused by other arches
in the future, it is desirable to cover this parameter's parsing in a
separate case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-9-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 105 ++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index f656bbb6da..090238ab23 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -75,6 +75,22 @@
             .has_maxcpus  = hf, .maxcpus  = f,                \
         }
 
+/*
+ * Currently a 5-level topology hierarchy is supported on s390 ccw machines
+ *  -drawers/books/sockets/cores/threads
+ */
+#define SMP_CONFIG_WITH_BOOKS_DRAWERS(ha, a, hb, b, hc, c, hd, \
+                                      d, he, e, hf, f, hg, g)  \
+        {                                                      \
+            .has_cpus     = ha, .cpus     = a,                 \
+            .has_drawers  = hb, .drawers  = b,                 \
+            .has_books    = hc, .books    = c,                 \
+            .has_sockets  = hd, .sockets  = d,                 \
+            .has_cores    = he, .cores    = e,                 \
+            .has_threads  = hf, .threads  = f,                 \
+            .has_maxcpus  = hg, .maxcpus  = g,                 \
+        }
+
 /**
  * @config - the given SMP configuration
  * @expect_prefer_sockets - the expected parsing result for the
@@ -308,6 +324,11 @@ static const struct SMPTestData data_generic_invalid[] = {
         /* config: -smp 2,clusters=2 */
         .config = SMP_CONFIG_WITH_CLUSTERS(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
         .expect_error = "clusters not supported by this machine's CPU topology",
+    }, {
+        /* config: -smp 2,books=2 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
+                                                0, F, 0, F, 0, F, 0),
+        .expect_error = "books not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
@@ -379,6 +400,26 @@ static const struct SMPTestData data_with_clusters_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_books_invalid[] = {
+    {
+        /* config: -smp 16,books=2,sockets=2,cores=4,threads=2,maxcpus=16 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 1, T, 2, T,
+                                                2, T, 4, T, 2, T, 16),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "books (2) * sockets (2) * cores (4) * threads (2) "
+                        "!= maxcpus (16)",
+    }, {
+        /* config: -smp 34,books=2,sockets=2,cores=4,threads=2,maxcpus=32 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 1, T, 2, T,
+                                                2, T, 4, T, 2, T, 32),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "books (2) * sockets (2) * cores (4) * threads (2) "
+                        "== maxcpus (32) < smp_cpus (34)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -618,6 +659,13 @@ static void machine_with_clusters_class_init(ObjectClass *oc, void *data)
     mc->smp_props.clusters_supported = true;
 }
 
+static void machine_with_books_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.books_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -756,6 +804,56 @@ static void test_with_clusters(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_books(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_books = 2;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /* when books parameter is omitted, it will be set as 1 */
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_cores.books = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when books parameter is specified */
+        data.config.has_books = true;
+        data.config.books = num_books;
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_books;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_books;
+        }
+
+        data.expect_prefer_sockets.books = num_books;
+        data.expect_prefer_sockets.cpus *= num_books;
+        data.expect_prefer_sockets.max_cpus *= num_books;
+        data.expect_prefer_cores.books = num_books;
+        data.expect_prefer_cores.cpus *= num_books;
+        data.expect_prefer_cores.max_cpus *= num_books;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_books_invalid); i++) {
+        data = data_with_books_invalid[i];
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
@@ -780,6 +878,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-clusters"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_clusters_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-books"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_books_class_init,
     }
 };
 
@@ -803,6 +905,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_clusters",
                          MACHINE_TYPE_NAME("smp-with-clusters"),
                          test_with_clusters);
+    g_test_add_data_func("/test-smp-parse/with_books",
+                         MACHINE_TYPE_NAME("smp-with-books"),
+                         test_with_books);
 
     g_test_run();
 
-- 
2.41.0


