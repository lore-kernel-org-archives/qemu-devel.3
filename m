Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03ACC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972u-0002LP-7F; Tue, 22 Sep 2026 16:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972C-0000tN-RB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9728-0000Zf-0h
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOMxDRs4e6kbwdqK+UcD+rHmrn1BkQESsCiR2mUNx1w=;
 b=EbFYfI98Edfr91zf3Y3GKioDXg4qpGJDe8boEWxBitqJAWeuHfEflcdDK+4HxSdq+D0boP
 srXaaSLYbnEklwHfAs9ftUO2+Idu5keDwmYB9+R5O/9HazrPZXC1xGLpwXk1aD3kTDwGSs
 L5Ju/4PmyiJb/ikcgifXNfHctc3fmQw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-DwKapS4-PN6kA5s465ClEQ-1; Tue,
 22 Sep 2026 16:24:03 -0400
X-MC-Unique: DwKapS4-PN6kA5s465ClEQ-1
X-Mimecast-MFC-AGG-ID: DwKapS4-PN6kA5s465ClEQ_1790108643
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F81F195C244; Tue, 22 Sep 2026 20:24:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B9D61800446; Tue, 22 Sep 2026 20:24:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:29 +0400
Subject: [PATCH 82/88] qemu-iotests/232: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-82-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=29499;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vUlKTxQY8qRfH+BvWfnVX+8fPYcmZls7c+OQK7ViFgA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0cUc/i4rDpDb1PNFk8RMC+8XLBWzyGITqI
 /UEU7ptcpKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5WdSD/4pWtLpfgVAHYcc7zwu1zsI81Ml1KOJWSdRaqo+UXwmihI27iHclgzn0u5AKAMDcbfXzto
 n5q7gAlJwozuTK0IjfmAXgRh3XcxrpXwxe2NUeL6GoaRfx56QfkGZPiT0Sl+NrZ3VjlkwRtkyFO
 IM92vJgMUbJ+sepFwBGOLFsiDZ5H8zdkellLwcEeFQMZ/bBkqdBFT1iLComuJP0ZBoW6D2v8Z/s
 Hw6siXF5EqtsJTX329iWgysXb2mp+eyg5yTRtGgmJet7lbUMc92kjx7Blaqc7oo4z3U92LhNBa8
 cfxqLtcOh4RX9CsonrQ3Cbw0V4le/wTsMAOcuRB121sbBFxTvHuvUdyhyq7H/egrgMvI2fJBMeN
 b8VB0mM6rS1gjAx+cwM4Kw5L5DwEEweiZmv3pWD7UxIv74viMzb9zxCVDAnRT0NRGsm0aWwDBgv
 HwakgoJ8IW94IRWTw9vxco/JwWchxYcbx2FGT/lkFSsOPG6CjwTFsAMUEg2DvPof9T9ZdsiQlts
 vxiuGBVn633SObPdT17MoVMuo2XxmycB6Baf6jbHHRdeuo9xPrKKSEgHZgpUs6C7PzS+y9MyuT/
 Io8esjQ7KibGb1BVswt1S4bWhvysqQSE7YPndnjhaobI66PS/XQvSulCT5s/S9TLd2clF9QB5EO
 ojWqSYk+9L4DQNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace pipe-based HMP info block -n with QMP query-named-block-nodes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/232     |  32 +++----
 tests/qemu-iotests/232.out | 216 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 196 insertions(+), 52 deletions(-)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 1ee0aae481d4..05eb4688772b 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -43,31 +43,19 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
-_require_hmp
-
-do_run_qemu()
-{
-    echo Testing: "$@"
-    (
-        if ! test -t 0; then
-            while read cmd; do
-                echo $cmd
-            done
-        fi
-        echo quit
-    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
-    echo
-}
-
-run_qemu()
-{
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp |
-        _filter_generated_node_ids | _filter_imgfmt
-}
 
 run_qemu_info_block()
 {
-    echo "info block -n" | run_qemu "$@" | grep -e "(file" -e "QEMU_PROG"
+    (
+        printf '%s\n' '{"execute":"qmp_capabilities"}' \
+                      '{"execute":"query-named-block-nodes"}' \
+                      '{"execute":"quit"}'
+    ) | $QEMU -nographic -qmp stdio -nodefaults "$@" 2>&1 |
+    _filter_testdir | _filter_qemu | _filter_qmp |
+    _filter_generated_node_ids | _filter_imgfmt |
+    _filter_actual_image_size |
+    gsed -e 's/\("virtual-size":\s*\)[0-9]\+/\1VSIZE/g'
+    echo
 }
 
 size=128M
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
index 3bd1a920afc9..3c7716914e84 100644
--- a/tests/qemu-iotests/232.out
+++ b/tests/qemu-iotests/232.out
@@ -3,57 +3,213 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 === -drive with read-write image: read-only/auto-read-only combinations ===
 
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
 
 === -drive with read-only image: read-only/auto-read-only combinations ===
 
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 
 QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 
 QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 
 === -blockdev with read-write image: read-only/auto-read-only combinations ===
 
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-node0: TEST_DIR/t.IMGFMT (file, read-only)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
-node0: TEST_DIR/t.IMGFMT (file)
-node0: TEST_DIR/t.IMGFMT (file)
-node0: TEST_DIR/t.IMGFMT (file)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
-node0: TEST_DIR/t.IMGFMT (file)
-node0: TEST_DIR/t.IMGFMT (file)
-node0: TEST_DIR/t.IMGFMT (file)
 
 === -blockdev with read-only image: read-only/auto-read-only combinations ===
 
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-node0: TEST_DIR/t.IMGFMT (file, read-only)
-node0: TEST_DIR/t.IMGFMT (file, read-only)
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 
 QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-node0: TEST_DIR/t.IMGFMT (file)
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
 
+
 QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-node0: TEST_DIR/t.IMGFMT (file)
+
+QMP_VERSION
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": VSIZE, "filename": "TEST_DIR/t.IMGFMT", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "node0", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.IMGFMT"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
 QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


