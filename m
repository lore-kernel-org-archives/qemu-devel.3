Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB04C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcY-0001bk-NU; Wed, 16 Sep 2026 05:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcV-0001U6-EU; Wed, 16 Sep 2026 05:07:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcT-0007Mk-KM; Wed, 16 Sep 2026 05:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=vTNv0n7GHd9WF4rk69YqO7UkDWWJLEWO9Qji/0+capI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xEl0fmswPU7/rfmTqsh/WqP/yK50gQwztHAsqgQ8O8189GsCVkatTipvK0JWF02/B
 PWHmsblhBgozMbZMxRm66kBxOliql7fOB2bh7y7rDNzAURTtGZj/DoQUZYU6JusGRX
 g+QiiCsKlGKEM6ZrVYtgq7r8x9VCZr8Oz4SKCIfmlmdeTZN9mdTLJ7uFBvnOzUX9Kj
 rD9gbEJpDytJm/eVozEDGzpsRlgzr80igL34YxQYci89rJbqOm/ujJgIGHHfkUzH2b
 vf2KIVNlgGTSnJRewUV3FJgHYm3BSN5JW5+hEqMPDi96Cc4X6b8xAuzCeQVt8oPm2r
 G8/0xeszZOLhw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB5171D56C9;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 770A9429E14;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 431A25A783; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 21/57] scsi-disk: fix out-of-bound read in WRITE SAME
Date: Wed, 16 Sep 2026 12:03:45 +0300
Message-ID: <20260916090516.677749-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

A guest with an attached scsi-hd can force QEMU's SCSI disk emulation
to read roughly 60 KiB past the end of a heap buffer, copying that out
of bounds host memory into the guest's own disk image.

WRITE SAME computes the request transfer length at dev->blocksize
when the request is prepared and sets cmd->xfer from dev->blocksize.
scsi_disk_emulate_command() then uses cmd->xfer as the size of the
request buffer.

However, MODE SELECT can race with the WRITE SAME command and guest raise
the logical block size to any value whose low bits fit 0xfe00, up to 65024.
In the presence of this race, scsi_disk_emulate_write_same() will read
from memory as many bytes as indicated by the *new* dev->blocksize,
and write it to disk.

The read length in WRITE SAME must be bounded by the buffer that was
actually allocated, not by the mutable s->qdev.blocksize, so clamp the
length used against inbuf to r->buflen.  Re-validating req->cmd.xfer
against the current block size would not work because the race is
intrinsic in the SCSI protocol.

I am not sure if this is exploitable with virtio-scsi and other SG-capable
HBAs, because it should process the WRITE SAME input immediately,
without letting the MODE SELECT command race with it.

Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4365
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d30254aec93141d6b89262986a62764b2ae07177)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c5..5bb7a974d69 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1911,6 +1911,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIRequest *req = &r->req;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
     uint32_t nb_sectors = scsi_data_cdb_xfer(r->req.cmd.buf);
+    uint32_t buflen = MIN(s->qdev.blocksize, r->buflen);
     WriteSameCBData *data;
     uint8_t *buf;
     int i, l;
@@ -1930,7 +1931,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
-    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, s->qdev.blocksize)) {
+    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, buflen)) {
         int flags = (req->cmd.buf[1] & 0x8) ? BDRV_REQ_MAY_UNMAP : 0;
 
         /* The request is used as the AIO opaque value, so add a ref.  */
@@ -1956,7 +1957,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
     qemu_iovec_init_external(&data->qiov, &data->iov, 1);
 
     for (i = 0; i < data->iov.iov_len; i += l) {
-        l = MIN(s->qdev.blocksize, data->iov.iov_len - i);
+        l = MIN(buflen, data->iov.iov_len - i);
         memcpy(&buf[i], inbuf, l);
     }
 
-- 
2.47.3


