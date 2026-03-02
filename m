Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0651AE9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Ht-0004zt-45; Mon, 02 Mar 2026 05:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004ry-SD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-000622-2P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DWrDdj9xHtH3DQUCzQCt5xV4fVK/Ky496eNnGXetKo4YS+OVjmKHCWPqBVBx6u8Z
 FOxccv1zxg6XqmoFLOxVysHMZFnJEYurXchy1i3ZO9sdp41HraRuDYolPOdFeSLDK
 8wonHhBw58MVpClLbsjawvudn03TiekIIufkMAuYOuDmkqKJL2eYvOD3ahtOqXyoW
 oQosZIYp3zQBzTlW2CPFm3bxIJ7/PI+9KgZz7ov6civzxlfapJBzA8bX+il8KDELy
 GpqrvUcARaxOKhYECVojAYXRm2uzI3RmBg3giItK9NhB6vEAgiSnFurI8RsW7fkw7
 zJhu7hGDa0/wqBnIbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1vUqGb2SkN-00by4D for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 04/21] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
Date: Mon,  2 Mar 2026 11:13:15 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-4-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=n0JNkGWwDvp69U+jS7cX+vJwFoFOUey0gb5uYJ0EtrM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAF3u0RN+7t45ic/4uzj7czfJHI1m5FoRz4S
 Y6aiUNvD4yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WJYED/9i1AiwSr412VxBo/p7JSqs+RojkWko1kBStyfk8dOtHfP3g/XZsdL2+F8o9O2V4zj49RC
 IuUMJqwmXj0PRjQm4yM7NABvh8A/XjJgEUiBzjSFlIzbOv/km3uVupvc1n/AZcBl2q4+iMF69F+
 N1SUQFe5aodqYeYvrRmWTsjI3mywU4NSGvfD74LFW5fzJlcKwqsZw3iTXOw2oYMmwoWO3EGFld5
 PzwvJH+sSQmc4ldPcTVPmLaoiVQZ2mIlY5TsyVFXSuAQlbARCDCPNuxCyaME8LVzRN4hpJ4QVWU
 PIcuajRnhPTt7zRgntmUsE5Ek590l5dxIcADFGXM2EXFpubOa+V6SZbm9xDbcoUy/E26bA2/ooM
 lQoHs5vwoUPC53D+rdwQujmoiiwasRYc3ZSpJIxBwDilVaBS84zVfCreTIw20U2Rh/t34cQ7HpU
 +nKnKEwaEhBVmErUUktRvXmEY24W1AMVudPHU4YS10aFv7Uqb3ktpa9tT8gEjYxIw2sfdsQowfI
 G+jXqyCW45G0GwB5GIeJ0zCiO3K1KINaHBH6irMd8HwCYhtD1eBgN08Sn3yG/K3QcTNt6iUWZrl
 Y80UvrRXUgAcJ4QQddAXfUnta42JEg7s36JMZ6E4TVYMTd9bkAZxV0df84WLm8Ttodj7rutwxZC
 sSvac8CN4r5n91A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k8VmHjz5aSMo4GAzNsrQDx9nQfcvd6ntB5btelUObi9j3EIcuj9
 gRCwsoZR/vP+sRVqDs/neKUcWMuNtoeAkhHBk3E4yGe8hktkTmtxN9J+UOr+myLWg9keTa6
 Mqj2SetVhEj7/veZaEaPoJ791b0EGCLGCd0e0trE6JzvWayER7Ypurk/zH/dDuSSsi1t7FW
 /9IqX9Ucw6eTw2NmGvqSg==
UI-OutboundReport: notjunk:1;M01:P0:5PBLK6g751M=;lWzvm99d72GSQT5n0nIyOAYZAHS
 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
 VG1SAp8M65mgGwzVYLUx+nfGe7bD33bAaVJucT
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
index f7a5bd3619a49a3b4a8306973de7a4411cc0df58..97a224c39c49ff2269f375db47=
112458cab0b4cb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
=20
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
=20
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index c2b9621190f8678ac6b32d6794d9bcb6ffa5e402..ef6aac53343f2217cd1aa37e49=
3483703068d1ff 100644
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


