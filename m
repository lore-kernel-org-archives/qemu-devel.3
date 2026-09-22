Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1840C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x975M-0005kG-H4; Tue, 22 Sep 2026 16:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972V-0001YK-8z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972P-0000bf-B8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9Xx1QgV60HnWy/D1qs5SVHk5j8YzgWxCyt6p1UWbXQ=;
 b=X5Vn/0X3STSRfMMKK3wvYXI3s2s8yR4GpLMFSgl6cfabt1VLTxNd0T8eGcQ6zWFZvL1XYU
 ITryQapy0uDgAgCVvZHMCavGruZpTEU5Hn98Yo5ANyEDXI1AzCyio5HRKVVyDsaig6n2AC
 UXyyiNWmyERC5fuv+aNARSQFcRq46+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-YcSFxw1gOY2CMb5SmLTtGw-1; Tue,
 22 Sep 2026 16:24:21 -0400
X-MC-Unique: YcSFxw1gOY2CMb5SmLTtGw-1
X-Mimecast-MFC-AGG-ID: YcSFxw1gOY2CMb5SmLTtGw_1790108660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32B0D18052E0; Tue, 22 Sep 2026 20:24:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9E9B1800446; Tue, 22 Sep 2026 20:24:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:33 +0400
Subject: [PATCH 86/88] qemu-iotests/172: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-86-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=59416;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Z7zWiYPoHXujB3Ip3/2kCX5nmNzZ2k9eAEMT2Fd8030=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK09a/Az8Mpb8dKX3j/epaB5CfamM6lwI4x9
 VCmEnKiOgGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5cGfD/9yNFXIzWMs8pOAcgY8vOmz20t0Udxkl/0v0So/qDS0Rx1uPwdGlEBiPsb9iPnL8GBniJg
 7PTEWOqHpnbRseqUFtbv49ZMmgqNJ6Ng3Ew01fpdDxKM3toW1eq7KgBBamDGOUh82FxT44Qoq5O
 D9HdF3uUGVnGmn2i/7LKB80W58xDqrpRKPzLe6Vu049X7Y0RnlKt62zFrYsp9qzsMrt6vN62bV1
 E+Qq/TBic+d8NU8zIFSg25WdanG6qrU/+Jo2hxr32ZUVKjCcQXM8AmcQctngqheLBQMV0BwQwO/
 8DXb9UOP6fzwC2WSJVz6l8HSaNhwbJk6u3ugWe2WgxNcayFGcp7x6EgMWu75KTj88R6VpYuAKGW
 WAzQ8e2X70fwSo8u5T/CAXypOTxLvNPbymJGuVZsbxwoMh+wi2Kp67xn5d0Ccyr18QasNtUlHs/
 Vi9+Bkn78bMpr/1ijaMDMGE6qiapKXcfbJcKHVDwsKFvEvto46xeuvwjDiDaiaz/YQnBvdjzFXH
 ryKe26/G+Ar/3mfNIJq7dNaryXA5r7ZpqBPd32R7jLzcp8V9home557syIT2oRoDmljXrCXTclu
 cFF6RX2Ogph9Eym+PFV3IFTREaEdx7Ji78f4DwVUbSQe+nSi+X59sEgqve3pMsfpoUC89uoyzry
 6+xuKw+vlbGbBAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Replace HMP with QMP, using x-query-qtree for the device tree and
query-block for block device info.

The query-block output now includes all block devices, including those
without media inserted (e.g. ide1-cd0, empty floppy drives).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/172     |  76 +++++++++--
 tests/qemu-iotests/172.out | 305 ++++-----------------------------------------
 2 files changed, 89 insertions(+), 292 deletions(-)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index a78e42ff0adf..b2b06f404772 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
@@ -51,16 +50,70 @@ fi
 do_run_qemu()
 {
     (
+        echo '{"execute":"qmp_capabilities"}'
         if ! test -t 0; then
             while read cmd; do
-                echo $cmd
+                echo "$cmd"
             done
         fi
-        echo quit
-    ) | $QEMU -accel qtest -nographic -monitor stdio -serial none -vga none -nic none "$@"
+        echo '{"execute":"quit"}'
+    ) | $QEMU -accel qtest -nographic -qmp stdio -serial none -vga none -nic none "$@"
     echo
 }
 
+_filter_qmp_responses()
+{
+    $PYTHON -c '
+import sys, json, re
+for line in sys.stdin:
+    try:
+        j = json.loads(line)
+    except Exception:
+        continue
+    if "error" in j:
+        print(json.dumps(j["error"]))
+        continue
+    r = j.get("return")
+    if r is None:
+        continue
+    if isinstance(r, dict) and "human-readable-text" in r:
+        p = False
+        for l in r["human-readable-text"].split("\n"):
+            if "dev: isa-fdc" in l:
+                p = True
+            elif p and l.startswith("          dev:"):
+                p = False
+            if p:
+                print(l)
+    elif isinstance(r, list):
+        if r:
+            s = json.dumps(r)
+            s = re.sub(r"device\[\d+\]", "device[N]", s)
+            print(s)
+'
+}
+
+_filter_block_cache()
+{
+    $PYTHON -c '
+import sys, json
+for line in sys.stdin:
+    try:
+        r = json.loads(line).get("return")
+    except Exception:
+        continue
+    if not isinstance(r, list):
+        continue
+    for entry in r:
+        if entry.get("device") == "none0" and "inserted" in entry:
+            cache = entry["inserted"]["cache"]
+            if cache["writeback"]:
+                print("    Cache mode:       writeback")
+            else:
+                print("    Cache mode:       writethrough")
+'
+}
+
 check_floppy_qtree()
 {
     echo
@@ -68,21 +121,18 @@ check_floppy_qtree()
 
     # QEMU_OPTIONS contains -nodefaults, we don't want that here because the
     # defaults are part of what should be checked here.
-    #
-    # Apply the sed filter to stdout only, but keep the stderr output and
-    # filter the qemu program name in it.
-    printf "info qtree\ninfo block\n" |
+    printf '{"execute":"x-query-qtree"}\n{"execute":"query-block"}\n' |
     (QEMU_OPTIONS="" do_run_qemu "$@" |
-	_filter_testdir |_filter_generated_node_ids | _filter_hmp |
-        sed -ne '/^          dev: isa-fdc/,/^          dev:/{x;p};/^[a-z][^ ]* (NODE_NAME):* /,/^(qemu)$/{p}') 2>&1 |
-    _filter_win32 | _filter_qemu | _filter_qom_path
+	_filter_testdir | _filter_generated_node_ids |
+        _filter_qmp_responses | _filter_actual_image_size) 2>&1 |
+    _filter_win32 | _filter_qemu
 }
 
 check_cache_mode()
 {
-    echo "info block none0" |
+    printf '{"execute":"query-block"}\n' |
     QEMU_OPTIONS="" do_run_qemu -drive if=none,file="$TEST_IMG" "$@" |
-    _filter_win32 | _filter_qemu | grep "Cache mode"
+    _filter_block_cache
 }
 
 
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a023cd407dee..e9310bd34f39 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -7,7 +7,6 @@ Formatting 'TEST_DIR/t.IMGFMT.3', fmt=IMGFMT size=737280
 === Default ===
 
 Testing:
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -32,12 +31,12 @@ Testing:
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
+[{"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]
 
 
 === Using -fda/-fdb options ===
 
 Testing: -fda TEST_DIR/t.qcow2
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -62,19 +61,9 @@ Testing: -fda TEST_DIR/t.qcow2
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fdb TEST_DIR/t.qcow2
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -114,23 +103,9 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-
-floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]
 
 Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -170,24 +145,9 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/mach
 ine/unattached/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fdb 
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -227,12 +187,12 @@ Testing: -fdb
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
+[{"device": "floppy1", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]
 
 
 === Using -drive options ===
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -257,19 +217,9 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -309,23 +259,9 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-
-floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "type": "unknown"}]
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2.2,index=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -365,27 +301,12 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/mach
 ine/unattached/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 
 === Using -drive if=none and -device ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -410,19 +331,9 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -447,19 +358,9 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -499,21 +400,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"device": "none1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/mac
 hine/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 
 === Mixing -fdX and -global ===
@@ -525,7 +412,6 @@ QEMU_PROG: -global floppy.drive=... conflicts with drive=floppy0
 === Mixing -fdX and -device ===
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -565,24 +451,9 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -622,24 +493,9 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -679,24 +535,9 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -736,21 +577,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy1", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
@@ -762,7 +589,6 @@ QEMU_PROG: -device floppy,drive=none0,unit=1: Floppy unit 1 is in use
 === Mixing -drive and -device ===
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -802,24 +628,9 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=1
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -859,21 +670,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/unattached/device[N]"
 , "type": "unknown"}, {"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2.2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.2"}, "qdev": "/machin
 e/peripheral-anon/device[N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device floppy,drive=none0,unit=0
 QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
@@ -882,7 +679,6 @@ QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
 === Mixing -global and -device ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device floppy,unit=0
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -907,16 +703,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0 -device floppy,drive=none1,unit=0
 QEMU_PROG: -device floppy,drive=none1,unit=0: -global floppy.drive=... conflicts with drive=none1
@@ -949,7 +736,6 @@ QEMU_PROG: -device floppy,drive=none1: Can't create floppy unit 2, bus supports
 === Creating an empty drive with anonymous BB ===
 
 Testing: -device floppy
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -974,9 +760,9 @@ Testing: -device floppy
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
+[{"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]
 
 Testing: -device floppy,drive-type=120
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1001,9 +787,9 @@ Testing: -device floppy,drive-type=120
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "120"
+[{"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]
 
 Testing: -device floppy,drive-type=144
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1028,9 +814,9 @@ Testing: -device floppy,drive-type=144
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
+[{"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]
 
 Testing: -device floppy,drive-type=288
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1055,12 +841,12 @@ Testing: -device floppy,drive-type=288
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
+[{"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[N]", "type": "unknown"}]
 
 
 === Try passing different drive size with image ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-type=120
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1085,19 +871,9 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "120"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-type=288
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1122,22 +898,12 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "288"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 
 === Try passing different block sizes ===
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=512
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1162,19 +928,9 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=512
-
           dev: isa-fdc, id ""
             iobase = 1008 (0x3f0)
             irq = 6 (0x6)
@@ -1199,16 +955,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 account-failed = "auto"
                 stats-intervals = <null>
                 drive-type = "144"
-none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+[{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 737280, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}, "qdev": "/machine/peripheral-anon/device[
 N]", "type": "unknown"}, {"io-status": "ok", "device": "ide1-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[N]", "tray_open": false, "type": "unknown"}]
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
 QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: logical_block_size > physical_block_size not supported

-- 
2.56.0.rc0.29.g47ce80527c56


