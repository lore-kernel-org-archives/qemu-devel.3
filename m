Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236E9D2CDFF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4e-0000S9-E8; Tue, 22 Oct 2024 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4b-0000L5-EE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4Y-00066W-Li
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWd8qSFRMUXHBUD1J9oD9i5oR04LJMY81kwu8tgABa4=;
 b=NV6d7iEcRBCRSzSxYPjv4oIlL5p6Lkma2QYGVZ6nYomAVwC+GDtYT+d37Zl4VS42uOT+Z4
 ytKIzVdJFENAXAe4rsn2gUnCis5IXQfbhib/ZVl/5u5fYahu2Wd7dV7wN0qzAVG6SWH9i7
 vh/zFaEMJo2n6irFwar4lx1YCxTHZak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-32XfN1m5NDGFWcI3zK7F4g-1; Tue,
 22 Oct 2024 12:49:26 -0400
X-MC-Unique: 32XfN1m5NDGFWcI3zK7F4g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C2F419560BF; Tue, 22 Oct 2024 16:49:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 699B21955EA5; Tue, 22 Oct 2024 16:49:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 5/9] iotests/backup-discard-source: convert size variable to be
 int
Date: Tue, 22 Oct 2024 18:48:59 +0200
Message-ID: <20241022164903.282174-6-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Make variable reusable in code for checks. Don't care to change "512 *
1024" invocations as they will be dropped in the next commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20240620144402.65896-2-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/backup-discard-source | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 2391b12acd..05fbe5d26b 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -28,7 +28,7 @@ from iotests import qemu_img_create, qemu_img_map, qemu_io
 temp_img = os.path.join(iotests.test_dir, 'temp')
 source_img = os.path.join(iotests.test_dir, 'source')
 target_img = os.path.join(iotests.test_dir, 'target')
-size = '1M'
+size = 1024 * 1024
 
 
 def get_actual_size(vm, node_name):
@@ -39,9 +39,9 @@ def get_actual_size(vm, node_name):
 
 class TestBackup(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img_create('-f', iotests.imgfmt, source_img, size)
-        qemu_img_create('-f', iotests.imgfmt, temp_img, size)
-        qemu_img_create('-f', iotests.imgfmt, target_img, size)
+        qemu_img_create('-f', iotests.imgfmt, source_img, str(size))
+        qemu_img_create('-f', iotests.imgfmt, temp_img, str(size))
+        qemu_img_create('-f', iotests.imgfmt, target_img, str(size))
         qemu_io('-c', 'write 0 1M', source_img)
 
         self.vm = iotests.VM()
@@ -98,7 +98,7 @@ class TestBackup(iotests.QMPTestCase):
         mapping = qemu_img_map(temp_img)
         self.assertEqual(len(mapping), 1)
         self.assertEqual(mapping[0]['start'], 0)
-        self.assertEqual(mapping[0]['length'], 1024 * 1024)
+        self.assertEqual(mapping[0]['length'], size)
         self.assertEqual(mapping[0]['data'], False)
 
         os.remove(temp_img)
@@ -125,7 +125,7 @@ class TestBackup(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', '')
 
         # Check that data is written to temporary image
-        self.assertGreater(get_actual_size(self.vm, 'temp'), 1024 * 1024)
+        self.assertGreater(get_actual_size(self.vm, 'temp'), size)
 
         self.do_backup()
 
-- 
2.47.0


