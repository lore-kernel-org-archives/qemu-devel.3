Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AD5C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWRwA-0006JO-2x; Tue, 23 Jul 2024 22:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sWRw8-0006Im-Dh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:41:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sWRw5-0005so-2R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:41:04 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxqOmxaaBmv8kAAA--.1636S3;
 Wed, 24 Jul 2024 10:40:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxqsawaaBmdqdWAA--.60896S2; 
 Wed, 24 Jul 2024 10:40:48 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH] roms: Support compile the efi bios for loongarch
Date: Wed, 24 Jul 2024 10:22:45 +0800
Message-Id: <20240724022245.1317884-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqsawaaBmdqdWAA--.60896S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Added loongarch UEFI BIOS support to compiled scripts.

  UEFI code images require 16M alignment, flash images require
16M alignment, under the loongarch architecture.This is agreed
upon when the firmware is loaded in QEMU under Loongarch.

  The naming of UEFI under loongarch refers to the x86 and arm naming methods,
and the UEFI image names in x86 and arm are:
edk2-i386-code.fd
edk2-i386-vars.fd
edk2-arm-code.fd
edk2-arm-vars.fd
So on loongarch, we named it:
edk2-loongarch64-code.fd
edk2-loongarch64-vars.fd

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> 
Cc: "Daniel P. Berrangé" <berrange@redhat.com> 
Cc: Thomas Huth <thuth@redhat.com> 
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> 
Cc: Gerd Hoffmann <kraxel@redhat.com> 
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>

Hello, everyone:
  Earlier I submitted a patch that provides support for loongarch efi
compilation in qemu.
  However, the loongarch virtual machine UEFI code was in the edk2-platform
repository at the time, and community members did not integrate it because
it would cause the qemu distribution package to be too large.
  But now, the UEFI code of loongarch virtual machine has been migrated
from edK2-platform to edk2 repository. The migration work was completed
and merged into edk2 main line on 2024/6/18.
  The edk2-stable202408 release will come with support for loongarch,So
I modified my previous patch and submitted it.
  Before committing, I successfully compiled(Here I switch the edk2 repository
to the master branch in order to compile and test) the loongarch UEFI firmware
on a fedora39(x86) machine using the compile script in the roms directory in qemu,
and I was able to successfully run it in tcg mode in qemu using
the following command:

qemu-system-loongarch64 -bios edk2-loongarch64-code.fd -serial stdio

Thanks,
Xianglai.
---
 docs/system/loongarch/virt.rst               |  2 +-
 meson.build                                  |  2 +-
 pc-bios/descriptors/60-edk2-loongarch64.json | 32 ++++++++++++++++++++
 pc-bios/descriptors/meson.build              |  3 +-
 pc-bios/meson.build                          |  2 ++
 roms/edk2-build.config                       | 13 ++++++++
 6 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 pc-bios/descriptors/60-edk2-loongarch64.json

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index 06d034b8ef..172fba079e 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -64,7 +64,7 @@ Note: You need get the latest cross-tools at https://github.com/loongson/build-t
 
 (3) Build BIOS:
 
-    See: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
+    See: https://github.com/tianocore/edk2/tree/master/OvmfPkg/LoongArchVirt#readme
 
 Note: To build the release version of the bios,  set --buildtarget=RELEASE,
       the bios file path:  Build/LoongArchQemu/RELEASE_GCC5/FV/QEMU_EFI.fd
diff --git a/meson.build b/meson.build
index 23f35193ee..b9bdd479c8 100644
--- a/meson.build
+++ b/meson.build
@@ -93,7 +93,7 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
diff --git a/pc-bios/descriptors/60-edk2-loongarch64.json b/pc-bios/descriptors/60-edk2-loongarch64.json
new file mode 100644
index 0000000000..52915f729f
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-loongarch64.json
@@ -0,0 +1,32 @@
+{
+    "description": "UEFI firmware for loongarch64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-loongarch64-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-loongarch64-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "loongarch64",
+            "machines": [
+                "virt*"
+            ]
+        }
+    ],
+    "features": [
+
+    ],
+    "tags": [
+
+    ]
+}
+
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index 66f85d01c4..afb5a959cc 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -5,7 +5,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-aarch64.json',
     '60-edk2-arm.json',
     '60-edk2-i386.json',
-    '60-edk2-x86_64.json'
+    '60-edk2-x86_64.json',
+    '60-edk2-loongarch64.json'
   ]
     configure_file(input: files(f),
                    output: f,
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 8602b45b9b..090379763e 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -11,6 +11,8 @@ if unpack_edk2_blobs
     'edk2-i386-vars.fd',
     'edk2-x86_64-code.fd',
     'edk2-x86_64-secure-code.fd',
+    'edk2-loongarch64-code.fd',
+    'edk2-loongarch64-vars.fd',
   ]
 
   foreach f : fds
diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index cc9b211542..9e45361fb4 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -131,3 +131,16 @@ cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv-code.fd
 cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv-vars.fd
 pad1 = edk2-riscv-code.fd     32m
 pad2 = edk2-riscv-vars.fd     32m
+
+####################################################################################
+# LoongArch64
+
+[build.loongarch64.qemu]
+conf = OvmfPkg/LoongArchVirt/LoongArchVirtQemu.dsc
+arch = LOONGARCH64
+plat = LoongArchVirtQemu
+dest = ../pc-bios
+cpy1 = FV/QEMU_EFI.fd  edk2-loongarch64-code.fd
+pad1 = edk2-loongarch64-code.fd     16m
+cpy2 = FV/QEMU_VARS.fd  edk2-loongarch64-vars.fd
+pad2 = edk2-loongarch64-vars.fd     16m
-- 
2.39.1


