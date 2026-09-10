Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BE8C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lgi-0000Zm-Fk; Thu, 10 Sep 2026 16:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lG6-0000wp-J7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFn-00083j-EZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=Z2oSYus1MVK4pulRwhxr9XQryWS7L2IRU2pftw4C0tlg8vJ0V+IGbX0mFj7QKxiwLbLjmW
 KjLJlUGRnzRBUU26oRSMymmxJvSvzPoLPbtlfe/tehMZ2pif5dUhMzBiqbshBiNDSr0pGZ
 tp9lNN7tPNZryVez0kqJklfTyuPf7GI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-YGlGfXhRNOKFa9Wj1Ii24Q-1; Thu, 10 Sep 2026 16:13:22 -0400
X-MC-Unique: YGlGfXhRNOKFa9Wj1Ii24Q-1
X-Mimecast-MFC-AGG-ID: YGlGfXhRNOKFa9Wj1Ii24Q_1789071201
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso68759f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071201; x=1789676001; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=LJ2Z6W5UCXv/fEJUMoiC0FP7b/89nQwFuhBKgV7leLxA4vWgsZhH6HIP7vCpKwaKi9
 uvNTViB9PTuWK6cOjPCR4NTu7urFm+v35/REEhGdN5d/QQw3oLKaQiWbH73F6kpt8ZPT
 DFa/la7V1I4kBaJ90c4S/knd9SogWTyqJcwwKkI9ktV1pK/Wa/QLp3E27G0D4Dv3NLdH
 PL34Q1v2n3HJWQWBCQLZ8JVdGtdtj6WnJG2/AW8vQkWHScmV2dz4L3O71mtoRuXwNbr9
 xxRRBxSdc/hBM4VdZ8YSN1vOk/X8/qOh1wVmrXNbcxPqMjQqC/3zsjF6Oe7wuhN6Y4zq
 UUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071201; x=1789676001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=japSN24y02CnwWTQIPAaOeCag3z/0ETcY2Y08e2sFYPfUvnlD5Gi934xdo2wSgq3pq
 zYttAQAyX0y9C0I9DNUmSFpiLiy8965rC2WA/jSID/m4AjATihmiIqQJ6/GIE7Bxrreh
 XGnFLUrGdXcqQ+kvstiWzpYkAhsibF2/R3h6gkOdDMHn49hoV0d9jyA7wKs/JE/FhXRp
 UrOk3r3DKtRz7j2BrfB7uMObQy82YPTrNo6+/XasQ7xnusUz5HxPeE2WJN1haHuEjfni
 fX/JtITmr+RBkr/nv6HyvlQGZOo7i6I2y4WnswZBbnvCMiYM4x5mHfbyLExTUl6/Ah+A
 qf2w==
X-Gm-Message-State: AFuF++mSN/Taz3XaXYZj6mOo5KhrWiGh2jjUYdk3npAiuZK91BoZM3YN
 m6q2w0n5JpYnPrK/YxrrcGARg/5w4l5LxC6XG7W4Eow+PXWgu9yzr9/5lijYcdCefnB+b+CqOVW
 y1maMQ3ZV7lPdq+/Vfcy4UMXyLftSxpnNJS0QHPhw2akvhlREHg41TO9Xj0NwQH8g5eabY0q9Q3
 wFV01+YEVxjx3TP5OBkCFJofjaMYHkg6zIsg==
X-Gm-Gg: AYBFou2gbR2Y2Klw/yxrGWQGQMI0roq0iuh2sxuSR3+TEAImkXUgxH7//VAHhEIRQxo
 4ciqbOEElpA1nZA3sfAP/CdJEdYMa0Mo+uynGj76TtpuUK+Xr91CM7eDCUH0MzAtgeVSASN7GLy
 2YQkUCTWkP9nEE+RYgc01iF+LaHp4kogo/5B6dl5a+Ba8PnztWsY/2oEhUnfE+Qq1shaIWbfPVk
 6uSMDcHd5ZA+Q/+Mg+pVPjet7yeJmNffEo8/iAE6TnD5o17JLyw/5ENorenQVRv7VUz4LC9cvE6
 2Hyt/CvWq8H14khUI3BFtxLDPytiNjQxtTwA9oBs9zMBncKnTS6snh8Lm6USmpSqil/zcmAOtuM
 dftFwqEqfi6Pt/jGpN/9uyq8=
X-Received: by 2002:a05:600c:8518:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49e619acc89mr19429425e9.10.1789071200722; 
 Thu, 10 Sep 2026 13:13:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49e619acc89mr19428465e9.10.1789071200238; 
 Thu, 10 Sep 2026 13:13:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm21236135e9.0.2026.09.10.13.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:19 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 45/90] hw/virtio-blk: Account discard operations
Message-ID: <b9c513000f50cd5e67a32303a193997e7e775f7b.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

The acct_failed argument to virtio_blk_handle_rw_error() tells whether
there is accounting for this operation or not.  The only operation for
which there is none is discarding, which seems to be because at the time
of the introducing commit 37b06f8d46f ("virtio-blk: add DISCARD and
WRITE_ZEROES features"), BlockAcctType did not yet have a
BLOCK_ACCT_UNMAP variant.

It does have that now, though, so we may as well track those discard
operations with it, and can thus remove the acct_failed parameter.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-2-hreitz@redhat.com>
---
 hw/block/virtio-blk.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cb6a276a82..4110380392 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -69,7 +69,7 @@ void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
 }
 
 static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
-    bool is_read, bool acct_failed)
+                                      bool is_read)
 {
     VirtIOBlock *s = req->dev;
     BlockErrorAction action = blk_get_error_action(s->blk, is_read, error);
@@ -85,9 +85,7 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
         }
     } else if (action == BLOCK_ERROR_ACTION_REPORT) {
         virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
-        if (acct_failed) {
-            block_acct_failed(blk_get_stats(s->blk), &req->acct);
-        }
+        block_acct_failed(blk_get_stats(s->blk), &req->acct);
         g_free(req);
     }
 
@@ -124,7 +122,7 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
              * the memory until the request is completed (which will
              * happen on the other side of the migration).
              */
-            if (virtio_blk_handle_rw_error(req, -ret, is_read, true)) {
+            if (virtio_blk_handle_rw_error(req, -ret, is_read)) {
                 continue;
             }
         }
@@ -140,7 +138,7 @@ static void virtio_blk_flush_complete(void *opaque, int ret)
     VirtIOBlockReq *req = opaque;
     VirtIOBlock *s = req->dev;
 
-    if (ret && virtio_blk_handle_rw_error(req, -ret, 0, true)) {
+    if (ret && virtio_blk_handle_rw_error(req, -ret, 0)) {
         return;
     }
 
@@ -153,17 +151,13 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
 {
     VirtIOBlockReq *req = opaque;
     VirtIOBlock *s = req->dev;
-    bool is_write_zeroes = (virtio_ldl_p(VIRTIO_DEVICE(s), &req->out.type) &
-                            ~VIRTIO_BLK_T_BARRIER) == VIRTIO_BLK_T_WRITE_ZEROES;
 
-    if (ret && virtio_blk_handle_rw_error(req, -ret, false, is_write_zeroes)) {
+    if (ret && virtio_blk_handle_rw_error(req, -ret, false)) {
         return;
     }
 
     virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
-    if (is_write_zeroes) {
-        block_acct_done(blk_get_stats(s->blk), &req->acct);
-    }
+    block_acct_done(blk_get_stats(s->blk), &req->acct);
     g_free(req);
 }
 
@@ -443,6 +437,9 @@ static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
             goto err;
         }
 
+        block_acct_start(blk_get_stats(s->blk), &req->acct, bytes,
+                         BLOCK_ACCT_UNMAP);
+
         blk_aio_pdiscard(s->blk, sector << BDRV_SECTOR_BITS, bytes,
                          virtio_blk_discard_write_zeroes_complete, req);
     }
@@ -450,9 +447,8 @@ static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
     return VIRTIO_BLK_S_OK;
 
 err:
-    if (is_write_zeroes) {
-        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
-    }
+    block_acct_invalid(blk_get_stats(s->blk),
+                       is_write_zeroes ? BLOCK_ACCT_WRITE : BLOCK_ACCT_UNMAP);
     return err_status;
 }
 
-- 
MST


