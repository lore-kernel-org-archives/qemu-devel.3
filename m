Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F51C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fC-0002rc-Or; Thu, 03 Sep 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f8-0002n3-U4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f6-00045J-Uf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48584dc164fso416328f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446611; x=1789051411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhBHv/IsAV3MCNTeGG0bhvIWIurVdnd2SebTco/6Ixo=;
 b=iGLoykumtWd8HxQtvCdZKoslAn8vBK2fVR4O8z02wap3GLvH1zcZZjjwVDNwvEWaeb
 Xh+qFdKD9v0xhXzGxsZAbydH8UNa8wPJOBn3ckuW4iDMXT9eKPMLPGOpAYuvwTd+fuk1
 AEpeV5OWLCAjHrcIsa3+xSzDdYs8bhW9TTH3zMsUTNAVDwZBaV8tT3+dzjAj2U03vkIp
 pr+NYwkQnL4lvC3NsE0+mIg+/WQnHFZxx4jZge4N37o7goqRNQLM+NxTq8Xmq8qP3Aft
 G/atTHwOn8VlCgaUtCpC3veVsbTfuS9o3mBGqGdVuSHE7+0DFEZHO0vA4fGK3nifmfHO
 7BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446611; x=1789051411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhBHv/IsAV3MCNTeGG0bhvIWIurVdnd2SebTco/6Ixo=;
 b=mzid3uid9C2Mw1IgWJmPc+T6NJxuUnBCqX+3VbGouPSrl6L+XtPYfGVnkXJBwORdqu
 mCgwxkm1AR9KPeI+8qyt7/uzK3CJarbV/K8m/vWs/dQPvmrMUaiaYiRoZUEyf8DRJDwp
 xaioFxkddu8ckg198ZSyeayUbSYJapjqa5XhZdGw43OqH/BoQ6AoM6RjiFXLMWRfVBYf
 KfjB9CIUTbkPy0MF6jqaWjo9bGYnPvN8o0y/veIo9PMpDJnU/nntrm/8bVqjqQswXeXa
 VQUFAD1gsYK7VSMnYJhuc5utUddEq8PjJZKs9H9z6z9jn4PgMABBWevCFdGhdfKCTGhd
 GMPg==
X-Gm-Message-State: AFuF++kSXFoelUa56PT/jHYqbyfR00nBNDhHTW0Ihov5YnCCtwZOnz8D
 KnKDvmC9FifBAJIpPMIVEXzbvJDj4XymaHlgXUyZtIq0ngFBGdmuS55HodIyMWygcK48rZO4qgP
 b8B3h
X-Gm-Gg: AYBFou1KDNq7VCTHngpPrflGTfKkX10Qs9KNBXofJCGPj/7B56SbSqTz3qT1AMHfhcG
 aPHqjRw6/Bl5nb/ygZO8E7bVWEHrUzzzTBz/51/2KgYmXDpQRvP3aFqkBtyF4Tsw17B/pbIGtLi
 779KzB3yAN6wadgiN0whj/fhTaYfLGm1m3lqGiPmloFBS/JRYJuJqqJRsRIu9OF7Kn5KDjXALJ9
 b01B7TQY4WsiL+2MVm9mfUxfODg5aRwENDBmk02UPG+uOWlo2IdoFBToP1A0WvfxCNY1GOchYA5
 iL5oizK2EcIkf10Nd7QQEuymUUugDxh8OUV/nmCRBaXDJxbVi6OupPib24Jtus2vfuEF4GLJfkH
 psbr4O8NzSlUBZl99HX08zSl1xNrzY1F5dRwBNNA9/R5cjYS7pQX5HTyoOlbWNz4N55Aii8OexD
 8JoXUTGnGunDJUJC8AMKTLdPCQA0byYjqD7RVaPsK0iMvNRJelNhVIPjcq
X-Received: by 2002:adf:e00e:0:20b0:485:85f3:7e47 with SMTP id
 ffacd0b85a97d-48585f380a0mr1768336f8f.13.1788446611167; 
 Thu, 03 Sep 2026 07:43:31 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 17/25] parallels: do not trust the bitmaps of an image
 which was not closed
Date: Thu,  3 Sep 2026 16:41:35 +0200
Message-ID: <20260903144143.2328870-18-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=den@openvz.org; helo=mail-wr1-x42f.google.com
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


