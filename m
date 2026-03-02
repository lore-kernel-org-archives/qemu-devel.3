Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F5E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gw-00057Z-GD; Mon, 02 Mar 2026 06:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gq-00054I-BA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gn-0005i5-D6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451825; x=1773056625; i=lukasstraub2@web.de;
 bh=YxFt9a3Q8b3rYvpOCIGfX6fMR4sOddj7ZABbx+/ZiI4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SHDEPcmusDzN4nvJWDSgAcY6p7cTllxVVYDbLnqR7/tKA161BFSRZW+ER2BqE9Pq
 EBRBEyaT/DtXxfVj+uxLp4B7z9AV50d3Zo8JpoFw3IpT4IJduXwGsSzZVPXjWAJYl
 oPINeDeP05iVAEXnNNmbAARuHRr85oF28c1tttbIUJyYAHTl0/CKGFP6uHHbDAP2K
 gWZAEN755NPNkTWxp4UObO1sX44o/fNoqZzgFKWAajWURlXkJ7SiUORt5jS5Qeb/w
 M5rKHTo27QE6CEG9/bHPREbK50t0bDg9t/M77rHsIqN0nngni5InmhAEyuIQQXhTO
 /Tg20FqZ5yPbVW+7yQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1vZfCW063Z-010pSR; Mon, 02
 Mar 2026 12:43:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 05/21] colo: Remove ENABLE_COLO savevm command and mark it
 as deprecated
Date: Mon,  2 Mar 2026 12:43:35 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-5-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7085; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=PhsGvkNE4e8fxdp+HIj1fvwQLxZniTkG8SQ2HFQ0rRg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6Tah4jUCPuFM+c1ugFlqGnWNlgPjGuFXwZU
 io8glUm1LWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WJcMEACZc5J4D52fXycFctdBKixVCciFA6SPTtkuykteH0gjQw3Djq+/czcaL4XgZ6GVEinbklp
 PxgjQIUM0sPnGJk6xXEnNRTGsFMc4gx4zSuE4N9iyH2Lksq6KP0ZQAheqcCkbQCna16njyA0jqW
 LfefJ3o58b6ubOwAd/BtChvi8DAcRlKnf4of7Xg9l9Jr7OAgTpR2AySOw/bJ8RfC2ZRJ4BT31N6
 BRVtRqXP4IpabvbdcO1yv9pa5Kv5z85TkEu+tMNXTlEi7jKD546XexyQZ6er2DGe5hcbSs95D0L
 9AIROAw9Sthg3vKD1+wO8lpCL9Pn3lu3yeo8vy1yjFMEL8XnRCKzDK2QHMRWXGZmbEigt5i0b0R
 V1ObbaOXKvqGomko7z8dvV1JypIZ0LVeI7k6o6jhPRFxAt8X+Oem4Na//7c/yQknLBC7pd8l1Gr
 +1ZSCC879QJkSt2e/e1bGVR2bM0wCuiPTAwcUb/XIEU6img04khm8AK4EqicAf82YDWmeqrSIaM
 3kbg48R6+inE5N3fnR1to+t2tuP/NYNo0SreV0wDqiwQ7P1RkaeiAXJKomgUG7Z5+RyfMItkjX8
 NpwVM1qjhB1LCNwtv9FHOumh2IfeLKT1nQxDmKTrZJeU9jQibbyYlooVKxVVI2hYfrjPCpKwYGB
 b7drobtmMvJLm0g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KTRIxFIYrSfJKPW+bbX8L+eyrlNvY1rNDxwqjcFI3ukqZv6ANIe
 rHaB5ESTBl6HLeGWSchUUHtXwmwwavIL3MfX3bw8fpr4e+12+IW+J2OZsTgnZqlqkTHd9Rc
 g7hPplfFiPci8lLceEVyf+i/1Ps6rbaON3GCcIfwaX6SIe65bGSqBUhelQgu3MniVFg23wi
 1yyR59xrvLh+VDDebDevQ==
UI-OutboundReport: notjunk:1;M01:P0:3IQ+EFOj2qM=;wUiCqJGdQlTjA68cQRM4T61Jc4/
 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
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


