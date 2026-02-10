Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7788CEB26E7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWd-00014H-Bs; Tue, 10 Feb 2026 11:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0000jg-Lb
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:35 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWS-0006yT-5x
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740603; x=1771345403; i=lukasstraub2@web.de;
 bh=6abXST4U82gBInHYAiJha70N1bLsU6+GbtnfbmCxfVE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Xj8U+ZNLp1UeGdkkDBAcLMSOMrmFt7SD40Y4LaM+R0rwfrLpY37FiNJNl4wa1Y6a
 Ppncs0WqOeiKQB+hz31n86KFhnNcsD3pZwFHbA+3a0Li/blbHjHX7V+rPkuNkG+A4
 OOS5v6tWZeampzXMgxHRxQgYKMOeeZV+4xiKX5tk159VbYwwcWfpeoTJEq35id84B
 1/YHJen0/SGJMqWtPs2x+olMdQ5gA3O4WUJp6XOx70p5e+jqFT0Zh9m9am3qi3mDy
 mA00EazwtwZD+7MML/tmJ0ikhXa5aoqvW1x8yfk4fXUQVcOi5VmJ1OLWXF6ybjk3J
 VjpgyUnldXLcYa/GYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav2l-1vDkXo1BE3-00cMr6; Tue, 10
 Feb 2026 17:23:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:03 +0100
Subject: [PATCH v8 05/17] colo: Remove ENABLE_COLO savevm command and mark
 it as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-5-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6960; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=TXNxHAjOmaK7ytUFIMkH1Z1jbl5/VhU681czgf5lhvo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3pIqfqP3bUPWIsOEUqTu7k/R1Ino52NaBD
 EgIGspnxMGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WEl0EACQpJMxQpGUbkXAE0KqrmADy/37Y9DT/iur4G2PqC2P3D+OdeZ41xJowngVcF8jtgKhK1h
 bySlLBdo4AfFZKIyE12puU1Hi1E0b9O2gFXvgxRvx8XOIJ+0Pck7Re0yoUpzScE7lULN5o5Vl48
 9OPJCAQuNXZXkHkwG+bwCBaO6xcUXORi1Uz7uX6FgEu3h681rbvWJzqk+fybPq/jCCg1HtJG3hC
 J6THTt5Ex4qrrtKMed/dOSlDmpeT1KbqJC2nOa/TboCDXp9PLczMiaRspQ60asymDPlrSUFl5fw
 jCGI5ECfkoEu3sBl9TKhTlSZEozLvjK/chy30RCPnUTPchP2ARgjmt55oIo4seOFMgyXxaYwuCS
 /bfrBPRmwulZKVs32NyTe+g6yTS8g+LoM0/ylgtVkN3WXRI5mQ/X7K/l+9BguprAkUIBMgGL7+0
 NwGCgearFfrc4oHO8/wejiA0l/GzN1Unk8l8yqz9xcED/9qxdImjh1mu1uLYRcR52x155sxEJVL
 2DVCJn7TFsaO4B/oprtQTHHWxL5nJ4ndGacu0i4hug2M2BddvP587v1BODEBwdTJioACc5/lix5
 ZgUfJVi5I5fgRjhvdXCKvOjdPlyPuPo2/nyEvfmkRX79PRAkRsbRkIeo4QbpIuvfkxeMR3zRT8S
 YCq8T6bOvMVGllw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ykXhLv1m35wae1blmAPAstBerk1HmtMrHhmPJ0bgQYhWN0wBagd
 ikZ9EOTlTMWwiZrDAwuh2l4yLHorweoaOvPXyrl7qwTh2F3my3xCgzs8JN9SgK9fkCkOFUI
 RvfFMZCJIkkcamjUrrBoWOWYRdiIlU8lJHXEk8bo0Cdlj9MfweLDu2I4fjFujXjDBK0FudK
 dEn1AA6pQv7dB+NDFuVpw==
UI-OutboundReport: notjunk:1;M01:P0:JUT2O/HB+bw=;N5BZUKJm6N/BlCn0EFDerh6m6Ky
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
index bc8ce64ff5000b0eb634a20b22e5f3e3289b9707..5515be1bf305b40ba0b590136d=
f18a53451872c5 100644
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
@@ -3522,11 +3496,6 @@ static void *migration_thread(void *opaque)
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
index 0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef..07b26702f9102c2d93ff874546=
72755f54c33fdc 100644
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
@@ -1092,12 +1092,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
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
@@ -2403,13 +2397,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
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
@@ -2493,7 +2480,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
                 return ret;
             }
         }
-        break;
+        return 0;
=20
     case MIG_CMD_PING:
         tmp32 =3D qemu_get_be32(f);
@@ -2504,7 +2491,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
             return -1;
         }
         migrate_send_rp_pong(mis, tmp32);
-        break;
+        return 0;
=20
     case MIG_CMD_PACKAGED:
         return loadvm_handle_cmd_packaged(mis, errp);
@@ -2528,14 +2515,12 @@ static int loadvm_process_command(QEMUFile *f, Err=
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
index 125a2507b7279412bcb0745b95a774874c31c54f..0a1e5bfd1ca125565a4c90c6f3=
1b2f8c94404117 100644
=2D-- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -62,7 +62,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, =
const char *name,
                                            uint16_t len,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
-void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
=20
diff --git a/migration/trace-events b/migration/trace-events
index 91d7506634c9f110e8f0b5f9183728058fe6542a..cfd4d58a0f82ec299ca9e8a926=
0dd3c3a210cece 100644
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


