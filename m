Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DFDE9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hu-00050p-0b; Mon, 02 Mar 2026 05:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HZ-0004tw-1M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-00063A-Gl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=ITqpwwsSvHY6NBo/kS+QmQ39G/KVmJBMgSxNnkvOzu4=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wr1k+vPJvZ3Rnil7dzfxURgI+oBopYpfTzhwPQLAs493Aa0CJKJUkGo8oU/OlF0N
 yHcJHs2pJAYoSTs8nWiodAU+61Rin/AJatM0p39DSpMfg3HNtZa8AbsWq8fw/iSmI
 COelY4P2WMJSS0YEe3Xv73k0G6tAyElbgVbIALztLAmovWiAx95/VqRN7YLYTZslp
 KdFwi7CO3p1pHjkiGL7rqsaSDE+4dgvNfIaB9lavEL+DgHyM+1QdRbShTjWDf5v4I
 Z3KZFvhqq6I3ufwQ+ZGqPH5gH1/ZWUKP1jqnJ9Of6s0arTQjAgYrxDzaZuPB4v9pk
 9SGqBQWJU2LQgS8hpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1vU1Jm2WXm-00dLQ7 for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 21/21] colo: Reuse the return path from migration on
 primary and secondary side
Date: Mon,  2 Mar 2026 11:13:32 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-21-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7407; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xW8DcPv/c60MIhaTk/f+XYB6rFvpT/HXqTmPuiv92Mk=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGLlhxK3Jy+IZDExftHyJRGNOplmPJYBpsv
 iA3Zb9TCPaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WI0hEACLvykz6s4Wdjiv+LOAUFaaAvR8UgJGVHUabXj6sNHW61fUZ7GjExgpMD2Od9ghJClgYYX
 GZAjvjg7A3dMo3dmo8wNy4vbKNfR49zcTJRo8IuxK5NI1EqSVwEu29f3GGud0kchaFMYK8G+gwa
 8JLoqIR5KB4oF4PERV4oK01JmG8evAZoKv3R6SAUKx0lolcYLKQ8CylBO4BaxCE+X2/LIHgmQdz
 GxVivfLl98qHH0W5lBQXDLo1V7X1LR82bo3trcd7AUjUNLvHyRIDMXHUN6Ga879M8wBAPsuSRy1
 KSqwnl9B6//yJhuKwS35JAcoAhbnADqmtNNPh65JDRuuXUjc3p1+xwdmWfMbI9dSvm/FJxTWziM
 a4Y2HVPilakDDjDr7qgcw0tHmf+Q4V5HuqMpKzGhkpjkWdbcp//xltShzkSVWxTml2xKRxkcBAu
 PV/pVhcxPu0CjntbMXh5P96YBqGzE43Q1TXBrNt5GSixnGqFHpZqDa4yXwIVmIMwD9v9RDO1AXU
 /ASN53JiPmHbz8zwNAetljWIAo+h2FHioA3DVI+45rlkVg+6EhX0btY2fO7BpcqtIfZFkW1Muql
 y8RkUtC1Xk6+3a2dr4zU8GmSjgRTxobRJ7cS/Sh0uo0lohwzfWFpUxJP0q8z90vgJYGZ+ukh64P
 mmQXBvp6OdrDbOQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uHguU3rGO6o0pONml+Mtu7yY5nI5mBMiiSm+FVr4Pn5E2ykWfMA
 s06LYmPCGofZ2jvfE/JkYFNfvFtsf5UoSmaFxz7kTVguYoAXQ8gwv7Ow6HHRWA2jP6b7Xuy
 P1J0k6jhzqf6zQ4H/vYhKc060XyLQKlmqW9o7QcOli2N4HY4VIXPc72mpUEKjUB2AQWPR3f
 yO6x9tLG8o3SpBLP3RX1Q==
UI-OutboundReport: notjunk:1;M01:P0:5IZhVJn54B4=;MtselJJ0VKgnOUD8kbTAhk0bheW
 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
 n4AYKeVA1pPjeG++dd1lHc8e3saoEbX+ZdRrHF
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


