Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21429C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lj-00018f-1O; Sat, 09 Mar 2024 14:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Kv-0007t6-Sc
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:31 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Kt-0003X9-HW
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5682e8f21a7so2340316a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012369; x=1710617169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUC4gt3lxXhDXO4ThAk9t583cQlzaBs4BIxFd2rtuRE=;
 b=mvcjzE2liCot4Hk+YGLy9r6yBJyx6dnBEujXMJiDxRuS/prYkYKnDcYUOuma6duE7s
 p9eyBgsXrnA/fe709cVx2vqW1ggexQd4ZkwTeKPWEzBciJiFjBTu30pYMxaWHDNrUq3W
 jlh4+9DforgvW5jg6O2X/STqOL44OSPDZiaRGni1lTWUwUVT6/UeW7i6CjzXHfANI4PH
 baktCYE+f1rn+2YD6zOy62AMPYhK7QKyF3yjrlG4Qvt3/t7rQcYOa8olExFGKcQG6+3T
 OFwFBgILiDfIg6x2zxPsnXrh5rFdIAORZEuL1u17Png4apBTI7m3kQNaNaIZLHnNj6Go
 qZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012369; x=1710617169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUC4gt3lxXhDXO4ThAk9t583cQlzaBs4BIxFd2rtuRE=;
 b=B3HG3I8N6C2RDAuJvbZID7kx9lpNyCduRv5R8/RPUYYtdIDOT8xlMpx2GplNcsCjsz
 0JabG/bUBshURFgFETcu2GQ8lCxCgxNGL2eAQ6MhC2BHjDiy+iWmz1HVckjGsNoI9TVv
 +X5RJABtLuUuJ9bWArOm4wBHiaJBeL4M5OIK3lA0nyanEQzKZdi21ip0aMtf7Pu3tOh0
 wVKgWLkbAZ51o4ZbKuAXTZ9qw4uL2cbEClSM3mr83m5O8heXcCL9gDe8K60T9K4Hx+yk
 qpdfWkSdrOtIxK8sSdz7PlCL4mLcZND8H56asw2OJnMdVS0lICoiW2wj/fMWXEjajowq
 xD1Q==
X-Gm-Message-State: AOJu0YxqZPTS5ZqpkpjOZ66SMTmLmthCgnz6mVBfS7Du1bThUgjiaJud
 YuXLQ/8RR6JcvToNBhfJWxajqTJdjDVYAdfByQpju3C5TbqDaeoIMU4t4gVb0VzgjNJuXnAiIHS
 d
X-Google-Smtp-Source: AGHT+IEyHTZWHHCFdMvwfRVTSs9Fc0ywA1C7Tb/i7nNpXywYGFu3p6ZEm7Ayjkg5wWlsxstUFBn/IQ==
X-Received: by 2002:a17:906:f150:b0:a45:b761:2c2 with SMTP id
 gw16-20020a170906f15000b00a45b76102c2mr1165498ejb.60.1710012369579; 
 Sat, 09 Mar 2024 11:26:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 ce18-20020a170906b25200b00a44f3fb4f07sm1172207ejb.191.2024.03.09.11.26.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:26:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 39/43] tests/unit/test-smp-parse: Test "drawers" and "books"
 combination case
Date: Sat,  9 Mar 2024 20:22:06 +0100
Message-ID: <20240309192213.23420-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Since s390 machine supports both "drawers" and "books" in -smp, add the
"drawers" and "books" combination test case to match the actual topology
usage scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-11-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index aea1b2e73a..0cf6115198 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -445,6 +445,33 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_drawers_books_invalid[] = {
+    {
+        /*
+         * config: -smp 200,drawers=2,books=2,sockets=2,cores=4,\
+         * threads=2,maxcpus=200
+         */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 200, T, 3, T, 5, T,
+                                                2, T, 4, T, 2, T, 200),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (3) * books (5) * sockets (2) * "
+                        "cores (4) * threads (2) != maxcpus (200)",
+    }, {
+        /*
+         * config: -smp 242,drawers=2,books=2,sockets=2,cores=4,\
+         * threads=2,maxcpus=240
+         */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 242, T, 3, T, 5, T,
+                                                2, T, 4, T, 2, T, 240),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (3) * books (5) * sockets (2) * "
+                        "cores (4) * threads (2) "
+                        "== maxcpus (240) < smp_cpus (242)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -698,6 +725,14 @@ static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
     mc->smp_props.drawers_supported = true;
 }
 
+static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+    mc->smp_props.books_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -936,6 +971,67 @@ static void test_with_drawers(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_drawers_books(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_drawers = 5, num_books = 3;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /*
+         * when drawers and books parameters are omitted, they will
+         * be both set as 1.
+         */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_cores.drawers = 1;
+        data.expect_prefer_cores.books = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers and books parameters are both specified */
+        data.config.has_drawers = true;
+        data.config.drawers = num_drawers;
+        data.config.has_books = true;
+        data.config.books = num_books;
+
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_drawers * num_books;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_drawers * num_books;
+        }
+
+        data.expect_prefer_sockets.drawers = num_drawers;
+        data.expect_prefer_sockets.books = num_books;
+        data.expect_prefer_sockets.cpus *= num_drawers * num_books;
+        data.expect_prefer_sockets.max_cpus *= num_drawers * num_books;
+
+        data.expect_prefer_cores.drawers = num_drawers;
+        data.expect_prefer_cores.books = num_books;
+        data.expect_prefer_cores.cpus *= num_drawers * num_books;
+        data.expect_prefer_cores.max_cpus *= num_drawers * num_books;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_drawers_books_invalid); i++) {
+        data = data_with_drawers_books_invalid[i];
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
@@ -968,6 +1064,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-drawers"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_drawers_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-drawers-books"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_drawers_books_class_init,
     }
 };
 
@@ -997,6 +1097,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_drawers",
                          MACHINE_TYPE_NAME("smp-with-drawers"),
                          test_with_drawers);
+    g_test_add_data_func("/test-smp-parse/with_drawers_books",
+                         MACHINE_TYPE_NAME("smp-with-drawers-books"),
+                         test_with_drawers_books);
 
     g_test_run();
 
-- 
2.41.0


