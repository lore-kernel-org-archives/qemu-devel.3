Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F21E95A95
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaMU-000492-Im; Tue, 30 Dec 2025 09:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMS-00047Y-6X
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:08 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMN-0000fH-Qi
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1767103558; x=1767708358; i=lukasstraub2@web.de;
 bh=A76Ph+i1GoIhnzPNQjvIUIAIfgTWKwRNvs2FSVtG0xk=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=V+Yb/isICt9DxFfRrY9qvfUYCA08PUzWlqPXFPLfjnfYyapsXaPUSzbMDahzCYHe
 vZ6EK901L+i2Iyhc7h6FzX9r4ufIdR78dNWqh9+fUuNufBxjxLsnDsoe1YKcf8wII
 n9ZFESyNgulr4iuOkOdyjoKwhW6D+CvS4vDiCl0fBuI8CfdVY3RCidOh7dyZTMXtD
 GCzlRtaddhqOlTUEuNn2yRqABOqHyi1Wo/cgw/wR5HAlLV5Sgxbd/YrHLEkmSPeah
 dc69XcFXa9Tm7MSZ8N6lsLqFrtH/zGs8Bf1Mn0p+q/ZgI5eN31XnpkdDg6tGStruH
 sLOiaLqw/eWhEOT+Vw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.110.28]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1wEbx21Cty-00e40D; Tue, 30
 Dec 2025 15:05:58 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 30 Dec 2025 15:05:46 +0100
Subject: [PATCH 3/3] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251230-colo_unit_test_multifd-v1-3-f9734bc74c71@web.de>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
In-Reply-To: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10834; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=QEAmCgemvlKK2nsqj3U9UKnsQqF1qKJe1KOMusox+SI=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpU9xDK5JxjVW5w2qJO3wrSrv94+dBildorCsbz
 ZQ4xGZ4JqqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaVPcQwAKCRA1qwsonF2y
 WNTID/9h8KKod3PdEIVy98628Ws7cbltPXvppWZ4wtXq+VdqTEE3K96VVRJ+p9vxK7Tq0fdHYJ4
 rP4QNkoJchlyB557ZNIB1hPlL6kJ5i/M0fdpOKQRert+w3MFdObN3RGjNtpijIkztyaFak6GiGD
 6h5UDm9fvu8RYvYFS/i1PL9z3BM/7PQ1i14+LPdVxD+52S+xmv9LoJhJUAy2OgZtp/hQZdfpnmS
 o9GaZbmwXb8ckDEpBuGDLjV5vkTtk/h1qTfM1qSb2j6bDmmeHda2wxJkUS8duXyufCzsMLFtHCY
 EpWbxnf+vMq/leTT6folpG/x2NghDALHA/GUUvoINnr4zuUgGV5KGMvAgM3qtmmYFL6rsaZHFo2
 G2gRiAwPe8UbKhyIBAiFTUniJ2EkegQTgiwgJKrPon3Vio9IKIrUIBPLcRCDUbrlQCwm0Wy52+0
 cxP3IcxY9euWlmmvdjNJS+eCHLcVT9NzjOe31tZ8lmvgJS2k8Cx8oxb3jSaJANs3IhCeQcohiya
 wL6+EbOkyduCT3sqdEABQbkwDpTRC6UpAmbJLIwqDzbXaPjixquAaJptL9qUlKAGBf3Wr4iEa0h
 VOqH8cq4yN0bWHaqdLfP7Worxs3+V1VUD5XgVpRXfcgYjred2MtxJZJcZOWnOK3b/r8hQDbOFmn
 j8lanC/Nyll/a8Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:lU+aaT55dL9tHHgu1gSzQFH+OLe4TNavYdxVfzm5XaJJCHCCHOx
 KmO2jDka6V0aLXhQI9JnOxRvowS0pXdCpccW3D98bTS1PRYd3gwx/ZyL8V1wUI1vfxVjdtI
 E4lEfLeci/mhiOqAjxHJKdlyL4C3jrO0gfIihbQ3VhJUcwkrLZ7NYnn6ROT590IZ4L4P+hj
 HvTfqNmm7av6pmnghwlYA==
UI-OutboundReport: notjunk:1;M01:P0:HnODsnAbyoI=;qN2O3hPoAX7RcqqiDqz7a5nk94G
 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
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
List-Id: <qemu-devel.nongnu.org>
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
 tests/qtest/meson.build            |   7 ++-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 115 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.c  |  65 ++++++++++++++++++++-
 tests/qtest/migration/framework.h  |   9 +++
 5 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 08fba9695b9813dc0b6b6554ef8c40c9615918fa..e68ce6c193ce2a2c244fa072eb=
b24738380f844a 100644
=2D-- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -366,6 +366,11 @@ if gnutls.found()
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
@@ -377,7 +382,7 @@ qtests =3D {
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
index 0000000000000000000000000000000000000000..adec41c1c0473539d02e488b1d=
0baa663d7743b1
=2D-- /dev/null
+++ b/tests/qtest/migration/colo-tests.c
@@ -0,0 +1,115 @@
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
+static void test_colo_plain_primary_failover(char *name, MigrateCommon *a=
rgs)
+{
+    args->listen_uri =3D "tcp:127.0.0.1:0";
+    args->colo_primary_failover =3D true;
+
+    test_colo_common(args);
+}
+
+static void test_colo_plain_secondary_failover(char *name, MigrateCommon =
*args)
+{
+    args->listen_uri =3D "tcp:127.0.0.1:0";
+
+    test_colo_common(args);
+}
+
+static void *hook_start_multifd(QTestState *from, QTestState *to)
+{
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none"=
);
+}
+
+static void test_colo_multifd_primary_failover(char *name, MigrateCommon =
*args)
+{
+    args->listen_uri =3D "defer";
+    args->start_hook =3D hook_start_multifd;
+    args->colo_primary_failover =3D true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
+
+    test_colo_common(args);
+}
+
+static void test_colo_multifd_secondary_failover(char *name,
+                                                 MigrateCommon *args)
+{
+    args->listen_uri =3D "defer";
+    args->start_hook =3D hook_start_multifd;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
+
+    test_colo_common(args);
+}
+
+static void test_colo_plain_primary_failover_checkpoint(char *name,
+                                                        MigrateCommon *ar=
gs)
+{
+    args->colo_failover_during_checkpoint =3D true;
+    test_colo_plain_primary_failover(name, args);
+}
+
+static void test_colo_plain_secondary_failover_checkpoint(char *name,
+                                                          MigrateCommon *=
args)
+{
+    args->colo_failover_during_checkpoint =3D true;
+    test_colo_plain_secondary_failover(name, args);
+}
+
+static void test_colo_multifd_primary_failover_checkpoint(char *name,
+                                                          MigrateCommon *=
args)
+{
+    args->colo_failover_during_checkpoint =3D true;
+    test_colo_multifd_primary_failover(name, args);
+}
+
+static void test_colo_multifd_secondary_failover_checkpoint(char *name,
+                                                            MigrateCommon=
 *args)
+{
+    args->colo_failover_during_checkpoint =3D true;
+    test_colo_multifd_secondary_failover(name, args);
+}
+
+void migration_test_add_colo(MigrationTestEnv *env)
+{
+    migration_test_add("/migration/colo/plain/secondary_failover",
+                       test_colo_plain_secondary_failover);
+
+    migration_test_add("/migration/colo/multifd/secondary_failover",
+                       test_colo_multifd_secondary_failover);
+
+    if (!env->full_set) {
+        return;
+    }
+
+    migration_test_add("/migration/colo/plain/primary_failover",
+                       test_colo_plain_primary_failover);
+
+    migration_test_add("/migration/colo/multifd/primary_failover",
+                       test_colo_multifd_primary_failover);
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
index 8c1fc6e009f16dc05a47e917167f62e0250ca992..08bca49a8980f9988be9447acf=
54b17acd56da94 100644
=2D-- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char *u=
ri, MigrateStart *args)
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0)=
 {
         memory_size =3D "150M";
=20
-        if (g_str_equal(arch, "i386")) {
+        if (g_str_equal(arch, "i386") || args->is_colo) {
             machine_alias =3D "pc";
         } else {
             machine_alias =3D "q35";
@@ -1068,6 +1068,69 @@ void *migrate_hook_start_precopy_tcp_multifd_common=
(QTestState *from,
     return NULL;
 }
=20
+int test_colo_common(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    void *data_hook =3D NULL;
+
+    args->start.oob =3D true;
+    args->start.is_colo =3D true;
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
+    if (args->colo_failover_during_checkpoint) {
+        qtest_qmp_eventwait(to, "STOP");
+    }
+    if (args->colo_primary_failover) {
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
+    migrate_end(from, to, !args->colo_primary_failover);
+
+    return 0;
+}
+
 QTestMigrationState *get_src(void)
 {
     return &src_state;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/fra=
mework.h
index 2ea13e7758697550b5531737e66d6d939dd800d1..1da532569d8c5941c99d83ae7d=
a88ccab2bdcbe2 100644
=2D-- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -230,6 +230,9 @@ typedef struct {
      */
     bool live;
=20
+    bool colo_primary_failover;
+    bool colo_failover_during_checkpoint;
+
     /* Postcopy specific fields */
     void *postcopy_data;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
@@ -248,6 +251,7 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args);
 int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
+int test_colo_common(MigrateCommon *args);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
                                                     const char *method);
@@ -267,5 +271,10 @@ void migration_test_add_file(MigrationTestEnv *env);
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


