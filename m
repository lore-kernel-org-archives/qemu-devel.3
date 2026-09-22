Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7E3C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9718-0003Lj-ME; Tue, 22 Sep 2026 16:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970J-00019I-1f
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970H-0000FN-6A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZMz0Rf3aYpV07pIkVoHF40DR9YsmBk7X+QywefybOk=;
 b=PAi9Ulb18kmWWyFJjupc7odIsf8beVZ1r1AcfmeXvq8sAR4Uk9s9UvvIfALWzQi0IBCcFv
 iugN8djIoCBy4twpyDviwHjUoHp5ibz4ZIkBDY+ON1NtsG7uy6pWBQ6UGUZOAdd86NAuRK
 UhjNhOpEzDl492LORVjbsQ/h1FNzAsE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-WGqJDP4uPTKOJ4Oa4Izw7w-1; Tue,
 22 Sep 2026 16:22:09 -0400
X-MC-Unique: WGqJDP4uPTKOJ4Oa4Izw7w-1
X-Mimecast-MFC-AGG-ID: WGqJDP4uPTKOJ4Oa4Izw7w_1790108528
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F1521955DC8; Tue, 22 Sep 2026 20:22:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C16D1956086; Tue, 22 Sep 2026 20:22:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:57 +0400
Subject: [PATCH 50/88] qemu-iotests/225: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-50-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=D13aCsEA6yKRmysb2YyOf2AAylfBectFhDOwcTxGw2E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKx2TSsCfFvqoNnc2muQD+kgOZXvDC8rTxyC
 TjRl9DFkwmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5c+jD/0Sc6CROJ1Gzwpxv0TB2b0xz/n5Eeuikc/zRlQemhCISmA+H0UtI/n8qSXuaITQHDPCdCk
 gTH69IrdANnYbENyBOsMHwlM9MHIPBoE6XHaL9hdFLs4y+ZkbxNHYqH3FZd1uMpE/hafQOAGLkz
 OC9NlIckNMiIxgsySG+cDYmU/esPCUlZblQV3zkstY7WNeQNeInRVFCtBAdS1WI75ZqzqySM3ke
 Bk119vkPgC4ku7lC0Ad0uBFCZWI8twmq6gky/3u1DXqdeu64ewhj10sw60NKHa4we3bH5tb6Bv1
 yz9eM3zHt4bAuZ85TS8PCcPWRuW1qcIlgRKFi8sch7x7k1MNiSwjZ7vD3auAuTVX5GFwJ71V8qT
 AYCUWqvHAS1Mzzsko4SntnQADww0C+k/g1hF6Hfc8iZR6pM98o14r7xunPjAjuygVT4kMhqlj7C
 3S4+iq7fvJz7kePrp0/q6yVrWIyS7HlCXR1a4L1XS3SpvBs5T1wy1q7tWp+ExeLgJKe2WR7HZXD
 y7Z0CLKUjLhyn2e6ES1bXgzIeSHSx5mLERBdP1MK9ztamftUevzN26s0s93TN1hJq5bgyPHxA6K
 9K055EGQI1b9tLAMPB+3XP5CosHK0UW9H6WVn/m2mWV1y2mX5X52auoMQlpetA5ZwCmwRnoEC81
 T0Ppy4uludYyijg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/225     | 28 ++++++++++++++++++----------
 tests/qemu-iotests/225.out | 25 +++++++++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index 8128d583d609..9ec2741ecd8e 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -46,7 +46,6 @@ _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
-_require_hmp
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 1M
 TEST_IMG="$TEST_IMG.not_base" _make_test_img 1M
@@ -83,11 +82,14 @@ echo
 echo '=== Testing fitting VMDK backing image ==='
 echo
 
-qemu_comm_method=monitor \
-    _launch_qemu -blockdev "$base_opts" -blockdev "$overlay_opts"
+_launch_qemu -blockdev "$base_opts" -blockdev "$overlay_opts"
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "return"
 
 # Should not return an error
-_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'ops'
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }" \
+    "return"
 
 _cleanup_qemu
 
@@ -96,11 +98,14 @@ echo
 echo '=== Testing unrelated VMDK backing image ==='
 echo
 
-qemu_comm_method=monitor \
-    _launch_qemu -blockdev "$not_base_opts" -blockdev "$overlay_opts"
+_launch_qemu -blockdev "$not_base_opts" -blockdev "$overlay_opts"
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "return"
 
 # Should fail (gracefully)
-_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'failed'
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }" \
+    "error"
 
 _cleanup_qemu
 
@@ -118,11 +123,14 @@ echo
 # this a FIXME because with -blockdev, you cannot specify "partial"
 # options, so setting file.filename but leaving the rest as specified
 # by the user does not make sense.
-qemu_comm_method=monitor \
-    _launch_qemu -blockdev "$not_vmdk_opts" -blockdev "$overlay_opts"
+_launch_qemu -blockdev "$not_vmdk_opts" -blockdev "$overlay_opts"
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "return"
 
 # Should fail (gracefully)
-_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'failed'
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }" \
+    "error"
 
 _cleanup_qemu
 
diff --git a/tests/qemu-iotests/225.out b/tests/qemu-iotests/225.out
index beb8c23bd330..a5815afd0f0c 100644
--- a/tests/qemu-iotests/225.out
+++ b/tests/qemu-iotests/225.out
@@ -5,20 +5,25 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Testing fitting VMDK backing image ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io overlay "read 0 512"
-read 512/512 bytes at offset 0
-512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }
+{"return": {"human-readable-text": "read 512/512 bytes at offset 0\n512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 === Testing unrelated VMDK backing image ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io overlay "read 0 512"
-Error: read failed: Invalid argument
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }
+{"error": {"class": "GenericError", "desc": "read failed: Invalid argument"}}
 
 === Testing non-VMDK backing image ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io overlay "read 0 512"
-Error: read failed: Invalid argument
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'overlay', 'command': 'read 0 512' } }
+{"error": {"class": "GenericError", "desc": "read failed: Invalid argument"}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


