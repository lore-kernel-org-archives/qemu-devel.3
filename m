Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B23F483D5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4irn-0002cw-Aj; Mon, 23 Mar 2026 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4irV-0002aN-Af
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4irT-0003It-9e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774286082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZKcLN44a5EAqDQUK5Jp0uNYlSQIpUPtUV/cyjAqIGFE=;
 b=eH8l5b4yxiDB8UxW+xOJnjDNlZP33PdJFke7V0G7kps/oHY8wbHMeoerUhDy85RpMvPWfq
 x8C+wleLrJla0U73IVVFkbn4DB6Qu+PQi5fNwG62+LnMpc80rOhTk5uhykb8zvPTfWEi0D
 GfKkhj49uxnItW3NDtxjARaHEs1d8fk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-sfNDIbcYMAii6tAZ7o1dgg-1; Mon,
 23 Mar 2026 13:14:39 -0400
X-MC-Unique: sfNDIbcYMAii6tAZ7o1dgg-1
X-Mimecast-MFC-AGG-ID: sfNDIbcYMAii6tAZ7o1dgg_1774286078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A06E19560B1; Mon, 23 Mar 2026 17:14:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B153300019F; Mon, 23 Mar 2026 17:14:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/s390x: Add test for booting from a disk with
 4k sectors
Date: Mon, 23 Mar 2026 18:14:23 +0100
Message-ID: <20260323171423.112205-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The DASD disks on s390x have a different sector size (4k) and use
a different layout of the boot loader data compared to the usual
"SCSI"-style disks with 512 sectors that are used with most modern
guests. To make sure that there are no regressions with 4k disk
booting, add a test case that uses a disk image with these 4k sectors
and check that we can successfully show the boot menu and and load the
right kernel in all supported cases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/s390x/meson.build     |   1 +
 tests/functional/s390x/test_boot_4k.py | 138 +++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100755 tests/functional/s390x/test_boot_4k.py

diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index 0f03e1c9db8..b065b666bc2 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -10,6 +10,7 @@ tests_s390x_system_quick = [
 ]
 
 tests_s390x_system_thorough = [
+  'boot_4k',
   'ccw_virtio',
   'pxelinux',
   'replay',
diff --git a/tests/functional/s390x/test_boot_4k.py b/tests/functional/s390x/test_boot_4k.py
new file mode 100755
index 00000000000..965123ebd31
--- /dev/null
+++ b/tests/functional/s390x/test_boot_4k.py
@@ -0,0 +1,138 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2026 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+'''
+Functional test that boots from a (incomplete) disk with 4k sectors
+(DASD/ECKD geometry) and multiple kernels installed, so we can check
+the boot menu and various LOADPARM options.
+'''
+
+from qemu_test import QemuSystemTest, Asset, skipFlakyTest
+from qemu_test import wait_for_console_pattern
+
+
+class S390Boot4k(QemuSystemTest):
+
+    # This disk image has been taken from a DASD with 4k sectors.
+    # Note: It's incomplete (to keep it small), it contains just enough
+    # data for booting the kernels that are installed on the disk image
+    ASSET_DISK = Asset(
+        ('https://github.com/huth/qemu-paddock/raw/refs/heads/main/s390x/'
+         'f32-4k-bootmenu.raw.xz'),
+        'f4e2c91b4ec50a4756e8816b7a7c8ca01cc0d929f7a711cfd8124640c304ea41')
+
+    def wait_for_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message, vm=vm,
+                                 failure_message='panic')
+
+    def basic_machine_setup(self):
+        self.set_machine('s390-ccw-virtio')
+        disk_path = self.uncompress(self.ASSET_DISK, format="xz")
+
+        self.vm.set_console()
+        self.vm.add_args("-nographic", "-no-shutdown", "-blockdev",
+                         f"driver=file,filename={disk_path},node-name=d1")
+
+    def test_default(self):
+        '''
+        Check that the default kernel boots up correctly from a ccw device
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-blk-ccw,drive=d1")
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
+        self.wait_for_pattern("Trying to unpack rootfs image as initramfs")
+
+    def test_loadparm_machine(self):
+        '''
+        Check that we can select a kernel via "-machine loadparm=..."
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-blk-ccw,drive=d1",
+                         "-machine", "loadparm=2")
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
+
+    def test_loadparm_device(self):
+        '''
+        Check that we can select a kernel via  "-device ...,loadparm=..."
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device",
+                         "virtio-blk-ccw,drive=d1,bootindex=1,loadparm=3")
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
+
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/work_items/3350")
+    def test_loadparm_pci(self):
+        '''
+        Check that we can select a kernel via  "-device ...-pci,loadparm=..."
+        '''
+        self.require_device('virtio-blk-pci')
+        self.basic_machine_setup()
+        self.vm.add_args("-device",
+                         "virtio-blk-pci,drive=d1,bootindex=1,loadparm=2")
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
+
+    def test_scsi_default(self):
+        '''
+        Check that we can boot via SCSI, too (need to set logical block size
+        here to avoid that the auto-detection in the bios fails)
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-scsi", "-device",
+            "scsi-hd,drive=d1,physical_block_size=4096,logical_block_size=4096")
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
+
+    def test_scsi_loadparm(self):
+        '''
+        Check that we can boot via SCSI with loadparm
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-scsi", "-device",
+                         ("scsi-hd,drive=d1,bootindex=1,loadparm=3,"
+                          "physical_block_size=4096,logical_block_size=4096"))
+        self.vm.launch()
+        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
+
+    def test_menu(self):
+        '''
+        Check that boot menu shows up correctly
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-blk-ccw,drive=d1,bootindex=1",
+                         "-boot", "menu=on")
+        self.vm.launch()
+        self.wait_for_pattern("1. Fedora (5.8.15-301.fc33.s390x) 33")
+        self.wait_for_pattern("2. Fedora (5.6.6-300.fc32.s390x) 32")
+        self.wait_for_pattern("3. Fedora (0-rescue-b7218f0092704c5a9")
+        self.wait_for_pattern("Please choose:")
+        # For some unknown reason, sending a key to the bios does not work
+        # in the testing framework yet:
+        # exec_command_and_wait_for_pattern(self, '2',
+        #                              "Linux version 5.6.6-300.fc32.s390x")
+
+    def test_menu_timeout(self):
+        '''
+        Check that boot menu shows up and boot continues automatically
+        when a timeout has been specified
+        '''
+        self.basic_machine_setup()
+        self.vm.add_args("-device", "virtio-blk-ccw,drive=d1,bootindex=1",
+                         "-boot", "menu=on,splash-time=1")
+        self.vm.launch()
+        self.wait_for_pattern("s390-ccw zIPL Boot Menu")
+        self.wait_for_pattern("0. default (Fedora (5.8.15-301.fc33.s390x)")
+        self.wait_for_pattern("(default will boot in 0 seconds)")
+        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.53.0


