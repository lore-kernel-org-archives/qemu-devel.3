Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A567CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVBL-0006AG-6T; Sat, 13 Jun 2026 16:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVB8-0005kh-KS; Sat, 13 Jun 2026 16:42:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVB3-0005RM-2V; Sat, 13 Jun 2026 16:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382966; bh=8HHM1w7x1VDQswcT8xzFVme9fABgIN0/85/hbVFQpwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n0ldSWnTxDB8csS5p2Rrjsgedb4UjlFJ5798D6FgN2I2wFFpQiQYhEdt584/c5f0j
 gcu95sIpKTugqenLDvImWG/Gqr1qLc5qlPQTkFUOSqrCB8d8aoGHYYhQ04xg+HA+jk
 S3icv6zyCPb4fyy+nyTluAccYCj2dt5+zaqGZwQjiKUY7OS790pwQMs419GSZDWPtk
 wOQ7+FzV3SrKBFonTLAoOwWahOjW6vxJP3vdD8IoEaeFsABujreWv1A1xcARdIbzcg
 T0YIbIzUL/uORuTPZjjQ+wejKMyF2tx0JL5JDZAAHkrmPJz5DSD67l7nwZOtW+ecFo
 U+VzJQ2dh7HFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 528501B6F1E;
 Sat, 13 Jun 2026 23:36:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B87103CE968;
 Sat, 13 Jun 2026 23:36:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 60/72] virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD
 size check (CVE-2026-48914)
Date: Sat, 13 Jun 2026 23:35:26 +0300
Message-ID: <20260613203542.1809153-60-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Check that the iovec containing struct virtio_scsi_inhdr is large enough
before storing an error value there.

Feifan Qian <bea1e@proton.me> pointed out that this can be used to
corrupt heap memory when the descriptor uses an MMIO address and a
length of 1, forcing QEMU to allocate a 1-byte heap bounce buffer.
virtio_stl_p() stores 4 bytes and therefore corrupts whatever is beyond
the bounce buffer.

Fixes: CVE-2026-48914
Fixes: f34e73cd69bd ("virtio-blk: report non-zero status when failing SG_IO requests")
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260526154957.1741622-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit aeea0c2804c42f24915467a1e4c70e649e39b8e0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..6b92066aff 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -199,10 +199,16 @@ static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
 
     /*
      * The scsi inhdr is placed in the second-to-last input segment, just
-     * before the regular inhdr.
+     * before the regular inhdr. VIRTIO implementations normally do not rely on
+     * the precise message framing, but legacy implementations did and so we do
+     * too for the legacy virtio-blk SCSI request type.
      *
      * Just put anything nonzero so that the ioctl fails in the guest.
      */
+    if (elem->in_sg[elem->in_num - 2].iov_len != sizeof(*scsi)) {
+        status = VIRTIO_BLK_S_IOERR;
+        goto fail;
+    }
     scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
     virtio_stl_p(vdev, &scsi->errors, 255);
     status = VIRTIO_BLK_S_UNSUPP;
-- 
2.47.3


