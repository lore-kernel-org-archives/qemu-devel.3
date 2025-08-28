Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2564C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau0-0003IL-Ak; Thu, 28 Aug 2025 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urats-0003DX-8v
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratp-0005cd-Su
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b55ed86b9so4327445e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380876; x=1756985676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xU6DtKahST/Q0lK7j2pNj1bQhcUnlvAusucbHEq/Suw=;
 b=oGmBplU/TCmeTYzJ5gSMDo9+2m9mbDIGD2sMjH7BLSdmzADduGBUSOKMqEjoyBvUop
 Q3uyoFBqxsA7qK2h9exMmDysAedu30aT+am+RWNzQMn6DwLtXqLi6UXEzBfUHtQi4/Qk
 Lpj3rlb7EH5Ld601pm8IiM3vrvygB33rd1BjGfP39RVHLDsmNTOdau/LPJw4sg6Bmd+p
 nH6uYq11W4bjx+Z3dSTaL+q8PNXkpCRC6Z8UDgNSnTvo0tkp+yE9VsB48bmlNY7BDKFB
 ru04d8oabQ37UpbFCigF1iQW/L070WLHJ1jdsawNZAHs5WU5W2iK36dLRPgXCb0XV74v
 jA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380876; x=1756985676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xU6DtKahST/Q0lK7j2pNj1bQhcUnlvAusucbHEq/Suw=;
 b=DzA3KM9VxtO8Pw7uQNp7bFL/eBeb7thmBjE2QL0lDzCYqK92bBmPHe/7i3uNengCXK
 Vaenf4e0YOTPzFtIdZCWMjHk8Sng/CLZER+babvTaUChoeWNbzs2b9a6rGAPjuNWbZp8
 v4USfwFc66kVbYFPtyq4DQyXSEhNEcwlVOkDmBMuYnr7PgjW81xZD4khB6g3ixoYfayd
 prDETJYziTWeXdOUxyuH0XHRqb5HWX0XpVCAICm552pAm+cXaWbgoTrM/FFGD+hlS6m2
 bBcX2lzbN1de/dY70EeEYQFtf6j3ysajXqT4AKNfCd1nocrUdKPylIaQcCF+GEn7TcHZ
 HKVA==
X-Gm-Message-State: AOJu0Yzh9EuntVb5cPHyeFDjBdFBA8KvTB2HtxAMZDxspeQ7ggwjtTZW
 Ylmq7Mw7tWfFRyGjQymaiqcb6C8Qdk4ogxBBSEygVNE8eE9XJWC/dedfItkK15oYNbJcZVb8GtS
 PaSSk
X-Gm-Gg: ASbGncuEPFLAqbjl/i4niRjRWK08DCe5/qW8JHCyIkBTYCijABnrJHsaamUwRZZAmCT
 3ky/E9oYelNAtzFGiwwtxDrRks3EFodLipUgEn5OCkoqjva1oyGKnpzKjLwS7hbrviifDMIfcdI
 DvWc4p8ddpGfrQuDod4cee5S+TwRtN0xM4cOVyF5K4/NCPTBm2KSdKsSIJcYyG+L9M0zeRy6rxH
 iMIu1sQxe+Bth5XM/qUggVg4ujYBaHfn8AwLMy6XWXFLleaMndr/zyiQFhJmd9TKXv0QR1bWbfw
 t19ZOr3OKUunNR+RP8NCZzJJ4ejTFwzOpGd4ToFyJtRb1vSdMGLvINuy6ATfypC0DlTbpCyBm1K
 dE3sYrM0+hDrvRkRVmong7RNm07Z8A+AX7aTaRK8=
X-Google-Smtp-Source: AGHT+IHRzSwqnkK1HXoQDxf2SbRGNPONMFRQ60xXTHLZOo4yrxuhrDCAAh+8+PU6bfotOzsmOTM6lQ==
X-Received: by 2002:a05:600c:3104:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-45b517e0364mr173136375e9.36.1756380876094; 
 Thu, 28 Aug 2025 04:34:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] tests/functional/test_aarch64_rme: update image
Date: Thu, 28 Aug 2025 12:34:00 +0100
Message-ID: <20250828113430.3214314-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

TF-A needs to be patched to enable support for FEAT_TCR2 and
FEAT_SCTLR2. This new image contains updated firmware.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250727074202.83141-3-richard.henderson@linaro.org
Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
[PMM: switch to os.makedirs(..., exist_ok=True) to improve
 robustness when re-run after test was cancelled midway]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_rme_sbsaref.py | 64 ++++++++-------
 tests/functional/aarch64/test_rme_virt.py    | 85 +++++++-------------
 2 files changed, 66 insertions(+), 83 deletions(-)

diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index 100f1c7738b..ca892e0a8c9 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -10,21 +10,23 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+from os.path import join
+import shutil
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from test_rme_virt import test_realms_guest
 
 
 class Aarch64RMESbsaRefMachine(QemuSystemTest):
 
-    # Stack is built with OP-TEE build environment from those instructions:
+    # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
-    # https://github.com/pbo-linaro/qemu-rme-stack
+    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_sbsa_release
+    # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
-        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
-         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
-         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
+        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+         'releases/download/build/rme_sbsa_release-a7f02cf.tar.xz'),
+         '27d8400b11befb828d6db0cab97e7ae102d0992c928d3dfbf38b24b6cf6c324c')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -35,35 +37,41 @@ def test_aarch64_rme_sbsaref(self):
 
         self.vm.set_console()
 
-        stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
-        self.archive_extract(stack_path_tar_gz, format="tar")
+        stack_path_tar = self.ASSET_RME_STACK_SBSA.fetch()
+        self.archive_extract(stack_path_tar, format="tar")
 
-        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-sbsa')
-        pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
-        pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
-        virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
-        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+        rme_stack = self.scratch_file('.')
+        pflash0 = join(rme_stack, 'out', 'SBSA_FLASH0.fd')
+        pflash1 = join(rme_stack, 'out', 'SBSA_FLASH1.fd')
+        rootfs = join(rme_stack, 'out', 'host.ext4')
 
-        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
+        efi = join(rme_stack, 'out', 'EFI')
+        os.makedirs(efi, exist_ok=True)
+        shutil.copyfile(join(rme_stack, 'out', 'Image'), join(efi, 'Image'))
+        with open(join(efi, 'startup.nsh'), 'w') as startup:
+            startup.write('fs0:Image nokaslr root=/dev/vda rw init=/init --'
+                          ' /host/out/lkvm run --realm'
+                          ' -m 256m'
+                          ' --restricted_mem'
+                          ' --kernel /host/out/Image'
+                          ' --disk /host/out/guest.ext4'
+                          ' --params "root=/dev/vda rw init=/init"')
+
+        self.vm.add_args('-cpu', 'max,x-rme=on')
+        self.vm.add_args('-smp', '2')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'sbsa-ref')
         self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
         self.vm.add_args('-drive', f'file={pflash1},format=raw,if=pflash')
-        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')
-        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
-        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
-        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=shr0,mount_tag=shr0')
-        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
-        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
-        self.vm.add_args('-netdev', 'user,id=net0')
-
+        self.vm.add_args('-drive', f'file=fat:rw:{efi},format=raw')
+        self.vm.add_args('-drive', f'format=raw,file={rootfs},if=virtio')
+        self.vm.add_args('-virtfs',
+                         f'local,path={rme_stack}/,mount_tag=host,'
+                         'security_model=mapped,readonly=off')
         self.vm.launch()
-        # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot',
-                                 failure_message='Synchronous Exception at')
-        exec_command_and_wait_for_pattern(self, 'root', '#')
-
-        test_realms_guest(self)
+        # Wait for host and guest VM boot to complete.
+        wait_for_console_pattern(self, 'root@guest',
+                                 failure_message='Kernel panic')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
index 8452d27928f..bb603aaa26c 100755
--- a/tests/functional/aarch64/test_rme_virt.py
+++ b/tests/functional/aarch64/test_rme_virt.py
@@ -9,50 +9,22 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
+from os.path import join
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 
-def test_realms_guest(test_rme_instance):
-
-    # Boot the (nested) guest VM
-    exec_command(test_rme_instance,
-                 'qemu-system-aarch64 -M virt,gic-version=3 '
-                 '-cpu host -enable-kvm -m 512M '
-                 '-M confidential-guest-support=rme0 '
-                 '-object rme-guest,id=rme0 '
-                 '-device virtio-net-pci,netdev=net0,romfile= '
-                 '-netdev user,id=net0 '
-                 '-kernel /mnt/out/bin/Image '
-                 '-initrd /mnt/out-br/images/rootfs.cpio '
-                 '-serial stdio')
-    # Detect Realm activation during (nested) guest boot.
-    wait_for_console_pattern(test_rme_instance,
-                             'SMC_RMI_REALM_ACTIVATE')
-    # Wait for (nested) guest boot to complete.
-    wait_for_console_pattern(test_rme_instance,
-                             'Welcome to Buildroot')
-    exec_command_and_wait_for_pattern(test_rme_instance, 'root', '#')
-    # query (nested) guest cca report
-    exec_command(test_rme_instance, 'cca-workload-attestation report')
-    wait_for_console_pattern(test_rme_instance,
-                             '"cca-platform-hash-algo-id": "sha-256"')
-    wait_for_console_pattern(test_rme_instance,
-                             '"cca-realm-hash-algo-id": "sha-512"')
-    wait_for_console_pattern(test_rme_instance,
-                             '"cca-realm-public-key-hash-algo-id": "sha-256"')
-
 class Aarch64RMEVirtMachine(QemuSystemTest):
 
-    # Stack is built with OP-TEE build environment from those instructions:
+    # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
-    # https://github.com/pbo-linaro/qemu-rme-stack
+    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_release
+    # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
-        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
-         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
-         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7ad')
+        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+         'releases/download/build/rme_release-86101e5.tar.xz'),
+         'e42fef8439badb52a071ac446fc33cff4cb7d61314c7a28fdbe61a11e1faad3a')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -63,15 +35,16 @@ def test_aarch64_rme_virt(self):
 
         self.vm.set_console()
 
-        stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
-        self.archive_extract(stack_path_tar_gz, format="tar")
+        stack_path_tar = self.ASSET_RME_STACK_VIRT.fetch()
+        self.archive_extract(stack_path_tar, format="tar")
 
-        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-qemu_v8')
-        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
-        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
-        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+        rme_stack = self.scratch_file('.')
+        kernel = join(rme_stack, 'out', 'Image')
+        bios = join(rme_stack, 'out', 'flash.bin')
+        rootfs = join(rme_stack, 'out', 'host.ext4')
 
-        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
+        self.vm.add_args('-cpu', 'max,x-rme=on')
+        self.vm.add_args('-smp', '2')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'virt,acpi=off,'
                          'virtualization=on,'
@@ -79,23 +52,25 @@ def test_aarch64_rme_virt(self):
                          'gic-version=3')
         self.vm.add_args('-bios', bios)
         self.vm.add_args('-kernel', kernel)
-        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
-        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
-        self.vm.add_args('-device', 'virtio-9p-device,fsdev=shr0,mount_tag=shr0')
-        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
-        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
-        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-drive', f'format=raw,file={rootfs},if=virtio')
+        self.vm.add_args('-virtfs',
+                         f'local,path={rme_stack}/,mount_tag=host,'
+                         'security_model=mapped,readonly=off')
         # We need to add nokaslr to avoid triggering this sporadic bug:
         # https://gitlab.com/qemu-project/qemu/-/issues/2823
-        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
+        self.vm.add_args('-append',
+                         'nokaslr root=/dev/vda rw init=/init --'
+                         ' /host/out/lkvm run --realm'
+                         ' -m 256m'
+                         ' --restricted_mem'
+                         ' --kernel /host/out/Image'
+                         ' --disk /host/out/guest.ext4'
+                         ' --params "root=/dev/vda rw init=/init"')
 
         self.vm.launch()
-        # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot',
-                                 failure_message='Synchronous Exception at')
-        exec_command_and_wait_for_pattern(self, 'root', '#')
-
-        test_realms_guest(self)
+        # Wait for host and guest VM boot to complete.
+        wait_for_console_pattern(self, 'root@guest',
+                                 failure_message='Kernel panic')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.43.0


