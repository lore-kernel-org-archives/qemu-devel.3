Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6CFE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7L-00078w-KQ; Wed, 18 Feb 2026 16:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-00076s-Le
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7B-0007Ix-J8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450183; x=1772054983; i=lukasstraub2@web.de;
 bh=feJXsSvyoUdD50huC4V3ZMVTPpDBRHkISZPRsoSX/jU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oH56S5cEmUd5+e9q/AU+IVgJffErwQgmWJFjc7rlMujgwrl4RinN4xFLmFHCqQYU
 bKS8jhhF8LbZ8hylCGSqtL1wZ8Cy4offtNBlsn7RO2I5dg+nl7oEUYpmIDr67i8I+
 0FAAfDn+Jw5iFZAOzdOoWph0chre2UsIms9TM3oug42WQ5SQtv2NnRbhqfLmhMxP8
 mC94xJ/6Eec/gnMU1oxsgTJAmg/kofha2s5Rrkt8Om1pEa+dRlUnXVHcIw/4sPDAD
 7hvFdTneuEvU1xgjwJdgJcO0Ssdr9q2AkG23Q0Xra5OpixZJRz6Ji0bz4oeyO0N6P
 Gq4/37BZqz48i5g6FQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1vVwbz0XcS-00yGfH; Wed, 18
 Feb 2026 22:29:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:39 +0100
Subject: [PATCH v9 19/19] colo: Fix a rare crash during shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-19-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=t3eYA8ZfazPubqKxMFFkqU6p4E35SXfiyBm0itioh7s=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli8+osIyjDVqL7f8EZUmSrtytacWtNtxsVrMS
 d+uf5JQj0GJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPgAKCRA1qwsonF2y
 WKo6EACM8BmBb0F6MipBaGn5TUBVKDG5DowCv7Edj2FcI+LZ4r8GXgdxEzY79mALGmWXulxSHqn
 MOdh1YhGMBJIN7rgAdIIzb96+Ba6UApTac3SuDpC/4Igvg6NF7y3UhS4m5sXUDaXV8BmIM7jaVc
 Wb1i1qFBnEYFilxArt/htba6iKa9huaNKyZrEX+KglmRRJ3rEo4hoAp9zrtj45iBwwuZQwKwkMB
 CU927Qw4qhsvVH1zotBm+tNgTkcU6USFJwVbh8j90mt3coifhySVy529kIObmQakMNgtBpS+nH4
 Obm26bG+4D+VnhWbp4FnqE/HlYYZQwXv9ROaAx2rQclyi2tV1EaW/6nvrwxM7SgY5wkvoybIDiH
 PJLd+2LTCX0u27ZEcP6Zmet/8oM1xbX/lOtYT8IwnFO11zdx+iwdMKVcgpO3bktMNUpyYru2yYM
 B9YwU4dQgB81I9lAJTkeTXnvu6zzzZ2l7j+XzXQg1whEK34FM9MXlNqqbMISNlgsDXAwfy6WL27
 LRdgYppcmHKAbDi/3WBbq7GlKhUIzfs8YTSOYI2M9tGKgAokdUGilhg6IzyKaEJdPCKXtsnZjUo
 jSZlWCph8eVLuYyR7VchZLVGj9d8C1WoLInv34fzwqcQcmBO3zRYcmes5LwJJfkLDGdEFAkXshA
 0Q6pZS80LveQ1Bw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:o4nS8b2rxN3Kp/sd8ZLPD1wu0d7/TfmrhyzuphZfKNRfN51mVUn
 3XKo7eF/XxgIY/JiF+QwNIAgF27RCZuRrnjytZbgtj0N8B1dhdt8vGpjMwOk/Qi695tZ84P
 hWTAsjd9zjUG3OsX6E+0K2cmJe2hDXnM8d0I0a33fsFRcPaTFhzOqhPTwJT+agpdQrRNoQd
 6g0pvltfESlnhipiG6C4w==
UI-OutboundReport: notjunk:1;M01:P0:7e62uTO+Ybk=;q8ywrD5B26zlc0RVUA1Dscgvnhs
 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
 +k1RdnYU=
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

In the colo migration unit test, we shutdown all sockets with yank and
then stop qemu with SIGTERM. During shutdown migration_shutdown() calls
migration_cancel(). Now the colo thread frees s->rp_state.from_dst_file
which races with migration_cancel() checking for NULL and potentially call=
ing
qemu_file_shutdown() on it.

Fix this by taking the s->qemu_file_lock.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ce02c71d8857d470be434bdf3a9cacad3baab0d5..180793fe3f25140fa10887acc3=
d87515ebf43ac9 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
      * The s->rp_state.from_dst_file and s->to_dst_file may use the
      * same fd, but we still shutdown the fd for twice, it is harmless.
      */
-    if (s->to_dst_file) {
-        qemu_file_shutdown(s->to_dst_file);
-    }
-    if (s->rp_state.from_dst_file) {
-        qemu_file_shutdown(s->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_shutdown(s->to_dst_file);
+        }
+        if (s->rp_state.from_dst_file) {
+            qemu_file_shutdown(s->rp_state.from_dst_file);
+        }
     }
=20
     old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,
@@ -544,11 +546,14 @@ static void colo_process_checkpoint(MigrationState *=
s)
=20
     failover_init_state();
=20
+    qemu_mutex_lock(&s->qemu_file_lock);
     s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_fil=
e);
     if (!s->rp_state.from_dst_file) {
+        qemu_mutex_unlock(&s->qemu_file_lock);
         error_report("Open QEMUFile from_dst_file failed");
         goto out;
     }
+    qemu_mutex_unlock(&s->qemu_file_lock);
=20
     packets_compare_notifier.notify =3D colo_compare_notify_checkpoint;
     colo_compare_register_notifier(&packets_compare_notifier);
@@ -640,9 +645,11 @@ out:
      * Or the failover BH may shutdown the wrong fd that
      * re-used by other threads after we release here.
      */
-    if (s->rp_state.from_dst_file) {
-        qemu_fclose(s->rp_state.from_dst_file);
-        s->rp_state.from_dst_file =3D NULL;
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->rp_state.from_dst_file) {
+            qemu_fclose(s->rp_state.from_dst_file);
+            s->rp_state.from_dst_file =3D NULL;
+        }
     }
 }
=20

=2D-=20
2.39.5


