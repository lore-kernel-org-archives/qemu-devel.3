Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52188E6BF08
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOg-0003EQ-Nz; Fri, 30 Jan 2026 07:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOd-0002bZ-PD
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:43 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOb-0001rk-DB
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775275; x=1770380075; i=lukasstraub2@web.de;
 bh=0Tmq/TJdppSlXI+Ubgri9NcvnLS75IXkYXb8kqaLOJc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ny4DEvQW/wW8QcUH4oSLxFRiR/iJeJyE+esZE8nZ/dDd8vW9T43b2v7cxxlayD43
 4LJySZQdNxFLyePhHFbPwALPEBPG7oJ473sf+tqzio+HcbPXWJPTAlppH1p+5J0CK
 lK0M8OR8ZTeL3wzGiniGBmbUV+nwy8zdE0bN/7dmjKqmY2HQrTBteixBigj9xhl3y
 4GVbNUkR3d7m+dee0b+ESInCDi3dT/9oWOTCDCoFtp4byTIau4Exasv+a9yhRx4FE
 ynDiXICSfTYfgNcUsGR3ERhQ19D9epP6Ek31/KEZFeaMunHCxpAaS9Oj7pfbtCqdN
 Qhdoh+vweuaQs1BfBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKXb-1w3bMQ076n-00zofR; Fri, 30
 Jan 2026 13:14:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:13 +0100
Subject: [PATCH v4 05/16] colo: Remove ENABLE_COLO loadvm command functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-5-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=DzUjPHH1LtUOC7XxMpQHlfC5aCTE4w73hzWlkXM0Lo0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClUjvunZaVRhgmrU2cpvudBpLyDHs8pdSgE
 HficakirceJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WOsWEACWHXYygjDOB1mZkgw24HY1wDY4lAD9VbmAzH24bxYsuJ5jB5khRjjGBlwETd9cCVnBKh7
 XK9M5GfFZNybwWSTBie0ErrozFKripHlvvsfaYK9h6GiZVCAB7rtqEIa3gGVEzQcFM8HWfjXcHn
 ic/MlSgxaaOkc1DojWqUoPnm81aaA1TtM5rWaaQ6W6+tu/EnD35b2vq2N0vJnh6N333g1eBI38K
 8RuNWhxL6C73nRISkEoRIaUEuF39iBtSmy5uVuA3XR76HXb8DzNnyzBWVhIiw9PEjM0zJx1LUTg
 lKRPaHbmP10vpFYSG5JyLI2CY+I5b7LskqelK8f4t8XVB3HEIYpBVHfWm8HrVYHkT0WQKlL+ZC8
 aShIc2/tlwYFUi7CadLIEEEtyLdVx99emmpqYCxjjihSSA6j8OY2P799DOVyV/rCwfUSHHU1pfo
 3VYoD4EyQ0ELHvy/8CL2veCmw7INSKz91we5DmLn3LteKV+P6GgK846ghbSdouWOmNQzpXirPxT
 Ov1HUZVK8f+t8719BMhbBEkMTU+MbpMUFwadHvYzOPXSWWYVYTPrKKcbHx6F7+RjBkBBrzwkHEe
 l8uXmrZh/qBPFjzwsmNetMeYQAZMd4jPVJNPPDgOWeCWL9SyCbpbbZdbYUWNNb7hZpRJzzeK54Q
 ftx2G3YpjgVCTOw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:NHHdA+XflQuzDNx4M6ABmsdxQ9n31mPHMAFx2RXIfP8HkdGkxX3
 0+ITcoD33iuEyMjZ3W6ryDV3h/vUYCDKvxhceR9h0r75eiUZ3g1unDf24B0oMxqm41nNAWI
 WP4HWnXoOSrZxZmZ9C44JsUDz3L/z42VcZtK4oso8BuUXkQkh+cQmibYAPUHWO4pMIvca3y
 7BiZznfGmOldZbQ3H00aw==
UI-OutboundReport: notjunk:1;M01:P0:ZFN2rK1IKxU=;eVeR7FaeGpWjhnQDpqhYPEs7yWb
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
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

No need for it anymore now that x-colo capability is required
on incoming side.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h |  2 --
 migration/migration.c    | 26 --------------------------
 migration/savevm.c       | 10 ----------
 3 files changed, 38 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2496a968cc1ce709f706c0efe57e4f765f163d3c..8f94054a10760d0f2598f08064=
3f45f9944cf051 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,8 +25,6 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
=20
 /* loadvm */
-int migration_incoming_enable_colo(Error **errp);
-void migration_incoming_disable_colo(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/migration.c b/migration/migration.c
index bc8ce64ff5000b0eb634a20b22e5f3e3289b9707..3f3fc5276bb067ae1960e4b675=
b33208ad641b23 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -604,31 +604,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
=20
-static bool migration_colo_enabled;
-void migration_incoming_disable_colo(void)
-{
-    ram_block_discard_disable(false);
-    migration_colo_enabled =3D false;
-}
-
-int migration_incoming_enable_colo(Error **errp)
-{
-#ifndef CONFIG_REPLICATION
-    error_setg(errp, "ENABLE_COLO command come in migration stream, but t=
he "
-               "replication module is not built in");
-    return -ENOTSUP;
-#endif
-
-    if (!migrate_colo()) {
-        error_setg(errp, "ENABLE_COLO command come in migration stream"
-                   ", but x-colo capability is not set");
-        return -EINVAL;
-    }
-
-    migration_colo_enabled =3D true;
-    return 0;
-}
-
 void migrate_add_address(SocketAddress *address)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
@@ -735,7 +710,6 @@ static void process_incoming_migration_bh(void *opaque=
)
             runstate_set(RUN_STATE_PAUSED);
         }
     } else if (migrate_colo()) {
-        migration_incoming_disable_colo();
         vm_start();
     } else {
         runstate_set(global_state_get_runstate());
diff --git a/migration/savevm.c b/migration/savevm.c
index 0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef..413688b75f4bee6cb10878eb51=
886cf6ba14872d 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2403,13 +2403,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
ingState *mis,
     return 0;
 }
=20
-static int loadvm_process_enable_colo(MigrationIncomingState *mis,
-                                      Error **errp)
-{
-    ERRP_GUARD();
-    return migration_incoming_enable_colo(errp);
-}
-
 static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
@@ -2528,9 +2521,6 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len, errp);
=20
-    case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis, errp);
-
     case MIG_CMD_SWITCHOVER_START:
         return loadvm_postcopy_handle_switchover_start(errp);
     }

=2D-=20
2.39.5


