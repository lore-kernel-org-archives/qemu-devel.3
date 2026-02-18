Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D3EE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7S-0007Av-8q; Wed, 18 Feb 2026 16:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7I-00078f-FT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:52 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7G-0007NV-Gt
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450178; x=1772054978; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HvgJMaTHbiTQ+BQlo6cHOlsftQdcsra2ue/p/iroxdKgoYN2oxjLU08n5UIxQRfv
 Y8Rk2iWTtmkYnJqXDTHJn7SdriXc5YHrVa74+o1XVxM5eTDiO5gBfv1ilVxWDyR4f
 r8mccjnk/vTGcIkfnWuR6wlCk8nRoa3P7icQRw/V7wcVJ0mn/2DVzBtNQxCI0X1tt
 NoidiARzIDrr2nVHBKhTW8Hzu5uBmI8N2QGc2JmGLIx0AxijpzMVk1ZKxubR6Pbig
 0/WnosqwCMyovD1wVRS9zwnc8DH2jAAstvzCGOq1VZp9/CTb8LGR6BaDIs7JOUdhb
 CDIhi7YvwcCfJ4bjlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1voA9R2ZZT-007x3g; Wed, 18
 Feb 2026 22:29:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:24 +0100
Subject: [PATCH v9 04/19] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-4-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli8895dZBVsoIFEbDi6K0FBWYWDbOKdaY8RA0
 e/OO0NTLOaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WHiXD/92pO+LrCiTNONors3BY3+Ki/D+VuI1Z6D5uQujemE6PcAPgh1knajBP4VZVo6M9hfClSW
 QksLql2iFFYNZkb6dH172ErVGD85umJdQs4ThH7Z+12hQskdFsCW+N65P4bmuagp75cFF5WewoR
 CTiJ64TPUfoNFRq+dFEVGXS244f7ijUTN94GW4uTu47xVTpp4s7KVaNkZwgxhj8BvTxNP9nHkSm
 0RTuaUO1RL1plD8/6LpTok/EK3uhVs5i/PkkycCZirPW/GeUqhjP/5uwhb+lU7gYjX2Zv1D0VKs
 Y73HBAykFCWYPpkNsf4H7KzrP/mtlR7J8cqN/nfx/CF+jVVqfDhDD/lnur+T8DV0VzJxudniqxl
 1wgrjWvoLLaVFBLoIM9SDcIVMI+kOLGGXHUNREdIQIwxtROQ5IqijdAt1ie31uL5Dqdh6hZzKjN
 w8TxkUDC5wsFKf7gBfz75iO7AFIkXd5Mi4gnGFpsYSS9HZG5itcRE0Wa45AP3qH477t+qyJBuFA
 9U7ff5zbCyq4VyIEgSOv/vYkFTb+vCWimdU4f5h18tPWTaiHNboQQ6IC9a1OL7P8zx8zZqqvS9n
 2v6BmIO3mH4YqrtMdCZhEzKxUIwLra2hfl3YKKhz4Mf3Brao/1vreTKBWxq0GmRNcARozXJPy0M
 habCMI8Fztc4uRg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:CbtSBdRekclbiXyfbLvxkVyOGOcMZMJpbzxtbnWBSHfq878Ov/b
 Gx3P+BXAJpt/7BWU8Nb8D+X5giHBJVC4mp6A2iUTzQgZRt8dpnMENNVIJ/w+dxx6jK5mMlk
 AbmXANnbmHSdtAcrrqCx6OaoryKlKp/F4/Ey0vp3d0XSAfF74JikHVM3Xh0wFX1brf58Ewo
 h9NepsqsBMTLjJcdJK1Fw==
UI-OutboundReport: notjunk:1;M01:P0:T1F/O8tuGKY=;8C3hDGFm2byWcFR6qaQV1xGG5eE
 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
 1LNZMUO+FYDUQ/nMlxKKGkrWgdpKQ
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


