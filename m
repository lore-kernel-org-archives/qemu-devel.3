Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB6E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1iy-0000ZB-Vm; Mon, 02 Mar 2026 06:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1id-00004t-2t
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:51 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ia-0006CO-Eu
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451942; x=1773056742; i=lukasstraub2@web.de;
 bh=fwN66lijnmy4XUhK1dx7MdgKeJg4XbhuRV10AZhs3cw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=p5rJtIpylTp0W4xDFy2RzA1Q7FH4VTX3ZnytBRi1W3TIT6zHlLuK2zD+3FroQt6p
 462WMqAm/ikrNtdeK2TVY3NUofMZPhyM1+BChcGwuzPKDqF8jNMgCb7Yw41AoYWYK
 r4pHQ3VFZV3Qc2vs8ko41ztx7f2M2yTqUFz+dXLXl8zyPWgw/R/QHKhxcXydF/NBP
 kh/hdcO+AexSPee8qYp1Mn5nb9M0txZycKpvisXwIgcQIe6EPomunmI6zb1D32YBL
 /lU3MBgk+xLpwn2fECv6v7o2WvOT248NMysNQCUJ2aMxDeQ94WLy1uwgpepAgZcQv
 r3uVDjWydW0OE7tpkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1vqNsE144e-00Fqlq; Mon, 02
 Mar 2026 12:45:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 20/21] migration: Keep s->rp_state.from_dst_file open
 until migration ends
Date: Mon,  2 Mar 2026 12:45:35 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-20-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=ZLSzyW+Kbq+8BxGOT8Uq9Q6npx3OKDjaFrVvo16lwno=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UNp9EbHFamN0HwJO3wdQMQzNJ6EHhT9Eyl
 EHjAIvFp0mJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WONAEACcWAKeiVTJKUgf41163Ehip3G2QVRWpqEOpNjLex1x/7ggh+IpdcjQYTK13MyhTD7rsCj
 GAYLFMrzGLUcwdOtVGNvULwqzGr0L1x05qJbmNfOiXKdEEbDW0PeynIzbrJdLjItivQ8+30dxHU
 OJstTv9+TtUdwZSMTegF8CSVp1UzNdMKEML3elfE5VyGSg8hE+JIEJ7PqjsPs3gbjvsnecE7wjk
 xQgpvBAWtU+bcS71wi2ongD6cu3w3IU6zLDYmcDJ0wosFjV7E8RbScQw7xqMtCSlm6uO2PMxN0+
 wkbKecfkyB+Wvc2GUlgz3Mn60y8A4q/NGFT4ATabFjmWb97it6dfDp092gRknwXVh0WUjNOhrdF
 nMh+g0rBKnXhWFpnuoiNdDQBuXMdic2oJN+Rqp8tH1h1YBQcJsWtR3oJG5OVbA6EE8VLkdOnz9r
 d0fFO1fK4bSEeUTXfoW8ETiriMPsZki2Mn5VmehzU7FXnCaxMzt6RxWgP+c/W4lR2knpLsXnU5t
 O2qHBJcARGaBOg5h4qwVeo6SiE5yojTh/ObjIkyiYnKNnqIEtxlqX/hBeP3W9mO8ZKBr7yO6RPm
 Gb64j4uPp9amuBw3YXiW/x2x/KqBtBFRgWxU3o1dQm8Qbz3o6NhAeSwEGzLATN6QT7we7W9j0nP
 MtvqKNHoSznC2+A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zHOI9iQ5pE8bJBOZTwrd6C5rA364hBCHtMefg9uw/Dfy3Hz1l/K
 NeC9Bho62vlnZaTmGz8bOhKn4jZ3pOASwtvO2jAbZwSQ33obzOyyeFgLkh4gBwTCSpXjyZo
 kvBS/VkOBOXq7ruBgNbTlUf7fKnbgJ99fQf5KjUV1HEvrunyiU1gA7gQL9ZEagghAgqvUWl
 JNeObMMLFrCjvfFLHMt6w==
UI-OutboundReport: notjunk:1;M01:P0:smdkbBJidXQ=;e15zbcqMrsLKaagyCNMpP1B6rDG
 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
 KUzj17OvEVjAdV+kZOgCUP4titn01
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


