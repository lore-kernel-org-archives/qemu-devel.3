Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0744D3B7E1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 07:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFT4k-0007CP-CT; Mon, 25 Nov 2024 02:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFT4h-0007B7-Gi
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:59:59 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFT4f-0006L3-Od
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:59:59 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7250c199602so571905b3a.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 22:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732517995; x=1733122795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bn7NxH5CTNFEKOKyiJSwD1xFNrPz8+UgiToRUfTH7Yo=;
 b=IDHYsFWurliSUV9uBi3uYKOF/rMcQqABxK6qAJko7VHCTQ8SNCG4abxlT+8ZKRM86C
 9iH6vv4j1MuWRrFokOx4GdGIXepN071Zn/f+atz404B61lwQZyq4E6OORoDNMLkm4899
 ORfciBXPRVSiU+T5j+AaQnI0GpUdtNSKIxCOARWyw7IjXo1YDxI1/+rglwPYsZyDjJ6K
 E4MTnaSHT3CY2trBCboTlsl9Sj0SpvhETfHdVWa+lxhPdDRfaMdhayn5tFGw5jtMgOmr
 dcuWP0c0hVOV7T+12Hdh2EEjt2Ro0nDQnIibdAs7dXdoqJIzYtiXoib1o0rnfpovXSlm
 Cocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732517995; x=1733122795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bn7NxH5CTNFEKOKyiJSwD1xFNrPz8+UgiToRUfTH7Yo=;
 b=W07Pm6aBRoIkmSEPjQizsPtZRGlL8NQ7Aqz0k49ky7YJKXfFt7rbcqwEw3L8zN6siG
 8IBnuqdgNcfmDpkodPjrN4VNqsC80j6rmag3zN835i35PHNNjrH0mGwFER0PTuzo45Cs
 0Cr0AqPV7KtHTTmjlzb5lnFsPAqtTBRbA/Vx4rFBYIdOS2cQm5uQjMWcn7PYupK/xpEK
 ZSOPKZmQilTCMT8RT9xNGkPStkO9kusYY19Vy6S66oeYGys3oaqNCNMEWgunjVluv5df
 qWQwKSSPhArlys6szbc3junF90yLzXR/hbP0HAjem8Tl38twb22wY+0Q35gxXpxYiwkR
 Bm+A==
X-Gm-Message-State: AOJu0YzPalDaK/wlIYEic4wCVTaecuggMZNg8jENhM4lIP8n68ZR0fLw
 qdFSXIXIfIhgUfZh5Md6v2C6UPv5t8nFtjeixXvXFg44uroUryFYvZdKlIqmSlBAGMT8/vBkNp7
 qho4=
X-Gm-Gg: ASbGncsOLLZAC7PjBByYG2S85zPQnwd6cu9awGc1s+TqbKuwv+cX20Q4qwyLwc4gfGJ
 elHdfrEBGiiUNGlR0/zi5Tl3abwWEdfe9opTCryp9MF5vAekmWo06ZfvMBKAAAH6sm/3nfIdol6
 7yVBzpTBPVCd0SIsN7H2R4ae7LsMNAHwmg63jCg3cEO87TtQDyTKe5Y42YMgfVbxkT6Hv3KkWC2
 wpApLf7WWQOoLluiNaOgA/hpJAhpQaX0YG7kSRiSVyxREIwDOfiKBu1MwZsYCYAxxgxsaxsYLd4
 Fl2OcvmojQ7SnA==
X-Google-Smtp-Source: AGHT+IF0TS2PAUId3MwBi1Bm2sxNWzHRCH4G4icKj4IY/3Rb0bGno90jHLOsM92e4UABeYAjY7LBlg==
X-Received: by 2002:a05:6a00:1d91:b0:724:f10b:e663 with SMTP id
 d2e1a72fcca58-724f10bfd03mr9903358b3a.0.1732517995217; 
 Sun, 24 Nov 2024 22:59:55 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de454b5asm5866634b3a.27.2024.11.24.22.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 22:59:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: mathieu.poirier@linaro.org, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, jean-philippe@linaro.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/functional/aarch64_virt: add test for FEAT_RME
Date: Sun, 24 Nov 2024 22:59:50 -0800
Message-Id: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
using the Realms feature.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_virt.py | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 30bab5a677c..3e8f9372132 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -18,6 +18,7 @@
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
 from qemu_test import get_qemu_img, run_cmd
+from qemu_test.utils import archive_extract
 
 
 class Aarch64VirtMachine(QemuSystemTest):
@@ -129,6 +130,67 @@ def test_aarch64_virt_gicv2(self):
         return
         self.common_aarch64_virt("virt,gic-version=2")
 
+    # Stack is built with OP-TEE build environment from those instructions:
+    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # https://github.com/pbo-linaro/qemu-rme-stack
+    ASSET_RME_STACK = Asset(
+        ('https://fileserver.linaro.org/s/JX7oNgfDeGXSxcY/'
+         'download/rme-stack-op-tee-4.2.0.tar.gz'),
+         '1f240f55e8a7a66489c2b7db5d40391e5dcfdd54c82600bd0d4b2145b9a0fbfb')
+
+    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
+    # and launching a nested VM using it.
+    def test_aarch64_virt_rme(self):
+        stack_path_tar_gz = self.ASSET_RME_STACK.fetch()
+        archive_extract(stack_path_tar_gz, self.workdir)
+
+        self.set_machine('virt')
+        self.vm.set_console()
+        self.require_accelerator('tcg')
+
+        rme_stack = os.path.join(self.workdir, 'rme-stack')
+        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
+        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
+        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
+
+        self.vm.add_args('-accel', 'tcg')
+        self.vm.add_args('-cpu', 'max,x-rme=on')
+        self.vm.add_args('-m', '2048')
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
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
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
+        # Detect Realm activation during boot.
+        self.wait_for_console_pattern('SMC_RMI_REALM_ACTIVATE')
+        # Wait for boot to complete.
+        self.wait_for_console_pattern('Welcome to Buildroot')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


