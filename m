Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83AF10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B9q-0004Mg-4d; Mon, 30 Mar 2026 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8u-0003cB-UV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8s-0005xq-9J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=EobMz3zA7YsWNdOHQEbQB2W6YV7WXJJkOBVg4fFWthf4+Tp3g7Ozw5P5TYiifziCriLSS0
 1U0C+uKuFd1CYcgVPkJ3t2rEETexUFV0uzM5riz/+SUthmdNqW2POw5yurgDelKFDF2wVf
 SKCQNKjIpTV74kyLtx1UMskf8LpU92w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-2Yyro-DEMH62zTrvbSU3tg-1; Mon, 30 Mar 2026 07:50:46 -0400
X-MC-Unique: 2Yyro-DEMH62zTrvbSU3tg-1
X-Mimecast-MFC-AGG-ID: 2Yyro-DEMH62zTrvbSU3tg_1774871445
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so33475335e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871444; x=1775476244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=gWmUOgHjM14MC8DTKb8VQiePPfvpfsVI5zUrLMdA2rbn8qSo63zBppINEOqtB6WhDB
 j3R8MoG5ZyGRrjO6PujNkXSxvI9shO2j6CxBB4cDqWjKeZiSYXekYOU2fLGmzXpHVrj8
 iN225LsmAdoPN8CTplsB4HZ0DYG2g6ZjFLZOQLxKVw7Y3r+w1R0KW5L7Wa78pStHLQQ6
 dZccv2Yx4sDymNFlI4i2uErbVn3GuUwXnK2GE4TvstLPwWntlWnoXB0ZX3uC7Jolusr2
 ssQgZjQhnHtbnfSPhBOQ5Wjso6jVQnuLerqFWB+VgwpUJL3wI956SoY0gx7HAA9ceozE
 7HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871444; x=1775476244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N96Cvh9nP6r8XFXHnMsPNyo3ZrU8DUpNDRPrE2edM1c=;
 b=JbKfltReGeX0wfH8mt7Qpv+P4qHotBaJ/Cw7CHcvtl2SZF4N8cKoC5LlyZQoix22MN
 j/IlVrQzjPjIzGy3fnNV6yXioMfemOtyrwPqqr8j2vMBfws93Zp1Oc6DzSlT5j4B5xMa
 SF5C8s6Zk97x7OxWc5uWc87Q0vCKeFezyWxo6FBhB+oHgxjnUSDmj30dQoUEWb1hHukc
 SYPnCNftgoIzfFi3Xqj6B25K7+SvuKuuP8gQARhTZIY3Rmj6VGitAJDfD1ZVLVF7Qv0e
 ViEDJytQYxkrhJu/9okjAb4z21Z3Eq2ypZMX065GYhkQ1npTanY0VnMrwkP560FHWCu1
 Ht/w==
X-Gm-Message-State: AOJu0Yz+LXSZVNH9fmrZE4hYuMDo2F7ZSB4W3D0472wpMdarafOYOCAX
 GWeCUDs4fry3ZCcr0kS2wtSVZSnAzBOQYAUmgJrNpr1SvhPSOkt71yAFCfTwBCUATXA18QxukZn
 4qykGM9B5aGrlMLgE+YIAqrxoLrU2RJ4Gwu7datA7L+3V91umJ/1cb7bMm+vL3zEFUmLOdi+2Sc
 8mnILekGQXDkHCrlUomvzzgtqIFPwSEyE5WGYyOEsF
X-Gm-Gg: ATEYQzzbib8TSW1Wu6RWdewTqn9g8Kmh49NkHMKcJ8gkzU6wbLyTSzzYSkNpzTdGFxo
 TSCRlUZzFP1ZTcG9dGYIbvUjP2F3zkqQofx3ZOR8O1SQ2aqdxQubvzkhB3q0lLMJfFsqi2ojarY
 nTReEzKe6DzMwx9QRYnMCK/5CibUtCjFhvp6uiQM5oYhby0n6NwwkOGIZu+Y56qBkRgblluhDx0
 yX1+N4+MhhHUPRz5UqqfOZM1+bJgLQTpnoWqO0zs3r6QxnOJh4ikX1DNz8uSxLdXXXgoZvTuKQy
 dEcgoN0tyHcyXYHJrB9B76OEXrq8Gn635DgNtMKQQAHuAiL+QixDbfV4jmwUbTdhcwAzekJEclV
 ndFkHJzq767jr0TuYJ7C1gZbsBiPOJRrnnZ27Cyg5pWfP27/IID85QHE2RhTQgnpNYrPfBMIHrN
 XW6SXIHEIby5Tlvl4uzMJE6iPT
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-48727d5a313mr204229935e9.6.1774871443577; 
 Mon, 30 Mar 2026 04:50:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-48727d5a313mr204229495e9.6.1774871443075; 
 Mon, 30 Mar 2026 04:50:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245f8a3sm19825485f8f.24.2026.03.30.04.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 10/12] lsi53c895a: keep lsi_request alive as long as the
 SCSIRequest
Date: Mon, 30 Mar 2026 13:50:14 +0200
Message-ID: <20260330115017.256211-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


