Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63575CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpp-00073l-Cr; Thu, 11 Jun 2026 14:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpn-00072e-Si
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpl-0002JN-DD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so1603195e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201332; x=1781806132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS6Jgnf1q6xm35E2vee5rv8aGYu78NsPfN/jQ6mxQhg=;
 b=CrEZStPFebC1H0b3oWetiBW8paBIcERIjj/tzMOwZ46ZQAGbY+WLJgI1gIiV3of7ud
 TuF4L3Z4x4yTqGQYkbmGgtQ3cnqp8nrbaS28L8OvLDw/O+8yBMJH6uvxqV7nl0bLg0R6
 dchTKPTFf0QIvxU8AKboE82z5j/edzhyGnrpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201332; x=1781806132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mS6Jgnf1q6xm35E2vee5rv8aGYu78NsPfN/jQ6mxQhg=;
 b=LpeAxZ85VMoH2HDAbF42g6z51pV1nd3pnkBUiQFqwV306osW53Gwjp+CgM7l9edeDZ
 mNHLNsztFGK57zxFO7dJMdtQavIhVY6LfLcURXjmwtfvbu4t/4bzbGFo2tAEq2DoaCZ6
 sfS9lfu2pLCBUbd8LTeufu8ORD6dF1pGNpbaIwraZoCm2/rAs2JdRrvzsmOnf5zXfYAz
 pMpb4UcUlynlYCxwES1okaRoYn7u3lQ/j/U0N1oYakjLE8Z0tMUqVyDoj/R9ZJ0tUj8F
 d+QVew+gaYcClTSwOXaYww7D+b+/doGwUFqD+AaUpZK/7kp1TWg9LQndlBDUZahlMzm7
 LlcA==
X-Gm-Message-State: AOJu0Yxs0ndbotYC10yAwZgu9m5tzDx/cjcYkaeBswdKVYtd3NOzjsg7
 Ekrp9ZheftxQSFFYuWs2XZIChRA83snhKoKhoeBSal4/k2pER6hlV/hy5KTP/O7N7MMj5c58A2d
 nhx1PIqg=
X-Gm-Gg: Acq92OGArcBLbZ1sAft0GY9HMykPNAl+JJH8XPlg/CBMvtqA5m7PFj14J3Z4YTOCAZL
 874sK7jJWVP0TMLcBAWLY6uD6ZzpHMAF7yp36iOq8BsU1boezqK5KtewxuWK8VltsRYIcgchNG5
 NJ9wtGBZh9CZOc/fBb1RlgkPTnkZyNHCoA01hsaUaeO0k/xlfFWmc28q7gyJDFlUd7fTu5XRPYB
 tANE94Knrdlh9zxS7VUyEruRQnKL8PXEcJSpE/TEA71nHFsecGtLX6xJs92Ch77DX9wEIVRL5HD
 88bN0b9p9WigkB+n1g9s2nz4mr2kQgm2G70tpEFZGksE5kAJVoVIrxxi04uAM3ghcmi2ucDcQs8
 +pxjebTjAoYmGODiTS4srC3hcGMnW/mKNihw99D4rGcav0b/1A8QdL0IGeCOm675GA5+xKDLgwZ
 Dy13/NJZVvCd3DdLsAYhQoq5NWCV8mFI0AZElQ5WZNPIwZn4X6A93AOakB3cg31pI2vscKtRpvw
 oqKrxT8qzYh2jG3YvYByxs=
X-Received: by 2002:a05:600c:4fc8:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490e52df887mr49239555e9.7.1781201331842; 
 Thu, 11 Jun 2026 11:08:51 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:51 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v10 7/8] tests/functional/x86_64: add migration test for NVMe
 device
Date: Thu, 11 Jun 2026 20:08:40 +0200
Message-ID: <20260611180842.6390-8-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v9:
    - check-patch fixes
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 172 ++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e173..d705f5c8e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2622,6 +2622,7 @@ S: Supported
 F: hw/nvme/*
 F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
+F: tests/functional/x86_64/test_nvme_migration.py
 F: docs/system/devices/nvme.rst
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 1ed10ad6c29..fd77f19d726 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -37,6 +37,7 @@ tests_x86_64_system_thorough = [
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
+  'nvme_migration',
   'replay',
   'reverse_debug',
   'tuxrun',
diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
new file mode 100755
index 00000000000..890f0aab6d6
--- /dev/null
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -0,0 +1,172 @@
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
+        # Note, that commands we send to the console are echo-ed back,
+        # so if we have a word "FAIL" in the command itself, we should
+        # expect to see it once.
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
+                    'drive=drv0,id=nvme-disk0,serial=nvmemigtest,bootindex=1')
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
+        # Run workload before migration to check if it continues
+        # to run properly after migration.
+        #
+        # Workload is simple: it continuously calculates checksums of
+        # all files in /usr/bin to generate some I/O load on
+        # the NVMe disk and at the same time it drops caches to
+        # make sure that we have some read I/O on the disk as well.
+        # If there are any issues with the migration of the NVMe device,
+        # we should see errors in dmesg and consequently in the workload log.
+        exec_command_and_wait_for_pattern(self,
+            "(while [ ! -f /tmp/test_nvme_mig_workload.stop ]; do \
+                rm -f /tmp/test_nvme_mig_workload.iter_finished; \
+                echo 3 > /proc/sys/vm/drop_caches; \
+                find /usr/bin -type f -exec cksum {} \\;; \
+                touch /tmp/test_nvme_mig_workload.iter_finished; \
+            done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
+            prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self,
+            'echo $! > /tmp/test_nvme_mig_workload.pid',
+            prompt, vm=vm)
+
+        # check if process is alive and running
+        self.exec_command_and_check(
+            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
+
+    def assert_dest_vm(self, vm):
+        prompt = '# '
+
+        # check if process is alive and running after migration,
+        # if not - fail the test
+        self.exec_command_and_check(
+            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
+
+        # signal workload to stop
+        exec_command_and_wait_for_pattern(self,
+            'touch /tmp/test_nvme_mig_workload.stop',
+            prompt, vm=vm)
+
+        # wait workload to finish, because we want to examine log
+        # to see if there are any errors
+        exec_command_and_wait_for_pattern(self,
+            "while [ ! -f /tmp/test_nvme_mig_workload.iter_finished ]; do \
+                sleep 1; \
+            done;",
+            prompt, vm=vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'cat /tmp/test_nvme_mig_workload.errors',
+            prompt, vm=vm)
+
+        # fail the test if non-empty
+        self.exec_command_and_check(
+            "[ ! -s /tmp/test_nvme_mig_workload.errors ]", vm)
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


