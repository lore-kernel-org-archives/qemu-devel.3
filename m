Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D8FD4F07
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvX-0003nj-S6; Tue, 10 Mar 2026 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvS-0003WN-JH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvO-0000z9-Hn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYlE0CVt2AjKwTUBmdJU6SEJXf+8f020xSVMTSYvRP8=;
 b=CVGdtrOnoILWhtzwCtVHrfVeRIPtil+gDr6Dtfgzu+FKRk7Wz233ibV6vU/jpYaiiPPihv
 aqVwwpHE0EBltuzF6ufMPfCqntBp+qKq/I1J2kN09dB1gTy768Jk3TuwqVgEP5fPygwdtH
 oKDxmgpNDq1XND4m+XaPAUQP7SYPjrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-Twt1K90AMNOsjlm5-tPpXQ-1; Tue,
 10 Mar 2026 12:27:12 -0400
X-MC-Unique: Twt1K90AMNOsjlm5-tPpXQ-1
X-Mimecast-MFC-AGG-ID: Twt1K90AMNOsjlm5-tPpXQ_1773160031
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D93B180049D; Tue, 10 Mar 2026 16:27:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4689619560A6; Tue, 10 Mar 2026 16:27:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/28] iotests/308: Add multi-threading sanity test
Date: Tue, 10 Mar 2026 17:26:19 +0100
Message-ID: <20260310162622.333137-26-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Hanna Czenczek <hreitz@redhat.com>

Run qemu-img bench on a simple multi-threaded FUSE export to test that
it works.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-26-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/308     | 51 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/308.out | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index a83c6fc01fb..f4a06a522ef 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -441,6 +441,57 @@ $QEMU_IO -c 'read -P 0 0 64M' "$TEST_IMG" | _filter_qemu_io
 
 _cleanup_test_img
 
+echo
+echo '=== Multi-threading ==='
+
+# Just set up a null block device, export it (with multi-threading), and run
+# qemu-img bench on it (to get parallel requests)
+
+_launch_qemu
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'null-co',
+          'node-name': 'null'
+      } }" \
+    'return'
+
+for id in iothread{0,1,2,3}; do
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': '$id'
+          } }" \
+        'return'
+done
+
+echo
+
+iothreads="['iothread0', 'iothread1', 'iothread2', 'iothread3']"
+fuse_export_add \
+    'export' \
+    "'mountpoint': '$EXT_MP', 'iothread': $iothreads" \
+    'return' \
+    'null'
+
+echo
+$QEMU_IMG bench -f raw "$EXT_MP" |
+    sed -e 's/[0-9.]\+ seconds/X.XXX seconds/'
+echo
+
+fuse_export_del 'export'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'quit'}" \
+    'return'
+
+wait=yes _cleanup_qemu
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index ebeaf64b486..580cc94e92f 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -217,4 +217,60 @@ read 67108864/67108864 bytes at offset 0
 {"return": {}}
 read 67108864/67108864 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Multi-threading ===
+{'execute': 'qmp_capabilities'}
+{"return": {}}
+{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'null-co',
+          'node-name': 'null'
+      } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread0'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread1'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread2'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread3'
+          } }
+{"return": {}}
+
+{'execute': 'block-export-add',
+          'arguments': {
+              'type': 'fuse',
+              'id': 'export',
+              'node-name': 'null',
+              'mountpoint': 'TEST_DIR/t.IMGFMT.fuse', 'iothread': ['iothread0', 'iothread1', 'iothread2', 'iothread3']
+          } }
+{"return": {}}
+
+Sending 75000 read requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 4096)
+Run completed in X.XXX seconds.
+
+{'execute': 'block-export-del',
+          'arguments': {
+              'id': 'export'
+          } }
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{'execute': 'quit'}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
-- 
2.53.0


