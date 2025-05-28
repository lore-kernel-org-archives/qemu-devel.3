Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB273C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 11:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEzB-0003di-KJ; Wed, 28 May 2025 07:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKEz9-0003b6-4I
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:30:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKEz5-0005Bm-IL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:30:14 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-311e993f49aso396134a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748431809; x=1749036609;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q64yR4b+sL+fRICLpPHKDY1Z961O7A8a+ehK3Bc9Lnk=;
 b=HYnp4nP5X+co/knGov6+ttYukmZaQyvfm0hu2RkFj54pOykKK+VlZpARaFD9CdniJh
 wmSV0IA0emQrqrTL5JZ5vYzqZCvc4+ccK4lZcUDpDHlcWx4qEXb4z7RCJVPb4LiqRVhr
 MTZTw26GubwAcjjVP+aRaZ1LaKFiKtOZ37/0W1ykaCumX5DctizWnTjRSNs0kaztAnQl
 LB8aI5qu37keGXLNkDhop/briDJ5nQXTdsD0Sqir8fUMG3PnVRdgUT3Bb/K6xoOtz0Fd
 V4eFWDbIgtfH2P8arVMsnYwPp3JiZUoiMLgflP0JkTJ+aRn6HbDOKI05iydAZYgNmWhj
 kWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748431809; x=1749036609;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q64yR4b+sL+fRICLpPHKDY1Z961O7A8a+ehK3Bc9Lnk=;
 b=LmRWKWrflNymSPPJU0hd0qPIJMqrMseBWwx7WdPJI89bpjazki/5Ub6IuUUb4CYsqn
 HkCUPVPMh66rVGAxFXS0xS3kb2xYB+dq3slrqXSrMaSXoeEq1SwZUbkzGLaBBIl4CEhg
 MTTJPaWWWLp5wobqEBKNQ1AqddRQ6ioLQW+bIdpizUgJdZuTxpt9Xyc5h5paaEl7AJrU
 1+2UdKkMjwXZZ42lwLoXDB7aEVfDpGFSxiGSh1m9yDwe8zC9GEUfP/Ih0GmGM0zU7Bvk
 h1LW1xB1K+tblf9nrnUbRaBILL7itvgzwb0zu0lKNw70pq65X/EAnkFSBEgOVS5nQuUO
 TioA==
X-Gm-Message-State: AOJu0YyWbeLCLvwGR1GWLQxxXgbL7A4An4ydVU/rCRxvUqk9Lykiy/Mg
 BqjdT6yo14IT8OFmiEikSF+HrvcLocVDS1O0u5sAqHqTfhBrDpXSSJl6FzHI7wa/bDc=
X-Gm-Gg: ASbGncvKuCEH9PBSui0F08sqSYMuU+mLsNKmpyqdL2xbtgGW2GLr8WAlHKbQ/wUthNO
 mgWrZrC0cPRKu0t7jzKeP17yefvoPlFy9Sejl3IFacX0kxsUojvg4ylp62AiuQBj47sCK0OuPte
 45FYvtzXbl+1k2NzKmbIjV3uPxNhLRE4idiNnNA1GW6mgupZ7/xCw4clbizGxu6vGR5dxJ5P+vK
 BExIFHd6Illw9Vc9oJ/rK8bKVrU0/yeolW2dCkMCsnA6WRMUGuL3vRCLojfuEKtaoAAhm3IVITL
 emK1YtXtiTbmflXsJMaXtkMjnV2qhrQ+r6JONkxbyLF7rRAmZYcc
X-Google-Smtp-Source: AGHT+IEJ4dpoLh0sCQU1eEAtFlg0H9jMKH1QrrJzvSYbxQy6fbzLFPYxLHeJdB9ZDKEqEUTobziWaQ==
X-Received: by 2002:a17:90b:3dc3:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-311e8cc462emr2997197a91.25.1748431809144; 
 Wed, 28 May 2025 04:30:09 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-311e9c28e01sm954581a91.31.2025.05.28.04.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:30:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 May 2025 20:30:05 +0900
Subject: [PATCH] file-posix: Tolerate unaligned hole at middle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-dio-v1-1-633066a71b8c@daynix.com>
X-B4-Tracking: v=1; b=H4sIALzzNmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3ZTMfN2UJAOTRDOzRHMLEwsloMqCotS0zAqwKdGxtbUAU0WYjVU
 AAAA=
X-Change-ID: 20250528-dio-db04a66a7848
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

file-posix used to assume that existing holes satisfy the requested
alignment, which equals to the estimated direct I/O alignment
requirement if direct I/O is requested, and assert the assumption
unless it is at EOF.

However, the estimation of direct I/O alignment requirement is sometimes
inexact and can be overly strict. For example, I observed that QEMU
estimated the alignment requirement as 16K while the real requirement
is 4K when Btrfs is used on Linux 6.14.6 and the host page size is 16K.

For direct I/O alignment, open(2) sugguests as follows:
> Since Linux 6.1, O_DIRECT support and alignment restrictions for a
> file can be queried using statx(2), using the STATX_DIOALIGN flag.
> Support for STATX_DIOALIGN varies by filesystem; see statx(2).
>
> Some filesystems provide their own interfaces for querying O_DIRECT
> alignment restrictions, for example the XFS_IOC_DIOINFO operation in
> xfsctl(3). STATX_DIOALIGN should be used instead when it is available.
>
> If none of the above is available, then direct I/O support and
> alignment restrictions can only be assumed from known characteristics
> of the filesystem, the individual file, the underlying storage
> device(s), and the kernel version. In Linux 2.4, most filesystems
> based on block devices require that the file offset and the length and
> memory address of all I/O segments be multiples of the filesystem
> block size (typically 4096 bytes). In Linux 2.6.0, this was relaxed to
> the logical block size of the block device (typically 512 bytes). A
> block device's logical block size can be determined using the ioctl(2)
> BLKSSZGET operation or from the shell using the command:

Apparently Btrfs doesn't support STATX_DIOALIGN nor provide its own
interface for querying the requirement. Using BLKSSZGET brings another
problem to determine the underlying block device, which also involves
heuristics.

Moreover, even if we could figure out the direct I/O alignment
requirement, I could not find a documentation saying it will exactly
matche with the alignment of holes.

So stop asserting the assumption on the holes and tolerate them being
unaligned.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 block/file-posix.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ec95b748696b..7b686ce6817d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3307,22 +3307,21 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA;
     } else if (data == offset) {
-        /* On a data extent, compute bytes to the end of the extent,
-         * possibly including a partial sector at EOF. */
+        /* On a data extent, compute bytes to the end of the extent. */
         *pnum = hole - offset;
 
         /*
+         * We may have allocation unaligned with the requested alignment due to
+         * the following reaons:
+         * - unaligned file size
+         * - inexact direct I/O alignment requirement estimation
+         * - mismatches between the allocation size and
+         *   direct I/O alignment requirement.
+         *
          * We are not allowed to return partial sectors, though, so
          * round up if necessary.
          */
-        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
-            int64_t file_length = raw_getlength(bs);
-            if (file_length > 0) {
-                /* Ignore errors, this is just a safeguard */
-                assert(hole == file_length);
-            }
-            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
-        }
+        *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
 
         ret = BDRV_BLOCK_DATA;
     } else {

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250528-dio-db04a66a7848

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


