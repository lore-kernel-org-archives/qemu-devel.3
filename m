Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25073C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofje-000061-Gv; Tue, 28 Jul 2026 07:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wofjb-00005T-3I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:12:31 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wofjY-0004D1-6d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:12:30 -0400
X-UUID: 2a3924308a7511f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f6473d65-276c-4d17-995f-68703e21d8c1, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:f6473d65-276c-4d17-995f-68703e21d8c1, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:b225b5019b9461c859ebf45dcad40170,
 BulkI
 D:260728191209SSOAZ7L1,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|136|85
 0|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
 il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
 E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2a3924308a7511f1aa26b74ffac11d73-20260728
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1418706460; Tue, 28 Jul 2026 19:12:04 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH] cryptodev: reject queue counts above the array limit
Date: Tue, 28 Jul 2026 19:11:35 +0800
Message-ID: <20260728111135.572426-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
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

The queues property accepts any non-zero uint32_t, but
CryptoDevBackendPeers::ccs only has MAX_CRYPTO_QUEUE_NUM entries.

This can make even an error path crash.  For example, a builtin backend
with queues=65 first reports that it only supports one queue.  When the
half-created object is finalized, cleanup walks all 65 entries and reads
ccs[64].

Reject queue counts that do not fit in ccs[].

Fixes: 46fd17054548 ("cryptodev: introduce a new is_used property")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 backends/cryptodev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index e8f2b18f2017..84f00313e925 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -309,9 +309,9 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *name,
     if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
-    if (!value) {
-        error_setg(errp, "Property '%s.%s' doesn't take value '%" PRIu32 "'",
-                   object_get_typename(obj), name, value);
+    if (!value || value > MAX_CRYPTO_QUEUE_NUM) {
+        error_setg(errp, "Property '%s.%s' must be between 1 and %d",
+                   object_get_typename(obj), name, MAX_CRYPTO_QUEUE_NUM);
         return;
     }
     backend->conf.peers.queues = value;
-- 
2.43.0


