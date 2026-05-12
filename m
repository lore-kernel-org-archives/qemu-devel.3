Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389CDCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuBL-0001sI-BS; Tue, 12 May 2026 16:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBD-0001mR-Tm; Tue, 12 May 2026 16:58:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBC-0004ge-7B; Tue, 12 May 2026 16:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=SKY70TJATbySCjlj1m9t/Vc1PDRfADpHm3QaoE8Pdbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rfSAf235V7N99ypGI72yyFVDLYtiGRxKh2L3K7hINumyQmrWGbCuwyRQMwsg0mZRt
 FcmQlF2VVxoC+KIolc7Cd8CcmZfjuaaAKQpFU8VGrqUTIKFuYOHQ7Ye7aup+HcuXHa
 KhCgEa9p0d3YMNuA3ETBWJyy8+KJ9ViKX7SnidcFLSQMArWD9gI2gx8IeHAoV+ZYaq
 RKk2/JytuwPeSgWPtF6HhgubsMtQ4zwxqoXkKyiNXP3yH0/yqfNI7MvFDZTjKmuW0J
 QnD4vHsnwFCZRhT3N9HZwWMEWTeDu/Gfs1HL8lAS1q5qkISMesIPzlLW8wW2vXHn8v
 h0/8kb0KmZHIg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1D241AA2F1;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE2C13ABC62;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 037/107] lsi53c895a: keep lsi_request alive as long
 as the SCSIRequest
Date: Tue, 12 May 2026 23:53:24 +0300
Message-ID: <20260512205437.360850-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

To protect against using the lsi_request after SCSIRequest has been freed,
keep the HBA-private data alive until the last reference to the SCSIRequest
is gone.  Because req->hba_private was used (even if just for an assertion)
to check that the request was still either current or queued, add a boolean
field that is set when the SCSIRequest is cancelled or completed, which
is when the lsi_request would have been unqueued.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7c7aaaa342b57b0099d7fc4a9803e987b891322b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index be9bff02b0..5e9321f1a2 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -197,6 +197,7 @@ typedef struct lsi_request {
     uint8_t *dma_buf;
     uint32_t pending;
     int out;
+    bool orphan;
     QTAILQ_ENTRY(lsi_request) next;
 } lsi_request;
 
@@ -748,14 +749,20 @@ static lsi_request *lsi_find_by_tag(LSIState *s, uint32_t tag)
     return NULL;
 }
 
-static void lsi_request_free(LSIState *s, lsi_request *p)
+static void lsi_request_orphan(LSIState *s, lsi_request *p)
 {
+    p->orphan = true;
     if (p == s->current) {
         s->current = NULL;
     } else {
         QTAILQ_REMOVE(&s->queue, p, next);
     }
-    g_free(p);
+    scsi_req_unref(p->req);
+}
+
+static void lsi_free_request(SCSIBus *bus, void *priv)
+{
+    g_free(priv);
 }
 
 static void lsi_request_cancelled(SCSIRequest *req)
@@ -763,9 +770,7 @@ static void lsi_request_cancelled(SCSIRequest *req)
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
     lsi_request *p = req->hba_private;
 
-    req->hba_private = NULL;
-    lsi_request_free(s, p);
-    scsi_req_unref(req);
+    lsi_request_orphan(s, p);
 }
 
 /* Record that data is available for a queued command.  Returns zero if
@@ -817,9 +822,7 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     }
 
     if (req->hba_private == s->current) {
-        req->hba_private = NULL;
-        lsi_request_free(s, s->current);
-        scsi_req_unref(req);
+        lsi_request_orphan(s, s->current);
     }
     if (!stop) {
         lsi_resume_script(s);
@@ -830,10 +833,11 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
 static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
 {
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
+    lsi_request *p = req->hba_private;
     int out;
 
-    assert(req->hba_private);
-    if (s->waiting == LSI_WAIT_RESELECT || req->hba_private != s->current ||
+    assert(!p->orphan);
+    if (s->waiting == LSI_WAIT_RESELECT || p != s->current ||
         (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON))) {
         if (lsi_queue_req(s, req, len)) {
             return;
@@ -2325,7 +2329,8 @@ static const struct SCSIBusInfo lsi_scsi_info = {
 
     .transfer_data = lsi_transfer_data,
     .complete = lsi_command_complete,
-    .cancel = lsi_request_cancelled
+    .cancel = lsi_request_cancelled,
+    .free_request = lsi_free_request,
 };
 
 static void scripts_timer_cb(void *opaque)
-- 
2.47.3


