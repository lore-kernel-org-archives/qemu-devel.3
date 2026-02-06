Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446EEE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3g-0004O4-8J; Fri, 06 Feb 2026 15:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3M-0004Fy-AX
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:46 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008Oi-QC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408207; x=1771013007; i=lukasstraub2@web.de;
 bh=NPRScifiTgK3qkFDsRha4RlRArQuLKMT7x2FOENuMxA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lWy24Jn1FPR88+Ll24JAIb3O4tzB8KwQmbi88D5M+kZR+msEIxXb0czkfRBkTRAJ
 jZUGUVscdnEVkzxcHV4JNCECnb5uJ5ra7rE+6Fdk1ZhMnWb9LrKpB4cJPBPObMNHa
 6oW4teaDdUayA7LDJo6ptJXMyRj8PgbuSm3/SVkN2ft+iRWoXQMT6M3Iklz0k0lYA
 ATmEM2sUMl9kuy97cCpehDt/ZhGRjqvgtDKsA9XQp35hB5msoHZ3oyHr+iu/2lzio
 2CZI/8oun9w5aKoULPKosCcuMEHasFaUh8FDBm3NZYz6HtOTMvuzrRSRo9Pmel40S
 iwfW5qKgvkUNUAZSYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1vzCcu1u5T-00Ajjl; Fri, 06
 Feb 2026 21:03:27 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:12 +0100
Subject: [PATCH v6 14/18] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-14-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10625; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=HDldps4OP7KhV57NbTGLFlMs9pbZfQwO+rWwU50owsg=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGQ7eMAZqU+1yk+NW9tH1vFeAMwDjIPs7w2
 sp9pGyOfRWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WP4mEACkySRHuYtXPmBqGhWt6oRFKfoUW+WmUYuAkpkzaBlwrksrlROuDxkKXaUClgeu8JYniMh
 IepqwkGX+6/9M8xTM2R0gpUr/Ze6tl8eXmZL/LMsZW2GLOrbVlaRHaAO/qF0iJdbo7YWVnimxwC
 HJ024q4bn2ZsTzLBkylxuhf/PKPC2Ya/OYOOAh3rjEy6f+gSkWykwVdmzXw84FlE0IEoWqCSrXB
 9Kge1wnLPdPI8zLv2loaasX8Tzk2PaxJWS/qOaVZ1pEDgs+tTPhdPNlJgnDXazOocoO/tFD3hH3
 iQMVXFSGZkHJu6w1YumTi0pb1zYp8H5+xuZYJ4RMIBD6AxQsDMujCuwtsLHC0ICFms5aOPj9Ofk
 FhGDC1baFHfEIt40lAHkVoRppoZgge7KDtCcX9WyUX1GJAieVCqNvWmt9heOcmgHPke0Zb9Wtxe
 pbfSSFbD84/dopIQOaPVilVoegF0oUU84miM4HNbe7PBBoKqlS9KzeC0DfScSShIW8FAA2HE0W/
 z9mnI1HnsV8jNlg8rHaTcwOY5GALaz4qIrLFpxa+hx11MIlKsIzdo4gVv5TF7SNq6dWNbn0A8nQ
 MEXdIm3K1aLK2sJC4ho6fshk9+2yVvOhE4qmLX+egAriek4WiGX1wQBTzhmK8GDA0NdUdwKCwLU
 6f9nPDeMk7DnjUg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:i97WwHSPSBQsJ++/fs4KbFUR2LEm88mU25OawOzOQ1ZwQKrK+vb
 FJzNX0PTORjeHeHf3MpPJqiWMo+7hYzijWzdKeierZ2PjLsMxIlWIwpm7lDjh0PqnvT+vTK
 V1GtVFSxrXNxqhIg56cnlAcVuXgrx5C2em+HOIyJICJEb56Y8oFVEgnpSfCpaENH5pqt2Za
 A/GBidbAlOXZTfmGNuorQ==
UI-OutboundReport: notjunk:1;M01:P0:YrH2Ty2sSkg=;ZTBqLSgQhg+UQvrxi/9XaxefQcw
 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
 8ilUbO4bf/2X0/ylsRffqKPi7/hUy
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


