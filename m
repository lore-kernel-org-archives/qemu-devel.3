Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE9E10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdS-000368-H4; Wed, 08 Apr 2026 15:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAYA7-0000rf-6B
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:03 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAIbZ-0006Vr-MR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 22:25:24 -0400
X-UUID: 2c429f2a32f211f1aa26b74ffac11d73-20260408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:86b7a1dc-c663-4b84-a90d-eb7dd1256d10, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:d5ee1104897b8e35f4c2d2b1890b79b1,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:2
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c429f2a32f211f1aa26b74ffac11d73-20260408
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1406993118; Wed, 08 Apr 2026 10:25:13 +0800
From: Jun Yu <yujun@kylinos.cn>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Jun Yu <yujun@kylinos.cn>
Subject: [PATCH] system: Improve error handling and robustness
Date: Wed,  8 Apr 2026 10:25:07 +0800
Message-Id: <20260408022507.27457-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

This commit fixes two important issues:

1. In parse_name(), ensure qemu_name is never NULL by initializing it to
   an empty string when the "guest" option is not provided. This prevents
   potential null pointer dereferences.

2. In parse_add_fd(), replace error_abort with proper error handling
   using the provided errp parameter. This avoids immediate program
   termination on failure and allows for more graceful error reporting.

These changes improve the robustness of the QEMU system emulator by
providing more predictable error handling and preventing potential
crashes.

Signed-off-by: Jun Yu <yujun@kylinos.cn>
---
 system/vl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 246623b319..eb07b04044 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -560,6 +560,9 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
     }
 
     qemu_name = qemu_opt_get(opts, "guest");
+    if (!qemu_name) {
+        qemu_name = "";
+    }
 
     proc_name = qemu_opt_get(opts, "process");
     if (proc_name) {
@@ -626,7 +629,11 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
 
     /* add the duplicate fd, and optionally the opaque string, to the fd set */
     fdinfo = monitor_fdset_add_fd(dupfd, true, fdset_id, fd_opaque,
-                                  &error_abort);
+                                  errp);
+    if (!fdinfo) {
+        close(dupfd);
+        return -1;
+    }
     g_free(fdinfo);
 
     return 0;
-- 
2.25.1


