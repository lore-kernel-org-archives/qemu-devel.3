Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F64F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcGQ-0003hx-UX; Mon, 09 Mar 2026 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFw-0002a6-8A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFs-0000eL-QO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=cSXhqxV5fQN6PZeWolSQX3H4rUw9N2k3xETYS2uqBsF/8iY30fHw9oYziDnhbrX3ugee4x
 IG4SBy7ZDT33UkgaFz1Ce3yyN6NvKYpa1/l1JubiN3fDXG9akuuNHBgE05c6YFw232LEj/
 qQQ5R0E2qJfGu9/H8IeFeXocbBR3bi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-px5IgLSrOd28LXE7ZQ8ZJA-1; Mon, 09 Mar 2026 11:09:51 -0400
X-MC-Unique: px5IgLSrOd28LXE7ZQ8ZJA-1
X-Mimecast-MFC-AGG-ID: px5IgLSrOd28LXE7ZQ8ZJA_1773068980
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso6177754f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068980; x=1773673780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=pruVwzsfpt0ocUUj6JSMyGQcMogrI4X8V109wSLuzq6PRT+NaGcnPx9/sDK8ZGvSfg
 ueNrdt73h4zo+ckdC9PtHl34PuTDX9d/8hM6OfWNMqfCrja6AAIE/H1RhV2L1RJN42K1
 mRpHTufleMXZXADSw8lXVXcwXbkbH3Wh5ADqz+vL+eChr+gfuP0iDOeHcpuklP9reNBs
 jmVN/Km6ZbIQi3anNIZTBDYJkGo2Or1sKrPYc2PlWuPd0ZVIzk7lWzq2WFsJ2/HE73wE
 RMfJK7pL8bfx+RzN1OHg7RG526fviJPGJVWAJzFvu4qElOp5LLhIi8ZSTnjbhkz2/oad
 f1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068980; x=1773673780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=jwrtW3YNFlSB6GoLiOF3w+fueSD5WS+7lZK87/BlR7oU9LhTBPzwjItiHnvKMlyAyu
 lr6zCqa6/b3XN0+mMBvF7NeN1VAdXm3guR1FaLAJRW7jSXmr78fGLGaHz/xd3UnNoWTc
 tNEENJ/ZT/lkcGJ7e4L+hUGRBFb0gmIikTtkpdtCo5MntLIA8Lrj9U4eEfDHHLsstAnn
 K3ds4bOE/91JySy+ql20FJW17Yzn9KsGda4NVRnsCo+LVpOKzma04vbt8w3HXQRKe1FJ
 61eF2kxwDTFfEDM5HXsd/WP/tMcc6m6eoI7qMXHJKONneRi5LIhnFfTrCQJU/A2CC8Mf
 I96A==
X-Gm-Message-State: AOJu0Yw1Vx9GQcju60n/kXo2qhyeMIQHyVg6ub+GQRkJaNB5U9Ogg5Pl
 GBsgBonp3pCM+5MGAvomY7wooChkGUh9TemxLxsXNRSOLbOLdhPlCHhdx3ywlyoiHGqkkY8clVt
 JBGGeXl8S+i/JEJj8rJGD1ar+c7BESlUWDpdkvXW06Pos86DjBM6s1xZz
X-Gm-Gg: ATEYQzxP1ODnUGRtC+WlFuVv6bn2yu47oVNGvMsa0JEEad7Pn7tO24RCrZeqhG0wBt2
 2ruYcH9x0xez87zM/H6NJzfPp03rDPV3+Tx0LbLZR7pgDOsk7QTz6SXWp0U7gr8Bid2MmgkCvJK
 UHWYLuPZgRK97Fg8wLHYCeM/nebcBWk6fjeLCoGWMwHevqgnB4jBZgten3fiS5FqsfK6J6J/2Pc
 2Y728AEUykhlz0oRxc9UJsIMaDyxCgyVu4Xd8Q3VHlseAyUeNXmBH7bYy6ebDuY6R3cQ16QXkto
 9Dkyq6b1UJdgP1qzkgzwr9uOavsyWZ+6NUV2hLicWebdtAwV4okQnINawM5xvw+41nVuRKvhtdG
 VkOl5rSQ+2pAC1JwNJ82hcZQYzynkKrVMD6C5Y1o3ZAH5NWaFlSAN1Q0PJH2KT07MCHrNEJ3Jp6
 IIm/KQ
X-Received: by 2002:a05:6000:1846:b0:439:b7b5:b1d1 with SMTP id
 ffacd0b85a97d-439da65d6e4mr20726829f8f.18.1773068979334; 
 Mon, 09 Mar 2026 08:09:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1846:b0:439:b7b5:b1d1 with SMTP id
 ffacd0b85a97d-439da65d6e4mr20726745f8f.18.1773068978790; 
 Mon, 09 Mar 2026 08:09:38 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9ccsm26660513f8f.19.2026.03.09.08.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:38 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 14/25] fuse: Explicitly handle non-grow post-EOF accesses
Date: Mon,  9 Mar 2026 16:08:45 +0100
Message-ID: <20260309150856.26800-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When reading to / writing from non-growable exports, we cap the I/O size
by `offset - blk_len`.  This will underflow for accesses that are
completely past the disk end.

Check and handle that case explicitly.

This is also enough to ensure that `offset + size` will not overflow;
blk_len is int64_t, offset is uint32_t, `offset < blk_len`, so from
`INT64_MAX + UINT32_MAX < UINT64_MAX` it follows that `offset + size`
cannot overflow.

Just one catch: We have to allow write accesses to growable exports past
the EOF, so then we cannot rely on `offset < blk_len`, but have to
verify explicitly that `offset + size` does not overflow.

The negative consequences of not having this commit are luckily limited
because blk_pread() and blk_pwrite() will reject post-EOF requests
anyway, so a `size` underflow post-EOF will just result in an I/O error.
So:
- Post-EOF reads will incorrectly result in I/O errors instead of just
  0-length reads.  We will also attempt to allocate a very large buffer,
  which is wrong and not good, but not terrible.
- Post-EOF writes on non-growable exports will result in I/O errors
  instead of 0-length writes (which generally indicate ENOSPC).
- Post-EOF writes on growable exports can theoretically overflow on EOF
  and truncate the export down to a much too small size, but in
  practice, FUSE will never send an offset greater than signed INT_MAX,
  preventing a uint64_t overflow.  (fuse_write_args_fill() in the kernel
  uses loff_t for the offset, which is signed.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 20 +++++++++++++++++++-
 tests/qemu-iotests/308     | 35 ++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/308.out | 10 ++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index d45c6b814f..af0a8de17b 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -657,6 +657,16 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
         return;
     }
 
+    if (offset >= blk_len) {
+        /*
+         * Technically libfuse does not allow returning a zero error code for
+         * read requests, but in practice this is a 0-length read (and a future
+         * commit will change this code anyway)
+         */
+        fuse_reply_err(req, 0);
+        return;
+    }
+
     if (offset + size > blk_len) {
         size = blk_len - offset;
     }
@@ -717,7 +727,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
         return;
     }
 
-    if (offset + size > blk_len) {
+    if (offset >= blk_len && !exp->growable) {
+        fuse_reply_write(req, 0);
+        return;
+    }
+
+    if (offset + size < offset) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    } else if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 6ecb275555..a83c6fc01f 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -300,16 +300,34 @@ dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$orig_len \
     conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
+# And one really squarely post-EOF write
+dd if=/dev/zero of="$EXT_MP" bs=1 count=1 seek=$((orig_len + 32 * 1024)) \
+    conv=notrunc 2>&1 \
+    | _filter_testdir | _filter_imgfmt
+
+# Half-post-EOF reads
+dd if="$EXT_MP" of=/dev/null bs=1 count=64k skip=$((orig_len - 32 * 1024)) \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
+# And one really squarely post-EOF read
+dd if="$EXT_MP" of=/dev/null bs=1 count=1 skip=$((orig_len + 32 * 1024)) \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
 echo
 echo '--- Resize export ---'
 
 # But we can truncate it explicitly; even with fallocate
-fallocate -o "$orig_len" -l 64k "$EXT_MP"
+# (Make sure we extend it to a length not divisible by 128k, we need that below)
+bs=$((128 * 1024))
+extend_to=$(((orig_len + bs - 1) / bs * bs + bs / 2))
+extend_by=$((extend_to - orig_len))
+
+fallocate -o "$orig_len" -l $extend_by "$EXT_MP"
 
 new_len=$(get_proto_len "$EXT_MP" "$TEST_IMG")
-if [ "$new_len" != "$((orig_len + 65536))" ]; then
+if [ "$new_len" != "$extend_to" ]; then
     echo 'ERROR: Unexpected post-truncate image size:'
-    echo "$new_len != $((orig_len + 65536))"
+    echo "$new_len != $extend_to"
 else
     echo 'OK: Post-truncate image size is as expected'
 fi
@@ -322,6 +340,13 @@ else
     echo "$orig_disk_usage => $new_disk_usage"
 fi
 
+# Use this opportunity to test a read access across the (now no longer so much
+# aligned) EOF.  dd can only do requests with a length of its block size, and
+# all of its seek/skip values are in bs units, so it is hard to do a request
+# across the EOF if the EOF is at a power of two (64M).
+dd if="$EXT_MP" of=/dev/null bs=$bs count=2 skip=$((extend_to / bs)) \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
 echo
 echo '--- Try growing growable export ---'
 
@@ -338,9 +363,9 @@ dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$new_len conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
 new_len=$(get_proto_len "$EXT_MP" "$TEST_IMG")
-if [ "$new_len" != "$((orig_len + 131072))" ]; then
+if [ "$new_len" != "$((extend_to + 65536))" ]; then
     echo 'ERROR: Unexpected post-grow image size:'
-    echo "$new_len != $((orig_len + 131072))"
+    echo "$new_len != $((extend_to + 65536))"
 else
     echo 'OK: Post-grow image size is as expected'
 fi
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index 2d7a38d63d..ebeaf64b48 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -134,11 +134,21 @@ wrote 65536/65536 bytes at offset 1048576
 dd: error writing 'TEST_DIR/t.IMGFMT.fuse': No space left on device
 1+0 records in
 0+0 records out
+dd: error writing 'TEST_DIR/t.IMGFMT.fuse': No space left on device
+1+0 records in
+0+0 records out
+32768+0 records in
+32768+0 records out
+dd: TEST_DIR/t.IMGFMT.fuse: cannot skip to specified offset
+0+0 records in
+0+0 records out
 
 --- Resize export ---
 (OK: Lengths of export and original are the same)
 OK: Post-truncate image size is as expected
 OK: Disk usage grew with fallocate
+0+1 records in
+0+1 records out
 
 --- Try growing growable export ---
 {'execute': 'block-export-del',
-- 
2.53.0


