Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D6EE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3Z-0004M8-Km; Fri, 06 Feb 2026 15:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FN-Lz
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008OM-72
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408205; x=1771013005; i=lukasstraub2@web.de;
 bh=VrcI6PxuZ1L8eXHQm6VvRgueKLdx7DyhK8LwdtUh5f8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tRjjrul/jPqMkAFmvmVa917tbu7AxII1d0++2c5KE4JFBNw+Pabvez71ooEJrNfs
 N9oi/JikweHzYCAw5XUxuXffjZLLDktK4fj0oiz0Ol5NGe/hxpYvjGbDB/Dn5hIe1
 np57XUbwKMrMkMBN0y71OESR4G3kR911f0x2aSmzqia9mM5gJ2e9Xex7GCRM9lopR
 a0i0JV2Onp9J5AhJs0/2TKsjX70Qy9pxMhO5OyLBpy35DY33CV8X1Fp6Mu4Q/4Idn
 5f3plo7wbYM8qkrcLPaRQrDz+VPW5XMvcYdZhKzj7lrm3RPusaryP0du3Xwxd8Pax
 gtFKxlxTpO1Gv8fh/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1vtPrX0KaM-0050hA; Fri, 06
 Feb 2026 21:03:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:04 +0100
Subject: [PATCH v6 06/18] colo: Don't send ENABLE_COLO command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-6-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFAEJVKHgyp4IbjBlSKasUqhI6EoAlBGHuO
 d6yTpolpe6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WH3rD/98xYjQZP89QHLl27pHLLAipUHhN9PjpuMamLQFaU/So6xmBq8pKl2MTZLZX8ZzAcKOU9N
 eHG3MQpOs9+ZgLfslqu3VUFHNMlmZj/ClFhG8Zd8laXFLn38vbO0PuRA99lGMVavPV2mWzzh2Dp
 l1Bw649MNjpv2ImEwFtvp9Oa5zzuBiTWO/dXkKvFsatvlKR2PdnJKqmFDm6Lcqm+Ga9qbLh8wHX
 8Zj1cC3T6w8CbQg7x1FXRY7Aw9s1ku2EPphpa/r1ywg1t0x9xdx42cN6a6rSFp7zD7SAVce5DsX
 JiloEIx9p0Ttxf9ItPOwHi7tex7lLk+aALxNqihJKfEk/x0eNOuWNDbtDsNxxSMRVbKSYf8YMfW
 TR0OtOMcxXZiaOQQaWySf2+/6K/6eS9ZQf0x6oAD7UT5Wu8sUWmBAMMA97I/vg4SRh7/dbwpP+R
 eygLu0PCJsuVBVQ9rYmiSvPoBp8n5MgGCqe/o7ZhppczGkG7SpFYUOaHvYtMXME1epca9pyoKyE
 ixqYWZv7ncXxwnbBvnk5Rg5Fy5C4AmEBDTfMfs8LvcUC83pDOQxl4X/BJ/1yywslnnlLUHu3YCS
 k6ewglbmZjGhRoP/Li3KW5AlNbj1mMR+oSK9icpJpFLlePytuWB87PNHMMLXwO6yaSNXsvacg6k
 r4XNxr2JRIz6fOw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:79V5jId5uJpE4TTvgzEUWYoNmI1kQC1KtqcaMkWIyrR3Hu/JRFU
 c+ygyNIqgBUK172mdRiQgnOmH6Iv5i0PMGJTt35SHd/EReJoEXyt2wjoE/KWezm2P/8o5it
 NhNdeeJrnO1EApoj8Rzlw6SkLjFddPhtjJE3q/1pQG0LdaNbv8qGD8Vqs0vfUu5HroqHkNQ
 3FHJCu+9jwflPvrwCiUaQ==
UI-OutboundReport: notjunk:1;M01:P0:DvBlSfMHSCg=;LMO2Vqe51J4nr/TJtxjbu5pjD2w
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


