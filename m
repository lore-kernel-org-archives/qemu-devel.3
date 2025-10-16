Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F5BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNf-0007WI-A7; Thu, 16 Oct 2025 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MN0-0007B8-52; Thu, 16 Oct 2025 07:42:14 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMt-0003Wb-ER; Thu, 16 Oct 2025 07:42:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5E24BC01E8;
 Thu, 16 Oct 2025 14:41:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-j6aB0vES; Thu, 16 Oct 2025 14:41:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614902;
 bh=HFE8QjC8Rnlm0okx70mpoOdoiRgantXWnrfbocdxBfk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VESwroG5eUtyHBICBfrKSGq1v/Rn3VzMJ/Pp3J6IPMXgIaOi+1wk74VRaDGHio6FQ
 QxsMo4VjTPaTLrSZdkCfKFbQhks+uWPIjSwEpyTA3VWk4o7rt0prp/ipJuiltADLE4
 abzylGXg0AXjCKTLzHF+rm0SgdMh6B3aS14vSjbY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 25/25] tests/functional: add
 test_x86_64_vhost_user_blk_fd_migration.py
Date: Thu, 16 Oct 2025 14:41:02 +0300
Message-ID: <20251016114104.1384675-26-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Introduce a simple test to check that local migration of vhost-user-blk
device with passing open fds through unix socket works, and the disk
is still working on target.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 ...test_x86_64_vhost_user_blk_fd_migration.py | 307 ++++++++++++++++++
 1 file changed, 307 insertions(+)
 create mode 100644 tests/functional/test_x86_64_vhost_user_blk_fd_migration.py

diff --git a/tests/functional/test_x86_64_vhost_user_blk_fd_migration.py b/tests/functional/test_x86_64_vhost_user_blk_fd_migration.py
new file mode 100644
index 0000000000..0523a71f15
--- /dev/null
+++ b/tests/functional/test_x86_64_vhost_user_blk_fd_migration.py
@@ -0,0 +1,307 @@
+#!/usr/bin/env python3
+#
+# Functional test that tests vhost-user-blk local migration
+# with fd passing
+#
+# Copyright (c) Yandex
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import subprocess
+
+from qemu_test import (
+    LinuxKernelTest,
+    Asset,
+    exec_command_and_wait_for_pattern,
+)
+
+
+def wait_migration_finish(source_vm, target_vm):
+    migr_events = (
+        ("MIGRATION", {"data": {"status": "completed"}}),
+        ("MIGRATION", {"data": {"status": "failed"}}),
+    )
+
+    source_e = source_vm.events_wait(migr_events)["data"]
+    target_e = target_vm.events_wait(migr_events)["data"]
+
+    source_s = source_vm.cmd("query-status")["status"]
+    target_s = target_vm.cmd("query-status")["status"]
+
+    assert (
+        source_e["status"] == "completed"
+        and target_e["status"] == "completed"
+        and source_s == "postmigrate"
+        and target_s == "paused"
+    ), f"""Migration failed:
+    SRC status: {source_s}
+    SRC event: {source_e}
+    TGT status: {target_s}
+    TGT event:{target_e}"""
+
+
+class VhostUserBlkFdMigration(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        (
+            "https://archives.fedoraproject.org/"
+            "pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/vmlinuz"
+        ),
+        "d4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129",
+    )
+
+    ASSET_INITRD = Asset(
+        (
+            "https://archives.fedoraproject.org/"
+            "pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/initrd.img"
+        ),
+        "277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b",
+    )
+
+    DATA1 = "TEST_DATA_BEFORE_MIGRATION_12345"
+    DATA2 = "TEST_DATA_AFTER_MIGRATION_54321"
+
+    def write_data(self, data, vm) -> None:
+        exec_command_and_wait_for_pattern(
+            self,
+            f'echo "{data}" | ' "dd of=/dev/vda bs=512 count=1 oflag=direct",
+            "# ",
+            vm=vm,
+        )
+
+    def read_data(self, data, vm) -> None:
+        exec_command_and_wait_for_pattern(
+            self,
+            "dd if=/dev/vda bs=512 count=1 iflag=direct 2>/dev/null",
+            data,
+            vm=vm,
+        )
+
+    def setUp(self):
+        super().setUp()
+        self.vhost_procs = []
+
+    def tearDown(self):
+        # Cleanup vhost-user server processes
+        for proc in self.vhost_procs:
+            if proc:
+                try:
+                    proc.terminate()
+                    proc.wait(timeout=5)
+                except subprocess.TimeoutExpired:
+                    proc.kill()
+                    proc.wait()
+                except:
+                    pass
+
+        super().tearDown()
+
+    def create_test_image(self):
+        """Create a temporary test image for vhost-user-blk"""
+        img_path = self.scratch_file("disk.img")
+
+        # Create 64MB image
+        with open(img_path, "wb") as f:
+            f.write(b"\0" * (64 * 1024 * 1024))
+
+        return img_path
+
+    def start_vhost_user_server(self, socket_path, img_path):
+        """Start vhost-user-blk server using contrib/vhost-user-blk"""
+        # Find vhost-user-blk binary
+        vub_binary = self.build_file(
+            "contrib", "vhost-user-blk", "vhost-user-blk"
+        )
+
+        if not os.path.isfile(vub_binary) or not os.access(vub_binary, os.X_OK):
+            self.skipTest("vhost-user-blk binary not found")
+
+        # assert that our further waiting would be correct
+        self.assertFalse(os.path.exists(socket_path))
+
+        cmd = [vub_binary, "-s", socket_path, "-b", img_path]
+        self.log.info(f'Starting vhost-user server: {" ".join(cmd)}')
+        proc = subprocess.Popen(
+            cmd, stderr=subprocess.PIPE, text=True, preexec_fn=os.setsid
+        )
+        self.vhost_procs.append(proc)
+
+        # Wait for socket to be created
+        for _ in range(100):  # 10 seconds timeout
+            time.sleep(0.1)
+
+            # Check if process is still running
+            if proc.poll() is not None:
+                self.fail(f"vhost-user server failed: {proc.stderr}")
+
+            if os.path.exists(socket_path):
+                return
+
+        self.fail(f"vhost-user socket {socket_path} was not created")
+
+    def setup_shared_memory(self):
+        shm_path = f"/dev/shm/qemu_test_{os.getpid()}"
+
+        try:
+            with open(shm_path, "wb") as f:
+                f.write(b"\0" * (1024 * 1024 * 1024))  # 1GB
+        except Exception as e:
+            self.fail(f"Failed to create shared memory file: {e}")
+
+        return shm_path
+
+    def prepare_and_launch_vm(
+        self,
+        shm_path,
+        vhost_socket,
+        incoming=False,
+        vm=None,
+        use_backend_transfer=True,
+    ):
+        if not vm:
+            vm = self.vm
+
+        vm.add_args("-accel", "kvm")
+        vm.add_args("-device", "pcie-pci-bridge,id=pci.1,bus=pcie.0")
+        vm.add_args("-m", "1G")
+        vm.add_args("-append", "console=ttyS0 rd.rescue")
+
+        vm.add_args(
+            "-object",
+            f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
+        )
+        vm.add_args("-machine", "memory-backend=ram0")
+
+        vm.add_args("-kernel", self.ASSET_KERNEL.fetch())
+        vm.add_args("-initrd", self.ASSET_INITRD.fetch())
+
+        vm.add_args("-S")
+
+        if incoming:
+            vm.add_args("-incoming", "defer")
+
+        vm.set_console()
+
+        vm_s = "target" if incoming else "source"
+        self.log.info(f"Launching {vm_s} VM")
+        vm.launch()
+
+        self.set_migration_capabilities(vm, use_backend_transfer)
+        self.add_vhost_user_blk_device(vm, vhost_socket)
+
+    def add_vhost_user_blk_device(self, vm, socket_path):
+        # Add chardev
+        chardev_params = {
+            "id": "chardev-virtio-disk0",
+            "backend": {
+                "type": "socket",
+                "data": {
+                    "addr": {"type": "unix", "data": {"path": socket_path}},
+                    "server": False,
+                    "reconnect-ms": 20,
+                },
+            },
+        }
+
+        vm.cmd("chardev-add", chardev_params)
+
+        # Add device
+        device_params = {
+            "id": "virtio-disk0",
+            "driver": "vhost-user-blk-pci",
+            "chardev": "chardev-virtio-disk0",
+            "num-queues": 1,
+            "bus": "pci.1",
+            "config-wce": False,
+            "bootindex": 1,
+            "disable-legacy": "off",
+        }
+
+        vm.cmd("device_add", device_params)
+
+    def set_migration_capabilities(self, vm, use_backend_transfer=True):
+        capabilities = [
+            {"capability": "events", "state": True},
+            {"capability": "x-ignore-shared", "state": True},
+        ]
+
+        if use_backend_transfer:
+            capabilities.append(
+                {"capability": "local-vhost-user-blk", "state": True}
+            )
+
+        vm.cmd("migrate-set-capabilities", {"capabilities": capabilities})
+
+    def do_test_vhost_user_blk_fd_migration(self, use_backend_transfer=True):
+        self.require_accelerator("kvm")
+        self.set_machine("q35")
+
+        socket_dir = self.socket_dir()
+        vhost_socket = os.path.join(socket_dir.name, "vhost-user-blk.sock")
+        migration_socket = os.path.join(socket_dir.name, "migration.sock")
+
+        img_path = self.create_test_image()
+        shm_path = self.setup_shared_memory()
+
+        self.start_vhost_user_server(vhost_socket, img_path)
+
+        if not use_backend_transfer:
+            target_vhost_socket = os.path.join(
+                socket_dir.name, "vhost-user-blk-target.sock"
+            )
+            self.start_vhost_user_server(target_vhost_socket, img_path)
+        else:
+            target_vhost_socket = vhost_socket
+
+        self.prepare_and_launch_vm(
+            shm_path, vhost_socket, use_backend_transfer=use_backend_transfer
+        )
+        self.vm.cmd("cont")
+        self.wait_for_console_pattern("Entering emergency mode.")
+        self.wait_for_console_pattern("# ")
+
+        self.write_data(self.DATA1, self.vm)
+        self.read_data(self.DATA1, self.vm)
+
+        target_vm = self.get_vm(name="target")
+        self.prepare_and_launch_vm(
+            shm_path,
+            target_vhost_socket,
+            incoming=True,
+            vm=target_vm,
+            use_backend_transfer=use_backend_transfer,
+        )
+
+        target_vm.cmd("migrate-incoming", {"uri": f"unix:{migration_socket}"})
+
+        self.log.info("Starting migration")
+        self.vm.cmd("migrate", {"uri": f"unix:{migration_socket}"})
+
+        self.log.info("Waiting for migration completion")
+        wait_migration_finish(self.vm, target_vm)
+
+        target_vm.cmd("cont")
+        self.vm.shutdown()
+
+        self.log.info("Verifying disk on target VM after migration")
+        self.read_data(self.DATA1, target_vm)
+        self.write_data(self.DATA2, target_vm)
+        self.read_data(self.DATA2, target_vm)
+
+        target_vm.shutdown()
+
+    def test_vhost_user_blk_fd_migration_backend_transfer(self):
+        """Test vhost-user-blk migration with backend-transfer (fd passing)"""
+        self.do_test_vhost_user_blk_fd_migration(use_backend_transfer=True)
+
+    def test_vhost_user_blk_fd_migration_regular(self):
+        """Test vhost-user-blk migration without backend-transfer"""
+        self.do_test_vhost_user_blk_fd_migration(use_backend_transfer=False)
+
+
+if __name__ == "__main__":
+    LinuxKernelTest.main()
-- 
2.48.1


