Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D3C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 07:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0bhf-0004Tv-5z; Fri, 04 Apr 2025 03:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0bhT-0004Sl-Vu; Fri, 04 Apr 2025 03:42:52 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0bhR-0004WI-3g; Fri, 04 Apr 2025 03:42:50 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af519c159a8so1579842a12.3; 
 Fri, 04 Apr 2025 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743752566; x=1744357366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x5AUXD0puZRHXKy/UWT22Y1EUaKUmNZNPwPiNx0WQy0=;
 b=jhhoyouzgfwvUwWInR+1efvDXPYU8INxdpvC4LRKAD4T+ag5yDD6JN081zu1bjwkt1
 gGpfOaWLbtI9rGrIvNV2VULO7nkdd+hRw1zJ8Gqg//qT5uQgh9KGx9W1uVf/bd/Ns4G8
 omHnB09e+Us3M8JDTRfyzNAQIHKAFADE87OJt4TEwDhIMDJuGB0TIt8XW3R+u3XMeSbV
 LT67ZjLgHx8I2yI7n2KqUa8KCTEUMCNbNCZtx/DcwKKXHp4MoVrsbiyqv/YaQkwf+dwi
 Hhx85B7XkfXCR995iXjkHNmXSq0SvUJE/oztTDgx5/z8P8Pefu1fI1eHNmNznje4JRdy
 U7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743752566; x=1744357366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5AUXD0puZRHXKy/UWT22Y1EUaKUmNZNPwPiNx0WQy0=;
 b=FQhG5d3iQ2i+PcIluT9YFYuWdbrcGXWrI7DTfZjpMW/Qv9GEOYbK+IDQ6AcI8/0nwi
 UFOhEFZKNheiAVxADs4t+N7MM8UebeNvqlZoSmQUrjuudMVmkYCziYBb68+FpRNELwTu
 78Lny3TslkmJSXScTlnDpFvKlQHsoHm/NoV7VbIJAbwGMRfHgoJ8F4CAh1ZFxPTWb3Di
 jSj8iQLrVOgy8wAFBDFn0hMf6pJElAtEA8AVfwU+bmGfe2oRfMTlOG+kSmAsN4gNxftE
 WZPvEaCOoVnzdWyC9uN3wqShB7Kw8YOWPpfHQJ767SJ/8LXmfbKNrhjiBPlZjSFcAH8b
 uh8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx7tL9KGk8cKGIUN4MBvRdVLkr5+L7LIV3tUvdG4WPPJWVIY+saV1Em8gwd363EW8dqhRZnxpgYk0n@nongnu.org
X-Gm-Message-State: AOJu0YwA+CZhZ/4bNMhhsnoA5MmhWt/BZaIHuNhl6qfPBLDhov5Wf175
 f+yD/ijUiWeaZ8gjMPTmXtz9DTCQTgSpu13W8Q0I2ednzH1p2BNs
X-Gm-Gg: ASbGncsCD7fgIl/Xq2CwABqWx+/u2eWuZx8wkpVvBzanNaL4XpwBX3tyKN6cMMZWDpu
 y+gn4rwKvxM1jjT+PXBrbUz/z1OutmnLKrB+D4hDFMYa+nPFeFblm+MSpvl4vauUetfzUek61WY
 IqE2adM6P4YRvxhhuiyYtroGQfmTNmSObobCdjDzCETN43DVW03VUj1sSXDLy4AwLQRJVha3Tv6
 QHA7GFWEGh3pwXQTfNevHv403mZYfpr331yOHBT3Sg2BrftK5CYiMUrNHkkI/GLRWqJOGQSLwJf
 1JY9BlnPW3VbpOuFTR1OZ1pT3tE4kW0yjSWEBzBnf8wq0oQbeG8m
X-Google-Smtp-Source: AGHT+IFq/xaw0hTaR++9NnjzeAISSZ2w7hheBK45eecxZyGlS+hV0KwIvLGtt5qpqp45ngMQfC/kdw==
X-Received: by 2002:a17:90b:51cc:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-306a601d9e8mr3259303a91.0.1743752565670; 
 Fri, 04 Apr 2025 00:42:45 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:220:2937:2caa:d050])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca8cffasm2967822a91.26.2025.04.04.00.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 00:42:44 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v4] block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
Date: Fri,  4 Apr 2025 00:42:33 -0700
Message-ID: <20250404074233.133365-1-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=prantoran@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Full Unit Access (FUA) is an optimization where a disk write with the
flag set will be persisted to disk immediately instead of potentially
remaining in the disk's write cache. This commit address the todo task
for using pwritev2() with RWF_DSYNC in the thread pool section of
raw_co_prw(), if pwritev2 with RWF_DSYNC is available in the host,
which is alway for Linux kernel >= 4.7. The intent for FUA is indicated
with the BDRV_REQ_FUA flag. The old code paths are preserved in case
BDRV_REQ_FUA is off or pwritev2() with RWF_DSYNC is not available.

During testing, I observed that the BDRV_REQ_FUA is always turned on
when blk->enable_write_cache is not set in block/block-backend.c, so
I commented this section off during testing:
https://gitlab.com/qemu-project/qemu/-/blob/master/block/block-backend.c?ref_type=heads#L1432-1434

Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>

Update 1:

The testing with "-t writeback" works for turning on enable_write_cache.
I renamed the function to qemu_pwritev_fua() and fixed any typos.

I moved the handle_aiocb_flush() into the qemu_pwritev_fua() and
removed from the previously todo seciont. Initially I thought
of only passing aiocb, but then I was not sure whethe I could
derive buf from aiocb, so I added arguments for iovec and iovcnt
into qemu_pwritev_fua().

For handling buf in handle_aiocb_rw_linear(), I created iovec
and passed its reference. I assumed that there will be only one
buffer/iovec, so I passed 1 for iovcnt.

Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>

Update 2:

For non-Linux hosts, I am returning -ENOSYS in the same way for
pwritev.

I changed the signature to add fd, iov, nr_iov, offset separately,
with the aiocb pointer at the end. I thought of reconstructing
aiocb inside the function but the handle_aiocb_flush() uses
(BDRVRawState)aiocb->bs->opaque which I was not sure whether it
was used to pass return values upstream.
So I decided on passing aiocb pointer as an input argument.

I was not sure about how git rebase worked with patches, I hope
it worked, finger-crossed 😅

Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
---
 block/file-posix.c | 59 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..16e32acedd 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -229,6 +229,7 @@ typedef struct RawPosixAIOData {
             unsigned long op;
         } zone_mgmt;
     };
+    BdrvRequestFlags flags;
 } RawPosixAIOData;
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -1674,6 +1675,20 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
     return pwritev(fd, iov, nr_iov, offset);
 }
 
+static ssize_t
+qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, const RawPosixAIOData *aiocb)
+{
+#ifdef RWF_DSYNC
+    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
+#else
+    ssize_t len = pwritev2(fd, iov, nr_iov, offset, 0);
+    if (len == 0) {
+        len = handle_aiocb_flush(aiocb);
+    }
+    return len;
+#endif
+}
+
 #else
 
 static bool preadv_present = false;
@@ -1690,6 +1705,11 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
     return -ENOSYS;
 }
 
+static ssize_t
+qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, const RawPosixAIOData *aiocb)
+{
+    return -ENOSYS;
+}
 #endif
 
 static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
@@ -1698,10 +1718,16 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
 
     len = RETRY_ON_EINTR(
         (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
-            qemu_pwritev(aiocb->aio_fildes,
-                           aiocb->io.iov,
-                           aiocb->io.niov,
-                           aiocb->aio_offset) :
+            (aiocb->flags &  BDRV_REQ_FUA) ?
+                qemu_pwritev_fua(aiocb->aio_fildes,
+                                aiocb->io.iov,
+                                aiocb->io.niov,
+                                aiocb->aio_offset,
+                                aiocb) :
+                qemu_pwritev(aiocb->aio_fildes,
+                            aiocb->io.iov,
+                            aiocb->io.niov,
+                            aiocb->aio_offset) :
             qemu_preadv(aiocb->aio_fildes,
                           aiocb->io.iov,
                           aiocb->io.niov,
@@ -1727,10 +1753,22 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
 
     while (offset < aiocb->aio_nbytes) {
         if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
-            len = pwrite(aiocb->aio_fildes,
-                         (const char *)buf + offset,
-                         aiocb->aio_nbytes - offset,
-                         aiocb->aio_offset + offset);
+            if (aiocb->flags & BDRV_REQ_FUA) {
+                struct iovec iov = {
+                    .iov_base = buf,
+                    .iov_len = aiocb->aio_nbytes - offset,
+                };
+                len = qemu_pwritev_fua(aiocb->aio_fildes,
+                                    &iov,
+                                    1,
+                                    aiocb->aio_offset + offset,
+                                    aiocb);
+            } else {
+                len = pwrite(aiocb->aio_fildes,
+                            (const char *)buf + offset,
+                            aiocb->aio_nbytes - offset,
+                            aiocb->aio_offset + offset);
+            }
         } else {
             len = pread(aiocb->aio_fildes,
                         buf + offset,
@@ -2539,14 +2577,11 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
             .iov            = qiov->iov,
             .niov           = qiov->niov,
         },
+        .flags          = flags,
     };
 
     assert(qiov->size == bytes);
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
-    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
-        /* TODO Use pwritev2() instead if it's available */
-        ret = raw_co_flush_to_disk(bs);
-    }
     goto out; /* Avoid the compiler err of unused label */
 
 out:
-- 
2.43.0


