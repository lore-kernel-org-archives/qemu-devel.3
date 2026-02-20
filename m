Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD70C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXc-0000S7-RN; Fri, 20 Feb 2026 14:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXa-0000RR-Ie
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:54 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXY-0001Pl-7Z
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617107; x=1772221907; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cpA3bLKvcWFGTFdoJF2+qhNQW800Mm+KydD/rqxCZ6l6HEl5Y6EJgkxoN2vZdQFV
 YaMlmBUlD3QifUg5jPaOQXi1IX45Slv3rbjhXkjj5lQoTD8RKE8S79ZN3MWBQwOUS
 tieeSl0TaRVGDxayVZq/c25n1H5hAPzsVEqVELRgaGNsxgTvSUgFyso5DnfhjAxVp
 K5Xlf6qiONi0hPgCcj6uVoSQJGDkJU/d+keSwH4uVC21OFRzNZcjRgTp1cQO5LLIx
 gKrhyQ6OX2SXFm/F8FWhIgZZC85MBGwRy/3ydS34Dlr4hURdAN7OR6SEAl23pZ/Vk
 x049AtFuwT85T6mNfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1vNhtu3Bdt-00n1RV; Fri, 20
 Feb 2026 20:51:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:25 +0100
Subject: [PATCH v10 03/19] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-3-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtNR1IBDN9PtIUic/Lz33QuA4XISp8xFzUk0
 F1l90Azh5eJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TQAKCRA1qwsonF2y
 WMU0D/0bcvfak0DBaZuQPCIY8gy/M9/8xZhPCeG13uEP3zubH3K1Oa7nvBKCiTV7EwM9Skw5xfQ
 WFXznbHLVhTA2ETgbSp/cMml94rACKMqww25hVgi9SJhAJ/3iiuak5L0wBuWaHV7K+o5+1c9RHd
 NwJznu9YIv0rLbMlSwueMNTMQt2ahwVKUZqrfgKsGygiRJPEcU5k9SzEmDAq/uoWQToV8C05W6T
 ZSt2QoRHn4c93OnW1KzZ/shfFC2LZIG9aZBzhWITOmvGNAhWGI/QB7Pg0dB8sho+aCWVP4BSrbZ
 ++JxjL3Oyn8IDEsaU5KY0IQSckS3au/Aqdi4IJ5NpGZdNoOg23fXEJia43PdJfE7CrFd28xh2Gu
 rwjz6S3GK4uIB/749s9dPBkbmcMo8FraqM/F2Ro0HFE53Uxw27KOPQhCPMbFDwo6BeyLo6IPcoG
 u1rQqsn/TpmAP597ryQfBeS+HADKew2gycJCBu9zaGe2zAQFgy8HdBOJCjb0vZXwOfRy5IhYt0k
 ENSFfWX6dmJl1DDqA0DOwpFB9hHX6bD6WtQbQ/fpLp6ywDg5Ma57nIRLWB44ELGtkiig4u1o8tM
 kF2krqk7zafq06a0i5QRrki0SlRCEHmj8uREHyk+0V3aq/bwCjFzagrKl9WIn28IeJUqK7VQjyD
 /Ii+nrw9Lru7V8A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:DlCD7URn7if5pqgJilW4m3FRxD2aOonnUwin8WuJ/vmlBnjIcY9
 NxK2x0DO1KmPygRsPxQd5OJ7XGIdw04Nn8f88Sz3JN3PoISC/UHxd+I9J+2TGVWEguq9kfi
 GC0GKwqTO95cuKzmh/DQUUTCEkLDSd0SQdNZs9z9NXIzx6TQBUBBd0idf9V3GtLmr82X6VH
 REBeYU4FZ1UYs3MoS6fSA==
UI-OutboundReport: notjunk:1;M01:P0:oi+n2wJ+FyA=;KP/2iRmnyetq6Qbv3H/G25x0R1x
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


