Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC96EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3b-0004ND-2m; Fri, 06 Feb 2026 15:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3O-0004H7-4f
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:49 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008Og-LT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408204; x=1771013004; i=lukasstraub2@web.de;
 bh=g0D4GD0whMF9S+29OO1evM+fgXXSpdPHCqCK+yS42Eg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Re5dQ8JihhnOoGMY6YjCWEgJlSwWR6cW3+H2NR94PR/eTgUrscTZtwecd6+L36ST
 RWxGjyR1U3o5BHb8b+sNoyvhRVNIQu6mAtqNkdIDJCPd992DmZgFiDAzyERAG8BVl
 8C+HRjq4SPeBRq6/1xVp4jg6S/E8e0OTHLAPnIAMaLpPcsWnEIxdfsp+ft0gtEub1
 KJRq5v6xgoRstEU42mD8kSYeMZRfzC7S3KWYWFUSeN8SU5iEo0eSG0HBiZCI2dZMK
 WniYylUTnsYQSVHBEXEymqvYKYt+Ll1vkbaSzWExEt3uXeBk4FtvDHsodpLCa4B48
 U5LB68rPBGpVaUH3eQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1vGDI41vFH-00aCeT; Fri, 06
 Feb 2026 21:03:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:01 +0100
Subject: [PATCH v6 03/18] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-3-27779dda139d@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1mMhTslV7cg6iKWHsOFtaZSmCzWFWpfBUGInMbVbPoU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFp/X9e5Izv5rudSlKljfpH7Vl112iblnzW
 8mwMHAAtkiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WEz1D/9vy4ArN7Pw+gWv7+15avPP2gfb8QDJ7ey/RBRiXo71OGINlpjs6dPFX6tXz3mOWAvphBd
 pm16//Df5RKh6+m65+o+5/qHiZTvVnRWDlQ5tyDp/726JpsZ/ssg9STN8sa5cVm2hnRfFqj+8PQ
 JApoWEul2pUkaAH2qto2538DydSAyBJgipxeX2VboYP+K74yaMshsx+lVHzgoi90Q3OJ2u+DOGL
 2UT39GQS/wWj6OAtslsfRdjQN5+THa7BFwww1mgTo8SkNOsnRl4TrI+4V2QfKhZz82OTkp1gV2k
 E6fRc6nYJiJvePy2SzMakgfe8xxFu7gYK5NMfUDsZO+b1gQFSqA7U0TyGztEuX7NBJNyJYA0dVu
 HZP2KMN6vFqp/6E5rJMFqt8WwVj8iJde/YuV6EUF54bAR1M+YERf7CQAA4Rd1NqVnb+573WnvJL
 IOLS5VcAU6THothS4/nY5pBaUThfEHIkaK36WOFpCJUwdrFOMjWdKqBayQI6VP0yMwOZyRPcCuM
 Zp/QRQ4gAjazE12Fun3ThD0RoVHierRfttr6jXkYUlHg1b7ZaabdfSNBvoJmKPdwzihVjJWlNKu
 MzBshhnuS6/35vJmYTTcLO8mNO/AU86Mn0P1dSqb0KfqWjxOKoXA0lpMBQalJIm375XDrDUW0/6
 NYA5UdTbzhBSAbA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:jDmw6TIbWrezAN9DhH216X2lGK6Qe9VsovURSoj06nGqPYmPuGk
 VLrHHBYo/+tmCidno/B6hMmCrXLSWqaANOjgjStt++tFLwc9ArocurbKs9BPcvGi0imz1f4
 +X6nvxVymv5DbPVwrz6CeHaP/KufYHrFK5sURcYAvjd15eu9Bj8c2SDem8LRiKST5hVy+tW
 8weGICdmXhGzujH5MJ8fQ==
UI-OutboundReport: notjunk:1;M01:P0:I92XF7PN/LM=;e7alJZU9V1veBH5HPEmGFKzmsu8
 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
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


