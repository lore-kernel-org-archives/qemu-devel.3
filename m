Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E741AC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdngV-0004Po-9k; Fri, 31 Jan 2025 04:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngT-0004Nl-7d
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngR-0002oi-M5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738317090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkCHPTSgu46sKfQlR+iwsxq9+VZrqAq4gn91UtuoshE=;
 b=Gjttsxf218U1Q6l57aIy7Q4EO8DvE3kEXlTkjNrO5QGxDqr/FBThnN7ZEP6UtppZPiozXR
 1aQa1jzZ1YpOoIDhGhk3/aTD4hfNSfbvsVv69Jr+9zfKYmVp1dTgkVym1SnkYTGunPay8d
 d1BPeg8YncvBL7mf3OyAvDfpKHoWSgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-KySP6KshOSiOOXJ9yIg8Qw-1; Fri,
 31 Jan 2025 04:51:26 -0500
X-MC-Unique: KySP6KshOSiOOXJ9yIg8Qw-1
X-Mimecast-MFC-AGG-ID: KySP6KshOSiOOXJ9yIg8Qw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 006D11801F10; Fri, 31 Jan 2025 09:51:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1C81180098C; Fri, 31 Jan 2025 09:51:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 13/15] iotests: Add filter_qtest()
Date: Fri, 31 Jan 2025 10:50:49 +0100
Message-ID: <20250131095051.49708-4-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The open-coded form of this filter has been copied into enough tests
that it's better to move it into iotests.py.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py                 | 4 ++++
 tests/qemu-iotests/041                        | 4 +---
 tests/qemu-iotests/165                        | 4 +---
 tests/qemu-iotests/tests/copy-before-write    | 3 +--
 tests/qemu-iotests/tests/migrate-bitmaps-test | 7 +++----
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 19817c7353..9c9c908983 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -701,6 +701,10 @@ def _filter(_key, value):
 def filter_nbd_exports(output: str) -> str:
     return re.sub(r'((min|opt|max) block): [0-9]+', r'\1: XXX', output)
 
+def filter_qtest(output: str) -> str:
+    output = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', output)
+    output = re.sub(r'\n?\[I \+\d+\.\d+\] CLOSED\n?$', '', output)
+    return output
 
 Msg = TypeVar('Msg', Dict[str, Any], List[Any], str)
 
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 98d17b1388..8452845f44 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1100,10 +1100,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         # Check the full error message now
         self.vm.shutdown()
-        log = self.vm.get_log()
-        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+        log = iotests.filter_qtest(self.vm.get_log())
         log = re.sub(r'^Formatting.*\n', '', log)
-        log = re.sub(r'\n\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
         log = re.sub(r'^%s: ' % os.path.basename(iotests.qemu_prog), '', log)
 
         self.assertEqual(log,
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b24907a62f..b3b1709d71 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -82,9 +82,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         self.vm.shutdown()
 
         #catch 'Persistent bitmaps are lost' possible error
-        log = self.vm.get_log()
-        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
-        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        log = iotests.filter_qtest(self.vm.get_log())
         if log:
             print(log)
 
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index d33bea577d..498c558008 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -95,8 +95,7 @@ class TestCbwError(iotests.QMPTestCase):
 
         self.vm.shutdown()
         log = self.vm.get_log()
-        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
-        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        log = iotests.filter_qtest(log)
         log = iotests.filter_qemu_io(log)
         return log
 
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index f98e721e97..8fb4099201 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -122,11 +122,10 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
         # catch 'Could not reopen qcow2 layer: Bitmap already exists'
         # possible error
-        log = self.vm_a.get_log()
-        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
-        log = re.sub(r'^(wrote .* bytes at offset .*\n.*KiB.*ops.*sec.*\n){3}',
+        log = iotests.filter_qtest(self.vm_a.get_log())
+        log = re.sub(r'^(wrote .* bytes at offset .*\n'
+                     r'.*KiB.*ops.*sec.*\n?){3}',
                      '', log)
-        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
         self.assertEqual(log, '')
 
         # test that bitmap is still persistent
-- 
2.48.1


