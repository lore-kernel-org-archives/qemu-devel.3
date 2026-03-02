Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C981FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyym-0004JB-RU; Mon, 02 Mar 2026 03:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywo-00036V-H5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywm-0002CP-08
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZ/qzo7xeOri3mZOuD9YPGbqnowbEx4ah84LBZxa7wY=;
 b=E8P2i0clsfA2QwbMR2LNx0Gh14JmuCIbnwYot0geieBD9yjFk4Hho30omFN/+XJf8Ig/rf
 X9M87dURj1+J0rz4SrQYgwuglywBVreQdS5rbh75PdNjHaMdEDYWU7kA+W2goRJsTP/JDD
 rTRcNBzeLCiWc83an/pFnRaUStSztU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-DVhHb5VvM4yRqksDvYRj6g-1; Mon, 02 Mar 2026 03:48:10 -0500
X-MC-Unique: DVhHb5VvM4yRqksDvYRj6g-1
X-Mimecast-MFC-AGG-ID: DVhHb5VvM4yRqksDvYRj6g_1772441289
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48378c4a79fso35185615e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441288; x=1773046088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ/qzo7xeOri3mZOuD9YPGbqnowbEx4ah84LBZxa7wY=;
 b=RdkMO88uFIoLy8Sbv/ksWNbsYTq0/hwiEV/56L5pbB3Do9kgusbX0LP3DRYWJPtJz3
 Mayds7qE6wTjTfQ/eHAmbARFOC9Wme8TXt0a4celfLI570N1W341G4mHVNR/VtI5Wrfr
 EKKd3Nzc50ryFWljzy5FFTc1GJRvEfH+9NjsA34wQUKcNRTIHMHHMClrv5w7Hy0Hr5vJ
 wvV0qtprCpbgSV3aDQeg+zzODW4R9CzGTZrEeXgzu/N+3E3i36Q5dyoPMIFUYt9XkNmW
 wUjUQd76VnW3lRYeruI3ygpGWoug0qETFWdQgoWgf9LP0oRxY7TXC2j4pTdF2dtr9/jH
 f44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441288; x=1773046088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZ/qzo7xeOri3mZOuD9YPGbqnowbEx4ah84LBZxa7wY=;
 b=P9CE7viBOEfOG02IYBna31aedW38+gcPmPlKjbRXUnCMepN2IMXy3lNmuL1v5DpXO/
 VEDJXwKCRzaSvDt8ei8ugQIiX0UzVFID01WDnOkVd0AvgAOPmJJ/PKAvBqMtxm5NZMMr
 O4eK9BvIU5c1e6n2gx9EV/LnbJWLrbf+fai/1V+HHO2cVWVfOQMBcAx2xqjUvQnT7yt8
 H6LmKV1ynPlNlfALRWxdC5ONOFIPAqvhOoL1tl3TTeQ0ZeVueibwsIMV7yl+4SSCXSfm
 fsGWBkwcfpcx74ZI+Bb3PJVEND5e+ngqQ62M7NVxDQns/6gZhlJM/L8am+bFQjOZgSWj
 w7PA==
X-Gm-Message-State: AOJu0Yw3Pq/n3Cgiq6W8hpIwF8Ckmk4myhae2jHYVfCOOmd5hMRpDa+9
 yeGsdD2fYoLWU0TBZ4+taVWTfGzcJRRyWJclgwvKxxGLL+JDpkuPgb53mOf6UPMWKRBj1otBpSs
 NjLFF0GxoXMGNVATb5HA1l8SWZovZRFaZupjGqrzczfwaEyI1Djn2jGgyEB8GQ7MwXk2P5rgcUe
 WD77Xm+vY6XAvLUoD9dLzSaveFJ99EAwZ1KlWcpaYp
X-Gm-Gg: ATEYQzwSrvq/17VqoE/dkKM/junHBUa1mdOYvGY8GvpF4+MIaiWDehPIb9QJWVauwtq
 xl6MXr8JTHD+6TLbraQbOYFouiRVguf4I6IuSz8CSbSFuZ3jtFVjIcIDqyOtqmoqq6OsEUUOkL1
 PA11QQwEuDezqRsnQ+PXKSKqJQWtU0Wgo8TPOjr5l5rBP9kT0D/2JI8Jq0TF5Jk4wGMDr4tztMV
 O1UMe1LbKol6YKP+2mgfwUDNroX9OgVbdK26eBPupTMpwYPZ8/qtjuyDQIb5qdKcBIrzaPClq7A
 cThpR59vEfwBuJqz6dHy0/q+HzC7rapcUJ9vPCdwIsbsFHokIWaq0L3VP4kCW8Jg6S5mCRcjZ9g
 gKM4T11AKC2fbXqRwgOEsyYRwpQG3hkyD4zH9etjecNiXZZRsvGeLfN5cfQ2QdzF0TYe2vgLWbl
 7X/3SbYA7aiwJ5KYUHJw3vRHikubk=
X-Received: by 2002:a05:600c:6309:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-483c9bc6164mr201626175e9.29.1772441288183; 
 Mon, 02 Mar 2026 00:48:08 -0800 (PST)
X-Received: by 2002:a05:600c:6309:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-483c9bc6164mr201625465e9.29.1772441287481; 
 Mon, 02 Mar 2026 00:48:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm391240335e9.10.2026.03.02.00.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 074/102] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Mon,  2 Mar 2026 09:47:20 +0100
Message-ID: <20260302084749.474955-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

A new functional test is added that exercises the code changes related to
closing of the old KVM VM file descriptor and opening a new one upon VM reset.
This normally happens when confidential guests are reset but for
non-confidential guests, we use a special machine specific debug/test parameter
'x-change-vmfd-on-reset' to enable this behavior.
Only specific code changes related to re-initialisation of SEV-ES, SEV-SNP and
TDX platforms are not exercised in this test as they require hardware that
supports running confidential guests.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-34-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                  |   1 +
 tests/functional/x86_64/meson.build          |   1 +
 tests/functional/x86_64/test_rebuild_vmfd.py | 136 +++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100755 tests/functional/x86_64/test_rebuild_vmfd.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a8e1546de1e..83c05112a33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ M: Ani Sinha <anisinha@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: stubs/kvm.c
+F: tests/functional/x86_64/test_rebuild_vmfd.py
 
 Guest CPU cores (TCG)
 ---------------------
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index beab4f304ba..05e4914c772 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -37,4 +37,5 @@ tests_x86_64_system_thorough = [
   'vhost_user_bridge',
   'virtio_balloon',
   'virtio_gpu',
+  'rebuild_vmfd',
 ]
diff --git a/tests/functional/x86_64/test_rebuild_vmfd.py b/tests/functional/x86_64/test_rebuild_vmfd.py
new file mode 100755
index 00000000000..5a8e5fd89b4
--- /dev/null
+++ b/tests/functional/x86_64/test_rebuild_vmfd.py
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+#
+# Functional tests exercising guest KVM file descriptor change on reset.
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
+    # ASSET_OVMF comes from /usr/share/edk2/ovmf/OVMF.stateless.fd of a
+    # fedora core 43 distribution which in turn comes from the
+    # edk2-ovmf-20251119-3.fc43.noarch rpm of that distribution.
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
+                         r'virtual machine state has been rebuilt')
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
2.53.0


