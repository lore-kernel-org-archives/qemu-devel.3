Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9CE6BF09
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOi-0003Vg-7A; Fri, 30 Jan 2026 07:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOf-000319-Mx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:45 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOd-0001sV-O5
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775274; x=1770380074; i=lukasstraub2@web.de;
 bh=d5XXZz6zgrcELqgWU2qKR2sPq1ihJhxnJTX7yAeEed8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IWTpZfyeQfotNUvVQkUKvXp3zHhPkgcoSuSXL8IZ9/lnBhkcJDiYe35g40zkcUNp
 51G73C4IdQQmtcorzYmNViV4cu24I/Yx9kMLU4CxJg6mHSUa+AqerAgsEJ3FxKvQR
 LdZk5cYOZ4GDAHETJSNugWCDX4FiF+Lgxr90f8cr2pJxZ2N1avuNOxPMpl4it0f15
 HYp1NYwDcOxEYcjskBetSQWMxm9hhuMx5782HKBOUhqttm1q8cy6hrnSjKKOAZ57b
 7/0KKHqq8jJ8JguAxXQMEYM+LWC6M0QZiRI2sx6hxv+EvJ5OCbNo35fOn22rmTgOm
 zn5fWM9G/3ukJEOFUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1vSLnX2wUj-00Sfhp; Fri, 30
 Jan 2026 13:14:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:12 +0100
Subject: [PATCH v4 04/16] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-4-7115ab6f0e77@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=j2vUFY574JXXo6iLoH5OhndH1exIpX5cdGP5ypAbWzA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClNHGQ1nPqXlkGoEzbb0e70bTfYsat8qlj+
 O5CFcR/5heJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WO5RD/9Y33EGcOp1S23QHs3nTTX4oe+JLfyvu+oB1p0uFsQE90mvQFfFP+jm1TUvU+e5aqL2QQd
 2RAV0TAZ7eiRDd7VlIX8dqNKci+sUvm6neIXUllwh63VBwIZKr1tRoenaogYVe/EFCHGjAqDG5/
 vuZG4H+cWUlnBuhwRO7/x8395dN/qUCRueKyY3vzTLwS3bahbmJJBlsvIEdIgldPTRyy6sFMDd0
 il+Bwl11DL0iZBrWbvBIIY30gW+wAF0uNLjmbdTAU/a1LUwtUjiZRvgfCXR0qlyFLkBLUeTaAOC
 eL9MKXLpp54ggHIKEYPYPkNzw2lnGrJOdXuwT8K15aAYksLVpPkICBIV62z8dKMWjDPpBHSWmIr
 h3VSBaou7G9DHspjr3haXluPnTyIRbCCNk46geVZJqRgMQbe2aDjCMaWbCqOH4g4XqIgE5ecro9
 jA70F414qYHnzHMBDZow07vJDG2TwKhmN4Z3/Il98/zRmOk09fT6POuI9hGvYgeCRQNr6y2Pwh6
 Kt/b1FylVx2QNaB0QBH+NQ3LlkQnzxBhSbuki92H3tSlVFl7DIcpmOLS9jYBS2aNPLuCfm8Rjdb
 2OGQec50aI3AGHHaEuP9js+MXbnP/6rDxuyYA7tAcU0Mn3iq/SCNnz+pVh9Yns+DeQuln1l5RmA
 kP1XQsHqhuuDXLA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:WcNvThW2wPcqRZQ51aNH7OOmwBobq6HQlKcstjTjcEyOmRhQ/Qk
 jKCCe+G/o1yn/VVK7yP/TBTODb7v6PJQZBBW2IHUzvzEZ7x1GMrGgN5OHdBALRA+hq59+Xn
 qJDcz5tUyVt/kLokZfbbBc7hO0QmROCNisfkmDem7lc34UMMgqwjmsWE1fzfUERjDYlwRmb
 aFWx7u3caf7hLC9i1rcFQ==
UI-OutboundReport: notjunk:1;M01:P0:r/sg0y7Deqs=;1gsK4MtB5WOs+tr3DHWhKNrledw
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h | 1 -
 migration/colo.c         | 2 +-
 migration/migration.c    | 9 ++-------
 migration/ram.c          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index d4fe422e4d335d3bef4f860f56400fcd73287a0e..2496a968cc1ce709f706c0efe5=
7e4f765f163d3c 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -27,7 +27,6 @@ bool migration_in_colo_state(void);
 /* loadvm */
 int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
-bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa77500386d923dd97e522883027e71d8..8dfd39b035c48590fcebeb2045=
9f01fb37fb67d1 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -933,7 +933,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
=20
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
=20
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index a73d842ad8b060dc84273ade36ef7dc8b87421f3..bc8ce64ff5000b0eb634a20b22=
e5f3e3289b9707 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -605,11 +605,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
 }
=20
 static bool migration_colo_enabled;
-bool migration_incoming_colo_enabled(void)
-{
-    return migration_colo_enabled;
-}
-
 void migration_incoming_disable_colo(void)
 {
     ram_block_discard_disable(false);
@@ -739,7 +734,7 @@ static void process_incoming_migration_bh(void *opaque=
)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-    } else if (migration_incoming_colo_enabled()) {
+    } else if (migrate_colo()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
@@ -807,7 +802,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
=20
-    if (migration_incoming_colo_enabled()) {
+    if (migrate_colo()) {
         /* yield until COLO exit */
         colo_incoming_co();
     }
diff --git a/migration/ram.c b/migration/ram.c
index fc7ece2c1a10f34aa5a91f58cbe42ea418d7c078..aebf77aa0b861e00516d6f1090=
aebefdd0d97e54 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -4370,7 +4370,7 @@ static int ram_load_precopy(QEMUFile *f)
              * speed of the migration, but it obviously reduce the downti=
me of
              * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_colo_enabled()) {
+            if (migrate_colo()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporaril=
y */
                     host =3D colo_cache_from_block_offset(block, addr, tr=
ue);

=2D-=20
2.39.5


