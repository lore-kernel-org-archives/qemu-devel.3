Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F773EE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3V-0004I3-J2; Fri, 06 Feb 2026 15:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0004F4-Tf
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:39 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS37-0008Nn-7o
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408204; x=1771013004; i=lukasstraub2@web.de;
 bh=acIbGuWiYVbHQzrhTfvGmU5crz8RI/HnOnsie89+6bU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CDRwYoLPOs8iI9snbf9XRCJaws4u/VrzXSMduiOJG4p9iiKyLPgLkIqXCWHqnZy2
 Y3ar+xWRdtWh0jrPJqGOo2BBfnGWPoU7MqPvQTiYoZAU+uLJiB0ESFEa8wzK7/ncO
 lm5JqDkdJtkkr+O5Z/E2QCSrA1kP1tIOeRH70b0BW0hOkOfvWKL5SVvGXlmWSyk1l
 R+32Cs3J+WMtzzgWR627n+nssg+G+oXqFkHeJSxpIRUFVK6XAlvMOem7y71oO6dK4
 8IdvpzOMRuwOt47E5q+KwoCiCpWZ+Y11Oh7P9kJLTviGSt/I7A+EkDtgdHqJhlgju
 pfJ6gQhPm5icc74qRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1vFwJ81yNK-00ZvfY; Fri, 06
 Feb 2026 21:03:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:02 +0100
Subject: [PATCH v6 04/18] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-4-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Xy8q5Le+j2M5D8fLVu4VkyakFnaluhNaPAzEkXoWOs4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFkWnVfD13rCkFdPfETMlwmTYO+tMVY3NU3
 RmYgOVVRm6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WPcXD/4988xxbBkg7MUn3K8kaBm0vDR6OGN586/xa7O6S4sNwdYQiht/nCXKejsv/Tz64O0AdWZ
 ghEyO9L9asvS/ycTmEw05xICasZ9Iu6bVrmUFZI1DLtqFjzTQm1gzdcw6eU+Cyzu91mOVUo3Ds9
 oh7PCzhJRDUYb16ZcaoQTX5KK/SXeOzkpc4PYiekwCRP6WC76fV3a+zqSHDHtOB3w5D8vQruPRp
 Nps5otKJP2ToiXYgUGD66z0kY6jzqYA5FVPTOf45/F3vwAI4pCN1WFZZB3dUq0vUjq/wxNdH7WW
 fz36AlxdHdwo3ZTZwQrLWWAGrchLFCNM/9ATJtTlTOP2sdfm1aMLwQyN9V91Hp1pg5RnfdANcFo
 0alrTdh0R3KBOTmBo7gIrIkkLvlpNi357lwbjE9mmkft4p+NcjGNPjzJarGXdlVrYYNGEK2jxVx
 NF6G82K7kRWiXMxv0flq2FPFPJEYXlC0SzcFybXaCiCVUkWDy3EOHHff0ZVi91XsoAzWn9CI/Kv
 JYPRKuqI88qflqz3+p93wGlh1Hfu3Zkv+Zrf9dRXFfA8CaX+Fa2V9g+RYZOhJ80UWd4Wihk84hK
 z1OytnlHlwBgnt81VbbXDs4xJqcZvtCkZEnBWT7v+7HSP+fyoLjcRSQ7sw32eHkk8X5PDXNeh2R
 ji671RL5WEZS1gA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:js2DdbFDkU7pfAt1zKgisCVPm6sm5PxU+e+YV626jVoXHoGKBnq
 oiKnl63zC+LG8L24N0R6kGwKfs/kCkw6VEaC/iT7JeVzovUcMy1cHy8S6oEfo/HIE1URpO8
 D8KceYFQ4A/tTz70Olv8MR/67koUjQUEJPGnP9NYbkN2SMd9fPFOWAGfimSRCYyHL+mTlvK
 /tWQVc8LcUn8ByYRbBDuQ==
UI-OutboundReport: notjunk:1;M01:P0:j25ZD2U0yy8=;PW9uJN0RVFD5WqHEdLLUBOWSlvz
 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
 Y8paBEJg=
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


