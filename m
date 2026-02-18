Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4987E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7M-000794-QA; Wed, 18 Feb 2026 16:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-00076r-Hy
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp78-000749-Vr
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450179; x=1772054979; i=lukasstraub2@web.de;
 bh=lFaylqJfRwA+xGkjtlbHuBTbGEoGnwtC2rN5nMHNvvg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vm6/hiXXcOapx4gwhFgPTjZPsUUd8y3QkPwiemdeIpGxh81kq4Q1gvA1AiZ1uNgq
 cO82Ha6FhJXXjFUqswSdyiiw6721jXcM1OKamBwZT5z0XqczwVPEfSUp/NRmOqqS6
 EYIFjh0cjT3KHbHdFBZ/JpLRb7CFAh27nNrX2g6pLwMm5lIEPewUwP+1MSHhi9qbi
 OU02uaQu9VEfp2/natfpWFTDEqG+BeRzw8o2EVBoXCveGusRdunzBf1xiTN7DqlEc
 rGNMQWiLr6ddFLln6tZizLMSZfLx8ZU1VVoyOLYDWg31wORuQtEfxL3rUIdTlRa28
 H7zSmMvfhsPD0/6Rsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1vz7SD3wYl-00EVZg; Wed, 18
 Feb 2026 22:29:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:25 +0100
Subject: [PATCH v9 05/19] colo: Remove ENABLE_COLO savevm command and mark
 it as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-5-d8dbdb0ca6f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7042; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=YT+h1EviSwAmcakmyBDcRUQRzNdTm5AuYHH102VFwng=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli88slgfK9rm+FE0O5SP281RVMpLNg7duJz1c
 d7jTbmFeoaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WJGPEACQmDvzuHBrdxMmT1PuDAaf6TXpLUmX88YcOyB3UQhAnjxFQgIkcjCc1LvK3A5q5Gw9H0h
 nX1K9upFLFkknEwJxCbrVDUi3CDYZEi73gh2NAdh4nBVBRSDUzBM9QpkWUSJib56xMxn3Dh/95B
 Nhd4UcvzvkOd3fczlkBdQSyTOyBfApkMW1NVBkYZiLjsPNC6v5kO/4cTpAtqw3N5GwB+Q4HfEPb
 5vbzRvMqVBznEM+sGafkZzrc7IV17muDx5Dp5PojzHgOUMVdhuG3hh3+OCMQ4jugyWn2lu/4iPz
 l6kGn4iK3KcwY8qrGKUqPJR0eZmxzGLOVCC0qJWceZZitQE3ZuffirntlJQ5opON+ymqQQEvtE0
 +m4FBWbDej0fUlHL5IQ9+mh/iKcN8Gh8e1YnNx/csg/E3S26OOFpTKKKH9gZwp8WBObRtu3m8ej
 2MN5+POq7I0Hj0YTrSUuFWbMq7PPNHsz3ppyB46wYuG2HmFwcFLTMID3Pr2wLRTTEsJYcsQiQph
 14yBeGTcg8HlXzJPn68W/O/BsbAHLTIDITklbh8IyXlBJE9TRhxF7//d4shcoqnRTh6BvsYvrjU
 SleaFBey3P7CGQpLCGDn4/erqqixyDis4iteOLvnbXiFu8Xms4tZuhg2Sx7vQMdDGdEAM42f1QF
 LbO1xGsQctc8bLA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:oNkMHMfhyTgJcCHhJcN9QIo7EW7OuTZ4WruLTsMB7JI0Un9AQYY
 zPaYdbfJ2oTM42TKegzF4ICxBxQsCpqLq46JiZ65Kl6KxonpA7JfBhdvttRLru8INX5uW04
 ZGOzsDkT1Op3AlDC8qLe4raWKTwfjZqA7ceLLfKF560bhYG2bZosf3EltRi2GFux+OdWMVC
 2rysjlGwEZkBdy1UNxhKw==
UI-OutboundReport: notjunk:1;M01:P0:BEbvX/yaxnY=;U/wUTaH/pYdZUIQSqYF278TZnK8
 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
 LxhGtq6uownnXYA/Ecb7rDH5TU4Eb
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
on incoming side. There is also no need to send it for backwards
compatibility since we only support COLO with the same version on
both sides.

We mark the command code as deprecated and now error out if such
a unhandled command is encountered in loadvm_process_command().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


