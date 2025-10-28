Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D716CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmf6-0000Ga-1D; Tue, 28 Oct 2025 12:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmev-0008Ta-GN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmek-0003nv-Bp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auuHryN5cCB+q/vS4sVe6ErpZM58tUub9h+/jBkDl4o=;
 b=SAbTQf+z5FJwwyw0YoN+s7p9xj1J4BYsfa3JC2ed8rv08ioeJaHNjIB8eBbxkvz6hdn7b1
 a7Hvd2wJanxC99uB9xXIMAq3HG18ihxyb8GEwbUsapEkLQ5LQvf+WAOnNlm1MyC1doiWAK
 CEPJR1V4pcKidmFGTZCcfDIJCSXxpUg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-zP-FGVKRMQKnM95r8EfX9g-1; Tue, 28 Oct 2025 12:34:38 -0400
X-MC-Unique: zP-FGVKRMQKnM95r8EfX9g-1
X-Mimecast-MFC-AGG-ID: zP-FGVKRMQKnM95r8EfX9g_1761669277
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-427a125c925so3108248f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669277; x=1762274077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auuHryN5cCB+q/vS4sVe6ErpZM58tUub9h+/jBkDl4o=;
 b=edOFOxxAPDiSZwREmlI29TljxjzPpJGQKc1XcwZ+K1nYBXc32W3cj74R7xmvEAzXoy
 WEbp/4VumdI3uv0eKvFAhD98cvjXvdFmD9TuAPfA03ZEnVDOrR1fJIcFsRwKnSSRqFtq
 HLhsAr1FjkKKkq7I2c9fc1DZw3KnR20PGJht0eL/ttNZdHx6gtOe0UQPJ0IELNPcclwl
 VWzPecrHxyS/aqV4dUT6PrZJzbxHmsd2IUVQLGaXHSJNKbBsIof+wr/HOskpXeV3o63e
 vJL7VHA88UhOPTkmwWDjv2dUQBhYV/VxACtuJdBgBpvqOjyEmjO0Tdft4I0iiE01O3e1
 i8rA==
X-Gm-Message-State: AOJu0YyP14nLqugRNLPZQ9821I15smjC2hArl/g00525ypslZal/rVoF
 27FgQQOTBoD+Ztq2TuoBbQE3AQILwRcIciMLOHVaFHK4m7l1qxooTIwQIeIWKKDlxA9k8eX9blA
 y/EHgmbD6A5EbREXOeWxuP+ciZQR/7ac7TMymQZx1a8jdziR3tPdFFg7u
X-Gm-Gg: ASbGnct1qvH6k1PYCCIweM6f2tHx1HJ4lDTMYtKDNvW2817lgZkbL0yeQSQbcoa5/gY
 5woY9WayLfdxCaG5xEwPTdaXgcthYoYcYsA+ClNY4mnlw3bMS554Jaz027nNUerbH9tAsLilqTW
 sJONbyTb/Yb0nnKLgr0wgH/olXf5trWtvK6p7MP+gE4KOJqCYTy3TqTa9OVcbHUSMpFwuhJghYb
 a1NKYtA7I9IzpfPjJd503XWlRz8XbWfAsQMVNuvw+amMBZXWPeNCG7HSNxhWeZ3WmMXjLyVjB4e
 Pjpx5+anW1qzxgiD3Wx5Z8DRkckIWc3fWFWl/QnO1tiP0LL50UVzVhIH3MNUrhTaUM+m62/rJTR
 tihYjsaI8oZjRob7gtZLc6MeIIixsfzMozvQq2HS4y3PL3uhsCOJq6vId3w==
X-Received: by 2002:a05:6000:611:b0:428:4354:aa27 with SMTP id
 ffacd0b85a97d-429a7e8b8f0mr3494780f8f.46.1761669277238; 
 Tue, 28 Oct 2025 09:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxBVko4PJ83bqeJR0GtHD8wbRPRF1jRxhZEWLxfDqqFxpLVFzUNu6zxK0N8Ne7jjFSBDuisQ==
X-Received: by 2002:a05:6000:611:b0:428:4354:aa27 with SMTP id
 ffacd0b85a97d-429a7e8b8f0mr3494747f8f.46.1761669276828; 
 Tue, 28 Oct 2025 09:34:36 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5768sm21839628f8f.24.2025.10.28.09.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:35 -0700 (PDT)
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
Subject: [PATCH 16/16] win32-aio: Run CB in original context
Date: Tue, 28 Oct 2025 17:33:42 +0100
Message-ID: <20251028163343.116249-17-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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
2.51.0


