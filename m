Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4595FFD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmI9-0001Ro-1X; Sun, 01 Mar 2026 14:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHs-0001AY-Bs
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:08 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHm-0003XH-Ss
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392613; x=1772997413; i=lukasstraub2@web.de;
 bh=HxiDYFgacPvgSqtV2BRTOBlRJCdeGvyIqxMJefcSLYA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EXxvL0Wl/HwMUh+OZe6O52JkXiBteyh3519CiQ8VPCcV7qxC7mAw1GCYtpyR2GPj
 KseaHFZH1oxv+S348dger7fGTkCBE32yE6s59D6gu/tas4UphCViM/fj6gaCQbtKb
 1ZF4VDIbtWEnO0l+IQaG6HS4srabTD+D5C88qExMePdP83THN/B157CZs6BwyTJYc
 7vEPQ0ERQoJ7L/WRolj8nD+Tv3L9Jn7OIW7bGOKDwOQMfEKO6vCtqLtXeIOk1bMsd
 QDMrmZBg9pGKzNLi9JUqcu2W3KGrx8FPByELY96TnZYm9kh72PIlKWQQuIrk78bA4
 6P3hpAx1EEm5z9pG1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1ve0wb0Uom-00wejW; Sun, 01
 Mar 2026 20:16:53 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:38 +0100
Subject: [PATCH v11 13/21] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-13-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCd2xEhEbgoOI5wr5OgsHvb73k1dQOXoBfHo
 NbadZdLIfeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WPKmD/96h8PbbvGOicMLdeaK1aBmC/YPLw85zcLR/vjzkkuQPiVt0rclss/lDlNlE5A1DQW6W0k
 LSNVZydYcHRvwCEOp4jpcUTiOafVMy+wFomcyTknITpFJN0NZMEu9+WxRFG8blHfYppA4WYeQcM
 YgShZG1ddqtkNLCRiqsw+jQ/ulhPXAR3dgtTSAZdC9hbT0gw5nyVaMAnzhGfBE26lTLH/HN4uWQ
 WiputOLfVc95ZAlMVbQ1UFuyzo/zhK1x/d/p6fYGT/kg3tEr6fxfwu1ta0A9Oc+lp+j7brzFOOy
 W9YpjSFIt7Umctv744i9g9GRKe3mBv61vx51gayze/Vt5Z1hqThCoIIaPzpIUT18GH7QG4nijht
 wvTu3FR8yd/dSmpLb5EBobv/7B2fDPCtZ6INzWv0hWjthYnEQSxUBMxfGDt5/fX5Cgq6758Xtdv
 WbxjGCwr1uViJPrPLp+gKNDLbT1qFx2sMe44OsUmsiwoC97W9qx73SBUrzynXIhzvLadyImUFNR
 z1OSj0ZTmSiwWd34K8hFicO771hxKgDDGvkxqz6EikFaC8AH2rfdC2hi0X50rXPeBNVRaWGO2g2
 kDWriWmqPop3hxxNa7JxL6Dd/KrGLqXWNPfJCJxboY4QmC9HQdDPYatwaUlF3wOMEUrvlflPbKd
 uIYSY7Kc2aszPuQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ztLtmETyoyJ9QLMtvfgh3owT0zUncSOj+Mljph0vpXeSEO1wzG0
 31zn2PLZHkGbcxSuMnRhsJIE07wgvKutNeSSqDYwh1KveOsg/xb4p4P3TVCso4oy1Wl3uQL
 /VP+l4EKj1ev3BjcXWdaeflTSXV6TkF2OwPZqIF7h+H72Sh+Tb6ZQrUMr951mUeYIOAxBY/
 DiqS0/KLiZsUygitWZjMQ==
UI-OutboundReport: notjunk:1;M01:P0:GvHvz9qWvgc=;5vkUXYgeKEFtOcdZAmnG1hghQ26
 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
 4zimhUn7LhRyXpsBmwszPBOMQcuNm
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


