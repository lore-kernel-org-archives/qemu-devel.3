Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BB4C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7rV-0001fm-3k; Wed, 12 Aug 2026 08:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rS-0001Y1-8t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rO-00087d-IA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso8495035e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786536905; x=1787141705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVJtcEPdiwg9PXALv8+qKSFQ+Lu+9GTpys8gB3I2ODs=;
 b=bo/sCI8792A2TjX/HJ+/teVjvjG3rRB+mzjNNCwUx3BHTWNtWD3fZgiTmp9ZTepPYK
 tWmEoOcNGFTyvK7//OxNmOeBQjjQfNyug9LLv74QXDhOarfRK0ablf68bavleWhJSyov
 qJEXgUjPc7orSAgQUygAXyXNrV5Hz3RoThH+t2R3opuHmdbxJOh4pfbNnF1kLvqaT67d
 5x5CRGc7uzAXm9KIF1wgP4DymffC5fsre8e8gZUGjuC5To6lYlVouKhH87qzKCmYUCEt
 k9COs6lAo9/qtR3d3vQCLjmulsrhe+OkIZN5wShLiX3htg2SJqjydlsF9vf3WORVMmwZ
 7/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536905; x=1787141705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IVJtcEPdiwg9PXALv8+qKSFQ+Lu+9GTpys8gB3I2ODs=;
 b=BoVtp35f5mn46v9/Am+kKvpIFsWHhha5qj8sIoe5JbanOKTjWrcePLGV89+hHZ4iXw
 Jx4BSMdmifurcYCTFLes5qcR+dgQJ66labNmxbQ+iH/Ozx5yNaBf8Cp8d1DbMB7wqBKd
 viGTeuHzbzPvzvzOHeur+eGZ97Pqk41uyenQdT7OsJ+Nutlm3+JrOiGiUJdYxpxnPcsY
 Y/OT/EwcnBgg4g+6uJzu5N28l8n6ZnbI8utPDE1/ta0bELEIiQBnWZRzTYSU6AM/l3zC
 KRjrVmD25dfI2takv+hylP6abxYhuD+nm+bgvLCIeLsN9CM9WAP7pCFfRNW7cwgtMbve
 tqlQ==
X-Gm-Message-State: AOJu0Yw308Fr1hU+k06k4b14L2uH1fejqYe7ikOUP4GUNX/c/6/nGVea
 n8UYl5+jcarQpERP+RJBwLtAAUF8Jvj0pup1uXXF8goWWde5/uYXlNSpLkoU/PrRmzYKBrpiU1X
 UId7m
X-Gm-Gg: AR+sD13Q5P8hto6ijxtw9E6hdF7kMBFcEi8wBLBNFVZQjut/lbm20qtaCU7B1q06HCs
 weEQLWQK6bvEwXK3en8L3YvsXJgf0CVllpU4mq/C/QqSWfNhB64FQno+t8fVuxY/I99X5+BSXMb
 ShFyXJX9nKZwiVaFmAANonfY+JZy/tYhmxwGc1A0jX8FM3XYAU1QhTCzJ0L4hFDKL9AU//i5Exd
 3XkVakpkz1GmHKCKwy96E4ssLKQuodJYSGu19K0zGnv2LYEquzJ9C1/mONBqedUJGHyCae4qNHW
 snGIC+z5c4AIadNT/O54AMw1h2yN5duK4tPNlHPuT6iiPbxfPl9ezQ9Bm91wzYIcxUliUYyVQrb
 lQ0s6xXQy3u+rT3HH4ZWzLaFiUEfxtxW9g3MfBxBEjn0L/PbuL0lWqUS7IY9o8chqxQXVCDBrMN
 yZEfpf36DkK0vwSPOBGcl0F0zQzsnL/lA34yR2DecWv41I14g6SAdMEJXq5w==
X-Received: by 2002:a05:600c:a213:b0:499:737c:8a8b with SMTP id
 5b1f17b1804b1-4997c12c7e8mr40112965e9.12.1786536904846; 
 Wed, 12 Aug 2026 05:15:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad267c2sm49069945e9.0.2026.08.12.05.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:15:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
Date: Wed, 12 Aug 2026 14:14:57 +0200
Message-ID: <20260812121500.1034178-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
References: <20260812121500.1034178-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

bdrv_replace_child_bs() swaps the node a BdrvChild points to without
telling the parent anything about it, so a parent which tracks the size of
its child never learns that it changed. Every other way the size of a node
changes goes through bdrv_co_truncate(), which does notify.

The device models which care all register the same BlockDevOps hook:

  virtio-blk  resize_cb = virtio_blk_resize(), ending up in
              virtio_notify_config()
  ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
              and the IDENTIFY data
  scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
              CAPACITY DATA HAS CHANGED
  xen-block   resize_cb = xen_block_resize_cb()

Only scsi-disk is really hurt by the missing notification, because it is
the one which validates guest requests against a cached size.
virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
blk_get_geometry() for every request, so a missing notification leaves
those guests with a stale idea of the size but never refuses I/O which the
node underneath can serve. check_lba_range() compares against
SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
re-read the capacity every request past the end of the old node is refused
for the whole life of the device.

This is reachable with qom-set of the 'drive' property, which is allowed
on a realized device, and it is silent on the host: out-of-range requests
are answered by scsi_check_condition() and never reach
scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
RANGE, which Linux turns into EREMOTEIO for reads as well as writes.

Emit the notification from bdrv_replace_child_bs(), so that every device
model gets it through the path it already implements rather than any of
them being special cased. Send it only when the size really changed, which
keeps the callback out of the common case of a replacement by an equally
sized node.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block.c                      | 13 +++++++++++++
 include/block/block_int-io.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/block.c b/block.c
index f0a6042e61..1fe66caf8d 100644
--- a/block.c
+++ b/block.c
@@ -5524,9 +5524,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     Transaction *tran = tran_new();
     g_autoptr(GSList) refresh_list = NULL;
     BlockDriverState *old_bs = child->bs;
+    int64_t old_len;
 
     GLOBAL_STATE_CODE();
 
+    old_len = bdrv_getlength(old_bs);
+
     bdrv_ref(old_bs);
     bdrv_drained_begin(old_bs);
     bdrv_drained_begin(new_bs);
@@ -5542,6 +5545,16 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     tran_finalize(tran, ret);
 
     bdrv_graph_wrunlock();
+
+    /* A parent caching the child size has to learn that it changed */
+    if (ret == 0) {
+        int64_t new_len = bdrv_getlength(new_bs);
+
+        if (new_len >= 0 && new_len != old_len) {
+            bdrv_parent_cb_resize(new_bs);
+        }
+    }
+
     bdrv_drained_end(old_bs);
     bdrv_drained_end(new_bs);
     bdrv_unref(old_bs);
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index ed8b5657d6..95d0dd7a05 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -197,4 +197,7 @@ void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes);
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_parent_cb_resize(BlockDriverState *bs);
 
+void co_wrapper_bdrv_rdlock
+bdrv_parent_cb_resize(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_IO_H */
-- 
2.53.0


