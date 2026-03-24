Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FB9F532D0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 04:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4t1r-00011W-Gb; Tue, 24 Mar 2026 00:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4s4p-0003mD-DQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:05:07 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4s4h-0004DY-Fp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:05:07 -0400
X-UUID: 33ef4fa4272e11f1a21c59e7364eecb8-20260324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:614953cb-7a60-44ec-ad90-7df7e7475261, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:89c9d04, CLOUDID:b0f06e0a013fe8c31943f95c1522be85,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
 DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
 0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33ef4fa4272e11f1a21c59e7364eecb8-20260324
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 2078942221; Tue, 24 Mar 2026 11:04:41 +0800
From: zhaoguohan@kylinos.cn
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] net/passt: don't close socketpair fds after ownership transfer
Date: Tue, 24 Mar 2026 11:04:39 +0800
Message-ID: <20260324030439.820494-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Mar 2026 00:06:05 -0400
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

qemu_chr_add_client() and g_subprocess_launcher_take_fd() take
ownership of sv[0] and sv[1], respectively.

Closing them in the caller after the handoff can result in the same
fd being closed twice when the owning cleanup path runs.

Avoid this by tracking ownership and only closing descriptors that
are still owned by the caller.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 net/passt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 4ff94ee509d4..930fe44cce4f 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -331,10 +331,8 @@ static int net_passt_stream_start(NetPasstState *s, Error **errp)
     /* start passt */
     if (net_passt_start_daemon(s, sv[1], errp) == -1) {
         close(sv[0]);
-        close(sv[1]);
         return -1;
     }
-    close(sv[1]);
 
     return 0;
 }
@@ -458,6 +456,7 @@ static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
         error_setg(errp, "Failed to make socket chardev");
         goto err;
     }
+    sv[0] = -1;
 
     s->vhost_user = g_new0(struct VhostUserState, 1);
     if (!qemu_chr_fe_init(&s->vhost_chr, chr, errp) ||
@@ -467,8 +466,10 @@ static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
 
     /* start passt */
     if (net_passt_start_daemon(s, sv[1], errp) == -1) {
+        sv[1] = -1;
         goto err;
     }
+    sv[1] = -1;
 
     do {
         if (qemu_chr_fe_wait_connected(&s->vhost_chr, errp) < 0) {
@@ -482,11 +483,14 @@ static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
 
     qemu_set_info_str(&s->data.nc, "vhost-user,connected to pid %d", s->pid);
 
-    close(sv[1]);
     return 0;
 err:
-    close(sv[0]);
-    close(sv[1]);
+    if (sv[0] >= 0) {
+        close(sv[0]);
+    }
+    if (sv[1] >= 0) {
+        close(sv[1]);
+    }
 
     return -1;
 }
-- 
2.43.0


