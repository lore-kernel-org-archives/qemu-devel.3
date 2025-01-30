Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3CC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPZ-0007qh-Co; Thu, 30 Jan 2025 08:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOi-0007KE-HO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOd-0008Sm-W7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jS5zDx9jtnIO/JxC5lpsMdrbwXR47jWwVrlXMYE0NaA=;
 b=ggJ4MupSvSmbhL8rsoWweB/c7Avelz7S1IBn2wTd8cSOqH2rbrI5y14y+IoMRRwh27d2RK
 Fx9eAkofb/qG4uxrVvUnZVVd/cIfdSWms1Nc0IQEwTAV5xAM5mmXtKHV9436OUzGssZ4sS
 VcDVC2PafaIO6/XH9Ouq57lCRugi7eU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-bDoZkGlwNqK89XlQflAVSQ-1; Thu,
 30 Jan 2025 08:15:49 -0500
X-MC-Unique: bDoZkGlwNqK89XlQflAVSQ-1
X-Mimecast-MFC-AGG-ID: bDoZkGlwNqK89XlQflAVSQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06B87180034F
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:15:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E3E530001BE; Thu, 30 Jan 2025 13:15:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/20] tests/functional: Add a ppc64 mac99 test
Date: Thu, 30 Jan 2025 14:15:19 +0100
Message-ID: <20250130131535.91297-6-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The test sequence boots from disk a mac99 machine in 64-bit mode, in
which case the CPU is a PPC 970.

The buildroot rootfs is built with config :

BR2_powerpc64=y
BR2_powerpc_970=y

and the kernel with the g5 deconfig.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250128212145.1186617-1-clg@redhat.com>
[thuth: Adjusted the comment about '-nographic]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |  1 +
 tests/functional/meson.build         |  2 ++
 tests/functional/test_ppc64_mac99.py | 44 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100755 tests/functional/test_ppc64_mac99.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b4d84bf5f..59c3c45f86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1453,6 +1453,7 @@ F: include/hw/pci-host/uninorth.h
 F: include/hw/input/adb*
 F: pc-bios/qemu_vga.ndrv
 F: tests/functional/test_ppc_mac.py
+F: tests/functional/test_ppc64_mac99.py
 
 Old World (g3beige)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2b2d8953aa..2e0802144a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -41,6 +41,7 @@ test_timeouts = {
   'ppc64_powernv' : 480,
   'ppc64_pseries' : 480,
   'ppc64_tuxrun' : 420,
+  'ppc64_mac99' : 120,
   'riscv64_tuxrun' : 120,
   's390x_ccw_virtio' : 420,
   'sh4_tuxrun' : 240,
@@ -205,6 +206,7 @@ tests_ppc64_system_thorough = [
   'ppc64_powernv',
   'ppc64_pseries',
   'ppc64_tuxrun',
+  'ppc64_mac99',
 ]
 
 tests_riscv32_system_quick = [
diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
new file mode 100755
index 0000000000..dfd9c01371
--- /dev/null
+++ b/tests/functional/test_ppc64_mac99.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a mac99 machine with a PPC970 CPU
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+
+class mac99Test(LinuxKernelTest):
+
+    ASSET_BR2_MAC99_LINUX = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
+        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
+
+    ASSET_BR2_MAC99_ROOTFS = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
+        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
+
+    def test_ppc64_mac99_buildroot(self):
+        self.set_machine('mac99')
+
+        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
+        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
+
+        self.vm.set_console()
+
+        # Note: We need '-nographic' to get a serial console
+        self.vm.add_args('-kernel', linux_path,
+                         '-append', 'root=/dev/sda',
+                         '-drive', f'file={rootfs_path},format=raw',
+                         '-snapshot', '-nographic')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('>> OpenBIOS')
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('/init as init process')
+        self.wait_for_console_pattern('gem 0000:f0:0e.0 eth0: Link is up at 100 Mbps')
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.48.1


