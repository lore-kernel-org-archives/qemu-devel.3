Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB43C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972W-0001bC-TZ; Tue, 22 Sep 2026 16:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971f-0007Av-9r
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971d-0000Qs-Gp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ArTgqVawGv6a/NtFiXaEVr9WEUB3GZtXsMYexCrpmms=;
 b=D5cJr8rS9i11txcTUoJvZi5RccoJaoo52+WfDC2HII2guBMa0sFz7ie0P0P9/31wSEqEnY
 iWs9l/B/xus3HhvmVvU+gJr/W+/pI2Vu3KQOHtqGI93GCqCPcinP1U7nHWGN067tLpDbkY
 mHGZpuFPdJkyuZknUQIeN3L2p0DCeZE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-X-8EnChCOae4PLtEvgolXw-1; Tue,
 22 Sep 2026 16:23:35 -0400
X-MC-Unique: X-8EnChCOae4PLtEvgolXw-1
X-Mimecast-MFC-AGG-ID: X-8EnChCOae4PLtEvgolXw_1790108614
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A44A195FD11; Tue, 22 Sep 2026 20:23:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 610D31800370; Tue, 22 Sep 2026 20:23:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:21 +0400
Subject: [PATCH 74/88] qemu-iotests/130: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-74-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4274;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yRmZMtPGaLTkXb3jb5qSGcgOzjcAJVdxJQ3/weBLRPA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzkv6qabSwo9SoMGJN6/o57+s223/ZsgKuL
 9zzA/ad8gaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5RqcD/42ehoesuVktPZuPVLo+E8NbugEcRcjYRoTRlgJVqv4bqfmfSThxrfCq0Egcchp7K01Gz0
 dGnJcz+G3KVUPn+GkFeWLNk0wEqkwP8xlSKGR8HH5nuYXZZgR++yufx08yb6JvGn7HyIqU3Mrcd
 kWEcxQ+DaeOEsIsBz4jwyvm7mKWjocTQXPClCQmgAGVzlQl7e2xQNI6WkHmDmnTMtyOqen6OEzx
 gaLOav9IzwPrqrPJNEkJH9WUVOzkdufxlFP9Kx4pzmlpqMNEv25z0CFntTn1b5Otb5puVym4/2H
 /OmbPxNKGNTRWmgjPXuQHobAZZFqNv3Uaxtp3ZsFkrBw2dL9bLnByj3t+LjtCJHWDNGBr5UnuDq
 YFG4djqNeI4dIaOWRiSa+Zr+V+1eCY0zUyrBAMVbgTiBvbyctLGmqjE2mnETcEHMDSrRWomZBxa
 LdiodZXWX2mXjXss8gwPxmpGXtckoUC7KdyRtwHlZcJyPyQKNQh9aEjiepdylx3dC8dl1CP3MJQ
 cfoYbpuPNtqWhYbEiS+TzBtuIXR2VHPqvhIEkKcslxLwHnHcjDyCg4/svcELVoZjcVu3oB9pISJ
 V0S7o6PpWgshdclKtArc8wwxQxHrrRiRud95/hqnHd4UPt5gSt3EEY4w1v8cJkBHaSkKed2iVFS
 CyzMltlescoAXgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace HMP commit with QMP block-commit job-based API, using
_run_qmp_job() helper for the complete/dismiss sequence. Silence
all QMP output since the test validates backing file path
preservation via _img_info, not the commit protocol itself.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/130     | 53 +++++++++++++++++++++++++++++++++++++---------
 tests/qemu-iotests/130.out |  8 +------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 3d10aba2594e..beb5ef24c0f1 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -46,9 +46,6 @@ _supported_proto file
 _supported_os Linux
 # We are going to use lazy-refcounts
 _unsupported_imgopts 'compat=0.10'
-_require_hmp
-
-qemu_comm_method="monitor"
 
 
 TEST_IMG="$TEST_IMG.orig" _make_test_img 64M
@@ -57,24 +54,60 @@ _make_test_img 64M
 _img_info | _filter_img_info
 
 echo
-echo "=== HMP commit ==="
+echo "=== commit ==="
 echo
 # bdrv_make_empty() involves a header update for qcow2
 
 # Test that a backing file isn't written
 _launch_qemu -drive id=testdisk,file="$TEST_IMG",backing.file.filename="$TEST_IMG.base"
-_send_qemu_cmd $QEMU_HANDLE "commit testdisk" "(qemu)"
-_send_qemu_cmd $QEMU_HANDLE '' '(qemu)'
-_cleanup_qemu
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'device': 'testdisk',
+                      'job-id': 'job0',
+                      'auto-dismiss': false } }" \
+    'BLOCK_JOB_READY'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-job-complete',
+       'arguments': { 'device': 'job0' } }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'job-dismiss',
+       'arguments': { 'id': 'job0' } }" 'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+wait=1 _cleanup_qemu
 _img_info | _filter_img_info
 
 # Make sure that if there was a backing file that was just overridden on the
 # command line, that backing file is retained, with the right format
 _make_test_img -F raw -b "$TEST_IMG.orig" 64M
 _launch_qemu -drive id=testdisk,file="$TEST_IMG",backing.file.filename="$TEST_IMG.base",backing.driver=$IMGFMT
-_send_qemu_cmd $QEMU_HANDLE "commit testdisk" "(qemu)"
-_send_qemu_cmd $QEMU_HANDLE '' '(qemu)'
-_cleanup_qemu
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'device': 'testdisk',
+                      'job-id': 'job0',
+                      'auto-dismiss': false } }" \
+    'BLOCK_JOB_READY'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-job-complete',
+       'arguments': { 'device': 'job0' } }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'job-dismiss',
+       'arguments': { 'id': 'job0' } }" 'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+wait=1 _cleanup_qemu
 _img_info | _filter_img_info
 
 echo
diff --git a/tests/qemu-iotests/130.out b/tests/qemu-iotests/130.out
index e45285ccc311..f9109d6ed9db 100644
--- a/tests/qemu-iotests/130.out
+++ b/tests/qemu-iotests/130.out
@@ -6,18 +6,12 @@ image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 
-=== HMP commit ===
+=== commit ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) commit testdisk
-(qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.orig backing_fmt=raw
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) commit testdisk
-(qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)

-- 
2.56.0.rc0.29.g47ce80527c56


