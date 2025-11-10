Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D65CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUAs-00029s-FU; Mon, 10 Nov 2025 10:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9j-0007uE-1e
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9g-0001Jf-Po
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97LWOWIVGNTslIhzn2F5UxuphWwRSGYYKiGjxX6b0oc=;
 b=fM3yxpCpAe2VHkFFtEB/uUbj7YUNzcusvfJdGceWppFB8ws6QjcrxnUQ6QE9ITF6I8OMFI
 vE1gCLQPA052b2AnvOVQGisyNVTnbiMfca+duCTvu0EX149TF2YFvLij2N3jhcFCSs1VS+
 tORGg59uNIsQfvQ98newWW5xgSHuO5M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-8yEOcJbtPsyaDKdNM1SZUA-1; Mon, 10 Nov 2025 10:50:01 -0500
X-MC-Unique: 8yEOcJbtPsyaDKdNM1SZUA-1
X-Mimecast-MFC-AGG-ID: 8yEOcJbtPsyaDKdNM1SZUA_1762789800
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2e448bd9so1297144f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789800; x=1763394600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97LWOWIVGNTslIhzn2F5UxuphWwRSGYYKiGjxX6b0oc=;
 b=NETGIOoYX/VeS5QiIYkyqWdmSSI3jsq6I2/9rXNUrdP8gqVeVMcIlRavDTKTDRBgTU
 F64hT5DhpulfyCsgd08Cj/BOe/IfgeBalx5cQloTK5Ixa+2CD0Uwn+TRe/GV9grENuJ2
 LIBmZbsBhKJR9cgRdLM5D3vg/Ypic7SKyiBSy14/uPtW1Y/gzyIFgJd+ZzYIvvCEB8wU
 Ds1xrCgy1+sa1+s35QSZIhRsGDz069ro0+PP/+43IhZfz/A4W9spo2b9QFu5Z2jw2PIg
 aOiLvSMfJesqvfuUxPD8IE+RLuRC23qQQgtJj63M8AAeHuMe63h1gau0z/MCao4oG9Pb
 9E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789800; x=1763394600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97LWOWIVGNTslIhzn2F5UxuphWwRSGYYKiGjxX6b0oc=;
 b=FQq/J8J8OECYqL6dx9R2SLko9lk42Y8/Cppbz7FnaYgN3BN5ohLdIjPW8bxKgn87AS
 6sU244MaBx+ZjaqccIIW90HqAHAxzmJeUBTFzoKF5HG2fFKt2z7Br6boWcKKjXawZ1gD
 mcOQiclnRIDbas0meS2gAIeFZ6vSWjAcrvA6Ipt1DRP3FmZ0cymCACSkB+VUwC6RC3b7
 NBWFpW4/PUZh0kTl960ISciuYwhnPcbmOiLY4AYfeKhVIpaNwuJ+xjJGaqIfkIIvdQOM
 RJy7yds/AjjjFZiXGehWCSY1ArwaL9FXlRMUqKlvhmz5mGxgJcczV9amfWKmAbvB30dY
 m0hA==
X-Gm-Message-State: AOJu0Yz/w7bC0JKovUtnTJOfSYPiBRBRj1+qefNVYZAbGYQNB5ngh3I2
 4Rr1WFEp9NnyIelMkecH79wvndm1J8p9LH+NH8c8aTVf+5jRlnqUJToJe9dspurBb4HKgxcSwvG
 oE7hYjw6sru4HMhX5uqd8HxXMaLudG/AtMCGyhywIdD6bg9LX8rvzCntO
X-Gm-Gg: ASbGncsxX/JznMOz4ETNqdFy8ah3T6TK+LBxrr35CuDU69kuXjqN0uiMF96l/gHv6R4
 x9LaDPbU/0TukHKcGcl1TBqfYyxqNHXBw6UiC/tCFrVArMzFNY8XK0ZwX/WJssrIxyp50DrkmMv
 G+YovnzG4w8OGdMEpyNY7+3o0txj3821DElX258jF7WUsN/FbIsSeERwVoCtI5fqQTAH6htJjoh
 1tsi/WKjqKLh+uppdQnuzNcUjgH0fRVH4D3Go5jQ0+ggGRnZPYn4TiLkxiLvz7D1Lp5GyUEbLLU
 SaY5SKxgGoJxTtZAMZ+8QmlYw1paIdVhF8O1MNrIsrvprCHRiZJqtT2rSoj5Ysn4zXD42+TEZSN
 pCz/HO9PBxqGfTM1z3cyUUN9soqDqYKpZlcTZRemAZl243ZSbI/xBMJtRrw==
X-Received: by 2002:a05:600c:1c97:b0:475:dc85:4667 with SMTP id
 5b1f17b1804b1-4777322f29dmr74173315e9.15.1762789800426; 
 Mon, 10 Nov 2025 07:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEabPrGUNbKsMZYOk2DjBy70AWnZ2rsiHUUQFccs/agsINyOqR9bU9aSBYwhDCKDM1oiKSBzg==
X-Received: by 2002:a05:600c:1c97:b0:475:dc85:4667 with SMTP id
 5b1f17b1804b1-4777322f29dmr74173105e9.15.1762789800033; 
 Mon, 10 Nov 2025 07:50:00 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd084d4sm261059595e9.14.2025.11.10.07.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:58 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 19/19] win32-aio: Run CB in original context
Date: Mon, 10 Nov 2025 16:48:54 +0100
Message-ID: <20251110154854.151484-20-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AIO callbacks must be called in the originally calling AioContext,
regardless of the BDS’s “main” AioContext.

Note: I tried to test this (under wine), but failed.  Whenever I tried
to use multiqueue or even just an I/O thread for a virtio-blk (or
virtio-scsi) device, I/O stalled, both with and without this patch.

For what it’s worth, when not using an I/O thread, I/O continued to work
with this patch.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/win32-aio.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/win32-aio.c b/block/win32-aio.c
index 6327861e1d..f0689f3ee9 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -48,48 +48,62 @@ struct QEMUWin32AIOState {
 typedef struct QEMUWin32AIOCB {
     BlockAIOCB common;
     struct QEMUWin32AIOState *ctx;
+    AioContext *req_ctx;
     int nbytes;
     OVERLAPPED ov;
     QEMUIOVector *qiov;
     void *buf;
     bool is_read;
     bool is_linear;
+    int ret;
 } QEMUWin32AIOCB;
 
+static void win32_aio_completion_cb_bh(void *opaque)
+{
+    QEMUWin32AIOCB *waiocb = opaque;
+
+    waiocb->common.cb(waiocb->common.opaque, waiocb->ret);
+    aio_context_unref(waiocb->req_ctx);
+    qemu_aio_unref(waiocb);
+}
+
 /*
  * Completes an AIO request (calls the callback and frees the ACB).
  */
 static void win32_aio_process_completion(QEMUWin32AIOState *s,
     QEMUWin32AIOCB *waiocb, DWORD count)
 {
-    int ret;
     s->count--;
 
     if (waiocb->ov.Internal != 0) {
-        ret = -EIO;
+        waiocb->ret = -EIO;
     } else {
-        ret = 0;
+        waiocb->ret = 0;
         if (count < waiocb->nbytes) {
             /* Short reads mean EOF, pad with zeros. */
             if (waiocb->is_read) {
                 qemu_iovec_memset(waiocb->qiov, count, 0,
                     waiocb->qiov->size - count);
             } else {
-                ret = -EINVAL;
+                waiocb->ret = -EINVAL;
             }
        }
     }
 
     if (!waiocb->is_linear) {
-        if (ret == 0 && waiocb->is_read) {
+        if (waiocb->ret == 0 && waiocb->is_read) {
             QEMUIOVector *qiov = waiocb->qiov;
             iov_from_buf(qiov->iov, qiov->niov, 0, waiocb->buf, qiov->size);
         }
         qemu_vfree(waiocb->buf);
     }
 
-    waiocb->common.cb(waiocb->common.opaque, ret);
-    qemu_aio_unref(waiocb);
+    if (waiocb->req_ctx == s->aio_ctx) {
+        win32_aio_completion_cb_bh(waiocb);
+    } else {
+        aio_bh_schedule_oneshot(waiocb->req_ctx, win32_aio_completion_cb_bh,
+                                waiocb);
+    }
 }
 
 static void win32_aio_completion_cb(EventNotifier *e)
@@ -120,10 +134,13 @@ BlockAIOCB *win32_aio_submit(BlockDriverState *bs,
     DWORD rc;
 
     waiocb = qemu_aio_get(&win32_aiocb_info, bs, cb, opaque);
+    waiocb->req_ctx = qemu_get_current_aio_context();
     waiocb->nbytes = bytes;
     waiocb->qiov = qiov;
     waiocb->is_read = (type == QEMU_AIO_READ);
 
+    aio_context_ref(waiocb->req_ctx);
+
     if (qiov->niov > 1) {
         waiocb->buf = qemu_try_blockalign(bs, qiov->size);
         if (waiocb->buf == NULL) {
-- 
2.51.1


