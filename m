Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0434C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9Y-00036L-I5; Fri, 11 Sep 2026 05:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9Q-0002fP-NB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9M-00089z-JK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5biUd1hrE7MZBRCxmWFH37KE+WRWPVMF0xAnNQXGG3o=;
 b=Ebc6AlzKgwxfvy4iapxZ+8bYdLwawEPjk25oBC0ueK8Jcpj1z/tzs/grnbB5GzLDhwasH/
 AgKSDZTo9KMTnkC4fv8fPkx4UfzpB9SMYJjyXfDL/Ik5fd2zXY97lSlQ9d01IDo2qxlGdI
 3blls3ueNpnRtWF12+O7T0zQpD6DYbk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-4MZi78jfO7WnGV6DWMQ_Vw-1; Fri, 11 Sep 2026 05:02:19 -0400
X-MC-Unique: 4MZi78jfO7WnGV6DWMQ_Vw-1
X-Mimecast-MFC-AGG-ID: 4MZi78jfO7WnGV6DWMQ_Vw_1789117338
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so4976935e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117338; x=1789722138; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5biUd1hrE7MZBRCxmWFH37KE+WRWPVMF0xAnNQXGG3o=;
 b=HJ4IbE8jJmknF68BAGSwEhOnvsa/78EwceNCke6AlwJWKvz3C2+P9MK40IWROxF8cX
 U6ImqwJyZcyT1HOQ17N+Lrm5cSM79srPG+Mzt2FFtzEQK45WoDmmzpakxEyXYYL7P2bg
 sDX6X+6KFxXufDTIJCwEILQ5qdoiU1T7ZHec44M/evfLmxE7OtfgcrnnzwPY/REPAkFK
 1mXl0eDiycNX17gxOJZYFcnmoDvm9LNr7mtBSFTk9MSDlEa/P8LKveKBhTGS3xSNmK5x
 0w4muBrUNuwzb/BcvTJDE4eH15b002+7fpCx7H9fAv/swFBuui5M51y7hMTkLRj6bmwu
 2PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117338; x=1789722138;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5biUd1hrE7MZBRCxmWFH37KE+WRWPVMF0xAnNQXGG3o=;
 b=BDxMEqSf3u1PT0h3e+IqCaJiIlykU3l04hFAdEfpzwSxwoW+kYQo/Pw9IDHkR1OnRd
 dumsxE5UkrID+BvZtl8V5EL36gGgTL6UCvPVe/fZsbgK4fkSwGyo72C6sU3COYoYNvGf
 uz8XYxiw8Y1NzzbiUGx4oF3jetVknsxPJc67qFrXVlXwA6GulcJnqpuSoBngH3J0VWcD
 B7F6qw4uc9y9KSUXdx2ae2bs35tRPjmEaumBVMVO1K6VKXgyc8fyRCoOvp51IolQfdZM
 icYimyPm0wyweBKY3VaHtqN27OknTeW24dOr8bGmzgLM9axSLdHQGi9Cn6tLkIDVT9jQ
 g9GQ==
X-Gm-Message-State: AFuF++llVa47gmRObMp2NHe4QEuOzaDmX+CTADPGtphM1GaMxq1FHRlK
 S16RAs8HVXnys6YiDe+S2J0MJnyuijfDFpaShJFpXvCXpmRx3Q7k9eeGylgLsFCCRR0/nAHikw6
 lIdlqRo4sQs05OoTe4/8/gXZR+J/hfP0C8RyVN4UUJw55qz0zQTiPzg4eJW4GlOAhet0yV0K1P2
 4YZ6zhGEjDhyMxs91PkzKbw9EbBC9yxq7DfQ==
X-Gm-Gg: AYBFou0eJ9N65CwP/grLyvXvqmSHGvXz3drm2pGUoZGzfQvJMw8TMSyx/8KzkGO7ZBI
 L+vLBVWmm09kfkjWfz/S6xHqNd4FrDzLLlXIWopFwuyvSQaopq78B3hANLftXtp/SkyCFBZjHMn
 NYs/ePNYTYLlI8ctG2dlRcUia5CTUqPxyXOppwXfZD0npTSvWCqQeVBY1+NNGuWXfKjErnUqXqy
 n3poreBkFmG9SXlkihmlinNPPoUstl4EFRndp4QUwdALWPQJcV75JN5/p22wtgN9d0+6A0HVjJh
 CTQpGxoCA8DUvzGwv8Yepw+SD/qBewBTGn21B1Tz8tgiyFk92jhqce6L6L48j/9HtrEr87yhFuQ
 ea+mBtJiuDsc32iqadEzQE+U=
X-Received: by 2002:a05:600c:4f88:b0:49c:fa21:e742 with SMTP id
 5b1f17b1804b1-49e619ce757mr32581485e9.24.1789117337695; 
 Fri, 11 Sep 2026 02:02:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4f88:b0:49c:fa21:e742 with SMTP id
 5b1f17b1804b1-49e619ce757mr32580375e9.24.1789117336652; 
 Fri, 11 Sep 2026 02:02:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c300e2sm152070125e9.8.2026.09.11.02.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:16 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 24/75] tests/functional: add test_tap_migration
Message-ID: <88bba62b067f52e6c42f5a2a48e304c5e481ea85.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add test for a new local-migration migration of virtio-net/tap, with fd
passing through UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-17-vsementsov@yandex-team.ru>
---
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 461 ++++++++++++++++++
 2 files changed, 462 insertions(+)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e..6254149239 100644
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
index 0000000000..1e0d602518
--- /dev/null
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -0,0 +1,461 @@
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
+from typing import Tuple
+
+from qemu_test import (
+    LinuxKernelTest,
+    Asset,
+    exec_command_and_wait_for_pattern,
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
+        SYS_setns = 308
+        CLONE_NEWNET = 0x40000000
+        ret = libc.syscall(SYS_setns, fd, CLONE_NEWNET)
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
+def parse_ping_output(out) -> Tuple[bool, float, float]:
+    lines = [x for x in out.split("\n") if x.startswith("[")]
+
+    try:
+        first_no_ans = next(
+            (ind for ind in range(len(lines)) if lines[ind][20:26] == "no ans")
+        )
+    except StopIteration:
+        return False, parse_ping_line(lines[0]), parse_ping_line(lines[-1])
+
+    last_no_ans = next(
+        ind
+        for ind in range(len(lines) - 1, -1, -1)
+        if lines[ind][20:26] == "no ans"
+    )
+
+    return (
+        True,
+        parse_ping_line(lines[first_no_ans]),
+        parse_ping_line(lines[last_no_ans]),
+    )
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
+@skipWithoutSudo()
+class TAPFdMigration(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        (
+            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/vmlinuz"
+        ),
+        "d4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129",
+    )
+
+    ASSET_INITRD = Asset(
+        (
+            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/initrd.img"
+        ),
+        "277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b",
+    )
+
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
+        self.shm_path = None
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
+        with open(self.outer_ping_log, "w") as f:
+            self.outer_ping_proc = subprocess.Popen(
+                ["ping", "-i", "0", "-O", "-D", GUEST_IP],
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
+        with open(self.outer_ping_log) as f:
+            return f.read()
+
+    def stop_ping_and_check(self, stop_time, resume_time):
+        ping_res = self.stop_outer_ping()
+
+        discon, a, b = parse_ping_output(ping_res)
+
+        if not discon:
+            text = (
+                f"STOP: {stop_time}, RESUME: {resume_time}," f"PING: {a} - {b}"
+            )
+            if a > stop_time or b < resume_time:
+                self.fail(f"PING failed: {text}")
+            self.log.info(f"PING: no packets lost: {text}")
+            return
+
+        text = (
+            f"STOP: {stop_time}, RESUME: {resume_time},"
+            f"PING: disconnect: {a} - {b}"
+        )
+        self.log.info(text)
+        eps = 0.05
+        if a < stop_time - eps or b > resume_time + eps:
+            self.fail(text)
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
+        except Exception as e:
+            self.fail(f"Failed to create shared memory file: {e}")
+
+    def prepare_vm(
+        self, shm_path, vhost, incoming=False, vm=None, local=True
+    ):
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
+    def do_test_tap_fd_migration(self, vhost, local=True):
+        socket_dir = self.socket_dir()
+        mig_sock = os.path.join(socket_dir.name, "mig.sock")
+
+        # Setup second TAP if needed
+        if not local:
+            del_tap(TAP_ID2)
+            init_tap(TAP_ID2, with_ip=False)
+
+        self.prepare_vm(self.shm_path, vhost, local=local)
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
+        self.prepare_vm(
+            self.shm_path,
+            vhost,
+            incoming=True,
+            vm=target_vm,
+            local=local,
+        )
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
+        freeze_start = time.time()
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
+        freeze_end = time.time()
+
+        self.vm.shutdown()
+
+        self.log.info("Verifying PING on target VM after migration")
+        self.one_ping_from_guest(target_vm)
+        self.one_ping_from_host()
+
+        # And a bit more pings after source shutdown
+        time.sleep(0.3)
+        self.stop_ping_and_check(freeze_start, freeze_end)
+
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
MST


