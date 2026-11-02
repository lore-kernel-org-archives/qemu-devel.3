Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD1606A930
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fjy9agzJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvZ-0006Qi-UP; Mon, 02 Nov 2026 11:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvT-0006KP-Ua
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvP-00025Z-NC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQkNs56PL9QdUnEb3og/KIe5eouy38yAiSU7F0cBvck=;
 b=Fjy9agzJNTbhc3zkc55pOhYj5MD8gzXfRl+nmOlXgxcxvSEYhN4oDLnxYEzNfeKotcGRet
 Q1LkOiJVrbsLsFHddbYxk0RUtjF6Yk9Bx2sdyo0v2RCBjxErl73hECzLhUtaV2PQi4yeMM
 c/U+KFeSlkLWZLfREbKrPoiqI1DXjts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-9O4z6z4CN5aJU0Qo3pK7dg-1; Mon,
 02 Nov 2026 11:30:19 -0500
X-MC-Unique: 9O4z6z4CN5aJU0Qo3pK7dg-1
X-Mimecast-MFC-AGG-ID: 9O4z6z4CN5aJU0Qo3pK7dg_1793637018
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FED51801372; Mon,  2 Nov 2026 16:30:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B687D1956088; Mon,  2 Nov 2026 16:30:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/17] iotests/041: add tests for mirroring below throttle node
Date: Mon,  2 Nov 2026 17:29:46 +0100
Message-ID: <20261102162955.268763-9-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fiona Ebner <f.ebner@proxmox.com>

Test mirror with a non-root node as a source. This restriction was
dropped with commit "blockdev: mirror: do not require a root block
node".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20261006114240.478523-4-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041     | 40 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 2552388690c..abc070435df 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1434,10 +1434,19 @@ class TestThrottle(iotests.QMPTestCase):
                     bus='vio-scsi.0',
                     drive='throttle')
 
+        self.drive_qdev = '/machine/peripheral/virtio'
+
     def tearDown(self):
         os.remove(test_img)
         os.remove(target_img)
 
+    def blockstats(self, device):
+        result = self.vm.qmp("query-blockstats")
+        for r in result['return']:
+            if r['node-name'] == device:
+                return r['stats']
+        raise Exception(f'Device {device} not found when querying blockstats')
+
     def test_throttled(self):
         self.mirror_command('throttle')
 
@@ -1451,6 +1460,37 @@ class TestThrottle(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
+    def test_below_throttle(self):
+        self.mirror_command('source')
+
+        # The throttling above should not block the mirror from completing.
+        self.complete_and_wait('mirror')
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
+    def test_below_throttle_with_io_on_throttle(self):
+        self.mirror_command('source')
+
+        reqs = 3
+        req_len = 1 * 1024
+
+        for i in range(0, reqs):
+            req = f'aio_write -P 7 {i}M {req_len}'
+            self.vm.hmp_qemu_io(self.drive_qdev, req, qdev=True)
+
+        self.wait_ready('mirror')
+        # The throttle node above should still have in-flight requests.
+        assert self.blockstats('throttle')['wr_bytes'] <= 1 * req_len
+
+        self.complete_and_wait('mirror', wait_ready=False)
+        assert self.blockstats('throttle')['wr_bytes'] == reqs * req_len
+        self.vm.shutdown()
+        # The throttle node above is drained too when the mirror finishes, so
+        # the images should match.
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
 class TestThrottleDriveMirror(TestThrottle):
     attachTargetImage = False
 
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 96a0752f444..ec055a99151 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.............................................................................................................
+.................................................................................................................
 ----------------------------------------------------------------------
-Ran 109 tests
+Ran 113 tests
 
 OK
-- 
2.56.0


