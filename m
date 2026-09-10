Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25682C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pwN-0003xv-DW; Thu, 10 Sep 2026 21:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ7-0001lx-EL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPz-0007HD-Bw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so3085345e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083776; x=1789688576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhBHv/IsAV3MCNTeGG0bhvIWIurVdnd2SebTco/6Ixo=;
 b=caFJLeInJyvRVlxbo97whX/gslJm9IkQRLBjIs8cyzaT2yaRwWGaA7/njdo+AZfw17
 OpZVJdpIsdPyhoxD1jFE4OtjhfKO2IPH2Tw16Pjdx89EAlhAch87N0+gt34PozZ1iGqj
 dN9Ue9TmYm60F0dBxQaQ4GCHRB0jdp8DZCOU6LTr99L/p1+F+YgYAK03EIGdMzUo0TEh
 1TPF59zEkSuQkfvq+vi28NNPlsPv4WIzarxDO7sZN+QcZ66jqcO7LvkP8GuZ4iGhk4pV
 cy3GjszAD2Wn9h/B9zzDJfqEXmyQnY+V6XE6h2Ql72MDBQdx0aOeo5EKUlgIpfZWPp0j
 QvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083776; x=1789688576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhBHv/IsAV3MCNTeGG0bhvIWIurVdnd2SebTco/6Ixo=;
 b=Rl/2oR0JhJ60+T+wgj82+udRV/6Z6aQQ9zcLqifcGa2EQMFvqdwWQYd/y/K9zvJ/KK
 tQ7rmoBJfAocj6ULQ34Smje2OwQxocc19iGS3qmj5V3jOexEWf+XQVAuOTs7KXLh1vzZ
 wU2kMGhlp6ojVmJJhUCBfaQimtfbW01LKWoNDnSu7lzK6P0JxdxOIn11CQFADkhSZgjI
 MLJXiobaND8Hd6hW6MHcphiIq6Yzf77WUibF0B+vYu1rmkCI469hr+1gu8IEGQ+sTqrJ
 KSs2psZ1i+x0lt7SVoJ+MckCSn3E6Ps7kOgk2WykVnG4O95uHAJEvr8Ea3JYq6TDjpgY
 rQkA==
X-Gm-Message-State: AFuF++k17wcfV5pmy3Z1GXT6bF75tuG0p8W63doiWPv2sUWOKjbfR5xt
 fIkJWIFIYAtVbrWVFVCElZ8SpR4P/ZhvtQhNiajr2wcdWZLxGD+zTsSCG1px6Ji4ihY=
X-Gm-Gg: AYBFou2solu6u9jPUojIo0+bTBqhqZuomRwu6b3MIeOddxRt+Kbzc4Jg5BB6H1GkL/M
 PLSmE73NPeeFCvlfJnpxmZFL5vSMybdSLCBVGrxlH7p6E/r98L4cy0GbUTio+kVg2xbOtM5947B
 kSWMtUgJW2DHLjS4nvlYXWyqcEntWC0BwHl5WOOPscghd3v1PFhVnVHHCImmcLGzwP5Ob9YnryQ
 /Pi5OUA7n6JLe/Foj+NUhVLSFxfzNifGFsQJwtLoMIvWSz28tPMY2OKqeaJ6RS4ZwSUy87GTrt1
 2ZMTqDurazj5cg++00oga/12uJaurFtr3VC5X1y01BxUp7hSvG2ooHnsNgvNDUfPalE+eXTr6is
 lsGLR7UmFEI/Q3m7iKAiOpfvhfhhxQDMDPS0GhGa591oyraKxzjka+rARbo5FeYFY6+oCTsQs6G
 PTcxUBGErknkO9i6SypPSUDSsaNaH4Q2Xm9BLToTnPM1MSzpupmgNGrl0x7q7gJ2u3YCpt
X-Received: by 2002:a05:600c:628c:b0:49c:fc7a:22d5 with SMTP id
 5b1f17b1804b1-49e6188840amr15147475e9.4.1789083775932; 
 Thu, 10 Sep 2026 16:42:55 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 24/29] parallels: do not trust the bitmaps of an image which
 was not closed
Date: Fri, 11 Sep 2026 01:42:17 +0200
Message-ID: <20260910234222.3039975-25-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

The inuse magic in the header says that the image was not closed
correctly. The bitmaps stored in the Format Extension are then stale by
definition: they were written by the last inactivation, and every write
which happened after it is missing from them. Nothing said so, the
bitmaps were loaded and handed out as valid, and an incremental backup
taken from one of them would silently miss the data written after the
last clean close.

Mark them inconsistent, as qcow2 does for a bitmap whose in-use flag
survived a crash. Using such a bitmap fails with an error naming it, so
the loss is reported to whoever tries to rely on it instead of being
discovered later in a backup.

parallels_save_bitmap() already skips an inconsistent bitmap, so it is
not written back. The format has no per bitmap flag to record that the
contents are unusable, so keeping it would present it as valid again on
the next open. Say what happens, as the bitmap disappears from the image
and 'qemu-img bitmap --remove' would report it as missing afterwards.

The image data itself is unaffected: it is repaired at open as before,
and only the bitmaps are dropped.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c                         | 13 +++++++++--
 tests/qemu-iotests/tests/parallels-checks     | 23 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 15 ++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 17445d183b..b7fac2514a 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -335,6 +335,9 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
                 goto fail;
             }
             bdrv_dirty_bitmap_set_persistence(bitmap, true);
+            if (s->header_unclean) {
+                bdrv_dirty_bitmap_set_inconsistent(bitmap);
+            }
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
@@ -417,8 +420,14 @@ static int GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     QemuUUID uuid;
     int ret = 0;
 
-    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
-        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        return 0;
+    }
+
+    /* The format has no way to mark a stored bitmap unusable */
+    if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        warn_report("Dropping inconsistent bitmap %s",
+                    bdrv_dirty_bitmap_name(bitmap));
         return 0;
     }
 
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 6f60fda62b..575b736e35 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -414,6 +414,29 @@ _check_test_img
 # Clear image
 _make_test_img $SIZE
 
+echo "== TEST BITMAP OF AN IMAGE WHICH WAS NOT CLOSED =="
+
+INUSE_OFFSET=44
+
+echo "== add a persistent dirty bitmap and dirty it =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+{ $QEMU_IO -c "write -P 0x11 0 65536" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== pretend the image was not closed correctly =="
+poke_file "$TEST_IMG" "$INUSE_OFFSET" "\x59\x6e\x6f\x74"
+
+echo "== the bitmap is stale, so it can not be used and is dropped =="
+$QEMU_IMG bitmap --clear -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+echo "== the name is free again =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+echo "== guest data was never in doubt =="
+{ $QEMU_IO -r -c "read -P 0x11 0 65536" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image
+_make_test_img $SIZE
+
 echo "== TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY =="
 
 echo "== write two clusters =="
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index d40f865868..f390ea90d4 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -268,6 +268,21 @@ read 65536/65536 bytes at offset 0
 file size: 2097152
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST BITMAP OF AN IMAGE WHICH WAS NOT CLOSED ==
+== add a persistent dirty bitmap and dirty it ==
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== pretend the image was not closed correctly ==
+== the bitmap is stale, so it can not be used and is dropped ==
+Repairing image was not closed correctly
+qemu-img: Operation clear on bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45 failed: Bitmap 'b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45' is inconsistent and cannot be used
+Try block-dirty-bitmap-remove to delete this bitmap from disk
+qemu-img: warning: Dropping inconsistent bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+== the name is free again ==
+== guest data was never in doubt ==
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY ==
 == write two clusters ==
 wrote 1048576/1048576 bytes at offset 0
-- 
2.53.0


