Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701FC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fB-0002pg-5Q; Thu, 03 Sep 2026 10:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ey-0002en-UD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ew-00040d-EL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so22543875e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446600; x=1789051400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvawrBNstr38t9qdVqlJQ3pT802/IPUF8hZaymEalgQ=;
 b=k6Ps9wE9x8/eNi16YNyyx3YPHs9LZxjXhUIzo23NoYOvOKvQsY0F2HcmxYhurWHOI8
 qu7B1yjQw6r35Q9jMPOdkjeHvqOR7ZSYgthlVsCIthIPrsozVsYPoq2FcDDnKlFi13WQ
 IX823OxrDzDpN7cpXqLNyRR5n9mbvZLuR5Yrv2sz6Cp9OHwQMojShXoZ5gIWr384k7dA
 TJqZxWHxh/yc+e7NQKy/1NhtgTt/54rcUJq8pSKgt11//GzHgU4odgmr9YaaZjIibmjJ
 VPfqmBFx+0glpii1p1RjodmMd4+mCRSoF9rdGQkQxS22BrScdY/TFxbVYsDb8QcW2iar
 eUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446600; x=1789051400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvawrBNstr38t9qdVqlJQ3pT802/IPUF8hZaymEalgQ=;
 b=dRHB1fvHzGAGFrFBZ+s/CkFJnpi+4hKzWtfkExCSe7bdfauGDLOht/Vdzvr9Iv7JfO
 1aOaaFnOyLRIQH7QK5aHVNic9rN8D+i8v30e3KyxGLNCIkmdiRvTIGNV5ebYh0YY7Y/7
 8FdqeQMeNs4wg2+uZPhiFmAqwnuVbykrwZLKe9fHCoGY/FKKo1NxCtaaxDboJlxIKtM0
 mwoZnqMYuEw+d/XXU2sBwxDCERw+xZnPUrkqnppv7iY+f/6dhd8Rnko97lqJKwNK3Ou7
 5A3OHcinw8ByR1/yJyCVaZL0RZCS0po68EfS+t+Cra7LgkfwjZnWtodqAs5D0j3SvwMv
 TukQ==
X-Gm-Message-State: AFuF++kMuJv+kknLzvPhp8v5s12naFTMzlQJrlTeyed8D4kZTXF1roVa
 Zw4nUd8K5DDBO9OED43vCB8JJVM4gktNdFHgy9cRbDd8tOg54+07A06qIbI22wfPGvBglwqFy5E
 fB//L
X-Gm-Gg: AYBFou2eBoh5NOaTyD4MxS0S4PlpjAgdq68jGGH3zjz/fHg1F53mlZjSW582jLhHhhS
 wXfQ6BAarVZG8N11WOKTK7znPXy7U6ykZqCaeZV21riCbFncb34CYnT6O+6OslHL5hJCKtsWZlt
 tckZQS85eV1YmMU5uPY1sTg1lurqerwgqAD/SauEmic9ffDbgF6/pFgaCd7uBuG6EIxGV5lunmM
 wBXNstWjCS3q/UlyKAmkEHD4rJZ8M9qTo+uwYtEeAM7qDgwR5yQWDeCHoibA1/0Ok1DSC+IctOA
 y9io2l+UL1DZ8Wz4l/hHWgFJH6vFlAx2X+vToztk/5XStqWvUJ3FwRqfAmiCkdAK7IJWureTs3t
 k11edg0o1AjrDcHM73FKiZgkgRfPJx68LDXVt1ijIHAwOmd/jxNQMaFh/aHcuNhad8Z+p4EJ0GD
 gCYcEsGrDkGJEFI876OsMgHada9oLMiNbja55lWZo6oh/OduBGnpgfVBXV67J0cLBJ+2zk
X-Received: by 2002:a05:600c:8b2c:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49ce5829cc9mr266427565e9.12.1788446600381; 
 Thu, 03 Sep 2026 07:43:20 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:19 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 07/25] parallels: do not let the check die on what it is
 meant to report
Date: Thu,  3 Sep 2026 16:41:25 +0200
Message-ID: <20260903144143.2328870-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

parallels_check_duplicate() sizes its local bitmap by the end of the
payload and asserts that every BAT entry fits into it. An entry
pointing at a cluster which runs past the end of the image file does
not fit, so a plain 'qemu-img check' on such an image dies:

    qemu-img: block/parallels.c:843: parallels_check_duplicate:
    Assertion `ret != -E2BIG' failed.

A repairing check survives by accident, as
parallels_check_outside_image() clears the entry before the duplicate
check gets to see it. There is nothing for the duplicate check to do
with such a cluster anyway, as the corruption has already been
reported, so skip it.

The answer parallels_mark_used() gives has to stay out of ret, which is
what the function returns once the loop is over. -EBUSY for the
duplicate this function exists to find is left in ret whenever the last
allocated BAT entry is the duplicated one and the check is not
repairing. 'qemu-img check' then ends with

    ERROR duplicate offset in BAT entry 1
    qemu-img: Check failed: Device or resource busy

and prints no summary at all, so the corruption it just found is
reported as a failure to look. Keep the answer in a variable of its
own, as the only errors worth returning from here are the I/O ones,
and those leave the loop where they happen.

The tests write two clusters and damage the second entry, one by
cutting the cluster in half so that it no longer fits the file, one by
pointing it at the first cluster.

Fixes: a398275e88 ("parallels: create mark_used() helper which sets bit in used bitmap")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c                             | 12 ++++---
 tests/qemu-iotests/tests/parallels-checks     | 33 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 34 +++++++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index c96bed5ed3..cacf23143b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -872,14 +872,16 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     buf = qemu_blockalign(bs, s->cluster_size);
 
     for (i = 0; i < s->bat_size; i++) {
+        int used;
+
         host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
         if (host_off == 0) {
             continue;
         }
 
-        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
-        assert(ret != -E2BIG);
-        if (ret == 0) {
+        used = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        if (used == 0 || used == -E2BIG) {
+            /* parallels_check_outside_image() reports the -E2BIG one */
             continue;
         }
 
@@ -937,8 +939,8 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
-        if (ret == -EBUSY) {
+        used = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        if (used == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
         }
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 99af4c5f52..cf90eaf152 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -335,6 +335,39 @@ echo "== both of them survive the close =="
               -c "read -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
               "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST A CLUSTER WHICH RUNS PAST THE END OF THE FILE =="
+
+echo "== write two clusters =="
+{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" \
+           -c "write -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
+           "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== cut the second one in half =="
+file_size=`stat --printf="%s" "$TEST_IMG"`
+truncate -s $((file_size - CLUSTER_SIZE / 2)) "$TEST_IMG"
+
+echo "== the check completes and reports the cluster =="
+_check_test_img
+
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY =="
+
+echo "== write two clusters =="
+{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" \
+           -c "write -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
+           "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== point the second entry at the first cluster =="
+poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
+
+echo "== the check completes and reports the duplicate =="
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 51eb3f1ef1..645c4b3679 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -199,4 +199,38 @@ read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST A CLUSTER WHICH RUNS PAST THE END OF THE FILE ==
+== write two clusters ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== cut the second one in half ==
+== the check completes and reports the cluster ==
+ERROR cluster 1 is outside image
+ERROR space leaked at the end of the image 524288
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY ==
+== write two clusters ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== point the second entry at the first cluster ==
+== the check completes and reports the duplicate ==
+ERROR space leaked at the end of the image 1048576
+ERROR duplicate offset in BAT entry 1
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 *** done
-- 
2.53.0


