Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E696CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMy-0002eQ-SY; Tue, 12 May 2026 17:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMl-0001GF-NX; Tue, 12 May 2026 17:10:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMi-0003hb-TI; Tue, 12 May 2026 17:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=5PYlGv51Ih9TzksCqpzyIWicot3ZhsLNMi8S6ghzsnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XGuxN2udLXL66fEZpxODgs2nhrgofzZoUQlqvChmihweM5ybnp9yJFIwaokFw8dgK
 cHcxLpvszXNBZGRNvjNY8Om1seJxhTudVfBtSaGkxkNFBIOI6FZjH1iar/bRizsCTZ
 LB7HBWu46COCiFx8DysA30k4xsXdDMfOXzv8Gs+O94vLhhD0zx4qs5TXWgTVPV+TyP
 vNKysfN7r1vCR2u/Fzy5IO4llP/jUQu1gz1/xeJeJYGppfHNOWp3xxzUL8TMtv+rh/
 ehDyPU5XjG87MBmQNQCoy7jHBkFJw1g3Xwfh4IjyoVJC+K7+fHoigxSDihC31wRnKC
 IP0HP4Aez8qmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E2F71AA367;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80F823ABCD7;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jihe Wang <wangjihe.mail@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 042/117] lsi53c895a: keep SCSIRequest alive during DMA
Date: Tue, 12 May 2026 23:53:44 +0300
Message-ID: <20260512205503.361097-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reentrant MMIO can cause the SCSIRequest to be completed, at which
point lsi_request_orphan would drop the last reference.  Anything
that happens afterwards would access freed data.  Keep a reference
to the SCSIRequest and, through req->hba_private, to the lsi_request*
for as long as DMA runs.

Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d459131ff590c517bc89fa5867d4878b5eacbc30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index b2d3980286..0b1f68a40a 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -637,7 +637,7 @@ static void lsi_do_dma(LSIState *s, int out)
     }
 
     p = s->current;
-    req = s->current->req;
+    req = scsi_req_ref(s->current->req);
     dev = req->dev;
     assert(dev);
 
@@ -667,6 +667,11 @@ static void lsi_do_dma(LSIState *s, int out)
     } else {
         lsi_mem_write(s, addr, p->dma_buf, count);
     }
+    if (p->orphan) {
+        scsi_req_unref(req);
+        return;
+    }
+    scsi_req_unref(req);
 
     p->dma_len -= count;
     if (p->dma_len == 0) {
-- 
2.47.3


