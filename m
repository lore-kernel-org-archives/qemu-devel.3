Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF16E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75y-0007WC-2p; Tue, 10 Dec 2024 15:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75d-0007Cj-3r
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:18 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75O-000250-9M
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so17236f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863441; x=1734468241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO7Rkh0kNcH52cHtxwJZh0wpmiOhoRyHZYNCvSJEn60=;
 b=qRhFjLNA3Etj3NRC1HRzE5lodG12xSKjFoiuyKjG9xOIFqmzou/mSbHH4+jbmuxqbi
 +IwdpK33wSgcChpS5uEYEbm0J120BtCWOfsqeZoIjQfEekS6/3Ypl9amMkJcLznE1MOs
 g1LY6wfCdoKs6b1X7UpR7YzdB72axFWUSqGzPk/wOu15J/SqCWnvrxSwL1k7fUCgZ9xB
 NejunDpOCIBBpfxbbM6U1KFvrYK8DQ3AsEjOsIb+4Vc2bUqWN1kNc68t8sNci15/sd1+
 KhgIFgXBS1ZLZNAntOZIM0PkFA71K5k8RozBARrWxTgNMkBWsvhpbm+Uo83BF1PrQg8E
 VIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863441; x=1734468241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO7Rkh0kNcH52cHtxwJZh0wpmiOhoRyHZYNCvSJEn60=;
 b=wOt0U8qNBsOV+uN1m9AnAC/WaXHN76HqLXLE/KUXD2NpEwS9zPYIZ9+nJo2//MuYGL
 D/o1X8sO5nowbsnYpFVB6OW74khfLbE8IT26ohywp84wjPQUB/cX1Wy0S1EaHSdO+Jo5
 hkLwfoHqyU6KlFuRaBXupTsN9jyf162QEADL/SP2us+xNaQ8DvLQElFsax9myhMSholM
 /qN+Aasm1t6s9vJtbyBkl5ByNrUIc/kxpAusIoOhLpitDMmweSlSMYm3So/Hv/JUWNwr
 DudKQoDPLMx5ltIYFVGQDSaHOXesvJzrdsNyMAd7CSNsG1K59iYS0Ubto9Fhzy55rB6K
 +IZw==
X-Gm-Message-State: AOJu0Yzt17z2AiESVJhcRVup5pwtsKhxxIJb1hZuc9aAx63N929LRhQY
 p/26koY07askk6yT+gXKZOKDDlCsyCtVXfWKpUg7+2e48JNpajzlfL3JObsusPI=
X-Gm-Gg: ASbGncvm0gL+UoQn+haSUC0CRJFJHSMnlWFGrA96rpXNuRkO/n50xaWOuiWaVEBoCGB
 qneiAqSvq40eQTjTmuMVKU+06eK4O9h6k5VQvqkjhsZ5+tazpDH013D1R8VTT4xcF+oRmL2XOY7
 qr8w6C++miTlht4ct6itqfvxpZZtqxkc6qJSFxMYX/44hfEpmzIpH0yREuNIQUZXVfalvoh2VrQ
 K4m68SQCVf8FcmZVgPg0jgaJzqDQi3RpCMrsVWz0jbslVrQXOPE
X-Google-Smtp-Source: AGHT+IHB9jfiCMge6xvoMP8JLCIaen/Zs0h1oM3Kfa/6TidQkYZATwGb25cuTJifart++l6ZStAfVA==
X-Received: by 2002:a05:6000:1843:b0:386:3262:ff70 with SMTP id
 ffacd0b85a97d-3864de8ef4dmr122246f8f.2.1733863440579; 
 Tue, 10 Dec 2024 12:44:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4087sm17106689f8f.5.2024.12.10.12.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AAFB16037E;
 Tue, 10 Dec 2024 20:43:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 15/20] tests/functional/aarch64: add tests for FEAT_RME
Date: Tue, 10 Dec 2024 20:43:44 +0000
Message-Id: <20241210204349.723590-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

This boot an OP-TEE environment, and launch a nested guest VM inside it
using the Realms feature. We do it for virt and sbsa-ref platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

-----

v2:
- move test to its own file
- add sbsa test
- check output of `cca-workload-attestation report`

v3:
- build and run test with cca-v4 images
- factorize nested guest test between both tests
- remove accel tcg option as it is the default when running tests
Note: It's a long test and there is a work in progress to understand why
debug build is so slow (x12 vs optimized).

v4:
- use pauth-impdef=on to speed up build time execution (x2.5 faster)
- increase timeout value

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241203213629.2482806-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/meson.build                 |   4 +
 tests/functional/test_aarch64_rme_sbsaref.py |  70 +++++++++++++
 tests/functional/test_aarch64_rme_virt.py    | 100 +++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0a76bd9954..4e207c53d5 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,8 @@ endif
 test_timeouts = {
   'aarch64_aspeed' : 600,
   'aarch64_raspi4' : 480,
+  'aarch64_rme_virt' : 1200,
+  'aarch64_rme_sbsaref' : 1200,
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
index 0000000000..c136b5ce17
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -0,0 +1,70 @@
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
+from test_aarch64_rme_virt import test_realms_guest
+
+class Aarch64RMESbsaRefMachine(QemuSystemTest):
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_SBSA = Asset(
+        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
+         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
+         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
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
+                                 'rme-stack-op-tee-4.2.0-cca-v4-sbsa')
+        pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
+        pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
+        virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
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
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        test_realms_guest(self)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
new file mode 100755
index 0000000000..39e4e4adb5
--- /dev/null
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -0,0 +1,100 @@
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
+def test_realms_guest(test_rme_instance):
+
+    # Boot the (nested) guest VM
+    exec_command(test_rme_instance,
+                 'qemu-system-aarch64 -M virt,gic-version=3 '
+                 '-cpu host -enable-kvm -m 512M '
+                 '-M confidential-guest-support=rme0 '
+                 '-object rme-guest,id=rme0 '
+                 '-device virtio-net-pci,netdev=net0,romfile= '
+                 '-netdev user,id=net0 '
+                 '-kernel /mnt/out/bin/Image '
+                 '-initrd /mnt/out-br/images/rootfs.cpio '
+                 '-serial stdio')
+    # Detect Realm activation during (nested) guest boot.
+    wait_for_console_pattern(test_rme_instance,
+                             'SMC_RMI_REALM_ACTIVATE')
+    # Wait for (nested) guest boot to complete.
+    wait_for_console_pattern(test_rme_instance,
+                             'Welcome to Buildroot')
+    exec_command_and_wait_for_pattern(test_rme_instance, 'root', '#')
+    # query (nested) guest cca report
+    exec_command(test_rme_instance, 'cca-workload-attestation report')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-platform-hash-algo-id": "sha-256"')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-realm-hash-algo-id": "sha-512"')
+    wait_for_console_pattern(test_rme_instance,
+                             '"cca-realm-public-key-hash-algo-id": "sha-256"')
+
+class Aarch64RMEVirtMachine(QemuSystemTest):
+
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK_VIRT = Asset(
+        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
+         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
+         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7ad')
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
+                                 'rme-stack-op-tee-4.2.0-cca-v4-qemu_v8')
+        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
+        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
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
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        test_realms_guest(self)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.39.5


