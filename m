Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2EBE9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hk-0004xR-0X; Mon, 02 Mar 2026 05:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HZ-0004tx-3S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-000636-HK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=fwN66lijnmy4XUhK1dx7MdgKeJg4XbhuRV10AZhs3cw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Kb5kW+a4dsJkDNw89Ic8mgzu5gjyW+jpUQttUhigjDmHRimU1mluJXQhF+dyDxL6
 YHqwuNO+DGptt8Qlk/XUKte4CrLXuTvRIpae1izFGCZKUXOut9LB2gmxgYXJtWb7k
 MGfu7kerpiAcAESn8imRlZisrAmpnqeisXumDrVrFMBjt6U4c4UlG+9ngvTiqzZIb
 7p8bJaWootVEyXsP5tRFdpACk5EmbA68D0lsaeybZ24t/jsbX2PPNLOszGR5nwgEx
 3JNFDBOjU5heI8YdOSkozqF7Xx405qjAV2b6VaP+xR9/emg4Jdjq9VEQhSeL6LxnE
 xNeFA3+ZbCPpLB5ldg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xjd-1vWuep24ah-014elW for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 20/21] migration: Keep s->rp_state.from_dst_file open
 until migration ends
Date: Mon,  2 Mar 2026 11:13:31 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-20-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=ZLSzyW+Kbq+8BxGOT8Uq9Q6npx3OKDjaFrVvo16lwno=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAG6VQ1NCENiX2u0zZWA4NS5GsBT/rhqEjPy
 YXu5vTXyz+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WFhbD/9Us4Xhd8yQ/NARtmlNirS3NrvR/UrUwTP5nYnnp2x5dyenOR8mYsor3KGVCVWcjsyZdyI
 jZnxQzwVCivstkzfQQ9qUBMR3uZV96RtDqrfIt3kovH26qWBdtB4K1+3n5hnCHemUeAMDU2L4VT
 yZ1HHqbrGEpX4+dIJ6dYwxDlOvDBI4VBlRW/0lkoqBgKEH0RRYpgjry3iUCE8ZV8ExGoT+qmSc+
 yoQwBukKgPM4bXoZ+xtMZOItTespS/AA16kSDAGMq5W4u4Wu6pjv7j2Lv/zRedJ44eZZdDRJAP3
 WOfQ2X0lquFdJYqOANWal5hDttg1BOCv8Y4c3HYSlCeB3MbK1YzbhwTCE37eM2uWNTd3R2VJp8V
 EniLqa9NFdPHMB97CqYXl8lJuvSb5upRRW/1rHnypovx5py7Dz856zP+PcVu4PNptvPHGKHgwMQ
 LVEuVP909+w6f5Af7Pt5FxvMCG6Xb3yc7fKBLqaP4QMykGIDMS4NDLROm2dTrGWLKhHrjvWSDbi
 lo/TEczHCe+7OgMcmpVN3kKHsS5KYKNDkXrqTLQnvx24q2E19EpXhu2CX+1eecemAzpdUS0Fvhd
 vvXKnxyiDZStqv4CKWXVt2ZwXi0/vMjQM5ylXUneFDNSuPkhpSYRQEHhQj6RY04EKopugpMDKnh
 ANpISYUK+DtLfQg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+K4Ul8rIlVcgoUIoPvKi+J5Jn6RPq7LDyQcyPZ5YnbcJJ9ApwEp
 j3Cm9Bhdz+YNXxo8RFfRnQ4Hrb5i22ogXohXjvwKn/NBSMePatk0NNTNNtKt6e4nz0E7J4n
 8tX0bzZ7oKQYyLBGxyKjhHCcAl8ZMUbnsWo3de5PS/1EDq0zq8646oMB0bJeQD5d3/IiiL0
 q0K1BXDlCGn8tiwV5Tt6A==
UI-OutboundReport: notjunk:1;M01:P0:WJXgTuJHlBA=;v3XBPLkSl34BHv8sUgiUG3rS9G+
 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
 Sih+lZEFcFt7MjAoH7V2RbLFYO7Ecpm4s5Cop3
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

This will be used in the next patch to allow COLO to reuse the return path=
.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..74f5c314ff62333f6c9dd8bbd0=
9afdfaf84a41c2 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -97,7 +97,8 @@ static GSList *migration_blockers[MIG_MODE__MAX];
=20
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
-static bool close_return_path_on_source(MigrationState *s);
+static bool stop_return_path_thread_on_source(MigrationState *s);
+static void migration_release_dst_files(MigrationState *ms);
 static void migration_completion_end(MigrationState *s);
=20
 static void migration_downtime_start(MigrationState *s)
@@ -1278,7 +1279,8 @@ static void migration_cleanup(MigrationState *s)
     cpr_state_close();
     cpr_transfer_source_destroy(s);
=20
-    close_return_path_on_source(s);
+    stop_return_path_thread_on_source(s);
+    migration_release_dst_files(s);
=20
     if (s->migration_thread_running) {
         bql_unlock();
@@ -2209,6 +2211,7 @@ static void migration_release_dst_files(MigrationSta=
te *ms)
      * locking needed because this qemufile should only be managed by
      * return path thread.
      */
+    assert(!ms->rp_state.rp_thread_created);
     if (ms->postcopy_qemufile_src) {
         migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src=
);
         qemu_file_shutdown(ms->postcopy_qemufile_src);
@@ -2216,7 +2219,9 @@ static void migration_release_dst_files(MigrationSta=
te *ms)
         ms->postcopy_qemufile_src =3D NULL;
     }
=20
-    qemu_fclose(file);
+    if (file) {
+        qemu_fclose(file);
+    }
 }
=20
 /*
@@ -2402,7 +2407,7 @@ static void open_return_path_on_source(MigrationStat=
e *ms)
 }
=20
 /* Return true if error detected, or false otherwise */
-static bool close_return_path_on_source(MigrationState *ms)
+static bool stop_return_path_thread_on_source(MigrationState *ms)
 {
     if (!ms->rp_state.rp_thread_created) {
         return false;
@@ -2424,7 +2429,6 @@ static bool close_return_path_on_source(MigrationSta=
te *ms)
=20
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created =3D false;
-    migration_release_dst_files(ms);
     trace_migration_return_path_end_after();
=20
     /* Return path will persist the error in MigrationState when quit */
@@ -2787,7 +2791,7 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
=20
-    if (close_return_path_on_source(s)) {
+    if (stop_return_path_thread_on_source(s)) {
         goto fail;
     }
=20
@@ -2941,7 +2945,8 @@ static MigThrError postcopy_pause(MigrationState *s)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        close_return_path_on_source(s);
+        stop_return_path_thread_on_source(s);
+        migration_release_dst_files(s);
=20
         /*
          * Current channel is possibly broken. Release it.  Note that thi=
s is

=2D-=20
2.39.5


