Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202DAE9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1jC-000139-0l; Mon, 02 Mar 2026 06:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1id-00006r-Lg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:51 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ib-0006Cx-Pf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451942; x=1773056742; i=lukasstraub2@web.de;
 bh=ITqpwwsSvHY6NBo/kS+QmQ39G/KVmJBMgSxNnkvOzu4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wVjMc5YI6eJxRYXxCtH3fVyVJ4cuWX5WgGisFV1pL/hfEL30t5LFxt990FTimb1E
 uIWy5Ens9/OayLehMv/0sUzKprdvQ0zccVyyyAIX612KPlEwKMWyoO3i3vRw9PIax
 gxsPz2OMwpbiCBGeF65GJjxM9VvcC9OelbATit6EkeijfNPbfuhczzsDv0oqOQBLX
 ltdHJv3UX4fPc9N+XwbplrXenhPFAtN76f8/4bhJf/l5GKfmEKEg4pYF9NrznwVK2
 JYWz539fp0nMbclO1JjtNlO5TmUBVqauX/yR5bDM7c1EqojV0e9FEyhh6VBMImrBr
 Er2VCC0sh14O2RTnAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1vdEkA2EzA-012C8U; Mon, 02
 Mar 2026 12:45:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 21/21] colo: Reuse the return path from migration on
 primary and secondary side
Date: Mon,  2 Mar 2026 12:45:36 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-21-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7407; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xW8DcPv/c60MIhaTk/f+XYB6rFvpT/HXqTmPuiv92Mk=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6VIrBfG7LpEGf+SAUGAmrzzBf7zgFKa/cUt
 M6m2SC1p/aJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulQAKCRA1qwsonF2y
 WDK/EACAICAwrPB7bGGOCR5Ja+v+bhMANmaepVg6IIZa664E+xFbtmK3nO1b1r/C4LAFLns562b
 63r5LJNDJbctJT88P1FUOPAsbNljidAQ8EBdeq8lh/vaoC7ib8rmeDplhySE/nJOoCdUph6QbaU
 UmdmkU3HgIaEOzW2QhZcyM2c0jjTnXIdrokb8e0iUF+WAisgpd4T2BFm9Ax2mpKyV/MKWTq1nlI
 wZwz2Ji7wQGi8s5qihzrnr9491QednVCh7q/PUJqUUhrgkLgLm/Ziam9gIkoFUyKEdhQlY6hEiO
 KdjeWyAJfz+iylBAgcmIbVnqMO2irZzEwci+6bdePISSoB4u1Bi9Bo4znT8byK9dABMGSK34akN
 6/HDeIpIeV/PzCrisVe09uYbPF0RHdpIWx3oeWl/ZnXaC1xDcqJvVuNYBf0syyzg7HJoSeIP3BA
 ivcnHE9PcSpCH9ScABepmvpogfkt48OCAMjMLniKDDXRiE+U1sb1Ny0nvnUvBa6Oly//NAj1Vwa
 42SCKYzbfXTulQcVXVXHqIFF06L8s3LVT2TdHcNodSP6FnoLrOXfdn5GvRAf4llOxz1Pim9GeOn
 hjrMPuXy8bnBi0/muego5eJ1xrP6bFiYDl9+ep9ytNshb6jQ8FREdxHk5KkWjCHeQk4mrBfq/Co
 p9gokIRSGbQRM9g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ddC/OlYtxDD8dXCATvBdqapc76U0kEtJqxdsyhJEAkhhDGCd8cg
 PM2fvG30vnktjfoBfe9eMZbjw8gjr3AGGfbdDeSodBcvjZwJx0P5r/oiu+wQnVBeGhhUosG
 ByKnhEuZ/dJYNXJs2Vql86020Gyb/7R4CcSj2xMwE505uvcO0V+SF3HrTlI7CLGKdZ7qqcm
 c9S5udowXUDxBsnupRpcA==
UI-OutboundReport: notjunk:1;M01:P0:1qDYW5phugk=;e1A4rHX2uMcjbO44NxyrAqiB/tM
 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
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

Use the return-path capability with colo and reuse the opened return path
file on both primary and secondary side.

This fixes a crash in colo where migration_cancel() races with colo closin=
g
s->rp_state.from_dst_file.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst          |  4 ++--
 migration/colo.c                   | 26 +++++++++-----------------
 migration/options.c                | 10 +++++++++-
 tests/qtest/migration/colo-tests.c |  1 +
 tests/qtest/migration/framework.c  | 13 +++++++++++++
 5 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index f7d3b6439cf3401a58c412634239d1a43999a10e..9ec3eb79b006a24e0d3a360f1c=
8f49a68f4d8086 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -225,7 +225,7 @@ any IP's here, except for the ``$primary_ip`` variable=
::
 **3.** On Secondary VM's QEMU monitor, issue command::
=20
     {"execute":"qmp_capabilities"}
-    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "return-path", "state": true }, {"capability": "x-colo",=
 "state": true } ] } }
     {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet"=
, "data": {"host": "0.0.0.0", "port": "9999"} } } }
     {"execute": "nbd-server-add", "arguments": {"device": "parent0", "wri=
table": true } }
=20
@@ -242,7 +242,7 @@ Note:
     {"execute":"qmp_capabilities"}
     {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
     {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "nbd0" } }
-    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "return-path", "state": true }, {"capability": "x-colo",=
 "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
=20
 Note:
diff --git a/migration/colo.c b/migration/colo.c
index dc47d03874039b686d2a4072ac4e6c77e4ff1f87..2d36f933cf155c108456516229=
4a61d32e28fe86 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -539,6 +539,8 @@ static void colo_process_checkpoint(MigrationState *s)
     Error *local_err =3D NULL;
     int ret;
=20
+    assert(s->rp_state.from_dst_file);
+    assert(!s->rp_state.rp_thread_created);
     if (get_colo_mode() !=3D COLO_MODE_PRIMARY) {
         error_report("COLO mode must be COLO_MODE_PRIMARY");
         return;
@@ -546,12 +548,6 @@ static void colo_process_checkpoint(MigrationState *s=
)
=20
     failover_init_state();
=20
-    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_fil=
e);
-    if (!s->rp_state.from_dst_file) {
-        error_report("Open QEMUFile from_dst_file failed");
-        goto out;
-    }
-
     packets_compare_notifier.notify =3D colo_compare_notify_checkpoint;
     colo_compare_register_notifier(&packets_compare_notifier);
=20
@@ -636,16 +632,6 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_free(s->colo_delay_timer);
     qemu_event_destroy(&s->colo_checkpoint_event);
-
-    /*
-     * Must be called after failover BH is completed,
-     * Or the failover BH may shutdown the wrong fd that
-     * re-used by other threads after we release here.
-     */
-    if (s->rp_state.from_dst_file) {
-        qemu_fclose(s->rp_state.from_dst_file);
-        s->rp_state.from_dst_file =3D NULL;
-    }
 }
=20
 void migrate_start_colo_process(MigrationState *s)
@@ -838,6 +824,7 @@ static void *colo_process_incoming_thread(void *opaque=
)
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
=20
+    assert(mis->to_src_file);
     if (get_colo_mode() !=3D COLO_MODE_SECONDARY) {
         error_report("COLO mode must be COLO_MODE_SECONDARY");
         return NULL;
@@ -854,7 +841,6 @@ static void *colo_process_incoming_thread(void *opaque=
)
=20
     failover_init_state();
=20
-    mis->to_src_file =3D qemu_file_get_return_path(mis->from_src_file);
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration inco=
ming
@@ -866,6 +852,12 @@ static void *colo_process_incoming_thread(void *opaqu=
e)
         goto out;
     }
=20
+    /*
+     * rp thread still running on primary side, shut it down to go into
+     * colo state.
+     */
+    migrate_send_rp_shut(mis, 0);
+
     colo_incoming_start_dirty_log();
=20
     bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
diff --git a/migration/options.c b/migration/options.c
index 1ffe85a2d8ccc8de9cc04d3c12293538a367abf7..f33b2979290f30ecfd0ffc4654=
498f25750f6720 100644
=2D-- a/migration/options.c
+++ b/migration/options.c
@@ -575,7 +575,15 @@ bool migrate_caps_check(bool *old_caps, bool *new_cap=
s, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
-#ifndef CONFIG_REPLICATION
+#ifdef CONFIG_REPLICATION
+    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'x-colo' requires capability "
+                             "'return-path'");
+            return false;
+        }
+    }
+#else
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
                    " can't enable COLO");
diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/co=
lo-tests.c
index 598a1d3821ed0a90318732702027cebad47352fd..366b9f7ac6d56a6e74a29d3e06=
2124ad4234608e 100644
=2D-- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -46,6 +46,7 @@ static int test_colo_common(MigrateCommon *args,
      * used in production.
      */
     args->start.oob =3D true;
+    args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] =3D true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] =3D true;
=20
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fra=
mework.c
index 2a3efeb80740cbfe876f649f0af685c5839e00a2..0bfc241914462c023ceab2fab0=
386009dc5a4320 100644
=2D-- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -216,6 +216,19 @@ static void migrate_start_set_capabilities(QTestState=
 *from, QTestState *to,
      * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
      * are from qapi-types-migration.h.
      */
+
+    /*
+     * Enable return path first, since other features depend on it.
+     */
+    if (args->caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+        if (from) {
+            migrate_set_capability(from, "return-path", true);
+        }
+        if (to) {
+            migrate_set_capability(to, "return-path", true);
+        }
+    }
+
     for (uint8_t i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
         if (!args->caps[i]) {
             continue;

=2D-=20
2.39.5


