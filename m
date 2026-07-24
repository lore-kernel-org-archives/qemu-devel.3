Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D1C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHlr-00051H-PT; Fri, 24 Jul 2026 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlp-0004r5-87
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlm-0008T1-Hq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7N11i6OZVIXLBMkIPP1QBIvrvvjyEy7GoTzD7/AppxA=;
 b=McnxVXxTAHz1G/mT8fU9s4MzIBAb5cza5DOwMCkqQQ/YOiOkplyQ1wAxcXYH4cMDtNs60Z
 ZJ+i5hi25pcZSN7wTlVJd6WCpzQXAbwD+i00x0HMMDaskR8g84N7wCj+aptEcLxE/YK2al
 yB4BpR+9v6g2k2qa7u8n48ndMhmfb44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-A0U3R6nHPGmUgMB35pPqAg-1; Fri, 24 Jul 2026 11:23:24 -0400
X-MC-Unique: A0U3R6nHPGmUgMB35pPqAg-1
X-Mimecast-MFC-AGG-ID: A0U3R6nHPGmUgMB35pPqAg_1784906603
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-476608a9fefso502859f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906603; x=1785511403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7N11i6OZVIXLBMkIPP1QBIvrvvjyEy7GoTzD7/AppxA=;
 b=fbTiqT8khQW6kuGwEA69sENxlzw/ZzUchHUwjzgsylHJ4Qbs0gF4vf38RKWmfdVwmv
 Zo5OM80Nf/7pUmOaZOhQaBEqIC5wZ1rrp0JKucSar6AmHKo7DajGICFVVA1ykBV5wNPg
 Fe8yMB1HJ67mDwFJ8wqFY3//Tv6p4EezM7jwkVMBMJPEA1iM4mDx81GNwxGjAFWBNAmS
 rlSB3YUM302pzTv3GIJnvR3flPc6HPl126w6cuBHqS0uK5oy+Bz8IGWa9tzadpgn1UXF
 rgB9YqYk03AY0kYGKhy0X/UjappF0KugGwIX0b4Iwtovs266FW4zSLze5Kj34xolmDLw
 6AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906603; x=1785511403;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7N11i6OZVIXLBMkIPP1QBIvrvvjyEy7GoTzD7/AppxA=;
 b=IRBbuvst3yl3x4ps/VW6ofPMU1GpG3OtxzfLGDFrJp1M0vG1CnYGmsAmZCxO6/bYPk
 EtXB3FvdUuHrg7KnFhxoYpBXIsGZo/7jAY+h9f1S/uX+aD20lHNLpfAccFIu5LgbEZuD
 ktKMkWn2irn5gGIDXDbE1U5gvyCA0o/zwlMyw/r+OXwRsWuR+mgssjLjxgQ2HoAZmcr6
 TUlXqyVaXq9oSCrNf7FgagBrAgCyAdIQTV59vjOPe/cyztd3szG1xreh0RaJQQwKfTHX
 sZLaMSq79fEHhuknlCdiwPoOccHG7V4HwFg3DiKqyS5kDyK2tvrXI5vlLPHh7eqOonQ8
 gs/w==
X-Gm-Message-State: AOJu0YzT+B4kNlSPC9CYtXGZVrufvPAANU4JmdrviVQ0GDb8gWgtq2Sm
 hrMXvJEDb+B9jQ2CPesxhs6reX/dmc2K7VhwLgkGSnvf1Pc6xRrlHYsggNtIQJwbIrIiKMHKpn5
 yPm0tgeFf6dPWC38/EsZGOVaqEhaw9nBhxxR8uz+TlOwZ0hKNqRI4X7iz
X-Gm-Gg: AR+sD121mscD+sJfswRMIjat1FYqHLlyn6d9VdvMUTM4HnyO9EYHQTPS7jn+qYXksXU
 mN6XH2UWMwLfJT6NiRG8dNrrz2TNlTuL198FPwt6Y7LWHf4p5Oj6rKlMIxEvljoPk2LGkKTpzvA
 wpLEJaXHOo0tq6Ad943wY++Fb7rgRetRT7A1uaca19xZdaTXxu+Xl+N4QJT5m1tXMPlurGakaai
 s4ut0/pDnW4QbkWM49SEZFSKAinmq6DmByQgXg04xVBeswWGPPaFTVTuWoCeDa8W7wuOFIqyahg
 vnFH0em1oNt0RJ/UI9y83Rc0ZiswWkCRNyiK+WKgzoB5X/C/Kk0OVTNbBKpOKSX0CgThiWLKSzT
 FPa34MwfgQl+Tg/7fMPk8XrFlKJnzO1wuZBx6q6fSQ+zpvrjGgU+yPYo5WRY=
X-Received: by 2002:a05:6000:615:b0:47f:97f7:87dd with SMTP id
 ffacd0b85a97d-47f9d0f5e0fmr994153f8f.25.1784906603349; 
 Fri, 24 Jul 2026 08:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:615:b0:47f:97f7:87dd with SMTP id
 ffacd0b85a97d-47f9d0f5e0fmr994101f8f.25.1784906602885; 
 Fri, 24 Jul 2026 08:23:22 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a6d7sm26167641f8f.2.2026.07.24.08.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:22 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/6] hw/virtio-blk: Account discard operations
Date: Fri, 24 Jul 2026 17:23:10 +0200
Message-ID: <20260724152315.234183-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

The acct_failed argument to virtio_blk_handle_rw_error() tells whether
there is accounting for this operation or not.  The only operation for
which there is none is discarding, which seems to be because at the time
of the introducing commit 37b06f8d46f ("virtio-blk: add DISCARD and
WRITE_ZEROES features"), BlockAcctType did not yet have a
BLOCK_ACCT_UNMAP variant.

It does have that now, though, so we may as well track those discard
operations with it, and can thus remove the acct_failed parameter.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/block/virtio-blk.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff4..56bfe1840c4 100644
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
2.55.0


