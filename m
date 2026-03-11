Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4859A112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5V-0004Rl-6q; Wed, 11 Mar 2026 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5G-00045F-QH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5C-0005pL-Hh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1uWV43rQtyDdNMKHi143nhhRTg/MPJw8Y9ODC/0WLs=;
 b=W9G496rnGiRp+czmRHQpY753pUWzE/MkVYaw71cVhodpKetzXCLj5R+arTq3AOyK7u4VGS
 ZHOukmiuZMqAcMB6i3Jrg0ewV8QE7NAW8dAxGzvKEs0sd7puf1ofOO2SaNufqFvBIw8JDi
 yZM1VssY1WxVfYYpz8Cz3tAE9OayJkY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-txrW0ZfcOYS317ni-fxmOA-1; Wed, 11 Mar 2026 12:06:44 -0400
X-MC-Unique: txrW0ZfcOYS317ni-fxmOA-1
X-Mimecast-MFC-AGG-ID: txrW0ZfcOYS317ni-fxmOA_1773245203
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439a9182148so19333f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245203; x=1773850003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1uWV43rQtyDdNMKHi143nhhRTg/MPJw8Y9ODC/0WLs=;
 b=RZoqfvWAlcSk2BfMzdja8BZhaw9m1zpgB6NqPZwVE5XUqWJ/8XTLs8+IY6Y0BcyObs
 V8/p3e7dJbFbv/2g6hcI1HQSOMGtmwV01OWYkeZ7I/sd9zccVZgPTrkwIp623dnhmZfF
 q+IDgFEYqPJRSHAvLM6PImN9EYX7mtydeYrq4JKPHAh2wgYil9ZGVGH1CBOqmntBqc49
 +rzOq4va5SVXIlu8zncPg2P7CvbmxQaf99nDbp+kdYhb70iDeBzi7cRdUGSRp10ejLN+
 M1Wv9CjHuz7o/0rDEp+zGUSuvdIfDfq/kGpWjZx6sMstip8sJ1wv74wQ3W9Yd2nlg4N1
 7jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245203; x=1773850003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1uWV43rQtyDdNMKHi143nhhRTg/MPJw8Y9ODC/0WLs=;
 b=I/63Bjfu7g6OQTB/tIS9m5/u+kGe/aqvbPs5Y6jBJruj7ZAPU3Z2WSq0RFr7zRnL5V
 HDg1mJcORQRrhtbeJTan8rQrLtaPtRyPdR0gNDwsD9foUtzM3wGssMe3TvCChOujeTtl
 lKMY+2qxbeyxf4bl8W3yKsPrvwL+HKpejp2U0oSEB9c6GoleS87DoyTYN13jFMN8TfuX
 EQUDUQ6zmInEO0tcPQ6mR+T53rylIoYOQrxcnbuBPNysyMZZVZkc9ZyFHl4r35RwLQ4L
 Gi8xTGTDXJaDoKCk+3nW+VyFa/aO+4kOvADDO1vmQcxjs8pjRQ4zQ2L093wLF+aoh4qB
 JCZA==
X-Gm-Message-State: AOJu0YwJGoInT2z3njcKElgdb8c4ShaiSsc4JNQTkCieVEVfWGkAj6f3
 3vmTbtnTIlEyHeK6cVaBVRwsFXYXJ6+QE1nQFUty2EYSYWzxyJxJrZHYmlb+c8MhwoSLadZpr06
 /f2w0iioJO8PijQk7TX9Q6z0PtIiJvFceFH02tuUOFzjBHCxtyMNqcz7F
X-Gm-Gg: ATEYQzyHffWmpdYJx7G2viXW2xmxhtvhrifqUeUO+P1EMwPB3Bx5yFXh3jLWlVN9jPg
 N5ZCwViGYE0YADpPZvs3TQ7nGyPWjWxVJQi3dMavF1lNY+19zrimytzOkFLoaNc6uJy47qW+DI4
 NgWRwat5TTphsLOLqNDOIw8kKd1hek9z0y1D/WLPgAYDStFxi58YbvOZDlNSlXxguawvJfcWT5I
 PW/K/zv45GH96Vr9M15/WuZdVcM2etsC9VeNgaRqCf2ZiZ5u4AiWiCcfhpCw06oPi80YksaXl8C
 VlfeuSvm3snGhgHTVhGx0a2h2410innKJWtiSK9rU+8u703SMb958ilmnp6UMSA5O6OvJ8I8Vid
 vJRDJmIXBWUrticfB4t65C8lLjTv3PqfjTUYD4vFuIdbFW32xWPuO4kX/ZbchLkOS5mSVPwLgFD
 k+N5mk
X-Received: by 2002:a5d:5848:0:b0:439:b1be:819f with SMTP id
 ffacd0b85a97d-439f81df05dmr6867289f8f.2.1773245203045; 
 Wed, 11 Mar 2026 09:06:43 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:439:b1be:819f with SMTP id
 ffacd0b85a97d-439f81df05dmr6867226f8f.2.1773245202564; 
 Wed, 11 Mar 2026 09:06:42 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2187aasm149198f8f.30.2026.03.11.09.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:41 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 3/6] qcow2: Preallocation: Do not COW after disk end
Date: Wed, 11 Mar 2026 17:06:25 +0100
Message-ID: <20260311160628.344838-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
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

When creating/resizing an image with/to a non-cluster-aligned length, we
currently implicitly COW the cluster tail after the guest disk end.
That is unnecessary, but more importantly, when creating a qcow2 image
for a pre-existing external raw data file, we should not write to it
unless data preallocation was requested.

So far, writing to the data file past the guest disk end during qcow2
image creation may just be a peculiarity.  But this series will make
qcow2 use the BDRV_O_NO_IO flag to suppress taking the WRITE flag on the
data file during image creation, to allow users to create a qcow2 image
with an existing raw image as its data file that is currently in use by
the VM (i.e. the WRITE flag is unshared).  To make this work, we really
must not write to the data file at all during creation, unless data
preallocation (falloc/full) has been requested.

(The comment added in this commit therefore primarily reasons with the
use of that flag, and how we must not break it.  Admittedly, that only
makes sense after the corresponding patch in this series.)

Note that this means that creating/resizing images with/to a guest disk
size that is not aligned to clusters will create a partial data cluster
at the image end when preallocating (except for falloc/full
preallocation without a data file).  I think that is fine, similarly to
how creating a non-preallocated image will generally leave a partial
cluster at the end, too (the L1 table).

It does mean iotest 125 needs to be adjusted, though.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c          | 18 ++++++++++++++++++
 tests/qemu-iotests/125 | 17 +++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index edf18630f6..2ab5a9e0f1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3378,7 +3378,25 @@ preallocate_co(BlockDriverState *bs, uint64_t offset, uint64_t new_length,
         }
 
         for (m = meta; m != NULL; m = m->next) {
+            int64_t disk_end_ofs;
+
             m->prealloc = true;
+
+            /*
+             * Do not COW beyond the supposed image end: There is no point, and
+             * it could break BDRV_O_NO_IO from qcow2_co_create():
+             * qcow2_alloc_host_offset() does not COW anything for the range we
+             * pass, but everything outside.  If growing to a non-cluster
+             * aligned size, it will thus request COW beyond the image end,
+             * breaking the BDRV_O_NO_IO promise.
+             * (As long as the @offset passed to this function was aligned to
+             * full clusters, that is the only possible instance of COW.  With
+             * qcow2_co_create(), it's always 0, so always aligned.)
+             */
+            disk_end_ofs = (int64_t)new_length - (int64_t)m->offset;
+            if (m->cow_end.offset + m->cow_end.nb_bytes > disk_end_ofs) {
+                m->cow_end.nb_bytes = MAX(disk_end_ofs - m->cow_end.offset, 0);
+            }
         }
 
         ret = qcow2_handle_l2meta(bs, &meta, true);
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 708e7c5ba2..8213de012e 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -172,10 +172,10 @@ done
 # Test image resizing using preallocation and unaligned offsets
 $QEMU_IMG create -f raw "$TEST_IMG.base" 128k | _filter_img_create
 $QEMU_IO -c 'write -q -P 1 0 128k' -f raw "$TEST_IMG.base"
-for orig_size in 31k 33k; do
-    for dst_size in 96k 128k; do
+for orig_size in $((31 * 1024)) $((33 * 1024)); do
+    for dst_size in $((96 * 1024)) $((128 * 1024)); do
         for prealloc in metadata full; do
-            echo "--- Resizing image from $orig_size to $dst_size (preallocation=$prealloc) ---"
+            echo "--- Resizing image from $((orig_size / 1024))k to $((dst_size / 1024))k (preallocation=$prealloc) ---"
             _make_test_img -F raw -b "$TEST_IMG.base" -o cluster_size=64k "$orig_size"
             $QEMU_IMG resize -f "$IMGFMT" --preallocation="$prealloc" "$TEST_IMG" "$dst_size"
             # The first part of the image should contain data from the backing file
@@ -183,10 +183,15 @@ for orig_size in 31k 33k; do
             # The resized part of the image should contain zeroes
             $QEMU_IO -c "read -q -P 0 ${orig_size} 63k" "$TEST_IMG"
             # If the image does not have an external data file we can also verify its
-            # actual size. The resized image should have 7 clusters:
-            # header, L1 table, L2 table, refcount table, refcount block, 2 data clusters
+            # actual size. The resized image should have 5 metadata clusters
+            # (header, L1 table, L2 table, refcount table, refcount block)
+            # plus the data.  We round up that data to full clusters for full
+            # preallocation, but not for metadata preallocation.
             if ! _get_data_file "$TEST_IMG" > /dev/null; then
-                expected_file_length=$((65536 * 7))
+                expected_file_length=$((65536 * 5 + dst_size))
+                if [ "$prealloc" = full ]; then
+                    expected_file_length=$(((expected_file_length + 65535) / 65536 * 65536))
+                fi
                 file_length=$(stat -c '%s' "$TEST_IMG_FILE")
                 if [ "$file_length" != "$expected_file_length" ]; then
                     echo "ERROR: file length $file_length (expected $expected_file_length)"
-- 
2.53.0


