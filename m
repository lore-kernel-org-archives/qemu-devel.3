Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3DAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7TH-0007mQ-CU; Fri, 13 Dec 2024 10:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7SE-0004yH-0q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:46 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7S3-0005RF-8C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:45 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6a3c42400so318726266b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103174; x=1734707974;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSBpg2hYj8CiNrxPOnsHHRCwOt6RUqezuji7AZqApGE=;
 b=ppGMd1pNcd+4In8fw5V90RZS1+9CXZ50L0ZMiDiF9gMvywyPk2+EJ2gQT/lM1q2tdd
 PBn+U2YYhSBTFQXVhoZjfBw7k8c8CyrgpbX9mVfmQaOVmhTu9EV92T2NbhAjGHnM5bpX
 Lrha0Az02PpFh1nsGA05LQeGA5ik41WX2IvHa5ZUilWhZrYz4azaui/FMq9zFCe+ba2S
 71YTCqm6pWrXua4P3rlcMyPJ08W3dt4jLK0WwHGsBIjbur76E0Q0KxjZyXpoG7iy3dmT
 LVnQe0mKNIA9GT0kCop3TvqwKLNLPvsHPe8CVCpUpAIN9o7Le2PtAlmD/h55c2RmPXkG
 xEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103174; x=1734707974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSBpg2hYj8CiNrxPOnsHHRCwOt6RUqezuji7AZqApGE=;
 b=drj0IJK+YgosAFhoUVeXuja/ZKyDynJqH68qPPxBmyhvKUQ1FjML/xvXLh3ajBY3wJ
 LZgK4UOGUhymcbO9b/q9QzcmxURzpft/rFRs2pUojFw2bEglF8MkZS+T18lrXqzVU7nG
 GDpL4qg1g/sY4W4eoWkgzVvgBq7YzQXvg8ltbFgpsx7T1p7qOn1XlSE9+IBgFY94mDAL
 bLnLg6S9smRlnQt5/QZglwhsCsi/Ei0jhah28Qej/z3vx4kY/bqjUIBFG6VjXXu1w0N7
 xxffIUBcJainZOHBkdBVyFMuIFE7L8xG1aPzshrcibMZs9esToWtTXS1Dh09J5v9uOno
 9UBQ==
X-Gm-Message-State: AOJu0YyMg1LRCwqV4wZ4UjPLHG8Rvsd/NHBsqiKIVTIbOuWJYUJMZN8n
 W3B+UdGFnZW0yfIFCDslmX6D5BKbotOYnwdiM/GneNlN5cGT+5QoBTuIghae4v9QjBe/zUYhKuj
 hHw==
X-Gm-Gg: ASbGncs7QYTio4kY92gpfHSFN3/8anjfeuAzauO5K1hTyiSoAVHxtSbEU5UNGTq8UQk
 SqumRERZk/0v2HZq7Xiz+Ofy78rJfUIbLXe0F3Q+omfz6F6TqLXuLwW404IWRWjWyFBBSzmaDyx
 kZZ9W+N0lAZlUw/pa2Gb5UMVXs2DX318Yel1dbMjKqCqD92ymu3raA5tEroczAv2mjvx//Ng93a
 CUK1pwrUqe5c8F6KI9kx9OHe+/DQ3ZYoqtTu7AwtUtm95lEx+6PoORpN7AJiAyGaUm+SruFCosr
 KruLzPA9o4FbYXhuPvLoAs9yU2SE5OBb
X-Google-Smtp-Source: AGHT+IH3vPN8OrY/FjyTEENdPORXBL2scMFbSqkuqSFCNID3xOwjVcWxaenO+1nw38CLmHESwk7LWA==
X-Received: by 2002:a17:907:3f20:b0:aa6:ad4c:7d55 with SMTP id
 a640c23a62f3a-aa6c415fa8fmr841195766b.14.1734103173633; 
 Fri, 13 Dec 2024 07:19:33 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:19:33 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Subject: [PATCH v14 14/15] hw/block/virtio-blk: Replaces request free function
 with g_free
Date: Fri, 13 Dec 2024 16:18:20 +0100
Message-Id: <20241213151821.65748-31-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62d;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The virtio_blk_free_request() function has been a 1-liner forwarding
to g_free() for a while now. We may as well call g_free on the request
pointer directly.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/block/virtio-blk.c          | 43 +++++++++++++++-------------------
 hw/vmapple/virtio-blk.c        |  2 +-
 include/hw/virtio/virtio-blk.h |  1 -
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9e8337bb639..40d2c9bc591 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -50,11 +50,6 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
     req->mr_next = NULL;
 }
 
-void virtio_blk_free_request(VirtIOBlockReq *req)
-{
-    g_free(req);
-}
-
 void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
 {
     VirtIOBlock *s = req->dev;
@@ -93,7 +88,7 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
         if (acct_failed) {
             block_acct_failed(blk_get_stats(s->blk), &req->acct);
         }
-        virtio_blk_free_request(req);
+        g_free(req);
     }
 
     blk_error_action(s->blk, action, is_read, error);
@@ -136,7 +131,7 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
 
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
         block_acct_done(blk_get_stats(s->blk), &req->acct);
-        virtio_blk_free_request(req);
+        g_free(req);
     }
 }
 
@@ -151,7 +146,7 @@ static void virtio_blk_flush_complete(void *opaque, int ret)
 
     virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
     block_acct_done(blk_get_stats(s->blk), &req->acct);
-    virtio_blk_free_request(req);
+    g_free(req);
 }
 
 static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
@@ -169,7 +164,7 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
     if (is_write_zeroes) {
         block_acct_done(blk_get_stats(s->blk), &req->acct);
     }
-    virtio_blk_free_request(req);
+    g_free(req);
 }
 
 static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
@@ -214,7 +209,7 @@ static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
 
 fail:
     virtio_blk_req_complete(req, status);
-    virtio_blk_free_request(req);
+    g_free(req);
 }
 
 static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
@@ -612,7 +607,7 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
 
 out:
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
     g_free(data->zone_report_data.zones);
     g_free(data);
 }
@@ -661,7 +656,7 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
     return;
 out:
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
 }
 
 static void virtio_blk_zone_mgmt_complete(void *opaque, int ret)
@@ -677,7 +672,7 @@ static void virtio_blk_zone_mgmt_complete(void *opaque, int ret)
     }
 
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
 }
 
 static int virtio_blk_handle_zone_mgmt(VirtIOBlockReq *req, BlockZoneOp op)
@@ -719,7 +714,7 @@ static int virtio_blk_handle_zone_mgmt(VirtIOBlockReq *req, BlockZoneOp op)
     return 0;
 out:
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
     return err_status;
 }
 
@@ -750,7 +745,7 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 
 out:
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
     g_free(data);
 }
 
@@ -788,7 +783,7 @@ static int virtio_blk_handle_zone_append(VirtIOBlockReq *req,
 
 out:
     virtio_blk_req_complete(req, err_status);
-    virtio_blk_free_request(req);
+    g_free(req);
     return err_status;
 }
 
@@ -855,7 +850,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
             virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
             block_acct_invalid(blk_get_stats(s->blk),
                                is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
-            virtio_blk_free_request(req);
+            g_free(req);
             return 0;
         }
 
@@ -911,7 +906,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                               VIRTIO_BLK_ID_BYTES));
         iov_from_buf(in_iov, in_num, 0, serial, size);
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
-        virtio_blk_free_request(req);
+        g_free(req);
         break;
     }
     case VIRTIO_BLK_T_ZONE_APPEND & ~VIRTIO_BLK_T_OUT:
@@ -943,7 +938,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         if (unlikely(!(type & VIRTIO_BLK_T_OUT) ||
                      out_len > sizeof(dwz_hdr))) {
             virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
-            virtio_blk_free_request(req);
+            g_free(req);
             return 0;
         }
 
@@ -960,7 +955,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                                                             is_write_zeroes);
         if (err_status != VIRTIO_BLK_S_OK) {
             virtio_blk_req_complete(req, err_status);
-            virtio_blk_free_request(req);
+            g_free(req);
         }
 
         break;
@@ -975,7 +970,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         if (!vbk->handle_unknown_request ||
             !vbk->handle_unknown_request(req, mrb, type)) {
             virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
-            virtio_blk_free_request(req);
+            g_free(req);
         }
     }
     }
@@ -998,7 +993,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
         while ((req = virtio_blk_get_request(s, vq))) {
             if (virtio_blk_handle_request(req, &mrb)) {
                 virtqueue_detach_element(req->vq, &req->elem, 0);
-                virtio_blk_free_request(req);
+                g_free(req);
                 break;
             }
         }
@@ -1048,7 +1043,7 @@ static void virtio_blk_dma_restart_bh(void *opaque)
             while (req) {
                 next = req->next;
                 virtqueue_detach_element(req->vq, &req->elem, 0);
-                virtio_blk_free_request(req);
+                g_free(req);
                 req = next;
             }
             break;
@@ -1131,7 +1126,7 @@ static void virtio_blk_reset(VirtIODevice *vdev)
             /* No other threads can access req->vq here */
             virtqueue_detach_element(req->vq, &req->elem, 0);
 
-            virtio_blk_free_request(req);
+            g_free(req);
         }
     }
 
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 9aeb2931922..52d857166bd 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -55,7 +55,7 @@ static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
         qemu_log_mask(LOG_UNIMP, "%s: Barrier requests are currently no-ops\n",
                       __func__);
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
-        virtio_blk_free_request(req);
+        g_free(req);
         return true;
     default:
         return false;
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 28d5046ea6c..dcb2c89aed5 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -109,7 +109,6 @@ typedef struct VirtIOBlkClass {
 } VirtIOBlkClass;
 
 void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
-void virtio_blk_free_request(VirtIOBlockReq *req);
 void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
 
 #endif
-- 
2.39.5 (Apple Git-154)


