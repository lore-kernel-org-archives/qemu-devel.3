Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADFECD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUfv-00020y-Hx; Sat, 13 Jun 2026 16:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfg-0001xB-Cl; Sat, 13 Jun 2026 16:09:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfb-0002kn-Os; Sat, 13 Jun 2026 16:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=2JSzfA8Q4mBWTQsJt3J+K9E/6xfb1l5lRRiTnsafi30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UvUwDdq/f8Kl6b0ohxknmMGf1gdIIB6Hh5ur3ZpAAmPEoycYBOu6mQpK7rsIIsFxb
 bMy6ikqJGxDKEWW0oPHofvHBW0tFCJ2UdYSLuS8bgCKGbfeCg3eW6JH+cbKHhFuD3r
 9FRjBEPoTHMg2rYtmpe5XZJd6370RM3URiXNXmDxAKhLAiFVme0M22kvX3FcdiBShb
 9mpq6hUd/DEHG3sv/bj2Qg7DYhkVTpY2PAcENmmm+PgcWURlAOzjuY5sBM5FFqWHqu
 EpSXgJz9FsNGq99/WGw1j01sPXJYvOYDHea+V8XWwfPJ4/3icTnMrJZWvkvyj3Ir9d
 9Sq2a4pXoqbwQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F88D1B6EA2;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C818E3CE8FD;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 51/61] block/io: fallback to bounce buffer if
 BLKZEROOUT is not supported because of alignment
Date: Sat, 13 Jun 2026 23:03:34 +0300
Message-ID: <20260613200411.1808021-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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
index c4a4301321..8f193c29e5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1917,7 +1917,18 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
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


