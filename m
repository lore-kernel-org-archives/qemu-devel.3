Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C00AC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAF-00049w-O4; Fri, 11 Sep 2026 05:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9b-0003Kf-Pr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9Z-0008Bz-F2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=fCT7073teAyPe6FIZiFhudKTQ8argIN7Pbm8UWRIQP+ZcbMHsPmdPgzn9UZvFrItH9KwIK
 eKGhbXpvLbBpgln3Kpj7qocHXg6d849VxZI9AjFVC/aJTAFAD3zJ6v4ZpX2oU0TXEYf7Oe
 cZ2slyHrWwFg0sHjTUAdtHJwhrptjDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-QHM21EYcN12msoCCvjcrBg-1; Fri, 11 Sep 2026 05:02:35 -0400
X-MC-Unique: QHM21EYcN12msoCCvjcrBg-1
X-Mimecast-MFC-AGG-ID: QHM21EYcN12msoCCvjcrBg_1789117354
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso3439675e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117354; x=1789722154; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=EycpQigLoyPocedAodlmw+O2JMBcRNgrJsWffHPFCRP/HmGhRl/Ks9I6TLhyT1fF8C
 UTPjIrr7zl/S0zybi5YbP563iDCkZ6NB8OiBhul0BZ9FtVi/gh2zVzNwLDHcL8rnQ3s8
 Mb9I7730g8ePxSw/scAft3sITNgumm4Co0Rv4WlDIR3Hn01+I/EaYFCklYcliwdRa1Oe
 kRIELh257/DaFVwNxFvsYjLDHxKX2kSHGnX2iWv9QqSXk0CVbTXCZtTUo4uXKjsmMgS1
 JYlRFCqb/jOeCTX9DeWxbHJzZiaYg6a4RyH54+lN03jXe3ocfp+FnOjbku7EP6XVtOBD
 Ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117354; x=1789722154;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YVWgcLlJ6W5VVT8H262UfAJpSjM0Zse4ulGjykHY0SY=;
 b=qDrm5oX1DhLOaVmUtif7oN3inRba9RmRkLWBOvjT36IezFGNm6zcEsQV+7wnRY8xW5
 YIqT247K/uQv+9eRBYofZtufn/4hO5Wn+KcDkzuKuRWN0viAu645+Icp/EdvdLVGj2WA
 zXEYUl5ym/Z5G1xoyjjlYulBLN9RPiUC0LMsU1OhI1+damXABo2y0nEJtvEbXOdZS6BO
 kTQwlr5sbHySEvJKT4XywY9FJaMMIIRdQW7bbaha5czuiYFZ0Wq+Gahp+rIggpjRj8nr
 Us8y2tZuY6TLLv4kjO8idrjRiTGuTlF4yVUPf9RS5lgSeQ87/eS/bo/Z73IOILKxMRG6
 3FXw==
X-Gm-Message-State: AFuF++mkvfERbCdcumCx+PKoXCuoFxJhRbmmFz8U5nXGGQ9A67v8d2wQ
 MZtb7gvQnBiGRxwpeT/PWLPsBhfE4CY5TPAFaclpx6aizthq7OFZ8WZ7kvlnbQd4B+fljY/AqRi
 YAHJPYxH4ke1NI5ydPuvyLnJ2EtkmThxgh3xUu3rzbni7diqTR8XfUC8ec/erARpgf73xIJLOfX
 lvwU6Mw/tzYpGUuDzwTIIl12rR5jN7OjQh4w==
X-Gm-Gg: AYBFou1qO0sRXpWx1roD/PS8OYpvSKWq3BX1PVgNykuvQLlifMuud+/At3vI4StUGXu
 X9S9rem2xSrBekodLpcCDuOmbrlyeqmRD6jla6+Saqu2Odnk/jd12sQlhIWq2a3yrDEI1ScS17w
 QG13r40tlcG1n0BUPbihk80uM51VgNyUaT8G8/t1tEhX3vg+ha69Vb9PJ3I59hYMP73E1DvKxr5
 lu55uGJHPwRVf7rLmpk4TU3MJ/09/r+o3r0CCePGAZI8/6p5tAtcffvnuamfakD3HLh2ShKcw/+
 Cr15Sk0fx0onf/LlDC3Sod2XKULLZRnIc4VYkplXvBou8uzEF6lF1YeNfTaCJ5pY9OKDpv4jgde
 eTE9msr5jxVvlcIS2vGBnOks=
X-Received: by 2002:a05:600c:628f:b0:49d:2705:7030 with SMTP id
 5b1f17b1804b1-49e60f71698mr40227875e9.7.1789117353893; 
 Fri, 11 Sep 2026 02:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:49d:2705:7030 with SMTP id
 5b1f17b1804b1-49e60f71698mr40227065e9.7.1789117353210; 
 Fri, 11 Sep 2026 02:02:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm147534515e9.1.2026.09.11.02.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:32 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PULL v2 31/75] hw/virtio-blk: Account discard operations
Message-ID: <efac4c99d1f44aae69ddc6c0168f2083ff674aff.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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


