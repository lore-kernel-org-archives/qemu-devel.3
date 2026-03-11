Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D1112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PPM-0002MI-0a; Wed, 11 Mar 2026 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPK-0002I4-CV; Wed, 11 Mar 2026 15:39:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPI-0000sl-Fl; Wed, 11 Mar 2026 15:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257670; bh=UhDEF+0FkvE8wwY7FcHd1IRaCkhOlhAOXEZlZtt+UPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cP4z15DzZeFEbBZf+CClv0CjrLodn5P7tk0MNos3u8ey1rjwicfOJw6eRmUC5qf8F
 C1cdLNmTprDZMJdPEogEOptIU60W2ZDXKfU8NsjH07FkN/nmpz/n4v3s52RdINIxFD
 anRyhpRyhT0qJhpq3Ax1MezhrAB2j5dCodRHGhcfyLsx3DMv+wDekH6HBv2N+mLx3R
 Q9DjGmYQvRgQDVqAHEJNqN5vj2livOnNjNrdfVLfqT6AdfBHgPybGG4LudLuYB4g1t
 3kTBME2bqW35GfbTmY8RdYXVzTzvidWNz693OYyFT+Z+BFEieugnY9GYI14gVG87kg
 YrhpojhA03V3A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A56C519211D;
 Wed, 11 Mar 2026 22:34:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E8CE637C482;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 53/53] fuse: Copy write buffer content before polling
Date: Wed, 11 Mar 2026 22:34:46 +0300
Message-ID: <20260311193449.1096110-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

aio_poll() in I/O functions can lead to nested read_from_fuse_export()
calls, overwriting the request buffer's content.  The only function
affected by this is fuse_write(), which therefore must use a bounce
buffer or corruption may occur.

Note that in addition we do not know whether libfuse-internal structures
can cope with this nesting, and even if we did, we probably cannot rely
on it in the future.  This is the main reason why we want to remove
libfuse from the I/O path.

I do not have a good reproducer for this other than:

$ dd if=/dev/urandom of=image bs=1M count=4096
$ dd if=/dev/zero of=copy bs=1M count=4096
$ touch fuse-export
$ qemu-storage-daemon \
    --blockdev file,node-name=file,filename=copy \
    --export \
    fuse,id=exp,node-name=file,mountpoint=fuse-export,writable=true \
    &

Other shell:
$ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
$ killall -SIGINT qemu-storage-daemon
$ qemu-img compare image copy
Content mismatch at offset 0!

(The -t none in qemu-img convert is important.)

I tried reproducing this with throttle and small aio_write requests from
another qemu-io instance, but for some reason all requests are perfectly
serialized then.

I think in theory we should get parallel writes only if we set
fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
if we do that, that throttle-based reproducer works (i.e. does get
parallel (nested) write requests).  I have no idea why we still get
parallel requests with qemu-img convert anyway.

Also, a later patch in this series will set fi->parallel_direct_writes
and note that it makes basically no difference when running fio on the
current libfuse-based version of our code.  It does make a difference
without libfuse.  So something quite fishy is going on.

I will try to investigate further what the root cause is, but I think
for now let's assume that calling blk_pwrite() can invalidate the buffer
contents through nested polling.

Cc: qemu-stable@nongnu.org
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-2-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a3fcbca0ef643a8aecf354bdeb08b1d81e5b33e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d..aec4d8736d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
         goto out;
     }
 
+    /*
+     * Note that aio_poll() in any request-processing function can lead to a
+     * nested read_from_fuse_export() call, which will overwrite the contents of
+     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
+     * content is copied before potentially polling via aio_poll().
+     */
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
@@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                        size_t size, off_t offset, struct fuse_file_info *fi)
 {
     FuseExport *exp = fuse_req_userdata(req);
+    QEMU_AUTO_VFREE void *copied = NULL;
     int64_t length;
     int ret;
 
@@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
         return;
     }
 
+    /*
+     * Heed the note on read_from_fuse_export(): If we call aio_poll() (which
+     * any blk_*() I/O function may do), read_from_fuse_export() may be nested,
+     * overwriting the request buffer content.  Therefore, we must copy it here.
+     */
+    copied = blk_blockalign(exp->common.blk, size);
+    memcpy(copied, buf, size);
+
     /**
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
@@ -660,7 +675,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
     if (ret >= 0) {
         fuse_reply_write(req, size);
     } else {
-- 
2.47.3


