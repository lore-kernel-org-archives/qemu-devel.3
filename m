Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971B6C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972X-0001dr-Cp; Tue, 22 Sep 2026 16:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9721-0000bM-94
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971w-0000WS-37
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/OVYXkQe1QMnI4wvHKulOQBAOcvaoS2FA+7oii3348=;
 b=UlHq0A8RMAdadx7vGPc2emlMqwVeiiazr0Cbr8mHNd0ci5Lp3qU5YZrTW52F6/sBqyj+xj
 S7xkDOaCDgRCZQpHN1ZNrMBFOtWImisp2A2ggSlCdyHUaT7Esu4WI6t2+sLl0Bu95KsQgk
 zR/DZbI+u2ToajShBsjqnF8bdG8b3c8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-1Don_5-LNv2NTBYGQY8dHw-1; Tue,
 22 Sep 2026 16:23:53 -0400
X-MC-Unique: 1Don_5-LNv2NTBYGQY8dHw-1
X-Mimecast-MFC-AGG-ID: 1Don_5-LNv2NTBYGQY8dHw_1790108632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A73821955DDF; Tue, 22 Sep 2026 20:23:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D63180056E; Tue, 22 Sep 2026 20:23:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:26 +0400
Subject: [PATCH 79/88] qemu-iotests/186: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-79-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=63836;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XvI4A+02rb5Agfheb8KROpz6AMCJEFW1mMefHosceEY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzkR7na3H0UZSqXg2cEqctPmySPq1D1h8yY
 elkASj4fmyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5dntD/9wTMbFVO47zQhlWYACSFol84NVZsIV2MyleD03MJ1jieF4HOtuyhkETAkyh/RofWhMW0t
 J08aepodKVySYmjjkWOH6jTYQxjRrWJvB55V7zRvO+ekyFCrOdLGxFiB+14w0ZOXLka8fyIu6RB
 xL7LOIR7C8fNIWKVvFr3UqoCfbKCcFhXnA3aSLXJtEU9XWslr2ZKA/5IF2J3zeNHsZtY7af0Fga
 qJOyVfGdvZ/lc3Bug6sdZMv80kltsKaiwGnuXrELpjXH9nWX0PluJ0eTt5wvfWBZqLE+VZouRNB
 IIdsAoynTCXKpxutJ/IycsmhJfe0YHSnwJin6Zf71Z2FP0WmQhDLkKR4b5P9D6pwBIZ7tuk/EPC
 +0dbsZPexkBI0/gylSj4M45aF25FvgKi7CbZUeMf6cpfRNRtLQbqgjuBxD/+zIAA4dcXZANG7Mb
 uLtR5UrUa/a9r6UeaFKkEtJbs1+h4ahmY/vKACobtfZ5lFpqmUF+aUCXGsp3zP/cvioLgwIGdW1
 Jdv0f3uI3ippgjZzt7WwUvzqpB3Y80oooOhgZybyTVXyWYIeoeebMXRp6ZhOS1DF/lscql3vj8z
 1h+W1RzyrcxNdZxeRkKj9/YB6/RSacL7ocFEQv4dm2PDJAK0lYLSEQDEky/UBOUPoTN1CLUxz+8
 sYoJOUs/+NR5+QA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Replace pipe-based HMP info block with QMP query-block.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/186     |  12 +-
 tests/qemu-iotests/186.out | 590 +++++++++++++++++++--------------------------
 2 files changed, 256 insertions(+), 346 deletions(-)

diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 9a4215d28e92..56952356b24f 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -41,7 +41,6 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _require_drivers null-co
 _require_devices virtio-scsi-pci
-_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
@@ -52,20 +51,21 @@ do_run_qemu()
     echo Testing: "$@"
 
     (
+        echo '{ "execute": "qmp_capabilities" }'
         if ! test -t 0; then
             while read cmd; do
-                echo $cmd
+                echo "$cmd"
             done
         fi
-        echo quit
-    ) | $QEMU -S -display none -device virtio-scsi-pci -monitor stdio "$@" 2>&1
+        echo '{ "execute": "quit" }'
+    ) | $QEMU -S -display none -device virtio-scsi-pci -qmp stdio "$@" 2>&1
     echo
 }
 
 check_info_block()
 {
-    echo "info block" |
-    do_run_qemu "$@" | _filter_win32 | _filter_hmp | _filter_qemu |
+    echo '{ "execute": "query-block" }' |
+    do_run_qemu "$@" | _filter_win32 | _filter_qmp | _filter_qemu |
         _filter_generated_node_ids | _filter_qom_path
 }
 
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 01530040e5f4..4f966a70219e 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -4,458 +4,368 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 === Empty drives ===
 
 Testing: -device floppy
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -device floppy,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "", "locked": false, "removable": true, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -device ide-cd
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -device ide-cd,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -device scsi-cd
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-/machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -device scsi-cd,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-qdev_id: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === -blockdev/-device=<node-name> ===
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": true, \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vi
 rtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741
 824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vir
 tual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
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
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "type": "unknown"}, {"io-status": "ok", "device": "", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "vir
 tual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === -drive if=none/-device=<bb-name> (with medium) ===
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral/qdev_id/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "null", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === -drive if=none/-device=<bb-name> (without medium) ===
 
 Testing: -drive if=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device floppy,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device floppy,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device ide-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device ide-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device scsi-cd,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "/machine/peripheral-anon/device[1]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=none -device scsi-cd,drive=none0,id=qdev_id
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-none0: [not inserted]
-    Attached to:      qdev_id
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "none0", "locked": false, "removable": true, "qdev": "qdev_id", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === -drive if=... ===
 
 Testing: -drive if=floppy
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "floppy0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[10]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=floppy,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "floppy0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[10]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=ide,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[4]", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=ide,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "ide0-cd0", "locked": false, "removable": true, "qdev": "/machine/unattached/device[4]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co, read-only)
-    Attached to:      /machine/unattached/device[N]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "ide0-cd0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": true, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/unattached/device[4]", "tray_open": false, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=virtio,driver=null-co,read-zeroes=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "virtio0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1073741824, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\"}"}, "qdev": "/machine/peripheral-anon/device[1]/virtio-backend", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "size": "1M"} (null-co)
-    Attached to:      /machine/system.flash0
-    Cache mode:       writeback
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": [{"device": "pflash0", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 512, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 1048576, "filename": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\", \"size\": \"1M\"}", "format": "null-co", "actual-size": 0}, "iops_wr": 0, "ro": false, "children": [], "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "null-co", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"read-zeroes\": \"on\", \"driver\": \"null-co\", \"size\": \"1M\"}"}, "qdev": "/machine/system.flash0", "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


