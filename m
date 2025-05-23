Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D64C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIVIb-0001R4-8o; Fri, 23 May 2025 12:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIR-0001Ov-Sa
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIQ-0006Xf-1s
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748017857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoUc7S9ZxW1OXHM9W64yjUiO4aEYPNW0PaKNrb+pmJE=;
 b=i0n+moES+Lpp0dup+cccTeXZiJX4i3gp/HrdLTmhgHGP4xg/icShdof+1/CouAwaLA8NoL
 WBKs3G+g+7KC29jkTsl/nlReCkTuBc2iVlpj4RUMiBBMnNDy+CAgRJEMcYUxsk/UwWTQyc
 4K4IihNQPUbf3dvxU+9J/nycjszUJ2E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-qWMerglCPWCABqEu9iuypw-1; Fri,
 23 May 2025 12:30:53 -0400
X-MC-Unique: qWMerglCPWCABqEu9iuypw-1
X-Mimecast-MFC-AGG-ID: qWMerglCPWCABqEu9iuypw_1748017852
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9D401800446; Fri, 23 May 2025 16:30:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BC06195608F; Fri, 23 May 2025 16:30:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 3/3] iotests: Filter out ZFS in several tests
Date: Fri, 23 May 2025 11:27:23 -0500
Message-ID: <20250523163041.2548675-8-eblake@redhat.com>
In-Reply-To: <20250523163041.2548675-5-eblake@redhat.com>
References: <20250523163041.2548675-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fiona reported that ZFS makes sparse file testing awkward, since:
- it has asynchronous allocation (not even 'fsync $file' makes du see
  the desired size; it takes the slower 'fsync -f $file' which is not
  appropriate for the tests)
- for tests of fully allocated files, ZFS with compression enabled
  still reports smaller disk usage

Add a new _require_sparse_file that quickly probes whether an attempt
to create a sparse 5M file shows as less than 1M usage, while the same
file with -o preallocation=full shows as more than 4M usage without
sync, which should filter out ZFS behavior.  Then use it in various
affected tests.

This does not add the new filter on all tests that Fiona is seeing ZFS
failures on, but only those where I could quickly spot that there is
at least one place where the test depends on the output of 'du -b' or
'stat -c %b'.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.rc                | 30 +++++++++++++++++++++
 tests/qemu-iotests/106                      |  1 +
 tests/qemu-iotests/175                      |  1 +
 tests/qemu-iotests/221                      |  1 +
 tests/qemu-iotests/253                      |  1 +
 tests/qemu-iotests/308                      |  1 +
 tests/qemu-iotests/tests/mirror-sparse      |  1 +
 tests/qemu-iotests/tests/write-zeroes-unmap |  1 +
 8 files changed, 37 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 237f746af88..e977cb4eb61 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -996,6 +996,36 @@ _require_large_file()
     rm "$FILENAME"
 }

+# Check whether disk_usage can be reliably used.
+_require_disk_usage()
+{
+    local unusable=false
+    # ZFS triggers known failures on this front; it does not immediately
+    # allocate files, and then aggressively compresses writes even when full
+    # allocation was requested.
+    if [ -z "$TEST_IMG_FILE" ]; then
+        FILENAME="$TEST_IMG"
+    else
+        FILENAME="$TEST_IMG_FILE"
+    fi
+    if [ -e "FILENAME" ]; then
+        echo "unwilling to overwrite existing file"
+        exit 1
+    fi
+    $QEMU_IMG create -f raw "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -gt $((1024*1024)) ]; then
+        unusable=true
+    fi
+    $QEMU_IMG create -f raw -o preallocation=full "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -lt $((4*1024*1024)) ]; then
+        unusable=true
+    fi
+    rm -f "$FILENAME"
+    if $unusable; then
+        _notrun "file system on $TEST_DIR does not handle sparse files nicely"
+    fi
+}
+
 # Check that a set of devices is available in the QEMU binary
 #
 _require_devices()
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index ae0fc466910..55548439aad 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file fuse
 _supported_os Linux
+_require_disk_usage

 # in kB
 CREATION_SIZE=128
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index f74f053b719..bbbf550a5af 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -77,6 +77,7 @@ _supported_os Linux

 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage

 size=$((1 * 1024 * 1024))

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index c463fd4b113..eba00b80adb 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -41,6 +41,7 @@ _supported_os Linux

 _default_cache_mode writeback
 _supported_cache_modes writeback writethrough unsafe
+_require_disk_usage

 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
index 35039d20a89..6da85e6a113 100755
--- a/tests/qemu-iotests/253
+++ b/tests/qemu-iotests/253
@@ -41,6 +41,7 @@ _supported_os Linux

 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage

 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 437a9014da5..6eced3aefb9 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -51,6 +51,7 @@ _unsupported_fmt vpc

 _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
+_require_disk_usage

 # $1: Export ID
 # $2: Options (beyond the node-name and ID)
diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
index 338d6cfbb35..39e3196c811 100755
--- a/tests/qemu-iotests/tests/mirror-sparse
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -40,6 +40,7 @@ cd ..
 _supported_fmt qcow2 raw  # Format of the source. dst is always raw file
 _supported_proto file
 _supported_os Linux
+_require_disk_usage

 echo
 echo "=== Initial image setup ==="
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
index 7cfeeaf8391..f90fb8e8d27 100755
--- a/tests/qemu-iotests/tests/write-zeroes-unmap
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -32,6 +32,7 @@ cd ..
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_disk_usage

 create_test_image() {
     _make_test_img -f $IMGFMT 1m
-- 
2.49.0


