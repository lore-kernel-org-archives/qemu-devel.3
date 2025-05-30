Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD4C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 03:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKqhy-00073y-US; Thu, 29 May 2025 23:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKqhx-00073h-6t
 for qemu-devel@nongnu.org; Thu, 29 May 2025 23:47:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKqhu-0007rj-U7
 for qemu-devel@nongnu.org; Thu, 29 May 2025 23:47:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c9907967so1661251b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748576817; x=1749181617;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SmHrKAIG3latrlQVZf4f4pjdfsqMll3J1YItE/z3El4=;
 b=1l4kLNorZEgcDaU08gyYqn9yeOLk3fndEVxxFdqi0bKEmBBsAWQwSDQEwZWTDXBb3U
 uYGgtkIu94kAptOepvnGexvpdEzKSt1G+T3uKDStGBB5wYalVRRTTCUN+2JRoocT+LMT
 Q3UjgVB7fMnQ6p/b45IY72/SOyWC/VO0PfRsSITZ9cQiNOc63z9fAFz6kmHR4VZKOAJn
 cL0Qys5p9XVwHqpalNbPHYcZSfpO5ht/S2qaDlgK949Tl+IubVImifqI9tfrmnT/GVp2
 zrW0ju03GL2shXrYU6RD1h9FutMaF6wWBsITUb6kGf9YoPfzLLeqDCgN1ctSzl6g8onS
 RrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748576817; x=1749181617;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SmHrKAIG3latrlQVZf4f4pjdfsqMll3J1YItE/z3El4=;
 b=wZNaL+FYuB8cxKRcwwnHkFAVo+3f9VZhP5g3I0G3rndL4tFaF/MFgAQP+SUY7w9jjH
 I0bdHZfJI3Bxys6cSBuDJ8F15hVl9bQQdiFgXltqYW+4ZvRkXXBTJW51zulEml81+XmD
 05PhydBouS6uilewYK/ylZPRqD6qjz/IFWesWJSTIGbOVG18cqtkl4EyyBd2arYoFA1f
 BhdtwnZJIdhGGcqgWs4iXbZozFA+hRjdukc+/YBg+7UH7w0qNuQRknhnfmeSCp+Jdx3s
 AltSEWfi4jS60h0IKgK7uI+e2NnRZa/j4q4zihr0WeZSZyu22PMAuUWaCE3mWNnNA3S8
 Avfw==
X-Gm-Message-State: AOJu0Yzk4+5t2htx6ukTIWq+bdP6Po0/tEVDCMCwifW6Bt8mkP4OM50T
 I981di+Q3Vxbljv6ucIO9quvzedXKE+KWjbj64AupDG0EbClITpHA2NzG2JoN0hOy0A=
X-Gm-Gg: ASbGncuKrhTBmXvvNLUydOlNfiRLJzckp1REqo+io3xlWN2QcIROhUFyvXg+SY3w38c
 aq0qUuVkJUoJYJz0B4mAA2BhMA/9tXRyVBHO77cGljlDFOIx9Mhf6twmaTpc592+DHpRHeNwjiK
 ZEba2F+28x2L5Hzia5B1v7XOArOjSdZIv8deXEG6LwiNcsRuMkYI365OzGEQNIlTY9nwVt72Dvn
 Vw8x26gXVyxE+kmm8F8zbPObXKiY8QluPjs55xizd7WZpopafzmKDZFXUz/4Fvhll4TFDfx3dyp
 PTbHkjwXUA4nELj6Do/kxX5SBG+xQyLoPTruOWoPVkaGM0glUqBE
X-Google-Smtp-Source: AGHT+IHWdc57MR0e9L2kxv877vEbjlWCD6yKaGkq3L0En3CZlsIDHzM3Q/H1SqvXTZJ48t0Q5kmoEw==
X-Received: by 2002:a05:6a00:1949:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-747bd94c5d8mr3052541b3a.3.1748576816791; 
 Thu, 29 May 2025 20:46:56 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affafb44sm2147252b3a.107.2025.05.29.20.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 20:46:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 12:46:53 +0900
Subject: [PATCH v2] file-posix: Tolerate unaligned hole at middle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-dio-v2-1-5830b56f781c@daynix.com>
X-B4-Tracking: v=1; b=H4sIACwqOWgC/1WMwQ6DIBAFf8XsudsAKiU9+R+NBwRa91BooCEaw
 7+L3jzOy5vZILlILsGz2SC6TImCryBuDZhZ+49DspVBMNGzXii0FNBOrNNS6ofqFNTnL7o3LWf
 lNVaeKf1DXM9o5sd69TNHjrJt2dHgkzKD1aun5W7CF8ZSyg66J4rplwAAAA==
X-Change-ID: 20250528-dio-db04a66a7848
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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
match with the alignment of holes.

So stop asserting the assumption on the holes and handle unaligned holes
properly.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Changed to round the number also when the specified offset in a hole.
- Changed to iterate until finding an aligned location.
- Link to v1: https://lore.kernel.org/qemu-devel/20250528-dio-v1-1-633066a71b8c@daynix.com
---
 block/file-posix.c | 83 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ec95b748696b..d3c598d96895 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3280,6 +3280,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
                                             BlockDriverState **file)
 {
     off_t data = 0, hole = 0;
+    bool has_data = false;
     int ret;
 
     assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
@@ -3297,40 +3298,62 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
 
-    ret = find_allocation(bs, offset, &data, &hole);
-    if (ret == -ENXIO) {
-        /* Trailing hole */
-        *pnum = bytes;
-        ret = BDRV_BLOCK_ZERO;
-    } else if (ret < 0) {
-        /* No info available, so pretend there are no holes */
-        *pnum = bytes;
-        ret = BDRV_BLOCK_DATA;
-    } else if (data == offset) {
-        /* On a data extent, compute bytes to the end of the extent,
-         * possibly including a partial sector at EOF. */
-        *pnum = hole - offset;
+    /*
+     * We may have allocation unaligned with the requested alignment
+     * due to the following reaons:
+     * - unaligned file size
+     * - inexact direct I/O alignment requirement estimation
+     * - mismatch between the allocation size and
+     *   direct I/O alignment requirement
+     *
+     * We are not allowed to return partial sectors, though, so iterate
+     * until finding an aligned location in or at a border of a hole.
+     */
+    *pnum = 0;
+    do {
+        ret = find_allocation(bs, offset + *pnum, &data, &hole);
+        if (ret == -ENXIO) {
+            /* Trailing hole */
+            if (!has_data) {
+                *pnum = bytes;
+            }
+            break;
+        }
 
-        /*
-         * We are not allowed to return partial sectors, though, so
-         * round up if necessary.
-         */
-        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
-            int64_t file_length = raw_getlength(bs);
-            if (file_length > 0) {
-                /* Ignore errors, this is just a safeguard */
-                assert(hole == file_length);
+        if (ret < 0) {
+            /* No info available, so pretend there are no holes */
+            *pnum = bytes;
+            has_data = true;
+            break;
+        }
+
+        data -= offset;
+        hole -= offset;
+
+        if (data == *pnum) {
+            /* Return the end of a data extent if aligned. */
+            has_data = true;
+            *pnum = ROUND_UP(hole, bs->bl.request_alignment);
+            if (*pnum == hole) {
+                break;
+            }
+        } else {
+            /* Round down the end of a hole. */
+            assert(hole == *pnum);
+
+            if (data - *pnum >= bs->bl.request_alignment) {
+                if (!has_data) {
+                    *pnum = ROUND_DOWN(data, bs->bl.request_alignment);
+                }
+                break;
             }
-            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
+
+            has_data = true;
+            *pnum += bs->bl.request_alignment;
         }
 
-        ret = BDRV_BLOCK_DATA;
-    } else {
-        /* On a hole, compute bytes to the beginning of the next extent.  */
-        assert(hole == offset);
-        *pnum = data - offset;
-        ret = BDRV_BLOCK_ZERO;
-    }
+    } while (*pnum < bytes);
+    ret = has_data ? BDRV_BLOCK_DATA : BDRV_BLOCK_ZERO;
     *map = offset;
     *file = bs;
     return ret | BDRV_BLOCK_OFFSET_VALID;

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250528-dio-db04a66a7848

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


