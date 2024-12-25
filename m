Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4168E7718E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFko-0001Wh-Ar; Tue, 24 Dec 2024 20:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkm-0001Vp-NS
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 20:00:00 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkl-0000Qs-2J
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 20:00:00 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8e8cb8605so29132936d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088398; x=1735693198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65GTU1//NgdTBQFKZluuU8u2RNkvRDyZjKOZ3sqEvMM=;
 b=Ba+8xz9xWqzvMATKmTm+lW65zIms4YjO6WSsB7KgEewK7C00SmOBKTSq2TEw4TRRlT
 h1QKB/KFUmh2Ji4S63lqQmbbK3ByeLKvmgCbFleGfxf7WxxFtNXlbPwaFYudP7O6MW/b
 X28VZojjbn0FwFa8PTcjc/42cUeqBpKanwp9rR0fNTx6aeTiQDTppp1FlZ2q1YXDFLFK
 Ey9fQormkPgXhewcPc4eUXMQE7GdUhaXe04cojfeW2CsJnhbswuEB8yd9Pqa4y5uSFcR
 sRJCCH2w50MWg56uJEI3dKjfOSPxeIkrOFqrFuqyYl73G187fyGKhnLJ2nuuwapw/44g
 HAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088398; x=1735693198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65GTU1//NgdTBQFKZluuU8u2RNkvRDyZjKOZ3sqEvMM=;
 b=FALw5ZvRu0uxFaQcogCXwhSjH04550wbjaqMdOH/wbZzF3mln/9MBMK3VcT66ZCxEt
 J4iDdc/RSzBSYRhE4TwXygjxCsmzxC82ZZyYuLzyFNljriVkMMKzsvgfxmM3DtPT72RC
 UEfqB9GwRXP193ipCYwZHc/6CTngo3rbgtj90aLnVgN3AZHJjVjzcy9Fi/j7op0zDeMl
 qyvRgNLM2qGdMMmHz2Kn6uDt2sZ5iRrXwkxhYyL7AfXqDXUnmZ2bHZYN5UYgsBgGBHqS
 sYa8UIDbGgOqW++mshkcEsyyFnackSfUVO96uHurVncBR9LZvSv9nYbpFDUdYYcK2d+L
 mMzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO5NwY+vCP6V8XakJinFcvS2KPhgUjVslLKb+Iaqqrf1hZSOMwocWm4t1Ka+0q9qFOGQQ5uL4HRWq0@nongnu.org
X-Gm-Message-State: AOJu0YzGFDUlADXcYOyboXnf4/bIkXIOIJyzZLTzE7sI/aP+YsOfwS/M
 2UN1doGMmalOQGH+tjsj589EzPYdohVWorPHyZkAcc68WnbNJ0uOb/BsNaKcTLA=
X-Gm-Gg: ASbGncvBut51e+SqwwDb+nqOD2iJPpoawaxHxbE3ORYljrpCKBy5RnEJJ6A+DYwTWnw
 nQVEWrjiJB9CPym1hfI6GCW6MqBJ4cKCzqBHWW3kXZvTsA4mpCmG5j+UD7gDuql5rj0UAyClioY
 vO5/Tx6iHHfCK6T42cxxamOqrJFc8ojflVGJFtiwWlD4GyU8LVW++xcfb7Rp4raDuZxLC4gaBgv
 TtKaXdNhFOBIQkPhrq/vpHGLMPDVweOz/fl7F0x8AGAzQ5YcAdxYLwcHqfBWuvEi7dV6Sd1DMhE
 9j8etrQkjshBTq5HZNp3YOK/fw==
X-Google-Smtp-Source: AGHT+IGFMPwDGS9F86TxACl6LzAf0NjQMYYVARjOn0nL5De2GXlOW/5DFeYnVCBQgbWzbUX6MnfC5w==
X-Received: by 2002:a05:6214:486:b0:6d8:b594:c590 with SMTP id
 6a1803df08f44-6dd23307cacmr254533126d6.6.1735088398012; 
 Tue, 24 Dec 2024 16:59:58 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:57 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v9 11/12] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Tue, 24 Dec 2024 16:59:18 -0800
Message-Id: <20241225005919.26853-12-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2d.google.com
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
 tests/qtest/meson.build           | 10 +++++-
 tests/qtest/migration-test.c      |  3 ++
 tests/qtest/migration/dsa-tests.c | 59 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h |  1 +
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/migration/dsa-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..17ed7f3fdc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -355,6 +355,13 @@ if gnutls.found()
   endif
 endif
 
+migration_dsa_files = []
+if config_host_data.get('CONFIG_DSA_OPT')
+  migration_dsa_files = [files(
+    'migration/dsa-tests.c',
+  )]
+endif
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
@@ -362,7 +369,8 @@ qtests = {
                              'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
-  'migration-test': migration_files + migration_tls_files,
+  'migration-test': migration_files + migration_tls_files + \
+                    migration_dsa_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5cad5060b3..9f37a36377 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -30,6 +30,9 @@ int main(int argc, char **argv)
     migration_test_add_precopy(env);
     migration_test_add_cpr(env);
     migration_test_add_misc(env);
+#ifdef CONFIG_DSA_OPT
+    migration_test_add_dsa(env);
+#endif
 
     ret = g_test_run();
 
diff --git a/tests/qtest/migration/dsa-tests.c b/tests/qtest/migration/dsa-tests.c
new file mode 100644
index 0000000000..6b45627e63
--- /dev/null
+++ b/tests/qtest/migration/dsa-tests.c
@@ -0,0 +1,59 @@
+/*
+ * QTest testcases for DSA accelerator
+ *
+ * Copyright (C) Bytedance Ltd.
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char *dsa_dev_path_p = "['dsa:/dev/dsa/wq4.0']";
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
+
+static void *test_migrate_precopy_tcp_multifd_start_dsa(QTestState *from,
+                                                        QTestState *to)
+{
+    migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+    migrate_set_parameter_str(from, "accel-path", dsa_dev_path_p);
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
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
+void migration_test_add_dsa(MigrationTestEnv *env)
+{
+    if (test_dsa_setup() == 0) {
+        migration_test_add("/migration/multifd/tcp/plain/zero-page/dsa",
+                       test_multifd_tcp_zero_page_dsa);
+    }
+}
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e9fc4ec363..6e194cda41 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -226,5 +226,6 @@ void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
 void migration_test_add_cpr(MigrationTestEnv *env);
 void migration_test_add_misc(MigrationTestEnv *env);
+void migration_test_add_dsa(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
Yichen Wang


