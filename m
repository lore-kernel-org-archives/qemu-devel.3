Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C0FEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQBQ-0002MF-O2; Thu, 12 Feb 2026 01:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAm-0000k4-Cr
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAk-0005Pf-78
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIIvsU/cmXTMQHhWbp8xpt7mJK+6PPrS2lODajVDTYo=;
 b=dlMCEED0C2JEE/YuHHetFcBo+BBpKSmaynLCtHeheNzK7ytYgaxYC2ysqL2lHPYB4Fw9i8
 FN7n2epLrlaMrG4hud2we05Pa+XLN5gJyCDPgXeAFgqDKnLNNs/XLZI3scB0rkMR6pT3e+
 /GBc6T5/ArUO/bEIbP5esvjEsPthixM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-G_52xn_KNfm_88sz88IbPA-1; Thu, 12 Feb 2026 01:27:27 -0500
X-MC-Unique: G_52xn_KNfm_88sz88IbPA-1
X-Mimecast-MFC-AGG-ID: G_52xn_KNfm_88sz88IbPA_1770877647
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso4212252a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877646; x=1771482446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIIvsU/cmXTMQHhWbp8xpt7mJK+6PPrS2lODajVDTYo=;
 b=gVattix4+214o0Om/yDJNWbs/HaWnMsrs69adjQ/Sv9ncz8t2kb7tSBPzwmitoLaLP
 OcKICmR2SBaGt+KjJfh8WxjzwqIhvGiwZ6/BkNefXmzU0tZclpvsDhYIttEVAqbfocBY
 X6Fe9ASFL0FoxOYsZZ9Vbv3UNAWOOzgM8BMDbQoowbYJAjj1xdbW9aK3JFT7PtYV/7dK
 MBELx/Pletu/qBFd47Z5y0fbo+8kH0b72pwFf16mLGUKG2mOYTf8ayGPl7qDDJNLsdp8
 QNcieLUsjOJE4xAqBs4Ir4ZmvIpQwBiKLIlOQZUTMQj0P+W9p7afS2BEjhEmq97wEJQQ
 yguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877646; x=1771482446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIIvsU/cmXTMQHhWbp8xpt7mJK+6PPrS2lODajVDTYo=;
 b=VYt8q2lalTNzr2ifn+ZH7vcHc1Wv4qvNEcQc19mlxe/s3XoFCD2fkTaKX8+Ao4wMPY
 TsKi9zG+xvTMd/gE/zPPI/jHX5K8czbYFUlakFLi9E90Vm6/sM7vRqfSucDPZBjQaZnJ
 Baj7lsF0KsNAfblVHoZVmYMC+6RsIeKUT29PSp6jNU9ZrPHnaYp+61UBooxNxr0bGRgm
 b8dMvo7WMcuO+6hjiLRoz9Bqv3dBBMftYsvnWhxDjTOTWkEcZRuEbQL6DTDl0iowGtR8
 hROOr0+WUkjMYPSjUBcaWRme8LgV7IHOisimHpzi1lL/7ts2rnwTYNqaOpBEkoKxq2lS
 rtfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl9hDxsx4tdabkyRSPZ3Gtn61co2u+l2+ChkX+qfb5miXJnJacgJ77gg83SflDUhq+xmPswRn3zWIy@nongnu.org
X-Gm-Message-State: AOJu0YyLZ/T5tz4b3gXQSD0Mw/ETwpoMH+3dzsDdDlqjXSzGlf7+lT5S
 CT1ktYqLvoW00Jk8QKiEUSk1oH8vn9t2fzRARvmfHbZzeLZC+ktxQ+mzbu6Wf1C8YzTNlEhng3I
 qoG1Fa8ivD2QsR1B/LwbAbrXWEmhOJPS3S/PnWvlazZaX7vI1D4xV6K1DGXCiZ2NL
X-Gm-Gg: AZuq6aI362K9F6OCAXMyZm7ENe7uf9g4c0QdrtP3IroeZuYyfxf/5xFrMb6wkytCuVl
 jFrpo9BJMAa08YFpwJ2fRMO1y8Kn8iOKiLOkGwKRldidVSyGuQLT95w2HVWjEe5YH0Q/pu+hMaf
 Dy2WuRUltf+qBIYNGTy8bZXTRuLP4dHStBCcVTwG8W63k+27CYnod6KxiJvKFobqsN1op5MC/oJ
 7Etiu1E4ye8XLkIFOJh1nc8k5qjPJ3U0dnSVKdlnJVn3SNXsojC+jYCyEMl9L0pBfzLpA3xvoEd
 N+nUF/iu1XzIoAFbzVbZsrUvxmOpH/i/IW5j+WRcRNExExDWqAxBH7Uh2lBIo349pl877b79cB4
 VEwqmUoOAqaAUQ+RLA6XOahGc3OrFCNi2C6ABrT/liSA7q6YHtSMNQY0=
X-Received: by 2002:a17:90b:388e:b0:34c:2db6:578f with SMTP id
 98e67ed59e1d1-3568f3edd72mr1657487a91.19.1770877646370; 
 Wed, 11 Feb 2026 22:27:26 -0800 (PST)
X-Received: by 2002:a17:90b:388e:b0:34c:2db6:578f with SMTP id
 98e67ed59e1d1-3568f3edd72mr1657473a91.19.1770877645948; 
 Wed, 11 Feb 2026 22:27:25 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 31/31] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Thu, 12 Feb 2026 11:55:15 +0530
Message-ID: <20260212062522.99565-32-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
This normally happens when confidential guests are reset but for
non-confidential guests, we use a special machine specific debug/test parameter
'x-change-vmfd-on-reset' to enable this behavior.
Only specific code changes related to re-initialisation of SEV-ES, SEV-SNP and
TDX platforms are not exercised in this test as they require hardware that
supports running confidential guests.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vmfd_change_reboot.py         | 135 ++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a88901a7d7..cd62cbd57a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ M: Ani Sinha <anisinha@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: stubs/kvm.c
+F: tests/functional/x86_64/test_vmfd_change_reboot.py
 
 Guest CPU cores (TCG)
 ---------------------
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
index 0000000000..cb7370e465
--- /dev/null
+++ b/tests/functional/x86_64/test_vmfd_change_reboot.py
@@ -0,0 +1,135 @@
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
+        self.set_machine('q35')
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
+
+        self.uki_path = self.ASSET_UKI.fetch()
+        self.ovmf_path = self.ASSET_OVMF.fetch()
+
+        self.vm.add_args('-kernel', self.uki_path)
+        self.vm.add_args("-bios", self.ovmf_path)
+        # enable KVM VMFD change on reset for a non-coco VM
+        self.vm.add_args("-machine", "q35,x-change-vmfd-on-reset=on")
+
+        # enable tracing of basic vmfd change function
+        self.vm.add_args("--trace", "kvm_reset_vmfd")
+
+    def launch_vm(self):
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
+    def vm_console_reset(self):
+        exec_command_and_wait_for_pattern(self, '/usr/sbin/reboot -f',
+                                          'reboot: machine restart')
+        console_pattern = '# --- Hello world ---'
+        wait_for_console_pattern(self, console_pattern)
+        self.vm.shutdown()
+
+    def vm_qmp_reset(self):
+        self.vm.qmp('system_reset')
+        console_pattern = '# --- Hello world ---'
+        wait_for_console_pattern(self, console_pattern)
+        self.vm.shutdown()
+
+    def check_logs(self):
+        self.assertRegex(self.vm.get_log(),
+                         r'kvm_reset_vmfd')
+        self.assertRegex(self.vm.get_log(),
+                         r'virtual machine accel file descriptor has changed')
+
+    def test_reset_console(self):
+        self.common_vm_setup()
+        self.launch_vm()
+        self.vm_console_reset()
+        self.check_logs()
+
+    def test_reset_qmp(self):
+        self.common_vm_setup()
+        self.launch_vm()
+        self.vm_qmp_reset()
+        self.check_logs()
+
+    def test_reset_kvmpit(self):
+        self.common_vm_setup()
+        self.vm.add_args("--trace", "kvmpit_post_vmfd_change")
+        self.launch_vm()
+        self.vm_console_reset()
+        self.assertRegex(self.vm.get_log(),
+                         r'kvmpit_post_vmfd_change')
+
+    def test_reset_xen_emulation(self):
+        self.common_vm_setup("xen-version=0x4000a,kernel-irqchip=split")
+        self.launch_vm()
+        self.vm_console_reset()
+        self.check_logs()
+
+    def test_reset_hyperv_vmbus(self):
+        self.common_vm_setup(None, "hv-syndbg,hv-relaxed,hv_time,hv-synic,"
+                             "hv-vpindex,hv-runtime,hv-stimer")
+        self.vm.add_args("-device", "vmbus-bridge,irq=15")
+        self.vm.add_args("-trace", "vmbus_handle_vmfd_change")
+        self.launch_vm()
+        self.vm_console_reset()
+        self.assertRegex(self.vm.get_log(),
+                         r'vmbus_handle_vmfd_change')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.42.0


