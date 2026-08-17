Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A5C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2al-0000C6-5x; Mon, 17 Aug 2026 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZA-0006HF-F0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z6-0006Sb-1H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so19824165e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993205; x=1787598005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bnodjSAzjDULOoHrxt/3zq90Ldw0LIHvEoopbIGCwKk=;
 b=jCeEXwSG0umwEjaipDtmeMhtq7I/k923OTWWsPs0BSTrnou6UXdeJGNwqMKLJ06byx
 Pfem3j1DhOxxru0YNhproDk+h6FvlCMXieHE5n0R9cCHbOmvJGrJfM3/K3GeslC2Y4+7
 +qXjJAIp6eNzcO5aXxhwl/bBOP3UylVxAqkVelo5rz96VKQvIuR4iHz3D1tSjRkLt/Pi
 fqI5/oDf8INweSvXqMSy/K29rS0Xx65bV1Rzefnm5qJeoNBeOVKq5WsPjOT8OBk8CLtR
 aNQR1wn3ntrYpi863SOlLHwF8nB/8RYHd4ocByLLzcFidAKBz+iYUrfeb7yaXG5eLRc0
 cSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993205; x=1787598005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bnodjSAzjDULOoHrxt/3zq90Ldw0LIHvEoopbIGCwKk=;
 b=Wn/zIy/ja3aG0pTkjsHAYAOZOHVzU6U4OCHil8dfcOJz8Re5GiWKwhVVMTkWCdobPr
 jlfRuR6aSgno3YgZoJIjFxg+Dn8TlVH5BB7sJgcMLtpVZxja6E0c0w4c1T0PxYhBGtYS
 DEqkuuMN7weY0ybFGs9ax/4gw6aKhOa7aNZV7qb4vvBAmh9N5SuLgBUl7QyZrXvMAq8F
 ialh75xw+Knt1ly0qrUbzJksEFRDIcKWt5Uz6MSj2ply+kv05QAVxRhXgtchTRkJkpGy
 V1A4tmmISqPyorPvdbkE/+hQBEvRFvaHAfkVmwCzgLz/J6mb76fFM9Qxy4Vz+pVjGGBZ
 E8vA==
X-Gm-Message-State: AOJu0YzmuXnHwmA20Jni/hUTvEoTqRGqc41f3bUpwEbS/on3w5pJNSml
 Gy/YLjPX3fl63CTs2caAk4BEmKP8+Q/NzZMZV5fhsRNIu1LzwIOzXdNUvPrpqO/W5WGGmd2aDUB
 dRIKV
X-Gm-Gg: AR+sD110E+h74VF7BfGLnqA2N6R1FQJRxG6zjsOGlZDWafLCeapnCAdq93XYsbQyFOG
 zEZLn9v8w1DoKxmnk+EVvgwxMsQoiplo15Yx7dSulCJ6qTnV79wMFfUl1w9tHy9Zn4RTAy+p2V9
 s5d+ly50kh8aS5iMngJAhYTPw2OBLgPocL9t6pxxYJWnkpoD5AlIOOB5fiFWk3joL9/F79uIST2
 3gLNPyps3ufcF/NJh4lSITt/NkdUrnpLjM3D/Thco6CNOLXKbpaPG+Rvwl1cdTYa+VBzuKaU7Hu
 V5hx5v+N1pPGvWXpw3xxkz4i/7Um8vX3nRmLoDMU6dgSy5eo09bxoUebkUhVmpfKhBKoYlIY662
 w6Fw99iW8T+7jCgEmSvB3WW1N01Zi625aAaW1IHCirO/JoFBQuNDlLcEXIgz9qe9LziNN/PYqZU
 B48XN0p268l7OO+w3btv/OEJtfDy9a6DDbiOJ/yAL7lXoJAra4Sg==
X-Received: by 2002:a05:600c:8509:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-499879337acmr489135255e9.5.1786993205196; 
 Mon, 17 Aug 2026 12:00:05 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 17/25] parallels: do not trust the bitmaps of an image
 which was not closed
Date: Mon, 17 Aug 2026 20:59:34 +0200
Message-ID: <20260817185942.1065143-18-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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
 block/parallels-ext.c                         | 13 +++++++--
 tests/qemu-iotests/tests/parallels-checks     | 27 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 17 ++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

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
index 6f60fda62b..916d423a64 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -414,6 +414,33 @@ _check_test_img
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
+echo "== a read-only open still reports it, it is only inconsistent =="
+$QEMU_IMG info -f $IMGFMT "$TEST_IMG" | grep -q "$BITMAP" \
+    && echo "still reported"
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
index d40f865868..4dfadd68d6 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -268,6 +268,23 @@ read 65536/65536 bytes at offset 0
 file size: 2097152
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST BITMAP OF AN IMAGE WHICH WAS NOT CLOSED ==
+== add a persistent dirty bitmap and dirty it ==
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== pretend the image was not closed correctly ==
+== a read-only open still reports it, it is only inconsistent ==
+still reported
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


