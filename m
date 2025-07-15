Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6EC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublYl-0002sx-87; Tue, 15 Jul 2025 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxK-0004Ad-Ea
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxI-0001Qg-5m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwgv47YLUvO/F34uGxNiYd+WQOW4mbMcciSwO93qLOg=;
 b=EfpK9PG48idQ22HsV6SI/PA3KM/FOy9N1g6RZAqrEEO0JpxNypJc0uoXeirT1CZsAcoMFw
 XMJ2vOnJy/o8mTc/wg2WUnpc8QjSCZFyrxhvbaebPAWW2i3dkvfkZFSLDUJgm43rmdBZSe
 EPLiEna4yXTS42Rz/KQ2I4fQAnv4bvM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-TUJmSdTaPyOVv6sPNnbCEg-1; Tue,
 15 Jul 2025 15:04:41 -0400
X-MC-Unique: TUJmSdTaPyOVv6sPNnbCEg-1
X-Mimecast-MFC-AGG-ID: TUJmSdTaPyOVv6sPNnbCEg_1752606281
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4C6B19560B3; Tue, 15 Jul 2025 19:04:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C62E197702B; Tue, 15 Jul 2025 19:04:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 30/57] iotests: add test for changing the 'drive' property via
 'qom-set'
Date: Tue, 15 Jul 2025 21:03:03 +0200
Message-ID: <20250715190330.378764-31-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250605100938.43133-1-f.ebner@proxmox.com>
[kwolf: Fixed up pylint warnings flagged by 297]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/qom-set-drive     | 75 ++++++++++++++++++++++
 tests/qemu-iotests/tests/qom-set-drive.out | 11 ++++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/qom-set-drive
 create mode 100644 tests/qemu-iotests/tests/qom-set-drive.out

diff --git a/tests/qemu-iotests/tests/qom-set-drive b/tests/qemu-iotests/tests/qom-set-drive
new file mode 100755
index 0000000000..ec8ddac4fd
--- /dev/null
+++ b/tests/qemu-iotests/tests/qom-set-drive
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# group: quick
+#
+# Test how changing the 'drive' property via 'qom-set' behaves.
+#
+# Copyright (C) Proxmox Server Solutions GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import iotests
+from iotests import imgfmt, log, qemu_img_create, QMPTestCase
+
+image_size = 1 * 1024 * 1024
+images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 4)]
+
+class TestQOMSetDrive(QMPTestCase):
+    def setUp(self) -> None:
+        for image in images:
+            qemu_img_create('-f', imgfmt, image, str(image_size))
+
+        self.vm = iotests.VM()
+        for i, image in enumerate(images):
+            self.vm.add_blockdev(self.vm.qmp_to_opts({
+                'driver': imgfmt,
+                'node-name': f'node{i}',
+                'file': {
+                    'driver': 'file',
+                    'filename': image,
+                }
+            }))
+        self.vm.add_object('iothread,id=iothread0')
+        self.vm.add_device('virtio-scsi,iothread=iothread0')
+        self.vm.add_device('scsi-hd,id=iot,drive=node0')
+        self.vm.add_device('virtio-scsi')
+        self.vm.add_device('scsi-hd,id=no-iot,drive=node1')
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        for image in images:
+            os.remove(image)
+
+    def test_qom_set_drive(self) -> None:
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/iot',
+                        property='drive'))
+        log(self.vm.qmp('qom-set', path='/machine/peripheral/iot',
+                        property='drive', value='node2'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/iot',
+                        property='drive'))
+
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+        log(self.vm.qmp('qom-set', path='/machine/peripheral/no-iot',
+                        property='drive', value='node3'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+
+if __name__ == '__main__':
+    iotests.activate_logging()
+    # LUKS would require special key-secret handling in add_blockdevs()
+    iotests.main(supported_fmts=['generic'],
+                 unsupported_fmts=['luks'])
diff --git a/tests/qemu-iotests/tests/qom-set-drive.out b/tests/qemu-iotests/tests/qom-set-drive.out
new file mode 100644
index 0000000000..7fc243dca6
--- /dev/null
+++ b/tests/qemu-iotests/tests/qom-set-drive.out
@@ -0,0 +1,11 @@
+{"return": "node0"}
+{"error": {"class": "GenericError", "desc": "Different aio context is not supported for new node"}}
+{"return": "node0"}
+{"return": "node1"}
+{"return": {}}
+{"return": "node3"}
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.50.1


