Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EEDCAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216F-0008DW-2X; Fri, 26 Sep 2025 01:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216C-0008Bi-EX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2165-0000im-OP
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LG8f7f/BKceVvi+dHjXJIpPGDrEsR8S5Y6r6UkC5W54=;
 b=E11sqtRob1A/u3VsVbM9dX2eiQcxJcP5ioux1ggP9O7fYxiEYBumye7Rx8OGzqEnC2wxRy
 7BUParVUjAxP4ZbjXZvaF14r0ViM1SxS7lpFS7M3NSrEXrX3Nhsbc5RHVzvoxA4Ytt/KFq
 fjDcmFD8R3+oI6ucr/QdBngyFnemM54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-gR4gzjhLPBeO7Qb9XPGLEA-1; Fri,
 26 Sep 2025 01:34:07 -0400
X-MC-Unique: gR4gzjhLPBeO7Qb9XPGLEA-1
X-Mimecast-MFC-AGG-ID: gR4gzjhLPBeO7Qb9XPGLEA_1758864846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2687118004D4; Fri, 26 Sep 2025 05:34:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C16401800452; Fri, 26 Sep 2025 05:34:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/29] tests/functional: add a vfio-user smoke test
Date: Fri, 26 Sep 2025 07:33:30 +0200
Message-ID: <20250926053358.308198-2-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250911210905.2070474-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 201 ++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 24b71a4fc54d820cce42830a0db83e653e91ffc5..7d134a85e666134717b526f470e3360e3a992201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4318,6 +4318,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 967426c30c3cf1047f182ff0450e4fc12b1b08e0..f78eec5e6cf43cc919f49a2e643a4c879bb6067b 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -33,6 +33,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
new file mode 100755
index 0000000000000000000000000000000000000000..8bc16e5e314904b26414d17dc62a67c27b6bb008
--- /dev/null
+++ b/tests/functional/x86_64/test_vfio_user_client.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import os
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+# Exact output can vary, so we just sample for some expected lines.
+EXPECTED_SERVER_LINES = [
+    "gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3",
+    "gpio: devinfo flags 0x3, num_regions 9, num_irqs 5",
+    "gpio: region_info[0] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[1] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region_info[3] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[4] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[5] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region7: read 256 bytes at 0",
+    "gpio: region7: read 0 from (0x30:4)",
+    "gpio: cleared EROM",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+    "gpio: SERR# enabled",
+    "gpio: region7: wrote 0x103 to (0x4:2)",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+]
+
+class VfioUserClient(QemuSystemTest):
+    """vfio-user testing class."""
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+
+        self.kernel_path = None
+        self.rootfs_path = None
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-snapshot')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+
+        # wait for libvfio-user socket to appear
+        while True:
+            out = exec_command_and_wait_for_pattern(self,
+                 'ls --color=no /tmp/vfio-user.sock', '#', None, server_vm)
+            ls_out = out.decode().splitlines()[1].strip()
+            if ls_out == "/tmp/vfio-user.sock":
+                break
+
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        """Run basic sanity test."""
+
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        sock_dir = self.socket_dir()
+        socket_path = os.path.join(sock_dir.name, 'vfio-user.sock')
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if s.startswith("gpio:")]
+
+        for line in EXPECTED_SERVER_LINES:
+            if line not in gpio_server_out:
+                self.log.error(f'Missing server debug line: {line}')
+                self.fail(False)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.51.0


