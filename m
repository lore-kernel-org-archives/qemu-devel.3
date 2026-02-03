Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF046E83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSA-0007P4-Q6; Tue, 03 Feb 2026 05:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRy-00076T-FW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRr-000286-KC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113749; x=1770718549; i=lukasstraub2@web.de;
 bh=VrcI6PxuZ1L8eXHQm6VvRgueKLdx7DyhK8LwdtUh5f8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E254y2BJzb51nkUQl1boW5CKfIcb3xT7mQXrFSD2zYu//CSPCJ1QBFcddDZsTm9M
 f+qbUH9OGwOwfv6mYO00uS99tQZAHE6KMDpmqjtMCXjM9T0jWbLL6Nimqw0gIfuPq
 ICPHNkXCTLsnux9f8KhdEEvi5X/CFAE9o9tXRum01rwdu0IeiQ96SlEe4a32Wi4MG
 QSjKsjsiA7rfCNE+7HbSaJQjy6DEkUpiG4ZgvGTYSKao/fVUZSMrHELf8/lS3HJYD
 /gXHHzXxFajXqKNtSkLDjITF5nP+fbpqarSGApUD+navKxxZGT7QDtMMV7YFjuGkB
 wPPawVc/zGAljhVZsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1vued73idJ-00GWPb; Tue, 03
 Feb 2026 11:15:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:12 +0100
Subject: [PATCH v5 06/16] colo: Don't send ENABLE_COLO command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-6-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3335; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=nZTC8zs4apfQA4GAvORqUb4bbhPSlbWQnSJto/VqfvQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrPMZWE0HJA3A4x2E3F4Xe0uN3WdAFynjVUK
 6tnzHVCKGKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WE1yEAC7UwZ/XPBTNnLte1sekt8R8AaYkWN0Y/2awjfSLgANSiQfQmoq3I4PhksW95yLMjei1xN
 VXFxox7fYyEH0TsF3wILXpMNG+Niteg8Bnhu6MAd6ag6le4sJ+REPuwkN6XMOQvor0RAHjpLKaz
 XOQL+Bc32N1FA6G2B4in3oSPGyFjNiNXVS6jNDtotxtxD9jMEPndAHKzqsL2cRSOSEIyR8JUi4J
 b8U1i2wHh5VIr/ag6wcZ1OH3kWRj3TceAlz0Kh2HSLl5K286Bk0EZgAftXrWQ8yiuBPRhbSFO47
 QvKqW9ugbWN4TG54ufj7AljLPn8CsYvFndk02dn36NllHoN7o8qDDzFAWJwyiu3f+fs6Y7gdqw8
 B1ds6RI6UsS+l5wWL/tWbCM1eZUUkrdWouvjcjBoeqAZzWeojiBoCztanVFPK1y9o4JLb+3P+1D
 BfF1lFsLwomB7hNw7ENRVsRL99eVRGGFBsD2dnYGYDc17qc7HqyfgR26EDmrGdwDo1u/kE73jXD
 PJO+LiHmpjk35jzUJbPQMnMq/UJ1f0A5eLkBx7L3SFAP4hCmN2wDv2DfSAgIcwjwd9EJdnH0Yt/
 qBZQLy2RuClY7jR1qdpSLvg16sT0vQZKJzqdvIG48pbKfChdmEJXHjqxfl+clX4SRoiA4ZDe15+
 UGC6685nm9SM6+g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:SNTjhRpFfC2jCkR/FnuK3znTOrYLjmx61ZifhHhjd3fQLrGaJQ/
 wMDAmEQ7nRpHI6AWHrhf8OknHKezp3k0SKhvQO//fMHIFkjquMjbcN3DZePIP3XtRuWZTRT
 az0LtLEw5CViLv5UGkYWKr0nrlGQEPym09zNin86VdpSWlOjsq1EaKJPKgJEta0s8j79W8N
 wCMsxNz4z+ZSvbMa8br3A==
UI-OutboundReport: notjunk:1;M01:P0:MuMdSBgnMm8=;TauPEZW7kpzmzRfSq/sVn/QeY+X
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

We only support COLO with the same version on both sides so this is
not needed anymore.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


