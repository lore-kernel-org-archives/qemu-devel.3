Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD5DCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 18:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6CXH-0005yn-Oe; Tue, 07 Oct 2025 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWi-0005oB-GG
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWf-0002qF-GI
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759862104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05ZWYAXl5ZwTZ0FtrkUAUoGr1gQfXaB5RyM4Ta7fz84=;
 b=Y5OGIG9GaQDiTbl4mWkNRIxsCCGID95264lBD8+yXg8B2su2Grrqi9yI1CoTRKTzRWs0Cu
 pQNYiZL731PhPzMyjNSprHU/gf8pBKEPqLtGN0CeCZ6A8ejSOQkM9HbI7YMzXVArc55BU0
 wNSIE3aJwlW0GxbkyOIaks3Toy+5uzI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-kldb1I1zN8SxpSlsCacXHg-1; Tue,
 07 Oct 2025 14:35:02 -0400
X-MC-Unique: kldb1I1zN8SxpSlsCacXHg-1
X-Mimecast-MFC-AGG-ID: kldb1I1zN8SxpSlsCacXHg_1759862101
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B346F1956096; Tue,  7 Oct 2025 18:35:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E3F31956056; Tue,  7 Oct 2025 18:35:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 5/5] tests/functional: add vdpa-blk blockdev-mirror test
Date: Tue,  7 Oct 2025 14:34:47 -0400
Message-ID: <20251007183447.93120-6-stefanha@redhat.com>
In-Reply-To: <20251007183447.93120-1-stefanha@redhat.com>
References: <20251007183447.93120-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a test case that reproduces
https://issues.redhat.com/browse/RHEL-88175.

When the mirror blockjob completes, it replaces the original vdpa-blk
blockdev node with a new vdpa-blk blockdev. This will only work if the
BlockRAMRegistrar populates memory mappings (see the previous commit).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_vdpa_blk_mirror.py | 118 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vdpa_blk_mirror.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6c..dfe0e00190 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -33,6 +33,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vdpa_blk_mirror',
   'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
diff --git a/tests/functional/x86_64/test_vdpa_blk_mirror.py b/tests/functional/x86_64/test_vdpa_blk_mirror.py
new file mode 100755
index 0000000000..7d52836920
--- /dev/null
+++ b/tests/functional/x86_64/test_vdpa_blk_mirror.py
@@ -0,0 +1,118 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright Red Hat, Inc.
+#
+# vdpa-blk mirror blockjob tests
+
+
+import glob
+import os
+import subprocess
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+
+
+def run(cmd: str) -> None:
+    '''
+    Run a shell command without capturing stdout/stderr and raise
+    subprocess.CalledProcessError on failure.
+    '''
+    subprocess.check_call(cmd, shell=True,
+                          stdout=subprocess.DEVNULL,
+                          stderr=subprocess.DEVNULL)
+
+
+class VdpaBlk(LinuxKernelTest):
+
+    KERNEL_COMMAND_LINE = 'printk.time=0 console=ttyS0 rd.rescue'
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+    VDPA_DEV_1 = f'vdpa-{os.getpid()}-1'
+    VDPA_DEV_2 = f'vdpa-{os.getpid()}-2'
+
+    def setUp(self) -> None:
+        def create_vdpa_dev(name):
+            '''
+            Create a new vdpasim_blk device and return its vhost_vdpa device
+            path.
+            '''
+            run(f'sudo -n vdpa dev add mgmtdev vdpasim_blk name {name}')
+            sysfs_vhost_vdpa_dev_dir = \
+                glob.glob(f'/sys/bus/vdpa/devices/{name}/vhost-vdpa-*')[0]
+            vhost_dev_basename = os.path.basename(sysfs_vhost_vdpa_dev_dir)
+            vhost_dev_path = f'/dev/{vhost_dev_basename}'
+            run(f'sudo -n chown {os.getuid()}:{os.getgid()} {vhost_dev_path}')
+            return vhost_dev_path
+
+        try:
+            run('sudo -n modprobe vhost_vdpa')
+            run('sudo -n modprobe vdpa_sim_blk')
+
+            self.vhost_dev_1_path = create_vdpa_dev(self.VDPA_DEV_1)
+            self.vhost_dev_2_path = create_vdpa_dev(self.VDPA_DEV_2)
+        except subprocess.CalledProcessError:
+            self.skipTest('Failed to set up vdpa_blk device')
+
+        super().setUp()
+
+    def tearDown(self) -> None:
+        super().tearDown()
+
+        try:
+            run(f'sudo -n vdpa dev del {self.VDPA_DEV_2}')
+            run(f'sudo -n vdpa dev del {self.VDPA_DEV_1}')
+            run('sudo -n modprobe --remove vdpa_sim_blk')
+            run('sudo -n modprobe --remove vhost_vdpa')
+        except subprocess.CalledProcessError:
+            pass # ignore failures
+
+    def test_mirror(self) -> None:
+        '''
+        Check that I/O works after a mirror blockjob pivots. See
+        https://issues.redhat.com/browse/RHEL-88175.
+        '''
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args('-object', 'memory-backend-memfd,id=mem,size=1G')
+        self.vm.add_args('-machine', 'pc,accel=kvm:tcg,memory-backend=mem')
+        self.vm.add_args('-append', self.KERNEL_COMMAND_LINE)
+        self.vm.add_args('-blockdev',
+            'virtio-blk-vhost-vdpa,node-name=vdpa-blk-0,' +
+            f'path={self.vhost_dev_1_path},cache.direct=on')
+        self.vm.add_args('-device', 'virtio-blk-pci,drive=vdpa-blk-0')
+
+        self.launch_kernel(kernel_path, initrd_path,
+                           wait_for='# ')
+
+        self.vm.cmd('blockdev-add',
+                    driver='virtio-blk-vhost-vdpa',
+                    node_name='vdpa-blk-1',
+                    path=self.vhost_dev_2_path,
+                    cache={'direct': True})
+        self.vm.cmd('blockdev-mirror',
+                    device='vdpa-blk-0',
+                    job_id='mirror0',
+                    target='vdpa-blk-1',
+                    sync='full',
+                    target_is_zero=True)
+        self.vm.event_wait('BLOCK_JOB_READY')
+        self.vm.cmd('block-job-complete',
+                    device='mirror0')
+
+        exec_command_and_wait_for_pattern(self,
+            'dd if=/dev/vda of=/dev/null iflag=direct bs=4k count=1',
+            '4096 bytes (4.1 kB, 4.0 KiB) copied')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.51.0


