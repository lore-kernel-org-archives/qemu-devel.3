Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA02C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pzp-0006iL-8U; Thu, 10 Sep 2026 21:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQD-0001o5-R1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:30 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ4-0007GL-Ln
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:09 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so168981f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083772; x=1789688572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=glpyB4DxsS8ZWN5aIRdsqhP/0DLwU+xj9L5Ah6WnlWLgweVezaysk8qmjljDhhVY0R
 Tw8UcKBTHX1r6Qfd1haaduTZSUBsFfhSUX+/uKc7SprjVptMXgB+R3fSa9M6BYNtw/xd
 0hZEUt1Resff9JfWQuU9mtt/ZakjTYIOm/qkW+Dv9Rn3fCICPjKLdVG1zs0Kd4bnlm/F
 +/aHJyTub7PTR3gpehZYbevDMu4xphhzq4ayBZYDXVynaSWc+ydRSoggAIKdgFJrYHr0
 biuibFiJhWOIXNmQxUx34nb5nOqbbHGWXpKe87ftma8uGzNvwCPhyQMZy1wtiBJqGy65
 HJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083772; x=1789688572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=Yh1kFi1r/bkt6F6M9OZeZnSIwX/ryfTfzN6UTRApj2NJr0CuxHq39dQL/YSZUzIo1w
 UIjE1FcU/QiVwjmvdy68I7nqMM1R+YOyIUh382ditugzCzNCWypbpMbWkGw9O3W0vJ8b
 Ih5iml9iFTk0DlPiLwMJfg+CyDvEWmr0YxC5NTsWEyswvXAOd6Tqs7+CodptPFSFxFMq
 bUNOpW3Ko9LINp1FQZdf5yCeIHpbAsXSaKH6/kPpTHe9pNnHxR6w+splUhKilQX1YVOd
 pvLInTIGDBkdENo0zA5nllIa8qcxdiw4iZS6Tid9l49Jn+dz56hGQQTZJs9xlmU0p3EE
 1AjA==
X-Gm-Message-State: AFuF++lmE+rp6wUzpB/OSle0vmk6Hpy1ZbgKkJHdEjKhIBiY7IIz0FgE
 VvJtY+89D0GyhdGr/w2Mvg8N1gUHvyzDqdGnXqVVxmbsacGRlqhSrSRWI6yM8HSysls=
X-Gm-Gg: AYBFou3Da7ap9XM4PQsTtBy+8p+qtLFThNIloYh8cN437CHeBvfUdhJy7WJMfixiiRQ
 az7/cXDKe/wRjlWC/G6RGNRHDqG0jJenwsXrbCVD8cKxJuNYm+0CFqzBYBV4wYZIraNx1eXScvc
 eIevVHHJ7ziEvF0IGN/sxwvElfKvcWhvd4c4aT5McKMX2256K2clTgyYQ3jS+p8NcBBiCOQLY8S
 X4qD60Z9D57ZYNawSNzbJhkc7lp7CJduU0laemZLBQkVxObsaefqyu6qERLDgTp9NB1fBiErFpO
 ogt4Ae2gY8FItfozPs9FTItjtfhZjq/pMYuRtF8RF5pRmq9O4hXw4fGjy/Em/Rm/1Mw9Dyb3x9p
 +tA4teLyY9ZPmSoBCK8Mh9hGY3+XBAutF17rTt8SywWkH+8We4BRLmm2CyZ87NnqnTRA+BC/F6D
 hQNI4HazeQt0DcnXQeUbh3uQWgLmseD4O+IGERv+95zDvZGqmjzTYAJ3JmfVLW9m5S5CKxhw==
X-Received: by 2002:a05:600c:8518:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49e619acc89mr36624775e9.10.1789083772457; 
 Thu, 10 Sep 2026 16:42:52 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 21/29] iotests: cover the Format Extension against the leak
 check
Date: Fri, 11 Sep 2026 01:42:14 +0200
Message-ID: <20260910234222.3039975-22-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

The Format Extension and the bitmap data clusters it points to are
absent from used_bmap, so the leak check has to be told about them
through s->ext_end or it reports the space they occupy as leaked and
'qemu-img check -r leaks' truncates it away while the header still
points at it.

The leak coverage in parallels-checks grows a persistent bitmap, dirtied
one granule at a time so that parallels_save_bitmap() stores a bitmap
data cluster rather than the all ones L1 entry and the extension spans
two clusters. It asserts that neither is a leak, that a genuine leak
appended after them is still reported and repaired, that the bitmap and
the guest data survive the repair, and that dropping the bitmap makes
the space reclaimable. Without s->ext_end the check reports two leaked
clusters where there should be none.

A name which is not a UUID is covered there too, as the refusal belongs
to the same command.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-checks     | 48 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 35 ++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index c9dcd715ac..6f60fda62b 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -362,6 +362,54 @@ echo "file size: `stat --printf="%s" "$TEST_IMG"`"
 
 echo "== the first cluster survived =="
 { $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+_make_test_img $SIZE
+
+echo "== TEST FORMAT EXTENSION IS NOT LEAKED SPACE =="
+
+BITMAP=b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+
+echo "== a name which is not a UUID can not be stored, so refuse it =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" bitmap0 2>&1 | _filter_testdir
+
+echo "== add a persistent dirty bitmap =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+# A dirty run shorter than a cluster is stored as a bitmap data cluster
+# instead of the all-ones L1 entry, so the extension spans two clusters.
+echo "== dirty a single granule of the bitmap =="
+{ $QEMU_IO -c "write -P 0x11 0 65536" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== the extension and its bitmap data are not a leak =="
+_check_test_img
+
+echo "== extend image by 1 cluster =="
+fallocate -xl $((file_size + CLUSTER_SIZE)) "$TEST_IMG"
+
+echo "== a real leak is still reported =="
+_check_test_img
+
+echo "== repair reclaims the leak only =="
+_check_test_img -r leaks
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== the bitmap survived the repair =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+echo "== data survived the repair =="
+{ $QEMU_IO -r -c "read -P 0x11 0 65536" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== dropping the bitmap makes the space reclaimable again =="
+$QEMU_IMG bitmap --remove -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+_check_test_img
 
 # Clear image
 _make_test_img $SIZE
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 6699848996..d40f865868 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -233,6 +233,41 @@ file size: 2097152
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST FORMAT EXTENSION IS NOT LEAKED SPACE ==
+== a name which is not a UUID can not be stored, so refuse it ==
+qemu-img: Operation add on bitmap bitmap0 failed: Bitmap name must be a UUID to be stored in a parallels image: bitmap0
+== add a persistent dirty bitmap ==
+== dirty a single granule of the bitmap ==
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+file size: 4194304
+== the extension and its bitmap data are not a leak ==
+No errors were found on the image.
+== extend image by 1 cluster ==
+== a real leak is still reported ==
+ERROR space leaked at the end of the image 1048576
+
+1 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+== repair reclaims the leak only ==
+Repairing space leaked at the end of the image 1048576
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+file size: 4194304
+== the bitmap survived the repair ==
+qemu-img: Operation add on bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45 failed: Bitmap already exists: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+== data survived the repair ==
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== dropping the bitmap makes the space reclaimable again ==
+file size: 2097152
+No errors were found on the image.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY ==
 == write two clusters ==
 wrote 1048576/1048576 bytes at offset 0
-- 
2.53.0


