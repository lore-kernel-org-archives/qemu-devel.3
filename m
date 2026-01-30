Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06502E6BF05
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOd-0002QQ-3K; Fri, 30 Jan 2026 07:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOb-0001x3-42
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:41 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOY-0001rI-Pl
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775277; x=1770380077; i=lukasstraub2@web.de;
 bh=llBJhoFnON047XOSgFOUfZ92XzUGvGmbEAW3sALo0jA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HGojQGM8VugV0GbVaXeW2q5RMu+opavjPB/vvzDxkR/zaB89nYoUWe5KLm0PsD+H
 IH3N+F3UMhU7r7XTaKJUHeXu16Todrsn45LV1pfCXMAf2ul+jilkNDWHNJQiklpQ1
 bxnn3JHtHtCuWjmBj3ABj5ffLf/JRasPhuIAnB4j2nr/hA3H5/a7KW0qf4HhV9NzJ
 CflGrZwzWxJEZv8wKCAFnu9FxJWz4UD0C50UghoW0JSVTeAkUyxxB9g1aTu+xkQZU
 /rYQ9MIkLHfQ0XF7cwmZB6vBTQVysuhoZzE4nVjzgL81kpvjgUyGqwS9LBYIrVjvB
 nmlyB4KR4njhOGqmPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JEu-1vk9lX1bti-00BpVi; Fri, 30
 Jan 2026 13:14:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:20 +0100
Subject: [PATCH v4 12/16] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-12-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
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
 bh=dhovH8yt9zf17sqfHc93I3y6GjsRHwe8T5Wpa4AvGyg=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmaprjeCIR4YoK4tr/Zn5aoGmKzi5wgTEIR
 i8+exuPuRKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WBcQD/9Xc09/dCTlinqo1FJ35MdsOr4D9tzWuTah6eozhJufoskxXF9rp1k6khrJaaalOeK6Dxr
 2zNaVuZgHFNlv+Lx2y49ULWY826XWZcPziK7Vx0qbPZJSztvGB8oNmyGPT45L7XdHlSprb4byjY
 XGzRMPG6SGhZoQ1MTUktnqMwtNLoZ+Aigjm0WQirgdRXCaob+DM85a1E94LXSkG4Zkq5gBjXeAB
 XSzjFxlv+IhPE3v+s6RYUZevN27JLNUu7ukpYACxcfADXtDF2XqGcMt/Jvjp0uSkyRtYtZtz+ov
 VfoTj8rQa2J72BzOLokXPzTjQm7Wr+Yu+AncRKoJfVsxAz1ZUGvDyRGcwNkxrgX16gS//lcrIoa
 tXxZfejRGkYtMGTGX0TUKhsFzARNKMKfT8FWejIQqv6npsA0BaCViWD+ETAPtmXzD9x8FYmU5xt
 dNQ1t6NU8HUM5kotem50u5RWFNzRVRWFOqbgDs8Wib3xuxUK8LPam9v/lSF2WXwAbjaaK++WkNo
 oMs7WusLHF2HIMujZxV3LHgIjU3LaXKAQmQb5/ZenGrYD6Vm8BrO1tiUr9Oxm3/q+hVmpUqNpM3
 HqKY4gQwawPHk/HWe6ZayqoQz76HGFM7AjPwdxNZgmWff/yrWGNgYV2eMq4B+B+Yvv2jhS11TjU
 unNZ45HSuiat1lg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Q7GnWzDkkF/RuwsSC3SIwttoSuqFqr4gvKNlZEqH/GTZ54bg20x
 ERTqxy44GWcdpfepbqAZ0JMmgUNsfnx4pGZIip5SL6KKxVahK5nGgqTF29D9YfTvUwp3gLZ
 0pCVsQflelisEOm5KmIthXdQkiEWqnQBccaLtM7Td37PWhJZT8GaqXyOLtdb71QcCIiPSK8
 esWAUfPIdQR/niJeYnZ3A==
UI-OutboundReport: notjunk:1;M01:P0:vhdp3+Es0r0=;DKZdLeiT53tJJBJbCVSWW4iRfGn
 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
 aSWZ1UTaB5uO1mFc+giV
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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
index 900d6b9436670515162eba4aec6ee0f023c9a2fc..ceb3ecb1d955a267018c70429d=
e61e45abb7a7ba 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3853,6 +3853,7 @@ F: migration/colo*
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


