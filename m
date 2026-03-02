Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5402AE9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hs-0004zO-64; Mon, 02 Mar 2026 05:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rp-QA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:40 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-000621-1S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ofy3ghbrMjpuPryXg6GNcVf6sQyiFtDeZ6J/yfWl8PF8GTgqay3Z/LLa5S9o736W
 C6Z/ld8LkHSqorJShLD353GgLGi/XkCC3ip4129jEJutClsEoReZ3ZiTtE+kvaBD4
 pQvmGWXcK6Oufxco3hMElQ2VYXe0mtGXQbs7DTsXW68ZCZ5FhG5ZQI/XAT7NK+rvY
 NBDul9cMqE/Wact3+Fkg/2C3j2xnRPi2ZxO+qlWmcOXB9VpJltU9eB3fMdITljY10
 Fz24wL3CN577BEDADhUlT+cm/5chOFgogQWRgeYyZ0NTWcElx6lckRud5ihrYSg+g
 G+Ugaj3PPzePu+JOYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIkg-1vP3VC22Iu-00hB06 for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 03/21] colo: Setup ram cache in normal migration path
Date: Mon,  2 Mar 2026 11:13:14 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-3-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAEVmhdzxpzDCFQwPTXmCYOdDJiYV2vim568
 E2Rx/T+gIWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBAAKCRA1qwsonF2y
 WP1TD/9+3htYJH/40x1aQSKhhtRvxC0YcxW6OeTrhH9c7i+LW4fhks1KgWcgDqA68krn8keigCJ
 ot0VMBWo5bDYfBgwCNLcreMCZh4hiBs5xIymv6vLUN+a/IrXP+KHR7J1XCrA+38nBTuLBzaSA0Y
 zJMF5pztB124yw3pIkLcJprGQy1vyqgcqSGTUO/Di3nNI8p0sNe+cxOklV41drDVQTh1VYQcsBz
 ykaTEaUwTHav7HL3TsLxuCwZpOSDrbGpbUDpieW/2G5mgqlvQHnUSW36Hzzx2qpqLizGkTr5PCt
 +L9Dc05aYWiGaT0SksLHVgx8Yb/Q2gR08psSaKQnXPLQjlGXJDITzuh5u08e7X2IhMq+bMVVFR6
 p8oL1ahBjW1h99vm1zxsrCwIChxUdggU9TgtcwJc85zXp1cGps9iz/2fKU9LUVf8Phkn0C+U3S3
 HGMoRZitXo7JCLETj2vR+h33d9F1jTTtgLTQ9ad4QmHE54Kh7F5Jp3zONJ0BJHEHXEnoDsKOS39
 z20Xwdx8H4zZxaEVkdNEvaJSPeWGIeQrQMDWEHRR4IUbFjAeKJxZx6MR9sTeQnmQwbZE2P0mB9b
 jydMuTylb9MNvCyWIN58z4BOjxu9BgLtORMYpr1Xjo8e6IIgaSiK1wtEhmOfqSnIBDjY/5PvE/G
 ld0+SfpJ6gck6Bw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eD8Ovf+J9Z0WU6pZF0Vsm6dYVWeh7smnv2QR7yyKyZInCqho9i+
 fGkoKoKwiOcj5P1inh62CUrLIqq68uubERRTD+rGcEuH/UIbXa0GI5vQV7NiQd4c5uzBez/
 kvU1XQQab0EjbonP8+/fSVyhuXgTnP/kqlNJ0eFa5KzXxQovWXPKFoDXuxES6suFud3YiZk
 bszepnfZR+8OXxWTbWUSA==
UI-OutboundReport: notjunk:1;M01:P0:R3zT0kodrhA=;XpCPy3z9grOLdKqcXs7T3x2r89M
 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
 pqZt4eNr59h/KbB2U=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


