Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C20C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ar-00019H-Iu; Mon, 17 Aug 2026 15:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z8-0006CZ-CT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z2-0006Qw-AL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso29055385e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993201; x=1787598001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=Q/0zM8npu7fjZ7EDKB2hq2u6Qd6FT+5RlAmHucRBWs859u46Vn6xdnSRzpAFu1v79c
 xX6TPzWENjQ1HWrw9dSsN5hAO8eNlTNKelrL0are71SDisTYCOx+Dl++WpJWOptd5sOn
 rp6QqzIYnv2Idfac/h+QFQ9e7D4Cz7brxK5y/+8X+NWbTmDGMGddCdPy+0TS2WKD6zlo
 70O7jeszrlaqOi63mXXT/7GJfYE1PfhiE4lrKAS5RSJqR1lBqWj/5ZbsCsMUaAWy6Qh7
 ZHzYv+IQZgxFPZimawXzk8JOzghINm6mHpND/xRNN67rh0JPk8JBGQ3q8XdTJtg2jf03
 j4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993201; x=1787598001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=F8fSol2uyr6ir6xASm4WtVKGNWV6gTUbsEEOHB4YNtSn0tEACwjxrUcUJdJFVbV1wI
 ELXzR1M8GRhKaA2zRWneCfpSA52LEbyvP9dqJ0AX9c+sED4VtY+cXhzLhgsnQrVUX3f4
 RIo49ucFwtzUlAxa8TraVrWVxj56sUPG5h+DEn8jYUQBVI8Wolt773YpPAIUtUrIaqC1
 1B4dmg1ARyQSwLA4NK5GouFP8DsNRYLgkhMfwD3wZ598NMXaJTs4GOznaYa8m65cp9d6
 72Riz7v12LQ2F3lA8KntAgebTRqzk6SN8ZBv4r5vgu+bbneYE3k1aLbnixe4z+D3Pm+j
 1DeA==
X-Gm-Message-State: AOJu0YwOCHORL/gqfipySs7pJotnzWyl8Cs5VQyNNwysoMwPq4uJBnoq
 FtSE7vfgsBfeTlO+GpYcZ4KNPNXrYAJlfSYacGYS1JF77FttQUWvp5dg0ZB7zXSXZQ2Wc2Tjacz
 9YXlO
X-Gm-Gg: AR+sD11cIgcd6b2RcRzF+hMMK7pxFPdr07hJyBlLsv32gV5iCOXxH43y3zzKHnfXRt0
 Kt7aT2zYj/Rr2vVeIQDMIZGvunpJNAZSotiKsGWK/cpnzKURVHBU+7nIuOnMMDTOk0X5B8jEyxI
 DX7Y11RMl4mx6PwwvOMVs1oBDWlkBw8oQjou2fSk5Oc2yZA1IHG+GtSSIGpyu5LDZioGbLtYbFt
 O8jBLpVEFCdDSQuVu9ytK4imbWv20dGU7Q4xCYKupTtCJ6Vvx4q5kTpJDOc2dJXEcJMh0GuzB2y
 mjGLI//WM/vEuzZxENTEsDp5FOnmaWzAyljqX+nEvM/7NauXGavWMvbcDE3KyVZpKV4J48ZzH8b
 P4hEh6uKeS5a1jdD/pdY6vz2OgxpgcO2nywBktF1VB2Ej9zBG/LLniPiVxn5k0N81L/U4GCLS1u
 RcCGCTYVuWbrkCbaedj7O59pFYmlW9FTGj1XlcUoN7UjKegKjS+w==
X-Received: by 2002:a05:600d:8654:10b0:499:a07d:a482 with SMTP id
 5b1f17b1804b1-499a07da4ebmr20208615e9.10.1786993201380; 
 Mon, 17 Aug 2026 12:00:01 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 14/25] iotests: cover the Format Extension against the leak
 check
Date: Mon, 17 Aug 2026 20:59:31 +0200
Message-ID: <20260817185942.1065143-15-den@openvz.org>
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


