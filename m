Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B136CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFc8-0001xO-E9; Mon, 15 Jun 2026 18:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc6-0001x1-Hi
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc4-0007pV-PY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 11B3C5969AE;
 Tue, 16 Jun 2026 00:16:59 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id R3icnX3ag8pQ; Tue, 16 Jun 2026 00:16:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0E85A596944; Tue, 16 Jun 2026 00:16:57 +0200 (CEST)
Message-ID: <69d2c42cf6a04038614acade8feb80bf35dd7999.1781561370.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1781561370.git.balaton@eik.bme.hu>
References: <cover.1781561370.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 1/7] Move assert to memory_region_set_ops()
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 philmd@mailo.com
Date: Tue, 16 Jun 2026 00:16:57 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This assert is checking the ops parameter so better placed in the
function that sets the ops.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..9abdaedce0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1564,6 +1564,7 @@ static void memory_region_set_ops(MemoryRegion *mr,
                                   const MemoryRegionOps *ops,
                                   void *opaque)
 {
+    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     mr->ops = ops ?: &unassigned_mem_ops;
     mr->opaque = opaque;
     mr->terminates = true;
@@ -1573,7 +1574,6 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
                            const MemoryRegionOps *ops, void *opaque,
                            const char *name, uint64_t size)
 {
-    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
-- 
2.41.3


