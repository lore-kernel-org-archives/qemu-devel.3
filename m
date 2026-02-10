Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A49DEB26E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWe-00014Z-1R; Tue, 10 Feb 2026 11:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0000jh-NK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:35 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWS-0006yp-Pm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740603; x=1771345403; i=lukasstraub2@web.de;
 bh=RGLrJs+wgVIMusQz3c1kd0U1NF/dMrRT7BE8mQjI8Gw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tzDMcW7Fty8eh+cWvqhXBkYyNVUaMP1Z1vwmFGtudMNuq6tAXFk7wF/SD+xfvOXc
 JJbIgpHr+uU58NIQTgFa/by/Mj9MdlNXMluUV6UjwcgBO77KYriTnbh9fEabfGKmq
 1qfvgnGOGsjuN9X+tSMscu2aZpSh2Y9voTYJEmJzGom0xcPVzXGb3dYdKiY5ycq30
 Bp8izQTbZbaV9zQywDqbyUHLN/mgBj6aAYJCOHPeWRspx9nYGxIvpKRh0rlesL8Ne
 cHaNP2PvG0Gym5/TA26FMFauzuu9i3aRHnZwrR2Wx2yqJNPf9l1BStbba02eEFLUl
 brkfR88ETscEHJmm2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1wIw4r0G58-00YmY5; Tue, 10
 Feb 2026 17:23:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:02 +0100
Subject: [PATCH v8 04/17] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-4-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t2ibklwvyzFX7TuDONb9SKjrRP9MTi9QhdG
 Gpgx+OhNF6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdgAKCRA1qwsonF2y
 WFgsD/wMPIGzxj5d3WTpBLsAmVbFD+TSkMRCrJhptJbzF++MZFLagEhktb1S7bEAkMV7/XxZJQa
 9UUvT3j0Q30/mlmQgXKeQYTeES0aOjbeNqs14Nd6sdTc7Wvr5JpfT3ZfF/J8OTGs0ZmLKc/WQ59
 h6vIuZxhxWawGcVeATmf6Wy6hsFfhogyRibOvD5NTy7HAWyssIJ1DLL16Z3C2Zq3eDqOAb8OcHW
 ZqUmgiwEWJ/kFob7avroSxX4UVgLwBjHDG3/mrJpH1G6PgkhIzKzg5hBNzPvHP/gwygu8ZaMgk6
 LZ/Y9nn+YopKhEPMPxbr2SNTSv/oVo+UeAqh17Y3F42LEpuPKhf6Kw7PAXy2t64zGhLL1Ex2eBj
 tcwlnhoo8jBziEs/gUmZoy3rql0ziPom944ElV6imLgi/pt1OX9YJAKmWwsFdUG3fWD2MrUVO3p
 SYzcGQgUT0UkJEHhpvsBj+f7S4vRv589I1dPiJEE2fN80/cVJH+T3FzFIrJUJkpB+yaG4kGdqBq
 gzBoahX8Xp6Na8BhjJhqBY3REea/YPkqB3XT9VkXexUaKCTImkkcrucGY6eorf0Eae4tUbNT0Zw
 IRItyKGpFlhOTHNQ/A1rlvnvCgIdeEmSPgVxFkrccSOpS8j1+4GbUw0Km7H0rNcT76PtPJtuoKb
 tCkxzwFBoCIkITA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:QB9LPguu9NbuBThRaP22jidzbv3ehXS4+A7wxS2Igj98jWAem/y
 pBsZpLRv3zPyHNOgOActxo2IQgsxGv1jjrrhqhiR0ywC1ucrFUlL03zZm1sh8xtZkLQ4fto
 RIqPCylzxvI6WQR5ymXdeOGxuTE5TsPr+FyQBwo6GUiYOcku3QAo+YWfq8CX/X2RCj2k6an
 ecFHb27/+XaUmUF++6s2g==
UI-OutboundReport: notjunk:1;M01:P0:sxM09nur9F8=;IjJVGhVY1d0vfcnhfumaKeCcpcG
 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
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


