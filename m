Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36230C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Fl4-0002OO-LQ; Thu, 03 Apr 2025 04:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fkt-0002Lz-EY; Thu, 03 Apr 2025 04:16:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fkr-0002lA-5N; Thu, 03 Apr 2025 04:16:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso747557b3a.2; 
 Thu, 03 Apr 2025 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743668211; x=1744273011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqvVEl8tA6R9IQjAY85z/m0Nm3Q19B3rLXCLdGwPbCQ=;
 b=IhaqUJuZMnIZoUAmQCCTi3pOT96gdHpj3159rLLsoAz/NRqepTgpZ/5OxhWHXeXeiL
 4yD052M1hFcBdDdMkZl2skscZLE5ShIj0p+5K/pQMhAnxhVX363HQq6uK8m8zsWOhRVR
 u5eAwSY5RqsPdkiVfRa2m4Zx0mXpc0Oj8MbR94m1kW9RlkI7giaclfF2q7BAv7nlyoJn
 LJFKlGSfppr+Q6jsAzvUjYFb+BSnKcRWPJ7JoVPnBU7KgZGjkg8BV5E1pNu6nH3JwZXq
 g+2VWbrQPxSsBk7T7qbcsjAepEUCKrtN463VUpWEbjOid2cAsX3DhEWcOkrLCCktR0J7
 7JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743668211; x=1744273011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqvVEl8tA6R9IQjAY85z/m0Nm3Q19B3rLXCLdGwPbCQ=;
 b=R1VSoqs8tK51GttQ2nHGY3Xd9OTvW9eg+VdEmHOZ/uQ8X14ta4UU/257lMxQUcjZCk
 OQHdB+Fs6qhdvKlmHxLStM8KuC9/FjWS+ThxTcZnJ1tnmSnX1+jS1rTsr6j++rf/z6Tn
 Jj+kqDpL/KYbV4cWRbz93osI9jWQZhfEV0/8HLVbiTtZNkmMpBhCz/+SR2ITaCzyj5+v
 fQB1XI29vvTkh83/8mRlG1lLxVuN6drD9aPyArT+EzuSdTiNrRWoLg/UuEEOOOrtAf2u
 6tUdUcRlrxizjLFCCeMbSEdWiJrFUTRg7yH3UsNmEWMnUh9UzDAkQ2VRoi56ODyOiR3n
 1bCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8ofmhRec802Ok1yb073UJz7z2Mo4ZcvfzbJpOG4+ZgD5RFAKKDGmw1OWOeK/fH7GxakkpFCyYGCt@nongnu.org
X-Gm-Message-State: AOJu0YyEB6m3Nrve3lZi3ZcSANTo7Lav8orIQcddRibvLUmOXL8Gjuiz
 G0WjJUfgPJGtKJu9sH1jlrBKDeIL3lns3AG6J3fY5Cv1ACSQ8QjVLBHywwo0eyw=
X-Gm-Gg: ASbGncuF7r1vJV8iNA33zvPY7BbTbpEfB3mVdnRv40y9ymGNODdP06NG/KeolYINb/A
 71jbe4crcaGGdeCInW0TRQwppm+V8nUb+2qzhn3NogVwWcjtCS5CSoN3zmC+xLlNp/5ydZuCLI0
 WeX8ewre/23u/sVOImqh4bR4kOKb/65/ASyXJNIX3uWP4+AS0A1+/bpmqJm0Riqf5fa/yFR+Y+W
 qBC9Rj5xQt1123qkHG0yZHH4i0ag7Pgm80r+D1qhLBuTSsuuYC1tsqX68L27iovs4XJPJPsHcVI
 7flDb4P2cJrVeP2LNxCcBlE1pdUmFjzU+S1u188SbQ==
X-Google-Smtp-Source: AGHT+IHQU6Xt/8iF8aw/F81Adfr8GMuCHe/su1wn0IzwOVnwlaXDYQOXRajGyMdedkQOWhDIsc6ckQ==
X-Received: by 2002:a05:6a00:238a:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-739c7965d2dmr6782370b3a.21.1743668211174; 
 Thu, 03 Apr 2025 01:16:51 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:a9bb:524:486b:23c8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9e9db78sm895308b3a.97.2025.04.03.01.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 01:16:49 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v2 1/2] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Date: Thu,  3 Apr 2025 01:16:32 -0700
Message-ID: <20250403081633.158591-2-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403081633.158591-1-prantoran@gmail.com>
References: <20250403081633.158591-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=prantoran@gmail.com; helo=mail-pf1-x433.google.com
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


