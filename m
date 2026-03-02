Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627F3E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1j7-0000mt-Hy; Mon, 02 Mar 2026 06:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ic-0008W8-57
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:49 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1iZ-0006CB-PA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451940; x=1773056740; i=lukasstraub2@web.de;
 bh=HxiDYFgacPvgSqtV2BRTOBlRJCdeGvyIqxMJefcSLYA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=K/mjSlZVEjTu/SufI1FNFBM+4UB2CQC/buvkE85n4saYdJBXgWEolWhwXJ7IFscn
 qF7JvPJRARHXtHoir3auuAtp90yMAdz6FZ+7zdPMv8/GMflM+7rQuvs2pmp9zuITU
 F3PdkTD9BtRBKImirLylqYqja16Z1iPoWlZevs6nCa+EHjP56wVoLRUoqsGZkrzfF
 DexxVxfJrnUnI5OMFlaP0bOGkM7WEnn76S+L8rjbXaxXwPko6LO956Nhtaasz2tcC
 1mwJPLB8PC43a++eScR3CjnsLQ4Iv4LUuVhkHd4Ga0anz1Cp41iy/PI0SDUXAw4mh
 mGkWqN0eBAPclJdxmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1vRX3T1lBv-00asN7; Mon, 02
 Mar 2026 12:45:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Date: Mon,  2 Mar 2026 12:45:28 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=VhVWaFr02/WFdhcd119EsGPo60ArzchyNKMe18f0Kks=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6U/F3qUHj8768f/VCsn46FkFqmNXzgxUsue
 jcbQDcJzF6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WJ38D/0aWxqzkE/VoFkvdy06/ay7yo1JZfUvi/2JoqkSJgXbOdr4IRHynrol3/SR/Rl/swSkfrg
 0ZIHjSg837VOu2xw9K7AdWd4cjf8hhzR0KGlKW/eR7oiGTARo6yjlbePB3Saxca/cP/ID5jOUP/
 4qEcnFSqLPzyUObfDiMXg0mZ51dcynX0hMVCtcF7aYaHzgBZIPwWc5hkHhZkcg4tQ32ok7XQA0v
 WHHxS87vOPPEQBXKynO/OWgcJtX9g3qDsLpt5R26mcEgrUFZlsH1w4xRnA11v93K6mGPYBhOWFu
 1hWaZxu9QTdJV+emO84noF7wdBdnuu9RtrY0ulN01XEuW8ik5aFdRaIgdHbk25Ovom0nerYze+5
 Os1KXbF4o5mu3iZGtjPT+8Aj+Nh/fiiPPkmisOsLWiCL57NTY9a4bwv8oZdW98es4SF+QfdJvUF
 VgEO9oa63UWldK8uJgBZ3ypNw480kAbFwW6IHJwlXcOEs1aUZwZLu6ivqhUm3XXHSMICZ2VKWxc
 MLexlHFyMSWzwIGELLnuRIRyzEVYQgoU1bprH7I40IzcSpP44XCAse9Vrnhfg+XCOH7+a9SbDq/
 Kh2TEe+isqds1Fl4Br4LotvjN8D63xvvdkN5yRlU61Ehdy82hoQopV7SGStQCOHdDh6AhHUyPn9
 Jd4hS95V3DIx6gQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fo1EZXsM47r4O0a27HeV5cXpcSCGt1RDU6wnR8S7y98JiCWc85E
 AL3hO9j6/HIklL+KVyTvtaK4rzcLjHxiXBXRnQMQgzXRkNTOlSkGdUnyfnIL5xbz7xDXnlO
 399/HbX4aPVcB+WKJMKw3+iTOhIoT+cpEXhqnCPXpoSsZXQcDiFBG6nagQPNbtGr+4LTfrT
 UOVEXfTlHk3pPEpcOvWkQ==
UI-OutboundReport: notjunk:1;M01:P0:jDq+ozn5N7g=;2m1RzGjVSzuWTVQu4Dn3lQve0J7
 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
 W4dLydZieOOS8u8aLMQo1XrKhNCgj
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a COLO migration test for COLO migration and failover.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                        |   1 +
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.h  |   5 +
 5 files changed, 211 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2a1f4cc08223cb944b61e32a6d89e25bf82eacb..1b0ae10750036be00571b7104a=
d8426c071bb54c 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3875,6 +3875,7 @@ F: migration/colo*
 F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
+F: tests/qtest/migration/colo-tests.c
 F: docs/COLO-FT.txt
=20
 COLO Proxy
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 25fdbc798010b19e8ec9b6ab55e02d3fb5741398..6a46e2a767de12d978d910ddb6=
de175bce9810b8 100644
=2D-- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -374,6 +374,11 @@ if gnutls.found()
   endif
 endif
=20
+migration_colo_files =3D []
+if get_option('replication').allowed()
+  migration_colo_files =3D [files('migration/colo-tests.c')]
+endif
+
 qtests =3D {
   'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
@@ -385,7 +390,7 @@ qtests =3D {
                              'migration/migration-util.c') + dbus_vmstate=
1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
-  'migration-test': test_migration_files + migration_tls_files,
+  'migration-test': test_migration_files + migration_tls_files + migratio=
n_colo_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 08936871741535c926eeac40a7d7c3f461c72fd0..e582f05c7dc2673dbd05a936df=
8feb6c964b5bbc 100644
=2D-- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -55,6 +55,7 @@ int main(int argc, char **argv)
     migration_test_add_precopy(env);
     migration_test_add_cpr(env);
     migration_test_add_misc(env);
+    migration_test_add_colo(env);
=20
     ret =3D g_test_run();
=20
diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/co=
lo-tests.c
new file mode 100644
index 0000000000000000000000000000000000000000..598a1d3821ed0a903187327020=
27cebad47352fd
=2D-- /dev/null
+++ b/tests/qtest/migration/colo-tests.c
@@ -0,0 +1,198 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest testcases for COLO migration
+ *
+ * Copyright (c) 2025 Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "qemu/module.h"
+
+static int test_colo_common(MigrateCommon *args,
+                            bool failover_during_checkpoint,
+                            bool primary_failover)
+{
+    QTestState *from, *to;
+    void *data_hook =3D NULL;
+
+    /*
+     * For the COLO test, both VMs will run in parallel. Thus both VMs wa=
nt to
+     * open the image read/write at the same time. Using read-only=3Don i=
s not
+     * possible here, because ide-hd does not support read-only backing i=
mage.
+     *
+     * So use -snapshot, where each qemu instance creates its own writabl=
e
+     * snapshot internally while leaving the real image read-only.
+     */
+    args->start.opts_source =3D "-snapshot";
+    args->start.opts_target =3D "-snapshot";
+
+    /*
+     * COLO migration code logs many errors when the migration socket
+     * is shut down, these are expected so we hide them here.
+     */
+    args->start.hide_stderr =3D true;
+
+    /*
+     * Test with yank with out of band capability since that is how it is
+     * used in production.
+     */
+    args->start.oob =3D true;
+    args->start.caps[MIGRATION_CAPABILITY_X_COLO] =3D true;
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return -1;
+    }
+
+    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
+
+    if (args->start_hook) {
+        data_hook =3D args->start_hook(from, to);
+    }
+
+    migrate_ensure_converge(from);
+    wait_for_serial("src_serial");
+
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+
+    wait_for_migration_status(from, "colo", NULL);
+    wait_for_resume(to, get_dst());
+
+    wait_for_serial("src_serial");
+    wait_for_serial("dest_serial");
+
+    /* wait for 3 checkpoints */
+    for (int i =3D 0; i < 3; i++) {
+        qtest_qmp_eventwait(to, "RESUME");
+        wait_for_serial("src_serial");
+        wait_for_serial("dest_serial");
+    }
+
+    if (failover_during_checkpoint) {
+        qtest_qmp_eventwait(to, "STOP");
+    }
+    if (primary_failover) {
+        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': 'yank-=
cmd', "
+                                            "'arguments': {'instances':"
+                                                "[{'type': 'migration'}]}=
}");
+        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heartbea=
t'}");
+        wait_for_serial("src_serial");
+    } else {
+        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank-cm=
d', "
+                                        "'arguments': {'instances':"
+                                            "[{'type': 'migration'}]}}");
+        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbeat'=
}");
+        wait_for_serial("dest_serial");
+    }
+
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
+    }
+
+    migrate_end(from, to, !primary_failover);
+
+    return 0;
+}
+
+static void test_colo_plain_common(MigrateCommon *args,
+                                   bool failover_during_checkpoint,
+                                   bool primary_failover)
+{
+    args->listen_uri =3D "tcp:127.0.0.1:0";
+    test_colo_common(args, failover_during_checkpoint, primary_failover);
+}
+
+static void *hook_start_multifd(QTestState *from, QTestState *to)
+{
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none"=
);
+}
+
+static void test_colo_multifd_common(MigrateCommon *args,
+                                     bool failover_during_checkpoint,
+                                     bool primary_failover)
+{
+    args->listen_uri =3D "defer";
+    args->start_hook =3D hook_start_multifd;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
+    test_colo_common(args, failover_during_checkpoint, primary_failover);
+}
+
+static void test_colo_plain_primary_failover(char *name, MigrateCommon *a=
rgs)
+{
+    test_colo_plain_common(args, false, true);
+}
+
+static void test_colo_plain_secondary_failover(char *name, MigrateCommon =
*args)
+{
+    test_colo_plain_common(args, false, false);
+}
+
+static void test_colo_multifd_primary_failover(char *name, MigrateCommon =
*args)
+{
+    test_colo_multifd_common(args, false, true);
+}
+
+static void test_colo_multifd_secondary_failover(char *name,
+                                                 MigrateCommon *args)
+{
+    test_colo_multifd_common(args, false, false);
+}
+
+static void test_colo_plain_primary_failover_checkpoint(char *name,
+                                                        MigrateCommon *ar=
gs)
+{
+    test_colo_plain_common(args, true, true);
+}
+
+static void test_colo_plain_secondary_failover_checkpoint(char *name,
+                                                          MigrateCommon *=
args)
+{
+    test_colo_plain_common(args, true, false);
+}
+
+static void test_colo_multifd_primary_failover_checkpoint(char *name,
+                                                          MigrateCommon *=
args)
+{
+    test_colo_multifd_common(args, true, true);
+}
+
+static void test_colo_multifd_secondary_failover_checkpoint(char *name,
+                                                            MigrateCommon=
 *args)
+{
+    test_colo_multifd_common(args, true, false);
+}
+
+void migration_test_add_colo(MigrationTestEnv *env)
+{
+    if (!env->full_set) {
+        return;
+    }
+
+    migration_test_add("/migration/colo/plain/primary_failover",
+                       test_colo_plain_primary_failover);
+    migration_test_add("/migration/colo/plain/secondary_failover",
+                       test_colo_plain_secondary_failover);
+
+    migration_test_add("/migration/colo/multifd/primary_failover",
+                       test_colo_multifd_primary_failover);
+    migration_test_add("/migration/colo/multifd/secondary_failover",
+                       test_colo_multifd_secondary_failover);
+
+    migration_test_add("/migration/colo/plain/primary_failover_checkpoint=
",
+                       test_colo_plain_primary_failover_checkpoint);
+    migration_test_add("/migration/colo/plain/secondary_failover_checkpoi=
nt",
+                       test_colo_plain_secondary_failover_checkpoint);
+
+    migration_test_add("/migration/colo/multifd/primary_failover_checkpoi=
nt",
+                       test_colo_multifd_primary_failover_checkpoint);
+    migration_test_add("/migration/colo/multifd/secondary_failover_checkp=
oint",
+                       test_colo_multifd_secondary_failover_checkpoint);
+}
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/fra=
mework.h
index 40984d04930da2d181326d9f6a742bde49018103..80eef758932ce9c301ed6c0f63=
83d18756144870 100644
=2D-- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -264,5 +264,10 @@ void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
 void migration_test_add_cpr(MigrationTestEnv *env);
 void migration_test_add_misc(MigrationTestEnv *env);
+#ifdef CONFIG_REPLICATION
+void migration_test_add_colo(MigrationTestEnv *env);
+#else
+static inline void migration_test_add_colo(MigrationTestEnv *env) {};
+#endif
=20
 #endif /* TEST_FRAMEWORK_H */

=2D-=20
2.39.5


