Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9359CEB26E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWd-00014T-P3; Tue, 10 Feb 2026 11:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWW-0000oD-9c
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:36 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0006zK-0k
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740603; x=1771345403; i=lukasstraub2@web.de;
 bh=2Je3+6AqZSnLVm8uuHSb30760gu61Fpz6Kj6xfR5eBA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=N3V92sbIHwxeYZIdx3Hd3TjGZOP6nGOoKTu1ZPvgS+JgWQywhDqVYmxbxx6G8CTF
 DqT93SC/vtFP+eW5QMhPrxbaA85qhheO/WDVE2n2D3jF02VP7jRDtBnVbw1NUTn9t
 cQZ0Mlt385yqh/svZhiQ7WbTckWH2y2xbiW8auCsZOWNy8JrSEJvSG11i5XiXrwbh
 AFQEM+GtLyE/QH38TCNKABScTCbLlaR1+Dq9fekWKVpcbq1fvfJk/6uTK8c2eqQLx
 y+B2ntmuy4A3SJ+Vg2GiOaf9ALmS0OeahyoXwodiCXOaFPo5XydEcgyi9F9zBJUoG
 jKYaHwhyEvVdwvtutQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1wEHFV3hOB-00Udg8; Tue, 10
 Feb 2026 17:23:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:01 +0100
Subject: [PATCH v8 03/17] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-3-7f9e5f7d082b@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=2P/9ztw9/gwa5O+sAkz8Smeq4Vt2ZazojIRUwUeeeNI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t2RgPDcfDHJHkFpNAlu0nH+AToMQn/9+Oxb
 rb2ZVSZIJqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdgAKCRA1qwsonF2y
 WMRZEACH6mElvwu9S/wfoAs3lktPs1tz8/PQdy65VgDWhWU5rGeRCPS78TK54O2TTvKztiTs0an
 0rNnJ8eSG6YzJvwJSzgAVKmSlknjww2s4EaGZqz88bp3Ucrbgq3Xf/LpnR1CeA0v9z59HYysuGD
 ChpVq2qJ6hBYZyV47thE0aFPDIFFvk5ySXnnnZT0XHgG3VluUpDi84GM7vBl9BAwOWog87Fylma
 PkLTo4SNLIQBg5+htbW8v4XtrJkfJAYIl9tOJkhLGx+zjFwXQOKUUUgXLbiKsJop19Zs23DJMfa
 1VSsUTGucw0UJUOlYqKlrK0Q4gPkKlVW5i4aIaX1nU1fsm7GwzrtR9tNWfT7Mzruh2iDsHCxntb
 OFxajfwJkkXUiun+I7wJEDrMzitefkr396m/jpfIbP4XI5kL+22EdRpWA9T9Lv1JHaOyud3JCk0
 dvQhpN9Zm04kNkjn82yuXfOJPy16Ya89YF9DC2sR7ydIvbBMAWkZTNiTlJ6NPZ1QKY4398JPxi0
 PgLbEaeSipACfZzoW+QSQyD73GfP0cy88JDs7Bkrp0YEBTXbhY/yg0hKLmHdxEy29K9vtvPsBoU
 lFkbyTE9YxwYDGxTMRcAogg64RwpUUdKE2s9ISPL81GXbEAdcSIpVFzLAYT+9s74Yv8qQV2GV6d
 cAeuZcBpFYslREg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:qL6ZHC2S4ZjKPLEH23MG1sTbehugkZB2T5cm7YJfA0HY6A+ek4m
 nKOY5oL33EYJyTXnz3lPPcjhE7I9VhNfA5FlEksLtwz3tUMP7xrlogkQoQ5lNIY3kg0GP9Z
 b3+45yGqaORjXsJSNODsVxpA32xF+S6yDlf9QxRpUlYjkQNF6VOwguIn0p9qL7QyFwGHBKG
 qcqlb4UxTnStzWzp8dErA==
UI-OutboundReport: notjunk:1;M01:P0:QtFoF6Zs28A=;wkyuP6cGVXu6JrUoW2PYYdHaXwe
 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
 MhM50iv45wzKU0L375pa
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use migrate_colo() to initialize the ram cache in the normal migration pat=
h.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 18 ++++++++++++++----
 migration/savevm.c    | 14 +-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0b83009d01d238ff16c0a542d83509f..a73d842ad8b060dc84273ade36=
ef7dc8b87421f3 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_setg(errp, "COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
=20
     assert(mis->from_src_file);
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_setg(&local_err, "COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        ret =3D colo_init_ram_cache(&local_err);
+        if (ret) {
+            error_prepend(&local_err, "failed to init colo RAM cache: %d:=
 ",
+                          ret);
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bbb4e8f5321114c9919d4619798fed5e..0353ac2d0de819b6547a1f771e=
6a4c3b8fb1e4ef 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2407,19 +2407,7 @@ static int loadvm_process_enable_colo(MigrationInco=
mingState *mis,
                                       Error **errp)
 {
     ERRP_GUARD();
-    int ret;
-
-    ret =3D migration_incoming_enable_colo(errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D colo_init_ram_cache(errp);
-    if (ret) {
-        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
-        migration_incoming_disable_colo();
-    }
-    return ret;
+    return migration_incoming_enable_colo(errp);
 }
=20
 static int loadvm_postcopy_handle_switchover_start(Error **errp)

=2D-=20
2.39.5


