Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56989E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0On-0007Mx-Bj; Mon, 02 Mar 2026 05:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nz-0006Zq-Eg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007Hk-TF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446815; x=1773051615; i=lukasstraub2@web.de;
 bh=HxiDYFgacPvgSqtV2BRTOBlRJCdeGvyIqxMJefcSLYA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BnKvcQMRyNtoIByLCEGfXcDkJ1pTmPjzd2fY/d1+Q64YsmPQH+Gk6zNnP8RoxuI8
 6szCoLLkuFpHnBc/1AhcdWeR3bEfx8Ze8BhLv+Y4R13hdeEbDPoeuRo4e/xClPwi3
 bumGAGshioV0ZLntciCjPwJBw1zWOFmff8Fobrqnvzlh8KAZuo8j6tYeYqGnwtri4
 auK+BEstuislBqyR/wMRH79xYQNc2rR0pNWKRbSyi7ZxzOViRSV/pPWy+2RFOCAwp
 r/Re0rUGQ2krD4vTDeB+hPihRe/I+QDk+RPINArowVTrkw9z2l2gYISGe2dt7w5tF
 /2Rpd8bpHWB6JXIIxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBS71-1vpYP20aND-002owF; Mon, 02
 Mar 2026 11:20:15 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Date: Mon,  2 Mar 2026 11:19:55 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-13-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=VhVWaFr02/WFdhcd119EsGPo60ArzchyNKMe18f0Kks=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpoAYyluvnZf0CRPZAPpB4ko7EAVQKIMcYK
 OFhIXCvjFmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WFf7D/9FCZA4Hrh6nBsNX8vBz7SNEtwuXTrC+2OZmS+84O/c5DbV/rYNgdpHYhyHdOnEBAKsRgj
 0Pda2z178zIqB1L8KAwJd7JqWe3LSRWe9GHNhouw91ZfZUuleqIiO4rT+dn/X2RAmyd8ix5Zwxz
 FB63iKLulO++k4jRvKsN1lIZsWuewHtbdupbrPWTcNPU2F5J/v1GY8UQc52AREdGRnp/Yzu3Qio
 tT9RQNI2LZ6wQPg3OTovXa0dpAH+hg6HfE7Vb/AgjsLukC3UBP038aZLYBQReIqDoIEoB4c1uhw
 W4SMNMhJ8IbRTXr3+xNSroiuYsnwUzZnB0ISpEW577hj+/SxwanBUO/HHov14UDkiLBYL/PdOVR
 iPdI9ZJuIzi2xc4mCrURM66nJDC0CE64bPwO/WeH5D35t3tTm2zf2uIY95HMT5E+vtkg+pxMYGO
 nkJpAp9OV8DA6CHCy8JRCcBiDtpXTqwLErFdWYbiG9H2ejtzzDpucaQEMB1wuHavE2Fr0y6bv0z
 gUzZyT95n1LdmVYwO4ebVCTKk8fBjAWfWXxef52ny5y3FVKv3Ufqwx6NW8U40Jt8vPGeC3jJOg/
 HcTzo1vpBXue+CQZfRg7DM51ikT2v0Q693BavwL0syzlPWYZW4XDJuaoWUHDI0pliKh2uV2cseh
 d3+2z3zpCYZRs7w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j8jmMZ2wnzYBOpGdLlQ1/PoL1Q9vgbVCFLm+MCFCVLfuP0Alm8+
 LYJZkbJ1WBdZiLds0SpJCTfsxLaHY/RqLK+tu3SxtGATT4olcGQYtYw3PllATnvO38nI6hI
 IPbBKAjXMT5QmsJpB9gACQGesquDQBzfExo/lz1NsnOD013gD2Iko25l26xiDq+o9KfUFzT
 DhSEgIMBPy4UXslr7MMJQ==
UI-OutboundReport: notjunk:1;M01:P0:S+tc9WKR2O4=;oyly9sS6sYYFqP6QS18C/ENeb4R
 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
 Sb6Sl+BbOmevo3ifHbh9Pfmj4tgPV
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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


