Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C074C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxr-0006Ay-OK; Fri, 23 Feb 2024 10:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhs-0005GP-Pq; Fri, 23 Feb 2024 10:43:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhq-000662-OR; Fri, 23 Feb 2024 10:43:24 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so6066305ad.2; 
 Fri, 23 Feb 2024 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703000; x=1709307800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wgXTACHWpXDU7vx3hdD6qJ6S+zqp0nQ7964G/fo8kg=;
 b=JJT6G5D6Rc1+64LlQujS3hMddpnyxXiC79Qy/au9hT3zRQl419wW1A0QY/6byQwIoN
 3L7HlftYCFfqbusq0hjBlC5KUY3V7dyUs5LCbxR/GchuvuESC9P87Z8Ww5o4poJORxDd
 ZbYiRPZcQtcvypA2Z9PZ4knAICLJ0EQjjr/5WeDrkVtvhPnsaFbKrfV/vYOViNvcWqzQ
 z2sRzvIYdOjMFvwBramxjaEmD/FW5f256TssJcn8SrEp62klrrn08zPk278FyUrGa35P
 9QDXhuR8C5SOiYVvo5nNgoSkEUnkfx91FsurAlU6+t9swEw1/QR1e01dYu4MMw0zcS13
 UcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703000; x=1709307800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wgXTACHWpXDU7vx3hdD6qJ6S+zqp0nQ7964G/fo8kg=;
 b=LOk5Bk3tXuYK1/DoKiSPKXkbU8PMQbxBoVNvX/wvjDuJ5GBoa7Gqf4BmfaJKpX9lg/
 vImuswkaxRGw8sMTRLHTmlbBJWApNCo/YKrknQeMHoHFeftIAOrvSvZrKey0zocGExmN
 PAI1c9Z4C8RxgvMUxipQ2EAAaGrfZilXwDDNC4PXzFiAs8tas24694qrrn9PrLcBlWDq
 M6QDPBtZq3HFdJvrjVrtIOvCjkrfEiDI5gzDNWhObB3+03ccQzNWwdPbcO6YDcKl2uTl
 hbbQDi9N1dk1tIIiUEjdoyZIbzaToAhCppFT13ZcOLI55ji7dn5LfMotruUwJ1qpsKHw
 DPZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvwc+NzIbv4xnNxzo+yUYcd1KfQJjdKFiqngama/AsFpkGy3uRUlQi32qg2ysR0aUKK2URRJ2uZ6iI6i93Eqck0eYj
X-Gm-Message-State: AOJu0YxwLX7ffGJPRpk/FyvD7aUkXnxJNzvXmLW3I0ojhQdcBFUMPLkx
 tIxpQz0wToctRaygRJcDFiWXNx9WOEVKWJiT/i320D2hMBi+842x7ggmQqiZ
X-Google-Smtp-Source: AGHT+IHFAJurQrcu/3oUlSEP+2kyBaHonL2Y5LJaI4IVOts+Xrj8cb3kKN668ehVEFd0xTKipv3Crw==
X-Received: by 2002:a17:903:4284:b0:1d8:e4b8:95e5 with SMTP id
 ju4-20020a170903428400b001d8e4b895e5mr168712plb.32.1708703000241; 
 Fri, 23 Feb 2024 07:43:20 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 08/47] tests/avocado: ppc add hypervisor tests
Date: Sat, 24 Feb 2024 01:41:27 +1000
Message-ID: <20240223154211.1001692-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The powernv and pseries machines both provide hypervisor facilities
that are supported by KVM. This is a large and complicated set of
features that don't get much system-level testing in ppc tests.

Add a new test case for these which runs QEMU KVM inside the target.
This downloads an Alpine VM image, boots it and downloads and installs
the qemu package, then boots a virtual machine under it, re-using the
original Alpine VM image.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                   |   1 +
 tests/avocado/ppc_hv_tests.py | 202 ++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 tests/avocado/ppc_hv_tests.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dd98a923f..3b409b42a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1526,6 +1526,7 @@ F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
 F: tests/avocado/ppc_pseries.py
+F: tests/avocado/ppc_hv_tests.py
 
 PowerNV (Non-Virtualized)
 M: Cédric Le Goater <clg@kaod.org>
diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
new file mode 100644
index 0000000000..5080358e25
--- /dev/null
+++ b/tests/avocado/ppc_hv_tests.py
@@ -0,0 +1,202 @@
+# Tests that specifically try to exercise hypervisor features of the
+# target machines. powernv supports the Power hypervisor ISA, and
+# pseries supports the nested-HV hypervisor spec.
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado import skipIf, skipUnless
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern, exec_command
+import os
+import time
+import subprocess
+
+deps = ["xorriso"] # dependent tools needed in the test setup/box.
+
+def which(tool):
+    """ looks up the full path for @tool, returns None if not found
+        or if @tool does not have executable permissions.
+    """
+    paths=os.getenv('PATH')
+    for p in paths.split(os.path.pathsep):
+        p = os.path.join(p, tool)
+        if os.path.exists(p) and os.access(p, os.X_OK):
+            return p
+    return None
+
+def missing_deps():
+    """ returns True if any of the test dependent tools are absent.
+    """
+    for dep in deps:
+        if which(dep) is None:
+            return True
+    return False
+
+# Alpine is a light weight distro that supports QEMU. These tests boot
+# that on the machine then run a QEMU guest inside it in KVM mode,
+# that runs the same Alpine distro image.
+# QEMU packages are downloaded and installed on each test. That's not a
+# large download, but it may be more polite to create qcow2 image with
+# QEMU already installed and use that.
+@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
+@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
+class HypervisorTest(QemuSystemTest):
+
+    timeout = 1000
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
+    panic_message = 'Kernel panic - not syncing'
+    good_message = 'VFS: Cannot open root device'
+
+    def extract_from_iso(self, iso, path):
+        """
+        Extracts a file from an iso file into the test workdir
+
+        :param iso: path to the iso file
+        :param path: path within the iso file of the file to be extracted
+        :returns: path of the extracted file
+        """
+        filename = os.path.basename(path)
+
+        cwd = os.getcwd()
+        os.chdir(self.workdir)
+
+        with open(filename, "w") as outfile:
+            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
+            subprocess.run(cmd.split(),
+                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+
+        os.chdir(cwd)
+
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_iso() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir, filename))
+
+    def setUp(self):
+        super().setUp()
+
+        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
+
+        # Alpine use sha256 so I recalculated this myself
+        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
+        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
+                                    algorithm = "sha256")
+
+        self.iso_path = iso_path
+        self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
+        self.initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
+
+    def do_start_alpine(self):
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args("-kernel", self.vmlinuz)
+        self.vm.add_args("-initrd", self.initramfs)
+        self.vm.add_args("-smp", "4", "-m", "2g")
+        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,id=drive0")
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'localhost login:')
+        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command(self, 'setup-alpine -qe')
+        wait_for_console_pattern(self, 'Updating repository indexes... done.')
+
+    def do_stop_alpine(self):
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'alpine:~#')
+        self.vm.wait()
+
+    def do_setup_kvm(self):
+        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'apk update')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'apk add qemu-system-ppc64')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'modprobe kvm-hv')
+        wait_for_console_pattern(self, 'alpine:~#')
+
+    # This uses the host's block device as the source file for guest block
+    # device for install media. This is a bit hacky but allows reuse of the
+    # iso without having a passthrough filesystem configured.
+    def do_test_kvm(self, hpt=False):
+        if hpt:
+            append = 'disable_radix'
+        else:
+            append = ''
+        exec_command(self, 'qemu-system-ppc64 -nographic -smp 2 -m 1g '
+                           '-machine pseries,x-vof=on,accel=kvm '
+                           '-machine cap-cfpc=broken,cap-sbbc=broken,'
+                                    'cap-ibs=broken,cap-ccf-assist=off '
+                           '-drive file=/dev/nvme0n1,format=raw,readonly=on '
+                           '-initrd /media/nvme0n1/boot/initramfs-lts '
+                           '-kernel /media/nvme0n1/boot/vmlinuz-lts '
+                           '-append \'usbcore.nousb ' + append + '\'')
+        # Alpine 3.18 kernel seems to crash in XHCI USB driver.
+        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'localhost login:')
+        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command(self, 'poweroff >& /dev/null')
+        wait_for_console_pattern(self, 'localhost:~#')
+        wait_for_console_pattern(self, 'reboot: Power down')
+        time.sleep(1)
+        exec_command(self, '')
+        wait_for_console_pattern(self, 'alpine:~#')
+
+    def test_hv_pseries(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
+        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_stop_alpine()
+
+    def test_hv_pseries_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
+        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on,cap-ccf-assist=off")
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_stop_alpine()
+
+    def test_hv_powernv(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
+                         '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
+                         '-netdev', 'user,id=net0,hostfwd=::20022-:22,hostname=alpine')
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_test_kvm(True)
+        self.do_stop_alpine()
-- 
2.42.0


