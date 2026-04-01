Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E28D35157
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qwG-0001bW-47; Wed, 01 Apr 2026 04:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyi@kylinos.cn>) id 1w7qwD-0001bM-KF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:28:33 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyi@kylinos.cn>) id 1w7qwA-0006tY-K0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:28:33 -0400
X-UUID: b9212bb22da411f1aa26b74ffac11d73-20260401
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:315622c3-ec4b-45a6-ae1f-c00c20b4c234, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-20
X-CID-META: VersionHash:e7bac3a, CLOUDID:90423360bc212990217ed51692fab68a,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:1
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9212bb22da411f1aa26b74ffac11d73-20260401
X-User: xieyi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <xieyi@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 819212702; Wed, 01 Apr 2026 16:28:12 +0800
From: Yi Xie <xieyi@kylinos.cn>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	Yi Xie <xieyi@kylinos.cn>
Subject: [PATCH] net/filter-buffer: use qemu_del_net_queue() in cleanup
Date: Wed,  1 Apr 2026 16:27:54 +0800
Message-Id: <20260401082754.96320-1-xieyi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=xieyi@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Yi Xie <xieyi@kylinos.cn>
---
 net/filter-buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 427da24097..ce3e9027a0 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -95,7 +95,8 @@ static void filter_buffer_cleanup(NetFilterState *nf)
     /* flush packets */
     if (s->incoming_queue) {
         filter_buffer_flush(nf);
-        g_free(s->incoming_queue);
+        qemu_del_net_queue(s->incoming_queue);
+        s->incoming_queue = NULL;
     }
 }
 
-- 
2.25.1


