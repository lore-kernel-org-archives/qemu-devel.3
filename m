Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFCFE94102
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNZs-0006ne-Sf; Mon, 29 Dec 2025 19:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vaNZr-0006nR-W0
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:27:08 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vaNZp-0008LB-P4
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:27:07 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6e29256320fa0ae6e54e3421e727591f0044dfe291002258f61f642f0e7a5a3c with SMTP id
 69531c4f9ead11955ae48fc9; Tue, 30 Dec 2025 00:26:55 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1767054413;
 bh=oNl4OQ5ttFUEus0IenPa3rXuPfOoRXpNY3TcSoLp4Ks=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=d0aDjYAuHYQlOVffL9GQ/9WvWhOn1yBDtNdi/uNF6tKlSN3FQvgm5bmuTvMq5wnzI
 Pr5dgkqmtzplyvhbwZ3wRmnl07bRsOv9o+kct/Sjilbkp3kewx0CXMM4OifO9fu7P2
 TWTBUsTUzbmDpq0R4Nt6PqJAM6Bm1ueDw18H1gPTXfiZnxMbiSY+nNt57TdI6VwkPr
 g50d8v3HTr08cvCXauMkyHCkz+6/LX4GosdQeyKeAx+kpDJ6hGozx0JJ22nyOsbZ7O
 sJD0g6guCgcLV2xzS8jQOejJ8k0VFpFMQBEI5XvAUOVekZq2eTukSFtCH11CQeA2fi
 p1YOhN4JgXZWw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
Date: Mon, 29 Dec 2025 18:25:54 -0600
Message-ID: <20251230002604.113632-1-yodel.eldar@yodel.dev>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This introduces a functional test of vhost-user-bridge.

The test runs vhost-user-bridge and launches a guest VM that connects
to the internet through it. The test succeeds if and only if an attempt
to connect to a hard-coded well-known URL succeeds.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---

This patch introduces a functional test of vhost-user-bridge by
automating the testing described in its initial commit, 8e3b0cbb72,
with adjustments like using hubports (formerly the vlan parameter) and
memfd for the memory backend; hugepages are also omitted to avoid
requiring root privileges on the host.

The test configures networking within the guest by invoking udhcpc, then
makes an http request via wget to a well-known URL, example.org, that
has a low risk of requiring https for connections (a limitation of the
the test). An assert on the retcode of wget determines success/failure.

Please let me know if there are objections to the use of wget's retcode
as the test's condition; determining wget success through its output is
straightforward ("remote file exists"), but out of concern of some
unknown failure message (besides "bad address") locking up the test,
I've resorted to checking the retcode instead; perhaps, this violates
some convention?

Also, I figured checking for memfd support on the host was unnecessary
in 2026 for the intended users of the test, but perhaps not?

The guest's kernel contains an integrated initramfs and was built with
buildroot; an attempt to ensure bit-for-bit reproducibility was made by
building it via Containerfile based on a snapshot container image and
use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
is "experimental," so future builds may differ slightly (though the
image in the repo will be left untouched). The image and associated
build files are hosted on my personal account here:
	https://github.com/yodel/vhost-user-bridge-test
and will continue to be well into the future, but if there's some other
preferred location for the asset, please let me know?

Lastly, special thanks to Cédric for inspiring me to write the test in
"<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".

Thanks,
Yodel

 .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py

diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
new file mode 100755
index 0000000000..61afdbceec
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -0,0 +1,124 @@
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
+        b) Instantiate a vhost-user net backend on top of that socket
+        c) Expose vhost-user with a virtio-net-pci interface
+        d) Instantiate UDP socket and user-mode net backends
+        e) Hub the UDP and user-mode backends
+    3) Run udhcpc in the guest to auto-configure networking.
+    4) Run wget in the guest and check its retcode to test internet connectivity
+
+The test fails if wget returns 1 and succeeds on 0.
+"""
+
+import os
+import subprocess
+from qemu_test import Asset, QemuSystemTest, which
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
+from qemu_test import wait_for_console_pattern
+from qemu_test.ports import Ports
+
+class VhostUserBridge(QemuSystemTest):
+
+    ASSET_KERNEL_INITRAMFS = Asset(
+        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
+        "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
+
+    def configure_vm(self, ud_socket_path, lport, rport):
+        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
+
+        self.require_accelerator("kvm")
+        self.require_netdev("vhost-user")
+        self.require_netdev("socket")
+        self.require_netdev("hubport")
+        self.require_netdev("user")
+        self.require_device("virtio-net-pci")
+        self.set_machine("q35")
+        self.vm.set_console()
+        self.vm.add_args(
+            "-cpu",      "host",
+            "-accel",    "kvm",
+            "-kernel",   kernel_path,
+            "-append",   "console=ttyS0",
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
+            "-netdev",   "user,id=user0",
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
+
+        vubr_path = self.build_file("tests", "vhost-user-bridge")
+        if is_readable_executable_file(vubr_path) is None:
+            self.skipTest("Could not find a readable and executable "
+                          "vhost-user-bridge")
+
+        with Ports() as ports:
+            sock_dir = self.socket_dir()
+            ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
+            lport, rport = ports.find_free_ports(2)
+
+            self.configure_vm(ud_socket_path, lport, rport)
+
+            vubr_log_path = self.log_file("vhost-user-bridge.log")
+            self.log.info("For the vhost-user-bridge application log,"
+                         f" see: {vubr_log_path}")
+
+            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
+                                                lport, rport)
+
+            with open(vubr_log_path, "w") as vubr_log, \
+                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
+                                  stdout=vubr_log, stderr=subprocess.STDOUT):
+                self.vm.launch()
+
+                wait_for_console_pattern(self, prompt)
+                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1", prompt)
+                exec_command_and_wait_for_pattern(self,
+                    "wget -qT 2 --spider example.org", prompt)
+
+                try:
+                    exec_command_and_wait_for_pattern(self, "echo $?", "0", "1")
+                except AssertionError:
+                    self.log.error("Unable to confirm internet connectivity")
+                    raise
+                finally:
+                    self.vm.shutdown()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.52.0


