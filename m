Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E6FEB26E3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWe-00014i-6o; Tue, 10 Feb 2026 11:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWZ-0000y0-5r
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:40 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWX-00070Q-2s
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740605; x=1771345405; i=lukasstraub2@web.de;
 bh=zZmWjHjQ6lItQ14ur7yHrRObdhRj00cj/OHH9WFRmcQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=q/hbzFExpGZ98DFbvrkEZg2nqPmJDTkoJDSG6Lox3SOSGDt48AWXbjh1S6z1jT5W
 pa9EK7wsZxeaJy84hhg31xhnmgytZhFLeTu3uq7BZwNuNswvVkwXEntq2QOtI9i4j
 izQOohI/2PAiPDhlPooYWhjZPcKT2GEzFRh0vacgChbUmCAjVQ6lZDgWZR35q4O3I
 qUJygNNQkjba495VtBK/itaCRqgIvtyAYl9v0Eedl59ZnJEacl5PCgmSUmxAkDZPh
 SOCuBghlGQL3NCAs4rK5NqHyxRExvXqpRpibfj8w/R4+p7Us9j2tx6iihNDB2DTvr
 DW188cgdpTyVHr8Uow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1w01eJ3tlL-00GHf2; Tue, 10
 Feb 2026 17:23:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:11 +0100
Subject: [PATCH v8 13/17] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-13-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 bh=l0keOMCpjfwRRBppboSoF5o5+YBX7iahZfhZmMFJqtU=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3BW1PQi4NPeDo2rtsw8PdLvR/SpuP6+wbE
 QZn1XjoE2OJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WMKBEACbNAHAuJhPJT0o6rQ4h6kvRnC34vqXpZVu2Mhyw7VqNNBh6lJ9p5xpJAVScE6hncK+/FX
 07SiiYN43fFHPTo0PUv/4Le0XQzAsjN+tBSS95Tbh3Kto1eAgZBGB/StrArXppRNSoJVh7D/rdD
 lQVM5pH9JCkQEAO4wE1erMXI8yyi3j0xzRyBBUJtzEiNMvuCqI44cqhukMFnryBiz0qbzana3Dd
 rvwv0TdxurQOi3KAUx7+Ln/9+xK/YM4HmyWsyLF5boLy9fzeIPMDSjTZqgbr1OSpqLvQIcO5Ny2
 BLCpBq2D+8aA+h15XMrCMlwgog8EP7kD7v7ERxZZFdjW4DZORG7sisjP1d/t//LJ7aDZH0mNZ/u
 V/Ozd2Mdps6ObW8b3WDOELHp8+RD4GIapkf3YnpYAJhi2sSLotWx4BYjl626j66VC/2aUoyFmGC
 2nJk+JlipZiNh40s6K5EXswCheZnntO3ZCoGjsajyqwfBKb/C8nM2Dqv11skErJpucvxOl6zHup
 2hArzEv+YRNpL3neknGIYqb2C/iHUFcE/SiILLO+oxRk4W2DfoTmCt9M1Gtv3umTQf9tpoD2olf
 eYb2E8FeewLd2UbDo46vJ1njnvpjV2IH1ongzcmDEkV/5zKISrotX2Bzahw8N5OZTAs01wnMpLY
 70efmgmnDWvJ1/g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:vDY/I0EohAW65cnDx6HCgXIKyr/U4Lf83Yazim5yGC3m8i8NUK7
 LLR7XENf794sJBP9jFPa28rkdsFmrX5BGCV1GgPXAbBJT9bxMC6l5Q+UUVLg1lL/D9Q+swX
 r4/dQG6L+8ZOHQJy7JhNtOr+R/nj/IUFoBsiqZVmCa/I18Ws8BXKmaSJsORE9RMdNekulDe
 +5led9m7uywr4EhBWBhOA==
UI-OutboundReport: notjunk:1;M01:P0:doUpYzZ3Pfs=;Xd1cDLKKFXjsz0EOuc8GTwoPMcM
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index e6e711ac8a333bb9bfa0d75c2c42dbe74b8523f2..fe6010929fc4cb83bc8a7686fb=
e537f1120f1eba 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3862,6 +3862,7 @@ F: migration/colo*
 F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
+F: tests/qtest/migration/colo-tests.c
 F: docs/COLO-FT.txt
=20
 COLO Proxy
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index dfb83650c643d884daad53a66034ab7aa8c45509..624f7744ec9bd81c8823075b96=
6bc95f7750a667 100644
=2D-- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -371,6 +371,11 @@ if gnutls.found()
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
@@ -382,7 +387,7 @@ qtests =3D {
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


