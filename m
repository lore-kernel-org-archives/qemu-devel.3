Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DAC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSr-0005sa-J8; Tue, 01 Jul 2025 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSo-0005rM-M2
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSk-0003m2-Ci
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so35129965e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389685; x=1751994485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BLbP+hENQzPCP4H10W/ZiFi144I0pbRy1dph6k1wkAE=;
 b=qnWD9rWJbeQNM/juUekaH4z/g6N4ArvMrjgbjTQuZwfLrbpkWSYGGoctEIwOI0EGRv
 YeGHC+SgLZ2iAjxFmpN9Tam/+qsab6j2oFWycQIftIdLtEM0nXKKyBmNcnGr2TqJK26p
 pnAhBCW3x6ek4pRdCfLARtzYki1FhAkDUxppHICDBval4s3ItUAXSZVt6RSBkBuY1BTv
 x3p8TMtiUZtFe+b9ULNHTqSWNWGaGhiqDVGppYn0YnvfnovfudjVbh2tT9K6DkTztlwf
 I1phlFg1xXoIECKZjjcYpurQ80ywhPN/HvmTw6n5XQo7iJxlgPE3sFzbsh9kYNxEFgAy
 /09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389685; x=1751994485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLbP+hENQzPCP4H10W/ZiFi144I0pbRy1dph6k1wkAE=;
 b=Z+vpUf/V/JffyW5KTBZfDRRFcmjDc6ozxYYA03leKrwnvU6i85gMP4XYfLyflKd2gd
 G2RDSnVzWpakvqPjeQv0nVydoIhY+e/CuPmNLxVl7XyXBag1T0OjMDvKbrhblC2fbrgz
 GoZ6VTnlxz82KK8ATkfn9nujmoju0ewtPGGM0v8DAx+v6hnENz1Tzj9BSOsAGh3eGQ3c
 hRZN0JMi50wrjgZ15OgSOc4rZg1u+k2usRIJcj/CZdbV/0c4sJ64thbGgrz918jP5W/q
 ROqwtjyn+R6llI3sde8MTwzwbeRs19CjekHHyPyvrRdP78uZ5P3QJG/a8oCaqahQLlvA
 kEUQ==
X-Gm-Message-State: AOJu0YxA86yjOH0bZe+lYPgkzmmXFicoPCR9Yjl7NyCkKRl4qkGvhsJo
 UjE+6lh7xvHe1Le40rolS6eSXVf1PlFb40OlF2FZY0wt5aCWaDa5h3tSk8J0xQQaLjgJom/KHm+
 gPlGt
X-Gm-Gg: ASbGncuOUPZXv1uNN9q1FxllnM23TY/VDM0ZEE0GBHjezdaA0VxNLTpcz0q93ujgtAI
 ZKI135kimjgrbHCwY8+hQlIUkFhNercFVKgE7oYvpNEiCQFilsS4xUgPzwFVLbzQ7n7+9yEyBKV
 mOB0bUZaPPOQhE5LKeh+D65mdr6yV/1ydSi6zAz9dpyU3zwVpgoV+aZNOHBw3sft/feDAInByxt
 fX4Pm9gbQ7Bw6Z4LX31+fYdxBufvx1Q0mz8rMvZn8daUsWBKy4i+h757vWWNllIlRUFFrTdj46b
 nWgcdP2CkFUS11++JKQAGCPWooQ18QiXoiGqeSmyvjy1Qsvs+T/D5eOJWSgVvIB+4xsp
X-Google-Smtp-Source: AGHT+IG2n6sFi/V+Gzxippi+6k/c/sLTak68V7kLLXyrvTGc8+DUZZj5Gi5BhVAOE2FIg5jQJM2Nqw==
X-Received: by 2002:a05:6000:1789:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3a90be88de8mr16820277f8f.54.1751389684447; 
 Tue, 01 Jul 2025 10:08:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:08:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] tests/functional: test device passthrough on aarch64
Date: Tue,  1 Jul 2025 18:07:19 +0100
Message-ID: <20250701170720.4072660-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This test allows to document and exercise device passthrough, using a
nested virtual machine setup. Two disks are generated and passed to the
VM, and their content is compared to original images.

Guest and nested guests commands are executed through two scripts, and
init used in both system is configured to trigger a kernel panic in case
any command fails. This is more reliable and readable than executing all
commands through prompt injection and trying to guess what failed.

Initially, this test was supposed to test smmuv3 nested emulation
(combining both stages of translation), but I could not find any setup
(kernel + vmm) able to do the passthrough correctly, despite several
tries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250627200222.5172-1-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/meson.build                  |   2 +
 .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100755 tests/functional/test_aarch64_device_passthrough.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a27..85158562a2f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'aarch64_aspeed_ast2700' : 600,
   'aarch64_aspeed_ast2700fc' : 600,
+  'aarch64_device_passthrough' : 720,
   'aarch64_imx8mp_evk' : 240,
   'aarch64_raspi4' : 480,
   'aarch64_reverse_debug' : 180,
@@ -83,6 +84,7 @@ tests_aarch64_system_quick = [
 tests_aarch64_system_thorough = [
   'aarch64_aspeed_ast2700',
   'aarch64_aspeed_ast2700fc',
+  'aarch64_device_passthrough',
   'aarch64_imx8mp_evk',
   'aarch64_raspi3',
   'aarch64_raspi4',
diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
new file mode 100755
index 00000000000..1f3f158a9ff
--- /dev/null
+++ b/tests/functional/test_aarch64_device_passthrough.py
@@ -0,0 +1,142 @@
+#!/usr/bin/env python3
+#
+# Boots a nested guest and compare content of a device (passthrough) to a
+# reference image. Both vfio group and iommufd passthrough methods are tested.
+#
+# Copyright (c) 2025 Linaro Ltd.
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from random import randbytes
+
+guest_script = '''
+#!/usr/bin/env bash
+
+set -euo pipefail
+set -x
+
+# find disks from nvme serial
+dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
+dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
+pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
+pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
+
+# bind disks to vfio
+for p in "$pci_vfio" "$pci_iommufd"; do
+    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
+        continue
+    fi
+    echo $p > /sys/bus/pci/drivers/nvme/unbind
+    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
+    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
+done
+
+# boot nested guest and execute /host/nested_guest.sh
+# one disk is passed through vfio group, the other, through iommufd
+qemu-system-aarch64 \
+-M virt \
+-display none \
+-serial stdio \
+-cpu host \
+-enable-kvm \
+-m 1G \
+-kernel /host/Image.gz \
+-drive format=raw,file=/host/guest.ext4,if=virtio \
+-append "root=/dev/vda init=/init -- bash /host/nested_guest.sh" \
+-virtfs local,path=/host,mount_tag=host,security_model=mapped,readonly=off \
+-device vfio-pci,host=$pci_vfio \
+-object iommufd,id=iommufd0 \
+-device vfio-pci,host=$pci_iommufd,iommufd=iommufd0
+'''
+
+nested_guest_script = '''
+#!/usr/bin/env bash
+
+set -euo pipefail
+set -x
+
+image_vfio=/host/disk_vfio
+image_iommufd=/host/disk_iommufd
+
+dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
+dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
+
+# compare if devices are identical to original images
+diff $image_vfio /dev/$dev_vfio
+diff $image_iommufd /dev/$dev_iommufd
+
+echo device_passthrough_test_ok
+'''
+
+class Aarch64DevicePassthrough(QemuSystemTest):
+
+    # https://github.com/pbo-linaro/qemu-linux-stack
+    #
+    # Linux kernel is compiled with defconfig +
+    # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
+    # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
+    ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
+        ('https://fileserver.linaro.org/s/fx5DXxBYme8dw2G/'
+         'download/device_passthrough.tar.xz'),
+         '812750b664d61c2986f2b149939ae28cafbd60d53e9c7e4b16e97143845e196d')
+
+    # This tests the device passthrough implementation, by booting a VM
+    # supporting it with two nvme disks attached, and launching a nested VM
+    # reading their content.
+    def test_aarch64_device_passthrough(self):
+        self.set_machine('virt')
+        self.require_accelerator('tcg')
+
+        self.vm.set_console()
+
+        stack_path_tar_gz = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
+        self.archive_extract(stack_path_tar_gz, format="tar")
+
+        stack = self.scratch_file('out')
+        kernel = os.path.join(stack, 'Image.gz')
+        rootfs_host = os.path.join(stack, 'host.ext4')
+        disk_vfio = os.path.join(stack, 'disk_vfio')
+        disk_iommufd = os.path.join(stack, 'disk_iommufd')
+        guest_cmd = os.path.join(stack, 'guest.sh')
+        nested_guest_cmd = os.path.join(stack, 'nested_guest.sh')
+        # we generate two random disks
+        with open(disk_vfio, "wb") as d: d.write(randbytes(512))
+        with open(disk_iommufd, "wb") as d: d.write(randbytes(1024))
+        with open(guest_cmd, 'w') as s: s.write(guest_script)
+        with open(nested_guest_cmd, 'w') as s: s.write(nested_guest_script)
+
+        self.vm.add_args('-cpu', 'max')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'virt,'
+                         'virtualization=on,'
+                         'gic-version=max,'
+                         'iommu=smmuv3')
+        self.vm.add_args('-kernel', kernel)
+        self.vm.add_args('-drive', f'format=raw,file={rootfs_host}')
+        self.vm.add_args('-drive',
+                         f'file={disk_vfio},if=none,id=vfio,format=raw')
+        self.vm.add_args('-device', 'nvme,serial=vfio,drive=vfio')
+        self.vm.add_args('-drive',
+                         f'file={disk_iommufd},if=none,id=iommufd,format=raw')
+        self.vm.add_args('-device', 'nvme,serial=iommufd,drive=iommufd')
+        self.vm.add_args('-virtfs',
+                         f'local,path={stack}/,mount_tag=host,'
+                         'security_model=mapped,readonly=off')
+        # boot and execute guest script
+        # init will trigger a kernel panic if script fails
+        self.vm.add_args('-append',
+                         'root=/dev/vda init=/init -- bash /host/guest.sh')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'device_passthrough_test_ok',
+                                 failure_message='Kernel panic')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


