Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273FCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMt-00022x-Ka; Tue, 12 May 2026 17:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMh-0000mR-1h; Tue, 12 May 2026 17:10:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMd-0003Tb-FI; Tue, 12 May 2026 17:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=J4Ed4TRf/MsnbFidNRrCCai81Gr6gAV6UQrEHVbJdlQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=asafWBQjKI3+7d+TB+WQWopH71R1QwktPAAuqCuoLaBEjJDzxY5mqppmkgUClgDJz
 SsZK8EUygrzgJJB5DEL3RGM2KcNt1/kspHtWE3tDeL1mjxV2ts2Qflszq7Qb4NH2Ou
 csSIxydLTV+dz0qZF6ENOL4JeVgIujO9SxgyIf7NYZoy8nU4va4NSxdC/O3YhZAviU
 5/s3ijWJAy6enSkJwhG+Q9KJBwiJN+gjlJOHdGwFdJSCrSXumvAMUFk9bmU52vK+Uj
 I0X5B76HZBi5khKu6WeFbcvE5pTdLZydyhxqei2K/W+A7z/pGoI1UdS2FxxqEGkGtc
 A8T9kKraIBNtw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 59ABA1AA365;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 67B573ABCD5;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 040/117] lsi53c895a: keep lsi_request and SCSIRequest
 in local variables
Date: Tue, 12 May 2026 23:53:42 +0300
Message-ID: <20260512205503.361097-40-mjt@tls.msk.ru>
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

Protect against changes from reentrant device MMIO during DMA, by always
operating on the same request.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1ca38f84e19427c462f077390492f971f9eb11eb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 651f562d82..3f8d7a071c 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -626,6 +626,8 @@ static void lsi_do_dma(LSIState *s, int out)
     uint32_t count;
     dma_addr_t addr;
     SCSIDevice *dev;
+    SCSIRequest *req;
+    lsi_request *p;
 
     if (!s->current || !s->current->dma_len) {
         /* Wait until data is available.  */
@@ -633,12 +635,14 @@ static void lsi_do_dma(LSIState *s, int out)
         return;
     }
 
-    dev = s->current->req->dev;
+    p = s->current;
+    req = s->current->req;
+    dev = req->dev;
     assert(dev);
 
     count = s->dbc;
-    if (count > s->current->dma_len)
-        count = s->current->dma_len;
+    if (count > p->dma_len)
+        count = p->dma_len;
 
     addr = s->dnad;
     /* both 40 and Table Indirect 64-bit DMAs store upper bits in dnad64 */
@@ -653,21 +657,22 @@ static void lsi_do_dma(LSIState *s, int out)
     s->csbc += count;
     s->dnad += count;
     s->dbc -= count;
-     if (s->current->dma_buf == NULL) {
-        s->current->dma_buf = scsi_req_get_buf(s->current->req);
+    if (p->dma_buf == NULL) {
+        p->dma_buf = scsi_req_get_buf(req);
     }
     /* ??? Set SFBR to first data byte.  */
     if (out) {
-        lsi_mem_read(s, addr, s->current->dma_buf, count);
+        lsi_mem_read(s, addr, p->dma_buf, count);
     } else {
-        lsi_mem_write(s, addr, s->current->dma_buf, count);
+        lsi_mem_write(s, addr, p->dma_buf, count);
     }
-    s->current->dma_len -= count;
-    if (s->current->dma_len == 0) {
-        s->current->dma_buf = NULL;
-        scsi_req_continue(s->current->req);
+
+    p->dma_len -= count;
+    if (p->dma_len == 0) {
+        p->dma_buf = NULL;
+        scsi_req_continue(req);
     } else {
-        s->current->dma_buf += count;
+        p->dma_buf += count;
         lsi_resume_script(s);
     }
 }
-- 
2.47.3


