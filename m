Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7425E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzB-0005B6-K3; Wed, 18 Feb 2026 06:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfz0-0004Vx-Sl
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyo-0008VP-Qq
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQ9AmELqqNz5UNGo6YfAytDPC9vGP4ny5Z7LzeX7WVM=;
 b=RQ3IsEH7rQUHbbft5k8H/WeuPOFlvkPvqatQd2ufIidKsxLHba6W7WQg/kiTN4V0tSoqqo
 J7OEoqmuerHzaVYv00/2rj2Hsp09ksF3FWIwU69a7w5cN2T8q2K6F8lnOzL/GQdzrXTgnC
 fkIoGHSXMFEN20wK2zK+fgHK2ae7LrU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-2anBYWCsOoS4-79ME-kuFg-1; Wed, 18 Feb 2026 06:44:26 -0500
X-MC-Unique: 2anBYWCsOoS4-79ME-kuFg-1
X-Mimecast-MFC-AGG-ID: 2anBYWCsOoS4-79ME-kuFg_1771415065
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a8f8c81d02so49766605ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415065; x=1772019865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ9AmELqqNz5UNGo6YfAytDPC9vGP4ny5Z7LzeX7WVM=;
 b=Y+vmUcFost92ev5Z70YK/vtnFozxt1rOd/xuvqjOc8AfguBF6eCrj+kLjS051GxZc0
 cH+wM6SxgJc7gqrcBQEZq7LcXe9OmXXz6NSxaT/rZHwz+HI/73uB5QbObKPewIgp6nLC
 W1AXGT0JLCdydysxiAeCiC792M4SlO2i39163lcPolAJzBCNvE49bu5eyQewTSpjUM4k
 XuhaRsEmBSvv+qpH3m7W4QAB9D22rL6ngtRL9nZCnDc6esvek9CKUiinudPPw8fOuXZV
 V0p5mKvmw6vUFuMDbF4SkBPIWO9MuGtpoRSPVT22vSQxFC0IjwTjSI2calCnKPWC3I3O
 wZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415065; x=1772019865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQ9AmELqqNz5UNGo6YfAytDPC9vGP4ny5Z7LzeX7WVM=;
 b=opiVjo38JOefQUNICaREf0tGdU53Wb1uLb1xtseAFKxn04tDRtECktiul/EOnFvcFC
 2/zEjZF8/bgET18z6uYzgGbilw/ItXtpShMltiy5H0o3aIfmLC7zbUpGAjcowKXG2iMT
 ztp49OaiXNwaaRvySkMY0P1FyhtQuh/SIIh8Y9AXvIXBbQlN2iApOg6gIhGAi8Z8f7Ez
 oPhwcGFBhvrBdoLeg5vjpmC3lL8QydFj1ddLnvWX+Y6p63XRcKu5rwkr86L0ZBmkVo9z
 hEytkqVFrnWVsekdAS0j76rYy9PezCOHeuiNREY2mm+4A7kb84A3tZop9lkk006qq+Xb
 c6Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgTTR734d28mFbmm54KXB8SAVKW8B53Tv/dtsgdgvXUvQImANxiHDFno4T3VfTcqv9V2V5cgIsqvMQ@nongnu.org
X-Gm-Message-State: AOJu0YzMSQDCm48dNhFBKLprnI8oaDMINk1pH010NsvEjYoAZRpaw3FL
 w0qEJdeZMUW5MUjOz9UKS8UYhVJD1KVdC+d/WYxneAHXsZ42sEVDUXTjYk3KncXVwaNTVQOy248
 cqlTRjjDAKJqcjLY3YDLIb1SJvyXO3aCTukm8rgCtcPkxteaByxt/1FgX
X-Gm-Gg: AZuq6aJedm0uCLRDG50mKWTXR5ISupf14qzyhdUsajSBaLAlKhjlPJ2ApOc/QBXBqhX
 OukIkcSKOjhYE4lDnAgwOB/lTRG9oEsCjX5FY1dTXiNTapoVGU40z8NqNUl8hUJ4ERgLTpmcFVr
 jQa4LeSiKeUTdfvAW82VWP+SxPLgz0xcrSN23fq1WRA+UvBPom+hlpmgBFARCSAfLMhaZLQlQuW
 JvgGV/AOkvEq6nwoJHhyjC4yXSFtOBIOI866RZO4tEbU20jozK5lyC0d7bHXoGMsfwK5iA2G28j
 3ivYbo+rN+yz6pruKCyNWXbhtXGVNYmXNIQHY3dyxGftuEU7pMm2hN7ea4dSZoZl/+TjLcRJf26
 XmOOtqmATaHwQzR7wGL/xzX1XZzrsYaZ3G+uVwcZIogNKanjX3Mjz
X-Received: by 2002:a17:902:ea0a:b0:2a9:63de:b374 with SMTP id
 d9443c01a7336-2ab50521f0dmr150977565ad.3.1771415065371; 
 Wed, 18 Feb 2026 03:44:25 -0800 (PST)
X-Received: by 2002:a17:902:ea0a:b0:2a9:63de:b374 with SMTP id
 d9443c01a7336-2ab50521f0dmr150977465ad.3.1771415064954; 
 Wed, 18 Feb 2026 03:44:24 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v5 32/34] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Wed, 18 Feb 2026 17:12:25 +0530
Message-ID: <20260218114233.266178-33-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 MAINTAINERS                                  |   1 +
 tests/functional/x86_64/meson.build          |   1 +
 tests/functional/x86_64/test_rebuild_vmfd.py | 136 +++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100755 tests/functional/x86_64/test_rebuild_vmfd.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b0eb77c08f..de74d568e9 100644
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
index f78eec5e6c..c6553d922d 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -36,4 +36,5 @@ tests_x86_64_system_thorough = [
   'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
+  'rebuild_vmfd',
 ]
diff --git a/tests/functional/x86_64/test_rebuild_vmfd.py b/tests/functional/x86_64/test_rebuild_vmfd.py
new file mode 100755
index 0000000000..5a8e5fd89b
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
2.42.0


