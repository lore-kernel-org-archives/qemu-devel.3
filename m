Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C1C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0dq-000597-JK; Wed, 29 Jul 2026 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0do-000587-Ny
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:56 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dm-0007lB-Da
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 2F34AC0A64;
 Wed, 29 Jul 2026 12:31:53 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-huxt7y0S; Wed, 29 Jul 2026 12:31:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317512;
 bh=HV1FoDOcQbL4SYo01gnQ0Qs8H49RoCdBT7iobhWM0SM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qnqDX3uizmBn29bpmrKL9B+NOgQRV3iW6wQIberN/ELWtIajmyiR22r5HCOVFOsUF
 ATJUPqDaJ4UB5yuKKmyTSyoiWq/3oYNxmPVJPQZxGpPYrz97fGl7k1dgnR5zh2HPpN
 sYjXADdN83tf3rgBS9plmc61aSmcwAuNSGjrALq8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/5] test_tap_migration: add cpr test cases
Date: Wed, 29 Jul 2026 12:31:45 +0300
Message-ID: <20260729093146.1893719-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/x86_64/test_tap_migration.py | 251 ++++++++++++++++--
 1 file changed, 230 insertions(+), 21 deletions(-)

diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
index 0506b01926e..103421a029a 100755
--- a/tests/functional/x86_64/test_tap_migration.py
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -24,6 +24,7 @@
     exec_command_and_wait_for_pattern,
 )
 from qemu_test.decorators import skipWithoutSudo
+from qemu.qmp.legacy import QEMUMonitorProtocol
 
 
 GUEST_IP = "192.168.100.2"
@@ -289,7 +290,8 @@ def setup_shared_memory(self):
             self.fail(f"Failed to create shared memory file: {e}")
 
     def prepare_vm(
-        self, shm_path, vhost, incoming=False, vm=None, local=True
+        self, shm_path, vhost, incoming=False, vm=None, local=True,
+        cpr=False, cpr_sock=""
     ):
         if not vm:
             vm = self.vm
@@ -304,7 +306,10 @@ def prepare_vm(
             "-object",
             f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
         )
-        vm.add_args("-machine", "memory-backend=ram0")
+        machine_opt = "memory-backend=ram0"
+        if cpr:
+            machine_opt += ",aux-ram-share=on"
+        vm.add_args("-machine", machine_opt)
 
         vm.add_args(
             "-drive",
@@ -315,6 +320,13 @@ def prepare_vm(
 
         if incoming:
             vm.add_args("-incoming", "defer")
+            if cpr:
+                vm.add_args(
+                    "-incoming",
+                    '{"channel-type": "cpr", '
+                    '"addr": {"transport": "socket", '
+                    f'"type": "unix", "path": "{cpr_sock}"}}}}',
+                )
 
     def add_virtio_net(
         self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
@@ -348,7 +360,7 @@ def add_virtio_net(
             disable_legacy="off",
         )
 
-    def set_migration_capabilities(self, vm, local):
+    def set_migration_capabilities(self, vm, local, mode):
         vm.cmd(
             "migrate-set-capabilities",
             {
@@ -358,7 +370,10 @@ def set_migration_capabilities(self, vm, local):
                 ]
             },
         )
-        vm.cmd("migrate-set-parameters", {"local": local})
+        vm.cmd(
+            "migrate-set-parameters",
+            {"local": local, "mode": mode},
+        )
 
     def setup_guest_network(self) -> None:
         exec_command_and_wait_for_pattern(self, "ip addr", "# ")
@@ -370,20 +385,51 @@ def setup_guest_network(self) -> None:
         )
         self.wait_for_console_pattern("# ")
 
-    def migrate(self, vm, mig_sock):
-        vm.cmd("migrate", uri=f"unix:{mig_sock}")
-    def do_test_tap_fd_migration(self, vhost, local=True):
+    def migrate(self, vm, mig_sock, cpr=False, cpr_sock=""):
+        if cpr:
+            vm.cmd(
+                "migrate",
+                {
+                    "channels": [
+                        {
+                            "channel-type": "main",
+                            "addr": {
+                                "transport": "socket",
+                                "type": "unix",
+                                "path": mig_sock,
+                            },
+                        },
+                        {
+                            "channel-type": "cpr",
+                            "addr": {
+                                "transport": "socket",
+                                "type": "unix",
+                                "path": cpr_sock,
+                            },
+                        },
+                    ]
+                },
+            )
+        else:
+            vm.cmd("migrate", uri=f"unix:{mig_sock}")
+
+    def do_test_tap_fd_migration(self, vhost, local=True,
+                                 cpr=False):
+        mig_mode = "cpr-transfer" if cpr else "normal"
+
         socket_dir = self.socket_dir()
         mig_sock = os.path.join(socket_dir.name, "mig.sock")
+        cpr_sock = os.path.join(socket_dir.name, "cpr.sock")
 
         # Setup second TAP if needed
         if not local:
             del_tap(TAP_ID2)
             init_tap(TAP_ID2, with_ip=False)
 
-        self.prepare_vm(self.shm_path, vhost, local=local)
+        self.prepare_vm(self.shm_path, vhost, local=local, cpr=cpr,
+                        cpr_sock=cpr_sock)
         self.vm.launch()
-        self.set_migration_capabilities(self.vm, local=local)
+        self.set_migration_capabilities(self.vm, local=local, mode=mig_mode)
         self.add_virtio_net(self.vm, vhost, TAP_ID, local, incoming=False)
 
         self.vm.cmd("cont")
@@ -406,21 +452,53 @@ def do_test_tap_fd_migration(self, vhost, local=True):
             incoming=True,
             vm=target_vm,
             local=local,
+            cpr=cpr,
+            cpr_sock=cpr_sock,
         )
 
-        target_vm.launch()
-        if not local:
-            tap_name = TAP_ID2
+        if cpr:
+            # Launch target QEMU process; it will block in cpr_state_load()
+            # waiting for the source to connect and send CPR state.  QMP is
+            # not available until after CPR state is loaded.
+            target_vm.launch(do_qmp_connect=False)
+            time.sleep(1)
+
+            # Tell source to start CPR migration; it connects to the CPR
+            # socket, sends CPR state, then target unblocks and QMP becomes
+            # available.
+            self.migrate(self.vm, mig_sock, True, cpr_sock=cpr_sock)
+
+            # Now block waiting for target QMP greeting; it will arrive once
+            # the CPR state transfer completes.
+            target_vm.launch(do_start_process=False, do_qmp_connect=True)
+
+            if not local:
+                tap_name = TAP_ID2
+            else:
+                tap_name = TAP_ID
+            self.set_migration_capabilities(target_vm, local=local,
+                                            mode="cpr-transfer")
+            self.add_virtio_net(target_vm, vhost, tap_name, local,
+                                incoming=True)
+
+            freeze_start = time.time()
+            target_vm.cmd("migrate-incoming", {"uri": f"unix:{mig_sock}"})
         else:
-            tap_name = TAP_ID
-        self.set_migration_capabilities(target_vm, local=local)
-        self.add_virtio_net(target_vm, vhost, tap_name, local, incoming=True)
-
-        target_vm.cmd("migrate-incoming", {"uri": f"unix:{mig_sock}"})
-
-        self.log.info("Starting migration")
-        freeze_start = time.time()
-        self.migrate(self.vm, mig_sock)
+            target_vm.launch()
+            if not local:
+                tap_name = TAP_ID2
+            else:
+                tap_name = TAP_ID
+            self.set_migration_capabilities(target_vm, local=local,
+                                            mode="normal")
+            self.add_virtio_net(target_vm, vhost, tap_name, local,
+                                incoming=True)
+
+            target_vm.cmd("migrate-incoming", {"uri": f"unix:{mig_sock}"})
+
+            self.log.info("Starting migration")
+            freeze_start = time.time()
+            self.migrate(self.vm, mig_sock)
 
         self.log.info("Waiting for migration completion")
         wait_migration_finish(self.vm, target_vm)
@@ -444,6 +522,119 @@ def do_test_tap_fd_migration(self, vhost, local=True):
 
         target_vm.shutdown()
 
+    def do_test_tap_cpr_exec_migration(self, vhost):
+        socket_dir = self.socket_dir()
+        mig_file = self.scratch_file("migstate")
+
+        # Source VM: use a UNIX socket path for QMP so that the exec'ed
+        # new QEMU process can reconnect to the same monitor socket.
+        qmp_sock = os.path.join(socket_dir.name, "qmp.sock")
+        self.get_vm(name="default", monitor_address=qmp_sock)
+        self.prepare_vm(self.shm_path, vhost, local=True,
+                                   cpr=True)
+        self.vm.launch()
+        self.set_migration_capabilities(self.vm, local=True, mode="cpr-exec")
+        self.add_virtio_net(self.vm, vhost, TAP_ID, local=True, incoming=False)
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
+        # Capture the console socket fd so we can pass it to the exec'ed
+        # QEMU; it is inheritable and preserved across exec.
+        cons_fd = self.vm._cons_sock_saved_fd
+
+        # Build the command line for the new QEMU process that will replace
+        # the source after exec.  Reuse the same QMP path and console fd.
+        exec_cmd = [self.qemu_bin]
+        exec_cmd.extend(self.vm._harness_args)
+        exec_cmd.extend(["-chardev", f"socket,id=console,fd={cons_fd}",
+                         "-serial", "chardev:console"])
+        exec_cmd.extend(self.vm._base_args)
+        exec_cmd.extend(self.vm.args)
+        exec_cmd.extend(["-incoming", "defer"])
+
+        self.vm.cmd("migrate-set-parameters",
+                    {"cpr-exec-command": exec_cmd})
+
+        self.log.info("Starting cpr-exec migration")
+        freeze_start = time.time()
+        self.vm.cmd("migrate", {"uri": f"file:{mig_file}"})
+
+        self.log.info("Waiting for source migration to complete (exec)")
+        source_e = self.vm.events_wait(
+            (
+                ("MIGRATION", {"data": {"status": "completed"}}),
+                ("MIGRATION", {"data": {"status": "failed"}}),
+            )
+        )["data"]
+        assert source_e["status"] == "completed", \
+            f"Source migration failed: {source_e}"
+
+        # The source QEMU has now exec'ed the new QEMU.  The old QMP
+        # connection is gone; create a fresh QMP server on the same path
+        # and accept the new QEMU's connection.
+        self.vm._qmp_connection.close()
+        self.vm._events.clear()
+        # Remove the stale UNIX socket file left by the old server.
+        try:
+            os.unlink(qmp_sock)
+        except FileNotFoundError:
+            pass
+        self.vm._qmp_connection = QEMUMonitorProtocol(
+            qmp_sock, server=True, nickname=self.vm._name)
+        self.vm._qmp_connection.accept(timeout=120)
+
+        # The new QEMU is now reachable through the same QEMUMachine object.
+        self.set_migration_capabilities(self.vm, local=True, mode="cpr-exec")
+        self.add_virtio_net(self.vm, vhost, TAP_ID, local=True, incoming=True)
+        self.vm.cmd(
+            "migrate-incoming",
+            channels=[
+                {
+                    "channel-type": "main",
+                    "addr": {
+                        "transport": "file",
+                        "filename": mig_file,
+                        "offset": 0,
+                    },
+                }
+            ],
+            conv_keys=False,
+        )
+
+        self.log.info("Waiting for target migration to complete")
+        target_e = self.vm.events_wait(
+            (
+                ("MIGRATION", {"data": {"status": "completed"}}),
+                ("MIGRATION", {"data": {"status": "failed"}}),
+            )
+        )["data"]
+        assert target_e["status"] == "completed", \
+            f"Target migration failed: {target_e}"
+
+        self.vm.cmd("cont")
+        freeze_end = time.time()
+
+        self.log.info("Verifying PING on target VM after migration")
+        self.one_ping_from_guest(self.vm)
+        self.one_ping_from_host()
+
+        # And a bit more pings after migration
+        time.sleep(0.3)
+        self.stop_ping_and_check(freeze_start, freeze_end)
+
+        self.vm.shutdown()
+
     def test_tap_fd_migration(self):
         self.do_test_tap_fd_migration(False)
 
@@ -456,6 +647,24 @@ def test_tap_new_tap_migration(self):
     def test_tap_new_tap_migration_vhost(self):
         self.do_test_tap_fd_migration(True, local=False)
 
+    def test_tap_fd_migration_cpr(self):
+        self.do_test_tap_fd_migration(False, cpr=True)
+
+    def test_tap_fd_migration_vhost_cpr(self):
+        self.do_test_tap_fd_migration(True, cpr=True)
+
+    def test_tap_new_tap_migration_cpr(self):
+        self.do_test_tap_fd_migration(False, local=False, cpr=True)
+
+    def test_tap_new_tap_migration_vhost_cpr(self):
+        self.do_test_tap_fd_migration(True, local=False, cpr=True)
+
+    def test_tap_cpr_exec_migration(self):
+        self.do_test_tap_cpr_exec_migration(False)
+
+    def test_tap_cpr_exec_migration_vhost(self):
+        self.do_test_tap_cpr_exec_migration(True)
+
 
 if __name__ == "__main__":
     LinuxKernelTest.main()
-- 
2.43.0


