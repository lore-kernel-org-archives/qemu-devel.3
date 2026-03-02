Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E5E9B358
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0O1-0006ar-6B; Mon, 02 Mar 2026 05:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nz-0006ZQ-5J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007In-Uq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446812; x=1773051612; i=lukasstraub2@web.de;
 bh=YxFt9a3Q8b3rYvpOCIGfX6fMR4sOddj7ZABbx+/ZiI4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=On5WRExH4uJyhboKwJ0OVE6AY9jikh7b1G/Rmq+RSjnfBFHJIgPC5W2u/veKq+2c
 4RL6osiUEI/odxYpmHtX7hfiLyYOuWTuLIVDOSy2Qt8ItEDWj8VOW2eqesHRIpC8r
 ftECLfA+D23v68HShwG6H5Kp9vjo8IJmVBKmTjs1TRLwxKmckjOnVuUQBGnyAVDsl
 Cl/NRhTc4yyHqFHVs+p1/puS1cZS99mLl4jU2DA0/w14gW2TnPE6sIluEord6bOD6
 WsjEUk5ZR9rUqcGV+yNNuiI1XnQqSe6ywQ8/+X3w5FpVqTYeQR9IILBRuKZoeoi1L
 4hHB4psDITZDNuBXfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1vcROd1jgd-00y6Nv; Mon, 02
 Mar 2026 11:20:12 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 05/21] colo: Remove ENABLE_COLO savevm command and mark it
 as deprecated
Date: Mon,  2 Mar 2026 11:19:47 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-5-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7085; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=PhsGvkNE4e8fxdp+HIj1fvwQLxZniTkG8SQ2HFQ0rRg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQoHogfSycnt2q4xOPwZoIB7Ov9rRyiPDLNt
 zoNBwlGX56JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WFj5D/4lJnviw1xPJdgjU+qeQ+1/Tpz2h5ms5Fm25V9ajfqkZYYnOtCvfxS7T9cHVg3+EyZ5wx4
 ieotWsbARMbO5ge+xnL7jhmBhUxSBsfLHYZH58fN5y7xoiMNVu8w187QIdrwqw1B/V7BfEIl5YN
 7KKIIUH5XJe0hpvYZIqCDFtoLtDs787VtiiM5QB8Ajf+FgYMyQRYHLuYYZmtc9YZgqdCmbta66M
 49WlrjOG7N6A3rEr8Eet0nANTP11Pse+IpXA7U8+LHaUhkRCVcmr8uBvVaNOL7zOia6IzxiN/uz
 uB4yKGcTp5GPN1foduq1d6j5TMx4mLVkO7NGNJ06QTtvmG0hVU63y84mlw75rTWAkpKD0OreqUi
 K0ybNAx0pZuElYp9n5meEJ9OcTIbVSSf4FjbPUM+aiDTjITFOifm7XQaWkaY2bvisTiUewxBlNc
 zT00z0VjA9KI9uJh6YJjsvk1i8Pi3iKdAVAtKMgGtlfop7Csj23OfpYz2xjUblWDQ80YNQ7kF+P
 lrehhazyOfaAUWATBqSvQYm9hnMsxmb+IwTMgmTDjRTS7W1Wj3X1kWVcgJS6zvxdDnGvsUGzkT6
 V5jpso1wrNYpNsQkpbocd/AyJM4mTxk56w0f3FPl0eVfYolLppw4Pv1gR5sCrsQAhwVRTZD70d7
 XhkfQTixZ3xu7xg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prFpK7+BfTRsGv0s2mwsIw8b7mBwVVd4N9IbJNfJzQSezAjgYyX
 VIyY25oHioVWMMtHOz3wMIOyjqf34+pcXO5sgFKkNy/1pCg7PkqBJK1Kk9Kqly62T2QF4Kx
 ecdMHoubN7VUwjvsm8bnFUaVKGe2EIiuOZrMV509NPlb1ablTbu8FChfWd1rHRKRqaC3QtK
 7CVLmf1U1Bwpmc/ealJkw==
UI-OutboundReport: notjunk:1;M01:P0:VbgplAOWbUs=;UhuAWDebWOQI/Ad3b1CLjuvIGZo
 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
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

No need for it anymore now that x-colo capability is required
on incoming side. There is also no need to send it for backwards
compatibility since we only support COLO with the same version on
both sides.

We mark the command code as deprecated and now error out if such
a unhandled command is encountered in loadvm_process_command().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h |  2 --
 migration/migration.c    | 31 -------------------------------
 migration/savevm.c       | 25 +++++--------------------
 migration/savevm.h       |  1 -
 migration/trace-events   |  1 -
 5 files changed, 5 insertions(+), 55 deletions(-)

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
index ef6aac53343f2217cd1aa37e493483703068d1ff..dba5d6ede579da42693d5270ed=
e9660fb145238a 100644
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
@@ -3534,11 +3508,6 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_postcopy_advise(s->to_dst_file);
     }
=20
-    if (migrate_colo()) {
-        /* Notify migration destination that we enable COLO */
-        qemu_savevm_send_colo_enable(s->to_dst_file);
-    }
-
     if (migrate_auto_converge()) {
         /* Start RAMBlock dirty bitmap sync timer */
         cpu_throttle_dirty_sync_timer(true);
diff --git a/migration/savevm.c b/migration/savevm.c
index b88851cdb7974314b8481646a1dd19642887f210..197c89e0e659b889409c3dc975=
18920ea9c1824f 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -90,7 +90,7 @@ enum qemu_vm_cmd {
                                       were previously sent during
                                       precopy but are dirty. */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this strea=
m */
-    MIG_CMD_ENABLE_COLO,       /* Enable COLO */
+    MIG_CMD_DEPRECATED_0,      /* Prior to 10.2, used as MIG_CMD_ENABLE_C=
OLO */
     MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
     MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
@@ -1103,12 +1103,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
     qemu_fflush(f);
 }
=20
-void qemu_savevm_send_colo_enable(QEMUFile *f)
-{
-    trace_savevm_send_colo_enable();
-    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
-}
-
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
 {
     uint32_t buf;
@@ -2423,13 +2417,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
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
@@ -2513,7 +2500,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
                 return ret;
             }
         }
-        break;
+        return 0;
=20
     case MIG_CMD_PING:
         tmp32 =3D qemu_get_be32(f);
@@ -2524,7 +2511,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
             return -1;
         }
         migrate_send_rp_pong(mis, tmp32);
-        break;
+        return 0;
=20
     case MIG_CMD_PACKAGED:
         return loadvm_handle_cmd_packaged(mis, errp);
@@ -2548,14 +2535,12 @@ static int loadvm_process_command(QEMUFile *f, Err=
or **errp)
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len, errp);
=20
-    case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis, errp);
-
     case MIG_CMD_SWITCHOVER_START:
         return loadvm_postcopy_handle_switchover_start(errp);
     }
=20
-    return 0;
+    error_setg(errp, "MIG_CMD 0x%x deprecated (len 0x%x)", cmd, len);
+    return -EINVAL;
 }
=20
 /*
diff --git a/migration/savevm.h b/migration/savevm.h
index 2ba0881f3bd28dba10e52e16657a0b67b19bb00b..b3d1e8a13ca9a535a6990560ed=
2d64739ebe730e 100644
=2D-- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -65,7 +65,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, =
const char *name,
                                            uint16_t len,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
-void qemu_savevm_send_colo_enable(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
diff --git a/migration/trace-events b/migration/trace-events
index 90629f828f80b51500776ae2171724369e194573..60e5087e38beccb98588fdffec=
7deff9a7f92c88 100644
=2D-- a/migration/trace-events
+++ b/migration/trace-events
@@ -37,7 +37,6 @@ savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
 savevm_send_postcopy_resume(void) ""
-savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_send_switchover_start(void) ""
 savevm_state_setup(void) ""

=2D-=20
2.39.5


