Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813CEEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohY-00057F-A5; Tue, 10 Feb 2026 09:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohQ-00055I-SQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohN-0005id-U7
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733600; x=1771338400; i=lukasstraub2@web.de;
 bh=UJE2ovwVEJu2fgLMEYPDoWlll3YHStJCzvmj4wYfTAY=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=d5QAlGSAtWo/wPs2yR33cLfwExz9seQT8Q3WqLCKOEpd5LYD8CMqB17xTtGEdO//
 aGxHXayiUlAihP2gqVkTPHzP7Sb+oEVAW8BMPhmup56ihvOLtdECKUTBcadW3wnuQ
 Pz/N2e69tiTqqrhaLQtAXjoRjuzGJvW5eD8OD/SzkLA+DdHEVk7xyu+jRkaOiRq8p
 4gAU02TF5SH2VnH5zExqtc4bTjluIX+/MsBDK8IaZNptJS8eS8tiuZX1zZoEcrkQz
 HuOylfc+T+uRKNQxqaNYEDG8jsokY7aZqIdVzSSVIgUkSnPgS5lB0RV0m7QpUviZj
 a2/OdIC2drAOwsE5Nw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1w91cA1eBO-00WdS0; Tue, 10
 Feb 2026 15:26:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:18 +0100
Subject: [PATCH v7 06/18] colo: Don't send ENABLE_COLO command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-6-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3360; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=U2UjKxVtcqoXHNnRIOZswN08J4O1clBiHyKBzHjszW4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ac4NptZUfT2tj0yEQSV2HZ3xcFB/wH9Dv1I
 PTKaLqlRxKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WLuHEACBnWMxu4NGIe4p94+6GYmnhobdu69bU3LOaI3oWNqdMjV7hm1Qxlg4EcUUM6cZv8bjGfl
 dnwgOLxzJdys73Y12lV0Lw/YuQOIHn+JJ9ChzzoibtkPScdHSyf5BhaVTskh4ZQN3/yuCYploJg
 n5jvGLAmA621XhnGL8g5EIQhK9f6QAzLu8W+JIkz46ZSkOHyf9eXJAQU+ThhwnaWMCXXDjKsBFt
 AkdXyZoNgl75D+amaQ2U28zaHShHz4kaUfQBI9zsoW9tFAOKPg4sxWlmO+rDhy1Fk7S+pKgSpia
 rikYLTVfIQcVvYyaZ8PrpmuXO+jxwvTiIlMQvkQ2EVRfNIWmeEi3/Kn42HW8TzjJpmDv3z/1q5Z
 N6od1YqZe3AiknwIaHr+5VJtGtwIUP2Hc2H1XBwBnLm1A3pdq4uouaiI7uyH8APDTdCxpl+jK7/
 Fwlwq1qHTMfLNecjXr+jZ9Z2zXsH4bKFuAKgy8FQHSHOtk906mj9F03+vNb7U2P7a655hjKfWNN
 YrBeE3GUfV91J4Kcg3AbYhjzqZGilI5k8JSN+eBBtNOG7euJKj5G1g+m4ZZs7oEnnfsNlpZaG/C
 NIsvrgwSBCGymnCNg9GO1IvOC6fLXcWNPqxprluCbfMDeuvacxXbU1g3CRbkqQlqvkxLoZfYb1u
 Qgm1I4DtN+33rHw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:uBj11xeGfs/CiTwmxLx4jWVinBp7EMhI2pV8V43lr9PwI0sCdU6
 G4i1DZN5uHNjNdx4XlyW4F93pwqKuQm+ybNGZfp49LD0WFOoIhqWjrHJmy5c4Am9X8KYr/Z
 I12mDdeYHXjcChOkIQJdC4WtYOhLOODnhcj4TyqdK6jv+ExSJn8uDtCBdLhTdsMThhTxQdf
 qbdmq8nMSIQl5XJxsaf4Q==
UI-OutboundReport: notjunk:1;M01:P0:qOPnt4H6H4c=;1u2FCWz8LcummZDOhqvngeDJmrF
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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
index 413688b75f4bee6cb10878eb51886cf6ba14872d..8af38716c2557837e3adc54303=
78154fde4a289a 100644
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


