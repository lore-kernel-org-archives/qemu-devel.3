Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8100DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Fl3-0002Nl-62; Thu, 03 Apr 2025 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fkv-0002MC-7U; Thu, 03 Apr 2025 04:17:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u0Fks-0002lP-Oc; Thu, 03 Apr 2025 04:16:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-730517040a9so658539b3a.0; 
 Thu, 03 Apr 2025 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743668213; x=1744273013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJW7eEeDhBJeBk4owO1r4ck3myY5mwymx+z2ADb+4XU=;
 b=K7t/A/ecOitpT7EXrRS/ckWPQD4n+lkubf1qp4iadRm+EwkvzNOA7qZCZToyNGM3PM
 Cvi+zgZTAMkVlgt0G+oM5hFqfcQnsfDetXhGvDZz0iB1QIOEl6l+ijTpS8D9E5Ckz82s
 5k3SJSeQ3wiKPD47p47DrNMmEC32KjUoO+rXO4VsONHFTisc74Y22bwEXQgKVAVvuoi2
 ypOmZfHWFnh450uRkXbSpuvVIeOvk6uYMFaPvMbH+78KykPktSC9Z/aVCQtvl3B9VgE4
 vsqfTtKnIAPAUU0pUZiVpyXhRSWt37T5sv+WJuxNkxgeUyZRp5TU7nZv99l68g9Qb8E7
 1P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743668213; x=1744273013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJW7eEeDhBJeBk4owO1r4ck3myY5mwymx+z2ADb+4XU=;
 b=vXLJiNOhhY4oouUwaxxTOwW2Hi94R+XNZ4CUiMbs05e35nz2aSvp5wET3x3SKLVxHT
 Y0V8g3oYv8qZCuE2wCWjJOtE6vDKd2KHfVuZHbLHTPA6Fs7Q7H/z7J+S/Bt0LK0t44RC
 zOQe0LQLVTu8TyYXIegaydzkyEfyV3qNkfEcAqrX6hwlSrwhEpAClB0MU8K2UjLlWYGc
 MWxMMM0pWMwZxG34FOq9Riz0iw2uRzxHlR2pDfmWJR0tpISQKfg90NmtEJz6DlDVaNh6
 Pqibjz+I/KU5anqZPuNt/vnI64MvCpEjeQs/anEaYylsya6CSW6d+udkcW+HiSs+qeWS
 uWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcfPPPkaTLdeFX2TBfpq43XfXq2zMvZFPwRAeG+hm9dCSkoQclvab/9hn5FTwTG/NWRPcAiRD+mfia@nongnu.org
X-Gm-Message-State: AOJu0YwVP/TEKo0STw0LjyZ3nC6eyECxeBq8nWjExNjzcemXu+whA444
 yu0NNSo7i2ZSgki/lLCFNxL5ioNY/RJUcR356rDcr2BmUGoXGK22
X-Gm-Gg: ASbGncsyAwrDD/fhojnmbIwth6rKTK7P127LexpoRQ5YoNeKrzPEX+PM0/oC/pbqcUT
 TlhCKqbXEBZpmN1sRlmj9M3Xzi0Ag6M6tvKWhZDWA488RPkGv1JrzWC13zAMY0xmWxQMb3WO5/c
 ghio+24YueGsMVCbOiv5orEYXc2crhKt0EZNnR5uCvQ0YsuZu4Mbn7tSDjNNsbnJHOkHwzkrUMn
 20og2rP97VGd6YWmM007Cp5Rwx3mZG8iZvNMDfBmwDfetfhstKvxu2H9l9RhehoITbcqRTbuBtv
 GydraWNGYdUAQrPedPaSaG4IP3qlqkvNF7u06DZHMg==
X-Google-Smtp-Source: AGHT+IE4EY86NcFclNVxdHBF/oZT8NgHL5VKQB9Qbgvvi6FQAmcUL4T7TbRPOh2VtSsMsoVoQ8cVMg==
X-Received: by 2002:a05:6a00:2292:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-739d8523fd1mr1766485b3a.10.1743668212692; 
 Thu, 03 Apr 2025 01:16:52 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:a9bb:524:486b:23c8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9e9db78sm895308b3a.97.2025.04.03.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 01:16:51 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v2 2/2] [PATCH] block/file-posix.c: Use pwritev2() with
 RWF_DSYNC for FUA - update
Date: Thu,  3 Apr 2025 01:16:33 -0700
Message-ID: <20250403081633.158591-3-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403081633.158591-1-prantoran@gmail.com>
References: <20250403081633.158591-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=prantoran@gmail.com; helo=mail-pf1-x434.google.com
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
---
 block/file-posix.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 34de816eab..4fffd49318 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1676,12 +1676,24 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
 }
 
 static ssize_t
-qemu_pwrite_fua(int fd, const struct iovec *iov, int nr_iov, off_t offset)
+qemu_pwritev_fua(const RawPosixAIOData *aiocb, struct iovec *iov, int iovcnt)
 {
 #ifdef RWF_DSYNC
-    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
+    return pwritev2(aiocb->aio_fildes,
+                    iov,
+                    iovcnt,
+                    aiocb->aio_offset,
+                    RWF_DSYNC);
 #else
-    return pwritev2(fd, iov, nr_iov, offset, 0);
+    ssize_t len = pwritev2(aiocb->aio_fildes,
+                        iov,
+                        iovcnt,
+                        aiocb->aio_offset,
+                        0);
+    if (len == 0) {
+        len = handle_aiocb_flush(aiocb);
+    }
+    return len;
 #endif
 }
 
@@ -1710,10 +1722,7 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
     len = RETRY_ON_EINTR(
         (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
             (aiocb->flags &  BDRV_REQ_FUA) ?
-                qemu_pwrite_fua(aiocb->aio_fildes,
-                                aiocb->io.iov,
-                                aiocb->io.niov,
-                                aiocb->aio_offset) :
+                qemu_pwritev_fua(aiocb, aiocb->io.iov, aiocb->io.niov) :
                 qemu_pwritev(aiocb->aio_fildes,
                             aiocb->io.iov,
                             aiocb->io.niov,
@@ -1744,10 +1753,11 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
     while (offset < aiocb->aio_nbytes) {
         if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
             if (aiocb->flags & BDRV_REQ_FUA) {
-                len = qemu_pwrite_fua(aiocb->aio_fildes,
-                                    aiocb->io.iov,
-                                    aiocb->io.niov,
-                                    aiocb->aio_offset);
+                struct iovec iov = {
+                    .iov_base = buf,
+                    .iov_len = aiocb->aio_nbytes - offset,
+                };
+                len = qemu_pwritev_fua(aiocb, &iov, 1);
             } else {
                 len = pwrite(aiocb->aio_fildes,
                             (const char *)buf + offset,
@@ -2567,12 +2577,6 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
 
     assert(qiov->size == bytes);
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
-#ifndef RWD_DSYNC
-    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
-        /* TODO Use pwritev2() instead if it's available */
-        ret = raw_co_flush_to_disk(bs);
-    }
-#endif
     goto out; /* Avoid the compiler err of unused label */
 
 out:
-- 
2.43.0


