Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CFFC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x973k-0003la-Ms; Tue, 22 Sep 2026 16:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9727-0000g1-Qo
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9720-0000Wx-SP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqog62RpVQHtXn7Z53NynEn45ORAoRbqVTbtVT6ia1s=;
 b=YkvY9wMZp2fVHKau8+h1Zh/1FFlDjFMROSRYQowYdG3w0nT5i7/blmgEvKu9ZxasmXhzV5
 IlLeqtRDlzAHFOIP3glA2wMwTY4Vf+n7hEcCKSUdGKNv/3ymRiivcbEbYehOkZKX0HvXLD
 NEVczj0fLNbPKJu/sfrz46pKLJjXTR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-3wpmqzxUOgyvCpVV4UINdQ-1; Tue,
 22 Sep 2026 16:23:56 -0400
X-MC-Unique: 3wpmqzxUOgyvCpVV4UINdQ-1
X-Mimecast-MFC-AGG-ID: 3wpmqzxUOgyvCpVV4UINdQ_1790108636
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E23E0180AA59; Tue, 22 Sep 2026 20:23:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F390A1956086; Tue, 22 Sep 2026 20:23:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:27 +0400
Subject: [PATCH 80/88] qemu-iotests/192: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-80-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=STnE9fKOhDDMVPXAxHVL1ePns70Xw7kAsVCiZzRqt0k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0dLYHYqOzBzLqy7q8cATus4s4KAUukj/Xx
 3DmctWXcE6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5dcTEACHeXXy8ZSHFJiFrAeWZYKaSFAf3/4EijIJ2EN+i8k9rPxAOKRNm8qyeGcnG0KLNh3m1pW
 UCgMa4tOMjn14L8/UuU04mhHigcPp9McbNpE19NwazcwFoXOEqr92/LTT5hzMv0ZFxOtHnqcstB
 XQRqBHFN9sd5Hli2gJEpt/dSgEGnzyEX3XtmP7YpaE+/OH/KJ4zy4mspaQSGLKSpUjh/xVmVJDo
 3INYhvQ/jV3LrkTe2X0fC25iD9GtkclG6zfgYTS+6+kHCrWDSNJP6DZUFO0rgi2VU61bhjGx0jv
 BcjYxL6Bhqij/t2WYh0AYOjehf60Qp7krg1zXB2vkeQFQOGsoy8HiM5zs2v6bzd6TjExVy7t3Gz
 OuWcT5XsEBOg0xtDEnOA+h/30pd5DhhAOamIfKuySTMKhVLRb/VE1+McpQECv4ZeTRyr+cneF4g
 cl4sr2SXD0jSZ36iZ1bJ25wqT0GmWt8v71Sd9xqOrGNfaZ+qYCrjCTXHtrqyaEx3KvNUA0UCqzW
 hp6i8+sr3BsEqVYqRUX8ZFgk/grq1WFC1XqjUY7OGbYpBLljs4XHRVVONyHgPtl+gadk6ET2KIC
 bXh1rwomCTtFHJFSM8cleKdK4uSV2T4CDf3s3VnFI0v7xrnWQKUhwuiTJ7W8aVvRkoJQeOR2qVU
 cC5QjdqVgnxWaiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace HMP nbd_server_start/nbd_server_add with QMP
nbd-server-start/nbd-server-add.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/192     | 25 ++++++++++++++++++++-----
 tests/qemu-iotests/192.out | 17 +++++++++++++----
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 6869bd171537..080aff368815 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -43,7 +43,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
@@ -59,7 +58,6 @@ else
     DRIVE_ARG=if=ide,id=drive0,format=$IMGFMT,file=$TEST_IMG
 fi
 
-qemu_comm_method="monitor"
 _launch_qemu -drive $DRIVE_ARG -incoming defer
 h=$QEMU_HANDLE
 if [ "${VALGRIND_QEMU}" == "y" ]; then
@@ -68,9 +66,26 @@ else
     QEMU_COMM_TIMEOUT=1
 fi
 
-_send_qemu_cmd $h "nbd_server_start unix:$SOCK_DIR/nbd" "(qemu)"
-_send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
-_send_qemu_cmd $h "q" "(qemu)"
+_send_qemu_cmd $h \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': '$SOCK_DIR/nbd' } } } }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'drive0', 'writable': true } }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'quit' }" \
+    'return'
+
+wait=1 _cleanup_qemu
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/192.out b/tests/qemu-iotests/192.out
index b9429dbe3679..88185a2e8ff4 100644
--- a/tests/qemu-iotests/192.out
+++ b/tests/qemu-iotests/192.out
@@ -1,7 +1,16 @@
 QA output created by 192
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:SOCK_DIR/nbd
-(qemu) nbd_server_add -w drive0
-(qemu) q
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': 'SOCK_DIR/nbd' } } } }
+{"return": {}}
+{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'drive0', 'writable': true } }
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "drive0"}}
+{"return": {}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


