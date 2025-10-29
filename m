Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FDCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE01O-0002n7-Qj; Wed, 29 Oct 2025 02:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vE01J-0002m6-Q5; Wed, 29 Oct 2025 02:50:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vE01D-0002fR-MK; Wed, 29 Oct 2025 02:50:57 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59T6oRS7091399
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 15:50:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+XJM9L58F5tsLo4ferbBd9FuV8Mh6lWbSiBA4YTolOU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761720636; v=1;
 b=mENBduJWg8IFT9S39pnNkV0hrwuyh7D+Z0+z40L8UE5ee5FsyyYwdwY+tLMq27lD
 13O7JLPqJk6HUJYiTozgqREFhao6xD7MH3eO7Mmb3HYlj5TEfAKhiagcoOHox718
 Ad/kQK/MGSFOe5EnY8ULeu9lrTBqyoiUMkXMs64LNBGIiKNEp2ohCODgnF5S3rGp
 AgbH50JGF6qUbWFCCQu/DOvBzw3mFWBWWIWf9xlw0zUsnFy4KyGSbfnrCLBgDvoY
 DlT4XjQPkJTib8HE3jv6pW6Yf3TnpRiSFsGUGMRrrspyavx7qE3uyYbLwiZANnxP
 rPY4L6FMONZeWJSkMzCOVQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 15:50:27 +0900
Subject: [PATCH v3] file-posix: Tolerate unaligned hole at middle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dio-v3-1-6ae3bb70db16@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIADK5AWkC/1WMyw6CMBQFf4XctTV90NK44j+Mi76Qu5Ca1jQQw
 r9bcCPLOTkzK+SQMGS4NSukUDBjnCqISwNuNNMzEPSVgVMuqeSaeIzEW9oapUynWw31+U5hwPm
 o3B+VR8yfmJYjWti+nv3CCCNKCLo3mNWu92aZcL66+II9UPifJOhP4lWSWlAr1dBpdpa2bfsCI
 1rHAcwAAAA=
X-Change-ID: 20250528-dio-db04a66a7848
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@daynix.com,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
match with the alignment of holes.

So stop asserting the assumption on the holes and handle unaligned holes
properly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Stop iterating until finding an aligned location. I think I did too
  much with the last version; some caller (e.g., is_zero() in
  block/qcow2.c) only cares if there is *any* allocation in a range, and
  extra iterations only add I/O overhead in such a case.
  The code to iterate should be added only if it is proved to bring
  more benefits than overheads.
- Link to v2: https://lore.kernel.org/qemu-devel/20250530-dio-v2-1-5830b56f781c@daynix.com

Changes in v2:
- Changed to round the number also when the specified offset in a hole.
- Changed to iterate until finding an aligned location.
- Link to v1: https://lore.kernel.org/qemu-devel/20250528-dio-v1-1-633066a71b8c@daynix.com
---
 block/file-posix.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674cedb..b6d7a31b4d04 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3315,29 +3315,38 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA;
     } else if (data == offset) {
-        /* On a data extent, compute bytes to the end of the extent,
-         * possibly including a partial sector at EOF. */
+        /* On a data extent, compute bytes to the end of the extent. */
         *pnum = hole - offset;
 
-        /*
-         * We are not allowed to return partial sectors, though, so
-         * round up if necessary.
-         */
-        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
-            int64_t file_length = raw_getlength(bs);
-            if (file_length > 0) {
-                /* Ignore errors, this is just a safeguard */
-                assert(hole == file_length);
-            }
-            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
-        }
-
+         /*
+          * We may have allocation unaligned with the requested
+          * alignment due to the following reaons:
+          * - unaligned file size
+          * - inexact direct I/O alignment requirement estimation
+          * - mismatches between the allocation size and
+          *   direct I/O alignment requirement.
+          *
+          * We are not allowed to return partial sectors, though, so
+          * round up the end of allocation if necessary.
+          */
+        *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
         ret = BDRV_BLOCK_DATA;
     } else {
         /* On a hole, compute bytes to the beginning of the next extent.  */
         assert(hole == offset);
         *pnum = data - offset;
-        ret = BDRV_BLOCK_ZERO;
+
+        /*
+         * We may have allocation unaligned, so round down the beginning
+         * of allocation if necessary.
+         */
+        if (*pnum < bs->bl.request_alignment) {
+            *pnum = bs->bl.request_alignment;
+            ret = BDRV_BLOCK_DATA;
+        } else {
+            *pnum = ROUND_DOWN(*pnum, bs->bl.request_alignment);
+            ret = BDRV_BLOCK_ZERO;
+        }
     }
     *map = offset;
     *file = bs;

---
base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
change-id: 20250528-dio-db04a66a7848

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


