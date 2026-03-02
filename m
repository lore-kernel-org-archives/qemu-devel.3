Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E994E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gt-00055a-PU; Mon, 02 Mar 2026 06:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gq-00054F-0s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gn-0005hv-D5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451825; x=1773056625; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iMjtV8fNyUhfSDenbvaxuKBjbmOkEQRv0zFIO66Y+UTAcYM+PRbgn6magqQHu1Tt
 t/hGMbZWGG31D7g2MSFSitYYlibh04ZX3qpcwoWkSKzwvwapuoS/di3KzJoLt5r8H
 afjqpvzXtLr0abvFqOcnTZqp1dmqZF4RLhwnwKuQql8aDrmNOCSgS5RPd1Qa9RloN
 OwMlQFscNNX1jtWRSLxHtgzSvq3XQCniVjQrwsWxVyKXg8fd6KUiHS/9KG3Jcp7xH
 rovOKVTe8KI9dYol1wTtGeoXGp62wvAnxnXVNPqLsFMeVjzUMG2qixoHPVCH0IhMQ
 /G0vfj0kiDlEG1/W3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HFy-1w3cKG3E40-002d7K; Mon, 02
 Mar 2026 12:43:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 04/21] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
Date: Mon,  2 Mar 2026 12:43:34 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-4-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=n0JNkGWwDvp69U+jS7cX+vJwFoFOUey0gb5uYJ0EtrM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TXNBOsu+nuQuLCOk2AbPs5VS56PbejSwK1
 8tfFbgqeVWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WJXdD/wOcG0Lvh1P1TGgizn7SFDCVy31E0iu0YQsYBUTmSlZZR78bUuKof4vSt1MtAMtCEhgOY1
 26evsGNyBRfU8I5VQbEOeipT6hVt/l4tVVI1rGFL6OBzHbKgqRKLGYxGyXtkVsr9WuCKFfURi9W
 6ktu/S774ns9+DMdCB23aKD2TPOJ6FhP3hWFfSxMO2kI4hMbGpyVcZmny26O4Pydea92C349q2y
 CL2vbFI9BpVikV4SiB/I2uvR8ycjrFTpBrgDZZ05Nd68jEjhGoSIcU+VlWcrUePT7r4m38nXsd0
 n60EuY49HB6xLRUc+MP0oLCIAhjawc8D1UwKXpbzCUI2LhpHt1NrBX8Gg+7Xyxxy7wWSbQqYxsZ
 za9a5Rh2PNfj8hBKWz4FBgzG65tmqiNH49jqcl0CbJDrO9d1DWBp/i/HVnodluJSrpwTYH3h0sC
 3kSV0u0t42d3iWWIBNnOnHKceUKAGMTNC3RnqJ0Iu4wBsqD9WD3QK9UmxaSHYM1Zr1MH0KaESvq
 OW2FrzUu6btYfqicglCUgaBpPUjlSXQ04RFzoa7nNubJpWBZNqU3a1UcgaLBvldSWU+mWJgAugR
 oowXqJFtV0j+cf02DTg45nIMNBXw3sA3NohZIucEBEimTwf5R/obRQ9ju+2c43xHFXZ5IvE/F6S
 ILLgaCxfo91yy/Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8pjiqZtEaIUL0c4hxMp03URyth2gB9FPuVTzrkx6EtQ+pWTQI+p
 np8Q3g1a6yQ+Bg2LO9eYIToYiPy72BGLE8x9c8xsMqSJj0BjGWXVmBGEaz6NaSvv3dbxJ1b
 LZiyfhSlqGmUXWeQFCFAn6q2RdFYt5T+Pn5FnqYkrqPNZZzQLa77O6c/EJW+MBN8hxh6My3
 TP2FgXueZq8+4Sn31k9/w==
UI-OutboundReport: notjunk:1;M01:P0:K3J83JVPXy4=;xxbQG4q6pNhlC852dzT3MP9jXxL
 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
 Wc7mF4tsiAf0aVDaKZxDOQP9K7n6i
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index f7a5bd3619a49a3b4a8306973de7a4411cc0df58..97a224c39c49ff2269f375db47=
112458cab0b4cb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
=20
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
=20
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index c2b9621190f8678ac6b32d6794d9bcb6ffa5e402..ef6aac53343f2217cd1aa37e49=
3483703068d1ff 100644
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


