Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC54EA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohe-00059U-Bd; Tue, 10 Feb 2026 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohV-00056V-On
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:50 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohT-0005kS-N6
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733602; x=1771338402; i=lukasstraub2@web.de;
 bh=zZmWjHjQ6lItQ14ur7yHrRObdhRj00cj/OHH9WFRmcQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DXdFdSSrHTmf5mdA9a/CZSJXGWIXtw5cfHRG0vWaCJZ2OG0YUdP0kmxpveMerNDs
 X3c+f1HdhgIyeLvpt1LcZzbAGCNQ7kkPbqtKtVQBhXBOfP7H/B/jY4rPpM48WuKn9
 hw5qobfbsbiFdh+nccmkbJw+8rQ2Ps9gYbkDwoOfgZ+TF8yYtek/jPpQDJEHOdtMl
 SeeGt5fb0OjwSUl1TlQcmqIx0brinB9dnpEjocFCNvrfOmzMW25fALsDv51fDUBKD
 cHHweOAmQ0FgEDv2J5EXmp83eLLjhlyF+7KA9tWOsmoon82tbbMpFbAM7XIAat3Ko
 F8tlCSNrmBa5mGKgow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVen-1w2nFz0QaH-008BTT; Tue, 10
 Feb 2026 15:26:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:26 +0100
Subject: [PATCH v7 14/18] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-14-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AcfKULB/P6IpP4IVQ60eJlBQtPGydA/LbZj
 jdOmzAi5yKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WEenD/4zfcRgF0kvz26M0//xRrM1//4xAjd79QY2hdBqyVq9ai8wXa1s1R67J9q91s67xEWCeNY
 hQqBkesy4BKYmy3Hu51Eb6YxDaxAMNHpUgT/+bNeue6MVfkSYx0IXJurox5g9NKphcXku7Jff01
 C7JMvNRBW60js+HtaDKLt39neLO2AJUz0iCZHBGwJ2o+047SA1OhceoYtUeuZMzodQRGeXUgBfA
 jCmdygIZ8Na0pGIJqJipiP5pvbm5oz5qZ7xwLi9X/IOt7JXe4fYtbU0sZPJymSd7Mi/Gypsq38Y
 WNHbsdogHWf4AAtzMcIT47a+Yxjb3Zx0bx5HBy90sIXxbddl8406bP6pceznJNWerLCHadVAHPn
 2Ypjh3AGcVpFqLNOOzoPRdoOEviV56v1oAcNPvcgBfFQ0FnISTrTsl4syI46oRt4W2oMen2sMKU
 dtj0ue1lWi7IO4Qx0g8uukq+QsSJ746ghs5KSdPf1eKitCYdg53i6e1aHXB+jbMNGXiXL7UbFIj
 xFQFzVWcGvdh3sy8ss0MVwKbDRJJce89O+5De07T/KbBLe2SnqYUJvi/rjwD/uVzsPVO07AbaJ+
 lmd7h27D2hdleCzDWSqVwIdk5xyISPVA3Aamv2msmXQS/rR8cV1sbvSg6K0T2WhBCAv1l6NskaI
 tmRuKQNTa6e4NUQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:hpyB3tkimoqeqfm9ufqQytwFU0dmO/uiFbUUGuM1MtoQpuTzvuP
 kHA0ub57dBxxdInPzVYyonAzFrYLAmVjaBltpReXiKP/9NXJd4DLpmDnzd88YZeJIHdom8b
 qHlNHC10HrNPKrhGLOw44VQEVouJPS90tWbOLTcoC3xikel0F4wTPR9TVBnzuWKaB2POR6S
 WaUNjuDTCouCwk7+hKECA==
UI-OutboundReport: notjunk:1;M01:P0:TJGNfslGWpI=;Z/Za60Hjh9jWU2pbnQj2QEA2Ar5
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


