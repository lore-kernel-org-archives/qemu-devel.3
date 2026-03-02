Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B5E9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hw-00055n-DP; Mon, 02 Mar 2026 05:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HX-0004tb-I2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062X-RV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=HxiDYFgacPvgSqtV2BRTOBlRJCdeGvyIqxMJefcSLYA=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Q54tAosD9CcPP2JXCl8kAiIHK3NrmvrtcTdCnw7JI2GYyx2ui3a2QEJjEI7ZBxds
 y3+MjljEwHs7fdtKOm8BAoBT8tLX1IpwoEEpbDvwQbIVt4+BQh4EyczzTfpJshbJ2
 3Xp7xRRtPxbaKt+2Ty95CaqczjTWgflzCRT6iZq4OxsUAYVr56tgsgHwocPHyVYWo
 m4Y1KaC9mjnK2s5u15EsZOTRxsjcPmkELU9B1hQkBQQ/kTyowBD80xQ+Q7GLry4al
 fue0RZlvnrv0jrRCjmRV7X3+0FSxUqT+j0SrN3WUQMedNbF/iAfPi27dt+Jh1YKTz
 2qeE77qRLfRuo1Shdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdLK-1wFe7f27Po-00Pmbi for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Date: Mon,  2 Mar 2026 11:13:24 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-13-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=VhVWaFr02/WFdhcd119EsGPo60ArzchyNKMe18f0Kks=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFgMJIn7bDdJPs+oc8yDcHTbbXme9VqYk/B
 MdwOWYVUy+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WBgBD/4vQA/VW+bzeaUqMWW4PvYjBWTnwQNSyOLhiXlAeJim9ajNNJXhVwEJyLkt+prb1figdVG
 Rr0BlM+EbqOjdEmhlLU7pmqgaX7EPhN7ULy4o9kLyyIMazSvYYXpSJHKLYW8S/8l1zLXfVIqYNO
 LKje4bAVZHP3W0+MRIy7InI+FXfnIHUPSWmNWLrfWzzpRvd4DwqdgSaUiOIfEv7GkxeR6hY5Gal
 1iaJ50DWR/O98PmLz6sDzGfW4/hy+z1ly8ZPBOKbTyNI/RzeBGN1NK6vMrMbeYmju1z/830NZf7
 VMC39GuMnuzuMBQDcK+0rzPoK9nZWoUBj2fzj0DCcNAJfbTF5mDYyQaQ9eizS2JzRaNlULY5mNR
 nwbUq+2sZFDN51zPsDu8s1hy4uPK9VaTAkUh2Bg6OwX3VHPQeEYIZtqjxVefy5z1wxexTjyBBsL
 KoL7W2G1bQOWEvrZzuiOxEzfPBX2IRtn3hEwU2eGJumZKgLIe40ep1hBPDcU1cEAsa6d130nkYH
 l/pGF0Bgy/SA0j+x+To8ASUJrzFA22TRtBAbnpRPCDVfdEIxs6hj7FApT68VstuZtyH3+FwGqc5
 QC43vhh2xAbpGE+d1wJXyQuq8THc3r85b9CAmMnlW/9q4ve37Ak5MJFeG1QtsHcOdRPPu5JgRSH
 SA9AgSMqdgKy1SQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Mxx7RqjGpK9jTyCqsu8PoXWh9MYOCfMcEKU8F+JQhoVX/TXBVp
 lW3Vw7WjaXIzHmV7HSblDy/3TG0c7DKvddJ6Aaael938zaXATFuvdBefpNPulMquZJp3yBH
 lemVBjdQfkRYeBoyX5jRVk9oAS5BvUtG1wkxPbq5T8/6kTfJ/eZG44BHWquwEIaEm7f10m8
 SlA5mkJdKhwviI+0g4fPw==
UI-OutboundReport: notjunk:1;M01:P0:p5UGxCGIdq0=;8ppT1+JiMY8VfPcFDPLtpejOHsC
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


