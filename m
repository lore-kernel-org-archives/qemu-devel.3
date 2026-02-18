Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEAFE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7b-0007G3-VO; Wed, 18 Feb 2026 16:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7O-00079q-Ui
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:30:00 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7L-0007OT-I6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450178; x=1772054978; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dWlFhzUU4oJCHW3ti6NMHbxFy3qFqFNofZEQj4SqHCS/orH84n0gPIcGthe1XNRI
 k7KsjF1/iWqKpG9XqFvdy15icylP9OrD1ttVUJjdt9KOmkvdwoMgpZk8YBzy8ST5O
 +S0CDNpRHtgHiiOYJZdchNc/MNMUDwUUYgj15fW5dXTGUsyYdQ7lzKx4bKMi1XcfX
 H2DNGU6W2x4laGHfu2gqyspOO6tbI4Mu95Xm1/HqLtjQh0EPt7eRcnNfVxibDx2Er
 SC1r6Da7nHv5fev10yGXlpAX41Ic6nnMWQFj6JuasEakNind+/w78o5wXecw951zZ
 PktTn8sZgHaTITw+CQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1vasYS0tvO-00uQuH; Wed, 18
 Feb 2026 22:29:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:23 +0100
Subject: [PATCH v9 03/19] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-3-d8dbdb0ca6f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli88cdhrumeMs+ynNMRg7XsVvDSlBfiYoMEIT
 ibFQ7+QsyKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WLVOD/0XHBb1mDtCPE+/KYbmPGE//pf7wpIzkeCrOec8HGHOTBJZj3fEXXEDL8V7jnAS5n6MPoP
 ClGNS2WVH/bJIY6oFRTLXT79GmhXS3N33FdFjVyWvKph7v5olBeUPVtq1uvWVwrkagtb1A/B5JH
 HFsVQAlnhsDaawSEJ4HaRCUgPTtl67HCkgJw97beH/qK3Pk/MQSFNiYCBuIMfRmsXiRcTI4jEhH
 TXP3il77urn+FM5lK67CrNj7WFdWXJpd4hyyl8nQmqB01kP16q9NbZkIVo66dt8w/Yu/w8l5jYj
 mp+UkspZmFzSvDS1P+M1n9kvPRVO0unl7Qfeg5TWn4zmjsHxABKdHLdk68HTCV+A2qUDsJYz0vn
 xa3YFxdyKXjZHS4o1NnsuhNCYSXrz0uTIxKTc8n2lNE30eb9OqN36yDtW8Ip8knd6ZccAgSAL4i
 EnlLho+iUWo006Z3vMV+ucJ5hpd1K7zkpoy0bjxc7dhW4LOFWvRlozKPTgQumc9aYp6tGBXvL8q
 6hijvPciRHrXbukGljeXUJU8FJqpANb2mr152hX2IV2FOpGxzkebgPsJI/ODMjLGQKgi6QcJzIE
 3xZDgWxlktuoB/AHE3HmapOZ7nHb0u7dGLLuShD+S7+RSSVF0O9S90E4HtAP6iPr/BfM86CBK46
 rhaMdULo1yajuEA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Jeh5pGsW9PUxqfjpobtZTILo+/ONWgyjcfx8/SBiJpqHz62ZVgg
 7uTCAiMyIu5Hze9/DR6+f4Dybe0vs1LCA+naktP9YRNwE5L5exHStrJKmcYHcYyseGWThIO
 ZWY310nvQ8g17zVB2D357bOy6/Citii3l8jAuXw3WRmAR4JyBlevRcdGH0gdVuIgXgCzewm
 0cgzk1oZ1AzQxRyuqRGmQ==
UI-OutboundReport: notjunk:1;M01:P0:XJ7MtEUA2cI=;JuwDuC5B3VHLWpxTYAvOkZfaLN2
 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
 7O/ixIGz/tFXf4njIGCh
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


