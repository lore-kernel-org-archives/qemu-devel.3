Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3097CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB4v-0004b4-9H; Sat, 17 Oct 2026 16:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3b-0003RV-FG; Sat, 17 Oct 2026 16:31:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3Z-0004Qs-JL; Sat, 17 Oct 2026 16:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268871; bh=PWtl38TnxT/y+FQhj3emjXxsiygqWkfHDoqX9IZ/2zU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fzt2SWjpE4SbWivT4xHPnTWXCc4qm266hIMWzRtY1Za4B5H8HU/g1YRmGdhjtJqG5
 jMvQC7K1YmNhxJAc4R2FHtIH4EEir4HeLvVuMEejJzH/t0l759L5HqIUuZPpgMImGn
 JLikItnnTdPEEwtgYaU3YjySJRuwv18iAdbno8zu5dn+/2GJwx+z2HKkSQiwcaKlla
 P+4zNEU5gu9Of9n/GqPMLgQhb+TgTUEYvGevvA0EY1RVwRJCIPtR8eCF2rZd0DWCsH
 SE1hEcv/7jgrWcOoFFd/Ch7HDIV21C9AYcum/vFE6t3nuljXPkz6qnc7FOrejjuHeS
 7voY2JR1nsVZw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 902231DE76A;
 Sat, 17 Oct 2026 23:27:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3D88944343E;
 Sat, 17 Oct 2026 23:27:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Biggers <ebiggers@google.com>, Ben Chaney <bchaney@akamai.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 44/73] file-posix: add statx(STATX_DIOALIGN) support
Date: Sat, 17 Oct 2026 23:26:02 +0300
Message-ID: <20261017202638.728621-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

Linux v6.1 commit 825cf206ed51 ("statx: add direct I/O alignment
information") added an interface to fetch O_DIRECT alignment values for
block devices and file systems.

Prefer STATX_DIOALIGN to older interfaces and probing, but keep them as
fallbacks in case STATX_DIOALIGN cannot provide the information.

STATX_DIOALIGN support as of Linux 6.1:
- btrfs: no
- ext4: yes
- XFS: yes
- block devices: yes
- dm-crypt: yes

This change fixes #1290 ("IO alignment probing delivers incorrect
results on Linux when used with e.g. dm-crypt") on Linux host kernel
version 6.1 or later by avoiding the problematic probing code in
raw_probe_alignment(). It would be nice to fix the probing code but I
have not been able to reproduce it. Stable/LTS distros ship Linux 6.1+,
so the number of users without STATX_DIOALIGN is becoming small.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1290
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260922154351.226540-1-stefanha@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 196a50b0902b0951ce331212f7bcf109de832b5f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f..90c086f1f8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -426,28 +426,48 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
 
     bs->bl.request_alignment = 0;
     s->buf_align = 0;
-    /* Let's try to use the logical blocksize for the alignment. */
-    if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
-        bs->bl.request_alignment = 0;
-    }
 
-#ifdef __linux__
+#if defined(__linux__) && defined(STATX_DIOALIGN)
+    struct statx stx;
+
     /*
-     * The XFS ioctl definitions are shipped in extra packages that might
-     * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
-     * here, we simply use our own definition instead:
+     * Linux 6.1 introduced an interface for both block devices and file
+     * systems. The system call returns with the STATX_DIOALIGN bit cleared
+     * when the information is unavailable.
      */
-    struct xfs_dioattr {
-        uint32_t d_mem;
-        uint32_t d_miniosz;
-        uint32_t d_maxiosz;
-    } da;
-    if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
-        bs->bl.request_alignment = da.d_miniosz;
-        /* The kernel returns wrong information for d_mem */
-        /* s->buf_align = da.d_mem; */
+    if (statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
+        (stx.stx_mask & STATX_DIOALIGN)) {
+        bs->bl.request_alignment = stx.stx_dio_offset_align;
+        s->buf_align = stx.stx_dio_mem_align;
+    }
+#endif /* defined(__linux__) && defined(STATX_DIOALIGN) */
+
+#ifdef __linux__
+    if (!bs->bl.request_alignment) {
+        /*
+         * The XFS ioctl definitions are shipped in extra packages that might
+         * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
+         * here, we simply use our own definition instead:
+         */
+        struct xfs_dioattr {
+            uint32_t d_mem;
+            uint32_t d_miniosz;
+            uint32_t d_maxiosz;
+        } da;
+        if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
+            bs->bl.request_alignment = da.d_miniosz;
+            /* The kernel returns wrong information for d_mem */
+            /* s->buf_align = da.d_mem; */
+        }
+    }
+#endif /* __linux__ */
+
+    /* Let's try to use the logical blocksize for the alignment. */
+    if (!bs->bl.request_alignment) {
+        if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
+            bs->bl.request_alignment = 0;
+        }
     }
-#endif
 
     /*
      * If we could not get the sizes so far, we can only guess them. First try
-- 
2.47.3


