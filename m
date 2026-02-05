Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2952FE9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0ei-0007nu-1s; Thu, 05 Feb 2026 09:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eQ-0007lr-Mh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eL-0004Co-91
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rmSCRaAh/QmZON38XBXZLIptMu9K4kVvhHupa/JoYQ=;
 b=UKtUk5iq07rMcthD7ypaokyYhQ2ns2pqr5LSdgZeSIjB+DGCCG14bGfJqEtkHmcC9RJAXT
 v/FvDoFdVqLn6HHWHn8y1mhvk8105qVyMjmgK23OhjAFLawKTyGP9EFxju6beSdyH0Xa5O
 IL1Pg3rV65c3q+TlCyr+GVtsskT4+9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-VgSjyxkDOLazjAnnHW_q5Q-1; Thu, 05 Feb 2026 09:48:03 -0500
X-MC-Unique: VgSjyxkDOLazjAnnHW_q5Q-1
X-Mimecast-MFC-AGG-ID: VgSjyxkDOLazjAnnHW_q5Q_1770302882
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so730620f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302882; x=1770907682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rmSCRaAh/QmZON38XBXZLIptMu9K4kVvhHupa/JoYQ=;
 b=i9w/ifeff/yQ0TLjfonO183TgocjGlaFdap1aCiEbxwN5hlX8mbn/oN+Z9QwhtW4ND
 9g5vKyI6zamycQWUIN4TjbvSA1tVkZPTHhn094Df49BEvsR5uURg4eTkQW2H2Rp87wAL
 okcjzymx8xtJQBnCN2NsddOTHlIPKOHdAoGjcq9DTGr5IpFoYePH7jbr6d7LzGxpDGoD
 jjX9crJum204C5/M2lKK/RdCDQ7O/qwzztUTzAb446xWTaxBu8fXQ7c0l/Kh9qFAi8U/
 gzHHLh6hHVFquzZ6QtB/zkT48bvvdPWutT+BNbd+VJUStRRSHn024EpfZzsqduTsHc4v
 9ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302882; x=1770907682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7rmSCRaAh/QmZON38XBXZLIptMu9K4kVvhHupa/JoYQ=;
 b=U/P37hK0aNkjlaiCHuukoFr1MVm/7xyl7HetKCWEEheEo7KVyAfWASfB46eRvqc13a
 7+LZEPReCb4FB5weEAGsHRsMp8DhU6/zVPleb/ZbS1Gm2WAHQ2Bj2+/dUUOoD/Hfnm8f
 b7XKNTQ8KMBOF8Y+Nt4lT6yBhR59LodqsgKIyXM0apsszOOwAA0wB2CaK0Lf2qBB2xHd
 HvwY+iyxAc7MUmEN3GPKbDCpRXqri77ADEZhrdiZ7EPyzPtmtmOvqfbvU1+WELmCrdUs
 BxB7iWbmKpXmFWphq0Cmnlgv2tlxDA+fsq4oZ4WmEbzNUpY+4NeTGFeCd0CkbL547nQ5
 A3zQ==
X-Gm-Message-State: AOJu0Yw349eY7ZazpKyY5p8rjQpiU7O1GZc2E7pmA0pzsxbohX/esIR4
 i25AOaS6YrVqtbcSuLQattaX2gJnEiIMgMh+6jEuxO6KF4Yb0Dq51aO0TjI+s97Dn2qN0MnYWL7
 mZHMQtTTfOc1aNJ1qZJ8gAIXy962bt3dtw6561Z4AxAMN4YBUANdLN6q5
X-Gm-Gg: AZuq6aKd2plqB5hRFiOjfFv+fTN2l6jMuDklEtkzmRIrj884koTpovy3CyQK7ZmsbiA
 8ODiPF8O9IRAqEvmo0JCsm8qJkNmVFCFWS7SJPN0Tx18q2NLLYJedzQJUFcQq1BvRGM/F9wv9pC
 54+O+rI9VY0/IZgOX4ALPNEgHi+SwRrXhSku4PmdEOPAazMIgeUoihIvUDRD48g6bft58M7oipE
 c7+AfMja+Jx7ig9rPNU5j33onRV6KGQL0NzXbq+U+WjZWf9vdvUQs1h7tpeX16rH0z2fnbXk+vP
 4Ze9sOuNQk++f3FdQM/NchKuJzh2x1oUbNMhdcyD3S9w6Jqr9mIKU23vdRmnNFJ74g+bRs5M4vO
 grbJ7Fh2G0+aApllKZ7Jntd1QZANnslfwORk25HNVjkuwHs4GfFQGboV04ptglXXUkPCP
X-Received: by 2002:a05:6000:2011:b0:431:808:2d32 with SMTP id
 ffacd0b85a97d-43617e39901mr9649320f8f.7.1770302882113; 
 Thu, 05 Feb 2026 06:48:02 -0800 (PST)
X-Received: by 2002:a05:6000:2011:b0:431:808:2d32 with SMTP id
 ffacd0b85a97d-43617e39901mr9649287f8f.7.1770302881645; 
 Thu, 05 Feb 2026 06:48:01 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805f8b4sm14265607f8f.36.2026.02.05.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:48:00 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 3/5] qcow2: Preallocation: Do not COW after disk end
Date: Thu,  5 Feb 2026 15:47:33 +0100
Message-ID: <20260205144737.31131-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205144737.31131-1-hreitz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
image creation may just be a peculiarity.  But the next commit in this
series will make qcow2 use the BDRV_O_NO_DATA_WRITE flag to suppress
taking the WRITE flag on the data file during image creation, to allow
users to create a qcow2 image with an existing raw image as its data
file that is currently in use by the VM (i.e. the WRITE flag is
unshared).  To make this work, we really must not write to the data file
at all during creation, unless data preallocation (falloc/full) has been
requested.

(The comment added in this commit therefore primarily reasons with the
use of that flag, and how we must not break it.  Admittedly, that only
makes sense after the next patch in this series.)

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
index 69d621e9bf..b601bd540d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3368,7 +3368,25 @@ preallocate_co(BlockDriverState *bs, uint64_t offset, uint64_t new_length,
         }
 
         for (m = meta; m != NULL; m = m->next) {
+            int64_t disk_end_ofs;
+
             m->prealloc = true;
+
+            /*
+             * Do not COW beyond the supposed image end: There is no point, and
+             * it could break BDRV_O_NO_DATA_WRITE from qcow2_co_create():
+             * qcow2_alloc_host_offset() does not COW anything for the range we
+             * pass, but everything outside.  If growing to a non-cluster
+             * aligned size, it will thus request COW beyond the image end,
+             * breaking the BDRV_O_NO_DATA_WRITE promise.
+             * (As long as the @offset passed to this function was aligned to
+             * full clusters, that is the only possible instance of COW.  With
+             * qcow2_co_create(), it's always 0, so always aligned.)
+             */
+            disk_end_ofs = new_length - (int64_t)m->offset;
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
2.52.0


