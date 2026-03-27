Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B38310F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EhF-0002qX-US; Fri, 27 Mar 2026 17:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhE-0002q7-Qh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhD-0003cI-9k
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=XoZSQtNn6vzGmkrzbo/BeldV1fbFwS0XIxHZK0K8Hm2fPeVmaDHBiCYyZnvrZ8ch0Y8JeH
 hrYhntIC6PWAhv1B1PBko5k0/xcD32SvMtPgqfWImeFBJtC9hR0R2siHRjHUvip58+8iwt
 hDamjip39Ci/wNtssR4ih0efii8VoOk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_vk_PstNPP6cJuuFZaSO_A-1; Fri, 27 Mar 2026 17:26:21 -0400
X-MC-Unique: _vk_PstNPP6cJuuFZaSO_A-1
X-Mimecast-MFC-AGG-ID: _vk_PstNPP6cJuuFZaSO_A_1774646780
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b8c472f3eso1665370f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646779; x=1775251579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=D3BRKlnoSdenaT6UaznpfQWNJsq9EgpxCB6eKKp42oRih0lC6KTWT1v4pPK1jr0ljA
 hyUVdu4AT/ONnvN+m/UfiQMhd9BOt7VsHWWoG0FVtFBVswgL4mCzpqX1sjCXNH9k15PX
 ThvEfpwk+G2nU9+5gmjerMXYi3HVJuDujoUD6kkofgiBXsPRayM1jOlwmvCypsJUAMzG
 QMrUgsYJAqaDUPKRIblsdBCojmSm40Kj8iz9TXC18ZE8lmtVUZJQwd9B/JeZb6coMWDu
 WhgryoX/26VqaBIr1KG3ipIc5Z9O5o2ZBSmjR6FI6sZ5baVUxURmPifRkbrd19mxpKAm
 bgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646779; x=1775251579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=UHWxNt7kbgntWQ3o5Bwtk2zzOOmIkvgG0Fmn0abHLvAASmkRKBVUszDFYk68WeIU59
 79IyoVc1IzMZnjCl8JNuySap2dJ5vucCdqpb3tTPI4F03OBbQOO7k9mENj33QF5sDk1c
 hxh50pB1kwP/Qo1ZMGUJH2S9PSG0eX8VsWl+FzV/OXwt06iqEpaGNu9R7aNYBk0y9FA9
 sgunOd5At9acCLNtM+N/z/aoHOhHLIQCuwSi2Tp9T7KWhLorhycx4jGuSqNsLbQvFH7q
 uxe093l1k9KFctiRG6uRH6XczZtNpebE/HncHU1zOXLLNX3d/T4tn6xoVK+thKFI+Uju
 YOyQ==
X-Gm-Message-State: AOJu0Yz3g2/t6mknmHd5a58qWLJuZ0cTU9DjAcfLBpSgRGOvhr0AA887
 8lDAXszE6HgXhDY+/HT3+4TeNrV/nPHmvB1rDoTA02T9pHzXmxz2A7hicQsDPTNXq31WBCJ4dPI
 J8Mi/KA3DVZG4o1UbT604IaCRfto00VmJjqzK3XK4qCCeqcNHrn6S1+a0JbGFeprnwQmaosAY30
 Xr9o70KOMCz6y1KfYK4ZXOnPOWGFuLNG18fLL8+G2/
X-Gm-Gg: ATEYQzy263h47HpVTiu/uJSRAUkg0AAblQVaaHaRTrgsmVNmIYvCYr3gc7cZDeGCNUg
 1fKTxMBMbA+qAyk032kBb1AOKBr+/OGA3Fn0BMM5WxOhIl5uM5hNnsUDAKGODc5GCfdB1aGy5fH
 vnEz7P/9bgnwZ9l+0jKnrGdEiC2Vmm1QIWlC+s4ZOrzXotq6B9SKnyF6mMWrc4vGWVv2tfewpAl
 qNj7AUcONnPf0FLPUFcLSnQdZXFTzv64gyMSIkz9DQoXPmLyFgj3amHk9eYLyX1sG/xsOztBlvM
 CQaixcpgoIpUcFUqMoB4i48TEgp07MX8pa1mMf0aZv3TSUlPoozpITBzcFl8lXeKG6K7wWJnz+M
 B1F1rclu1F6XNh91GdkZB8FGzWpT0CZdrvbgI0DB+PRKw+1HchSRFSp+PM+VIFSGW6PD10Uf0D2
 P3eO8WTFvdJLUUlOJIsNRlZS2p
X-Received: by 2002:a05:6000:22ca:b0:43b:921e:d2fc with SMTP id
 ffacd0b85a97d-43b9ea672f1mr6847156f8f.46.1774646778669; 
 Fri, 27 Mar 2026 14:26:18 -0700 (PDT)
X-Received: by 2002:a05:6000:22ca:b0:43b:921e:d2fc with SMTP id
 ffacd0b85a97d-43b9ea672f1mr6847123f8f.46.1774646778133; 
 Fri, 27 Mar 2026 14:26:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f279bsm768401f8f.16.2026.03.27.14.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PATCH 04/16] lsi53c895a: keep lsi_request alive as long as the
 SCSIRequest
Date: Fri, 27 Mar 2026 22:25:35 +0100
Message-ID: <20260327212547.460420-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To protect against using the lsi_request after SCSIRequest has been freed,
keep the HBA-private data alive until the last reference to the SCSIRequest
is gone.  Because req->hba_private was used (even if just for an assertion)
to check that the request was still either current or queued, add a boolean
field that is set when the SCSIRequest is cancelled or completed, which
is when the lsi_request would have been unqueued.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1180e601811..b882fc02276 100644
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
2.53.0


