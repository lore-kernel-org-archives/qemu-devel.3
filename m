Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF87C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzuRX-0008KV-7S; Wed, 02 Apr 2025 05:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1tzuRO-0008Jv-9X; Wed, 02 Apr 2025 05:31:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1tzuRL-0004lq-NV; Wed, 02 Apr 2025 05:31:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227a8cdd241so37603735ad.3; 
 Wed, 02 Apr 2025 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743586276; x=1744191076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yqvVEl8tA6R9IQjAY85z/m0Nm3Q19B3rLXCLdGwPbCQ=;
 b=JcVwjDTB7UVBiZcQlNziv8AdCvhNddXfjRwz149DCi7qyvLqEZxepR+bL0Tj3LUCkJ
 oNVwilVSCtdu8pAAdZs0p9d0+cBu9pj/j/Nkk5a/Qo2UTuUQmunjao3djNGDyD0SXzQS
 OUBrrygHkCstigv94XmBYkrEmVC70gVKZ3oOGLADJWguEWwVy3QfNkLQ3tiEvckgWhrR
 +9auGZsS8I4Y1sCvPQhj5jGM6aQeCN48psFyg7++ybys3adWL7LcL8gj7CK32qnj4keZ
 1eSp8CcwP8VktLYVMjGLLRMCat8PkWptx/mRGyTiRgSS/ADr8L0loMnwc2z1FY5vf3MT
 oCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743586276; x=1744191076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yqvVEl8tA6R9IQjAY85z/m0Nm3Q19B3rLXCLdGwPbCQ=;
 b=tsqMkRAvb2ZgCgd8LieMmXKOJ+Dk0O6J4JG8oBjdJ8ufkh77p5utsQwg+tjcoG9GA2
 Fe0JemQBp+bywd9qbKZzBslGpfMCYB7t4jK+F2GvEcAeVMRuUWLLulHFPBZagQ4Q2YlP
 vWPdbOaMT3NjvkFgT5E+zyw4F2GV08kAN1TNwcIFxo0/6PphMm0X7eIEvFP2DKvtomHJ
 FTUym/xdZILQL3jBrY9ERzO+YRIOapza7AOH2QJmZUZ9YlQ190xfCh2fszVm2yA69xWp
 yUprNUv92TGB32JHcW7EyZu+kbDzWtAeDMy1pMDF9DveEgcrURJ8p0IqZzVVnON4Jufr
 lnaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvpUpzv1dvUXbZqP9jkDDZfOoD4CzaBUG1LXPnAeIwWwgWI5TjRinqvGHjV4/2gvwSBYU1qwKDdgER@nongnu.org
X-Gm-Message-State: AOJu0YwvhzQ8aRy2alBGFYqHxyPXIjKCaoq0jkOtL5MPUbl25CfPPEZV
 M2XgP8sF7a+dsHuD79sW++leBGKKYvFFG6aFl5Nr5K3E9DbOV/oG
X-Gm-Gg: ASbGncs6lGWOhqgG6m5XFaE74sJeucJ55hNafBmprOySzLdxLj2BWyIHgJXQKcjkYNk
 CuBQDRyF6z8s9zUNkDXVuoCrmjuWtgP0IWN96uFefGo2cZcthdRHp8T9W+bqt97Eg9BfzeqCQRI
 fQEfZ70gdAb027+4V1CqFA5K18e+FNYPIWUXNs/YOrR4M6J9ka4hzss3IlGQy9EI4g6F00ocDQT
 PAgbBKgOUEpJHrswWnLEX1FG6rZfeZK77QEdNLWv0IYkPmzyNXRsjvCWRbK2rD0OrUUjfQWizpL
 z20lziKldKKnlSL1lxCQtJ2JUvOxho5jG/6okzgTa7M=
X-Google-Smtp-Source: AGHT+IFa4w93ottiSz/j20RjoHWq7pojwbc09r0qgsQBUG3vl/o3crQJaqZlH0SCImbpNLCu6oEkmQ==
X-Received: by 2002:a17:902:d4c4:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-2296c6863dbmr26359545ad.24.1743586275661; 
 Wed, 02 Apr 2025 02:31:15 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:63e2:c940:de7a:976a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e51337sm10436699b3a.82.2025.04.02.02.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 02:31:14 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH] block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
Date: Wed,  2 Apr 2025 02:31:01 -0700
Message-ID: <20250402093101.256136-1-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=prantoran@gmail.com; helo=mail-pl1-x636.google.com
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
---
 block/file-posix.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..34de816eab 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -229,6 +229,7 @@ typedef struct RawPosixAIOData {
             unsigned long op;
         } zone_mgmt;
     };
+    BdrvRequestFlags flags;
 } RawPosixAIOData;
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -1674,6 +1675,16 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
     return pwritev(fd, iov, nr_iov, offset);
 }
 
+static ssize_t
+qemu_pwrite_fua(int fd, const struct iovec *iov, int nr_iov, off_t offset)
+{
+#ifdef RWF_DSYNC
+    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
+#else
+    return pwritev2(fd, iov, nr_iov, offset, 0);
+#endif
+}
+
 #else
 
 static bool preadv_present = false;
@@ -1698,10 +1709,15 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
 
     len = RETRY_ON_EINTR(
         (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
-            qemu_pwritev(aiocb->aio_fildes,
-                           aiocb->io.iov,
-                           aiocb->io.niov,
-                           aiocb->aio_offset) :
+            (aiocb->flags &  BDRV_REQ_FUA) ?
+                qemu_pwrite_fua(aiocb->aio_fildes,
+                                aiocb->io.iov,
+                                aiocb->io.niov,
+                                aiocb->aio_offset) :
+                qemu_pwritev(aiocb->aio_fildes,
+                            aiocb->io.iov,
+                            aiocb->io.niov,
+                            aiocb->aio_offset) :
             qemu_preadv(aiocb->aio_fildes,
                           aiocb->io.iov,
                           aiocb->io.niov,
@@ -1727,10 +1743,17 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
 
     while (offset < aiocb->aio_nbytes) {
         if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
-            len = pwrite(aiocb->aio_fildes,
-                         (const char *)buf + offset,
-                         aiocb->aio_nbytes - offset,
-                         aiocb->aio_offset + offset);
+            if (aiocb->flags & BDRV_REQ_FUA) {
+                len = qemu_pwrite_fua(aiocb->aio_fildes,
+                                    aiocb->io.iov,
+                                    aiocb->io.niov,
+                                    aiocb->aio_offset);
+            } else {
+                len = pwrite(aiocb->aio_fildes,
+                            (const char *)buf + offset,
+                            aiocb->aio_nbytes - offset,
+                            aiocb->aio_offset + offset);
+            }
         } else {
             len = pread(aiocb->aio_fildes,
                         buf + offset,
@@ -2539,14 +2562,17 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
             .iov            = qiov->iov,
             .niov           = qiov->niov,
         },
+        .flags          = flags,
     };
 
     assert(qiov->size == bytes);
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
+#ifndef RWD_DSYNC
     if (ret == 0 && (flags & BDRV_REQ_FUA)) {
         /* TODO Use pwritev2() instead if it's available */
         ret = raw_co_flush_to_disk(bs);
     }
+#endif
     goto out; /* Avoid the compiler err of unused label */
 
 out:
-- 
2.43.0


