Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475C0E6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOk-00041h-Om; Fri, 30 Jan 2026 07:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0003Lu-6t
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:47 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOf-0001td-Fo
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775275; x=1770380075; i=lukasstraub2@web.de;
 bh=3SkpMi4quISgRmRXEBHkyLwy4k46W7154mr9/Z8iw+A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EcxfWoBrTGjXpIt/vg9NpB1PnIph7aLn9kZxpok962BciPJaZ/XTeObF3sAZx96y
 niSgwXl0+hu5DKAVvsmlJytxZ9dP5q5Pfllr5TBnxJKF6zdV2YtyzIPbiO0/roW1j
 IEED+tyDt3ooLM3jmwFyW1C64o3g5HGmS6pX35yKg/DwTZN8sf8d2qd2FpjNyh/cn
 +SaxcWwZAIAV/F7A3l8rMeGlvLQ1icgIwHWUhGLW/UNP7CwxfwkEJE8AwfVgfOXxZ
 39E72uvGpy72jowtSLWO/BRPKKeJehnJEQllbQmxJwZsQEICcrA4D0NRHiElb+Dj9
 KA2UA7nl/kuo3K7B2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1vQ9wg1SG9-00UthZ; Fri, 30
 Jan 2026 13:14:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:14 +0100
Subject: [PATCH v4 06/16] colo: Don't send ENABLE_COLO command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-6-7115ab6f0e77@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Wxl6FQI19QQqNOv671X8shtuGgShfiq9D8FfSoZ4gdk=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClOfNuIm5eE9q9TmqbLIhBqxU16PCjxKQiv
 YtcMjEi+HuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WB/bD/9U3w0gky6Wy7lBK58Y0Fsw8LA9ua0zpgw6oHCQH/N63aZHN8+beSwMYhjl0h5jN79B0k/
 x1/6azBt7Z1wCa7GL/zYKpyu6F7bEwBvD0EoFyiGTsp2Gc7FsY34nIIwz1A6sI9W8w16eShvLxB
 zFyLGue7QvVB8lDX1mRZH76Y3PAX2MPHbs68CLytxSPpQp4cIT0YInJi/Ky5McVVsJJmyDH9BqQ
 Tq9xo6I9CV7Yq2CvUFqFuofUyR0ZKEE8DxcsC85tMygvv6cnHGTERH69QYNRb2iH3rgSZBVeB3r
 a288pdwM7pmVEy9SgEsM4Hnl2bwu0QptYApurorhDffzs0DQjt7X2EClrES12Ary+NcRo+isWKo
 x5REPH/lOdgDahROhSoOEZ01dD1K6zyaJlnBZ6rpz2YCkaBog9nH43i3q9LspjzyOM5br4qg6Uf
 uJJRBYSSKzL7fW5fijbmHXi0+5tvfCg0JX1lLMVLOTyIjetscGuAR2A+WheJjubMobfJqdLIKqr
 7dkMFA/lerh+GcG39z/vZu6LAx0HDtbrgcLb3kAl9RbbsRE6L9363H519JlQFp4cNJy+kJ98VtM
 Jrbwy88JDfIDsMluRokO+L3pYIdZ1ekYRBp91M33FMUzv9aqD2HKN4xnw+EREXK6vthpB4Hu6tz
 ICF3x7NEkdbc5lg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:v2Ej47Gktq3lI36GjJKOC6b0h4tZ8bNZeMAfisNBlOilpHS8mat
 rznLA7E8Gs/cu5CnOKxBfjykd3E0unpLc7bqrkXCW74tphBZoxhUVwiAtTiUipf6t8E3IJy
 R/M8ug2uEvvpRLUUWmKL6GcyGKom47V937s0IaLe/EZEn9hO8xn3ImMyjISfBM2YeemLbhb
 4zHWGJMI0+kZ9srulD1yw==
UI-OutboundReport: notjunk:1;M01:P0:vk/XrUD5OZA=;EFozOnd6QrW8GrzrlQkCJTTKB9g
 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
 VVrQtbLUzvtqifKIkt9bmfDKZ64eG
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

We only support COLO with the same version on both sides so this is
not needed anymore.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c  | 5 -----
 migration/savevm.c     | 8 +-------
 migration/savevm.h     | 1 -
 migration/trace-events | 1 -
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3f3fc5276bb067ae1960e4b675b33208ad641b23..5515be1bf305b40ba0b590136d=
f18a53451872c5 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -3496,11 +3496,6 @@ static void *migration_thread(void *opaque)
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
index 413688b75f4bee6cb10878eb51886cf6ba14872d..a3af09616a7bd22194ffba3cfb=
7cc4cf15fc88e0 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -90,7 +90,7 @@ enum qemu_vm_cmd {
                                       were previously sent during
                                       precopy but are dirty. */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this strea=
m */
-    MIG_CMD_ENABLE_COLO,       /* Enable COLO */
+    MIG_CMD_UNUSED_0,          /* Unused since 11.0 */
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


