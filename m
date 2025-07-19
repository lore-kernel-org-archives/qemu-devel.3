Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD93C83F3D
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 04:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucyj2-0004CX-HM; Fri, 18 Jul 2025 23:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucyiv-00040T-Hz
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 23:58:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucyir-00071o-4A
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 23:58:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b3be5c0eb99so2070103a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 20:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752897530; x=1753502330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmpYkkW2T5351sW+n25nvUIMoB840GbkMt5lsg8Dg+I=;
 b=pa4jJLWzSDFeAdZ2Q3MMa1xe//7mg71k3DBDwG+QmmpJm0Rhc4lSrWqjpELCp3D869
 xJ0BcD1da5lb4MfIJ/7CN9iLwY6Pjlu3U28AGy60vngN/v8Ua1mQ5fG7XMqd1xL8eLcq
 41jFyaYjGoBTtg3+hxUJtr+J330hlr+iAbl5DfdnUhhzUCsbRLoaZNDXRF45nUlkwLAt
 vYYGGPAw62E8ulRkyUfspHIsg91np8HnzgsT7JKW14ELvAYQVBh0gRZg39LepXR/y69Q
 F8/xwel2YpRasqHDGwUFhNPspHDWvgJwjNVJ5n0+CH+q4Qct5eirBjvZp5IcSkDpPvKk
 +HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752897530; x=1753502330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmpYkkW2T5351sW+n25nvUIMoB840GbkMt5lsg8Dg+I=;
 b=lxBmVldB+FwQPYZat8jyg5I8JDbvTc4kNDLZZ33uy6en9SceuXCxMRI24WaGPg/9lt
 wqWm3jzluOvwrJ9tEp4sk+O9d/e1heamjEVVHyNQk7OYIOAaSzktu+RH2CJ0WeiCNu8X
 BFkbEKguvslo+CFZh0pSWQm52GFfMPMh3nY9xKcBGSlJtCS4Zz5o7A+4UBJI+D4h2sDe
 M4ztYk4IXAckRgP6fWes4IvIiiAcRh2NSJE1IjG2rw/gbVOknpnuUtF3LN6g3KKWrPqQ
 8Ko9H41ZCaMtI/s5l/UzbArj/bePZkvr6OTJFuIUfDWhqx3Zs6LlzZrJ4TGyVE2eoj5g
 FZSQ==
X-Gm-Message-State: AOJu0YwWhbjTKyzrkd1T0vveqPT/D80FYSYW3DeH/Gmr9EmJCjNyxd6S
 JiEqW150OCAfaPacgtgMpgAWiUfa8QCUxCJYR1o8ulMUT6C1i9Chlpr/3gAL02PcS+tcJ0El7oT
 FUmTa+HM=
X-Gm-Gg: ASbGnctnX8UOWCBRFpRpWoA++qFzRu61JIweJfeHq0UjGL3ijuJ+r/kpfmYbDLx+m2Q
 W9KS7p7U+bTiSuv09cZNPrEZwJj1t2zD2eQhKGy7xTXvO6nW91cCvN53GWGAI82grleutfQtRll
 cM74yrxyJgFUN+fG7z9OKvnw+6tYwGHh+7DBpCsgFhv4zMzelG+YOtmGcRgZYxFvEWxYNPF5VTc
 ijTqgxDPX4oZ1KiS3Rs8uiU1eKgoAji8wS1oa/xuJQ1f6BLYMym27FQjI+P80h49x1H4gK4EIHh
 1zNb3aSfuJu5HplHOa4RgSlR0/gDIPvDZCQUM4HNDwsLm7JnOcdH8QHu98HQPDIanZ0h9qhWdMB
 i5Q4zndZuCWJZW8hRpOieoVXVmqPCJnp4
X-Google-Smtp-Source: AGHT+IG5oh21h0Yhw10XI865taJjirmgYKGcY4ctD0zqNP1PLlkrkqBSZ7KNhLRzoP5UQZBNSC6onA==
X-Received: by 2002:a05:6a20:6a22:b0:225:7617:66ff with SMTP id
 adf61e73a8af0-2391c962646mr8480562637.20.1752897529837; 
 Fri, 18 Jul 2025 20:58:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2ff88cf8sm1961819a12.49.2025.07.18.20.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 20:58:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, richard.henderson@linaro.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] tests/functional/test_aarch64_rme: update image
Date: Fri, 18 Jul 2025 20:58:38 -0700
Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
References: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

TF-A needs to be patched to enable support for FEAT_TCR2 and
FEAT_SCTLR2. This new image contains updated firmware.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_rme_sbsaref.py | 64 ++++++++-------
 tests/functional/test_aarch64_rme_virt.py    | 85 +++++++-------------
 2 files changed, 66 insertions(+), 83 deletions(-)

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 746770e776d..cd6390b548a 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -10,21 +10,23 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+from os.path import join
+import shutil
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from test_aarch64_rme_virt import test_realms_guest
 
 
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
+        os.mkdir(efi)
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
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index 8452d27928f..bb603aaa26c 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
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
2.47.2


