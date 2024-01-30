Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B96C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqm-0002uZ-64; Tue, 30 Jan 2024 00:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqg-0002u0-Ni
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:54 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqb-0001O6-EN
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:54 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5961a2726aaso2031956eaf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593068; x=1707197868;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCfSOssekZN4zKobgArXjcljl64GHI25OWtrrgugOcQ=;
 b=ZQJHUY5VAHjuLKOPTQ7/5RIIQTz1yfc7HR7dmqiSDPmDVpQqyc/Ap80QZAB47Am3K0
 a0jEcMLlB/GC5FFONuUx/g6P1MtmmvOO9zPTb9hPLdXLUBXm8NdG4O7ZVVIKchiJn4jH
 BAFz7Zdlbx7Rxv1y9teAS5VW+IkveIp2vxK5HE5Ek7YmTlS5QdkjJ1rb6Uukxz3Z+bTy
 QkwNHhMe55yNc00lBk1wlxmmz8NaJrSFYEZp3BXiTSn1i0/vtaPiReyKuGMjzfkBpiRJ
 ThSIEpVMhK2DxccTN4KTMKymZf4UTnDMcDSetF8TQY5wUjEEiOyorBzeg0hd9n3qIgzB
 /HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593068; x=1707197868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCfSOssekZN4zKobgArXjcljl64GHI25OWtrrgugOcQ=;
 b=Zpjgtx7vRsslD/RAL1LTgRbkt7+S5IcEmBvPGo8RSysHwhfqX+YMCBGNT+oyQyBfpV
 ggDdbh2N0iv/uD/c5lUN7F8oCXvMFTl9W2m21IbPS8V7/Grm8zxFHwHFKSRaGynLNsB1
 wlymHLIWYR7+0IIIOYxyFl9XRMIgSrpBn3xnvUxe4KeXOcwqnuq9T5MlT5BY2J2VOekz
 g1bzI+qSWFMBQOTkhh511F21//wv1us3bhR63hKIwSUFzr4g1OdN2HoFjyE6AfpJ8+i+
 jOxvqzEQKABhgHIrJqs0KY3nu7OmXITgoE7zV7bIDrDO7yfDBKBQeGZcPwp82rhau/LX
 I/sg==
X-Gm-Message-State: AOJu0YzgX06MMApGLOhZmfkH0KlL1rmJWp0MLOMMz964MZmtk/hiXNyC
 LdxPpKy0krrqMZBQPB6KK+7uh/oJ04+NO+nWicW6yIg+OfgS4tua/qF9GQ4Z5wEFUYehxk7TkTw
 pt/g=
X-Google-Smtp-Source: AGHT+IG1xLeQGtKw934ZWtEDgUSX2T++i5eXiXbI5EV/glI55bM1oqNGlPc164gHKLZLOE+GjLWfjA==
X-Received: by 2002:a05:6358:9216:b0:177:2984:3db8 with SMTP id
 d22-20020a056358921600b0017729843db8mr4205888rwb.20.1706593067526; 
 Mon, 29 Jan 2024 21:37:47 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:47 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 7/7] tests: Add case for LUKS volume with detached header
Date: Tue, 30 Jan 2024 13:37:25 +0800
Message-Id: <87aa559fbc0c98a5b90ac4f3fa25cb7438a5c181.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS                                   |   5 +
 tests/qemu-iotests/tests/luks-detached-header | 218 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 3 files changed, 228 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e..fddd3348c2 100644
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
index 0000000000..f0b5f3921c
--- /dev/null
+++ b/tests/qemu-iotests/tests/luks-detached-header
@@ -0,0 +1,218 @@
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
+import iotests
+from iotests import imgfmt, qemu_img_create, img_info_log, qemu_img_info, QMPTestCase
+
+
+image_size = 128 * 1024 * 1024
+
+luks_img = os.path.join(iotests.test_dir, 'luks.img')
+detached_header_img1 = os.path.join(iotests.test_dir, 'detached_header.img1')
+detached_header_img2 = os.path.join(iotests.test_dir, 'detached_header.img2')
+detached_payload_raw_img = os.path.join(iotests.test_dir, 'detached_payload_raw.img')
+detached_payload_qcow2_img = os.path.join(iotests.test_dir, 'detached_payload_qcow2.img')
+detached_header_raw_img = \
+    "json:{\"driver\":\"luks\",\"file\":{\"filename\":\"%s\"},\"header\":{\"filename\":\"%s\"}}" % (detached_payload_raw_img, detached_header_img1)
+detached_header_qcow2_img = \
+    "json:{\"driver\":\"luks\",\"file\":{\"filename\":\"%s\"},\"header\":{\"filename\":\"%s\"}}" % (detached_payload_qcow2_img, detached_header_img2)
+
+secret_obj = 'secret,id=sec0,data=foo'
+luks_opts = 'key-secret=sec0'
+
+
+class TestDetachedLUKSHeader(QMPTestCase):
+    def setUp(self) -> None:
+        self.vm = iotests.VM()
+        self.vm.add_object(secret_obj)
+        self.vm.launch()
+
+        # 1. Create the normal LUKS disk with 128M size
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': luks_img,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file', filename=luks_img,
+                         node_name='luks-1-storage')
+        result = self.vm.blockdev_create({ 'driver': imgfmt,
+                                           'file': 'luks-1-storage',
+                                           'key-secret': 'sec0',
+                                           'size': image_size,
+                                           'iter-time': 10 })
+        # None is expected
+        self.assertEqual(result, None)
+
+        # 2. Create the LUKS disk with detached header (raw)
+
+        # Create detached LUKS header
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': detached_header_img1,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img1,
+                         node_name='luks-2-header-storage')
+
+        # Create detached LUKS raw payload
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': detached_payload_raw_img,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file',
+                         filename=detached_payload_raw_img,
+                         node_name='luks-2-payload-storage')
+
+        # Format LUKS disk with detached header
+        result = self.vm.blockdev_create({ 'driver': imgfmt,
+                                           'header': 'luks-2-header-storage',
+                                           'file': 'luks-2-payload-storage',
+                                           'key-secret': 'sec0',
+                                           'preallocation': 'full',
+                                           'size': image_size,
+                                           'iter-time': 10 })
+        self.assertEqual(result, None)
+
+        self.vm.shutdown()
+
+        # 3. Create the LUKS disk with detached header (qcow2)
+
+        # Create detached LUKS header using qemu-img
+        res = qemu_img_create('-f', 'luks', '--object', secret_obj, '-o', luks_opts,
+                              '-o', "detached-header=true", detached_header_img2)
+        assert res.returncode == 0
+
+        # Create detached LUKS qcow2 payload
+        res = qemu_img_create('-f', 'qcow2', detached_payload_qcow2_img, str(image_size))
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
+        if 'Pattern verification failed' in self.vm.get_log():
+            print('ERROR: Pattern verification failed:')
+            print(self.vm.get_log())
+            self.fail('qemu-io pattern verification failed')
+
+    def test_img_creation(self) -> None:
+        # Check if the images created above are expected
+
+        data = qemu_img_info(luks_img)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], False)
+
+        data = qemu_img_info(detached_header_raw_img)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], True)
+
+        data = qemu_img_info(detached_header_qcow2_img)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], True)
+
+        # Check if preallocation works
+        size = qemu_img_info(detached_payload_raw_img)['actual-size']
+        self.assertGreaterEqual(size, image_size)
+
+    def test_detached_luks_header(self) -> None:
+        self.vm.launch()
+
+        # 1. Add the disk created above
+
+        # Add normal LUKS disk
+        self.vm.qmp_log('blockdev-add', driver='file', filename=luks_img,
+                         node_name='luks-1-storage')
+        result = self.vm.qmp_log('blockdev-add', driver='luks', file='luks-1-storage',
+                                  key_secret='sec0', node_name='luks-1-format')
+
+        # Expected result{ "return": {} }
+        self.assert_qmp(result, 'return', {})
+
+        # Add detached LUKS header with raw payload
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img1,
+                         node_name='luks-header1-storage')
+
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_payload_raw_img,
+                         node_name='luks-2-payload-raw-storage')
+
+        result = self.vm.qmp_log('blockdev-add', driver=imgfmt,
+                                  header='luks-header1-storage',
+                                  file='luks-2-payload-raw-storage',
+                                  key_secret='sec0',
+                                  node_name='luks-2-payload-raw-format')
+        self.assert_qmp(result, 'return', {})
+
+        # Add detached LUKS header with qcow2 payload
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img2,
+                         node_name='luks-header2-storage')
+
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_payload_qcow2_img,
+                         node_name='luks-3-payload-qcow2-storage')
+
+        result = self.vm.qmp_log('blockdev-add', driver=imgfmt,
+                                  header='luks-header2-storage',
+                                  file='luks-3-payload-qcow2-storage',
+                                  key_secret='sec0',
+                                  node_name='luks-3-payload-qcow2-format')
+        self.assert_qmp(result, 'return', {})
+
+        # 2. Do I/O test
+
+        # Do some I/O to the image to see whether it still works
+        # (Pattern verification will be checked by tearDown())
+
+        # Normal LUKS disk
+        result = self.vm.qmp_log('human-monitor-command',
+                                  command_line='qemu-io luks-1-format "write -P 40 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp_log('human-monitor-command',
+                                 command_line='qemu-io luks-1-format "read -P 40 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        # Detached LUKS header with raw payload
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-2-payload-raw-format "write -P 41 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-2-payload-raw-format "read -P 41 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        # Detached LUKS header with qcow2 payload
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    # Test image creation and I/O
+    iotests.main(supported_fmts=['luks'],
+                 supported_protocols=['file'])
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
2.31.1


