Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9969ECA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcz-0005hB-Ag; Wed, 07 Oct 2026 12:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbT-000302-RY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbN-0006N5-T2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDfVsXARpho14i319kfTJ92XYV/xuCkUvg1QwR3qkoY=;
 b=DWxUVAM4obX8oKgS1uF3CiZIqBh/bkey/B3KP/nUrjzHqFByllpmSKhZuflf/RlIHhMN/6
 UNEFOJZwrb2Hup3z0gfQHCOsOgDG3LuBY9DbeJ1aBj5etRxEq0YvDGiaMgrJP2UcVetjEW
 J/KBEAq+DH2UWLLSikRerGiZkqk8UVk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-GbCYvwAbOp23BZ1f2T62xg-1; Wed,
 07 Oct 2026 12:34:41 -0400
X-MC-Unique: GbCYvwAbOp23BZ1f2T62xg-1
X-Mimecast-MFC-AGG-ID: GbCYvwAbOp23BZ1f2T62xg_1791390880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892BF1955BCB; Wed,  7 Oct 2026 16:34:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37EEB1956052; Wed,  7 Oct 2026 16:34:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/21] hw/block/fdc: account for read and write requests
Date: Wed,  7 Oct 2026 18:32:56 +0200
Message-ID: <20261007163302.332250-16-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

From: Christian Quante <christian@quante.one>

hw/block/fdc.c never calls block_acct_*, so a floppy drive stays at
zero in query-blockstats and "info blockstats" while IDE, ATAPI, SCSI,
virtio-blk, NVMe and xen-block all report their traffic. That is the
only interface through which QEMU reports drive activity, so a
front-end that shows per-drive activity LEDs -- the way 86Box does --
can light up every bus except the floppy.

The accounting is already set up for the drive: floppy_drive_realize()
reaches block_acct_setup() through blkconf_apply_backend_options(), and
-device floppy carries account-invalid, account-failed and
stats-intervals through DEFINE_BLOCK_PROPERTIES. The properties can be
set today, they just have nothing to act on.

Wrap the five blk_pread()/blk_pwrite() calls in two helpers that
account for the transfer. The cookie lives on the stack: floppy I/O is
synchronous throughout, so it never outlives the call and there is no
device state to migrate, unlike IDE where the cookie sits in the device
because the transfer is asynchronous -- scsi-disk, nvme, ahci and
xen-block all keep it in their request state for the same reason.

Measured with a boot sector that reads 18 sectors from A: and 16 from
C: and writes two back to each. The disk backend reports rd_ops=16
rd_bytes=8192 wr_ops=2 wr_bytes=1024 either way, so the guest did the
same work in both runs; the floppy went from rd_ops=0 wr_ops=0 to
rd_ops=19 rd_bytes=9728 wr_ops=2 wr_bytes=1024 -- 19 reads being the
boot sector the BIOS pulls in plus the 18 the guest asks for.

Signed-off-by: Christian Quante <christian@quante.one>
Message-ID: <20260824114216.231916-1-christian@quante.one>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/fdc.c | 52 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 1178b959a64..41776af6a0e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -222,6 +222,42 @@ static int fd_offset(FDrive *drv)
     return fd_sector(drv) << BDRV_SECTOR_BITS;
 }
 
+/* Reads the sector at the current position and accounts for the request */
+static int fd_read_sector(FDrive *drv, uint8_t *buf)
+{
+    BlockAcctStats *stats = blk_get_stats(drv->blk);
+    BlockAcctCookie acct;
+    int ret;
+
+    block_acct_start(stats, &acct, BDRV_SECTOR_SIZE, BLOCK_ACCT_READ);
+    ret = blk_pread(drv->blk, fd_offset(drv), BDRV_SECTOR_SIZE, buf, 0);
+    if (ret < 0) {
+        block_acct_failed(stats, &acct);
+    } else {
+        block_acct_done(stats, &acct);
+    }
+
+    return ret;
+}
+
+/* Writes the sector at the current position and accounts for the request */
+static int fd_write_sector(FDrive *drv, const uint8_t *buf)
+{
+    BlockAcctStats *stats = blk_get_stats(drv->blk);
+    BlockAcctCookie acct;
+    int ret;
+
+    block_acct_start(stats, &acct, BDRV_SECTOR_SIZE, BLOCK_ACCT_WRITE);
+    ret = blk_pwrite(drv->blk, fd_offset(drv), BDRV_SECTOR_SIZE, buf, 0);
+    if (ret < 0) {
+        block_acct_failed(stats, &acct);
+    } else {
+        block_acct_done(stats, &acct);
+    }
+
+    return ret;
+}
+
 /* Seek to a new position:
  * returns 0 if already on right track
  * returns 1 if track changed
@@ -1644,8 +1680,7 @@ int fdctrl_transfer_handler(void *opaque, int nchan, int dma_pos, int dma_len)
         if (fdctrl->data_dir != FD_DIR_WRITE ||
             len < FD_SECTOR_LEN || rel_pos != 0) {
             /* READ & SCAN commands and realign to a sector for WRITE */
-            if (blk_pread(cur_drv->blk, fd_offset(cur_drv), BDRV_SECTOR_SIZE,
-                          fdctrl->fifo, 0) < 0) {
+            if (fd_read_sector(cur_drv, fdctrl->fifo) < 0) {
                 FLOPPY_DPRINTF("Floppy: error getting sector %d\n",
                                fd_sector(cur_drv));
                 /* Sure, image size is too small... */
@@ -1672,8 +1707,7 @@ int fdctrl_transfer_handler(void *opaque, int nchan, int dma_pos, int dma_len)
 
             k->read_memory(fdctrl->dma, nchan, fdctrl->fifo + rel_pos,
                            fdctrl->data_pos, len);
-            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), BDRV_SECTOR_SIZE,
-                           fdctrl->fifo, 0) < 0) {
+            if (fd_write_sector(cur_drv, fdctrl->fifo) < 0) {
                 FLOPPY_DPRINTF("error writing sector %d\n",
                                fd_sector(cur_drv));
                 fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM | FD_SR0_SEEK, 0x00, 0x00);
@@ -1756,9 +1790,7 @@ static uint32_t fdctrl_read_data(FDCtrl *fdctrl)
                                    fd_sector(cur_drv));
                     return 0;
                 }
-            if (blk_pread(cur_drv->blk, fd_offset(cur_drv), BDRV_SECTOR_SIZE,
-                          fdctrl->fifo, 0)
-                < 0) {
+            if (fd_read_sector(cur_drv, fdctrl->fifo) < 0) {
                 FLOPPY_DPRINTF("error getting sector %d\n",
                                fd_sector(cur_drv));
                 /* Sure, image size is too small... */
@@ -1843,8 +1875,7 @@ static void fdctrl_format_sector(FDCtrl *fdctrl)
     }
     memset(fdctrl->fifo, 0, FD_SECTOR_LEN);
     if (cur_drv->blk == NULL ||
-        blk_pwrite(cur_drv->blk, fd_offset(cur_drv), BDRV_SECTOR_SIZE,
-                   fdctrl->fifo, 0) < 0) {
+        fd_write_sector(cur_drv, fdctrl->fifo) < 0) {
         FLOPPY_DPRINTF("error formatting sector %d\n", fd_sector(cur_drv));
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM | FD_SR0_SEEK, 0x00, 0x00);
     } else {
@@ -2270,8 +2301,7 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint32_t value)
         if (pos == FD_SECTOR_LEN - 1 ||
             fdctrl->data_pos == fdctrl->data_len) {
             cur_drv = get_cur_drv(fdctrl);
-            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), BDRV_SECTOR_SIZE,
-                           fdctrl->fifo, 0) < 0) {
+            if (fd_write_sector(cur_drv, fdctrl->fifo) < 0) {
                 FLOPPY_DPRINTF("error writing sector %d\n",
                                fd_sector(cur_drv));
                 break;
-- 
2.56.0


