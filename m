Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CE2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7s5-0004sC-BL; Mon, 29 Jun 2026 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1we7s1-0004s3-HN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:01:37 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1we7rv-0002BC-U6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:01:37 -0400
X-UUID: 17c29018739911f1aa26b74ffac11d73-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f3a3d7a9-73b0-42d1-864f-b3dc494f2f5f, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:cc3b54967397f7af63bcf71e7a0b805f,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
 0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17c29018739911f1aa26b74ffac11d73-20260629
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1671236427; Mon, 29 Jun 2026 17:01:19 +0800
From: yujun <yujun@kylinos.cn>
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <ybendito@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] ebpf: fix swapped toeplitz/indirection args in set_data trace
Date: Mon, 29 Jun 2026 17:01:16 +0800
Message-Id: <20260629090116.266561-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

trace_ebpf_rss_set_data() passes its third and fourth arguments to
the toeplitz-ptr and indirection-ptr fields defined in trace-events.
ebpf_rss_set_all() passed indirections_table and toeplitz_key in the
opposite order, so tracing mislabeled the two pointers.

Match the argument order already used by trace_ebpf_rss_mmap().

Fixes: f5cae19d10 ("ebpf: improve trace event coverage to all key operations")
Signed-off-by: yujun <yujun@kylinos.cn>
---
 ebpf/ebpf_rss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 926392b3c5..6650d0daef 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -270,7 +270,7 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
 
     ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
 
-    trace_ebpf_rss_set_data(ctx, config, indirections_table, toeplitz_key);
+    trace_ebpf_rss_set_data(ctx, config, toeplitz_key, indirections_table);
 
     return true;
 }
-- 
2.25.1


