Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B5C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUkGI-0003tU-8J; Fri, 19 Jul 2024 05:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sUkGG-0003sX-Q5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sUkGD-0001D9-Pd
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721382643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9y9Ij66/J8exGryiUhQ0gmr+Ps8BviwHqBpAqtIAOIs=;
 b=B//n3Fotv7h0U+tcV4OkTmKBktl5iDWYVhthBGoPaaVE/pwz4lI9sUxPmwHUs22f3qhIia
 UxeSJayBXWpQgtA+61gZUpSHBer43uwVZO2EDiTmDQQWn4JWpr3MPSo4p+nA65n1DdEyVK
 XbjZ2OO9pXBi1kajhHrrDqJSS64ERUc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-_HUDpJEoMye9FcM_rmV2Pg-1; Fri,
 19 Jul 2024 05:50:40 -0400
X-MC-Unique: _HUDpJEoMye9FcM_rmV2Pg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A74E51955F65; Fri, 19 Jul 2024 09:50:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 529313000192; Fri, 19 Jul 2024 09:50:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH] tests/avocado: Move LinuxTest related code into a separate
 file
Date: Fri, 19 Jul 2024 11:50:31 +0200
Message-ID: <20240719095031.32814-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_FRAUD_PHISH=0.01,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Only some few tests are using the LinuxTest class. Move the related
code into a separate file so that this does not pollute the main
namespace.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/avocado_qemu/__init__.py  | 239 +---------------------
 tests/avocado/avocado_qemu/linuxtest.py | 253 ++++++++++++++++++++++++
 tests/avocado/boot_linux.py             |   3 +-
 tests/avocado/hotplug_blk.py            |   2 +-
 tests/avocado/hotplug_cpu.py            |   2 +-
 tests/avocado/intel_iommu.py            |   2 +-
 tests/avocado/replay_linux.py           |   2 +-
 tests/avocado/smmu.py                   |   3 +-
 8 files changed, 262 insertions(+), 244 deletions(-)
 create mode 100644 tests/avocado/avocado_qemu/linuxtest.py

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 304c428168..a3da2a96bb 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -10,7 +10,6 @@
 
 import logging
 import os
-import shutil
 import subprocess
 import sys
 import tempfile
@@ -18,7 +17,7 @@
 import uuid
 
 import avocado
-from avocado.utils import cloudinit, datadrainer, process, ssh, vmimage
+from avocado.utils import ssh
 from avocado.utils.path import find_command
 
 from qemu.machine import QEMUMachine
@@ -32,14 +31,6 @@
 #: and build tree, it will not be accurate.
 BUILD_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
 
-if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
-    # The link to the avocado tests dir in the source code directory
-    lnk = os.path.dirname(os.path.dirname(__file__))
-    #: The QEMU root source directory
-    SOURCE_DIR = os.path.dirname(os.path.dirname(os.readlink(lnk)))
-else:
-    SOURCE_DIR = BUILD_DIR
-
 
 def has_cmd(name, args=None):
     """
@@ -451,231 +442,3 @@ def ssh_command_output_contains(self, cmd, exp):
                 break
         else:
             self.fail('"%s" output does not contain "%s"' % (cmd, exp))
-
-class LinuxDistro:
-    """Represents a Linux distribution
-
-    Holds information of known distros.
-    """
-    #: A collection of known distros and their respective image checksum
-    KNOWN_DISTROS = {
-        'fedora': {
-            '31': {
-                'x86_64':
-                {'checksum': ('e3c1b309d9203604922d6e255c2c5d09'
-                              '8a309c2d46215d8fc026954f3c5c27a0'),
-                 'pxeboot_url': ('https://archives.fedoraproject.org/'
-                                 'pub/archive/fedora/linux/releases/31/'
-                                 'Everything/x86_64/os/images/pxeboot/'),
-                 'kernel_params': ('root=UUID=b1438b9b-2cab-4065-a99a-'
-                                   '08a96687f73c ro no_timer_check '
-                                   'net.ifnames=0 console=tty1 '
-                                   'console=ttyS0,115200n8'),
-                },
-                'aarch64':
-                {'checksum': ('1e18d9c0cf734940c4b5d5ec592facae'
-                              'd2af0ad0329383d5639c997fdf16fe49'),
-                'pxeboot_url': 'https://archives.fedoraproject.org/'
-                               'pub/archive/fedora/linux/releases/31/'
-                               'Everything/aarch64/os/images/pxeboot/',
-                'kernel_params': ('root=UUID=b6950a44-9f3c-4076-a9c2-'
-                                  '355e8475b0a7 ro earlyprintk=pl011,0x9000000'
-                                  ' ignore_loglevel no_timer_check'
-                                  ' printk.time=1 rd_NO_PLYMOUTH'
-                                  ' console=ttyAMA0'),
-                },
-                'ppc64':
-                {'checksum': ('7c3528b85a3df4b2306e892199a9e1e4'
-                              '3f991c506f2cc390dc4efa2026ad2f58')},
-                's390x':
-                {'checksum': ('4caaab5a434fd4d1079149a072fdc789'
-                              '1e354f834d355069ca982fdcaf5a122d')},
-            },
-            '32': {
-                'aarch64':
-                {'checksum': ('b367755c664a2d7a26955bbfff985855'
-                              'adfa2ca15e908baf15b4b176d68d3967'),
-                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
-                                'releases/32/Server/aarch64/os/images/'
-                                'pxeboot/'),
-                'kernel_params': ('root=UUID=3df75b65-be8d-4db4-8655-'
-                                  '14d95c0e90c5 ro no_timer_check net.ifnames=0'
-                                  ' console=tty1 console=ttyS0,115200n8'),
-                },
-            },
-            '33': {
-                'aarch64':
-                {'checksum': ('e7f75cdfd523fe5ac2ca9eeece68edc1'
-                              'a81f386a17f969c1d1c7c87031008a6b'),
-                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
-                                'releases/33/Server/aarch64/os/images/'
-                                'pxeboot/'),
-                'kernel_params': ('root=UUID=d20b3ffa-6397-4a63-a734-'
-                                  '1126a0208f8a ro no_timer_check net.ifnames=0'
-                                  ' console=tty1 console=ttyS0,115200n8'
-                                  ' console=tty0'),
-                 },
-            },
-        }
-    }
-
-    def __init__(self, name, version, arch):
-        self.name = name
-        self.version = version
-        self.arch = arch
-        try:
-            info = self.KNOWN_DISTROS.get(name).get(version).get(arch)
-        except AttributeError:
-            # Unknown distro
-            info = None
-        self._info = info or {}
-
-    @property
-    def checksum(self):
-        """Gets the cloud-image file checksum"""
-        return self._info.get('checksum', None)
-
-    @checksum.setter
-    def checksum(self, value):
-        self._info['checksum'] = value
-
-    @property
-    def pxeboot_url(self):
-        """Gets the repository url where pxeboot files can be found"""
-        return self._info.get('pxeboot_url', None)
-
-    @property
-    def default_kernel_params(self):
-        """Gets the default kernel parameters"""
-        return self._info.get('kernel_params', None)
-
-
-class LinuxTest(LinuxSSHMixIn, QemuSystemTest):
-    """Facilitates having a cloud-image Linux based available.
-
-    For tests that intend to interact with guests, this is a better choice
-    to start with than the more vanilla `QemuSystemTest` class.
-    """
-
-    distro = None
-    username = 'root'
-    password = 'password'
-    smp = '2'
-    memory = '1024'
-
-    def _set_distro(self):
-        distro_name = self.params.get(
-            'distro',
-            default=self._get_unique_tag_val('distro'))
-        if not distro_name:
-            distro_name = 'fedora'
-
-        distro_version = self.params.get(
-            'distro_version',
-            default=self._get_unique_tag_val('distro_version'))
-        if not distro_version:
-            distro_version = '31'
-
-        self.distro = LinuxDistro(distro_name, distro_version, self.arch)
-
-        # The distro checksum behaves differently than distro name and
-        # version. First, it does not respect a tag with the same
-        # name, given that it's not expected to be used for filtering
-        # (distro name versions are the natural choice).  Second, the
-        # order of precedence is: parameter, attribute and then value
-        # from KNOWN_DISTROS.
-        distro_checksum = self.params.get('distro_checksum',
-                                          default=None)
-        if distro_checksum:
-            self.distro.checksum = distro_checksum
-
-    def setUp(self, ssh_pubkey=None, network_device_type='virtio-net'):
-        super().setUp()
-        self.require_netdev('user')
-        self._set_distro()
-        self.vm.add_args('-smp', self.smp)
-        self.vm.add_args('-m', self.memory)
-        # The following network device allows for SSH connections
-        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                         '-device', '%s,netdev=vnet' % network_device_type)
-        self.set_up_boot()
-        if ssh_pubkey is None:
-            ssh_pubkey, self.ssh_key = self.set_up_existing_ssh_keys()
-        self.set_up_cloudinit(ssh_pubkey)
-
-    def set_up_existing_ssh_keys(self):
-        ssh_public_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa.pub')
-        source_private_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa')
-        ssh_dir = os.path.join(self.workdir, '.ssh')
-        os.mkdir(ssh_dir, mode=0o700)
-        ssh_private_key = os.path.join(ssh_dir,
-                                       os.path.basename(source_private_key))
-        shutil.copyfile(source_private_key, ssh_private_key)
-        os.chmod(ssh_private_key, 0o600)
-        return (ssh_public_key, ssh_private_key)
-
-    def download_boot(self):
-        # Set the qemu-img binary.
-        # If none is available, the test will cancel.
-        vmimage.QEMU_IMG = super().get_qemu_img()
-
-        self.log.info('Downloading/preparing boot image')
-        # Fedora 31 only provides ppc64le images
-        image_arch = self.arch
-        if self.distro.name == 'fedora':
-            if image_arch == 'ppc64':
-                image_arch = 'ppc64le'
-
-        try:
-            boot = vmimage.get(
-                self.distro.name, arch=image_arch, version=self.distro.version,
-                checksum=self.distro.checksum,
-                algorithm='sha256',
-                cache_dir=self.cache_dirs[0],
-                snapshot_dir=self.workdir)
-        except:
-            self.cancel('Failed to download/prepare boot image')
-        return boot.path
-
-    def prepare_cloudinit(self, ssh_pubkey=None):
-        self.log.info('Preparing cloudinit image')
-        try:
-            cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
-            pubkey_content = None
-            if ssh_pubkey:
-                with open(ssh_pubkey) as pubkey:
-                    pubkey_content = pubkey.read()
-            cloudinit.iso(cloudinit_iso, self.name,
-                          username=self.username,
-                          password=self.password,
-                          # QEMU's hard coded usermode router address
-                          phone_home_host='10.0.2.2',
-                          phone_home_port=self.phone_server.server_port,
-                          authorized_key=pubkey_content)
-        except Exception:
-            self.cancel('Failed to prepare the cloudinit image')
-        return cloudinit_iso
-
-    def set_up_boot(self):
-        path = self.download_boot()
-        self.vm.add_args('-drive', 'file=%s' % path)
-
-    def set_up_cloudinit(self, ssh_pubkey=None):
-        self.phone_server = cloudinit.PhoneHomeServer(('0.0.0.0', 0),
-                                                      self.name)
-        cloudinit_iso = self.prepare_cloudinit(ssh_pubkey)
-        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
-
-    def launch_and_wait(self, set_up_ssh_connection=True):
-        self.vm.set_console()
-        self.vm.launch()
-        console_drainer = datadrainer.LineLogger(self.vm.console_socket.fileno(),
-                                                 logger=self.log.getChild('console'))
-        console_drainer.start()
-        self.log.info('VM launched, waiting for boot confirmation from guest')
-        while not self.phone_server.instance_phoned_back:
-            self.phone_server.handle_request()
-
-        if set_up_ssh_connection:
-            self.log.info('Setting up the SSH connection')
-            self.ssh_connect(self.username, self.ssh_key)
diff --git a/tests/avocado/avocado_qemu/linuxtest.py b/tests/avocado/avocado_qemu/linuxtest.py
new file mode 100644
index 0000000000..e1dc838b1c
--- /dev/null
+++ b/tests/avocado/avocado_qemu/linuxtest.py
@@ -0,0 +1,253 @@
+# Test class and utilities for functional Linux-based tests
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import shutil
+
+from avocado.utils import cloudinit, datadrainer, process, vmimage
+
+from . import LinuxSSHMixIn
+from . import QemuSystemTest
+
+if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
+    # The link to the avocado tests dir in the source code directory
+    lnk = os.path.dirname(os.path.dirname(__file__))
+    #: The QEMU root source directory
+    SOURCE_DIR = os.path.dirname(os.path.dirname(os.readlink(lnk)))
+else:
+    SOURCE_DIR = BUILD_DIR
+
+class LinuxDistro:
+    """Represents a Linux distribution
+
+    Holds information of known distros.
+    """
+    #: A collection of known distros and their respective image checksum
+    KNOWN_DISTROS = {
+        'fedora': {
+            '31': {
+                'x86_64':
+                {'checksum': ('e3c1b309d9203604922d6e255c2c5d09'
+                              '8a309c2d46215d8fc026954f3c5c27a0'),
+                 'pxeboot_url': ('https://archives.fedoraproject.org/'
+                                 'pub/archive/fedora/linux/releases/31/'
+                                 'Everything/x86_64/os/images/pxeboot/'),
+                 'kernel_params': ('root=UUID=b1438b9b-2cab-4065-a99a-'
+                                   '08a96687f73c ro no_timer_check '
+                                   'net.ifnames=0 console=tty1 '
+                                   'console=ttyS0,115200n8'),
+                },
+                'aarch64':
+                {'checksum': ('1e18d9c0cf734940c4b5d5ec592facae'
+                              'd2af0ad0329383d5639c997fdf16fe49'),
+                'pxeboot_url': 'https://archives.fedoraproject.org/'
+                               'pub/archive/fedora/linux/releases/31/'
+                               'Everything/aarch64/os/images/pxeboot/',
+                'kernel_params': ('root=UUID=b6950a44-9f3c-4076-a9c2-'
+                                  '355e8475b0a7 ro earlyprintk=pl011,0x9000000'
+                                  ' ignore_loglevel no_timer_check'
+                                  ' printk.time=1 rd_NO_PLYMOUTH'
+                                  ' console=ttyAMA0'),
+                },
+                'ppc64':
+                {'checksum': ('7c3528b85a3df4b2306e892199a9e1e4'
+                              '3f991c506f2cc390dc4efa2026ad2f58')},
+                's390x':
+                {'checksum': ('4caaab5a434fd4d1079149a072fdc789'
+                              '1e354f834d355069ca982fdcaf5a122d')},
+            },
+            '32': {
+                'aarch64':
+                {'checksum': ('b367755c664a2d7a26955bbfff985855'
+                              'adfa2ca15e908baf15b4b176d68d3967'),
+                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
+                                'releases/32/Server/aarch64/os/images/'
+                                'pxeboot/'),
+                'kernel_params': ('root=UUID=3df75b65-be8d-4db4-8655-'
+                                  '14d95c0e90c5 ro no_timer_check net.ifnames=0'
+                                  ' console=tty1 console=ttyS0,115200n8'),
+                },
+            },
+            '33': {
+                'aarch64':
+                {'checksum': ('e7f75cdfd523fe5ac2ca9eeece68edc1'
+                              'a81f386a17f969c1d1c7c87031008a6b'),
+                'pxeboot_url': ('http://dl.fedoraproject.org/pub/fedora/linux/'
+                                'releases/33/Server/aarch64/os/images/'
+                                'pxeboot/'),
+                'kernel_params': ('root=UUID=d20b3ffa-6397-4a63-a734-'
+                                  '1126a0208f8a ro no_timer_check net.ifnames=0'
+                                  ' console=tty1 console=ttyS0,115200n8'
+                                  ' console=tty0'),
+                 },
+            },
+        }
+    }
+
+    def __init__(self, name, version, arch):
+        self.name = name
+        self.version = version
+        self.arch = arch
+        try:
+            info = self.KNOWN_DISTROS.get(name).get(version).get(arch)
+        except AttributeError:
+            # Unknown distro
+            info = None
+        self._info = info or {}
+
+    @property
+    def checksum(self):
+        """Gets the cloud-image file checksum"""
+        return self._info.get('checksum', None)
+
+    @checksum.setter
+    def checksum(self, value):
+        self._info['checksum'] = value
+
+    @property
+    def pxeboot_url(self):
+        """Gets the repository url where pxeboot files can be found"""
+        return self._info.get('pxeboot_url', None)
+
+    @property
+    def default_kernel_params(self):
+        """Gets the default kernel parameters"""
+        return self._info.get('kernel_params', None)
+
+
+class LinuxTest(LinuxSSHMixIn, QemuSystemTest):
+    """Facilitates having a cloud-image Linux based available.
+
+    For tests that intend to interact with guests, this is a better choice
+    to start with than the more vanilla `QemuSystemTest` class.
+    """
+
+    distro = None
+    username = 'root'
+    password = 'password'
+    smp = '2'
+    memory = '1024'
+
+    def _set_distro(self):
+        distro_name = self.params.get(
+            'distro',
+            default=self._get_unique_tag_val('distro'))
+        if not distro_name:
+            distro_name = 'fedora'
+
+        distro_version = self.params.get(
+            'distro_version',
+            default=self._get_unique_tag_val('distro_version'))
+        if not distro_version:
+            distro_version = '31'
+
+        self.distro = LinuxDistro(distro_name, distro_version, self.arch)
+
+        # The distro checksum behaves differently than distro name and
+        # version. First, it does not respect a tag with the same
+        # name, given that it's not expected to be used for filtering
+        # (distro name versions are the natural choice).  Second, the
+        # order of precedence is: parameter, attribute and then value
+        # from KNOWN_DISTROS.
+        distro_checksum = self.params.get('distro_checksum',
+                                          default=None)
+        if distro_checksum:
+            self.distro.checksum = distro_checksum
+
+    def setUp(self, ssh_pubkey=None, network_device_type='virtio-net'):
+        super().setUp()
+        self.require_netdev('user')
+        self._set_distro()
+        self.vm.add_args('-smp', self.smp)
+        self.vm.add_args('-m', self.memory)
+        # The following network device allows for SSH connections
+        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                         '-device', '%s,netdev=vnet' % network_device_type)
+        self.set_up_boot()
+        if ssh_pubkey is None:
+            ssh_pubkey, self.ssh_key = self.set_up_existing_ssh_keys()
+        self.set_up_cloudinit(ssh_pubkey)
+
+    def set_up_existing_ssh_keys(self):
+        ssh_public_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa.pub')
+        source_private_key = os.path.join(SOURCE_DIR, 'tests', 'keys', 'id_rsa')
+        ssh_dir = os.path.join(self.workdir, '.ssh')
+        os.mkdir(ssh_dir, mode=0o700)
+        ssh_private_key = os.path.join(ssh_dir,
+                                       os.path.basename(source_private_key))
+        shutil.copyfile(source_private_key, ssh_private_key)
+        os.chmod(ssh_private_key, 0o600)
+        return (ssh_public_key, ssh_private_key)
+
+    def download_boot(self):
+        # Set the qemu-img binary.
+        # If none is available, the test will cancel.
+        vmimage.QEMU_IMG = super().get_qemu_img()
+
+        self.log.info('Downloading/preparing boot image')
+        # Fedora 31 only provides ppc64le images
+        image_arch = self.arch
+        if self.distro.name == 'fedora':
+            if image_arch == 'ppc64':
+                image_arch = 'ppc64le'
+
+        try:
+            boot = vmimage.get(
+                self.distro.name, arch=image_arch, version=self.distro.version,
+                checksum=self.distro.checksum,
+                algorithm='sha256',
+                cache_dir=self.cache_dirs[0],
+                snapshot_dir=self.workdir)
+        except:
+            self.cancel('Failed to download/prepare boot image')
+        return boot.path
+
+    def prepare_cloudinit(self, ssh_pubkey=None):
+        self.log.info('Preparing cloudinit image')
+        try:
+            cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
+            pubkey_content = None
+            if ssh_pubkey:
+                with open(ssh_pubkey) as pubkey:
+                    pubkey_content = pubkey.read()
+            cloudinit.iso(cloudinit_iso, self.name,
+                          username=self.username,
+                          password=self.password,
+                          # QEMU's hard coded usermode router address
+                          phone_home_host='10.0.2.2',
+                          phone_home_port=self.phone_server.server_port,
+                          authorized_key=pubkey_content)
+        except Exception:
+            self.cancel('Failed to prepare the cloudinit image')
+        return cloudinit_iso
+
+    def set_up_boot(self):
+        path = self.download_boot()
+        self.vm.add_args('-drive', 'file=%s' % path)
+
+    def set_up_cloudinit(self, ssh_pubkey=None):
+        self.phone_server = cloudinit.PhoneHomeServer(('0.0.0.0', 0),
+                                                      self.name)
+        cloudinit_iso = self.prepare_cloudinit(ssh_pubkey)
+        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
+
+    def launch_and_wait(self, set_up_ssh_connection=True):
+        self.vm.set_console()
+        self.vm.launch()
+        console_drainer = datadrainer.LineLogger(self.vm.console_socket.fileno(),
+                                                 logger=self.log.getChild('console'))
+        console_drainer.start()
+        self.log.info('VM launched, waiting for boot confirmation from guest')
+        while not self.phone_server.instance_phoned_back:
+            self.phone_server.handle_request()
+
+        if set_up_ssh_connection:
+            self.log.info('Setting up the SSH connection')
+            self.ssh_connect(self.username, self.ssh_key)
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index cdce4cbcba..a029ef4ad1 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -10,7 +10,8 @@
 
 import os
 
-from avocado_qemu import LinuxTest, BUILD_DIR
+from avocado_qemu.linuxtest import LinuxTest
+from avocado_qemu import BUILD_DIR
 
 from avocado import skipUnless
 
diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
index 5dc30f6616..d55ded1c1d 100644
--- a/tests/avocado/hotplug_blk.py
+++ b/tests/avocado/hotplug_blk.py
@@ -9,7 +9,7 @@
 
 import time
 
-from avocado_qemu import LinuxTest
+from avocado_qemu.linuxtest import LinuxTest
 
 
 class HotPlug(LinuxTest):
diff --git a/tests/avocado/hotplug_cpu.py b/tests/avocado/hotplug_cpu.py
index 292bb43e4d..342c838539 100644
--- a/tests/avocado/hotplug_cpu.py
+++ b/tests/avocado/hotplug_cpu.py
@@ -8,7 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import LinuxTest
+from avocado_qemu.linuxtest import LinuxTest
 
 
 class HotPlugCPU(LinuxTest):
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 09e694bd40..008f214397 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -10,7 +10,7 @@
 import os
 
 from avocado import skipUnless
-from avocado_qemu import LinuxTest
+from avocado_qemu.linuxtest import LinuxTest
 
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
 
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index f3a43dc98c..b4673261ce 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -19,7 +19,7 @@
 from avocado.utils import vmimage
 from avocado.utils import datadrainer
 from avocado.utils.path import find_command
-from avocado_qemu import LinuxTest
+from avocado_qemu.linuxtest import LinuxTest
 
 class ReplayLinux(LinuxTest):
     """
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
index 4ebfa7128c..aadda71e4b 100644
--- a/tests/avocado/smmu.py
+++ b/tests/avocado/smmu.py
@@ -10,7 +10,8 @@
 import os
 
 from avocado import skipUnless
-from avocado_qemu import LinuxTest, BUILD_DIR
+from avocado_qemu import BUILD_DIR
+from avocado_qemu.linuxtest import LinuxTest
 
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
 
-- 
2.45.2


