Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CD606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbcGNzuZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cN-0006OI-GK; Mon, 02 Nov 2026 22:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cM-0006Nk-0t
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cK-0000aO-96
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBSdWXyr2z5Qa5bk8zHw/mmsn+OzV2/YeeQlS+BdwYU=;
 b=VbcGNzuZz3v/w/kQ9wIzlFAy1Soo+8Wxds4tiyNI48DLo1pwPMiD8gEo0tM27KVKaEbsyz
 A8MACrh49U6BrYNpid9UaRKj4UGwwSPJQfCzsO2Y24TDbHOA0PZpCmky4xkOt5Lz6IYEXO
 T9isybzqA2FnsK5g137rvuKEVP+kBJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-cNg6cYD-PmyaQhZuxSADcQ-1; Mon,
 02 Nov 2026 22:55:20 -0500
X-MC-Unique: cNg6cYD-PmyaQhZuxSADcQ-1
X-Mimecast-MFC-AGG-ID: cNg6cYD-PmyaQhZuxSADcQ_1793678119
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D7E1800758; Tue,  3 Nov 2026 03:55:18 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96A287E2; Tue,  3 Nov 2026 03:55:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 04/16] tests/qemu-iotests/qom-set-drive: replace with a
 differently sized node
Date: Mon,  2 Nov 2026 21:54:15 -0600
Message-ID: <20261103035506.2688772-22-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

From: "Denis V. Lunev" <den@openvz.org>

All images in this test have the same size, so the test never reaches
the size change path of bdrv_replace_child_bs(). Add a node of a
different size and point a device at it.

The notification itself is not visible over QMP, so this only covers the
block layer side. What the device does with it is checked by
tests/qtest/virtio-scsi-test.c.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260812121500.1034178-5-den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/qom-set-drive     | 14 +++++++++++---
 tests/qemu-iotests/tests/qom-set-drive.out |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/qom-set-drive b/tests/qemu-iotests/tests/qom-set-drive
index ec8ddac4fdd..52d7eb96da8 100755
--- a/tests/qemu-iotests/tests/qom-set-drive
+++ b/tests/qemu-iotests/tests/qom-set-drive
@@ -24,12 +24,15 @@ import iotests
 from iotests import imgfmt, log, qemu_img_create, QMPTestCase

 image_size = 1 * 1024 * 1024
-images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 4)]
+images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 5)]
+
+# node4 is deliberately larger, to cover a replacement which changes the size
+image_sizes = [image_size] * 4 + [2 * image_size]

 class TestQOMSetDrive(QMPTestCase):
     def setUp(self) -> None:
-        for image in images:
-            qemu_img_create('-f', imgfmt, image, str(image_size))
+        for image, size in zip(images, image_sizes):
+            qemu_img_create('-f', imgfmt, image, str(size))

         self.vm = iotests.VM()
         for i, image in enumerate(images):
@@ -68,6 +71,11 @@ class TestQOMSetDrive(QMPTestCase):
         log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
                         property='drive'))

+        log(self.vm.qmp('qom-set', path='/machine/peripheral/no-iot',
+                        property='drive', value='node4'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+
 if __name__ == '__main__':
     iotests.activate_logging()
     # LUKS would require special key-secret handling in add_blockdevs()
diff --git a/tests/qemu-iotests/tests/qom-set-drive.out b/tests/qemu-iotests/tests/qom-set-drive.out
index 7fc243dca6c..6f6e5e2b31c 100644
--- a/tests/qemu-iotests/tests/qom-set-drive.out
+++ b/tests/qemu-iotests/tests/qom-set-drive.out
@@ -4,6 +4,8 @@
 {"return": "node1"}
 {"return": {}}
 {"return": "node3"}
+{"return": {}}
+{"return": "node4"}
 .
 ----------------------------------------------------------------------
 Ran 1 tests
-- 
2.56.0


