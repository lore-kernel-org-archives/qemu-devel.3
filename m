Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549BBF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wW-00042j-I0; Tue, 24 Feb 2026 22:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wU-00041Q-Ud
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wS-0008Fc-Of
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbN3m6M7RUDrJAB1L6YlzIQTT4gnNDddD4b5Cw4HL4U=;
 b=DIYbOpeAN956R6GNkBki74E31orP5v51PzS/AbBLVXMeFkYI9fmF2LHe5J6nJNDDOhTnc3
 0iumdjWBQGZj5TeMFAjOsIu2n6CV4bWENEhOlCRKnY+ge0iphfcAJ3QP+cF8G0x1hcwyKV
 jATqpcME8lQe9xoa3uH5gNM2i2JvGYA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-9z03JCbaOneEpV2v4ZlNkw-1; Tue, 24 Feb 2026 22:52:02 -0500
X-MC-Unique: 9z03JCbaOneEpV2v4ZlNkw-1
X-Mimecast-MFC-AGG-ID: 9z03JCbaOneEpV2v4ZlNkw_1771991521
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3562692068aso364052a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991521; x=1772596321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbN3m6M7RUDrJAB1L6YlzIQTT4gnNDddD4b5Cw4HL4U=;
 b=nB5wvSAbI/XicMYeQXwC8e7VI181srlFjV0LgYEJEVFHRy3C8ZQlMNdQSz9d5p4uh/
 JPyq/6fyarzyEdD1TYpWDp32cWbLNBVRnJ7D3Wph1eBg0B0tlBCN8xReYTBzQNWYsbGU
 PhFYYgTgr4GdIJT2yDJrn28Kxh32m+0SreoiEyeluv1093yfqhBF0eMPvrUUqIfOBrJ+
 6zXP+/61NXoECee9ftXz26kFfDEag2rZFlKf3j9D/C+1aFV7fPaDQLvVlGatlLkTqzwi
 qd/DJ37DtGYoVvdazJCf4JPD8ONGyeocBOxwnh6idoCW0jQF2QdTTlTtWIHzoNe3rTbN
 g5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991521; x=1772596321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MbN3m6M7RUDrJAB1L6YlzIQTT4gnNDddD4b5Cw4HL4U=;
 b=MrMsbiJUfMBOyuBPApco3BBDW9NSN0txCS3xdxEiAZSW9UqxND23TqnLL6fGzrbSOn
 nsKLvAIqCDdm+pllUtQg3NpfmSTgPXVi7WkNxz1bEzPO07Oy1+G3drWeJksS0k5jNxQ/
 R/HOGaO0567YHG/O/l9vpwLZ82lznTy+R/22miHYQZ3m9cHMKII8pEycu+AG8VTTX6gP
 +SqbFMtdhau8nCkkd0m4FUvhnsDU8jdc9P/aj9l0Fwp2s1IKd9SFdZbbo8GV6yjqnrGk
 B1cdWAbHl//vRoHQw5W7y88mMha68MP2Gq433RkaCu85xs5skwGgM5fZ5WZanoCCtS3/
 bfdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ck4EbK1NcrtbZXJGtUzoGkLcyvCgg78K5o7S1AW5KzEM8ydkLzWV4D7fCS8wz910mqZknHF6IcmG@nongnu.org
X-Gm-Message-State: AOJu0Yyn/30pKSxlx6saSy7JeVBzgufThnNCbc6rWvldOgzFA9a8pNRz
 nE4dlSackmsFwDJoj2Uruar+8vVT08uUDWveGVhb6+CZoEb/e/fE/6Bzhk7ZsQGFKri4f411kg9
 PxYv4xvrPcqpT2hFlrVLCUm3+c4ViItWWEOp836GSIsM9GavZWcorWHVO
X-Gm-Gg: ATEYQzyG0YBe83cjiWJzczg53x/F5g8PS/tXK8rTRozZDCOEHJxnJSVQRlwwlPP4wgE
 csCdD2Wpbf8eNAuKwCCdjl/Jpe3+kTn6F6qpp0QcvlHcxGRlgRrNiQxxCFIK4KHG8Rj9/24EuQT
 Ma7Ozgl7BkyvVO1wV8k1X8I6hvkur6ZE6jSEzqktN4RMgEO6kQTk44uR8i1ugLJ0xyOkQWGGnvV
 I9PPWgI0PtZtE02aAIRONWa1aQ2Sq4AznoaIAKwIx7UNlyzlm3xZJnczseFoFT6OFnMv3sf+RuH
 kVHFmQgbrlfzpbddRAtrTVk1OpZTn2EWlRk7S+QqagfIsY33si+0AdgiVshMKzSSWGCHas/At+l
 1395p+gYUYjZqIXf5bMYTldklN4ElA4/UklmEQyU6RaqGMARJosaftBA=
X-Received: by 2002:a17:90b:350b:b0:34a:c671:50df with SMTP id
 98e67ed59e1d1-359038723cfmr2002217a91.17.1771991520790; 
 Tue, 24 Feb 2026 19:52:00 -0800 (PST)
X-Received: by 2002:a17:90b:350b:b0:34a:c671:50df with SMTP id
 98e67ed59e1d1-359038723cfmr2002200a91.17.1771991520345; 
 Tue, 24 Feb 2026 19:52:00 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:52:00 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com,
	ani@anisinha.ca,
	qemu-devel@nongnu.org
Subject: [PATCH v6 33/35] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Wed, 25 Feb 2026 09:19:38 +0530
Message-ID: <20260225035000.385950-34-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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
index 6377ff5898..726aa35ff2 100644
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
index beab4f304b..05e4914c77 100644
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


