Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A6CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuALS-0008Pr-AV; Wed, 12 Aug 2026 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJv-0006J8-AB; Wed, 12 Aug 2026 10:52:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJt-00072x-H1; Wed, 12 Aug 2026 10:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=stAxV7gNLR3BcCuDZ0PCzPqHZ3kHkrYdLVCFpRrSV+c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hf3zdL5MtiRQDDgQyszrJikOHTl4yGRTENIu2F8MXUxg+Wr00VJnXh+eJjcMfk74P
 Uke1ofBtWx8yIuI7vpStLayMDYqvOcxxNDo4pbGGSan+q9LtTXCxF3d6D/VQsqhCyu
 JpdB4qxyFXDEWzyn37wm72ihC+quotqCIoUp7GfThgYqC/wav8XxQh74NeltpUNmfV
 gNWIYUCcPG//oXLq8bkaT67r1R3P+X9KKR7ifBO2pbVAg4RZxe5FgrRLmW3J04S/eR
 /fqQSY5f6As1hhgd/9ZYY0NBxsJtKqQ2KacIin82H3sEEB9YX3f5ghZlb5fC+T+2aM
 AfqTiz6uqHgvw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74A411CA620;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFB19409D5F;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 39C052F99B; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 028/120] hw/ide/core: Fix possible crash via NULL
 pointer in ide_cancel_dma_sync()
Date: Wed, 12 Aug 2026 17:48:11 +0300
Message-ID: <20260812144955.649205-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
two IDE drives on a bus (primary or secondary drive) to cancel all
pending DMA transfers on the drive. The code then checks
s->bus->dma->aiocb to see whether there is any IO in flight on the
*bus* and then calls blk_drain(s->blk) to wait for its completion.
However, s->bus->dma->aiocb might belong to the other drive on the
bus, and if there is no disk attached to the current drive, s->blk
is NULL. Since blk_drain() does not check its parameter for a NULL
pointer, QEMU can crash in such a case.

To fix the problem, we have to check that "blk" is not NULL before
calling blk_drain(). And we have to call blk_drain() for both drives,
otherwise the assert(s->bus->dma->aiocb == NULL) statement after
the blk_drain() might trigger if the IO in flight belongs to the
the other drive.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/905
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4052
Reported-by: dong ling
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260721070216.82984-1-thuth@redhat.com>
(cherry picked from commit 9b899ddb2706150ee1e5d0150a11bb021377ecb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 4c1ee19d8e8..fb9bf11b455 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
      * In the future we'll be able to safely cancel the I/O if the
      * whole DMA operation will be submitted to disk with a single
      * aio operation with preadv/pwritev.
+     *
+     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
+     * so we have to drain both drives to get it cleared.
      */
     if (s->bus->dma->aiocb) {
         trace_ide_cancel_dma_sync_remaining();
-        blk_drain(s->blk);
+        for (int i = 0; i < 2; i++) {
+            if (s->bus->ifs[i].blk) {
+                blk_drain(s->bus->ifs[i].blk);
+            }
+        }
         assert(s->bus->dma->aiocb == NULL);
     }
 }
-- 
2.47.3


