Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8195FCB611
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWip-00083z-8L; Fri, 06 Mar 2026 10:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWic-0007q7-Hq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:04:00 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWia-0003LE-5g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:58 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so3208855f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809434; x=1773414234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BVjzpz+g8zyE8326nn6m7L9ExlEPRzKWbaO0sFI7v0=;
 b=SnlUqC+oH2MgfSef53a8fVo0G8PfAAs12DJneZ9BzY3v34LLFqAYL8I3NLqASiW2+W
 f7UEh5h5zE5hWCuT1kmQB7+N2AbTqM8gU0IpJe9nCfBEsvj+wgDe+p9eOp8SUcXPfHca
 LeDyUtPE4ZXwW1cQKmDT4o2G57197ACdeMeE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809434; x=1773414234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9BVjzpz+g8zyE8326nn6m7L9ExlEPRzKWbaO0sFI7v0=;
 b=GQdK4qTtBoIWF3WYSdS/ccr5aZeN49/+GEd1SuJOm1ZRFd/Z0iMm1EkIrUcUp+he7j
 jFpvjF3EpgVsjDSnTBM4gUvzHgFvXcG5Pew4qkAI0RmUMWl7RnYf+6kmYtiB2wmNZRL1
 YiyjciBGFu2tpu6PG2s2h66q5y74P8jIFAOoiSytxP+zWh9JDbTllhnbAcT8ijxl/vzC
 j49rVPuH0jfNnYJlcXSNtwpEC38D5T6OKL9n2h36nFMipFESZGT2yn7bPL6CRBDn2tZN
 xG/LEd6hqI4KhVaHUGmESBAxtI400dAUsfhFEa5m1En/JW503KO/0zqXPKBOYkEpZN04
 jv2w==
X-Gm-Message-State: AOJu0YyboEA2FrMW0g0fK4JzZe/PlYsUDiFbUNROjKs9pF7PlSuLg+zd
 Zfpfse4oKEbXjJgizIzCqMVZZcTiWfgMhebihEu5zdMng2V5WZ9OJ9WYQQpxzn+PI8FhCHj+rnr
 oXup8734=
X-Gm-Gg: ATEYQzzm92H7IY3fSe3Lly2iXuoIrttjWQDWHO1PfXllvZfhF7O8I3IcpAZrh9VKGEv
 qtF0lJnzmHSpH/r1HyO888GdX9O+YqXE1f068ctmSmV0HBwhfupilB4elH7qaByf/0dzrLF2tJ7
 Y3pRhaAT4ut7+GR+yTWEtKvBMB7PO2Xj048cxNRWcs55CIYbi4OKdH8I/d/SAHWuNunApFhhzPo
 u4KfwbEFLBkBePbxgxfij2ljUuaYI/R9MDDWIG9Bb2DabO7SVPd+biz6bxVkmwxQgVV6VFdDyfC
 BH73oQgxhD8vteXY8Z63XajHxdNdDuj/rfUooBwyVD1rHhBUFmqORb9ad9pcQmm7ry2lqoHhmK0
 OMoQRAKrByYKmVg8+gZvs8JPURDXBLVDhB+/zP5MXPsBVPVdiTD45b1XtTBHvNnhLdmeliFI69J
 4KtLVmZgVp8kgP2RxALU7HUabD/NtttoeY21cWalhp9mKfaNmBqZe0vgIqY8b6r04EL1pIBUGlF
 GEPMDnbbmPAyEYOzPt4cmI=
X-Received: by 2002:a05:6000:604:b0:439:b715:6f4b with SMTP id
 ffacd0b85a97d-439da8a78d1mr4395120f8f.57.1772809430264; 
 Fri, 06 Mar 2026 07:03:50 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:49 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 6/6] tests/functional/x86_64: add migration test for NVMe
 device
Date: Fri,  6 Mar 2026 16:03:42 +0100
Message-ID: <20260306150342.395923-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306150342.395923-1-alexander@mihalicyn.com>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Introduce a very simple test to ensure that NVMe device
migration works fine.

Test plan is simple:
1. prepare VM with NVMe device
2. run workload that produces relatively heavy IO on the device
3. migrate VM
4. ensure that workload is alive and finishes without errors

Test can be run as simple as:
$ meson test 'func-x86_64-nvme_migration' --setup thorough -C build

In the future we can extend this approach, and introduce some
fio-based tests. And probably, it makes sense to make this test
to apply not only to NVMe device, but also virtio-{blk,scsi},
ide, sata and other migratable devices.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 05e4914c772..a3b010d24c6 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -30,6 +30,7 @@ tests_x86_64_system_thorough = [
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
+  'nvme_migration',
   'replay',
   'reverse_debug',
   'tuxrun',
diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
new file mode 100755
index 00000000000..3788a8e3473
--- /dev/null
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -0,0 +1,159 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# x86_64 NVMe migration test
+
+from migration import MigrationTest
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+
+
+class X8664NVMeMigrationTest(MigrationTest):
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    ASSET_DISKIMAGE = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'),
+        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
+
+    DEFAULT_KERNEL_PARAMS = ('root=/dev/nvme0n1p1 console=ttyS0 net.ifnames=0 '
+                             'rd.rescue quiet')
+
+    def wait_for_console_pattern(self, success_message, vm):
+        wait_for_console_pattern(
+            self,
+            success_message,
+            failure_message="Kernel panic - not syncing",
+            vm=vm,
+        )
+
+    def exec_command_and_check(self, command, vm):
+        prompt = '# '
+        exec_command_and_wait_for_pattern(self,
+                                        f"{command} && echo OK || echo FAIL",
+                                        'FAIL', vm=vm)
+        # Note, that commands we send to the console are echo-ed back, so if we have a word "FAIL"
+        # in the command itself, we should expect to see it once.
+        wait_for_console_pattern(self, 'OK', failure_message="FAIL", vm=vm)
+        self.wait_for_console_pattern(prompt, vm)
+
+    def configure_machine(self, vm):
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        diskimage_path = self.ASSET_DISKIMAGE.fetch()
+
+        vm.set_console()
+        vm.add_args("-cpu", "max")
+        vm.add_args("-m", "2G")
+        vm.add_args("-accel", "kvm")
+
+        vm.add_args('-drive',
+                         f'file={diskimage_path},if=none,id=drv0,snapshot=on')
+        vm.add_args('-device', 'nvme,bus=pcie.0,' +
+                         'drive=drv0,id=nvme-disk0,serial=nvmemigratetest,bootindex=1')
+
+        vm.add_args(
+            "-kernel",
+            kernel_path,
+            "-initrd",
+            initrd_path,
+            "-append",
+            self.DEFAULT_KERNEL_PARAMS
+        )
+
+    def launch_source_vm(self, vm):
+        vm.launch()
+
+        self.wait_for_console_pattern('Entering emergency mode.', vm)
+        prompt = '# '
+        self.wait_for_console_pattern(prompt, vm)
+
+        # Synchronize on NVMe driver creating the root device
+        exec_command_and_wait_for_pattern(self,
+                        "while ! (dmesg -c | grep nvme0n1:) ; do sleep 1 ; done",
+                        "nvme0n1", vm=vm)
+        self.wait_for_console_pattern(prompt, vm)
+
+        # prepare system
+        exec_command_and_wait_for_pattern(self, 'mount /dev/nvme0n1p1 /sysroot',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'mount -t proc proc /proc',
+                                          prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys',
+                                          prompt, vm=vm)
+
+        # Run workload before migration to check if it continues to run properly after migration
+        #
+        # Workload is simple: it continuously calculates checksums of all files in /usr/bin
+        # to generate some I/O load on the NVMe disk and at the same time it drops caches to
+        # make sure that we have some read I/O on the disk as well.
+        # If there are any issues with the migration of the NVMe device, we should see errors
+        # in dmesg and consequently in the workload log.
+        exec_command_and_wait_for_pattern(self,
+                                        "(while [ ! -f /tmp/test_nvme_migration_workload.stop ]; do \
+                                            rm -f /tmp/test_nvme_migration_workload.iteration_finished; \
+                                            echo 3 > /proc/sys/vm/drop_caches; \
+                                            find /usr/bin -type f -exec cksum {} \\;; \
+                                            touch /tmp/test_nvme_migration_workload.iteration_finished; \
+                                        done) > /dev/null 2> /tmp/test_nvme_migration_workload.errors &",
+                                        prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'echo $! > /tmp/test_nvme_migration_workload.pid',
+                                          prompt, vm=vm)
+
+        # check if process is alive and running
+        self.exec_command_and_check("kill -0 $(cat /tmp/test_nvme_migration_workload.pid)", vm)
+
+    def assert_dest_vm(self, vm):
+        prompt = '# '
+
+        # check if process is alive and running after migration, if not - fail the test
+        self.exec_command_and_check("kill -0 $(cat /tmp/test_nvme_migration_workload.pid)", vm)
+
+        # signal workload to stop
+        exec_command_and_wait_for_pattern(self, 'touch /tmp/test_nvme_migration_workload.stop',
+                                          prompt, vm=vm)
+
+        # wait workload to finish, because we want to examine log to see if there are any errors
+        exec_command_and_wait_for_pattern(self,
+                                        "while [ ! -f /tmp/test_nvme_migration_workload.iteration_finished ]; do sleep 1; done;",
+                                        prompt, vm=vm)
+
+        exec_command_and_wait_for_pattern(self, 'cat /tmp/test_nvme_migration_workload.errors',
+                                          prompt, vm=vm)
+
+        # fail the test if non-empty
+        self.exec_command_and_check("[ ! -s /tmp/test_nvme_migration_workload.errors ]", vm)
+
+    def test_migration_with_tcp_localhost(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_tcp_localhost()
+
+    def test_migration_with_unix(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_unix()
+
+    def test_migration_with_exec(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+
+        self.migration_with_exec()
+
+
+if __name__ == '__main__':
+    MigrationTest.main()
-- 
2.47.3


