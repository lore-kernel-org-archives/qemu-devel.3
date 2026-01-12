Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AFECF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 23:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQvU-0003M2-Pv; Mon, 12 Jan 2026 18:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvS-0003L2-0Y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:18 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvO-0006II-P8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:17 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 abe4e9154eadea1569f0e7b462d2cb4b79ad464017d3fe8ef93a25a7872c7cbc with SMTP id
 69657d6e589bbfeeb4db3433; Mon, 12 Jan 2026 23:02:06 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768258925;
 bh=P5Ok0H0WTtrIdfeLa9f2dS19wnXPPfz5ZOswq0YMenM=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
 From:Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:
 Content-type:Content-transfer-encoding:In-reply-to:References;
 b=YRDNp+gkAnEwn8ffZZzLnYdsaRFlcRTxiQI5KjAqDppmGNANAT4543d0FVt38Bi1o
 nBB6tdCn+QQb8sUek53YtyArCS3EdKsg+zpsmVD9V/KOo/2WWc2XvBLiq4xT81DCu9
 th3iACiHaZQbPPaHFKPWBlGijs+Xqvx2Xj7zTJ5mYDAo9t7BfH8gFpWpqBqzkUiSy4
 +klNulCcdVNTSQcWUq41uJvAtz5NkBDyyqhjiAaWO8v3HgOaajNig6t3JtIv9tsf9V
 FPs5iPsNLU4dXjpHsMNVEi+unoM+aby8RAQ/v8TLlmbaDS2KHKUngYnsoFCtssBZ5q
 XpuK/lS/8+eOA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [RFC PATCH v2 2/3] tests/functional/x86_64: Add vhost-user-bridge test
Date: Mon, 12 Jan 2026 17:01:26 -0600
Message-ID: <20260112230127.99125-3-yodel.eldar@yodel.dev>
In-Reply-To: <20260112230127.99125-1-yodel.eldar@yodel.dev>
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a functional test of vhost-user-bridge and enter it into
MAINTAINERS under the vhost section.

The test runs vhost-user-bridge as a subprocess, then launches a guest
with four backends: a unix domain socket for vhost-user, a UDP socket, a
user-mode net, and a hubport to hub the UDP and user backends; only the
vhost-user backend is exposed, the rest are deviceless. This
configuration mimics the testing setup described in the initial commit
of vhost-user-bridge in 3595e2eb0a23.

A file containing a hardcoded UUID is created by the test in a scratch
file and exposed to the guest via the tftp parameter of the user netdev.
The guest requests the file by invoking tftp, and the test verifies its
sha256 hashsum.

Similarly, a file containing another hardcoded UUID is created in the
guest. A call to check_http_download() serves the file via http to the
host and verifies integrity with its hashsum.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 MAINTAINERS                                   |   1 +
 .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a46c7fd0b..f41811d482 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2374,32 +2374,33 @@ F: docs/devel/vfio-iommufd.rst
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
 F: docs/interop/vhost-user*
 F: docs/system/devices/vhost-user*
 F: contrib/vhost-user-*/
 F: backends/*vhost*
 F: include/system/vhost-user-backend.h
 F: include/hw/virtio/vhost*
 F: include/*/vhost*
 F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
 F: net/vhost*
+F: tests/functional/x86_64/test_vhost_user_bridge.py
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
 F: hw/virtio/vhost-shadow-virtqueue.*
 
 virtio
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
 F: hw/*/virtio*
 F: hw/virtio/Makefile.objs
 F: hw/virtio/trace-events
 F: qapi/virtio.json
 F: net/vhost-user.c
 F: include/hw/virtio/
 F: docs/devel/virtio*
 F: docs/devel/migration/virtio.rst
diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
new file mode 100755
index 0000000000..bf152dc959
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -0,0 +1,147 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Software Freedom Conservancy, Inc.
+#
+# Author: Yodel Eldar <yodel.eldar@yodel.dev>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Test vhost-user-bridge (vubr) functionality:
+
+    1) Run vhost-user-bridge on the host.
+    2) Launch a guest VM:
+        a) Instantiate a unix domain socket to the vubr-created path
+        b) Instantiate a vhost-user backend on top of that socket
+        c) Map a virtio-net-pci device to the vhost-user backend
+        d) Instantiate a UDP socket backend
+        e) Instantiate a user-mode net backend
+            i) Forward an ephemeral port to port 8080 in-guest with hostfwd=
+            ii) Expose a generated scratch file to the guest with tftp=
+        f) Hub the UDP and user-mode backends.
+    3) Invoke tftp in the guest to download exported scratch file from the host.
+    4) Serve a file to the host via http server in the guest.
+"""
+
+import os
+import shutil
+import subprocess
+from qemu_test import Asset, LinuxKernelTest, which
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
+from qemu_test import wait_for_console_pattern
+from qemu_test.ports import Ports
+
+class VhostUserBridge(LinuxKernelTest):
+
+    ASSET_KERNEL_INITRAMFS = Asset(
+        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
+        "8860d7aa59434f483542cdf25b42eacae0d4d4aa7ec923af9589d1ad4703d42b")
+
+    HOST_UUID = "ba4c2e39-627f-487d-ae3b-93cc5d783eb8"
+    HOST_UUID_HSUM = \
+        "d2932e34bf6c17b33e7325140b691e27c191d9ac4dfa550f68c09506facb09b9"
+
+    GUEST_UUID = "143d2b21-fdf0-4c5e-a9ef-f35ebbac8945"
+    GUEST_UUID_HSUM = \
+        "14b64203f5cf2afe520f8be0fdfe630aafc1e85d1301f55a0d1681e68881f3a2"
+
+    def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
+        self.require_accelerator("kvm")
+        self.require_netdev("vhost-user")
+        self.require_netdev("socket")
+        self.require_netdev("hubport")
+        self.require_netdev("user")
+        self.require_device("virtio-net-pci")
+        self.set_machine("q35")
+        self.vm.add_args(
+            "-cpu",      "host",
+            "-accel",    "kvm",
+            "-append",   "printk.time=0 console=ttyS0",
+            "-smp",      "2",
+            "-m",        "128M",
+            "-object",   "memory-backend-memfd,id=mem0,"
+                         "size=128M,share=on,prealloc=on",
+            "-numa",     "node,memdev=mem0",
+            "-chardev", f"socket,id=char0,path={ud_socket_path}",
+            "-netdev",   "vhost-user,id=vhost0,chardev=char0,vhostforce=on",
+            "-device",   "virtio-net-pci,netdev=vhost0",
+            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
+                        f"localaddr=localhost:{rport}",
+            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
+            "-netdev",   "user,id=user0,"
+                        f"hostfwd=tcp:127.0.0.1:{hostfwd_port}-:8080,"
+                        f"tftp={tftpdir}",
+            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
+        )
+
+    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
+        vubr_args = []
+
+        if (stdbuf_path := which("stdbuf")) is None:
+            self.log.info("Could not find stdbuf: vhost-user-bridge "
+                          "log lines may appear out of order")
+        else:
+            vubr_args += [stdbuf_path, "-o0", "-e0"]
+
+        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
+                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
+
+        return vubr_args
+
+    def test_vhost_user_bridge(self):
+        prompt = "~ # "
+        host_uuid_filename = "vubr-test-uuid.txt"
+        guest_uuid_path = "/tmp/uuid.txt"
+        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
+
+        vubr_path = self.build_file("contrib", "vhost-user-bridge",
+                                    "vhost-user-bridge")
+        if is_readable_executable_file(vubr_path) is None:
+            self.skipTest("Could not find a readable and executable "
+                          "vhost-user-bridge")
+
+        vubr_log_path = self.log_file("vhost-user-bridge.log")
+        self.log.info("For the vhost-user-bridge application log,"
+                     f" see: {vubr_log_path}")
+
+        sock_dir = self.socket_dir()
+        ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
+
+        tftpdir = self.scratch_file("tftp")
+        shutil.rmtree(tftpdir, ignore_errors=True)
+        os.mkdir(tftpdir)
+        host_uuid_path = self.scratch_file("tftp", host_uuid_filename)
+        with open(host_uuid_path, "w") as host_uuid_file:
+            host_uuid_file.write(self.HOST_UUID)
+
+        with Ports() as ports:
+            lport, rport, hostfwd_port = ports.find_free_ports(3)
+
+            self.configure_vm(ud_socket_path, lport, rport, hostfwd_port,
+                              tftpdir)
+
+            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
+                                                lport, rport)
+
+            with open(vubr_log_path, "w+") as vubr_log, \
+                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
+                                  stdout=vubr_log,
+                                  stderr=subprocess.STDOUT) as vubr_proc:
+                self.launch_kernel(kernel_path, wait_for=prompt)
+
+                exec_command_and_wait_for_pattern(self,
+                    f"tftp -g -r {host_uuid_filename} 10.0.2.2 ; "
+                    f"sha256sum {host_uuid_filename}", self.HOST_UUID_HSUM)
+                wait_for_console_pattern(self, prompt)
+
+                exec_command_and_wait_for_pattern(self,
+                    f"echo -n '{self.GUEST_UUID}' > {guest_uuid_path}", prompt)
+                self.check_http_download(guest_uuid_path, self.GUEST_UUID_HSUM)
+                wait_for_console_pattern(self, prompt)
+
+                self.vm.shutdown()
+                vubr_proc.terminate()
+                vubr_proc.wait()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.52.0


