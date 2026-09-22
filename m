Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43C3C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zn-0000Qo-35; Tue, 22 Sep 2026 16:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zT-0008Im-HG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zP-00006G-IT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C09zC/uamIYnbycxHJNEwP15ExC//N0HYyPC7wjyzU=;
 b=AMn2fw8yFBFQZeyUl5ypzFc7Hls37zBGnhU0AiqxMVuCj12MAcng1R8oR4mA6YynVlywty
 JXDANgk+cSGnDciQzRb2fO2tR3CKnOK6JxEDePjxga9C4u1JpicK5LSpCbEHANbRh0K2to
 3g6qCkYQMGWUEwT/16v6I76PolPyQ4I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-1NgG0gjKOLy39vlr9AqZMA-1; Tue,
 22 Sep 2026 16:21:15 -0400
X-MC-Unique: 1NgG0gjKOLy39vlr9AqZMA-1
X-Mimecast-MFC-AGG-ID: 1NgG0gjKOLy39vlr9AqZMA_1790108474
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB4D185588D; Tue, 22 Sep 2026 20:21:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E93E418; Tue, 22 Sep 2026 20:21:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:42 +0400
Subject: [PATCH 35/88] qemu-iotests/257: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-35-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=29463;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+Phsca7pI5y8NGKjPanX7AFd9YSEAFE4Ag0Bp83AGo4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwsqh8Awx0wBkS1mWz3XL2h1T1JHpTspBS8
 FCgjtYp9+CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5VyWD/9epqfYQjglxJlCXsFenz0nAo2ha9sioic60W6RE+LKB0V/XJ4soPLn1MXmre/tfPhQACB
 J+Zhnpf336ee1LaTcu5+oSUgxw+Elhtewy1WtMF9wvkxF19soqO3Lir8ZUEIzTzIVcv6hW/svAb
 1pshivodzHZuyS2LXZLnPt11DydsOtCZ3ax1MFva3OF+niydbV69o4osbYNwFkjKSkrecgReX9F
 L4OlLh9IwbeW/3RDwFAAzcHYVl9e4gdjOSUs77jCVB4kU1SwJFGdMerjPwSqtVP29YdDJAfw1t5
 2J8fXukvwOUlFazcLf/cpxlvkNZgv1sLA0Rhvsl4O3HIL/bBPC7Ul7kLLykyy/4H9W0UT4UHu4k
 BymCZgwvuhVhwTsVRSlnYDIYH6uiOo7Z+n1ZSPlLyvLQgS/HpuiSsgZcdqmV3NLxhmra5r0PWcT
 GNLTnBuXUWIWcUjJ5fdgPXf7o5OKjAOWT2CG3tar56+4R/LXiM0ewHnRRbNNeBaoAhgNadnFQ8K
 a5BltOI+xMt5hwRCO32W1O+0fHdzYXtVdhbY30VmRsIYqfZQROMKFXJG0CulWDeaALQ5xelPxnk
 +uDZyVg0KOIKioHPlyjhTxqRWUBnoHU5TTsZs3Q7eYLWYC3SspcFKQvGCFIuL7LnX0cgPmzTVc6
 YUtM1qThsQn6wKw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No need to log success, the qmp_qemu_io() command already checks for it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/257     |   7 +-
 tests/qemu-iotests/257.out | 315 ---------------------------------------------
 2 files changed, 3 insertions(+), 319 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 5e4dba02e769..3fbf24531a7d 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -227,7 +227,7 @@ def perform_writes(drive, n, filter_node_name=None):
             pattern.offset,
             pattern.size)
         log(cmd)
-        log(drive.vm.hmp_qemu_io(filter_node_name or drive.node, cmd))
+        drive.vm.qmp_qemu_io(filter_node_name or drive.node, cmd)
     bitmaps = drive.vm.query_bitmaps()
     log({'bitmaps': bitmaps}, indent=2)
     log('')
@@ -354,7 +354,7 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
         # 1 - Test Backup (w/ Optional induced failure)
         if failure == 'intermediate':
             # Activate blkdebug induced failure for second-to-next read
-            log(vm.hmp_qemu_io(drive0.node, 'flush'))
+            vm.qmp_qemu_io(drive0.node, 'flush')
             log('')
         job = backup(drive0, 1, bsync1, msync_mode,
                      bitmap="bitmap0", bitmap_mode=bsync_mode)
@@ -533,5 +533,4 @@ def main():
 
 if __name__ == '__main__':
     iotests.script_main(main, supported_fmts=['qcow2'],
-                        supported_protocols=['file'],
-                        require_hmp=True)
+                        supported_protocols=['file'])
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index fb28333cb2fa..984dd7dbd73e 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -9,13 +9,9 @@
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -42,13 +38,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -97,13 +89,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -180,13 +168,9 @@ expecting 10 dirty sectors; have 10. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -278,13 +262,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -311,13 +291,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -350,7 +326,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -387,13 +362,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -485,13 +456,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -518,13 +485,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -573,13 +536,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -656,13 +615,9 @@ expecting 10 dirty sectors; have 10. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -754,13 +709,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -787,13 +738,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -842,13 +789,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -925,13 +868,9 @@ expecting 10 dirty sectors; have 10. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1023,13 +962,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -1056,13 +991,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1095,7 +1026,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -1132,13 +1062,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1230,13 +1156,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -1263,13 +1185,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1318,13 +1236,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -1401,13 +1315,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1499,13 +1409,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -1532,13 +1438,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1587,13 +1489,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -1670,13 +1568,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1768,13 +1662,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -1801,13 +1691,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1840,7 +1726,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -1877,13 +1762,9 @@ expecting 5 dirty sectors; have 5. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -1975,13 +1856,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -2008,13 +1885,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2063,13 +1936,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -2146,13 +2015,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2244,13 +2109,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -2277,13 +2138,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2332,13 +2189,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -2415,13 +2268,9 @@ expecting 10 dirty sectors; have 10. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2513,13 +2362,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -2546,13 +2391,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2585,7 +2426,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -2622,13 +2462,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2720,13 +2556,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -2753,13 +2585,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2808,13 +2636,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -2891,13 +2715,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -2989,13 +2809,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -3022,13 +2838,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3077,13 +2889,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -3160,13 +2968,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3258,13 +3062,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -3291,13 +3091,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3330,7 +3126,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -3367,13 +3162,9 @@ expecting 1009 dirty sectors; have 1009. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3465,13 +3256,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -3498,13 +3285,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3553,13 +3336,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -3636,13 +3415,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3734,13 +3509,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -3767,13 +3538,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -3822,13 +3589,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -3905,13 +3668,9 @@ expecting 10 dirty sectors; have 10. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4003,13 +3762,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -4036,13 +3791,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4075,7 +3826,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -4112,13 +3862,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4210,13 +3956,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -4243,13 +3985,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4298,13 +4036,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -4381,13 +4115,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4479,13 +4209,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -4512,13 +4238,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4567,13 +4289,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -4650,13 +4368,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4748,13 +4462,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -4781,13 +4491,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4820,7 +4526,6 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
-{"return": ""}
 
 --- Test Backup #1 ---
 
@@ -4857,13 +4562,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -4955,13 +4656,9 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 --- Write #0 ---
 
 write -P0x49 0x0000000 0x10000
-{"return": ""}
 write -P0x6c 0x0100000 0x10000
-{"return": ""}
 write -P0x6f 0x2000000 0x10000
-{"return": ""}
 write -P0x76 0x3ff0000 0x10000
-{"return": ""}
 {
   "bitmaps": {}
 }
@@ -4988,13 +4685,9 @@ write -P0x76 0x3ff0000 0x10000
 --- Write #1 ---
 
 write -P0x65 0x0000000 0x10000
-{"return": ""}
 write -P0x77 0x00f8000 0x10000
-{"return": ""}
 write -P0x72 0x2008000 0x10000
-{"return": ""}
 write -P0x69 0x3fe0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -5043,13 +4736,9 @@ expecting 6 dirty sectors; have 6. OK!
 --- Write #2 ---
 
 write -P0x74 0x0010000 0x10000
-{"return": ""}
 write -P0x69 0x00e8000 0x10000
-{"return": ""}
 write -P0x6e 0x2018000 0x10000
-{"return": ""}
 write -P0x67 0x3fe0000 0x20000
-{"return": ""}
 {
   "bitmaps": {
     "backup-top": [
@@ -5126,13 +4815,9 @@ expecting 7 dirty sectors; have 7. OK!
 --- Write #3 ---
 
 write -P0xaa 0x0010000 0x30000
-{"return": ""}
 write -P0xbb 0x00d8000 0x10000
-{"return": ""}
 write -P0xcc 0x2028000 0x10000
-{"return": ""}
 write -P0xdd 0x3fc0000 0x10000
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [

-- 
2.56.0.rc0.29.g47ce80527c56


