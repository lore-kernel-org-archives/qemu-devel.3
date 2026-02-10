Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EBFEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohW-00056w-FV; Tue, 10 Feb 2026 09:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohP-00054v-Ha
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:43 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohN-0005iZ-Ka
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733600; x=1771338400; i=lukasstraub2@web.de;
 bh=RGLrJs+wgVIMusQz3c1kd0U1NF/dMrRT7BE8mQjI8Gw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Rdm5JjIW0goBe4LcIYAWO0WltkRsJ3/kERYeUVkNO9JBd3e4ODcZ36ZwqL10PPyH
 01YVd6NPFBsUeAPWcJeSEI2pilHrWMNx2OjWo41+J9PLHujbr/wrFnpzMrJsrihBK
 djoW88IAh7VVMSYRthWnJW2+yY7v7k1Trd7+xxte0lYl1BrUyUS+4fyT4oTCLGfgY
 eOI3e/cig4m0alct0wZ7+t8yoq0/MAd9DTRodhAjZ5zU+1uQCtv6Cj07cHq0T90Bl
 JOzqWHcwRxlY4SMNa1WKmCexG3Hc7pKSHiq1F/13P3lu7tsVDhWFx6hqCPgvao3ay
 VmjY0oNewUd1w5E8IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1wFuIw4Akr-00LKe7; Tue, 10
 Feb 2026 15:26:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:16 +0100
Subject: [PATCH v7 04/18] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-4-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 h=from:subject:message-id; bh=36P41Q25Nw5TQAK0cGBt4ldQPi9+jIFYiv6lBX9NyYs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AbEOFBO3C2CMst9zobhgOfxLY9++yD9uSgO
 mB7I46IUr6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAGwAKCRA1qwsonF2y
 WCooD/9KZ+wGXhtKn9bLpwJmV+s1P7aqtMd+CEkfSiN5UZzQ8vQlblwJAoiquxpcaH+xLNc65qH
 TXE0a+YIUAYNmwt0X5jKHQgQY+HEd+vbKF8if1oZX5iNgUfv1spgw868kAsH2ELebjOAe962HNK
 A3VW0AH8W5DTJFCjY1zuTxDNZkMeuqT8Mvjg9qHRd+10AbyomxwtLvsBr/xH2tk9Sk2lpwQ0fah
 zHyMvkil9t9opy85W9WVgqwPMdUMCvou3eb/CyCQlpI87hIHfYNFWnfSu/X9GCIb4md+jYiZKXw
 t1TPwiYf3L9V/FybA7C4FnXBjE3fJJMJRHJrZ72vO+rPtz29m1kT2XiLOdccFJQlnFOLNQlea/I
 0pzJFg/KxPbUZ5AHjIix4t+x+IDBc7xun6wM6tEu0Lf18/VmlPBUCl0JZJ0cw91QNdEXJf2hfoa
 KenqC2VJZSTwa04m07iMAUulsnilAmLxAocNzZSAzctNrsUiGrvPzfLce0hqjlenIdGsGvOIOuQ
 paYao367zzW8iL24JsrOI/o/13ZkeVVt3yIAjlma8x69v0slp+3WW/brPgQaveS7Ahcn52V/k7s
 H9WYBifZnCpnDJdH2vSG9F+l1aKDjYUO/rSifV76dWgyRfzDtR0b1CHIFNIsXcpblrpj2i7p+8X
 bOr03HeKRj4E3BQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:henhk+iDv+kZBofzKGPrAiooSLUEcd/u1XP9Zcy7dHLNVe0rtIO
 jt7d1+yGAs6dFjIux6gCLcs8WOMnfUpXkLIRGg8Zn2uLThsXDzzfpnq/43gzEZjewZiOuAq
 SWd2oyg3dn4kZ629QWd+32wj/mpSHvRjzkiCv1QHfC42i6FEDPNbqoPsd6bhbyyO7gYFsUT
 psUTjalYfLiRUrtsNOjcg==
UI-OutboundReport: notjunk:1;M01:P0:QWtlKm7I9o4=;MUlrSOUWS1lYExWt5xA/dqo9yrH
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


