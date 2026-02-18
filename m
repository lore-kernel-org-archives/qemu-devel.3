Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F30AE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7W-0007Eq-EX; Wed, 18 Feb 2026 16:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7L-000797-RB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:56 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7H-0007Nw-7M
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450181; x=1772054981; i=lukasstraub2@web.de;
 bh=yDiaSK9OpxS8V2pxAHSs+oO9Yxg0bwU7fddiiz7QY1k=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Gfo5EhGZVAILfzQOd0zwJ3ZaqBMcT49j9+/glmOU4tP9kaczyn+Ankwb4jMMwx4m
 gwGzglt6Yh7F7hYiCdHlsiUM/thChQNR89LbpmhFUJQc9eiWdYTonlbOMmrZl7PDv
 XYmfKNbxSkT6N/Y2stxd1DzpZ/O1h5ACnkgF9c5Qn3oOL92/EBwJsZL2ZNX9/aNyG
 butvIYNnp5kfFw6jU5zstOBnb6IG6vTi6kd7YI9yVFSW5CEuwUXYZaXNOi9wkWD3R
 08tAbwPLdbiFFt05BIhh9H+6z4esHa11OinqbMwuAE/HUNfZSSAepL6/YeJ7kYKOt
 w8RpIJT7blcg+cmScA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1vPEXR1MA0-00nIIR; Wed, 18
 Feb 2026 22:29:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:33 +0100
Subject: [PATCH v9 13/19] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-13-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli893tf0jIN1S6F0L+fZz+duMCdcItYCam4f6
 HAXDRzjizOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WDI/D/0YVWuN8VMS+bZscTgjPRv7oc70GwdfyJ6axmvzLQOAaB59GlbNGEIvyGNwCewQHSJpHK1
 c3Jmd60WxFEOMZo+k44wgY9Cb/X7vTrZkwJnIdPn0p2bpu/dErVi4vyxNttWPXQpPsLTNDLTpjn
 xrgzzd7ZYKvii4pAJLNVuaM42PXUgDPn/vZblvZatLwH2PdwyNuAdwksmOlMMvHOfrly2OQa7XY
 o8w5qjpoAAibWQmiwgaca3FC4ydBRRqnlldLjg5qlzWFA6ZGAkw86WoF60LcZ+oGRQV1awm7YHM
 PGsG66KPWEmcJ/M/FO0/F0tkICcZDFaD7s1ZSU1O3RMwWJw3ARC8V8cnefj78Wn4ireyB28YvOe
 dsZE/st4e4d5Zpkksn8QVH+699lEujxBHi48ZYPZ0zq4CSjD8fVVjyCVpXCHqbCGd4LEDQydVUM
 FUxIs5Bn/mflkk+x3qcPz2S45He1zrcJGEWSiOmuqz/Oc9ayzZp134K4pjdaV5X9Ft39zJjVPn+
 FhuxkNFBVqPUEXS1CGJDfGui/ZH0EN8Vl/fDrXz24DhGPKOfPP1QLjBXjeZjSn3MSBwpEIxkah5
 +wWJZuXv0sP2VChhKufANvFXF88UKpbHvIIy7tF4UgKNO+ixavPXeWIA1CXJ7yLpd+Pux6DHbTK
 Bjdx+jEjueRWM1w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:D2PWOogeSI/G41xhbpI8zc5OZ/sYJH6yFmzD/rLj2lPD95/TlKK
 jsDMOhZg0mDNBB7g+wTQR9y73+xbHu33PBwUxD54PA4mjUhUVky/vgJWcgsPOnlwL5wHrFF
 AjExoZYon6d4JnMaM7pP8U9Rml4TJC/7jFPQCjegMnwntZFCFDAFLnPhKOOZ5gqy3h+xmRa
 7lAJaW25lwWuTKh4uvUIg==
UI-OutboundReport: notjunk:1;M01:P0:Qku4Qpve0JI=;q47It8I5hlvyOIW5dQmEqYUHnHG
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


