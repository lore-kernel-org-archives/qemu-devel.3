Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB42C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9g-0001bx-Kl; Fri, 11 Jul 2025 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9B-0000u3-E9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA94-00076v-2W
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAqkVnj+I3W52z4DHcIlntVCfBKbnfxB134+d6tJ+JE=;
 b=czagaT1k1HEcpYkVxZGzgJbnmAmlCAR/zSNKdyy8JHmNHTd8JJ+nWA2iw5sTHiLHVGnemc
 65Qi2VtU+LL70nulLnv0AyzwGV34TOKVBD1sSDu7Mj7hPa8VxrPnDbVxxCwiOezeByKFmB
 /4PlIUW1LavbOBQ6mjhQz0PR6jjXxJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-LB1g24S8NfeG2Vx_aWaarg-1; Fri,
 11 Jul 2025 05:34:13 -0400
X-MC-Unique: LB1g24S8NfeG2Vx_aWaarg-1
X-Mimecast-MFC-AGG-ID: LB1g24S8NfeG2Vx_aWaarg_1752226452
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5576183030E; Fri, 11 Jul 2025 09:34:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25DC0195607A; Fri, 11 Jul 2025 09:34:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 08/15] tests/functional: Add a test for s390x pxelinux.cfg
 network booting
Date: Fri, 11 Jul 2025 11:33:33 +0200
Message-ID: <20250711093340.608485-9-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

Check the various ways of booting a kernel via pxelinux.cfg file,
e.g. by specifying the config file name via the MAC address or the
UUID of the guest. Also check whether we can successfully load an
alternate kernel via the "loadparm" parameter here and whether the
boot menu shows up with "-boot menu=on".

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250709083443.41574-6-thuth@redhat.com>
---
 MAINTAINERS                             |   1 +
 tests/functional/meson.build            |   1 +
 tests/functional/test_s390x_pxelinux.py | 119 ++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100755 tests/functional/test_s390x_pxelinux.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1842c3dd83f..e88ed2c0a97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1805,6 +1805,7 @@ F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
+F: tests/functional/test_s390x_pxelinux.py
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 050c9000b95..1ae5f02fb37 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -281,6 +281,7 @@ tests_rx_system_thorough = [
 
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
+  's390x_pxelinux',
   's390x_replay',
   's390x_topology',
   's390x_tuxrun',
diff --git a/tests/functional/test_s390x_pxelinux.py b/tests/functional/test_s390x_pxelinux.py
new file mode 100755
index 00000000000..4fc33b8c46d
--- /dev/null
+++ b/tests/functional/test_s390x_pxelinux.py
@@ -0,0 +1,119 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Functional test that checks the pxelinux.cfg network booting of a s390x VM
+# (TFTP booting without config file is already tested by the pxe qtest, so
+#  we don't repeat that here).
+
+import os
+import shutil
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+pxelinux_cfg_contents='''# pxelinux.cfg style config file
+default Debian
+label Nonexisting
+kernel kernel.notavailable
+initrd initrd.notavailable
+label Debian
+kernel kernel.debian
+initrd initrd.debian
+append testoption=teststring
+label Fedora
+kernel kernel.fedora
+'''
+
+class S390PxeLinux(QemuSystemTest):
+
+    ASSET_DEBIAN_KERNEL = Asset(
+        ('https://snapshot.debian.org/archive/debian/'
+         '20201126T092837Z/dists/buster/main/installer-s390x/'
+         '20190702+deb10u6/images/generic/kernel.debian'),
+        'd411d17c39ae7ad38d27534376cbe88b68b403c325739364122c2e6f1537e818')
+
+    ASSET_DEBIAN_INITRD = Asset(
+        ('https://snapshot.debian.org/archive/debian/'
+         '20201126T092837Z/dists/buster/main/installer-s390x/'
+         '20190702+deb10u6/images/generic/initrd.debian'),
+        '836bbd0fe6a5ca81274c28c2b063ea315ce1868660866e9b60180c575fef9fd5')
+
+    ASSET_FEDORA_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive'
+         '/fedora-secondary/releases/31/Server/s390x/os'
+         '/images/kernel.img'),
+        '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
+
+    def pxelinux_launch(self, pl_name='default', extra_opts=None):
+        self.require_netdev('user')
+        self.set_machine('s390-ccw-virtio')
+
+        debian_kernel = self.ASSET_DEBIAN_KERNEL.fetch()
+        debian_initrd = self.ASSET_DEBIAN_INITRD.fetch()
+        fedora_kernel = self.ASSET_FEDORA_KERNEL.fetch()
+
+        # Prepare a folder for the TFTP "server":
+        tftpdir = self.scratch_file('tftp')
+        shutil.rmtree(tftpdir, ignore_errors=True)   # Remove stale stuff
+        os.mkdir(tftpdir)
+        shutil.copy(debian_kernel, os.path.join(tftpdir, 'kernel.debian'))
+        shutil.copy(debian_initrd, os.path.join(tftpdir, 'initrd.debian'))
+        shutil.copy(fedora_kernel, os.path.join(tftpdir, 'kernel.fedora'))
+
+        pxelinuxdir = self.scratch_file('tftp', 'pxelinux.cfg')
+        os.mkdir(pxelinuxdir)
+
+        cfg_fname = self.scratch_file('tftp', 'pxelinux.cfg', pl_name)
+        with open(cfg_fname, 'w', encoding='utf-8') as f:
+            f.write(pxelinux_cfg_contents)
+
+        virtio_net_dev = 'virtio-net-ccw,netdev=n1,bootindex=1'
+        if extra_opts:
+                virtio_net_dev += ',' + extra_opts
+
+        self.vm.add_args('-m', '384',
+                         '-netdev', f'user,id=n1,tftp={tftpdir}',
+                         '-device', virtio_net_dev)
+        self.vm.set_console()
+        self.vm.launch()
+
+
+    def test_default(self):
+        self.pxelinux_launch()
+        # The kernel prints its arguments to the console, so we can use
+        # this to check whether the kernel parameters are correctly handled:
+        wait_for_console_pattern(self, 'testoption=teststring')
+        # Now also check that we've successfully loaded the initrd:
+        wait_for_console_pattern(self, 'Unpacking initramfs...')
+        wait_for_console_pattern(self, 'Run /init as init process')
+
+    def test_mac(self):
+        self.pxelinux_launch(pl_name='01-02-ca-fe-ba-be-42',
+                             extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3')
+        wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
+
+    def test_uuid(self):
+        # Also add a non-bootable disk to check the fallback to network boot:
+        self.vm.add_args('-blockdev', 'null-co,size=65536,node-name=d1',
+                         '-device', 'virtio-blk,drive=d1,bootindex=0,loadparm=1',
+                         '-uuid', '550e8400-e29b-11d4-a716-446655441234')
+        self.pxelinux_launch(pl_name='550e8400-e29b-11d4-a716-446655441234')
+        wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
+
+    def test_ip(self):
+        self.vm.add_args('-M', 'loadparm=3')
+        self.pxelinux_launch(pl_name='0A00020F')
+        wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
+
+    def test_menu(self):
+        self.vm.add_args('-boot', 'menu=on,splash-time=10')
+        self.pxelinux_launch(pl_name='0A00')
+        wait_for_console_pattern(self, '[1] Nonexisting')
+        wait_for_console_pattern(self, '[2] Debian')
+        wait_for_console_pattern(self, '[3] Fedora')
+        wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.50.0


