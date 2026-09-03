Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48607C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f9-0002oH-Q6; Thu, 03 Sep 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f6-0002j7-P0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f3-00043q-Is
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so22545375e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446608; x=1789051408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=m5RhOWR/mD90D/6RYfTEBh1iFQZutIaS/zK/vaQETRriR511TDoVGhQvVSvPX8wywh
 i3AdZ4yzwrTggwS6IzI6pfin4RbifTi9WWfvSraIivcmrKJrezMLUyqNZ+AQPZTS3p5U
 lTse+CKKD7mBucPdih4ouw1hNvVs3Hxw3INrfq3tNz41uQkVNJyZtTaTFXk/uHe2zfwZ
 HTY4A2lKzhJ6Wm4NIQHM3oOlgEDk9zgGMzPum4Nod0I6buUX9hmnwyyNozZOVXiWGQ+G
 SSWcHIS+GVLU4fv3vcFqpMRWpIRm/ktMy7AFNHdPlIaaxRFFhpcp1xa8cfJSIrMquMgi
 19TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446608; x=1789051408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mGHyHtBjiaIzmCNt57RsevzZuH4XsgPjyN0SdYM+JtQ=;
 b=Ff47fkWhbG4kCuaEuze1Avr4lRV9f9uGQaAtDBcpbbZ5Xd+sJyI/sva23zON85Jw7J
 Ip8eSSfyGu0oxq7xk0jHMTNgO7PoPQa4SKU0hmxMFUvOwcqxSERNPZc2n8xl7QhyBwMh
 avp5x/Owxxu+Nd4CZn4XYr5iFVXvie4r2hUUPolNnVcLtHsRn8Lx/GrZh1cRvMXETSjL
 DPLeV+00cmNNpT27Sd8Fi+vyiumbuANB6WOUuLPMaXjUxvvNhZzzqlvVk4sZDt+uhQDc
 qMVwltsBCB3cQq7V2WKmUV2nUbOt3/VO9WIWiCAQGpDw0CkAQ92DsQuYOIg7BrTqndyu
 Ojbg==
X-Gm-Message-State: AFuF++ki1KI5W4BAJAiyiQuW0R5JNRH5jclcBYHYd2GcvuvgPd/xis3Q
 PWSZRG2WSmIBmU7zhV5bO+sK99NLK6dEZ+2D4QcNUmJSjJ1J+vjaUYOM8kQps+8+w5NogfGeznc
 XdzCj
X-Gm-Gg: AYBFou20dI2yXKwZUerqrVHEiTqeYXHzjNC8w5An5/jj7xyPIG04TLN3wlk1ZwZanSa
 wYVTr64EfeoGjV4eobBjegkD294m45f7lywrMg2n3KRutxBL91mxaGGYEWTeA+jPAG4GwGNJUMI
 6eTJCucqw7aGxncqnZ/LQdfw+8Ddvi3BtwVOZYQPwUe3gpUyaEYSh9pw4dCD2QTGghSFZPYh8MR
 pz1zOsXE5zg1GReMGs9csXIm97qLD7i1IV0i7eUA3NFm6OO3S77+k9NZ91f5xKafi/qF2L2hNdP
 G1Q6x1qMZ9j1HL4whcnMDMxvq7CqACjLoMT7Xr0XIeWRuZ99cMOAM8ZtC/heJQf5y4pvRj2hUDb
 9nSCwEWxye5vJFGDKjgrRvLWtKUkNsi9ql0tyZUMYS+bkZaihOVWUtHVVNscA4TsGR+rL6hIkZz
 kyzvpTgS5DZiXkxagEL6NTvquhG7dXMd4YAALqWcF1MkwRIIQGzbAiMLZl
X-Received: by 2002:a05:600c:6217:b0:49c:f3dd:e166 with SMTP id
 5b1f17b1804b1-49cf3dde195mr67253335e9.13.1788446608111; 
 Thu, 03 Sep 2026 07:43:28 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 14/25] iotests: cover the Format Extension against the leak
 check
Date: Thu,  3 Sep 2026 16:41:32 +0200
Message-ID: <20260903144143.2328870-15-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


