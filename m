Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B40608A343
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3u+vMOS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvY-0006Ot-Jb; Mon, 02 Nov 2026 11:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvS-0006II-Hn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvP-000255-Jf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ML4m83i15qnRt4CcXdfr6a4fUCRjsSM/4T00NzGK5A=;
 b=D3u+vMOSLEdmOQs8HskprJTmMK9RO0kllg/LymT0OV4eRWf4XRl4BZ2WlyipYpXzxF7/fI
 ouvJPsjTIknGUx9ow/e4kUNDVi694unQAeo42G/m41jK4SJR1LfBdLeASmXqXtZeXdh9LG
 tBU6fnPKvEoQriNRezXupLtq8GoGq2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-dfQvR2D3MVyn7tmT6c-CBQ-1; Mon,
 02 Nov 2026 11:30:15 -0500
X-MC-Unique: dfQvR2D3MVyn7tmT6c-CBQ-1
X-Mimecast-MFC-AGG-ID: dfQvR2D3MVyn7tmT6c-CBQ_1793637014
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 871001956056; Mon,  2 Nov 2026 16:30:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FCF11956087; Mon,  2 Nov 2026 16:30:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/17] iotests/041: add test for mirror with throttle node as
 source
Date: Mon,  2 Nov 2026 17:29:44 +0100
Message-ID: <20261102162955.268763-7-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mostly in preparation for commit "iotests/041: add tests for mirroring
below throttle node" which adds test cases for commit "blockdev:
mirror: do not require a root block node".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20261006114240.478523-2-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041     | 88 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 +-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8452845f448..2552388690c 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1373,6 +1373,94 @@ class TestFilters(iotests.QMPTestCase):
 
         self.complete_and_wait('mirror')
 
+class TestThrottle(iotests.QMPTestCase):
+    image_len = 3 * 1024 * 1024
+    attachTargetImage = True
+
+    def mirror_command(self, device):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device=device,
+                    target='target',
+                    sync='full')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt,
+                 test_img, str(self.image_len))
+        qemu_img('create', '-f', iotests.imgfmt,
+                 target_img, str(self.image_len))
+        qemu_io('-c', 'write -P 23 0 3M', test_img)
+
+        self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
+        self.vm.launch()
+
+        self.vm.cmd('object-add', {
+                        'id': 'thrgr0',
+                        'qom-type': 'throttle-group',
+                        'limits': {
+                            'bps-total': 1 * 1024
+                        }
+                    })
+
+        if self.attachTargetImage:
+            self.vm.cmd('blockdev-add', {
+                            'node-name': 'target',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': target_img
+                            },
+                        })
+
+        source = {
+            'node-name': 'source',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': test_img
+            },
+        }
+
+        self.vm.cmd('blockdev-add', {
+                        'node-name': 'throttle',
+                        'driver': 'throttle',
+                        'throttle-group': 'thrgr0',
+                        'file': source,
+                    })
+
+        self.vm.cmd('device_add',
+                    driver='scsi-hd',
+                    id='virtio',
+                    bus='vio-scsi.0',
+                    drive='throttle')
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(target_img)
+
+    def test_throttled(self):
+        self.mirror_command('throttle')
+
+        time.sleep(1)
+        result = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(result, 'return[0]/ready', False)
+
+        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000 * 1000}')
+        self.complete_and_wait('mirror')
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
+class TestThrottleDriveMirror(TestThrottle):
+    attachTargetImage = False
+
+    def mirror_command(self, device):
+        self.vm.cmd('drive-mirror',
+                    job_id='mirror',
+                    device=device,
+                    target=target_img,
+                    sync='full',
+                    mode='existing')
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 46651953e88..96a0752f444 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-...........................................................................................................
+.............................................................................................................
 ----------------------------------------------------------------------
-Ran 107 tests
+Ran 109 tests
 
 OK
-- 
2.56.0


