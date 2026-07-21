Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77A6C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4Ut-0006zy-HM; Tue, 21 Jul 2026 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm4Uq-0006zC-Ms
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm4Un-0008Jz-2D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HibKTBfCoTkmhuOjLj0IUrugRec83BbyEiMXyaRjjfo=;
 b=ecU/LVG61Sp6fs3pkBiZXvZu4R7UOGMbTCd1AMBt7aew4znkeKCVX1x4TJC2ah4hLGgryr
 a8xX+llypzbBySmq9Sg+hKERLYT2R/R+SPDhUUMsOiRAY851UTvyrOeQd6ohs7klLx/Ab1
 fL1jIQ4wZRQdybOUhPoWZkErn0WCP4U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-zPyPLRuOOoKBOOIt4aOkCQ-1; Tue,
 21 Jul 2026 03:02:23 -0400
X-MC-Unique: zPyPLRuOOoKBOOIt4aOkCQ-1
X-Mimecast-MFC-AGG-ID: zPyPLRuOOoKBOOIt4aOkCQ_1784617341
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65BA11977032; Tue, 21 Jul 2026 07:02:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A37773004190; Tue, 21 Jul 2026 07:02:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org
Subject: [PATCH v2] hw/ide/core: Fix possible crash via NULL pointer in
 ide_cancel_dma_sync()
Date: Tue, 21 Jul 2026 09:02:16 +0200
Message-ID: <20260721070216.82984-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
---
 v2: Drain both drives

 hw/ide/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f78b00220b8..f43ab95b07b 100644
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
2.55.0


