Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA2D25938
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbTh-00020T-5p; Tue, 27 Jan 2026 00:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbTP-0001W1-PO
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbTL-0000K1-CD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bB4+97qjGRq+qTWDV6RdEjp9dd6Nvg48/ohMnASGL1U=;
 b=VH+Ir6R/aacdc6rPOCaIB+Iwef2RcPgZK7owynw21HhuuxkTOeB4ZoulVtgGhUQDnyHdJw
 FcJIDcpJKYi97I1Fo2AeNkrDYbmz4T922PQcexsqp5dJSF2aO1bXFlV61vq35hRj481pCM
 PYrE3cZURo+3W2JXomQZBOrey5UO0+I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-XT4GWsYsMDm2zi4tv6N-Rw-1; Tue, 27 Jan 2026 00:18:25 -0500
X-MC-Unique: XT4GWsYsMDm2zi4tv6N-Rw-1
X-Mimecast-MFC-AGG-ID: XT4GWsYsMDm2zi4tv6N-Rw_1769491095
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-352c7924ebcso4741990a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491094; x=1770095894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bB4+97qjGRq+qTWDV6RdEjp9dd6Nvg48/ohMnASGL1U=;
 b=pHjcr5f/QbT6CLwa4uSCLhWUdQOSnuM4vdiVwNnnrXMb5xjWvk41XGeZV1je3rMIIY
 M/KYGSV+yXfg+H0OwDgm6GleZ97UfFVUMFNXv5CLM3GRH71AIurVRKAwcycBt3q6xUQk
 2WaGnW5M6mBdxy7XchNRvCwcBNzeP7qUQ06MuV8BJG31CwVI2/RoFRD1Lt2lKHsS/WtF
 0RmlOycNZEXjcyJpsyY3KX1inEG0iOXSdoJ2j81dVwjECdobvjLg+o2nCbHFUujXdpww
 uzME0ImD9tkCp8WZxP0wHTAVMxSvzsZadV9QLwWpsl0Kv11g+SRiXG2jaUzX5lpX5mOb
 DbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491094; x=1770095894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bB4+97qjGRq+qTWDV6RdEjp9dd6Nvg48/ohMnASGL1U=;
 b=bn75wVRSL19d2IkANjufdu/F3c2cJ+YEm0RWnxS0TcPSG6ggTscGmewTzyDITnPBDA
 EnCcEGWdFGWqDEd1UGvPcI4BxPVwEqX5enu8Km6sVsJUs5dIqSDaF0cJarHRmaJz8Yl1
 1bXnCmtP5zw+vzQMSXAMoQocQ4umfGy9ogmZSOuzqu1JxFUi7pu6fWW1cs9HEcy6eQf+
 9W2P8oL8N1l/NTWZha5emAdu4E4T1tHi3zxfRneXFYYhXJTAMyICQZ7BdRPU4Bj4xrSv
 ty91w1X92ByGSCOqq1Nc0n/lycVr9XKqGLhhLfmZN9wzthtyiTyFhEqGoHvBAplgyogh
 3wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsYDQ/JIrHJPcX7xtTUgaYagudrzvLnHUpJ+gxoXRc6zT/jwkxQtqnufj1XXheV8K+BUEt+L/b99h+@nongnu.org
X-Gm-Message-State: AOJu0Yw4PjVMzvwnXrBGv1g5tvIdQBTBabPkrrQ/gW1TvlMaTSrIXhpf
 3IEN3dZS4Y6fwKxRYvrqhlyMDoOwI4HPBqfYARYx63KyTB4+L3zZEVRZcfiXzd5nNO1a3hVBkwa
 Ab5rEYL5Kcdg2MR8emIa12tQ96hoYaY7UnTr2OGnGYU25RWGe5cnPR3cbhtJxGfyU
X-Gm-Gg: AZuq6aJZHaQQenaYRvznXdICwTI/FIj+9/fEk26BCAVXHa0Mc7hkHPR2FfrSI9jjjLV
 4GDoc1EB/OJNCKr51xIbSkXEVv7XgcwZnGnBH7GpI4hvE1LXfTcVspq3sckKQ9u0NtEdNf+IV89
 /sH9qvAf2PlUZ5z17pAH3LdC8aFYcO1M3vz7FUvrKzMl5zl5R3ntSkHOzimE/vhrP+M4ewzh1Yh
 b50yLKVW+H74pTfeBh7i3oV8oOz570nnE54bmbUM2j3AjxTbxvRpKD2IVCkS6OMJlngSr8TESak
 KRO8jG0iGTFtJi60WvVgoq/vdEMAcX81RIuYyz6SdLnOSxmWaiVDCKa62OL//dv3kPaqg5/b2B2
 3B0RzSgijO3TJslF+DnAQs+BvRJ1Wnd8QSUyLWBFZ2g==
X-Received: by 2002:a17:90b:288a:b0:34c:75d1:6f90 with SMTP id
 98e67ed59e1d1-353fed6ebf4mr818776a91.17.1769491094325; 
 Mon, 26 Jan 2026 21:18:14 -0800 (PST)
X-Received: by 2002:a17:90b:288a:b0:34c:75d1:6f90 with SMTP id
 98e67ed59e1d1-353fed6ebf4mr818749a91.17.1769491093982; 
 Mon, 26 Jan 2026 21:18:13 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:18:13 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v3 33/33] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Tue, 27 Jan 2026 10:46:01 +0530
Message-ID: <20260127051612.219475-34-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A new functional test is added that exercises the code changes related to
closing of the old KVM VM file descriptor and opening a new one upon VM reset.
This normally happens when confidential guests are resetted but for
non-confidential guests, we use a special machine specific debug/test parameter
'x-change-vmfd-on-reset' to enable this behavior.
Only specific code changes related to re-initialization of SEV-ES, SEV-SNP and
TDX platforms are not exercized in this test as they require hardware that
supports running confidential guests.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                                   |  6 ++
 tests/functional/x86_64/meson.build           |  1 +
 .../x86_64/test_vmfd_change_reboot.py         | 96 +++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e586c58f..f3367d4251 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,6 +151,12 @@ F: tools/i386/
 F: tests/functional/i386/
 F: tests/functional/x86_64/
 
+X86 VM file descriptor change on reset test
+M: Ani Sinha <anisinha@redhat.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: tests/functional/x86_64/test_vmfd_change_reboot.py
+
 Guest CPU cores (TCG)
 ---------------------
 Overall TCG CPUs
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6c..784d9791cb 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -36,4 +36,5 @@ tests_x86_64_system_thorough = [
   'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
+  'vmfd_change_reboot',
 ]
diff --git a/tests/functional/x86_64/test_vmfd_change_reboot.py b/tests/functional/x86_64/test_vmfd_change_reboot.py
new file mode 100755
index 0000000000..b9e099aae1
--- /dev/null
+++ b/tests/functional/x86_64/test_vmfd_change_reboot.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+#
+# KVM VM file descriptor change on reset test
+#
+# Copyright © 2026 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from qemu.machine import machine
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+class KVMGuest(QemuSystemTest):
+
+    # ASSET UKI was generated using
+    # https://gitlab.com/kraxel/edk2-tests/-/blob/unittest/tools/make-supermin.sh
+    ASSET_UKI = Asset('https://gitlab.com/anisinha/misc-artifacts/'
+                      '-/raw/main/uki.x86-64.efi?ref_type=heads',
+                      'e0f806bd1fa24111312e1fe849d2ee69808d4343930a5'
+                      'dc8c1688da17c65f576')
+    # ASSET_OVMF comes from /usr/share/edk2/ovmf/OVMF.stateless.fd of a fc43
+    # distro which in turn comes from the edk2-ovmf-20251119-3.fc43.noarch rpm.
+    ASSET_OVMF = Asset('https://gitlab.com/anisinha/misc-artifacts/'
+                       '-/raw/main/OVMF.stateless.fd?ref_type=heads',
+                       '58a4275aafa8774bd6b1540adceae4ea434b8db75b476'
+                       '11839ff47be88cfcf22')
+
+    def common_vm_setup(self, kvm_args=None, cpu_args=None):
+        self.require_accelerator("kvm")
+
+        self.vm.set_console()
+        if kvm_args:
+            self.vm.add_args("-accel", "kvm,%s" %kvm_args)
+        else:
+            self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-smp", "2")
+        if cpu_args:
+            self.vm.add_args("-cpu", "host,%s" %cpu_args)
+        else:
+            self.vm.add_args("-cpu", "host")
+        self.vm.add_args("-m", "2G")
+        self.vm.add_args("-nographic", "-nodefaults")
+
+        self.uki_path = self.ASSET_UKI.fetch()
+        self.ovmf_path = self.ASSET_OVMF.fetch()
+
+    def run_and_check(self):
+        self.vm.add_args('-kernel', self.uki_path)
+        self.vm.add_args("-bios", self.ovmf_path)
+        # enable KVM VMFD change on reset for a non-coco VM
+        self.vm.add_args("-machine", "q35,x-change-vmfd-on-reset=on")
+        # enable tracing
+        self.vm.add_args("-d", "trace:kvm_reset_vmfd")
+
+        try:
+            self.vm.launch()
+        except machine.VMLaunchFailure as e:
+            if "Xen HVM guest support not present" in e.output:
+                self.skipTest("KVM Xen support is not present "
+                              "(need v5.12+ kernel with CONFIG_KVM_XEN)")
+            elif "Property 'kvm-accel.xen-version' not found" in e.output:
+                self.skipTest("QEMU not built with CONFIG_XEN_EMU support")
+            else:
+                raise e
+
+        self.log.info('VM launched')
+        console_pattern = 'bash-5.1#'
+        wait_for_console_pattern(self, console_pattern)
+        self.log.info('VM ready with a bash prompt')
+
+        exec_command_and_wait_for_pattern(self, '/usr/sbin/reboot -f',
+                                          'reboot: machine restart')
+        console_pattern = '# --- Hello world ---'
+        wait_for_console_pattern(self, console_pattern)
+        self.vm.shutdown()
+        self.assertRegex(self.vm.get_log(),
+                         r'kvm_reset_vmfd')
+        self.assertRegex(self.vm.get_log(),
+                         r'virtual machine accel file descriptor has changed')
+
+    def test_vmfd_change_on_reset(self):
+        self.common_vm_setup()
+        self.run_and_check()
+
+    def test_xen_emulation(self):
+        self.common_vm_setup("xen-version=0x4000a,kernel-irqchip=split")
+        self.run_and_check()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.42.0


