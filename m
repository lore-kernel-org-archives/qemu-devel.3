Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E2BE9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gr-00054t-4B; Mon, 02 Mar 2026 06:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gn-00053d-Me
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:53 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gl-0005i9-2I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451824; x=1773056624; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IRfBS3I0ERapwzjzQPkvECHF+JaN4uIQmNAGlpbjpAr383OKgP1tfb3GgI29DnYA
 WfA71TMqohEpgSu8N4ntgztIS35lhJK60NWXirxgClvqIhAhRYiLZ6vw01bysQnvP
 zoYIsQ/PSiQC7SpFvQ3WdFAABcaaOxM7SlRs0MkGqEynPABxgWlPlYMUTLooJ960i
 7mo/lUQexgk+2idvlM/MKJKjCkucdbxS6z8SHBrCHNkp0gupDtV98b/9lnfALgY6Y
 SK996iU/d9kh7bKkhIlcDXc5i1MctpV6JPflDczFFjssu+P56Nh9CbXsoxFGCOWnN
 Sk9ukqshzmNt2Zr/9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1wHJQg2Awc-00PER6; Mon, 02
 Mar 2026 12:43:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 03/21] colo: Setup ram cache in normal migration path
Date: Mon,  2 Mar 2026 12:43:33 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-3-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TyLNZcj5GVeeb7JlehGD/MQVlW4SXBqj+Y
 fESyWok7FSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WKaSD/9bdnkKz3HkytUG400vOx9dQGn0uEaHpu5LirpfhIAS6tMkn0D6wQhu5k9Fn+NfQ/m+K/D
 9KhrzXFtlJRmg/Lui9aQHCQAm0s7gTHgNVjxEPjNGOg2m6Uxc3VQsbuw6ZI0HVh5IAFTW/9fXzI
 +pqcFmMGPNVkCnkjuruhQZtyurP39R1+Anw4BhxkPTWio8hfHkwddu2DLgqbi9NRFa7LvfTorsD
 CY4mGarPpbUhP9JyYCq7hLTRmjSUKbzofLv9VexdhCRED4Cx2rQQn01YAXwFc35bdu2NjOTKe+V
 SrMS2HT5k7gCJz7VFHPqBI787sN3/YdV24cnzMI03o8MWo3NpnWB01diITmtTi3qGA9zZf+Rg4s
 QFWQNpGMaisMDh0a68ziseu9SvpAQjs7m2lQCCesB+WdDycj+FpqwgJ4m4xHWRTZD1ow9xvxerC
 aj60Vx8sng36y0aQ/va4A7uGI/ZBrQkizegCbaUMXcKnVU3ynhJgUarxTDIvxj5gAgvd5SE7FN+
 bWLcrrCJ+DTyTSHQX9DQD0IBQOh2BMaLm4Ex9XXd5MbVR5dGtO+jOigvje+iESIhkYqAJzVcKwB
 bpuLuhDdCSVX6NjBHuWgaXc9Bq2+agQAdflC9zElA6l+pgTRtSZ2HP7ovNg/xoduNgSq1fnlj29
 nmbnsRCZtTZ6VYQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tye5y6Yra+23Xa6ZWFsMsDOPks0mgzdTr9/LU5ZXsuD2GFTSsJI
 os8wfL41f4I91l0b0kGMQehOJtoyi9Zob8Nv1mn+L6pL37Ogg8AjIJnwi6Ej/XPImWxWOC1
 NX0W2KZ2KvNjdH51B5Uy/OnzZ/8IdM2Yp2+gc8aVbjLBHpruetCoFxkfsxXT9SHzKfIm9pt
 YYTeHDo6iVkGHEOevmQgw==
UI-OutboundReport: notjunk:1;M01:P0:CI4BFATZfu8=;OZZJtxfF2NMCELWegYsDdzPahSn
 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
 sbJ5LDOE=
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
index a5b0465ed30cb812cb294ab901c7a37fe6157dc6..c2b9621190f8678ac6b32d6794=
d9bcb6ffa5e402 100644
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
index 3a16c467b25b8d93b7d40bd0db751158e0278b4f..b88851cdb7974314b8481646a1=
dd19642887f210 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2427,19 +2427,7 @@ static int loadvm_process_enable_colo(MigrationInco=
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


