Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEBAC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971E-0004Aa-Dt; Tue, 22 Sep 2026 16:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970P-0001kq-O6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970O-0000GF-6C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTe4G7jBG9AAaRJLDixw2fc4uEWZ9fiZ87WTE8GiHC0=;
 b=i9Lm375JsUiwD2gz3BmcF+PUJ9IKynqV4/KO+jjoHDDPUHlCG6isRreS/GuxfPsUObETDt
 HEDKhzcxVoeS0TLbcI4CoknTiBuTsvyjMKhw/CpncJ+ZoQwFRhuqkXFZ0+QA98/ygu8iD1
 ZA0jsycmwn8eYbcNDBaowEW52NpvpSs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-TNpjK11JNpeV4tBSfa0xGw-1; Tue,
 22 Sep 2026 16:22:16 -0400
X-MC-Unique: TNpjK11JNpeV4tBSfa0xGw-1
X-Mimecast-MFC-AGG-ID: TNpjK11JNpeV4tBSfa0xGw_1790108535
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5665D1800634; Tue, 22 Sep 2026 20:22:15 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 677061956095; Tue, 22 Sep 2026 20:22:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:59 +0400
Subject: [PATCH 52/88] qemu-iotests/286: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-52-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n3hpqjipntq2EdIp7ypds4WHL/NuysC86fXwJJTYW7k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxaNHBiphnE+WbzxmYOM2YR1HxEgMb6DaBv
 oezVy61Z2KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5c28D/4z4/MTmFrA9ohpCwL1FvMsC31NeoKz1+M35eHbbErHsBZjxJ6758G65l6ua//9m6WYJlY
 hOxWa32BTK/dlZU7qhlntP3SdgqD1h6XPlu6pt0nHDJFQB2Ow8iWLCaaBLlw/yQAe0H0BSBjlm0
 XI3Iqq2t81jJ7AYUX3bG/liwTBdSiEvVWXL4+7ymtRkBYlrcG/QV7SmQzuenrNldn0JC+qNR4MR
 zLkbnb9gHuHxSXlYuG+zxxvaSOACpxOn2j2+mpkXOFG6MhLXC5uktmgtWZqBpDaln+crayXG/Gt
 PFhQs3IBWvkKoEeVTt8B9nPNiaUDPNgqBAk+28tr7TWPMAQ4I4kMNpO/PgAjdZl2e8NwK71nQqF
 37xOXyxsU5x+D0WRc64a7zrWYZRwEADQFQtcJjTxSueNhbVAquwV3CXGxf3//04/CtqeDFPsb9V
 ihKcKeaFE6dNmhG4Dm86l+hZ4Hqk+YcQ80iMLM+X58W5F7SFrsm+2yD/lQC2VnTsS4pHSuFnk2X
 Gcvda3U9dTTRg4KMYN+e1M7Mb81X1zpkp69KgQc5nOD/yD5/HlPfI1+p2MqL0aCimeH1mElWpw6
 zFtLC1gdjun9Vy6DeH9uLNV5RTTuwvGvmiAtAkCf3ybjowNiz5iN/dC3MaH8rSOw/fG985fQMpL
 POSlxSZ6BmktCQA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Replaced qemu_comm_method=monitor _launch_qemu -m 512 "$TEST_IMG" with
_launch_qemu using -blockdev to set explicit node names (disk0-file and
disk0), and HMP savevm with QMP snapshot-save (job-based), waiting for
"concluded" status.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/286     | 15 +++++++++++----
 tests/qemu-iotests/286.out |  8 +++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index 3b030ec58aa0..565a960e9eb3 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -40,7 +40,6 @@ _supported_proto file fuse
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
-_require_hmp
 
 _make_test_img 64M
 
@@ -49,10 +48,18 @@ sn_name=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
 
 # More memory will give us a larger VM state, i.e. one above 1 MB.
 # This way, we get a number with a decimal point.
-qemu_comm_method=monitor _launch_qemu -m 512 "$TEST_IMG"
+_launch_qemu -m 512 \
+    -blockdev driver=file,filename="$TEST_IMG",node-name=disk0-file \
+    -blockdev driver=$IMGFMT,file=disk0-file,node-name=disk0
 
-_send_qemu_cmd $QEMU_HANDLE "savevm $sn_name" '(qemu)'
-_send_qemu_cmd $QEMU_HANDLE 'quit' '(qemu)'
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
+silent=yes _run_qmp_job $QEMU_HANDLE 'save0' \
+    "{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save0',
+                      'tag': '$sn_name',
+                      'vmstate': 'disk0',
+                      'devices': ['disk0'] } }"
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
 wait=yes _cleanup_qemu
 
 # Check that all fields are separated by spaces.
diff --git a/tests/qemu-iotests/286.out b/tests/qemu-iotests/286.out
index bb04748e0808..33f1905a45ce 100644
--- a/tests/qemu-iotests/286.out
+++ b/tests/qemu-iotests/286.out
@@ -1,8 +1,10 @@
 QA output created by 286
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 Output structure:
 (snapshot ID) (snapshot name) (VM state size value) (VM state size unit) (snapshot date) (snapshot time) (VM clock) (icount)
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


