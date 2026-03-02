Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74018E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0OA-0006bY-Cg; Mon, 02 Mar 2026 05:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0006Wn-6A
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:20 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nq-0007GU-IS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446812; x=1773051612; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ptBIxBYcrlSVj7REYybXenVm40mjTpwjL7I1XRys2gGU8zDFwfuPYycPVE8fyv2d
 oGXkHQGgai5yeoLpZcyjfmgVOeXw0pY2gObtJip0mWEgcvE+ZqzW1k4Oy/RIRYck+
 pozaY8plkQhMiRCFj7IaoMUud2D70jttPnF2+0nwdaLEi5xQ0r3KMhfjAuB52Ygo6
 Y5ptDHlA0JSN4w67FIL39nVUdttBD3E3i2OO1eblfyO/N+ELZ/eNDArFH9VTzCQyd
 NzxPw8u2gm8Onr8pWOIaN3XCSzQaeEvq04q6PKaL2QLt32Sc/QaRDWjK0rMGO5zpR
 nL9xlnt2UilDvUWV7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkEhR-1vH2vt0KUL-00chvB; Mon, 02
 Mar 2026 11:20:12 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 04/21] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
Date: Mon,  2 Mar 2026 11:19:46 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-4-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=n0JNkGWwDvp69U+jS7cX+vJwFoFOUey0gb5uYJ0EtrM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQogvLzCHZKoqRyj0PMa7L/NpHYwDWXi9qfn
 9I7oJtY3tiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WIVgD/wN7YwGbI3CgxYgl/jaHwqteUmIDjyaVRET6ankQ66ZcQQgAnxyffVtajCL7XQnvdX59JB
 e4nMcN0ABWy2cGXMVLwWqAfrDmPQ7WPAXnw6zD2pflG+rp4ca1ebq/rwuUzNRqiLs3mX2fkzJu5
 G0ORVb7PA2lKHt7eYS5smUwaF03dc1vSAHqFIaN4m7T2zCxDYEKvTPCA+mzMz3gl0/i3iq6NwFy
 7n/LPcbW/MszqjK9LnxePdYG4ZP34dWjaVnbKP7vf3PdUVn5Fg7CJb6vkMIz651yagh5vx+P7dX
 vzS0mOTlvS+nsT/74K3XdPK0y5sLTTs+Bq+yrrtyUvqyLYt6LQRn3g1fqFw1B0Hd7zOAoRoLlm6
 v9YZRqdq0J/lcPqKhSCeIsdD7AVoCpj1DAh5MqVq4OemNZTtBdY9dc4DFvOimkB4yXbDy+gwxkF
 PbmwH9MHMelHNY+GZAWLbJ5EXBLtDp9CMP1AHR1C582YGV47+B6aKtyaUamq2QbCk7n/owE6y5l
 VcUJQ5lr/kzdlggNBBI/62r6ysr2R84v3sk2MQQaQuiOSRfvfx9Pv/0W5Nb0v0n2zEANsfx/Xtc
 BCq1zCdr9DkeH3hyQQh9K3cLR1aQhFILioIgS6X0QqgcuRA7t0t3azi1Fp63dKu9WwYYTA4uyO+
 JhRLx4chFN+U5cw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cMYOBNII22zFjtDgjuHzNBQCsmK/Q2u9lspSt24X09LkmLhiIN6
 EmeWrHCRyRnzyvKpWtbUm0Fkr8qbaccRf2Pictu03FPRb1Wn9WwfG95DmL3El7LAs51CC50
 36og9oS5ag1tfe62eua7czCvFOwE9SpW8CFmsBQ5o/etVM1JXnxfVUOyii0fDvJxPhJA+iK
 GyoA8f1c/XdB8qPWAOz3A==
UI-OutboundReport: notjunk:1;M01:P0:I8FGAVlxeso=;RxD93m0Sa6WqjW0y2gNMoAue7FO
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


