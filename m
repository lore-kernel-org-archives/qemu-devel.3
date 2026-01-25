Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52AD72369
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6uq-0007Ab-7b; Sun, 25 Jan 2026 15:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6un-00079S-Vp
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:58 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ul-0006E7-Vj
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373643; x=1769978443; i=lukasstraub2@web.de;
 bh=01CcrAFGfBqse/z0OudZxVv0Ve7zwFAcaH+poEHtbSo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XQgLhcj3AZN4tCsdiP7nydF3en4lOggIevtUHFc/1+e/odNgyqYcFRQlFalk3vZ8
 jdIbl43xCn2vVw+YxsKFrEf4+MZdNz+ZB/gkqkc55/DAJ0eI3aJmazrpOw1SroWRj
 nNh0d+sUwuRQgZ4xhUfD97MDkn2JJLqRdxGU+pFBj4O4jz0I4t1ngEk1dWNSF5W7M
 USj19VqjwM+yKsJUMbTJivSFMW8cFFDMKEx9rpe8ePLMeuM/Keaat/avpvG1tEq8x
 7UHmSHRUtQEjCScN9pQbM2yh4HptJT1r544OlgKqZZLJp/kDIKR20KU5U79lcLveU
 mLzxXP5nV4ptEhfjEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1vfh4F2aAa-00DVB2; Sun, 25
 Jan 2026 21:40:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:11 +0100
Subject: [PATCH v3 06/10] migration-test: Add COLO migration unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10523; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=xlNofuIt0xRZiXUiQCZ0X6/8WuKwBOF8U9/GK22VqXI=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/F6bmcoCTnFluvfFqmN5kgSAV0/2EAPEn6M
 JD4h/mtvHSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WCnlD/9AAlLCZit7JYQAOc0FdJmte2HnOkwiXsOifxkmBpVazvlRNIiXqIVK16GNsHSRpNEum1g
 +OncSGrsTNVLllCDCFzkF7SqSED+DYTbiV35VzNMiaAoq20iPNRsDIs57VShyMdQ4Ul4BYC7dIj
 SrC3gO4TOXlpAF9T5QVRkvcaNMHa5gE5zmHOK0QKbPgHbvFQ78Hmb4R01EYployKjB7yKzH21+v
 cHR+5UY1VtksCKbjWb+++blcp81pz4z1xfhb5XKb45z4TBISCCO0UJaHqE18SNq0ugnMjqg5hYY
 wovHNBvcSHUGRDqMEXmi/fjAKk0XeYZM6BAo1lszuROwyfuJeiimABwGSMJlMM4H/HVxVDtyRdx
 zjnI092zNevuIBet/L2hdmHPeNnVzu/ruF3ayu8AJP0rZ6z1sPXzzoZE3z1hMzQYSFYcRHrWbUR
 udR8zGDbiumPcu1x93udqKhDVZaD4HTWAMjr4qW6ATjdnxW5t2zqjopCg1xqOPIIGeOZnZzYc+l
 BRjbtcOXMD6GFaFZ1K2C2I/QyoFt1m/hrA34NuN+IdgoFjpJF9twXOfFJh1N7urTpcyrSMHJpd7
 /MFKUc0zKsHouLxddgvD1ML8dcVLHCderfRbVGXUd4Snn051SeJowmWCTPj3N4UplFDwh0Yh7Zg
 dLlXIubmm+YgrAQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:N4oVqgoTWY1nXbGl3z31gENPWOx+mmMHapHQ76ZyP7C4wvm0pCr
 8bknjysTM01Q8lHkWeB4K8KEGmB0vxFsiNOURC4Zo26jYYOm1Dasml8vRT2nTsgMFGzltOo
 mVHH8Lw1lbRtCrAbmToGxXVm2kq4PKh5jeGbpPnbOnMPs7wAk157ajb9maBHW2cnJbe4joX
 83Z7omOxfo2MTP3TRAaLA==
UI-OutboundReport: notjunk:1;M01:P0:94bCvwT1EPU=;WOQkhUngtmPusUu3qSMha2B5n6j
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                        |   1 +
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.h  |   5 +
 5 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 883f0a8f4eb92d0bf0f89fcab4674ccc4aed1cc1..2a8b9b2d051883c1b7adce9c1a=
fec80d16a317f8 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3856,6 +3856,7 @@ F: migration/colo*
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
index 0000000000000000000000000000000000000000..0586970e206f01ed6e7aa34293=
21aefc1de7be37
=2D-- /dev/null
+++ b/tests/qtest/migration/colo-tests.c
@@ -0,0 +1,199 @@
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


