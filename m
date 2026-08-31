Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7BBC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12R5-0004Bj-KF; Mon, 31 Aug 2026 09:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R3-0004BB-Vt
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12Qy-0003wj-Ax
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWNljSdOe9ZST1zA+pC3GmPfahj6oMI13NjXy9D13Fc=;
 b=RzqoRqJbi1eyXR+TMSKD4N5Bve/BdmkHF6EhM98xlBmFqQcJZy+5wFvfrBHCkVkuUASAZS
 mrd/GaCryG556BvtKrDea228mdAx8xBjOuwT2QcS0DGOIoAXEKteJEhM1qzLVxV3mGc3/Q
 IXSoaWz7BThzMYbP+5tMV8eQWzH0BKE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-04uRDO8QO8yu87Q3_AjUVQ-1; Mon, 31 Aug 2026 09:52:21 -0400
X-MC-Unique: 04uRDO8QO8yu87Q3_AjUVQ-1
X-Mimecast-MFC-AGG-ID: 04uRDO8QO8yu87Q3_AjUVQ_1788184341
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso2506554f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184341; x=1788789141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sWNljSdOe9ZST1zA+pC3GmPfahj6oMI13NjXy9D13Fc=;
 b=pQsXe5KpfSeDTrHyOxP/ClAtJElhSj5YIB0Jc6wIuBYqrZ0WCqwpmZg9ixqRBonmTg
 1TDUhaaiV0YuGYz7ofvWu7HHP5n4S+nKZ6wcaFjGQLkpMXtX5XoH6BFYoD1M/SJUwLA+
 FXTcZJCcFuMdqPa3ydRtIkRdjln+I8ebT2imEy4M92+6gk8bngb4bhuMYd6nYkZkUYY9
 1tijvOdsLxuGvxT5dGoFVAMt6GGKcBbJlUr2zbAdoHEUzdJZjh33faIJiqj+uOuy6+nS
 7SPIj1A8THZhoPGXCmW7KBmCi4tFkYaGUL2BHqQ05yHEeVkBZEAoTk/lxtGBVtF+nndq
 CZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184341; x=1788789141;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sWNljSdOe9ZST1zA+pC3GmPfahj6oMI13NjXy9D13Fc=;
 b=VqAfFH8uhwrgaaMEjq0poEjHQRVUJEn+y6HRwKI90KZBcEKfgzd88QQazHqGYG6Q9I
 k9qus+1Zr8+wl1pOSDKAbJ572ScKHYE3FW5O2p1yYE8lbZtEZNtFsHDxbAeZYBWB+qQ5
 61GscRrGpEgKZblKguJ+GWxzI+MS4WP2Xi08oo3AkJmTPaEVtCa2MJJlsQJMCZcmvKv9
 6OGuBYogOjI73iKJZ3ZZ/KVfvyUkrp6/LdBblZKWASeBX6VWOReSP6pte2jH7FDUJM2j
 8cAGSBEwDLPVqMiJyX0/yc08r8MJOGlQcUxQx74p9xEVwIbXVGrHXv8+p8EysfDNRJ1M
 M3Xg==
X-Gm-Message-State: AFuF++kV+VWlAblOGLwnjeKUEkz2ALMmJLEmPBwEujzEOzFgYoW5qhpU
 9QTxjgWfHRkwgh0Ap4UvqhysXBD+mV+sH0ZWOF5t93IHWwpkQ45UlE+P4Ui2Q3fGhPP0KGyGaDB
 JWf1qo8oNFWJ28RldIiY563K7Tp7xDfVXIYdPxAVmLiPm6Wh5idcWQ6Dd
X-Gm-Gg: AYBFou0Hk/3l/dEp3vvxXwVNGsZZML8OXnOUGyHw4qwUzB41tFMh8FhsVW7Ahirfahf
 uMj1g3v9c6nABqd8dxVTahwQbLGR3oW0+UFlkbi0SZoPj34fee4dw8eKdiBl9h5xIaoNvm2vIPj
 MXfQi8CA3lYsPAI59KwrOYh0q8nyqYmnplhC7+hBDs/s1FVEr3Hs1OCQCozlpVn1wGZUxIimCwM
 rAh3Ql4ZM3cfBAU6DzOc1baa3p41Z/EwS1qX+TKnvtnTBL1PbwDkpfVYso0n3997PttAECmTqow
 BcmGGBRaAKCpq3QwewVzVJzBL8JD/yWk1qUcTQKZSVt5mU4mEb7zBqyKDfcs9dsu1ldYOojUusX
 KmKOz0LFlULBXNYNEREF4XUH7Yna30LD58Fzj3Zd33BAyJd4rFpYM/Q3BPGc=
X-Received: by 2002:a05:6000:468a:b0:47f:7e8f:d62d with SMTP id
 ffacd0b85a97d-48440fcc37cmr1413226f8f.10.1788184340144; 
 Mon, 31 Aug 2026 06:52:20 -0700 (PDT)
X-Received: by 2002:a05:6000:468a:b0:47f:7e8f:d62d with SMTP id
 ffacd0b85a97d-48440fcc37cmr1413132f8f.10.1788184339624; 
 Mon, 31 Aug 2026 06:52:19 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843ce8b015sm5882777f8f.13.2026.08.31.06.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:18 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/9] block/accounting: Add offset to BlockAcctCookie
Date: Mon, 31 Aug 2026 15:51:57 +0200
Message-ID: <20260831135206.126184-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For latency alerts, we will want to generate QMP events from block
accounting cookies.  These should contain some minimal information about
the offending request, i.e., start offset, size, and type.  The latter
two are already part of the cookie, the former is not.  Add it.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/accounting.h         |  7 ++++-
 include/system/dma.h               |  2 +-
 block/accounting.c                 |  3 ++-
 hw/block/dataplane/xen-block.c     |  4 +--
 hw/block/virtio-blk.c              | 15 ++++++-----
 hw/ide/ahci.c                      |  6 +++--
 hw/ide/atapi.c                     |  9 ++++---
 hw/ide/core.c                      |  9 +++++--
 hw/ide/macio.c                     | 15 ++++++++---
 hw/nvme/ctrl.c                     | 43 +++++++++++++++++-------------
 hw/nvme/dif.c                      |  8 +++---
 hw/scsi/scsi-disk.c                | 28 ++++++++++++-------
 qemu-io-cmds.c                     | 14 +++++-----
 system/dma-helpers.c               |  4 +--
 tests/unit/test-block-accounting.c |  2 +-
 15 files changed, 105 insertions(+), 64 deletions(-)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index 12d32460927..9386440ec89 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -95,6 +95,7 @@ struct BlockAcctStats {
 };
 
 typedef struct BlockAcctCookie {
+    int64_t offset;
     int64_t bytes;
     int64_t start_time_ns;
     enum BlockAcctType type;
@@ -108,8 +109,12 @@ void block_acct_cleanup(BlockAcctStats *stats);
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
                                               BlockAcctTimedStats *s);
+/**
+ * Begin an I/O operation.
+ * @offset == -1 indicates an unknown offset (e.g. for meta operations).
+ */
 void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
-                      int64_t bytes, enum BlockAcctType type);
+                      int64_t offset, int64_t bytes, enum BlockAcctType type);
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie);
 void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie);
 void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type);
diff --git a/include/system/dma.h b/include/system/dma.h
index 82e7ad54374..1291697642e 100644
--- a/include/system/dma.h
+++ b/include/system/dma.h
@@ -305,7 +305,7 @@ MemTxResult dma_buf_write(void *ptr, dma_addr_t len, dma_addr_t *residual,
                           QEMUSGList *sg, MemTxAttrs attrs);
 
 void dma_acct_start(BlockBackend *blk, BlockAcctCookie *cookie,
-                    QEMUSGList *sg, enum BlockAcctType type);
+                    QEMUSGList *sg, int64_t offset, enum BlockAcctType type);
 
 /**
  * dma_aligned_pow2_mask: Return the address bit mask of the largest
diff --git a/block/accounting.c b/block/accounting.c
index 038af370170..66e5001403f 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -115,10 +115,11 @@ BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
 }
 
 void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
-                      int64_t bytes, enum BlockAcctType type)
+                      int64_t offset, int64_t bytes, enum BlockAcctType type)
 {
     assert(type < BLOCK_MAX_IOTYPE);
 
+    cookie->offset = offset;
     cookie->bytes = bytes;
     cookie->start_time_ns = qemu_clock_get_ns(clock_type);
     cookie->type = type;
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f31..f4dab9b2510 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -373,7 +373,7 @@ static int xen_block_do_aio(XenBlockRequest *request)
     case BLKIF_OP_READ:
         qemu_iovec_add(&request->v, request->buf, request->size);
         block_acct_start(blk_get_stats(dataplane->blk), &request->acct,
-                         request->v.size, BLOCK_ACCT_READ);
+                         request->start, request->v.size, BLOCK_ACCT_READ);
         request->aio_inflight++;
         blk_aio_preadv(dataplane->blk, request->start, &request->v, 0,
                        xen_block_complete_aio, request);
@@ -386,7 +386,7 @@ static int xen_block_do_aio(XenBlockRequest *request)
 
         qemu_iovec_add(&request->v, request->buf, request->size);
         block_acct_start(blk_get_stats(dataplane->blk), &request->acct,
-                         request->v.size,
+                         request->start, request->v.size,
                          request->req.operation == BLKIF_OP_WRITE ?
                          BLOCK_ACCT_WRITE : BLOCK_ACCT_FLUSH);
         request->aio_inflight++;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 384a5ee3f1c..d2605814795 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -338,7 +338,7 @@ static void virtio_blk_handle_flush(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 {
     VirtIOBlock *s = req->dev;
 
-    block_acct_start(blk_get_stats(s->blk), &req->acct, 0,
+    block_acct_start(blk_get_stats(s->blk), &req->acct, -1, 0,
                      BLOCK_ACCT_FLUSH);
 
     /*
@@ -421,8 +421,8 @@ static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
             blk_aio_flags |= BDRV_REQ_MAY_UNMAP;
         }
 
-        block_acct_start(blk_get_stats(s->blk), &req->acct, bytes,
-                         BLOCK_ACCT_WRITE);
+        block_acct_start(blk_get_stats(s->blk), &req->acct,
+                         sector << BDRV_SECTOR_BITS, bytes, BLOCK_ACCT_WRITE);
 
         blk_aio_pwrite_zeroes(s->blk, sector << BDRV_SECTOR_BITS,
                               bytes, blk_aio_flags,
@@ -437,8 +437,8 @@ static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *req,
             goto err;
         }
 
-        block_acct_start(blk_get_stats(s->blk), &req->acct, bytes,
-                         BLOCK_ACCT_UNMAP);
+        block_acct_start(blk_get_stats(s->blk), &req->acct,
+                         sector << BDRV_SECTOR_BITS, bytes, BLOCK_ACCT_UNMAP);
 
         blk_aio_pdiscard(s->blk, sector << BDRV_SECTOR_BITS, bytes,
                          virtio_blk_discard_write_zeroes_complete, req);
@@ -813,7 +813,7 @@ static int virtio_blk_handle_zone_append(VirtIOBlockReq *req,
     data->zone_append_data.offset = offset;
     qemu_iovec_init_external(&req->qiov, out_iov, out_num);
 
-    block_acct_start(blk_get_stats(s->blk), &req->acct, len,
+    block_acct_start(blk_get_stats(s->blk), &req->acct, offset, len,
                      BLOCK_ACCT_ZONE_APPEND);
 
     blk_aio_zone_append(s->blk, &data->zone_append_data.offset, &req->qiov, 0,
@@ -893,7 +893,8 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
             return 0;
         }
 
-        block_acct_start(blk_get_stats(s->blk), &req->acct, req->qiov.size,
+        block_acct_start(blk_get_stats(s->blk), &req->acct,
+                         req->sector_num * BDRV_SECTOR_SIZE, req->qiov.size,
                          is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
 
         /* merge would exceed maximum number of requests or IO direction
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 6b04762c4ad..cf63c87a013 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1092,7 +1092,8 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
         trace_execute_ncq_command_read(ad->hba, port, ncq_tfs->tag,
                                        ncq_tfs->sector_count, ncq_tfs->lba);
         dma_acct_start(ide_state->blk, &ncq_tfs->acct,
-                       &ncq_tfs->sglist, BLOCK_ACCT_READ);
+                       &ncq_tfs->sglist, ncq_tfs->lba << BDRV_SECTOR_BITS,
+                       BLOCK_ACCT_READ);
         ncq_tfs->aiocb = dma_blk_read(ide_state->blk, &ncq_tfs->sglist,
                                       ncq_tfs->lba << BDRV_SECTOR_BITS,
                                       BDRV_SECTOR_SIZE,
@@ -1102,7 +1103,8 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
         trace_execute_ncq_command_write(ad->hba, port, ncq_tfs->tag,
                                         ncq_tfs->sector_count, ncq_tfs->lba);
         dma_acct_start(ide_state->blk, &ncq_tfs->acct,
-                       &ncq_tfs->sglist, BLOCK_ACCT_WRITE);
+                       &ncq_tfs->sglist, ncq_tfs->lba << BDRV_SECTOR_BITS,
+                       BLOCK_ACCT_WRITE);
         ncq_tfs->aiocb = dma_blk_write(ide_state->blk, &ncq_tfs->sglist,
                                        ncq_tfs->lba << BDRV_SECTOR_BITS,
                                        BDRV_SECTOR_SIZE,
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 0ea149ad8c6..6f1187bce12 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -163,6 +163,7 @@ static int cd_read_sector(IDEState *s)
     trace_cd_read_sector(s->lba);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
+                     (int64_t)s->lba << ATAPI_SECTOR_BITS,
                      nsec * ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
 
     ide_buffered_readv(s, (int64_t)s->lba << 2, &s->qiov, nsec * 4,
@@ -297,7 +298,8 @@ static void ide_atapi_cmd_reply(IDEState *s, int size, int max_size)
     s->elementary_transfer_size = 0;
 
     if (s->atapi_dma) {
-        block_acct_start(blk_get_stats(s->blk), &s->acct, size,
+        /* No offset available for these commands */
+        block_acct_start(blk_get_stats(s->blk), &s->acct, -1, size,
                          BLOCK_ACCT_READ);
         s->status = READY_STAT | SEEK_STAT | DRQ_STAT;
         ide_start_dma(s, ide_atapi_cmd_read_dma_cb);
@@ -419,8 +421,9 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
     s->io_buffer_size = 0;
     s->cd_sector_size = sector_size;
 
-    block_acct_start(blk_get_stats(s->blk), &s->acct, s->packet_transfer_size,
-                     BLOCK_ACCT_READ);
+    block_acct_start(blk_get_stats(s->blk), &s->acct,
+                     (int64_t)lba << ATAPI_SECTOR_BITS,
+                     s->packet_transfer_size, BLOCK_ACCT_READ);
 
     /* XXX: check if BUSY_STAT should be set */
     s->status = READY_STAT | SEEK_STAT | DRQ_STAT | BUSY_STAT;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 06e6bb6067d..4b559cf68d0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -491,6 +491,7 @@ static void coroutine_fn ide_trim_co_entry(void *opaque)
             }
 
             block_acct_start(blk_get_stats(s->blk), &s->acct,
+                             sector << BDRV_SECTOR_BITS,
                              count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
 
             /* Got an entry! Submit and exit.  */
@@ -833,6 +834,7 @@ static void ide_sector_read(IDEState *s)
     qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
+                     sector_num << BDRV_SECTOR_BITS,
                      n * BDRV_SECTOR_SIZE, BLOCK_ACCT_READ);
     s->pio_aiocb = ide_buffered_readv(s, sector_num, &s->qiov, n,
                                       ide_sector_read_cb, s);
@@ -1009,10 +1011,12 @@ static void ide_sector_start_dma(IDEState *s, enum ide_dma_cmd dma_cmd)
     switch (dma_cmd) {
     case IDE_DMA_READ:
         block_acct_start(blk_get_stats(s->blk), &s->acct,
+                         ide_get_sector(s) << BDRV_SECTOR_BITS,
                          s->nsector * BDRV_SECTOR_SIZE, BLOCK_ACCT_READ);
         break;
     case IDE_DMA_WRITE:
         block_acct_start(blk_get_stats(s->blk), &s->acct,
+                         ide_get_sector(s) << BDRV_SECTOR_BITS,
                          s->nsector * BDRV_SECTOR_SIZE, BLOCK_ACCT_WRITE);
         break;
     default:
@@ -1112,7 +1116,8 @@ static void ide_sector_write(IDEState *s)
     qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
-                     n * BDRV_SECTOR_SIZE, BLOCK_ACCT_WRITE);
+                     sector_num << BDRV_SECTOR_BITS, n * BDRV_SECTOR_SIZE,
+                     BLOCK_ACCT_WRITE);
     s->pio_aiocb = blk_aio_pwritev(s->blk, sector_num << BDRV_SECTOR_BITS,
                                    &s->qiov, 0, ide_sector_write_cb, s);
 }
@@ -1147,7 +1152,7 @@ static void ide_flush_cache(IDEState *s)
 
     s->status |= BUSY_STAT;
     ide_set_retry(s);
-    block_acct_start(blk_get_stats(s->blk), &s->acct, 0, BLOCK_ACCT_FLUSH);
+    block_acct_start(blk_get_stats(s->blk), &s->acct, -1, 0, BLOCK_ACCT_FLUSH);
     s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
 }
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 40fb4f3b4f3..99d079be916 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -218,7 +218,14 @@ static void pmac_ide_transfer(DBDMA_io *io)
     MACIO_DPRINTF("\n");
 
     if (s->drive_kind == IDE_CD) {
-        block_acct_start(blk_get_stats(s->blk), &s->acct, io->len,
+        int64_t offset = -1;
+
+        if (s->lba >= 0) {
+            /* Same hardcoded 11 as in pmac_ide_atapi_transfer_cb() */
+            offset = ((int64_t)s->lba << 11) + s->io_buffer_index;
+        }
+
+        block_acct_start(blk_get_stats(s->blk), &s->acct, offset, io->len,
                          BLOCK_ACCT_READ);
 
         pmac_ide_atapi_transfer_cb(io, 0);
@@ -227,11 +234,13 @@ static void pmac_ide_transfer(DBDMA_io *io)
 
     switch (s->dma_cmd) {
     case IDE_DMA_READ:
-        block_acct_start(blk_get_stats(s->blk), &s->acct, io->len,
+        block_acct_start(blk_get_stats(s->blk), &s->acct,
+                         ide_get_sector(s) << BDRV_SECTOR_BITS, io->len,
                          BLOCK_ACCT_READ);
         break;
     case IDE_DMA_WRITE:
-        block_acct_start(blk_get_stats(s->blk), &s->acct, io->len,
+        block_acct_start(blk_get_stats(s->blk), &s->acct,
+                         ide_get_sector(s) << BDRV_SECTOR_BITS, io->len,
                          BLOCK_ACCT_WRITE);
         break;
     default:
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5168551e115..980816a2145 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2754,7 +2754,7 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     qemu_iovec_init(&ctx->data.iov, 1);
     qemu_iovec_add(&ctx->data.iov, ctx->data.bounce, len);
 
-    block_acct_start(blk_get_stats(blk), &req->acct, ctx->data.iov.size,
+    block_acct_start(blk_get_stats(blk), &req->acct, offset, ctx->data.iov.size,
                      BLOCK_ACCT_READ);
 
     req->aiocb = blk_aio_preadv(ns->blkconf.blk, offset, &ctx->data.iov, 0,
@@ -2983,6 +2983,7 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     uint32_t nlb;
     size_t mlen;
     uint8_t *mbounce;
+    int64_t offset;
 
     if (ret < 0 || iocb->ret < 0) {
         block_acct_failed(stats, &iocb->acct.write);
@@ -3003,10 +3004,10 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
-    block_acct_start(stats, &iocb->acct.write, mlen, BLOCK_ACCT_WRITE);
-    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
-                                  &iocb->iov, 0, nvme_copy_out_completed_cb,
-                                  iocb);
+    offset = nvme_moff(dns, iocb->slba);
+    block_acct_start(stats, &iocb->acct.write, offset, mlen, BLOCK_ACCT_WRITE);
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, offset, &iocb->iov, 0,
+                                  nvme_copy_out_completed_cb, iocb);
 
     return;
 
@@ -3029,6 +3030,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     uint64_t reftag;
     size_t len, mlen;
     uint16_t status;
+    int64_t offset;
 
     if (ret < 0) {
         iocb->ret = ret;
@@ -3113,10 +3115,11 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, len,
-                     BLOCK_ACCT_WRITE);
+    offset = nvme_l2b(dns, iocb->slba);
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write,
+                     offset, len, BLOCK_ACCT_WRITE);
 
-    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, offset,
                                   &iocb->iov, 0, nvme_copy_out_cb, iocb);
 
     return;
@@ -3136,6 +3139,7 @@ static void nvme_copy_in_cb(void *opaque, int ret)
     uint64_t slba;
     uint32_t nlb;
     size_t mlen;
+    int64_t offset;
 
     if (ret < 0 || iocb->ret < 0) {
         block_acct_failed(stats, &iocb->acct.read);
@@ -3154,10 +3158,11 @@ static void nvme_copy_in_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb), mlen);
 
-    block_acct_start(stats, &iocb->acct.read, mlen, BLOCK_ACCT_READ);
-    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba),
-                                 &iocb->iov, 0, nvme_copy_in_completed_cb,
-                                 iocb);
+    offset = nvme_moff(sns, slba);
+    block_acct_start(stats, &iocb->acct.read, offset, mlen,
+                     BLOCK_ACCT_READ);
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, offset, &iocb->iov, 0,
+                                 nvme_copy_in_completed_cb, iocb);
     return;
 
 out:
@@ -3236,6 +3241,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     uint16_t status;
     uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
     uint32_t snsid = dnsid;
+    int64_t offset;
 
     if (iocb->ret < 0) {
         goto done;
@@ -3362,10 +3368,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, len,
-                     BLOCK_ACCT_READ);
+    offset = nvme_l2b(sns, slba);
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read,
+                     offset, len, BLOCK_ACCT_READ);
 
-    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, offset,
                                  &iocb->iov, 0, nvme_copy_in_cb, iocb);
     return;
 
@@ -3524,7 +3531,7 @@ static uint16_t nvme_compare(NvmeCtrl *n, NvmeRequest *req)
     qemu_iovec_init(&ctx->data.iov, 1);
     qemu_iovec_add(&ctx->data.iov, ctx->data.bounce, data_len);
 
-    block_acct_start(blk_get_stats(blk), &req->acct, data_len,
+    block_acct_start(blk_get_stats(blk), &req->acct, offset, data_len,
                      BLOCK_ACCT_READ);
     req->aiocb = blk_aio_preadv(blk, offset, &ctx->data.iov, 0,
                                 nvme_compare_data_cb, req);
@@ -3722,7 +3729,7 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
 
     data_offset = nvme_l2b(ns, slba);
 
-    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+    block_acct_start(blk_get_stats(blk), &req->acct, data_offset, data_size,
                      BLOCK_ACCT_READ);
     nvme_blk_read(blk, data_offset, BDRV_SECTOR_SIZE, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
@@ -3892,7 +3899,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             goto invalid;
         }
 
-        block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+        block_acct_start(blk_get_stats(blk), &req->acct, data_offset, data_size,
                          BLOCK_ACCT_WRITE);
         nvme_blk_write(blk, data_offset, BDRV_SECTOR_SIZE, nvme_rw_cb, req);
     } else {
diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 4e7874f3223..fbd4d8eb816 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -644,8 +644,8 @@ uint16_t nvme_dif_rw(NvmeCtrl *n, NvmeRequest *req)
     qemu_iovec_add(&ctx->data.iov, ctx->data.bounce, len);
 
     if (req->cmd.opcode == NVME_CMD_READ) {
-        block_acct_start(blk_get_stats(blk), &req->acct, ctx->data.iov.size,
-                         BLOCK_ACCT_READ);
+        block_acct_start(blk_get_stats(blk), &req->acct, offset,
+                         ctx->data.iov.size, BLOCK_ACCT_READ);
 
         req->aiocb = blk_aio_preadv(ns->blkconf.blk, offset, &ctx->data.iov, 0,
                                     nvme_dif_rw_mdata_in_cb, ctx);
@@ -690,8 +690,8 @@ uint16_t nvme_dif_rw(NvmeCtrl *n, NvmeRequest *req)
         }
     }
 
-    block_acct_start(blk_get_stats(blk), &req->acct, ctx->data.iov.size,
-                     BLOCK_ACCT_WRITE);
+    block_acct_start(blk_get_stats(blk), &req->acct, offset,
+                     ctx->data.iov.size, BLOCK_ACCT_WRITE);
 
     req->aiocb = blk_aio_pwritev(ns->blkconf.blk, offset, &ctx->data.iov, 0,
                                  nvme_dif_rw_mdata_out_cb, ctx);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 24bd1a78b6e..5b40e404e13 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -484,7 +484,8 @@ static void scsi_do_read(SCSIDiskReq *r, int ret)
     scsi_req_ref(&r->req);
 
     if (r->req.sg) {
-        dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACCT_READ);
+        dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg,
+                       r->sector << BDRV_SECTOR_BITS, BLOCK_ACCT_READ);
         r->req.residual -= r->req.sg->size;
         r->req.aiocb = dma_blk_io(r->req.sg, r->sector << BDRV_SECTOR_BITS,
                                   BDRV_SECTOR_SIZE,
@@ -493,7 +494,8 @@ static void scsi_do_read(SCSIDiskReq *r, int ret)
     } else {
         scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                         r->qiov.size, BLOCK_ACCT_READ);
+                         r->sector << BDRV_SECTOR_BITS, r->qiov.size,
+                         BLOCK_ACCT_READ);
         r->req.aiocb = sdc->dma_readv(r->sector << BDRV_SECTOR_BITS, &r->qiov,
                                       scsi_read_complete, r, r);
     }
@@ -551,7 +553,7 @@ static void scsi_read_data(SCSIRequest *req)
     first = !r->started;
     r->started = true;
     if (first && r->need_fua) {
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, -1, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_do_read_cb, r);
     } else {
@@ -634,7 +636,7 @@ static void scsi_write_data(SCSIRequest *req)
 
     if (r->req.cmd.buf[0] == VERIFY_10 || r->req.cmd.buf[0] == VERIFY_12 ||
         r->req.cmd.buf[0] == VERIFY_16) {
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, -1, 0,
                          BLOCK_ACCT_FLUSH);
         cb = r->req.sg ? scsi_dma_complete : scsi_write_complete;
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, cb, r);
@@ -642,7 +644,8 @@ static void scsi_write_data(SCSIRequest *req)
     }
 
     if (r->req.sg) {
-        dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACCT_WRITE);
+        dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg,
+                       r->sector << BDRV_SECTOR_BITS, BLOCK_ACCT_WRITE);
         r->req.residual -= r->req.sg->size;
         r->req.aiocb = dma_blk_io(r->req.sg, r->sector << BDRV_SECTOR_BITS,
                                   BDRV_SECTOR_SIZE,
@@ -650,7 +653,8 @@ static void scsi_write_data(SCSIRequest *req)
                                   DMA_DIRECTION_TO_DEVICE);
     } else {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                         r->qiov.size, BLOCK_ACCT_WRITE);
+                         r->sector << BDRV_SECTOR_BITS, r->qiov.size,
+                         BLOCK_ACCT_WRITE);
         r->req.aiocb = sdc->dma_writev(r->sector << BDRV_SECTOR_BITS, &r->qiov,
                                        scsi_write_complete, r, r);
     }
@@ -1710,7 +1714,7 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
     if (!blk_enable_write_cache(s->qdev.conf.blk)) {
         /* The request is used as the AIO opaque value, so add a ref.  */
         scsi_req_ref(&r->req);
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, -1, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r);
         return;
@@ -1777,6 +1781,7 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
         }
 
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->sector * BDRV_SECTOR_SIZE,
                          r->sector_count * BDRV_SECTOR_SIZE,
                          BLOCK_ACCT_UNMAP);
 
@@ -1894,7 +1899,8 @@ static void scsi_write_same_complete(void *opaque, int ret)
                             data->iov.iov_len);
     if (data->iov.iov_len) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                         data->iov.iov_len, BLOCK_ACCT_WRITE);
+                         data->sector << BDRV_SECTOR_BITS, data->iov.iov_len,
+                         BLOCK_ACCT_WRITE);
         /* Reinitialize qiov, to handle unaligned WRITE SAME request
          * where final qiov may need smaller size */
         qemu_iovec_init_external(&data->qiov, &data->iov, 1);
@@ -1943,6 +1949,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
         /* The request is used as the AIO opaque value, so add a ref.  */
         scsi_req_ref(&r->req);
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->req.cmd.lba * s->qdev.blocksize,
                          nb_sectors * s->qdev.blocksize,
                         BLOCK_ACCT_WRITE);
         r->req.aiocb = blk_aio_pwrite_zeroes(s->qdev.conf.blk,
@@ -1969,7 +1976,8 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
 
     scsi_req_ref(&r->req);
     block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
-                     data->iov.iov_len, BLOCK_ACCT_WRITE);
+                     data->sector << BDRV_SECTOR_BITS, data->iov.iov_len,
+                     BLOCK_ACCT_WRITE);
     r->req.aiocb = blk_aio_pwritev(s->qdev.conf.blk,
                                    data->sector << BDRV_SECTOR_BITS,
                                    &data->qiov, 0,
@@ -2237,7 +2245,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     case SYNCHRONIZE_CACHE:
         /* The request is used as the AIO opaque value, so add a ref.  */
         scsi_req_ref(&r->req);
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, -1, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r);
         return 0;
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index de4c1966fea..655dfae9057 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1538,8 +1538,8 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
     }
 
     clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
-    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
-                     BLOCK_ACCT_READ);
+    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->offset,
+                     ctx->qiov.size, BLOCK_ACCT_READ);
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, ctx->flags, aio_read_done,
                    ctx);
     return 0;
@@ -1693,8 +1693,8 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
         }
 
         clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
-        block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
-                         BLOCK_ACCT_WRITE);
+        block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->offset,
+                         ctx->qiov.size, BLOCK_ACCT_WRITE);
 
         blk_aio_pwritev(blk, ctx->offset, &ctx->qiov, ctx->flags,
                         aio_write_done, ctx);
@@ -1706,7 +1706,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
 static int aio_flush_f(BlockBackend *blk, int argc, char **argv)
 {
     BlockAcctCookie cookie;
-    block_acct_start(blk_get_stats(blk), &cookie, 0, BLOCK_ACCT_FLUSH);
+    block_acct_start(blk_get_stats(blk), &cookie, -1, 0, BLOCK_ACCT_FLUSH);
     blk_drain_all();
     block_acct_done(blk_get_stats(blk), &cookie);
     return 0;
@@ -2325,8 +2325,8 @@ static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
 
     clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
     ctx->qiov.size = count;
-    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
-                     BLOCK_ACCT_UNMAP);
+    block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->offset,
+                     ctx->qiov.size, BLOCK_ACCT_UNMAP);
     blk_aio_pdiscard(blk, ctx->offset, count, aio_discard_done, ctx);
 
     return 0;
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 0d592f64680..7bf41119ebc 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -315,9 +315,9 @@ MemTxResult dma_buf_write(void *ptr, dma_addr_t len, dma_addr_t *residual,
 }
 
 void dma_acct_start(BlockBackend *blk, BlockAcctCookie *cookie,
-                    QEMUSGList *sg, enum BlockAcctType type)
+                    QEMUSGList *sg, int64_t offset, enum BlockAcctType type)
 {
-    block_acct_start(blk_get_stats(blk), cookie, sg->size, type);
+    block_acct_start(blk_get_stats(blk), cookie, offset, sg->size, type);
 }
 
 uint64_t dma_aligned_pow2_mask(uint64_t start, uint64_t end, int max_addr_bits)
diff --git a/tests/unit/test-block-accounting.c b/tests/unit/test-block-accounting.c
index 7aae491cfc2..0081502891c 100644
--- a/tests/unit/test-block-accounting.c
+++ b/tests/unit/test-block-accounting.c
@@ -63,7 +63,7 @@ static void *reader_thread(void *opaque)
     while (!qatomic_read(&stop_workers)) {
         BlockAcctCookie cookie;
 
-        block_acct_start(stats, &cookie, 4096, BLOCK_ACCT_READ);
+        block_acct_start(stats, &cookie, -1, 4096, BLOCK_ACCT_READ);
         block_acct_done(stats, &cookie);
     }
 
-- 
2.55.0


