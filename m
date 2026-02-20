Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFFDC5AE49
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXq-0000XD-QD; Fri, 20 Feb 2026 14:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXh-0000US-3m
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:01 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXe-0001SE-Pi
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617111; x=1772221911; i=lukasstraub2@web.de;
 bh=yDiaSK9OpxS8V2pxAHSs+oO9Yxg0bwU7fddiiz7QY1k=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VjzwZoRmpVFwmiF6VGCexafMNgjwiZ+sGVty9wcFgBoB8/N6e+AjiO58nKyiIpX3
 NnG9m5FdEMG7mqWnR0SEuWFr6Hq6L9T0SHDXb3sUWwnbdUD6p8y4KLE5g2cpYKSw9
 vAGgC8Wp1I1Fdff+4ZGHwzdag5lM+uMFHewtNuDA3E4iQIrlqGF7o8r+cS/Cf4PIu
 IKV/v4/HsmBNzUXGf8Hkr5UlgFSekyyt95oIE1OdMSyGVFmnxnpqorFc2Bymc4PX/
 bw8Ap43cZrnRMkYQ8AyLtQNMeSJ1CSZKdeg1KMaN3eGNG7C7ADvHF4UjWqq1EsHch
 LNdYusmIQff7zSeooQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1vXRJO3Txg-00zMim; Fri, 20
 Feb 2026 20:51:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:35 +0100
Subject: [PATCH v10 13/19] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-13-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
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
 bh=825HURWaTdxx68arWBum9/F1NbVpsOOl8RFvbUAzHSM=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOKnapJZ1ZilIcbokws85cTA3OunKZSmDTX
 BEj3jCGPfaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WNgKD/99KIP3xjEO9w6k3r1w/WcHi6vmRJm7NdYRlY3fM4k27y6KW4UGEbJoxpksMyyho15yAAl
 XA/QNEZY5pniPoyapZfZThXH2MHE/3sVfr214IObNtvnu6ixuI1YkJr5iJxUuxqXYl2J6daQGzv
 7ihGm+h2q3Y6cCTnaU5f/ugk88GMn7HK3uzs6/LX9Nh5X/7OQdexrDns4z3KpPYJGXTInn2eo3R
 N9Safd2UJ6uN+i1ekzvknziJCU0zhVQ2pR7uUpu+/ULzHdN17Sf9c9kydvddpYknfgeb+HD37Z2
 1EoZxWEZA8mv9UDBUA34+mbdhJ6nLIsqtOkQg4TNCMbU+Yr7JhiZhikPdFrcX4UepUuAk3vTmYh
 pKiB4CXDvI4Meh3EUVxO3c7g4x3KLEXcvD1aVksAQfznSEx87lQNBs1PsY3UGjjcKImiK9YSaPH
 I7cp7iUs+KeJrBXX0i2/Bh/VVR0/7DCHVqydB4/Zlmh27G+UqxNO8+pbmhmbSyYEQLzbWnkmkD2
 Ji5SeeQ/ILxAfJrU6ObTvbS/sx7x7BLEj60KU2bMNlMQjOhAEy/O0Adn44NvtWHUM/jvhKqpA83
 aTdYi0aiyhjAp5eJoqOBEg0TYyU0ZuQM7K5RySxRwtSJej5InAU4UE3p4FxLTWkBhV/M1PWC3Z7
 Rd9+APwcoBF9zig==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:qQCO7YyrEIxhcQhyBk/xAGYDeqhFThLpsNqwRXeHG8uw3vCUAg9
 ThcaW4e7eXVyYq/nTi4zZeJGnqlqCiCAtg6pzCe3C3NeJRjoMqBG6IdebHiyoyC5d9mV/ig
 ++1xBqfQGCch7aR7qmOjFyJQuN+XKP6c8jIE4Uxuw9HrJTCIlCgqow2nWvE2rA8/gidLXlT
 HiFPRkSmCl6tumbNIjcXQ==
UI-OutboundReport: notjunk:1;M01:P0:rm1BfbPqSLg=;iwqECQhwqgHpirXK7sTz0y0GqCL
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 5519ea4e163229a9bbc06318a0ee06d88ba6a8a1..a587a9233ac556a420f8784c4e=
3217e5c5b99f34 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3871,6 +3871,7 @@ F: migration/colo*
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


