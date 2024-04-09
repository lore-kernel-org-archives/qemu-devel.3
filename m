Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DEC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5SG-0000kd-Np; Tue, 09 Apr 2024 02:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru5SD-0000jv-6J; Tue, 09 Apr 2024 02:59:37 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru5SA-0003Zs-0u; Tue, 09 Apr 2024 02:59:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1785:0:640:67c7:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 3A48F60CA3;
 Tue,  9 Apr 2024 09:59:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b66e::1:3c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id twSu8p1i8qM0-YvE1MTfJ; Tue, 09 Apr 2024 09:59:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712645968;
 bh=/SBmk7jOz+2npM4XFBWWzAdnlujMywpFn3e+Iz00UI8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=Ta4C3W0DshxrplpSBI/C2MUdVBmL3SEV+v4tcOk0Q7xiaUqOma/k+NAci1EbPJ1c5
 ujRULfldqyrP6kXm9O7ZV7DHIcEkk7sr45MnPt+FRX6p+W8JaxRuy+UdyqSFesRQRL
 MnzWlf/N3T1x1ZwnXUsJfxOrOY4BehC4m87NoalI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, crosa@redhat.com, philmd@linaro.org,
 wainersm@redhat.com, bleal@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH] tests/avocado: add hotplug_blk test
Date: Tue,  9 Apr 2024 09:58:54 +0300
Message-Id: <20240409065854.366856-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Introduce a test, that checks that plug/unplug of virtio-blk device
works.

(the test is developed by copying hotplug_cpu.py, so keep original
copyright)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/avocado/hotplug_blk.py | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 tests/avocado/hotplug_blk.py

diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
new file mode 100644
index 0000000000..5dc30f6616
--- /dev/null
+++ b/tests/avocado/hotplug_blk.py
@@ -0,0 +1,69 @@
+# Functional test that hotplugs a virtio blk disk and checks it on a Linux
+# guest
+#
+# Copyright (c) 2021 Red Hat, Inc.
+# Copyright (c) Yandex
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import time
+
+from avocado_qemu import LinuxTest
+
+
+class HotPlug(LinuxTest):
+    def blockdev_add(self) -> None:
+        self.vm.cmd('blockdev-add', **{
+            'driver': 'null-co',
+            'size': 1073741824,
+            'node-name': 'disk'
+        })
+
+    def assert_vda(self) -> None:
+        self.ssh_command('test -e /sys/block/vda')
+
+    def assert_no_vda(self) -> None:
+        with self.assertRaises(AssertionError):
+            self.assert_vda()
+
+    def plug(self) -> None:
+        args = {
+            'driver': 'virtio-blk-pci',
+            'drive': 'disk',
+            'id': 'virtio-disk0',
+            'bus': 'pci.1',
+            'addr': 1
+        }
+
+        self.assert_no_vda()
+        self.vm.cmd('device_add', args)
+        try:
+            self.assert_vda()
+        except AssertionError:
+            time.sleep(1)
+            self.assert_vda()
+
+    def unplug(self) -> None:
+        self.vm.cmd('device_del', id='virtio-disk0')
+
+        self.vm.event_wait('DEVICE_DELETED', 1.0,
+                           match={'data': {'device': 'virtio-disk0'}})
+
+        self.assert_no_vda()
+
+    def test(self) -> None:
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator('kvm')
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
+
+        self.launch_and_wait()
+        self.blockdev_add()
+
+        self.plug()
+        self.unplug()
-- 
2.34.1


