Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9455CE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIesh-0004zq-Fi; Tue, 03 Dec 2024 21:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIesU-0004M6-1u
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:36 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIesR-0005Tk-0y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:33 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef402e4589so60808307b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278350; x=1733883150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMUZjSVVMo2pOYihqAfV7zRvytzhfUlPnoItmHg7JkQ=;
 b=Y2uHKp+RbWMDd9L5ewSZoWoxLIV+VQcEsqkJ1p4Zm7F0tMGr+2Ls7tnjtCcrTKG9Tj
 rJ8CAE1PZWrdfUOqejCgBAiiKmjCo980Q9w1/WW4Lr5PbSXkpLx1JMSk+Yj/q8h5m0wA
 i4WFEtCYRbGNfjKdto4GOytEB5JsUO+Yji5mVhrbmCoA87DvfL5tL/SDTnLo2Kkgmbjx
 dap/J3HKu7HiZ7JeGP2jdrAerzTq7ULpr0sDvj35xj65wY5iy0c6uEl51VyhPDdXHxBJ
 8VqXndyqVuhRjsb3gdou0v50dfy9PGrHl7hx3PbC+jbRJqYcrH24NvbG0tXbRap52X58
 G4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278350; x=1733883150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMUZjSVVMo2pOYihqAfV7zRvytzhfUlPnoItmHg7JkQ=;
 b=E2qZY5LXU/3UO5WLXIzVNz9e6Mw7dC2ZBnZzW05SSQMqP1suwiaUbshE9CbXzUHjrC
 e3/L9ujbgoFR2dzwEZvcS9YxTN5b5vjiJc6taAljif7Fqu5SlEjnTU8Mvax1qxJIJiEv
 5s+6yawH9NFn3iXqkwHsNdIn2L9WW5GKz3tPsitHeSJ6dDWiaHdngMzVeGm9m7eGTjg4
 xojq5NislZ+96IJAujDP8jmMbkGeeT08LauH5XiD7ZFLnipEYvIG9QPboUnCzj6KV45q
 DemoZ+SFAldRUPD6AhMSiICoZsaqyYkgfXrvODMmqqB2K4HOtRKfLR22EyrjMBjNiBVg
 K48w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwLRmRpANpOBGIb388Dto2DrnH5Hto6xh+2vNw4bWwi04fMR+cRcsmkSeSPJWux7XiVvPAHvPU+pmy@nongnu.org
X-Gm-Message-State: AOJu0YwzhUtJ/90+yxbQa8kYwdGnmqhTRh7VH5cEWwJj57YV7vguJMPa
 2F7bTIZMzS+bndkoNDUIftn4h3G1nPSmRPPR+eBe+Kgxbwp4PdGgyvOZf272kfc=
X-Gm-Gg: ASbGncseINQQpD+xuNelx/55BCUg4Sx/8+7XmOtL3d4BmVdm0VciH3EqoFbegCGfr3q
 y8SGO98a+UabucQFCcOOuvLLa9fDwnGr7B+2ZYXYmWaCi/+1zwe44FNBtjmShfA43dHOPXQ5Dlw
 mzfdGcAhwV1ewulVkHr5oYodTHU/qPmQB4tEYquHG+kLA7sW7rXPHfiFMOBNpbA2TU74YRNOT0x
 AtKx6EpO3xce9DiknsW7t1pEYCBRJ9AHpK0omQNOQF80XGx1Q9PL9OAKBdq5tTNN6wW+P3qN7jX
 UiLP8UcfsPHw+4cbrQ==
X-Google-Smtp-Source: AGHT+IHLzlBpsbMLVMYog1iK9ht/ElBnpnnRjfixt+PLy/Dn4GTT53borTiQmE58VJNzX0ZpL4zf3Q==
X-Received: by 2002:a05:690c:48c8:b0:6ee:988b:16d4 with SMTP id
 00721157ae682-6efad1dcfefmr70261077b3.29.1733278349983; 
 Tue, 03 Dec 2024 18:12:29 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.12.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:12:29 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v8 11/12] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Tue,  3 Dec 2024 18:11:40 -0800
Message-Id: <20241204021142.24184-12-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@linux.dev>

* Add test case to start and complete multifd live migration with DSA
offloading enabled.
* Add test case to start and cancel multifd live migration with DSA
offloading enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 80 +++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74d3000198..e1cef36143 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -611,6 +611,12 @@ typedef struct {
     bool suspend_me;
 } MigrateStart;
 
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char *dsa_dev_path_p = "['dsa:/dev/dsa/wq4.0']";
+
 /*
  * A hook that runs after the src and dst QEMUs have been
  * created, but before the migration is started. This can
@@ -3266,7 +3272,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -3286,6 +3292,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+        migrate_set_parameter_str(from, "accel-path", dsa_dev_path_p);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -3344,6 +3355,49 @@ static void test_multifd_tcp_cancel(void)
     test_migrate_end(from, to2, true);
 }
 
+/*
+ * This test does:
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       launch another target
+ *     migrate
+ *
+ *  And see that it works
+ */
+static void test_multifd_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel_common(false);
+}
+
+#ifdef CONFIG_DSA_OPT
+
+static void *test_migrate_precopy_tcp_multifd_start_dsa(QTestState *from,
+                                                        QTestState *to)
+{
+    migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+    migrate_set_parameter_str(from, "accel-path", dsa_dev_path_p);
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+}
+
+static void test_multifd_tcp_zero_page_dsa(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_dsa,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_cancel_dsa(void)
+{
+    test_multifd_tcp_cancel_common(true);
+}
+
+#endif
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -3774,6 +3828,20 @@ static bool kvm_dirty_ring_supported(void)
 #endif
 }
 
+#ifdef CONFIG_DSA_OPT
+static const char *dsa_dev_path = "/dev/dsa/wq4.0";
+static int test_dsa_setup(void)
+{
+    int fd;
+    fd = open(dsa_dev_path, O_RDWR);
+    if (fd < 0) {
+        return -1;
+    }
+    close(fd);
+    return 0;
+}
+#endif
+
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
@@ -3986,6 +4054,16 @@ int main(int argc, char **argv)
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
+
+#ifdef CONFIG_DSA_OPT
+    if (g_str_equal(arch, "x86_64") && test_dsa_setup() == 0) {
+        migration_test_add("/migration/multifd/tcp/plain/zero-page/dsa",
+                       test_multifd_tcp_zero_page_dsa);
+        migration_test_add("/migration/multifd/tcp/plain/cancel/dsa",
+                       test_multifd_tcp_cancel_dsa);
+    }
+#endif
+
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
Yichen Wang


