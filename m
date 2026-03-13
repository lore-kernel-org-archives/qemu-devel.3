Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A65105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GM-0005WM-RH; Fri, 13 Mar 2026 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fs-0005QJ-H7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006Ox-RB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso1759366f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411156; x=1774015956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBpcKOoEk+DQ0qOwh5vSLzEuS5T0qQxiJFTEUttDnck=;
 b=N4wiHlzvFI4x7gBhsUgkMqiXESy1kAKjuIzzPrdOkopcIBhZKJgCXqth/YW000di0H
 iIlVkCVm3DvPckFt0GV8sfLCGsfwa9sv0F/3toofJ0t5oMOmxFw5yo7kIQxbUqPjJLES
 +/R7dwLv8ffs/Thq1uY4FYsnmjWdAOXyDK8zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411156; x=1774015956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sBpcKOoEk+DQ0qOwh5vSLzEuS5T0qQxiJFTEUttDnck=;
 b=YXYEWwsCDFotAbEa8bKUoKJlsleY74Dx6n6I4hxXLgvX3W19i8ttq5vCO1eEfvpDV0
 83BZGH1ghbYqdHgn4/4bmIpwhePJ+sKhwHQF+XN+PgonUFATApVyOq27Z9w4OmQnvC/j
 aK2JElfveiKsoxkWjRz1fgOwwR+ZKECJ319CrzgA1zCLP6PhuIl9cUmsAMj4bdPqLX6y
 gEUlokXw5yHUiWh0vnrjp0sKUMQhAFIAYeepBPo+ATCeZqtSB9QfSGGpHTdd65mPwWkJ
 xeb0dg3/ICqP3xUx6r+Mr0eBTh0h7Z4RrzqTLF0LbjNQu32lsKpfQG5JP6+LxNUcW+c2
 sM7Q==
X-Gm-Message-State: AOJu0YxDyu4dKfQNL1CKqFObgvgIgg7mH2AzK5dg4xH/MDhRAmHE5kgB
 tkyLfoUIrmkv42KuRNk05j2tiS8KsJ15mcddcHLZrbJ3WAydIMTIB7MSLWXafr4XAHyPAlBSZF+
 /UaefaJA=
X-Gm-Gg: ATEYQzxSnycpAgRY8Zy5FQFAhGQ7kpVycIPIH7JC6lTYw6pjAYJ1AakMFzFEwbyv7N7
 Bs8KfXF3VTeAblkCjE8c2tfygm+3Sb9ENmjENjdk2NE3pdQbMN502P7wldP+7sk9Jbn6TPp4RZm
 lsMRStNc9sIFykMvH2Aec/Z5MDxvgKvO60u7F/wSUurrWx4w6DNHOOFoi1PTLDVx5MrpOpGABCq
 1NSmsEDypK8EagXW48CiUh7zG5+hZUfBPyG+2KnWggc4tJRc4lzwAMTT4i//vLIaaqAjt+/mT4V
 zJ1Sj3tsCbpjJB8PpbaVzub6cenu4CPvF5RmtvX44eNQMPYgHzEb8wF5QrpP+YFvjoLIJUkO1H4
 B7IXBsfF0gVrWxvBVcCTpFz2cJSbTVitBbDPVYHJQgzOM+P1KvWAM39qh7wRHc2RvXlf1mg0Jzr
 XHbhzl5pj11JfFbfYWg2PnfaUyHaLhV7yooILZsyv2rDikQHoa1aTgfKl5ZUAv4lLKCoJZiXlQ/
 552dAiNLShmFi6PoJLn4V++QHFyZ0AFbg==
X-Received: by 2002:a05:6000:2c07:b0:439:d923:c20a with SMTP id
 ffacd0b85a97d-43a04dbd550mr6351064f8f.49.1773411156203; 
 Fri, 13 Mar 2026 07:12:36 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:35 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 8/8] tests/functional/x86_64: add migration test for NVMe
 device
Date: Fri, 13 Mar 2026 15:12:21 +0100
Message-ID: <20260313141221.359503-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

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


