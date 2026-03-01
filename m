Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF813FD007E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU5-00048G-OW; Sun, 01 Mar 2026 16:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU3-000472-Op
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU0-00042H-QD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401065; x=1773005865; i=lukasstraub2@web.de;
 bh=HxiDYFgacPvgSqtV2BRTOBlRJCdeGvyIqxMJefcSLYA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DnsDxH6YY44VC9R8pSTzP9rDH+nDIq5pVgt+6YuvCc4VHgnazXgIElYDTBFwF5Hu
 4sVteOnoc+HelLbpXnBNX2kmPWmB82MGbIsds+UUAzLhKyWEd0ByRjegBmkn4arCZ
 T8f49h33s/Tknh0LR8HS9U1IiVtZloOvnSC3oyUWIlnSYjFequ12dEl8DxYLEYUrT
 BD7hdFyqLwbJHbm0jkH7e8lUxJSvn6PGUZgzYtxmnbl9QGl5nGxs20lT9t2gvVaOq
 8xkczAVwCiW/axVpawtQujrvyccg/+R6ZhjL3vhlJzRpGXManqrM1o+fpncBP+Cef
 l0Y7MeUM5gmYk5Mu3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1wEksC1F4L-00MDiD; Sun, 01
 Mar 2026 22:37:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:33 +0100
Subject: [PATCH v11 13/21] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-13-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=VhVWaFr02/WFdhcd119EsGPo60ArzchyNKMe18f0Kks=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGidukV2+6lzKfx5ZKNxr6A/bEREe81DhpgH
 4d0b2Q4mTGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WKArEACbxaXh/d7IfhsOfeqpRmp1hdrb4MWCw/jMyoNan/gaYkgALyGcoWhovO6p/uwYZkyG8+9
 uKTF6ZULW0tPAoCP6LujXxxCeckszqqlSYsHryjFyFORnS68sGgSQJZAc1hZbGBy3HBFeB1aX6U
 oAWImaD9AMa5upHhvBcTcD4nANy5tMcMWTL0k1PnPTkUfj17S0nkOrH2xFESH/+2LKWeKSg72UV
 PzFIr4IGXwxuxDp1H/+GMZ322BW6hzyc9ZRCJvOmg16dzuZ6bWnqQo1PpkWhwYRUly1+89Xew8Y
 gcW5PBN31mLIxkxokrWKcvPMJd/6N9SBjnEG2VbHVjVAnkz2lLDdvobwe0WbRcRZAZw7FZPE79/
 VeG8DaNV0WFXtkZGbKDnmRqVdWdo6muBWTX5wcdoPUS4mRveedLVBhAdG8dNu0yLe/YNuvApO2A
 2CrrCi6xsNqvxlLQhPDt5yzdRbdXPJEpDFOZQcZia4cmHO1SuKauVfjLG1R6Ru6QGDK6EIaFGme
 cp/tZH5EzXftl3eiZR9jCtVNePt+7tApSFEPLHyjXd/gyO5FZgZfDw+v2/89Dcu3W2ktnHb1JL1
 rw2E1wAyUhRtIau3iO4zH3AyjrxQVYp3OtvEmd6vH24+ZY+ikbBOGCMo42+Z1xNfLmAhKcxFWgi
 2LSw2yKLAFaOmdg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:fC7EU535D894nKxtVZ9e61IxXz9OfbaZUTXAQlUl3aH8oU21Qzc
 id5KUMAb92E+CVNy/IZGwulq8fKUSiH7ruxk5Y9cpSbG9BZh6b6EBF7FiaMK7uO0a3+yhEG
 5QFCYBBE1aJyOc47zHDTjAYprHjgL+AQg3ginympLaiyo79s/VUhQKZysr9nWb066s33p0x
 XQKCmh4hSdPmysAEaGN6g==
UI-OutboundReport: notjunk:1;M01:P0:Qdm6ZzL/pDE=;3F+RmrWAhhgSl6Epgb2Vl1F4qm/
 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
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


