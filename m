Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1498C98329
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh701-0007ZO-3J; Sat, 17 Jan 2026 09:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zn-0007Vu-Nl
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zl-0002Z0-EB
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658975; x=1769263775; i=lukasstraub2@web.de;
 bh=sY5U6tkhVqUdCuq/PtEYepJ63eDBszrJPvN5TBPfsdM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZYcWS/bnAC89Tk8if8Rba3us6trv7e8pXDGdICRtJo+juECzF4XidEgw9NWeLUJH
 +yOdgLymYVwp+BJbTwwRiLvaa7SsHtj3HF5TJA4m/dEvbPrkpBlVGSBVWdgPIXnDs
 jDzey7RYsUw1EK4jpXFVLOLg61dHDXFC+KDFF/+3OrFWrvGzSHxm+vwfoJuYKU1Js
 aYQJOJQdzI4qsqfggrZ3Y4Wyvv3MIk1HmgyK09Rh9vaJYgrk8k1YtOdQZLiuRkHM+
 her2NEhYpK9tYjyjARffPY+kqWQXoIVtttUG7hC5lxsSYwZ65THBjv6JvMs3CRojf
 4a0Clfu481IXCdrzoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1vsblh2eA2-00r8QA; Sat, 17
 Jan 2026 15:09:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:12 +0100
Subject: [PATCH v2 5/8] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12402; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=97WW2FsFUoW7E0Z8lUFQmJQQp+dc0Wwh8C2s6P2aMDY=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gb2RALg3uJb+xMs7RZbV+CU7wnamdNTQ+Oh
 S7xmyVkuf2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WMq9D/sHwfh2L7KOOJY4ZPTgEAERUvF69Syq52NpZtIgQV6iXJ/VimRaB377QTkoa5oJbqGtCvq
 Kh3MoVWqvq8K2NRFY2ZOSh5qUc77klhIZV8svd7VTv3u1BKyLRcwZlB7XqHwh7vjAhzlLW75qTE
 7wGLooLmd83oM2rj5/ZoZQf5ZRA23mhgf9DXELyaCBmdsRake5T2QbGorxX1QqJX/XeNbVtEp9E
 tRhS9u1Z+9h3olegaXXv2eAkCF62alRQiRKx3eArNv25h3OwQAbc67POkyS9MYeeVfsyPW9xthR
 5clIp+ggr203HYnfxqFhd9/XTYi6KLpVXrSFpgyee2zjfdEXdOThLpLElBxvxylWtCfTFNmfhxg
 lGKsUTyAX/84J2GBKE1SzS19guCWWMxv1Bhq7TwQCclNyVyQMxTFFjCJdLOSTVytIt1NpRiajiv
 ulaXbhS5J+6+yl+i64wQ0RETWbv4cn4vzUaFhXMWXTEN0E5lVJelc0pFH2NPyhUdqkE6+o6ohFU
 dPXARDFkWeF1onM0rzm9dBzxestchOqL/jqW8OtMVHXcxt0tZlpKg2CzJaH5H+UCcZFMx9NxFkW
 gaw3N5t81fvldOG31E7LQ17P/C4UuLydnnVVwEJM9CSStFgO8Ra0UPTljTVmqjhqnOxGhEsXSpx
 m7Y8Ub71+xzMrZw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:2M0uyHlZQlPmJc2YlupLhtMSzrB5g2I6RwJDwAbuEjpOiaetA3p
 9TbmqJSccZ1lCru7r76Z1FIC8uDRXZXLkyyWAsgsurRPOblruTBHnwdJ+s+S7NPAYOrARVS
 Kffx2TgpUjEkpOukh2Kl/qiSABRrqwUaBRYZlvF3Es7/1LIRewf1zgrrQTKNFTj32wIjS2k
 ddQvpPhaqYA3uqBmu8ONw==
UI-OutboundReport: notjunk:1;M01:P0:gMb5PuJwo34=;fl7ZCe3XMm7jG2zF4pYU8bar2Nz
 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
 ySLfFSHEqkLPkcxTAn6/A9I3ghum8
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

COLO does not support q35 machine at this time.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                        |   1 +
 tests/qtest/meson.build            |   7 ++-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 113 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.c  |  87 +++++++++++++++++++++++++++-
 tests/qtest/migration/framework.h  |  10 ++++
 6 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dbb217255c2cf35dc0ce971c2021b130fac5469b..92ca20c9d4186a08519d15bfe8=
cbd583ab061a8b 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3840,6 +3840,7 @@ F: migration/colo*
 F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
+F: tests/qtest/migration/colo-tests.c
 F: docs/COLO-FT.txt
=20
 COLO Proxy
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0f053fb56de5806d3c213e3a26c0b19998ae151a..d0129af4431bb08a94a918a1e4=
0a8f657059d764 100644
=2D-- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -367,6 +367,11 @@ if gnutls.found()
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
@@ -378,7 +383,7 @@ qtests =3D {
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
index 0000000000000000000000000000000000000000..5004f581e4d9e4e6f54eee6d70=
a9307b7fd123be
=2D-- /dev/null
+++ b/tests/qtest/migration/colo-tests.c
@@ -0,0 +1,113 @@
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
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fra=
mework.c
index 57d3b9b7c5a269d31659971e308367bd916d28f6..fe34e7cc7a1a4eeb8d5219f547=
33bbd8446b0e4e 100644
=2D-- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char *u=
ri, MigrateStart *args)
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0)=
 {
         memory_size =3D "150M";
=20
-        if (g_str_equal(arch, "i386")) {
+        if (g_str_equal(arch, "i386") || args->force_pc_machine) {
             machine_alias =3D "pc";
         } else {
             machine_alias =3D "q35";
@@ -1066,6 +1066,91 @@ void *migrate_hook_start_precopy_tcp_multifd_common=
(QTestState *from,
     return NULL;
 }
=20
+int test_colo_common(MigrateCommon *args, bool failover_during_checkpoint=
,
+                     bool primary_failover)
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
+     * COLO currently does not work with Q35 machine
+     */
+    args->start.force_pc_machine =3D true;
+
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
+    wait_for_resume(to, &dst_state);
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
 QTestMigrationState *get_src(void)
 {
     return &src_state;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/fra=
mework.h
index 2ef0f57962605c9e3bc7b7de48e52351e5389138..75088c5fb098a0f95acb1e2358=
5d3b6e8307451e 100644
=2D-- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -139,6 +139,9 @@ typedef struct {
     /* Do not connect to target monitor and qtest sockets in qtest_init *=
/
     bool defer_target_connect;
=20
+    /* Use pc machine for x86_64 */
+    bool force_pc_machine;
+
     /*
      * Migration capabilities to be set in both source and
      * destination. For unilateral capabilities, use
@@ -248,6 +251,8 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args);
 int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
+int test_colo_common(MigrateCommon *args, bool failover_during_checkpoint=
,
+                     bool colo_primary_failover);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
                                                     const char *method);
@@ -267,5 +272,10 @@ void migration_test_add_file(MigrationTestEnv *env);
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


