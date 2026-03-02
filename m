Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B3E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0OM-0006wz-9E; Mon, 02 Mar 2026 05:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nx-0006YI-Is
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007HI-3p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446811; x=1773051611; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EnQdERowk098cGs041BR5IWd6Cn6ajh5HbgZt8BPLtCOa5Zbrs+DJ8rIE7lWAx6t
 W0i3jIx1+CC8lZA6SrabuGtDq+FFRuY3NeGtG+zwBz8zx97dQ0vJJtlsXAp14qiQh
 RffOgW9UKenYAt/Xw6MxknsLKGYxaIXq14DLYfs4f5qmMFh+89zuV8CnAWv0Xuhf1
 J9NDqbcDWo4ipX4HmUKctLGfIoBGv3Wl+JO6HLawHVP5YBzkzPJMLvAU1+XTxY9rX
 yHLtSjwWzcVM2H72wzDQIMjwiiQkARWxoAdlXiMTiZT6WzKocQy0DydmHSPDWKvHG
 HFF2hMxXwWw27lPagw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1vmNXs2x47-0182YJ; Mon, 02
 Mar 2026 11:20:11 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 03/21] colo: Setup ram cache in normal migration path
Date: Mon,  2 Mar 2026 11:19:45 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-3-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQomQA2MzFHIt4IQwZGkCoDQdUNdWkm1u2iw
 wulXygAcPKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WAeOEACc1mfXOQKzDFvAOW4QZ4K7+CIusKemxe/5Q7NtoNUPqbvlY7f2YduBH3MZDxgzJHMWAZR
 /kfAHsHtXt62rEtUNE44mzjqk52XhVMl3YrBVW05Ov4NVRpemIRre3m1rCapim81XYEbEDUhfdK
 6r0Efxdk6Xf44dfOvchggGIycZ6OppoF24hqRE33Gj606Pegsjc3A82lj8CrwvUP0R2j3NPjIVe
 n0L7nf6cuoqRc40N+57Xd5WCZbPL8/p3Ot4+k2K/5ZUc6BA9u4tKDdhtY2HMSPUi1qHaUbCDhCJ
 yF1QwX7wxF7QrZr73vPGmTIwBawULyismdlkrh9efAaI8pDGxGkNj17Rk4Xgi7tHhszgdZT5IE1
 9nW2cZ+yFlXPxTCrE5x6X/AwJaKekDOcHSh7XHMnIX1XabEnKJSDlZnzwHqqdpwxoi9fY6HNQXh
 ZXToInxAJMGPoA8ofv51vGzLf/1+xqfwfiMkR8CoTSHorghJohWuSucekGp5tXKO4WTwbFSNfsp
 z3vyvgqFj9YKmRQ0iVH96Uq/Up4394DkE02kj2nfKLWmQx25y8wmLzSbakOQ7zIxWYVSbQthoiE
 iGH+YML6NuCGgg1zxKo456ECM4WORK0yJOK1kG1OHNXLhb0eBrw5X8pzom92bbY4XlDLSxvz6yl
 971uDQRt1y/0XsA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ph0PTTFv7mscAcA1t10D88DqHj6lJKnTtfKHCDPmZnJ8d5+XY1a
 lJ5VHlmohbFCDve3/Jf1pt3CiXWxpjA8xAolBpEWAUKydvf4mqEYY5TW3RojCEUC5a2C1Ic
 cSKZbJW17UtNXHHS1R0Np74N77cYFyOZ0QWfla6aMCJpO9unUBN4FaDKjZf6815P6OzsAjo
 q53yqLmOLquJ4jAP9gbsQ==
UI-OutboundReport: notjunk:1;M01:P0:9Ob6tlLhyco=;XSW3ImtEsyJko8G0vnmLJmjeLQy
 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
 ShfpHBcM=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


