Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5D9E9A04D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfk-0004NE-VH; Wed, 18 Feb 2026 08:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfc-0004An-C1
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0005lZ-7j
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=TkoyQ7MMKMc/Z8Hth3a5ilkp5LOmV+g0A/ob7ghqovZ70/D6+xO6oCUJXvIeY4MC812B35
 YgERPkVokdMW4AHsBUBraE99uGDakbVsg2WbIOKk7SPqZHGss2qS5fY7I5xwJWjI56azJs
 1ZSxdZu5T6pP40ArTIVTElIT87CVrQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-TaHz-W2QOxa_4eWltVvVwA-1; Wed, 18 Feb 2026 08:27:20 -0500
X-MC-Unique: TaHz-W2QOxa_4eWltVvVwA-1
X-Mimecast-MFC-AGG-ID: TaHz-W2QOxa_4eWltVvVwA_1771421239
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso37897185e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421239; x=1772026039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=TRm1va/OQyke6Olh1Wym7Cpp1wftOdbNXLiYHk1/qVuwzxBCGqV3Gy15N8nhqkUHXA
 WvscdX2vXzyR0KWasuYxjtnOzQlasO+YLhUeY4wLlCMIcwRyoqbg6TAQAMThZCxmyprW
 gq0oB+xc8lWYNA/wes9GUQmIhfIAXDYvIQp5WX1h8pD3Rs1x9CCoU3xcGZjKt2Xr7/Ld
 Wc6Gg/V2DQfRzXyRs6lco8AL3EfJKPnYw07O6DSSSTTA6s79eRP8TdkSkHZPqF2GrYTS
 Zrcwsz1qtcjJeTM1WlzvrcXvkDkM/wEr0CNFsjoSJXrelI/hUyw8IfhzDndxUIQeoE6K
 fXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421239; x=1772026039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6wY9hvfJ1eIlvKpdImFzHfK6DZcwfCljnWmU410eEo=;
 b=CWGk3P8SQQbiIoBY1laUwH9TFGDl8Q8vloBrvvR5DwVj4zhtjybkwzzl8iSCt8fCoD
 Y9wL26ajUQTkko3B7IPztBmNmdUYkuLYhqC5Z5tqS2rlT6i3rhxLyNCozMBCd/5OxAbw
 pbRxLlee7IXu97nvdL6Sw+riFJ+sNtgjXh2R8gLDrASwIPq0YtO8PhNm//7t25e8TN60
 f1JxU/W6LyftwzNEcDkymPBifsFChiOwJzVPE9+eBT/3E9wh5v8empzvEsa5L4xRlSHC
 9csPtoFFMKaLNzSkPRmA15fvQn/ogH3IUyxkLlBSCo08so/59+osvVEmnDkB4yDXnb+i
 pUQg==
X-Gm-Message-State: AOJu0Ywbzb9rssK2ZNtvwEe1rSgifg/Qw3l5ttSjG4/eyY5XW5YuY9ST
 moKq4v6WZVdcEykXyiXI9wkhKs9I7fFv+MB5DdcF6i9PIRt4u0JmC1Rn3OIxpIlISkJDbEIboRb
 cu4L7p/OHhU1RQ+NhTmQyvPp+jx33KiucDZ+dBzBJKVgFr8R0Se319mAo
X-Gm-Gg: AZuq6aJWPIBL2B/YrlMHD7O1INdu2ychNmHRht5mfBjrr72HTC9sC14m/I5FtGgNK/r
 izWmoKs602XkU27E5j0263JB4ORPsSIZz03fMzsbC/dBFfeu2vx+RRiAjGCfuAJiDqD6koiUGya
 ryTmvef6wxAEYILVw24+LYh643vQZhg/t5k8aJI+v8+DzKX+PKQ0K4QmQnxISSRiaFtVgEIJ+Xy
 RyBd0SQJTpz/WEP89lzZ5DfhLQ9cH/J4r3vKCBXh2ZpU2tDTX9vK/T86XZS25TfzW0UlKCCWYtN
 pXp05ig4ZY395gxQCOkPiqDynFzid2NBOegSbWCCqqcnNs/h6udLAoJxLSJ1La+HdmKx9/WxXAP
 EbiGGQMLRQ4hlYRVHucuqKHoeUAb1f8qfytYzosaZcdsGvH1JkCBjeeihAyRDYKtsP6MyTL1M6C
 EaDJ+j
X-Received: by 2002:a05:600c:871b:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-48398ae5e18mr33799315e9.27.1771421239358; 
 Wed, 18 Feb 2026 05:27:19 -0800 (PST)
X-Received: by 2002:a05:600c:871b:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-48398ae5e18mr33798785e9.27.1771421238797; 
 Wed, 18 Feb 2026 05:27:18 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc85csm41619785f8f.22.2026.02.18.05.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:17 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 14/24] fuse: Explicitly handle non-grow post-EOF accesses
Date: Wed, 18 Feb 2026 14:26:23 +0100
Message-ID: <20260218132633.29748-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


