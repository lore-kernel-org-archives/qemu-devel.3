Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11668E83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSB-0007QX-JD; Tue, 03 Feb 2026 05:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS2-0007Co-2U
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRt-00028C-Ih
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113751; x=1770718551; i=lukasstraub2@web.de;
 bh=RH+Y2MgwD+ufRGhuuBMYu3Rw0v9kmr8I7sL/bsv0nR4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IRsS4eszZvbkpE/GmQncwidiMBu2SMKZ7OH803sGV+Rmxfzj8sV5FcWAUPDCwrDp
 ZIKAuThkUOBvM93wOPX08fTiWgeWpyC8qDevGEkIn8uHoeXb2ciXtUNnovu7hvf58
 nqnnJ0wF8mU1LlvMz/KwwCuR695jUyWTmiikHJTfiVjexMs5RUCJGW52QeWAtLU2Z
 QS4PAm+e446IIjbXq25QX50ZhE4yXOFtm/QBtPg1u0WvRs0LNOKTY+vHqLPtzR2Km
 nJ7iM1HKYitxcc60tOis8PL1x01Y66vzw0d0yhJk3z1M2RWighgAmEmWhni4UrmMn
 xtOcUmhZ8MnRs+/gDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1vyF0p02H2-002Vlu; Tue, 03
 Feb 2026 11:15:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:18 +0100
Subject: [PATCH v5 12/16] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-12-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10800; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=jj8yZP4mf8lsa3pBgK0Zqr2kVZh642wRONhIwtQcjrQ=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQoD9ahy4YTa3tbzO3TMFh7Z+t8DHtEeRGc
 L97IXb+fL6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WLygEACmIjfBL4Mo+FEyV4X1zYNq38bAAhJuPVjenVPtI9Hh6GY6rBk64WbwnxTvCdFYBFaiQ3r
 wMY9ONZc/4SkibgKuJ3z1LIFrGmoJYJQH0kPlNJb4H+nCg/NfgQ1KN+Ok3phzXlupKFSCEw8ujS
 qjqErZECkhvF9oGcGFow2thqh3tCrkb6KCm82O2BAdQSojFyWKxgry0HZum//vjlxrV0Iwhpa6B
 4YPAH760B1t0JaBNGWBbNtZwRlxnfbUW5YPqC8KfvzroqK1M1I1P6Yee3Y0CQdqnsRP5lxJG9TN
 eABqEs9/0KC01QCAGlZ19OiddghPaAk/bi9AdEoze+kYeLf9xGTCfDSfCNl7BD6p6Vw9MY24fQX
 x7Gw2MwHfb/7d0N52SPMILkZFuOGK1ShOxzJ7lVnQ37BppBwg4XfOD+Tss7sLQd1VZ7gk5HOpTU
 essGCvnb1rDQJX2QN6o2WQGFAKF5rnYELywryZDTkT2VeLxTiShtBTTVEN2XPPzq5l5HFHNSGnx
 rH5GTKCupabK9dtMXp4KHn54gRJ/O0jR2UDM1lLsiGlKmNy5Ge+3mP51ZpWatuacNbA0LNR20R7
 p1HlyzazDu/i2sOzYW/yOzNqrgFdFjcrNPVZakAhsNcNRZqsW0V1wtuME4wsPYgiuNetewfr/bf
 ezAvFWapyPaAPrg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ca6WZauAEjxWdu3WGum+JeQ4M/IzXrmINRdvAgyrH6Qc32I9raN
 d8TcVkUxZhp8RwO5pKAFj/e5m5XM5cTQJLB7BhO4s4dscgJQccLXODwmnMCCkdkjIVUMNtp
 eAB+L5MhY+viG4tUqEx3VsArTdmAUyeMj1mtx+QqFWt6AoMbzRg9fSqAJRH3GYPWYhwy9/n
 lwfW4ZE2Gnp0IeGzhuzxQ==
UI-OutboundReport: notjunk:1;M01:P0:QkcDQHEiR4Q=;OgspJlvTLDXUd272SM6f6YGXNen
 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
 NuLAYzx8+AMiqlImZP4B
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                        |   1 +
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 206 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.h  |   5 +
 5 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e8b9cae59a1768ad9966d1291bd358a0712573..8e63e0a08fc7417036986f27c2=
d910eb99d8a96a 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3854,6 +3854,7 @@ F: migration/colo*
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
index 0000000000000000000000000000000000000000..e64b7aadabf24ff87046988eb7=
5dd34a7d3e34d8
=2D-- /dev/null
+++ b/tests/qtest/migration/colo-tests.c
@@ -0,0 +1,206 @@
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
+    /*
+     * COLO crashes with TCG accelerator.
+     */
+    if (!env->has_kvm) {
+        g_test_skip("COLO requires KVM accelerator");
+        return;
+    }
+
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


