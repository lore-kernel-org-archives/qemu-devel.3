Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8736FC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyT4l-0001ew-Km; Mon, 24 Aug 2026 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wyT4j-0001ea-Uf; Mon, 24 Aug 2026 07:42:49 -0400
Received: from nx188.node01.secure-mailgate.com ([89.22.108.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wyT4h-00082E-KZ; Mon, 24 Aug 2026 07:42:49 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wyT4c-002jae-L7; Mon, 24 Aug 2026 13:42:43 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787571762;
 bh=b4eXQXNtUOY+c1r1uBYQyT6GFguFOidjzzsbSW01HKI=;
 h=From:To:Cc:Subject:Date:From;
 b=Sw0zN+oxr8H8jxE80n6DXwth80xQWhhSnkZiCjVqvXG5e5ZeZIDnxRVD1aECf5Ymq
 YguKKDebVqg2O+EECYR6oLSLdhYN3CXVh32TuD7j3nNgUl6Z7Na9TMeQAmycRaNB8h
 IeEghS8Xw4j59E/LXgN98ppHpI5pmrNQRK3lja0E=
Received: from Zeuss.fritz.box (p549f1b6c.dip0.t-ipconnect.de [84.159.27.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id AEB55280C4A;
 Mon, 24 Aug 2026 13:42:41 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/block/fdc: account for read and write requests
Date: Mon, 24 Aug 2026 13:41:50 +0200
Message-ID: <20260824114216.231916-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178757176222.4186173.10335620556201042371@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00290444316647)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXOPZNYmQB9qz85cm7H/8AE29nSP6L7h/rn
 f0iUZFJLFiu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4bMT5zeh0i09FUzsOwd7xvTS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS78HF9DWBc0WhbQl3RlROHMl5OjAPt7LlMbhgG9BOAmXwBM2j5REykHorDckk/GS
 XMyjmcTOVEFl0KPc6uJqilaCXufEjWR3z+AWvVFWQY81MMXgHqsZsdeRNOsJiUZKcasaKInSW7KX
 2AnOCtteaCsWYoesNJcqmEE+fwKo/lk5DedlPOKWD0S2eE7vgplPkeWBOXp8nHKe0R+FkIqN7hnE
 owzMXpUnBxhMOdnGdpbVECj18Ndet5rC5wJSqHnrPDijix7jwdgfBvQbrDY6GMxN8PpzGx0UoNdj
 kgBB8gz10F07v8zCSKG3aIolMAnTlhB8b6AQ3op/S4fepr1yX9+qSca1H9GjtnlugvPS0vcnp8wl
 1zNSBea0aUdNQBObVdGN0rcm1s5jhXm7hKo2tt3djUVYA77R3b1kItDSDDxTxkteeabgDmWf+475
 NoptWdwTbsdixLWEv2vv1rY1tjz1n8/f8aNnFmVULNDWJF08z6wf2qinlvjTqpxpoHPYDmreKSUb
 Fkw5HnzX+AWWNI8VxF6sNESrgqryuOEa4IEoSa58oc+gAHbR5wq+CwfeGTQmy/tvPgT7E9gJ2OcT
 tXs8CVsONrMJuGzuoGnKTKcyLG3k9CjEUe77QPIKKJMzjf5GNGrszVg5Rg3lpE4ppCkqdj+sC6eO
 d+/vCp0aBVA//tAYpPJnWlEYadG+MBZP1cVh3wqd91kuGA2+IpHA5YMowAOZKBM6e/bYB566DxuD
 EK0zMbaaLtnxQMLD/YWtJZ6MkyNr9MQThDzE406gJL3sNjMV9Ofg1ecGMS6f0O9nqL0TsSeRgb8R
 OVf8R/Vmmw==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.188; envelope-from=christian@quante.one;
 helo=nx188.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 hw/block/fdc.c | 52 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 1178b959a6..41776af6a0 100644
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
2.53.0


