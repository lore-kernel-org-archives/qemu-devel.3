Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB890D70DF1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 21:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGmCp-0007Tm-8V; Thu, 28 Nov 2024 16:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGmCn-0007TR-Ix
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:37:45 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGmCk-000105-U0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:37:44 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so10634735ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 13:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732829860; x=1733434660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AIljxQ5lKy1BxzhydrV476Rj0l67EivfvuNeq97pdhg=;
 b=JsrfGg9xSU2JiqcZN99b+DrbmNBUAJc3velTgcT1qQDle+UxY9Pd4gC6kz+wXCMW4G
 QDtC//Ss5eWfsvHIpScdhXDhQTTvAa1/HB+pHuDQmrfrmJY8fDyobA6gvpYJ+FFj5nG2
 EW5+pRdjCvcbKgnD/8/fAQnRhjilVtMaZQHJBsOATGrJSliW29CBL15Br6afhBShtG/Z
 3ii8UADGswEQRV3Yj5oDMiolSPkbQcTG6rUiz0WvTHOlsVkrwo3Mgr4wJCeVdSd6Cg9s
 XRdRn2Xc8KgTqKw/ADN+V8Nq3b63oAN9X/NL/DwxTFrrZws+MvDMQplYSae587fIbtbu
 AEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732829860; x=1733434660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AIljxQ5lKy1BxzhydrV476Rj0l67EivfvuNeq97pdhg=;
 b=U2rZXgiHZY0Gn4/XSQ946fyCN9Ps+vyamBvpbCmo8DandAg+vAGi8gIXvbH2PExjmv
 yxzH26xcdtWeHIvM5hzneqiPgVyrW5C1+KVNCnJQtgX54x42M7uknMAOImMnVJj1DztB
 btE0JjqWLVxSczhA+mSrjcodhm1CnBx2hzEU28SozsnoIVI9PlB6h69cFhLILYFBjeLP
 W/V2X3+3AAWsA54XXapvVzFoLwfmGJam9M0E8xRv1vvlbYyEPn+SYXOLD9d2TbIOElSi
 QpWnOrJ0v/wNYEH1MIi3wdTqvyx+lEtP0mJDoj+1arVkRf5Uy6AznIfZRaCVRdPVThru
 enMA==
X-Gm-Message-State: AOJu0YzXRX3uR5BLGP8z+AADoGOXE+fPTQ5DZCEn1jGAZul53GygFA0H
 QFJf+1kD/7huwTHD1ThtM8z6eVLPLlGU8RyGfh7tGhW4BlGgcsz4mBdOyGMsQV9RnHe+1qpiMoi
 PDl0=
X-Gm-Gg: ASbGncu7NawnpLsmYkMyQ7gsWtaTmkMyfe1vLYBbhbDheARA/cEZu2gvMCAVqVZnlqI
 0Ddbvf5b171iC44sZJ7cG/3F2v9RkdUKqT5TQB605mV42pA4Xs0aLAFcDsBLPCaFIKAk6/o6qln
 oJ1tlljHcAkv4iB7YZlvCOAho8qP/zSjeh6TzJzVUHU6YwNaDoVD5d/HLu9jNi63jKOKVKGfFQx
 GCCMhSHKuIPgJ2R9tv54fGmvdYdGJEL+HxSLP2Gq204kwtLPDIUwogVtl90VsSSCuO9dDvcbFnu
 U1vXC4v+jfYeAg==
X-Google-Smtp-Source: AGHT+IEfHiE7BkLVEuxz6qacW2t5x+JBoCKDQLlKaYT/42zCYPDR2kYMLDavin8029nHD7xPKQwz2A==
X-Received: by 2002:a17:902:d50e:b0:212:20c2:5fcd with SMTP id
 d9443c01a7336-21501385212mr99573495ad.26.1732829859763; 
 Thu, 28 Nov 2024 13:37:39 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2152198a386sm17812675ad.209.2024.11.28.13.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 13:37:39 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
Date: Thu, 28 Nov 2024 13:37:29 -0800
Message-Id: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

This boot an OP-TEE environment, and launch a nested guest VM inside it
using the Realms feature. We do it for virt and sbsa-ref platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

-----

v2:
- move test to its own file
- add sbsa test
- check output of `cca-workload-attestation report`

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/meson.build                 |  4 +
 tests/functional/test_aarch64_rme_sbsaref.py | 96 +++++++++++++++++++
 tests/functional/test_aarch64_rme_virt.py    | 98 ++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 5c048cfac6d..b975a1560df 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,8 @@ endif
 test_timeouts = {
   'aarch64_aspeed' : 600,
   'aarch64_raspi4' : 480,
+  'aarch64_rme_virt' : 720,
+  'aarch64_rme_sbsaref' : 720,
   'aarch64_sbsaref_alpine' : 720,
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
@@ -52,6 +54,8 @@ tests_aarch64_system_thorough = [
   'aarch64_aspeed',
   'aarch64_raspi3',
   'aarch64_raspi4',
+  'aarch64_rme_virt',
+  'aarch64_rme_sbsaref',
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
new file mode 100755
index 00000000000..af3f9fb2d64
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Realms environment on sbsa-ref machine and a
+# nested guest VM using it.
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import os
+import logging
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+
+
+class Aarch64RMESbsaRefMachine(QemuSystemTest):
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_SBSA = Asset(
+        ('https://fileserver.linaro.org/s/pBCeJktME2T5ikj/'
+         'download/rme-stack-op-tee-4.2.0-cca-v3-sbsa.tar.gz'),
+         '67542c80e5cfa84494f757bbee80b3535946c74666b8b82681f8eceb0e91d4ef')
+
+    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
+    # and launching a nested VM using it.
+    def test_aarch64_rme_sbsaref(self):
+        stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
+        archive_extract(stack_path_tar_gz, self.workdir)
+
+        self.set_machine('sbsa-ref')
+        self.vm.set_console()
+        self.require_accelerator('tcg')
+
+        rme_stack = os.path.join(self.workdir,
+                                 'rme-stack-op-tee-4.2.0-cca-v3-sbsa')
+        pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
+        pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
+        virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-accel', 'tcg')
+        self.vm.add_args('-cpu', 'max,x-rme=on')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'sbsa-ref')
+        self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
+        self.vm.add_args('-drive', f'file={pflash1},format=raw,if=pflash')
+        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')
+        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
+        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
+        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=shr0,mount_tag=shr0')
+        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
+        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
+
+        self.vm.launch()
+        # Wait for host VM boot to complete.
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        # We now boot the (nested) guest VM
+        exec_command(self,
+                     'qemu-system-aarch64 -M virt,gic-version=3 '
+                     '-cpu host -enable-kvm -m 512M '
+                     '-M confidential-guest-support=rme0 '
+                     '-object rme-guest,id=rme0,measurement-algo=sha256 '
+                     '-device virtio-net-pci,netdev=net0,romfile= '
+                     '-netdev user,id=net0 '
+                     '-kernel /mnt/out/bin/Image '
+                     '-initrd /mnt/out-br/images/rootfs.cpio '
+                     '-serial stdio')
+        # Detect Realm activation during (nested) guest boot.
+        self.wait_for_console_pattern('SMC_RMI_REALM_ACTIVATE')
+        # Wait for (nested) guest boot to complete.
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        # query (nested) guest cca report
+        exec_command(self, 'cca-workload-attestation report')
+        self.wait_for_console_pattern('"cca-platform-hash-algo-id": "sha-256"')
+        self.wait_for_console_pattern('"cca-realm-hash-algo-id": "sha-256"')
+        self.wait_for_console_pattern('"cca-realm-public-key-hash-algo-id": "sha-256"')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
new file mode 100755
index 00000000000..cd895da46b6
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -0,0 +1,98 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Realms environment on virt machine and a nested
+# guest VM using it.
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import os
+import logging
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+
+
+class Aarch64RMEVirtMachine(QemuSystemTest):
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_VIRT = Asset(
+        ('https://fileserver.linaro.org/s/7dsXdtbDfBZbCTC/'
+         'download/rme-stack-op-tee-4.2.0-cca-v3-qemu_v8.tar.gz'),
+         '0b49f2652a7201d100365b8ccc6c317f1f8f2f4de6feed084080f52fe1b5fadc')
+
+    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
+    # and launching a nested VM using it.
+    def test_aarch64_rme_virt(self):
+        stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
+        archive_extract(stack_path_tar_gz, self.workdir)
+
+        self.set_machine('virt')
+        self.vm.set_console()
+        self.require_accelerator('tcg')
+
+        rme_stack = os.path.join(self.workdir,
+                                 'rme-stack-op-tee-4.2.0-cca-v3-qemu_v8')
+        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
+        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-accel', 'tcg')
+        self.vm.add_args('-cpu', 'max,x-rme=on')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'virt,acpi=off,'
+                         'virtualization=on,'
+                         'secure=on,'
+                         'gic-version=3')
+        self.vm.add_args('-bios', bios)
+        self.vm.add_args('-kernel', kernel)
+        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
+        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
+        self.vm.add_args('-device', 'virtio-9p-device,fsdev=shr0,mount_tag=shr0')
+        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
+        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-append', 'root=/dev/vda')
+
+        self.vm.launch()
+        # Wait for host VM boot to complete.
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        # We now boot the (nested) guest VM
+        exec_command(self,
+                     'qemu-system-aarch64 -M virt,gic-version=3 '
+                     '-cpu host -enable-kvm -m 512M '
+                     '-M confidential-guest-support=rme0 '
+                     '-object rme-guest,id=rme0,measurement-algo=sha512 '
+                     '-device virtio-net-pci,netdev=net0,romfile= '
+                     '-netdev user,id=net0 '
+                     '-kernel /mnt/out/bin/Image '
+                     '-initrd /mnt/out-br/images/rootfs.cpio '
+                     '-serial stdio')
+        # Detect Realm activation during (nested) guest boot.
+        self.wait_for_console_pattern('SMC_RMI_REALM_ACTIVATE')
+        # Wait for (nested) guest boot to complete.
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        # query (nested) guest cca report
+        exec_command(self, 'cca-workload-attestation report')
+        self.wait_for_console_pattern('"cca-platform-hash-algo-id": "sha-256"')
+        self.wait_for_console_pattern('"cca-realm-hash-algo-id": "sha-512"')
+        self.wait_for_console_pattern('"cca-realm-public-key-hash-algo-id": "sha-256"')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.39.5


