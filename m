Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2830C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972t-0002ID-RA; Tue, 22 Sep 2026 16:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971j-0007gk-50
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971h-0000RZ-5K
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rKjJMz+aMh1Qy1H8vCbMANpylIxy65AnQsfSBm0aNs=;
 b=YNBYMtuG5JSVUSTv7LT+XWNlmgvU9sCIrWcrs5wvRqnAvKp92FmF0+/S+wZlJEQo7/JcGb
 MbjG5jOue2yRpFWz1p15gwte6fZIw/8gejzool2y1vtrtGgTau1eD7i9s2SgUo7uZpSt0D
 wt+IZT81nK4zXh2gkJHZYHGeub4zpsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-gu1_pmF2N_yfjC_urmPDKA-1; Tue,
 22 Sep 2026 16:23:39 -0400
X-MC-Unique: gu1_pmF2N_yfjC_urmPDKA-1
X-Mimecast-MFC-AGG-ID: gu1_pmF2N_yfjC_urmPDKA_1790108618
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5246B1977587; Tue, 22 Sep 2026 20:23:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82CCF1800370; Tue, 22 Sep 2026 20:23:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:22 +0400
Subject: [PATCH 75/88] qemu-iotests/153: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-75-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=7089;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wksABVwCBrRcsBjPGyVPTBIdEaRVbsmnl+BCoF7sNvs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzCsCZft3907lmRUJuZ2tNS8ZTR14Z7E8vq
 Vkc7URcKVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5b9XD/9GDjkFobqwI/yaoD5WMCxAICr7Z2aeR3TxzIDccXiM1VVZJyErFA7Uak9hWEckQNA2p8c
 Oa3FyYNU7Pxf6FbfHtRZq8f6gm/C2MzyNI1HEaGXmGDoPoMp9KBo4j/OTCU93WK35k8osa3GQhp
 RyonyGX/1BB1efj+6DKd/TdN+nmFN1gA/BpWx68sUFsdCArNIY9cS+DFnWG0A6Figt7mVx0uYUl
 K3INJTsxIqP1njA1B2Y7cacd4kG2UNbeceKKSvft9hb5bFKqMYZE/6jsvTq1cGH3w92HqEAQYr/
 D1KAuLqjLt7ENEYynHt9Fiyt78ptG3IMnV8+1NMP5JJEWDs7m7T/l7vAbf/TDDrWkHi6WpH+Cj/
 3zX8l46btM84tmcEZbbbklrTbKk3cTB5JaDSbz5UNn19chFywEDxrXKzkBg649DlYCyZf081JvC
 sT1wUXlp+ZznYRa6svUWWag3ib0LqyzQX6ax3xs6gWi6h/QA4SqA3oWtQaaCZBY1j1tevhlwDZx
 pNXJo/G+g+GN/qotA3K7GY0xelHljcUDbMtjj2KxSQS0ia4CsGxU9eehtJJiUwWu4yuk7lKAhNB
 U0zFWPTo40TrRwjkVGOxSV4eqbzt+3Bz7yl0bnd1LP4zxNv+J+P14N6kdgN6j01MsIJPQoykesq
 PJxcK/W5Y5U4lxw==
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

Replace HMP drive_add/drive_del with QMP blockdev-add/blockdev-del.
Convert pipe-based monitor to QMP.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/153     | 37 +++++++++++++++++++++----------------
 tests/qemu-iotests/153.out | 44 ++++++++++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index def01d6f3ea4..12807c2cb5c1 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -59,7 +59,6 @@ _check_ofd || _notrun "OFD lock not available"
 
 _supported_fmt qcow2
 _supported_proto file
-_require_hmp
 
 _run_cmd()
 {
@@ -70,13 +69,14 @@ _run_cmd()
 _do_run_qemu()
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
-    ) | $QEMU -nographic -monitor stdio -serial none "$@" 1>/dev/null
+        echo '{"execute":"quit"}'
+    ) | $QEMU -nographic -qmp stdio -serial none "$@" 1>/dev/null
 }
 
 _run_qemu_with_images()
@@ -106,8 +106,8 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
     for opts2 in "" "read-only=on" "read-only=on,force-share=on"; do
         echo
         echo "== Launching another QEMU, opts: '$opts2' =="
-        echo "quit" | \
-            $QEMU -nographic -monitor stdio \
+        printf '%s\n' '{"execute":"qmp_capabilities"}' '{"execute":"quit"}' | \
+            $QEMU -nographic -qmp stdio \
             -drive file="${TEST_IMG}",if=none,$opts2 2>&1 1>/dev/null | \
             _filter_testdir | _filter_qemu
     done
@@ -213,8 +213,10 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 echo "Adding drive"
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_add 0 if=none,id=d0,file=${TEST_IMG}' } }" \
+    "{ 'execute': 'blockdev-add',
+       'arguments': { 'driver': '$IMGFMT', 'node-name': 'd0',
+                      'file': { 'driver': 'file',
+                                'filename': '${TEST_IMG}' } } }" \
     'return'
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
@@ -224,8 +226,8 @@ _run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" -F $IMGFMT "${TEST_IMG}.ov
 
 echo "== Closing an image should unlock it =="
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d0' } }" \
+    "{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd0' } }" \
     'return'
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
@@ -233,24 +235,27 @@ _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 echo "Adding two and closing one"
 for d in d0 d1; do
     _send_qemu_cmd $QEMU_HANDLE \
-        "{ 'execute': 'human-monitor-command',
-           'arguments': { 'command-line': 'drive_add 0 if=none,id=$d,file=${TEST_IMG},readonly=on' } }" \
+        "{ 'execute': 'blockdev-add',
+           'arguments': { 'driver': '$IMGFMT', 'node-name': '$d',
+                          'read-only': true,
+                          'file': { 'driver': 'file',
+                                    'filename': '${TEST_IMG}' } } }" \
         'return'
 done
 
 _run_cmd $QEMU_IMG info "${TEST_IMG}"
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d0' } }" \
+    "{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd0' } }" \
     'return'
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 
 echo "Closing the other"
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d1' } }" \
+    "{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd1' } }" \
     'return'
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 1607a79b36b7..90d0ac660a1f 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -425,9 +425,11 @@ _qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 Adding drive
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_add 0 if=none,id=d0,file=TEST_DIR/t.IMGFMT' } }
-{"return": "OKrn"}
+{ 'execute': 'blockdev-add',
+       'arguments': { 'driver': 'IMGFMT', 'node-name': 'd0',
+                      'file': { 'driver': 'file',
+                                'filename': 'TEST_DIR/t.IMGFMT' } } }
+{"return": {}}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
@@ -436,31 +438,37 @@ Creating overlay with qemu-img when the guest is running should be allowed
 
 _qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 -F qcow2 TEST_DIR/t.qcow2.overlay
 == Closing an image should unlock it ==
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d0' } }
-{"return": ""}
+{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd0' } }
+{"return": {}}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 Adding two and closing one
-{ 'execute': 'human-monitor-command',
-           'arguments': { 'command-line': 'drive_add 0 if=none,id=d0,file=TEST_DIR/t.IMGFMT,readonly=on' } }
-{"return": "OKrn"}
-{ 'execute': 'human-monitor-command',
-           'arguments': { 'command-line': 'drive_add 0 if=none,id=d1,file=TEST_DIR/t.IMGFMT,readonly=on' } }
-{"return": "OKrn"}
+{ 'execute': 'blockdev-add',
+           'arguments': { 'driver': 'IMGFMT', 'node-name': 'd0',
+                          'read-only': true,
+                          'file': { 'driver': 'file',
+                                    'filename': 'TEST_DIR/t.IMGFMT' } } }
+{"return": {}}
+{ 'execute': 'blockdev-add',
+           'arguments': { 'driver': 'IMGFMT', 'node-name': 'd1',
+                          'read-only': true,
+                          'file': { 'driver': 'file',
+                                    'filename': 'TEST_DIR/t.IMGFMT' } } }
+{"return": {}}
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d0' } }
-{"return": ""}
+{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd0' } }
+{"return": {}}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Closing the other
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'drive_del d1' } }
-{"return": ""}
+{ 'execute': 'blockdev-del',
+       'arguments': { 'node-name': 'd1' } }
+{"return": {}}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 

-- 
2.56.0.rc0.29.g47ce80527c56


