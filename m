Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E2EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohc-00058w-80; Tue, 10 Feb 2026 09:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohS-00055q-0O
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:47 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohQ-0005jS-Ex
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733599; x=1771338399; i=lukasstraub2@web.de;
 bh=2Je3+6AqZSnLVm8uuHSb30760gu61Fpz6Kj6xfR5eBA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OUJWIQ9H8uAW+AyMJ2Zn5zS1JSsdTnjY/AEhbzZZMMkh+Jaq9XM8TGe2gff1SQ2+
 jZdXIYgjVxe2netiKCjiIeM6zuCDTMFNpmzftXH07K7G+smSXtQ/qyEObobjxVjSn
 3slxCVW8c+t8cojvVa1tvpe9CYHlndF7sjrVS+8qjTq+gRWd7buaLPP4viMa7K41A
 kmEDKXYkDW11fFmUWnccsrvRMFp/wrlJRTKRjZJn4ndg0grC1QlxWj7J42KIYLN6v
 uBaXePvAD0E8Moh049C2jpGGCh95n3v8eAAvwYda4rvQuceuAq29Tc/q/EO8wd2+4
 HLu2rwWbOug3gCeVEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1vojIZ3HG0-00949y; Tue, 10
 Feb 2026 15:26:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:15 +0100
Subject: [PATCH v7 03/18] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-3-23bd32f36828@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=2P/9ztw9/gwa5O+sAkz8Smeq4Vt2ZazojIRUwUeeeNI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AbNmLy5WqcJ2xZKDkPs6wR1qtYyR6+BDx7b
 0w44RUkxQiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAGwAKCRA1qwsonF2y
 WPEAEAChQd7kVcwuDbuQ6iSYr2V9nIoV1x/SJx8v9YwzFO+6wG4I1JZzItrbG2djn7Ka+sZs/hB
 SgAiJPXjh46cBdf04rv/veBWSN5iKrhgn/CaSGXSTR+9uWqOn7XqCyliVqdq+tZDN2HXHwvtqTz
 gPb1Qr0c0PhHIvXJ/0PccRpelh2ZUpybuCY6A/lk04H5TyT1SWHp4opSCtHvFVQNHY0vg8uxeNe
 z6Hodf2cq3QLk/IVnyl58RdTgzxexdMnYoWJn6NH0jDkBPQDFtlh0AiqiPw0JPYl8/TF8RlIcIP
 QkXdRJMODFkaYklQpkOvyy4brxz4DzgGLz3ktHAhwnYdlfP+iTIDNunXYOYLJr/T91NR9mgdyih
 bk4J1r+Ni/GXonmaSTRUCHbOfV+/g6KwutxcuYXDB5Pzk527Z09QI6QPn8wFeSdIyjgx9DB4La8
 HR4id1to77lO6Jlkdxr8sjhx6UmXN8M7AkfZDdNadYRBcTbL6UuU4AqQPPwgQtQrIXZ/9Ro0m9o
 rs+P9sOQKQ7eCGqOLRs86V2wGu9fnEPIkxhRrJcM31gM58bp8cUxwKvcv7stauaJyqKbuMj0SCy
 4JdlmD467NS+UJ9yZoJxhvDjd4iuUGbZD4jUNGmClDj7HcCGJACeZPtG7nHXDXjrsvdcjr2ClKx
 Rww4LHzjHrwNFRg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:9wEcGjfibM6xRmDOTDrfyZSAYxfPnrgxCL1dqYeFbZ7dR2NsKnK
 6ou4s+y7aUfmYbeX1y5La1yOjLWehefQttWZXNxVnD0QuMex8gS+DirW27O+CuQOZBpweij
 Vzu1SUiAy00eXuj11h2jJEoRi8FlLnP8O0pILI0vm9u8APo4RuByFV7cNq6L4LOyotfa0pq
 acsdFHVyjdsgEMvmoU0NQ==
UI-OutboundReport: notjunk:1;M01:P0:R/YrjJr2fbI=;dzSMA1+37J+tn+0DS21hFKhe/9d
 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
 qPi7euGWGncBxYv1rhBw
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


