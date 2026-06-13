Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D3CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUSN-0000xX-1f; Sat, 13 Jun 2026 15:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSI-0000RL-2o; Sat, 13 Jun 2026 15:55:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSF-0004jI-9j; Sat, 13 Jun 2026 15:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380261; bh=9UsS+6X8RHNSf6lJpyS8ito1RuJtNyGBg4nwcbWTApE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TQ4wnvebqty1iRYigf7Wp7OS5JwTEWjDdPomiZrEViNgxk0nbrbAWNYqZPhBVUaqk
 04QMw6W8p9aRfcBWCs9g+J6R5QZf5415RBwCKgmvpLD6QaTJBOp+HGY44Vn1Pdboo9
 NsRWUZZuERrLb7fhqIHRBsOCKrAXZntIXhgpNRt/Ju6V1vVDxYQl9Os77BTauLreC/
 1O+49K/uHdPQsYEMqxVihLstnVmi9qagBbLcLaoOZDve7opL5aaNrMB6FczT93IBxR
 Ld7YXyOSX/WzJnrhkOr5UdSVgNoU4R5ugQosUU+l6w4QRMqPLz8FH6+wvMg9D2ArZV
 o31q/W6K9peog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12B4D1B6E3D;
 Sat, 13 Jun 2026 22:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6BF343CE8B7;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 46/56] block/io: fallback to bounce buffer if
 BLKZEROOUT is not supported because of alignment
Date: Sat, 13 Jun 2026 22:51:00 +0300
Message-ID: <20260613195116.1807273-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
certain 'qemu-img convert' invocations, because of a pre-existing
issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
the request is shorter than the block size of the block device.
Fallback to the bounce buffer, similar to when the ioctl is not
supported at all, rather than treating such an error as fatal.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=7197
Cc: qemu-stable@nongnu.org
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260105143416.737482-1-f.ebner@proxmox.com>
[Added TODO comment describing a larger fix that could be implemented in
the future.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit b4e28c304bc58325f8f712cb25e5d700826caa25)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index 29d1e84ea7..1e7c8658da 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1920,7 +1920,18 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        /*
+         * TODO The ret == -EINVAL && num < alignment case is a workaround for
+         * when request_alignment is 1 on files with cache=writeback. The Linux
+         * ioctl(BLKZEROOUT) requires block alignment and will fail with
+         * EINVAL. The block layer should align the request to
+         * write_zeroes_alignment instead of trying the syscall, failing, and
+         * falling back to a bounce buffer. Doing that is not easy so for now
+         * we use a bounce buffer:
+         * https://lore.kernel.org/qemu-devel/20260109120837.2772961-1-f.ebner@proxmox.com/
+         */
+        if ((ret == -ENOTSUP || (ret == -EINVAL && num < alignment)) &&
+            !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
-- 
2.47.3


