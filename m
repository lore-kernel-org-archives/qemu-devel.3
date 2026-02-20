Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80619C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXo-0000WC-P1; Fri, 20 Feb 2026 14:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0000S3-N5
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXa-0001QF-HF
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617112; x=1772221912; i=lukasstraub2@web.de;
 bh=uZtEj7iogsvDfWdZSVpmpiuTSLNmWFEYLAlplQJqdVk=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vUR+kaeeEdyvMDWKW/S//OyufV6FYKLQ/8+lnT7CNs2Prj5vpCBGezDCbYj5U74h
 EtTq8fO4QkBLuPjeobR1U3RwI/8d8coT0xK/x4+TFhQi5cAl6C5K4VTfupTPG1CFm
 9wzKndxBE3/+91HXVEzV17Jyf1zLsRubagYIDkrmkn6tqY68HUVic+ilKns3cHwbW
 IEjR6IsNNR8vd+ya5+uGjWq2jgaglUhINzT7Nzu/PgCOkIp8tQFgnq4MnymqDtkY3
 pmpCb/0gfjoroME2D6SRB7+qYjdDR1ZxgZeP4dkMhXIehkOjojpURMsOPzqnjI/hr
 pj72UE3gl5CePX3hbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1vJMJB2r7N-00ZsHt; Fri, 20
 Feb 2026 20:51:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:41 +0100
Subject: [PATCH v10 19/19] migration: Always open s->rp_state.from_dst_file
 on the source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8915; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=0QRIb5hyrRS7XuIg/Fb5rVgnPMcGW7UgecLa5q+td1A=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtPqBeM0eGOmw3PxQTnfsT9Y/ewskHpzY2o/
 M23cEY7ZiOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TwAKCRA1qwsonF2y
 WIJJEAChy7qjhVyb+hjeNrzqhFKf3EYAW7m2xdi8x+lBKroazHvEaTu58lultSkIIQw4yWMS6iy
 oon7Kd9GXaCrW8cZSfceFS6gndSrdzXcSFjFgqWZhfaqXd+EJ9eM3xLGcl7ORScyfvw0uFWdZ3f
 btepcSUrA9qMaaOijgktoVB3RG92UhLaRRDAtZDkKOlo1JrElwllwD19iEHIn5jLvmhu0QiJrUk
 T56eeSvm7fVGKBhVA/+Al3okFqKUvpVf4sgjyOuzELnfeYOnnDWVs5eLZkbDuvnw3tag9zJFBK9
 pfYfW3AgrD74bRyNRhj1k0HHQKkNAgvG5YVHeRDNHqsPEvhPA24LW9UklLtT45j4CldaKiL/3ov
 e1v4TdqceskmaL5LYEv6QrMq+oPFs5nJ+jT8DZgJDDAjLO+J17O3hxp9tE3rETtBogYf5VQaSId
 +jp21eclr2y7HLWJtlBVjU1SCWDJBAgtUQysTyAl8hdMJXgKJGwcTkCIT+GCSeY1w1NMjqiTBHb
 ziSS3sH8K/tlPEzC40AdNEd4FFZkz3dNpIhIJCDrncmg3eLrN7hThZu8jfaC+kao5r1YTyMHyuU
 10FrSyLrQ9bqEj8Z42YfVQT34ASsYRc6d2Stez9uvxdQt+0mBRR2oQUMBfKRxg0p8uEjih4H3Bm
 0hrfbD3sJ+5HPnA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:nABnO+LjBU8bpnGfzxgZ+EpHOYIlzI9nAp1LSCitY1x5HCC69wo
 YuD5QdZW3+j5FcUvSUvykXg/Bqruz5Wm+feyD+xkoNePMLGGAZi+DIffPbpQo9fdOwRGdY5
 guK100g22OkyPLGer8b5fcOKEXmjzzzS1nJV+0j8H9kfGfgZsl92h6s+4ELIY6fXJ9YR22B
 M3NL5fLJbhZIyiYplOeiQ==
UI-OutboundReport: notjunk:1;M01:P0:vB53VdT3Q9w=;hSOqSJMRaC2sjHp/RM3P0qf8igV
 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
 waaFueU0T/nmi7FbBAasFmeumw3EU
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
so always open the return path socket on the source. This allows
us to reuse the return path in other parts like colo. Also take
the proper locks in colo while we're at it.

This fixes a crash due to a race between migrate_cancel() and
the colo thread shutting down.

Before, the rp socket is opened just before the rp thread is started
and closed after it terminates and postcopy fast path is closed.
Now it's the same, only the rp socket stays open until migration_cleanup()=
.

If there is a rp thread, the rp socket is shut down at the end of migratio=
n,
but the file is still open. COLO is not compatible with postcopy, so this =
is
safe as no one else uses the rp socket after this point.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 29 ++++++-------------
 migration/migration.c | 77 ++++++++++++++++++++++++----------------------=
=2D----
 2 files changed, 44 insertions(+), 62 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276cf318e2=
984deae9ae0527 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
      * The s->rp_state.from_dst_file and s->to_dst_file may use the
      * same fd, but we still shutdown the fd for twice, it is harmless.
      */
-    if (s->to_dst_file) {
-        qemu_file_shutdown(s->to_dst_file);
-    }
-    if (s->rp_state.from_dst_file) {
-        qemu_file_shutdown(s->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_shutdown(s->to_dst_file);
+        }
+        if (s->rp_state.from_dst_file) {
+            qemu_file_shutdown(s->rp_state.from_dst_file);
+        }
     }
=20
     old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,
@@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationState *s)
     Error *local_err =3D NULL;
     int ret;
=20
+    assert(s->rp_state.from_dst_file);
     if (get_colo_mode() !=3D COLO_MODE_PRIMARY) {
         error_report("COLO mode must be COLO_MODE_PRIMARY");
         return;
@@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationState *s=
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
@@ -634,16 +631,6 @@ out:
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
diff --git a/migration/migration.c b/migration/migration.c
index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33a799695=
cf486c8fbd471c 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
=20
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
-static bool close_return_path_on_source(MigrationState *s);
+static bool stop_return_path_thread_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
=20
 static void migration_downtime_start(MigrationState *s)
@@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState *s)
     cpr_state_close();
     cpr_transfer_source_destroy(s);
=20
-    close_return_path_on_source(s);
+    stop_return_path_thread_on_source(s);
=20
     if (s->migration_thread_running) {
         bql_unlock();
@@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
=20
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        tmp =3D s->rp_state.from_dst_file;
+        s->rp_state.from_dst_file =3D NULL;
+    }
+    if (tmp) {
+        qemu_fclose(tmp);
+    }
+
     assert(!migration_is_active());
=20
     if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
@@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(MigrationS=
tate *s,
     return true;
 }
=20
-/*
- * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
- * existed) in a safe way.
- */
-static void migration_release_dst_files(MigrationState *ms)
-{
-    QEMUFile *file =3D NULL;
-
-    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        /*
-         * Reset the from_dst_file pointer first before releasing it, as =
we
-         * can't block within lock section
-         */
-        file =3D ms->rp_state.from_dst_file;
-        ms->rp_state.from_dst_file =3D NULL;
-    }
-
-    /*
-     * Do the same to postcopy fast path socket too if there is.  No
-     * locking needed because this qemufile should only be managed by
-     * return path thread.
-     */
-    if (ms->postcopy_qemufile_src) {
-        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src=
);
-        qemu_file_shutdown(ms->postcopy_qemufile_src);
-        qemu_fclose(ms->postcopy_qemufile_src);
-        ms->postcopy_qemufile_src =3D NULL;
-    }
-
-    qemu_fclose(file);
-}
-
 /*
  * Handles messages sent on the return path towards the source VM
  *
@@ -2388,9 +2364,9 @@ out:
     return NULL;
 }
=20
-static void open_return_path_on_source(MigrationState *ms)
+static void start_return_path_thread_on_source(MigrationState *ms)
 {
-    ms->rp_state.from_dst_file =3D qemu_file_get_return_path(ms->to_dst_f=
ile);
+    assert(ms->rp_state.from_dst_file);
=20
     trace_open_return_path_on_source();
=20
@@ -2402,7 +2378,7 @@ static void open_return_path_on_source(MigrationStat=
e *ms)
 }
=20
 /* Return true if error detected, or false otherwise */
-static bool close_return_path_on_source(MigrationState *ms)
+static bool stop_return_path_thread_on_source(MigrationState *ms)
 {
     if (!ms->rp_state.rp_thread_created) {
         return false;
@@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(MigrationSt=
ate *ms)
=20
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created =3D false;
-    migration_release_dst_files(ms);
+    /*
+     * Close the postcopy fast path socket if there is one.
+     * No locking needed because this qemufile should only be managed by
+     * return path thread which we just stopped.
+     */
+    if (ms->postcopy_qemufile_src) {
+        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src=
);
+        qemu_file_shutdown(ms->postcopy_qemufile_src);
+        qemu_fclose(ms->postcopy_qemufile_src);
+        ms->postcopy_qemufile_src =3D NULL;
+    }
     trace_migration_return_path_end_after();
=20
     /* Return path will persist the error in MigrationState when quit */
@@ -2787,7 +2773,7 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
=20
-    if (close_return_path_on_source(s)) {
+    if (stop_return_path_thread_on_source(s)) {
         goto fail;
     }
=20
@@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationState *s=
)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        close_return_path_on_source(s);
+        stop_return_path_thread_on_source(s);
+        QEMUFile *rp_file;
+        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+            rp_file =3D s->rp_state.from_dst_file;
+            s->rp_state.from_dst_file =3D NULL;
+        }
+        if (rp_file) {
+            qemu_fclose(rp_file);
+        }
=20
         /*
          * Current channel is possibly broken. Release it.  Note that thi=
s is
@@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState *s)
     if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
         goto fail;
     }
+    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_fil=
e);
=20
     /*
      * Open the return path. For postcopy, it is used exclusively. For
@@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState *s)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        open_return_path_on_source(s);
+        start_return_path_thread_on_source(s);
     }
=20
     /*

=2D-=20
2.39.5


