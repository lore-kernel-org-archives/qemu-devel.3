Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F0C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRWN-0003st-2v; Fri, 09 Feb 2024 09:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRW1-0003NS-27
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:06:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVy-0004Pm-Iw
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOtlDkkTa3GleU1CyjlxJoIy6uWxwEwTrEVVgffK/jk=;
 b=AGwmqzpWklrUMUBbVdW3ceazyJZ47bZhBTAB10UOt7RVma5KUU8uI8rk+4+b8feA3Nb8Kq
 Tbxv/hClBcsXxbwrF3s5/iujIBxDjjuRfx3CFWnwFUSXokxSyAfuPy4ASuN5V8fm5+v9+5
 SrP/Usm87lpZ0Jg8wb8K1qn8GE76aL4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-H9mBTrJEOf21P5i-zCvoqw-1; Fri,
 09 Feb 2024 09:05:56 -0500
X-MC-Unique: H9mBTrJEOf21P5i-zCvoqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27F831C0F47A;
 Fri,  9 Feb 2024 14:05:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A431311217;
 Fri,  9 Feb 2024 14:05:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/17] tests: Add case for LUKS volume with detached header
Date: Fri,  9 Feb 2024 14:05:05 +0000
Message-ID: <20240209140505.2536635-18-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Also, add a section to the MAINTAINERS file for detached
LUKS header, it only has a test case in it currently.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                                   |   5 +
 tests/qemu-iotests/tests/luks-detached-header | 316 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 3 files changed, 326 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898..f80db6a96a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3402,6 +3402,11 @@ F: migration/dirtyrate.c
 F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
 
+Detached LUKS header
+M: Hyman Huang <yong.huang@smartx.com>
+S: Maintained
+F: tests/qemu-iotests/tests/luks-detached-header
+
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Maintained
diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-iotests/tests/luks-detached-header
new file mode 100755
index 0000000000..3455fd8de1
--- /dev/null
+++ b/tests/qemu-iotests/tests/luks-detached-header
@@ -0,0 +1,316 @@
+#!/usr/bin/env python3
+# group: rw auto
+#
+# Test LUKS volume with detached header
+#
+# Copyright (C) 2024 SmartX Inc.
+#
+# Authors:
+#     Hyman Huang <yong.huang@smartx.com>
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
+import json
+import iotests
+from iotests import (
+    imgfmt,
+    qemu_img_create,
+    qemu_img_info,
+    QMPTestCase,
+)
+
+
+image_size = 128 * 1024 * 1024
+
+luks_img = os.path.join(iotests.test_dir, "luks.img")
+detached_header_img1 = os.path.join(iotests.test_dir, "detached_header.img1")
+detached_header_img2 = os.path.join(iotests.test_dir, "detached_header.img2")
+detached_payload_raw_img = os.path.join(
+    iotests.test_dir, "detached_payload_raw.img"
+)
+detached_payload_qcow2_img = os.path.join(
+    iotests.test_dir, "detached_payload_qcow2.img"
+)
+detached_header_raw_img = "json:" + json.dumps(
+    {
+        "driver": "luks",
+        "file": {"filename": detached_payload_raw_img},
+        "header": {
+            "filename": detached_header_img1,
+        },
+    }
+)
+detached_header_qcow2_img = "json:" + json.dumps(
+    {
+        "driver": "luks",
+        "file": {"filename": detached_payload_qcow2_img},
+        "header": {"filename": detached_header_img2},
+    }
+)
+
+secret_obj = "secret,id=sec0,data=foo"
+luks_opts = "key-secret=sec0"
+
+
+class TestDetachedLUKSHeader(QMPTestCase):
+    def setUp(self) -> None:
+        self.vm = iotests.VM()
+        self.vm.add_object(secret_obj)
+        self.vm.launch()
+
+        # 1. Create the normal LUKS disk with 128M size
+        self.vm.blockdev_create(
+            {"driver": "file", "filename": luks_img, "size": 0}
+        )
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=luks_img,
+            node_name="luks-1-storage",
+        )
+        result = self.vm.blockdev_create(
+            {
+                "driver": imgfmt,
+                "file": "luks-1-storage",
+                "key-secret": "sec0",
+                "size": image_size,
+                "iter-time": 10,
+            }
+        )
+        # None is expected
+        self.assertEqual(result, None)
+
+        # 2. Create the LUKS disk with detached header (raw)
+
+        # Create detached LUKS header
+        self.vm.blockdev_create(
+            {"driver": "file", "filename": detached_header_img1, "size": 0}
+        )
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_header_img1,
+            node_name="luks-2-header-storage",
+        )
+
+        # Create detached LUKS raw payload
+        self.vm.blockdev_create(
+            {"driver": "file", "filename": detached_payload_raw_img, "size": 0}
+        )
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_payload_raw_img,
+            node_name="luks-2-payload-storage",
+        )
+
+        # Format LUKS disk with detached header
+        result = self.vm.blockdev_create(
+            {
+                "driver": imgfmt,
+                "header": "luks-2-header-storage",
+                "file": "luks-2-payload-storage",
+                "key-secret": "sec0",
+                "preallocation": "full",
+                "size": image_size,
+                "iter-time": 10,
+            }
+        )
+        self.assertEqual(result, None)
+
+        self.vm.shutdown()
+
+        # 3. Create the LUKS disk with detached header (qcow2)
+
+        # Create detached LUKS header using qemu-img
+        res = qemu_img_create(
+            "-f",
+            "luks",
+            "--object",
+            secret_obj,
+            "-o",
+            luks_opts,
+            "-o",
+            "detached-header=true",
+            detached_header_img2,
+        )
+        assert res.returncode == 0
+
+        # Create detached LUKS qcow2 payload
+        res = qemu_img_create(
+            "-f", "qcow2", detached_payload_qcow2_img, str(image_size)
+        )
+        assert res.returncode == 0
+
+    def tearDown(self) -> None:
+        os.remove(luks_img)
+        os.remove(detached_header_img1)
+        os.remove(detached_header_img2)
+        os.remove(detached_payload_raw_img)
+        os.remove(detached_payload_qcow2_img)
+
+        # Check if there was any qemu-io run that failed
+        if "Pattern verification failed" in self.vm.get_log():
+            print("ERROR: Pattern verification failed:")
+            print(self.vm.get_log())
+            self.fail("qemu-io pattern verification failed")
+
+    def test_img_creation(self) -> None:
+        # Check if the images created above are expected
+
+        data = qemu_img_info(luks_img)["format-specific"]
+        self.assertEqual(data["type"], imgfmt)
+        self.assertEqual(data["data"]["detached-header"], False)
+
+        data = qemu_img_info(detached_header_raw_img)["format-specific"]
+        self.assertEqual(data["type"], imgfmt)
+        self.assertEqual(data["data"]["detached-header"], True)
+
+        data = qemu_img_info(detached_header_qcow2_img)["format-specific"]
+        self.assertEqual(data["type"], imgfmt)
+        self.assertEqual(data["data"]["detached-header"], True)
+
+        # Check if preallocation works
+        size = qemu_img_info(detached_payload_raw_img)["actual-size"]
+        self.assertGreaterEqual(size, image_size)
+
+    def test_detached_luks_header(self) -> None:
+        self.vm.launch()
+
+        # 1. Add the disk created above
+
+        # Add normal LUKS disk
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=luks_img,
+            node_name="luks-1-storage",
+        )
+        result = self.vm.qmp_log(
+            "blockdev-add",
+            driver="luks",
+            file="luks-1-storage",
+            key_secret="sec0",
+            node_name="luks-1-format",
+        )
+
+        # Expected result{ "return": {} }
+        self.assert_qmp(result, "return", {})
+
+        # Add detached LUKS header with raw payload
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_header_img1,
+            node_name="luks-header1-storage",
+        )
+
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_payload_raw_img,
+            node_name="luks-2-payload-raw-storage",
+        )
+
+        result = self.vm.qmp_log(
+            "blockdev-add",
+            driver=imgfmt,
+            header="luks-header1-storage",
+            file="luks-2-payload-raw-storage",
+            key_secret="sec0",
+            node_name="luks-2-payload-raw-format",
+        )
+        self.assert_qmp(result, "return", {})
+
+        # Add detached LUKS header with qcow2 payload
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_header_img2,
+            node_name="luks-header2-storage",
+        )
+
+        self.vm.qmp_log(
+            "blockdev-add",
+            driver="file",
+            filename=detached_payload_qcow2_img,
+            node_name="luks-3-payload-qcow2-storage",
+        )
+
+        result = self.vm.qmp_log(
+            "blockdev-add",
+            driver=imgfmt,
+            header="luks-header2-storage",
+            file="luks-3-payload-qcow2-storage",
+            key_secret="sec0",
+            node_name="luks-3-payload-qcow2-format",
+        )
+        self.assert_qmp(result, "return", {})
+
+        # 2. Do I/O test
+
+        # Do some I/O to the image to see whether it still works
+        # (Pattern verification will be checked by tearDown())
+
+        # Normal LUKS disk
+        result = self.vm.qmp_log(
+            "human-monitor-command",
+            command_line='qemu-io luks-1-format "write -P 40 0 64k"',
+        )
+        self.assert_qmp(result, "return", "")
+
+        result = self.vm.qmp_log(
+            "human-monitor-command",
+            command_line='qemu-io luks-1-format "read -P 40 0 64k"',
+        )
+        self.assert_qmp(result, "return", "")
+
+        # Detached LUKS header with raw payload
+        cmd = 'qemu-io luks-2-payload-raw-format "write -P 41 0 64k"'
+        result = self.vm.qmp(
+            "human-monitor-command",
+            command_line=cmd
+        )
+        self.assert_qmp(result, "return", "")
+
+        cmd = 'qemu-io luks-2-payload-raw-format "read -P 41 0 64k"'
+        result = self.vm.qmp(
+            "human-monitor-command",
+            command_line=cmd
+        )
+        self.assert_qmp(result, "return", "")
+
+        # Detached LUKS header with qcow2 payload
+        cmd = 'qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"'
+        result = self.vm.qmp(
+            "human-monitor-command",
+            command_line=cmd
+        )
+        self.assert_qmp(result, "return", "")
+
+        cmd = 'qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"'
+        result = self.vm.qmp(
+            "human-monitor-command",
+            command_line=cmd
+        )
+        self.assert_qmp(result, "return", "")
+
+        self.vm.shutdown()
+
+
+if __name__ == "__main__":
+    # Test image creation and I/O
+    iotests.main(supported_fmts=["luks"], supported_protocols=["file"])
diff --git a/tests/qemu-iotests/tests/luks-detached-header.out b/tests/qemu-iotests/tests/luks-detached-header.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/luks-detached-header.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
-- 
2.43.0


