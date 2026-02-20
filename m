Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8491CC5AE49
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXq-0000Wh-DL; Fri, 20 Feb 2026 14:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXj-0000VC-Ge
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:04 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXg-0001T5-8Q
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617108; x=1772221908; i=lukasstraub2@web.de;
 bh=lFaylqJfRwA+xGkjtlbHuBTbGEoGnwtC2rN5nMHNvvg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eRog03xKZa/i1BYvc/DSQ2AQ19gaUzg6cJlRn/5+8YQ3yQakFSioXQAxqWgj+Rro
 8UEJ4zKHKjE7KzNT2Zfvp9JN+Lb/AWN+Y7/rcyt58Fh+c1fvmxf317OyDJHtcOVrq
 2xfyUaHe0rBClWHxZTvNZdeZM/SlmnJH0d0yqEUYz6T/0cIqV/t7x1LbzWfHm32dZ
 wDHRhJCIbb2aMKpoBAfEif+4+MQmqYZunLBIy29mRulDL+QxpmfW5egqdGHflnrkj
 UjBLw4uIUidg3ThTapdQAmovZyXCmTiQiRdz0lekRdUjh3MWMIxXb+rOeZllIyRP3
 nI4QHYakn3fOSPmwaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1vPMKF1TU3-00pm4B; Fri, 20
 Feb 2026 20:51:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:27 +0100
Subject: [PATCH v10 05/19] colo: Remove ENABLE_COLO savevm command and mark
 it as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-5-bfe67d422ef1@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7042; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=YT+h1EviSwAmcakmyBDcRUQRzNdTm5AuYHH102VFwng=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtNUV3qkR0xdv1obFwdK7QkQ1qzK7q+/6VHX
 bIlroOs8eKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TQAKCRA1qwsonF2y
 WKo8D/9XYB3cWv78VAsyOwVHJ2IbddEGvPcZ9vDQWEIhz3+7Gl5O8SMgni+uOaFf8az8HIIRk3H
 NAI7aG3AENyOooHlDWQacmCU85HR5SErSRb3hfTm/TfLnj9EtSx1oAAfh3W97DJG0iX6SNPzhGT
 oXlIpAlZ/O3yRMk1sWzO6ue6kPxHopP/CZvOWg6fKK8eXPuvX8A80xKlAWsX2Uos9+88KKBZBc2
 LPUwu5UjFwGgX41puFgJ0sJn/MSKkz8uFHgR2bqntz81MiXdjXioTuMlJ6qM+LhtFO3zqlQaOzw
 7IyZyH9U1MILcVDaKfF2unMa7Ms3rNtRyQnMQ/5IH9KEvp+v4nSsRP4fMTv35je203wFfVlxDZI
 ia1/EmlxtlRcttwUZMPetVb8jMt4wkKDBlLo9djTbbDihipe0u6cuotjsvMXQgLWlEVNLB3LTKs
 nExtMN0EkbbNOG6cH2djjYRiBCVBvF5YPGpzLwUuu233uOEgMREBg1xAkK9v5kRCsvO63k06K83
 1do/N38tn2RHvp4SS3wKqUPRbdDXJPAfTbS2rVk69RDytSPrBcWCZS1e36pmarm8R4DDO1V+alM
 dOVkq9MNBSJyRmI6/O2RQCdbfu9dcwuGWEnOxwAOpTPyz/+cw1KFavz0Ml9M01JkBypAI3V0yC3
 ins1C6+B2uxruaA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:DAffT4DPf1r8SKgv02MmK2PUner5SXCyYHhpsywFd3YoHiIYCbv
 1iEiMex8UOR7yQQSqWi7V5A2HDr2XwroZBvH9ZEmJpYswaHMf0MXj7xW+t+Tzoae3wN6/6l
 u4zBhfg369yLoyfhzFAsvo8+YCD3gFYZa+kg9DZUgzNZlarkM7YbzUbkQGJDvOAh3lRF+OZ
 5hrQUy6AZzHoL5FceBwUg==
UI-OutboundReport: notjunk:1;M01:P0:ckSqNxywgx8=;7k4+uWyCwuaNn9xCJMvgKLEY91F
 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
 p6ghdNVP7fnrCC/IbpgY
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


