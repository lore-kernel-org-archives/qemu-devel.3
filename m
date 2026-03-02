Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D5E9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hb-0004uE-KL; Mon, 02 Mar 2026 05:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004ru-Rl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-000624-1a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=YxFt9a3Q8b3rYvpOCIGfX6fMR4sOddj7ZABbx+/ZiI4=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j/aDB9F1iNpYzSAyTLRbj17xgD+D5inxE4rbpNnLWlAbgWGcRDmhnTN6LhRh3hkR
 CHNpka/+GG8o7wDi0OyimuTxg+nk/mjbV+faErdEeWB8+RA6rs2RUk24Q95d6fZAA
 Tj4z2fALHd5x2JPNQAfyKhQuNRzNco882EUIkUIWv9U6iCi0KWcs0lyv9g9TpGLiU
 IfIlxsarnZ5HeZoMlc5Ty1AzA0zUrp+6xw4to+Gzs60iIQMWhaO54KMPjHVmTEzip
 gzJexsM/w1PIFQOlsxuvYysiVnOh902yM+5fRDFeAGFTe1HbzQP6NyW3G3GhFhzCy
 ZUPv+ox+lQDb/Gzsog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QmF-1vvdMp2tXx-005eOB for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 05/21] colo: Remove ENABLE_COLO savevm command and mark it
 as deprecated
Date: Mon,  2 Mar 2026 11:13:16 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-5-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7085; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=PhsGvkNE4e8fxdp+HIj1fvwQLxZniTkG8SQ2HFQ0rRg=;
 b=owEBbAKT/ZANAwAKATWrCyicXbJYAcsmYgBppWAFRuJnmE21hhMJwFQU3nWBVRgXe70mMFXZy
 7mSQULRHayJAjIEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WG0PD/dE04vf+dHKSv7OhdBX7x/Er8XfcLWZXbeMhcJst/j1VumrXztcvTgOJLT+MZvbsBpHLbw
 OJUsqjB8X+jqa8UZ9YAL35Of9oTCv4+Opf3ssKUc+qoeIYTUrqKrnTez0lvRzZ/ZBB5/W14Khsx
 FytQwCnPBCNrtolKF0RA6VQSIK4nZIUs7ZnJUyv0p7mXV486zPa/ozeJ9y9YQi6IiHezy7oiIh2
 LEvxvns1KeaUOlVVseIfdOCDSgPvFOYp4mTJ++XNfVD6P3poKft8HUPxpLtXQzDDPofQnULxGhJ
 G66kmATJZe9NsfDM4ftsgISIctOhIwtXZ5FUYy8vB1DG6xcHTcc0/bjLGEDfue+MlbmoqxyDFvW
 EJfTMFcPcTHlV5QvjDyzB7Tvm76cKXDc9qBisTUcNJLfeYw2iww4QxDMIBPhb5dRBXnO32fupAn
 QNd/c60uK6pgMEf2U/hqfExe7dt1e8IHESjhizFGbU9ooe1veTsdbjFtAehkfL5pn2eV3rDYcAJ
 J9+yD+Dt+OQtX8Eq92OAxFQCYIVt3IaVQ6IbNXHQdv6eVj27wBKBbhP39qxVpzNMDBzTsUpOWrt
 TVWhjbfanmCusjT8r2ww1S1xzQsGSWjqE41ZW7TYy7zLOOkr5qpUG2Estdsx1gv+hPglUgZ5dCZ
 D2NAs9JiO2xKK
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j+M4cAIFRVAZoHSaFlkRH3iETHJNTkITWUDkBKaL1zzz9WDx7Nl
 Sc+u0sHmp5zZdu5HaAAT+KZQbDmDAT4T5IftLjxODU8dF4MuQKVjPveqW6cRDZZvFe71y+6
 CI+Y2WHasAvRrq2P4xeQbaZjsDHvJqxIA00j0CYXfiRPhTaDp2D+Zz8wArZhB6Ol8ZO1sqK
 H85lhfpRldSUH//oAV0fw==
UI-OutboundReport: notjunk:1;M01:P0:cGCsaCEm0JI=;CTeouTfh8BdZnxtzEloMllPvSCL
 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
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


