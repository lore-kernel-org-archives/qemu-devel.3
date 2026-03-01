Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E480FD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHx-0001FH-68; Sun, 01 Mar 2026 14:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHu-0001Ca-C4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:10 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHs-0003YI-4C
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392610; x=1772997410; i=lukasstraub2@web.de;
 bh=YxFt9a3Q8b3rYvpOCIGfX6fMR4sOddj7ZABbx+/ZiI4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DY+6IbNcY/dqkeogQJe7zcVVa6GD8ffpjS+HJaQhO8ogVWeP0Sofr1pi2jvYmcMp
 ZzfFydcb39LMDU4vExILoyvsFaJfLTwWTpLbN6/wN4ajwZeftjwUa0mn4mlAxCAbr
 Q1mSZKRnS3LrTOqHmZhV8Xju7c9oQPYjhfvC0IYV8DqQ1xTC77CGunLMaLq7aOylZ
 hZ40KvAaFDtulSpSdF+6WvzrIpVogl6mHdjlMSc2ihDYeVsrHlvVLqxMaCVBZi2PH
 mbNjcoDfi4XHLgLN26L4YNXgHKGVmeFZHohSnVWdBeTXEIFrAH3HoYKyyqe4kCmI/
 7UePkadJA1YjgbWetg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP382-1wJwPW1VvQ-00LP6U; Sun, 01
 Mar 2026 20:16:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:30 +0100
Subject: [PATCH v11 05/21] colo: Remove ENABLE_COLO savevm command and mark
 it as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-5-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7085; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=PhsGvkNE4e8fxdp+HIj1fvwQLxZniTkG8SQ2HFQ0rRg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCcb6Mz7529+o1mLc7Keq5rKu4rnMl0HFMu6
 VOtba6EM1iJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WJrJD/90sbkyPDD7OY/MXYioKc/M+uZpRG75nJRmCYa16qqELftQD2ovWcgFNpz6xeZAZGcS0Aj
 C3j4RvcYuUZsqY4j+pogWWy3lZi+V6bRJLvdHGggNcy8jQLFrDlb9YtZdA9X2V3n2USi37zasEU
 B9E1lkxQLpz8CgEBMrIvSIm88dnYTZJWxbPXf0lycZ1Yw+TbjrIQvVz+wIc01aiwfQYPB2VPeO+
 ZwfFbZfAIGFkuxcD1bZB0NEknIgKUSoJHXD0ZmZO37CDfDNVki2RCq5mzByynWZoNWTbCxPwD6H
 90P/8Ko521Z1soFShIKzajoMXgJCP+RAfecHy/vqGtYwtHngl3JCAjqUCezvDoeyz3k/222fQWR
 y6LnLJCBFGAdfesN/zsrGrN8fCKvVYLC/8Ftwc1quQCDx5X1MLWdcGgptH6AitTBvka46gCluo7
 d2oyM0rbaPUIniOjaJIoa2TYJXccFPvZxTh34JAiYp+7DxTnDfXNXBKKvV7UMfexlrQDrXPagk7
 StzYxt13/5SqxSkiNeMATebeKU98GbMiYqz7+B7B754TdHxilj0bk+TAKECDxFNlNFXbfYrqUcc
 i8uJizENkCS/7NI4O5l5EplhRJS0lCTh6gylgh9EToyQgyNACqoQaeVRhaV5gVZ76DhHtVmQmM+
 qTkBsb1mtT0QDEA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:7g1v29DbBqffh3c/zfXGCsTCUlcN0zrnvD2HnTTS/xDzjQkKMxk
 onY0GfR2Tsea+4aHiXDGa4sKePCWYkbSbxeSL/JspgX6Ec6aHjwaK/CSlGcgXz4avEVg6xV
 8HOgLZSzRu4Ptma0SasRNQ80KE8ffIaLidSgnVWyq0OzfE9qzyV/Rx2zIE9/WQ6g91VNLmJ
 peyYeDiLsIR7t1HyuyI8Q==
UI-OutboundReport: notjunk:1;M01:P0:ew1J6j3w3OQ=;djuVUC7B46dhB72SS50WUb+gBlH
 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
 SzxjsPkmT1pZeRzyoPZK
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


