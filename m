Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7959C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ZT-0006Ku-Dj; Mon, 17 Aug 2026 15:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yw-00062O-TW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Ys-0006O5-Sc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so30996585e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993193; x=1787597993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvawrBNstr38t9qdVqlJQ3pT802/IPUF8hZaymEalgQ=;
 b=NS+XjIORujf9eZgXPxWa1DcIkmGY3QO4Hxyv7aNUEdTSP0bzIYbdD2GTyFa57PFTPg
 TSsqU5xJrC6GNnbbFv0AEA8nyWSvfO618/fJ0fDYrbk7VSEMZA1Rup9hIhb/kHNdTn1p
 hQcAgZhrp/1ybG+zwtuuKBdWqdN4blVx1ntxOtbFjKf//jMgaTcCKoRQ1/wGo2Fdq1Pc
 v3saDCOjnfGg5ovNtOThlEfseaerDN9igrxT6aLsPdTtIE8+QuOn7LhHgRxQxm2tpR4v
 +Si8qC4vqrXj7bx2SZHfv5dKc3THiSp/6VUWS5KU9TuevpdMNGdT4pf4PvQWhun9BUra
 WQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993193; x=1787597993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvawrBNstr38t9qdVqlJQ3pT802/IPUF8hZaymEalgQ=;
 b=TOwcTWuKSW8YiU9T9iOlFU5YsAhkS7GzHymp5RYZlEOtEPTkly7f1hrspOcCIGlIHa
 kQ/qC4KnCbfzs+JH+kdYkMIjNKnJEmL3djGkix1ltbWO3lameRBELtXEqLfZC96qgJsI
 tsZQIoJBMpKFNlA1OUgv+RYKKennOz4cpIlmQjFuoZYo5/tcWI78S+Zj6FLDUcLJhDm2
 F/LFNDl8VHqsSnaAJwv/Kso3LgJY4MOvqSS62UREnecOjsInpoiS2mZsV2PqONF5/E0K
 pDyc/7758jIMM9RG+l16Hv2H3YaFn1uHZIal3d59uogq4M+M89C1XUaSbu827OfikuGK
 6uCA==
X-Gm-Message-State: AOJu0YxHintFsD4YE70wzOrAck/VgClJZptc/927RAS6cHUejwDLLfWY
 E5LgQrqlCX+kwoKMiaatB/JWkn7ZYYQvUPcS3cngbsDxk7ZtX9guszTrB5y5quS33T+5SeINM8Q
 BxvWs
X-Gm-Gg: AR+sD12ZC/n79i+EatnWvGg0vyukECQ58FUunarptFyxf9+/eQrghuw6W9lQFN1ibBw
 1TXzMnPtaWy522zlUXx/sPBSLI6mRLE+ZNSuT9UZFuqWNixH9X/DY6S3zgeB/HhiMauPBqF82Ad
 MXlDf+4fXFCgj9RwjOyJL+iTCDQiEUZgbZZPS1jCG4EfsShCBCsB1eGhJlb7y78myagEkblIfpa
 EGmL6RTFelYn2Hov2x7ULc0z8GIbirm1zpDkKcRVbhXARaen/PmFWWdr347NwtnKPurmoJ8IC/d
 vjLyMuNlUj2aMLRvpb1+nfHRNaLULCFViMHNtn/9A2DhdB+C5CMkuSMTHUjSuM9GBjx2Aw/FH4N
 w3R9KkAIOgdAAC2MG3b9izYyeH93h74S4tpo0qK9F6I5QSkijoG+8A15HafZeg4bM2BjNqyYr0A
 787UHO6C7puTr4ZRApP6j4AIBhYIPx4RG24t7EtcbDQuFnJUn8zWViv1t5A+2s
X-Received: by 2002:a05:600c:5392:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4998795d6bemr432472575e9.11.1786993193014; 
 Mon, 17 Aug 2026 11:59:53 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 07/25] parallels: do not let the check die on what it is
 meant to report
Date: Mon, 17 Aug 2026 20:59:24 +0200
Message-ID: <20260817185942.1065143-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
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


