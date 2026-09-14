Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFEEC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6At4-00051P-FJ; Mon, 14 Sep 2026 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6Asf-0004vB-0j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6AsX-0000Ih-GP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1d16:0:640:f28c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 30507C0ACD;
 Mon, 14 Sep 2026 20:53:56 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:a2b::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rrX9s30iEKo0-eKlKd2LG; Mon, 14 Sep 2026 20:53:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789408435;
 bh=xCrbn2dhFVtP0JzTAdE2S3sCGopvnDv2Q5b6BMTFkEc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RwA8HmQfT5+izHoAY6ej4Uk9m04UQkHe5StPamqnNrPK88IRUSj5jDSJ+hU23w/9i
 P7PN6X6nOtJyiekMgGJIQKjgcWKPKWHX7CnTF1n3HTwUIA1diuHRhBpSy035/GZbSC
 wiYZLtxOxq2zHNKe6GVZchoPVj39XVAMqIbEVhpU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 1/5] tests/functional: add test_tap_migration
Date: Mon, 14 Sep 2026 20:53:47 +0300
Message-ID: <20260914175351.393680-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914175351.393680-1-vsementsov@yandex-team.ru>
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add test for a new local-migration migration of virtio-net/tap, with fd
passing through UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
 2 files changed, 426 insertions(+)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..62541492397 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -51,4 +51,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'tap_migration',
 ]
diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
new file mode 100755
index 00000000000..a34bd94fd25
--- /dev/null
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -0,0 +1,425 @@
+#!/usr/bin/env python3
+#
+# Functional test that tests TAP local migration
+# with fd passing
+#
+# Copyright (c) Yandex Technologies LLC, 2026
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import subprocess
+from subprocess import run
+import signal
+import ctypes
+import ctypes.util
+import unittest
+from contextlib import contextmanager, ExitStack
+
+from qemu_test import (
+    LinuxKernelTest,
+    Asset,
+    exec_command_and_wait_for_pattern,
+    skipIfMissingCommands,
+)
+from qemu_test.decorators import skipWithoutSudo
+
+
+GUEST_IP = "192.168.100.2"
+GUEST_IP_MASK = f"{GUEST_IP}/24"
+GUEST_MAC = "d6:0d:75:f8:0f:b7"
+HOST_IP = "192.168.100.1"
+HOST_IP_MASK = f"{HOST_IP}/24"
+TAP_ID = "tap0"
+TAP_ID2 = "tap1"
+TAP_MAC = "e6:1d:44:b5:03:5d"
+NETNS = f"qemu_test_ns_{os.getpid()}"
+
+
+def ip(args, check=True) -> None:
+    """Run ip command with sudo"""
+    run(["sudo", "ip"] + args, check=check)
+
+
+@contextmanager
+def switch_netns(netns_name):
+    libc = ctypes.CDLL(ctypes.util.find_library("c"))
+    netns_path = f"/var/run/netns/{netns_name}"
+
+    def switch_to_fd(fd, check: bool = False):
+        """Switch to netns by file descriptor"""
+        sys_setns = 308
+        clone_newnet = 0x40000000
+        ret = libc.syscall(sys_setns, fd, clone_newnet)
+        if check and ret != 0:
+            raise RuntimeError("syscall SETNS failed")
+
+    with ExitStack() as stack:
+        original_netns_fd = os.open("/proc/self/ns/net", os.O_RDONLY)
+        stack.callback(os.close, original_netns_fd)
+
+        ip(["netns", "add", netns_name])
+        stack.callback(ip, ["netns", "del", netns_name], check=False)
+
+        new_netns_fd = os.open(netns_path, os.O_RDONLY)
+        stack.callback(os.close, new_netns_fd)
+
+        switch_to_fd(new_netns_fd)
+        stack.callback(switch_to_fd, original_netns_fd, check=False)
+
+        yield
+
+
+def del_tap(tap_name: str = TAP_ID) -> None:
+    ip(["tuntap", "del", tap_name, "mode", "tap", "multi_queue"], check=False)
+
+
+def init_tap(tap_name: str = TAP_ID, with_ip: bool = True) -> None:
+    ip(["tuntap", "add", "dev", tap_name, "mode", "tap", "multi_queue"])
+    if with_ip:
+        ip(["link", "set", "dev", tap_name, "address", TAP_MAC])
+        ip(["addr", "add", HOST_IP_MASK, "dev", tap_name])
+    ip(["link", "set", tap_name, "up"])
+
+
+def switch_network_to_tap2() -> None:
+    ip(["link", "set", TAP_ID2, "down"])
+    ip(["link", "set", TAP_ID, "down"])
+    ip(["addr", "delete", HOST_IP_MASK, "dev", TAP_ID])
+    ip(["link", "set", "dev", TAP_ID2, "address", TAP_MAC])
+    ip(["addr", "add", HOST_IP_MASK, "dev", TAP_ID2])
+    ip(["link", "set", TAP_ID2, "up"])
+
+
+def parse_ping_line(line: str) -> float:
+    # suspect lines like
+    # [1748524876.590509] 64 bytes from 94.245.155.3 \
+    #      (94.245.155.3): icmp_seq=1 ttl=250 time=101 ms
+    spl = line.split()
+    return float(spl[0][1:-1])
+
+
+def parse_ping_output(out) -> float:
+    lines = [x for x in out.split("\n") if x.startswith("[")]
+
+    max_gap = 0.0
+    prev_timestamp = None
+
+    for line in lines:
+        if "no ans" not in line:
+            # This is a successful ping line
+            try:
+                timestamp = parse_ping_line(line)
+                if prev_timestamp is not None:
+                    gap = timestamp - prev_timestamp
+                    if gap > max_gap:
+                        max_gap = gap
+                prev_timestamp = timestamp
+            except (IndexError, ValueError):
+                # Skip malformed lines
+                continue
+
+    assert prev_timestamp is not None, "No successful pings found"
+    assert max_gap > 0.0, "Need at least two successful pings to calculate gap"
+
+    return max_gap
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
+@skipIfMissingCommands("ip", "ping")
+@skipWithoutSudo()
+class TAPFdMigration(LinuxKernelTest):
+    ASSET_ALPINE_ISO = Asset(
+        (
+            "https://dl-cdn.alpinelinux.org/"
+            "alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"
+        ),
+        "96d1b44ea1b8a5a884f193526d92edb4676054e9fa903ad2f016441a0fe13089",
+    )
+
+    @classmethod
+    def setUpClass(cls):
+        super().setUpClass()
+
+        # The test namespace has no external connectivity.
+        cls.ASSET_ALPINE_ISO.fetch()
+
+        try:
+            cls.netns_context = switch_netns(NETNS)
+            cls.netns_context.__enter__()
+        except (OSError, subprocess.CalledProcessError) as e:
+            raise unittest.SkipTest(f"can't switch network namespace: {e}")
+
+    @classmethod
+    def tearDownClass(cls):
+        if hasattr(cls, "netns_context"):
+            cls.netns_context.__exit__(None, None, None)
+        super().tearDownClass()
+
+    def setUp(self):
+        super().setUp()
+
+        self.require_accelerator("kvm")
+        self.set_machine("q35")
+
+        self.setup_shared_memory()
+
+        init_tap()
+
+        self.outer_ping_proc = None
+
+    def tearDown(self):
+        with ExitStack() as stack:
+            stack.callback(super().tearDown)
+
+            if self.shm_path:
+                stack.callback(lambda p: (os.unlink(p) if os.path.exists(p)
+                                         else None),
+                               self.shm_path)
+                self.shm_path = None
+
+            stack.callback(del_tap, TAP_ID2)
+            stack.callback(del_tap, TAP_ID)
+
+            if self.outer_ping_proc:
+                self.stop_outer_ping()
+
+    def start_outer_ping(self) -> None:
+        assert self.outer_ping_proc is None
+        self.outer_ping_log = self.scratch_file("ping.log")
+        with open(self.outer_ping_log, "w", encoding="utf-8") as f:
+            self.outer_ping_proc = subprocess.Popen(
+                ["sudo", "ping", "-i", "0", "-O", "-D", GUEST_IP],
+                text=True,
+                stdout=f,
+            )
+
+    def stop_outer_ping(self) -> str:
+        assert self.outer_ping_proc
+        self.outer_ping_proc.send_signal(signal.SIGINT)
+
+        self.outer_ping_proc.communicate(timeout=5)
+        self.outer_ping_proc = None
+
+        with open(self.outer_ping_log, encoding="utf-8") as f:
+            return f.read()
+
+    def stop_ping_and_check(self):
+        ping_res = self.stop_outer_ping()
+
+        disconnect_time = parse_ping_output(ping_res)
+        if disconnect_time > 0.5:
+            self.fail(f"long disconnect time: {disconnect_time}")
+
+    def one_ping_from_guest(self, vm) -> None:
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ping -c 1 -W 1 {HOST_IP}",
+            "1 packets transmitted, 1 packets received",
+            "1 packets transmitted, 0 packets received",
+            vm=vm,
+        )
+        self.wait_for_console_pattern("# ", vm=vm)
+
+    def one_ping_from_host(self) -> None:
+        run(
+            ["ping", "-c", "1", "-W", "1", GUEST_IP],
+            stdout=subprocess.DEVNULL,
+            check=True,
+        )
+
+    def setup_shared_memory(self):
+        self.shm_path = f"/dev/shm/qemu_test_{os.getpid()}"
+
+        try:
+            with open(self.shm_path, "wb") as f:
+                f.write(b"\0" * (1024 * 1024 * 1024))  # 1GB
+        except OSError as e:
+            self.fail(f"Failed to create shared memory file: {e}")
+
+    def prepare_vm(self, vm, shm_path, incoming):
+        if not vm:
+            vm = self.vm
+
+        vm.set_console()
+        vm.add_args("-accel", "kvm")
+        vm.add_args("-device", "pcie-pci-bridge,id=pci.1,bus=pcie.0")
+        vm.add_args("-m", "1G")
+        vm.add_args("-net", "none")
+
+        vm.add_args(
+            "-object",
+            f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
+        )
+        vm.add_args("-machine", "memory-backend=ram0")
+
+        vm.add_args(
+            "-drive",
+            f"file={self.ASSET_ALPINE_ISO.fetch()},media=cdrom,format=raw",
+        )
+
+        vm.add_args("-S")
+
+        if incoming:
+            vm.add_args("-incoming", "defer")
+
+    def add_virtio_net(
+        self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
+    ):
+        netdev_params = {
+            "id": "netdev.1",
+            "vhost": vhost,
+            "type": "tap",
+            "queues": 4,
+            "script": "no",
+            "downscript": "no",
+            "x-permit-local-migration": local,
+        }
+
+        if not (local and incoming):
+            netdev_params["vnet_hdr"] = True
+            netdev_params["ifname"] = tap_name
+
+        vm.cmd("netdev_add", netdev_params)
+
+        vm.cmd(
+            "device_add",
+            driver="virtio-net-pci",
+            romfile="",
+            id="vnet.1",
+            netdev="netdev.1",
+            mq=True,
+            vectors=18,
+            bus="pci.1",
+            mac=GUEST_MAC,
+            disable_legacy="off",
+        )
+
+    def set_migration_capabilities(self, vm, local):
+        vm.cmd(
+            "migrate-set-capabilities",
+            {
+                "capabilities": [
+                    {"capability": "events", "state": True},
+                    {"capability": "x-ignore-shared", "state": True},
+                ]
+            },
+        )
+        vm.cmd("migrate-set-parameters", {"local": local})
+
+    def setup_guest_network(self) -> None:
+        exec_command_and_wait_for_pattern(self, "ip addr", "# ")
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ip addr add {GUEST_IP_MASK} dev eth0 && "
+            "ip link set eth0 up && echo OK",
+            "OK",
+        )
+        self.wait_for_console_pattern("# ")
+
+    def migrate(self, vm, mig_sock):
+        vm.cmd("migrate", uri=f"unix:{mig_sock}")
+
+    def do_test_tap_fd_migration(self, vhost, local=True):
+        socket_dir = self.socket_dir()
+        mig_sock = os.path.join(socket_dir.name, "mig.sock")
+
+        # Setup second TAP if needed
+        if not local:
+            del_tap(TAP_ID2)
+            init_tap(TAP_ID2, with_ip=False)
+
+        self.prepare_vm(self.vm, self.shm_path, False)
+        self.vm.launch()
+        self.set_migration_capabilities(self.vm, local=local)
+        self.add_virtio_net(self.vm, vhost, TAP_ID, local, incoming=False)
+
+        self.vm.cmd("cont")
+        self.wait_for_console_pattern("login:")
+        exec_command_and_wait_for_pattern(self, "root", "# ")
+
+        self.setup_guest_network()
+
+        self.one_ping_from_guest(self.vm)
+        self.one_ping_from_host()
+        self.start_outer_ping()
+
+        # Get some successful pings before migration
+        time.sleep(0.5)
+
+        target_vm = self.get_vm(name="target")
+        self.prepare_vm(target_vm, self.shm_path, True)
+
+        target_vm.launch()
+        if not local:
+            tap_name = TAP_ID2
+        else:
+            tap_name = TAP_ID
+        self.set_migration_capabilities(target_vm, local=local)
+        self.add_virtio_net(target_vm, vhost, tap_name, local, incoming=True)
+
+        target_vm.cmd("migrate-incoming", {"uri": f"unix:{mig_sock}"})
+
+        self.log.info("Starting migration")
+        self.migrate(self.vm, mig_sock)
+
+        self.log.info("Waiting for migration completion")
+        wait_migration_finish(self.vm, target_vm)
+
+        # Switch network to tap1 if not using local-migration
+        if not local:
+            switch_network_to_tap2()
+
+        target_vm.cmd("cont")
+
+        self.log.info("Verifying PING on target VM after migration")
+
+        # Keep the stopped source alive while checking the target.
+        time.sleep(0.3)
+        self.stop_ping_and_check()
+
+        self.one_ping_from_guest(target_vm)
+        self.one_ping_from_host()
+
+        self.vm.shutdown()
+        target_vm.shutdown()
+
+    def test_tap_fd_migration(self):
+        self.do_test_tap_fd_migration(False)
+
+    def test_tap_fd_migration_vhost(self):
+        self.do_test_tap_fd_migration(True)
+
+    def test_tap_new_tap_migration(self):
+        self.do_test_tap_fd_migration(False, local=False)
+
+    def test_tap_new_tap_migration_vhost(self):
+        self.do_test_tap_fd_migration(True, local=False)
+
+
+if __name__ == "__main__":
+    LinuxKernelTest.main()
-- 
2.43.0


