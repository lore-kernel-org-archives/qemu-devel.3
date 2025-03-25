Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D908C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASy-0000al-0v; Tue, 25 Mar 2025 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASj-0000XG-4v
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASa-0002jK-50
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANG7o7PUwxlJhB57zgzUH/oBUrnu34TA6y5BHAtpYVM=;
 b=EKX37CYwZYaf1M1/HhV0LKTAN4bqV+7sdjXfcNPqEG4CAHSfr5DtHxYoSvuIFE9qrUiiH5
 6HjMlQoLOGTkdZwRLkP4hlRa6OPUEQHRrqo/7KV/+WszRMCTJFjaHPaRunQ1QehDpxwH9M
 QzhluMb4uhFoiccSMXtyRU6M4OVJf7c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-1ve3dTA7Mam7xvZDu8fZtA-1; Tue,
 25 Mar 2025 16:01:11 -0400
X-MC-Unique: 1ve3dTA7Mam7xvZDu8fZtA-1
X-Mimecast-MFC-AGG-ID: 1ve3dTA7Mam7xvZDu8fZtA_1742932868
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87627180025F; Tue, 25 Mar 2025 20:01:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 559AD1801767; Tue, 25 Mar 2025 20:01:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/15] tests/functional: Use the tuxrun kernel for the aarch64
 replay test
Date: Tue, 25 Mar 2025 21:00:20 +0100
Message-ID: <20250325200026.344006-13-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

This way we can do a full boot in record-replay mode and
should get a similar test coverage compared to the old
replay test from tests/avocado/replay_linux.py.

Since the aarch64 test was the last avocado test in the
tests/avocado/replay_linux.py file, we can remove this
file now completely.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |   1 -
 tests/avocado/replay_linux.py           | 160 ------------------------
 tests/functional/test_aarch64_replay.py |  37 ++++--
 3 files changed, 29 insertions(+), 169 deletions(-)
 delete mode 100644 tests/avocado/replay_linux.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b843c543ff..acdd8941168 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3667,7 +3667,6 @@ F: include/system/replay.h
 F: docs/devel/replay.rst
 F: docs/system/replay.rst
 F: stubs/replay.c
-F: tests/avocado/replay_linux.py
 F: tests/functional/*reverse_debug*.py
 F: tests/functional/*replay*.py
 F: qapi/replay.json
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
deleted file mode 100644
index 6ba283d3bf6..00000000000
--- a/tests/avocado/replay_linux.py
+++ /dev/null
@@ -1,160 +0,0 @@
-# Record/replay test that boots a complete Linux system via a cloud image
-#
-# Copyright (c) 2020 ISP RAS
-#
-# Author:
-#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import logging
-import time
-
-from avocado import skipUnless
-from avocado_qemu import BUILD_DIR
-from avocado.utils import cloudinit
-from avocado.utils import network
-from avocado.utils import vmimage
-from avocado.utils import datadrainer
-from avocado.utils.path import find_command
-from avocado_qemu.linuxtest import LinuxTest
-
-class ReplayLinux(LinuxTest):
-    """
-    Boots a Linux system, checking for a successful initialization
-    """
-
-    timeout = 1800
-    chksum = None
-    hdd = 'ide-hd'
-    cd = 'ide-cd'
-    bus = 'ide'
-
-    def setUp(self):
-        # LinuxTest does many replay-incompatible things, but includes
-        # useful methods. Do not setup LinuxTest here and just
-        # call some functions.
-        super(LinuxTest, self).setUp()
-        self._set_distro()
-        self.boot_path = self.download_boot()
-        self.phone_server = cloudinit.PhoneHomeServer(('0.0.0.0', 0),
-                                                      self.name)
-        ssh_pubkey, self.ssh_key = self.set_up_existing_ssh_keys()
-        self.cloudinit_path = self.prepare_cloudinit(ssh_pubkey)
-
-    def vm_add_disk(self, vm, path, id, device):
-        bus_string = ''
-        if self.bus:
-            bus_string = ',bus=%s.%d' % (self.bus, id,)
-        vm.add_args('-drive', 'file=%s,snapshot=on,id=disk%s,if=none' % (path, id))
-        vm.add_args('-drive',
-            'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
-        vm.add_args('-device',
-            '%s,drive=disk%s-rr%s' % (device, id, bus_string))
-
-    def vm_add_cdrom(self, vm, path, id, device):
-        vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
-
-    def launch_and_wait(self, record, args, shift):
-        self.require_netdev('user')
-        vm = self.get_vm()
-        vm.add_args('-smp', '1')
-        vm.add_args('-m', '1024')
-        vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                    '-device', 'virtio-net,netdev=vnet')
-        vm.add_args('-object', 'filter-replay,id=replay,netdev=vnet')
-        if args:
-            vm.add_args(*args)
-        self.vm_add_disk(vm, self.boot_path, 0, self.hdd)
-        self.vm_add_cdrom(vm, self.cloudinit_path, 1, self.cd)
-        logger = logging.getLogger('replay')
-        if record:
-            logger.info('recording the execution...')
-            mode = 'record'
-        else:
-            logger.info('replaying the execution...')
-            mode = 'replay'
-        replay_path = os.path.join(self.workdir, 'replay.bin')
-        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
-                    (shift, mode, replay_path))
-
-        start_time = time.time()
-
-        vm.set_console()
-        vm.launch()
-        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
-                                    logger=self.log.getChild('console'),
-                                    stop_check=(lambda : not vm.is_running()))
-        console_drainer.start()
-        if record:
-            while not self.phone_server.instance_phoned_back:
-                self.phone_server.handle_request()
-            vm.shutdown()
-            logger.info('finished the recording with log size %s bytes'
-                % os.path.getsize(replay_path))
-            self.run_replay_dump(replay_path)
-            logger.info('successfully tested replay-dump.py')
-        else:
-            vm.event_wait('SHUTDOWN', self.timeout)
-            vm.wait()
-            logger.info('successfully finished the replay')
-        elapsed = time.time() - start_time
-        logger.info('elapsed time %.2f sec' % elapsed)
-        return elapsed
-
-    def run_rr(self, args=None, shift=7):
-        t1 = self.launch_and_wait(True, args, shift)
-        t2 = self.launch_and_wait(False, args, shift)
-        logger = logging.getLogger('replay')
-        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
-
-    def run_replay_dump(self, replay_path):
-        try:
-            subprocess.check_call(["./scripts/replay-dump.py",
-                                   "-f", replay_path],
-                                  stdout=subprocess.DEVNULL)
-        except subprocess.CalledProcessError:
-            self.fail('replay-dump.py failed')
-
-
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-class ReplayLinuxAarch64(ReplayLinux):
-    """
-    :avocado: tags=accel:tcg
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    :avocado: tags=cpu:max
-    """
-
-    chksum = '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49'
-
-    hdd = 'virtio-blk-device'
-    cd = 'virtio-blk-device'
-    bus = None
-
-    def get_common_args(self):
-        return ('-bios',
-                os.path.join(BUILD_DIR, 'pc-bios', 'edk2-aarch64-code.fd'),
-                "-cpu", "max,lpa2=off",
-                '-device', 'virtio-rng-pci,rng=rng0',
-                '-object', 'rng-builtin,id=rng0')
-
-    def test_virt_gicv2(self):
-        """
-        :avocado: tags=machine:gic-version=2
-        """
-
-        self.run_rr(shift=3,
-                    args=(*self.get_common_args(),
-                          "-machine", "virt,gic-version=2"))
-
-    def test_virt_gicv3(self):
-        """
-        :avocado: tags=machine:gic-version=3
-        """
-
-        self.run_rr(shift=3,
-                    args=(*self.get_common_args(),
-                          "-machine", "virt,gic-version=3"))
diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/test_aarch64_replay.py
index 04cde433bcf..04dc32722c9 100755
--- a/tests/functional/test_aarch64_replay.py
+++ b/tests/functional/test_aarch64_replay.py
@@ -5,25 +5,46 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from subprocess import check_call, DEVNULL
+
+from qemu_test import Asset, get_qemu_img
 from replay_kernel import ReplayKernelBase
 
 
 class Aarch64Replay(ReplayKernelBase):
 
     ASSET_KERNEL = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
-         'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
-        '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/Image',
+        'b74743c5e89e1cea0f73368d24ae0ae85c5204ff84be3b5e9610417417d2f235')
+
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/rootfs.ext4.zst',
+        'a1acaaae2068df4648d04ff75f532aaa8c5edcd6b936122b6f0db4848a07b465')
 
     def test_aarch64_virt(self):
+        self.require_netdev('user')
         self.set_machine('virt')
-        self.cpu = 'cortex-a53'
+        self.cpu = 'cortex-a57'
         kernel_path = self.ASSET_KERNEL.fetch()
+
+        raw_disk = self.uncompress(self.ASSET_ROOTFS)
+        disk = self.scratch_file('scratch.qcow2')
+        qemu_img = get_qemu_img(self)
+        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', raw_disk,
+                    '-F', 'raw', disk], stdout=DEVNULL, stderr=DEVNULL)
+
+        args = ('-drive', 'file=%s,snapshot=on,id=hd0,if=none' % disk,
+                '-drive', 'driver=blkreplay,id=hd0-rr,if=none,image=hd0',
+                '-device', 'virtio-blk-device,drive=hd0-rr',
+                '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                '-device', 'virtio-net,netdev=vnet',
+                '-object', 'filter-replay,id=replay,netdev=vnet')
+
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0')
-        console_pattern = 'VFS: Cannot open root device'
-        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+                               'console=ttyAMA0 root=/dev/vda')
+        console_pattern = 'Welcome to TuxTest'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+                    args=args)
 
 
 if __name__ == '__main__':
-- 
2.49.0


