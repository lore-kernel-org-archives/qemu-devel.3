Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6BCED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygQ0-0003Hj-8B; Wed, 09 Oct 2024 19:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPb-00036H-HF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:48:16 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPZ-0006gD-Vz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:48:11 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbceb48613so2467836d6.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517689; x=1729122489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yby7vSJjPVA9a3PElfIZJQ0FPWIMr9xtoFf7KH5DZnk=;
 b=G5UMqpjjdTPyQNbHBiqk4cp2L02Tlf8WaD0vFK0hpLI3q57NJ/F1BL57QkttCMgZlM
 WKQmD2kDQJ27wxZCxeYWpW8u9LS9msgGuYDVts4kMUTLVnlLEFlLu0K72DRUmQr9zeqS
 7jBsHnoWOPGHFkWc/5rJz38TcQePLNYyf8VC0e8wkzrV9hzKqUU7klERhxfIwNg/1KYc
 dudpIbPXXsWSLrNd4SR9Mk5GC7hNz5iYd5YChmG/BFjwZVYFuCSna0ANKtQskZgF2D/y
 UFF+ZyP5q4flxprUYFrW6G+78IiSEeQODYgy+iNvDpHVdlBflkTtV6PbWkShuPWb1pzJ
 DFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517689; x=1729122489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yby7vSJjPVA9a3PElfIZJQ0FPWIMr9xtoFf7KH5DZnk=;
 b=vXs9zxbXFQ3QpOwDA2vNFc1ikklE07xVjZKuIuVSYIVjIfTCT7CZgcUEsJARob5U70
 ju/me4wifLNeGss5KPf64MKhReJe1BdCOLILn+8Fv0O/3tz7OabV8szB8IEJKFTo8q6q
 jxYjqy6ffYauAm7ZxLCDusxqVLys8TZLXF38wGqT4XAssduG0x6mHOafe4p5WWEd+qjK
 RUmNAoejCBU7Z3ZnwAD8cYx8JAK0btPOjT4gHxjDUnLSLoIO8tEAuOpXYhDmWskh+Z+D
 ZtagEMvOuCvY4lYGszUp5/Drr7q0n4aTPDsicQFmWvPF21NZcAHYbiHKPT6QcBqEMDSm
 Mf/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUY9IYQIWHIkbYcQcSJeaSruwbwBTwV9byvQ5wfOFpXF4v9uet8unskYdfDPM/VTpoctk5zKJcHHec@nongnu.org
X-Gm-Message-State: AOJu0Ywzx7VqUovMtrF8iU8/HlfMS7UECtqoou1eBRyS9eFFb2pya+Mj
 EtqWOchIkNtoZnU2wfOJ4Tdf5tZVdG+isdcu9LHFjRyF6vtZqF8HKdw404a8jZk=
X-Google-Smtp-Source: AGHT+IGXWAF3cktR536cbh8bgJlIcfWGBEX+1dbf84Bnu/XDLJKLYB5eosBs6C2jlEjDrgvAKt3WaA==
X-Received: by 2002:a05:6214:5d0c:b0:6cb:8282:d02f with SMTP id
 6a1803df08f44-6cbe4a2be52mr28755176d6.6.1728517688982; 
 Wed, 09 Oct 2024 16:48:08 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.48.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:48:08 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
Subject: [PATCH v6 12/12] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Wed,  9 Oct 2024 16:46:10 -0700
Message-Id: <20241009234610.27039-13-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf31.google.com
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
index 814ec109a6..47a9dd8c50 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -611,6 +611,13 @@ typedef struct {
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
@@ -3230,7 +3237,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -3250,6 +3257,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+        migrate_set_parameter_str(from, "dsa-accel-path", dsa_dev_path_p);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -3300,6 +3312,49 @@ static void test_multifd_tcp_cancel(void)
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
@@ -3727,6 +3782,19 @@ static bool kvm_dirty_ring_supported(void)
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
@@ -3939,6 +4007,16 @@ int main(int argc, char **argv)
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


