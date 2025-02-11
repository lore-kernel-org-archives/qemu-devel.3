Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8F7C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQt-0005hJ-0w; Tue, 11 Feb 2025 07:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQr-0005gQ-B4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQp-0000Na-9o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCo5bAQdLEanaWjHroagXTkeDpLVAvRrOcjgUeyp7RA=;
 b=hR55fLCzM4NVTumY3gnZ9xX4GjWOB3uVCy+sSiUE+ECIAb7yGcSFZfGxsaVKHfvOfKFyKk
 6tLQbbaO9oUTE9GOmuxgMCSaB6DeRvOAr8cCaygBWz+6adSE32wfaAwkSk819+tNprmIZi
 B/yM2W7qOfmdcMHybIKMcsYZQfo1NIo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-lYqrODunM1iUVT4bnseyhg-1; Tue,
 11 Feb 2025 07:32:00 -0500
X-MC-Unique: lYqrODunM1iUVT4bnseyhg-1
X-Mimecast-MFC-AGG-ID: lYqrODunM1iUVT4bnseyhg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FAD7180087C
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:31:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71DE919560A3; Tue, 11 Feb 2025 12:31:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/7] tests/functional: Add a ppc sam460ex test
Date: Tue, 11 Feb 2025 13:31:41 +0100
Message-ID: <20250211123144.37617-5-thuth@redhat.com>
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The test sequence boots from kernel a sam460ex machine with a
virtio-net device to check PCI.

The buildroot is built with config :

  BR2_powerpc=y
  BR2_powerpc_440fp=y

and the kernel with the '44x/canyonlands' deconfig and virtio support.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250203092606.491933-1-clg@redhat.com>
[thuth: sort meson.build alphabetically]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |  1 +
 tests/functional/meson.build          |  1 +
 tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 tests/functional/test_ppc_sam460ex.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a593241800..794bde23a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1562,6 +1562,7 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
+F: tests/functional/test_ppc_sam460ex.py
 
 pegasos2
 M: BALATON Zoltan <balaton@eik.bme.hu>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 70646d3457..b516d21cba 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -197,6 +197,7 @@ tests_ppc_system_thorough = [
   'ppc_bamboo',
   'ppc_mac',
   'ppc_mpc8544ds',
+  'ppc_sam460ex',
   'ppc_tuxrun',
   'ppc_virtex_ml507',
 ]
diff --git a/tests/functional/test_ppc_sam460ex.py b/tests/functional/test_ppc_sam460ex.py
new file mode 100644
index 0000000000..31cf9dd6de
--- /dev/null
+++ b/tests/functional/test_ppc_sam460ex.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a sam460ex machine with a PPC 460EX CPU
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+
+
+class sam460exTest(LinuxKernelTest):
+
+    ASSET_BR2_SAM460EX_LINUX = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
+        '6f46346f3e20e8b5fc050ff363f350f8b9d76a051b9e0bd7ea470cc680c14df2')
+
+    def test_ppc_sam460ex_buildroot(self):
+        self.set_machine('sam460ex')
+        self.require_netdev('user')
+
+        linux_path = self.ASSET_BR2_SAM460EX_LINUX.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', linux_path,
+                         '-device', 'virtio-net-pci,netdev=net0',
+                         '-netdev', 'user,id=net0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('Hardware name: amcc,canyonlands 460EX')
+        self.wait_for_console_pattern('/init as init process')
+        self.wait_for_console_pattern('lease of 10.0.2.15 obtained')
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self, 'poweroff', 'System Halted')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.48.1


