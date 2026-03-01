Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BD5FD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHm-000166-MW; Sun, 01 Mar 2026 14:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHl-00015b-PZ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHj-0003W5-CG
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392610; x=1772997410; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DzQOZpUWukObKmS7L+2qlsWa7vqgc7fndEL8Cv4AJCdoZw8hLCS83MKWS+mH4sH4
 hIs4ZeQauwOQySIC8rkt/KFXh3aS/6ZUy9GZVBOhT0lf6Vycf3rwV0CRKixv89wcM
 Cf/RU1F0MEVDjRYFbOzdzCCi/J8r1VIk8bBZ+NrPBwz4gbSnCWkCiIZuwrHsMSaGP
 5gw3iHR7un7f+SMaMyJwTfcw6Q7oPupKXB1VHUBTERBhnN74JBfea/QJ/lKuroigP
 MKx93viBs8x/Eg7XXkkO5oL3Jp+s+b5Up6gKKqB8JuzcH0xJr88aYlRyuWXIgicvV
 MfptrbXLqFT7pSaPPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1wJ6Wm491F-00HpfH; Sun, 01
 Mar 2026 20:16:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:29 +0100
Subject: [PATCH v11 04/21] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-4-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCcTVsDpFKYZY8vZZ9i8KWADhB3qm+3fbvRy
 8knTYnUzSyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WAwUEACJ56IlMclARKP6HHKTl3CMXJSQQWGcovJiyqFqToTlhvxvHGVpbKO5Ei5oTYglaRlKucO
 Z33m9l90ueCzlahC0uDdiG81zmrrDNo9CtEm031Iyl8r+6CkB2Dl5nG8LMaOg6mZx3z+u/fZpif
 /bjOpKzz8TpPRTE3G0DLj7tL4x08PQjqRKDfJ0nUOQ9eK5NDXsTgOL5+nMJcq8UeXCnzc37TXBj
 COfxh7qrI0LhsCWPpKb4UJMalvvZGcMAK3H/NM9YHAjzyloWxEWOrZpN3g+v1m7gzLMRx7oN9zx
 dpvwNi3IQCdmPD3ZRULLjOUcIVpWlebJxeXvAJvaAoCBIWKt1RAxAnRdbKIhT/Il6heWd0BzxHt
 sn5JYOYZ8KB5YvpAHAEqc56u+e7F1jvEV8Ghb59qusC4OQ8RWZPuPMRyz/SjgZb2zlB+P4Zg+WU
 qE26RzKf0RlyzMZGUmP7J50TNLjDr8qhkVAjybbKNsno3MhCQhQSn+DBr9zVgOmscoMkS9Z+rFC
 qRe5EVNC2UMFLqj2A14evwMj8VeZt4yar6xssa1uJMrj3Wn55U+YskthXzXxS1ApiZL0+WFkADG
 +lnW//hC9gnKW9FewPmaY7d3B1ROYfu5ViS1rSih4Wh9k4GtZwn4OTglmF0DWUqLZGNrfyaOtgL
 dcKN4ged9vdWkdw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:mI8WOxroTfVKE7V5Jl1VZV4TPIyzXNBLLmuuLsxdT2XEpH81Akt
 pSk1nB41lnWO38xw4EzeduPv6YNtQAYoqch1jw9nbBm5MYSqk3q7Hc44/z8vzQTwqWaImu9
 jiz6WNCjDvA72THI7H91oIbjfqTDIeQRNSOOHqqR71XJ9cnG1PGHrBxSHM0fbpMaVg1Qdoi
 Gs1WMVCiCDnzqUh1MaVCA==
UI-OutboundReport: notjunk:1;M01:P0:bIJihs0LkXc=;uwpbBXZ6nudAH0J8OzSWm5lME5Z
 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
 KNA9cx4q3p2Uplq9pjmSvMfAl8iJU
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


