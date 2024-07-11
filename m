Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE39C3DA4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1uj-0002PQ-5t; Thu, 11 Jul 2024 18:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ug-0002N9-Iw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:18 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uS-0000Vq-B9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:10 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d9e13ef9aaso843774b6e.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720735503; x=1721340303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lky2qViTQvC4wtieFSLEUnrtuJBg0t8UrboKRrXUgoo=;
 b=HIQHYU5sRPRjjlpJ6ZcYSR8FSju+NIJftn12iVaeRPd1rUjsWIc6SqHlwFRissfI93
 u5YvMqsdAw/hq/6YsrigTRtjzyFMxFCaUf6iidVE4oKk1pa9R47E/AC+f0zJGplagCG7
 UrIp2FyZWQ3oYea0IXWzcR9+rrw8z/dQP6Y6059sK+Mewo95eLhK4dPMELrnHcG4CmJr
 PT4w8VmcuEzzYXuS1B3p68OVZHZcEtpf6kEKN4xuhoILOp/wVzB29xdx6CcHPwrK9NXh
 YE0/L2qEImLHqsDhln4wvZCrvLutFLIwy1Ini/ZNV4fZpgYdUSAKw5zkuaCzIipk0MEe
 hZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735503; x=1721340303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lky2qViTQvC4wtieFSLEUnrtuJBg0t8UrboKRrXUgoo=;
 b=J1UEOZIZIoBbuQqf8LJhNrxkkX868Z5WyViGEaZ4t88onUIC2SS38FZrfLf8G6D+0N
 taWs+3bYMPesolWKVkaYKrgnjhLbbU7w8YHf1mX1DFYnklFlDCI62C53qPBA2ByZQciJ
 AtoUVEBX7QkKPNuXcoyKxDh1zwIiztJF0DfpsXq8rUKvaUm8qIXgC1h4pdG/vHP9g8ST
 tyhUsLKfxiJp2tmlDyW+bPZU9N1UNM3boiV72Ad7+bd+GrZFsa99cs/aFx2gPNdjDT8U
 tw38n4YnLi+XkSGmVv8c0JNVWlK36sQPX3VJNLrwB3Bblqk70zCV28HRgPiJjpLCnT7I
 o/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8nCVWvJMH/hFLF5NP0azBt87cf5dUMjv+EeN1n5cPgnxkMNPBliSTMqjgrGS52fcwzIKPDq43XVLU7GLevQgb4BAmvZ4=
X-Gm-Message-State: AOJu0Yxl+gesY9JH0qsQ65D8oLmA/BNu87zogKXagU4BIx5TR87rjBhH
 KVNbE3hE2aUf2CSmbhcER6I4lhUkV33z9TODSQXX1UgWgVtPGKZJrEBySvUoZXI=
X-Google-Smtp-Source: AGHT+IH7zaypfsaiYkptZ7R0CTbcb62xCDDJHF7wn0mG1YOlnSX+zQngcvdCwyJPVdFgzJ/Wuqvkcg==
X-Received: by 2002:a05:6808:1:b0:3da:aae9:7165 with SMTP id
 5614622812f47-3daaae97310mr427966b6e.14.1720735503179; 
 Thu, 11 Jul 2024 15:05:03 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93acff4d9sm1218578b6e.5.2024.07.11.15.05.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 15:05:02 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v5 13/13] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Thu, 11 Jul 2024 15:04:51 -0700
Message-Id: <20240711220451.19780-4-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711220451.19780-1-yichen.wang@bytedance.com>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x236.google.com
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
---
 tests/qtest/migration-test.c | 80 +++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..67cd976705 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -608,6 +608,13 @@ typedef struct {
     bool suspend_me;
 } MigrateStart;
 
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char *dsa_dev_path_p = "['/dev/dsa/wq4.0']";
+static const char *dsa_dev_path = "/dev/dsa/wq4.0";
+
 /*
  * A hook that runs after the src and dst QEMUs have been
  * created, but before the migration is started. This can
@@ -3279,7 +3286,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -3299,6 +3306,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+        migrate_set_parameter_str(from, "dsa-accel-path", dsa_dev_path_p);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -3348,6 +3360,49 @@ static void test_multifd_tcp_cancel(void)
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
+    migrate_set_parameter_str(from, "dsa-accel-path", dsa_dev_path_p);
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
@@ -3772,6 +3827,19 @@ static bool kvm_dirty_ring_supported(void)
 #endif
 }
 
+#ifdef CONFIG_DSA_OPT
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
@@ -3984,6 +4052,16 @@ int main(int argc, char **argv)
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


