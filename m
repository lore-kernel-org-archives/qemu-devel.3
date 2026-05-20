Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74919CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopj-0004U3-4f; Wed, 20 May 2026 17:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopi-0004PH-0O
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopc-0004gJ-Ci
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufZAiVzqJFOxVoQfwy4RilsYE7GTwcD7lNPFl/Uo2EQ=;
 b=ZIv4GzsyRX5rqNOnwZfDGWoQY1ztSnMx6Y8FaNbEQTaXHrWUUWC17VCT/yWuqcqTWCzyyc
 FiexKi3NWr+lw5IdWWsIfOz4ZHd39z2Zrcq0xTZLqSBdYkINHI6z9yCm8PHB3VYsM17JOq
 E/dkrs5ISlLXKLq6/uDJIeVxx8U1csE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-rkhK3qHwMBSMyRvLkIvMRA-1; Wed,
 20 May 2026 17:51:57 -0400
X-MC-Unique: rkhK3qHwMBSMyRvLkIvMRA-1
X-Mimecast-MFC-AGG-ID: rkhK3qHwMBSMyRvLkIvMRA_1779313916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E4201956080
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7158519560A2; Wed, 20 May 2026 21:51:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:19 +0400
Subject: [PATCH 18/40] tests/qemu-iotests/186: convert from HMP to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-18-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=55242;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SJeNraDDmveXGbgl/jOyBph6ScrwdGQk14rgIwS0MM8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDfWs2hMvIUlw3ncIVlxpZwOUWh8yRo4yTv
 YZ4iRbMv9yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5VuFEACmC8Q37+25gdfH8RPV7JAd8hLxS4Khl1AKSuGIFPmJpxmdgU1/VBmRYeCcS3KgygZvXX8
 vBXdDR4NV9b5K9arbK3NeMI47/8/crqUJWfzZE3p0UpuROaF25zVkqDPx1DmrSFunAwDwYaCvYC
 al07qOISoeQtztrarhC5Lc9zishojUz8rD1bEDsOr9gXYhc0dCAiF4aM2NyCQ1ZwUovEdIiPFYn
 rJNG9EKxs8vYrecZgdml/73Gm8l74LSNsNMaqTfs/635/LBqJ23PUnoPcOoLnrdTy4K1Qyn6zd0
 qCVedHAFlbxb7O1Wc49eTWWbGOkEGjod6ERmbGAx7dy8Zseo+0ZEPL0q4V5HK3wG+wv4grAGZtl
 arF08TQNQE+pF5VBUYAHDelF4UM0wiomdVVZOE3AgBDUpK3LbR2L+LkmYbKH4SgrIedRMCCWSVU
 o3lqsjutQGzXN850euql/igAMrzusxI53THCN7cPozSU2gAPb5Z3HUguwuzvkT47pjtpsXc5D20
 ggeLQmTfeBFmfvVnYUETi5ocUY5uVL09RaKuXQpx72gBURDwxRbpw3P2e8iQ2IlH54Vahg3tAsH
 eerLrLq4rrR8TPR5t3lLKYnEVQLmRxZbTL5PRbD77qzT1Upam6c3WWtfCB7Jdku0zePlFh9CwrI
 KCE8evZJENwmbIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace HMP 'info block' with QMP 'query-block' so the test works
with --disable-hmp builds. Use -qmp stdio instead of -monitor stdio,
send JSON commands via printf, and filter with _filter_qmp and
_filter_qmp_empty_return instead of _filter_hmp.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/186     |  20 +--
 tests/qemu-iotests/186.out | 440 +++++++++++----------------------------------
 2 files changed, 108 insertions(+), 352 deletions(-)

diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index eaf13c7a334..fa77319614b 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -1,7 +1,7 @@
 #!/usr/bin/env bash
 # group: rw auto
 #
-# Test 'info block' with all kinds of configurations
+# Test 'query-block' with all kinds of configurations
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
@@ -50,22 +50,18 @@ do_run_qemu()
 {
     echo Testing: "$@"
 
-    (
-        if ! test -t 0; then
-            while read cmd; do
-                echo $cmd
-            done
-        fi
-        echo quit
-    ) | $QEMU -S -display none -device virtio-scsi-pci -monitor stdio "$@" 2>&1
+    printf '{"execute":"qmp_capabilities"}\n{"execute":"query-block"}\n{"execute":"quit"}\n' |
+    $QEMU -S -display none -device virtio-scsi-pci -monitor none -qmp stdio "$@" 2>&1
     echo
 }
 
 check_info_block()
 {
-    echo "info block" |
-    do_run_qemu "$@" | _filter_win32 | _filter_hmp | _filter_qemu |
-        _filter_generated_node_ids | _filter_qom_path
+    do_run_qemu "$@" | _filter_win32 | _filter_qemu | _filter_qmp |
+        _filter_qmp_empty_return |
+        grep -v '"event"' |
+        _filter_generated_node_ids |
+        sed 's/device\[[0-9]\+\]/device[N]/g'
 }
 
 
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 01530040e5f..952b0c7a0a0 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -4,458 +4,218 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 === Empty drives ===
 
 Testing: -device floppy
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -device floppy,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "", "locked": false, "removable": true, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -device ide-cd
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -device ide-cd,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 Testing: -device scsi-cd
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -device scsi-cd,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 
 === -blockdev/-device=<node-name> ===
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]/virtio-backend", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 
 === -drive if=none/-device=<node-name> ===
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741
 824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vir
 tual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vir
 tual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 
 === -drive if=none/-device=<bb-name> (with medium) ===
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]/virtio-backend", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 
 === -drive if=none/-device=<bb-name> (without medium) ===
 
 Testing: -drive if=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "type": "unknown"}]}
 
 Testing: -drive if=none -device floppy,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=none -device floppy,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "type": "unknown"}]}
 
 Testing: -drive if=none -device ide-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none -device ide-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none -device scsi-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=none -device scsi-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
 
 
 === -drive if=... ===
 
 Testing: -drive if=floppy
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=floppy,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=ide,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]}
 
 Testing: -drive if=ide,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "ide0-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co, read-only)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "ide0-cd0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]}
 
 Testing: -drive if=virtio,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"io-status": "ok", "device": "virtio0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[N]/virtio-backend", "type": "unknown"}]}
 
 Testing: -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "size": "1M"} (null-co)
-    Attached to:      /machine/system.flash0
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "pflash0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1048576, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\", \"size\": \"1M\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\", \"size\": \"1M\"}"}, "qdev": "/machine/system.flash0", "type": "unknown"}]}
 
 *** done

-- 
2.54.0


