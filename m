Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53069FD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU6-00049J-SE; Sun, 01 Mar 2026 16:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU4-00047R-Ox
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:52 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU2-00042Y-0s
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401062; x=1773005862; i=lukasstraub2@web.de;
 bh=YxFt9a3Q8b3rYvpOCIGfX6fMR4sOddj7ZABbx+/ZiI4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tUBcD6bC5GOVwpa5vQ4T/JdMUjiQ+Sw0FM8SYOhv3VFoRzAsFc3S6Z/BhH2qf7D1
 Md11t6S4x/bW61mYdj0QMJkFSFdBXb2OUNkxYnePQSjuehBy8kyiQrwMuIASZFKEe
 2muGnPf1Ukz/tjlA5AQOUWG7r5GqHfVmSzLYY6HVAIRBf/ypDMsD8H0Ee6Neu2Z6Z
 5FzJYaTuXg21c2wFwcOfyfCbyVghKIDEg0N8yO0j/s2qKyrKUth9/W4UU0ffP61PX
 IYIxcJPIOie35SCdjQusJwr1ASn0qZgkxD/pBu7MAFliq9t7SXuB7yoMi8T1m4miP
 LSzPYY6rSc0yvr6HwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1w5NT72L8p-00WhIN; Sun, 01
 Mar 2026 22:37:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:25 +0100
Subject: [PATCH v11 05/21] colo: Remove ENABLE_COLO savevm command and mark
 it as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-5-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhtx16BqWrANHmfcdGma671RKEzekCs6RXK
 FJ2mXo8kfGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WO2FEAC8Cp+yq5OkwXuGrepoTzszH4vCZZfawQLFOPBQMT8J3TlveIzmOKFLWMGUPgne7PAtfJz
 dlQED5TXXtPEjelkv121UhElqc/5EMjmGOxFZW43sSmLDq3n5bGFX7iZYFcHWHTztE7n5Mf6vzF
 uaxsxeAnP5jEm1uFu8qTmdatrJsTNr+ABqZJmjXW8+MGdCTxxRF6a7wArkNxhCWhmJVxwVzRzDz
 oxwEwXR0DZ0UEhQ7a7SaUgIeriK5qXU3PMVW4jim5IazDw+eb9XXehshbx5vcCk9PVVj4LRlSlN
 AuY7lacdxt8E5U6oduILitr05IX1tGCsA3JukwqMkxhDNZgCsdLyLKwYZhb22/RseeTGeC1rg1m
 +26HS2rEZ5rqE2gUdWJb/vzgS9xt5OrhePe12C9lwi4axkXCD8WBw3icMUmDViBNRhoRBngGX2h
 qSGr4qpPl1I91EQhPhaZFUxjJpW0vxDfD1wl0iFyFAAk/lxzON7SyUeb8vyHqX/+4/z5iha6+Zw
 HRoCoZquONipAxk16BdRO7BO5zGJoL0HOdvS6RQTuXzG+hVjNibqIphIEFp0sljVgnDli2V/wpC
 jnPePybswsY489aKYz1gkTGSKFRtloGJnwiTZOoXOohqf2SFry2/iPkFF11ZH/5q/JH91XuxQEj
 MGbCUvCyNLxjITw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:FB3lO634r4RfZo+2ouDhZUUagXZ4Xkr+YhTvVBcwtAJjfDgInIq
 FNe1F3cmze/V33fLpnndKM693uMNcCqh+T6k/XEbbRbzRGnCE0Hiy2qOjezYEsJ4rkHjQ8e
 27V9tFH4KqbjgBI2KjsQ6cf2N7BJUB++LKURChyIjVUsZ9w2NFna33xb1JUorwTFbLjDecz
 pz84EeU2qjgN6SnMtfRew==
UI-OutboundReport: notjunk:1;M01:P0:qrelCTIhAao=;edXrKWVNtg/DtgKR8BZR31C/0e7
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


