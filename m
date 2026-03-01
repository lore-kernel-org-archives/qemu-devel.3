Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EB0FD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU5-00048C-Jh; Sun, 01 Mar 2026 16:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU3-00046u-Kw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU1-00042S-Rn
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401062; x=1773005862; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=q3znZdeqrAspyD62Y1tUJL2qtM6RACS3vTBW6GSaLjlFrAysliUKm6gZrqxj9mtk
 k2hmjDjDe/a+FpfMwb/CuWK1WJZaL8mlEhRqMtQZhvcnDX9wlwd8DJlFQdB6Dg/kY
 BOUpym22PFteiUQD7kEMCnj1KlRMzf5vf6L9E4l4lerOjqzSyDRxDSbSUWyXsVlOJ
 8jP+81AiMCQ0GDXtLsdyDXDL72APmzAyHUHGBWUUvmrbWonWzcK8V5q1Dgi/EOAC8
 ldBq/gkEYDwMlc/60K5oBvrq39++U/wpmqfIn4fVuT/eSQzQM048o0VEZlm7MxsEJ
 8dAbR+afgyzc66seSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1wHW1t0yxH-00OxX9; Sun, 01
 Mar 2026 22:37:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:24 +0100
Subject: [PATCH v11 04/21] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-4-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=n0JNkGWwDvp69U+jS7cX+vJwFoFOUey0gb5uYJ0EtrM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhay8LjirZBPNyqQYUy0F4nTEMykB0slxlA
 USu44oQMtqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WAUoEACMOgFdJtPHTtfPTod2bAjjur6CICiS8HiMBVIq8NpTOX6PcRBI88t8hlFT1o8nCSw2jnU
 spVl3tqbB5WkfXX2ixD7R4FjxY9AqCfEYQBHsYLXauwPaIzn1C1x8SDGTzqatwQddTXClKJG4HH
 fnNCT6FWDnvO6RkmRNc4Dwv+nHbSynAPM3rpdyeZcePPvY9WQes2f/iudkL6KFS92zgFOiMxzeO
 vwGb8ZQzWqJ3t20T8qO/wFf133hLpQ6qtXWbGULs5THieXnFSsS4hqZX1wEkEu6GzC+YwSHQqMJ
 +/+Dh2kdYHwlVu7tvJfJGsAhth0MSOAK5/g43Xm9D/zFK279P17hiHcj+X0OzxaGtVkqyN813Rl
 ef3bpiVGDi/PstXxBr4iAVJqWodshe49a9pgi0RerQrHh6usHLVxMRCSXOwPHv2i8Y58GbjWG68
 08GdBmrIQPaS47shFWjwm4r/B89XKdI2qk7NB/XowLpikoE492mfGxEeDH4SSG60HHmMghohBaR
 DdHL16Wxic+1IjL0r5haMB2ajOK6wCjlQ+VqqwEoBCZXdZEoF5rUIH9z8x6p5kWhvVT4MKunOu9
 wndGLRO6SxjW/9CBTlGWMkz5TML0P+qwRD5Dj+2pyB46tpZBwG8z5IoH4Pvt6aiS/wc8FKtTwDb
 AtiyQ9hngYFjJKA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:sRXCFEGpm8vhXGKsrEw9RmtS4Xt8dJlk9UxYqjcdRwWlfjIj4qA
 OLnwirwhs1FIO5TxmuVc4pRURmV7Efz/xg2jKyRZeZaPU/+v+uTMt1Ct7jMExZCNcBvwvVc
 8cj9W2PBGIZP3wh4lVGXhZ/2IS1FbNaQW41pRo3A5nKZ0F8SA9UJYinOBTnDhMchKuR+kh3
 WOsJh3GQ67OEHhr+OgDqQ==
UI-OutboundReport: notjunk:1;M01:P0:cJOjyq+REeY=;sL8DhbM6zzzZXr8z8qOw5YoWtgC
 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
 6FnM9ciLHpEJKplZN98f129It/JB3
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


