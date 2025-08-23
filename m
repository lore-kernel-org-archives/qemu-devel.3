Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10BDCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6G-0004XM-TM; Sat, 23 Aug 2025 17:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6E-0004V4-Ba
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:34 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6A-00054T-D6
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2B90480819;
 Sun, 24 Aug 2025 00:48:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-nEOOXVl3; Sun, 24 Aug 2025 00:48:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985708;
 bh=3LPYUtrlMzm8Kkb/TwFLjVqW2I4eWMHZK7XFbbirxyM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=sl5hhcSzDu0amuJrZrwoi5crJ/eohxVGMrLgGXO20mKeH3wgJhDyrwPXHGczN7vNy
 6M3UERnD7TMEXrJsmgaFG4r06Rx9gF28ubXXVsvGlRnmtJjmgGxUiunV9QAc6bI8qJ
 bAmYzz8SaoK3woFLDLno9Klnh5NurYE5OGQk/xi0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 7/7] RFC: add python/tap-migration-stand.py
Date: Sun, 24 Aug 2025 00:48:21 +0300
Message-ID: <20250823214821.48342-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823214821.48342-1-vsementsov@yandex-team.ru>
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

How to use:

1. prepare test image (any distribution with working network), and
modify IMAGE variable in script

You'll need to setup static ip in the image, for example in Ubuntu:

cat /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens1:
      dhcp4: no
      addresses: [10.0.1.2/24]
      gateway4: 10.0.1.1
      nameservers:
	addresses: [8.8.8.8, 8.8.4.4]

2. run script with sudo (to manipulate with TAPs)

cd python
sudo ./tap-migration-stand.py --qemu-binary path/to/qemu-system-x86_64 \
  --mode (new | cpr)

mode=new means current series, mode=cpr means
"[RFC V2 0/8] Live update: tap and vhost"

3. run in separate terminal something like

while true; do gvncviewer :0; gvncviewer :1; sleep 0.5; done

to monitor our vms (on live update, vnc port will change every time)

4. run ping processes, for example

in host: ping -f 10.0.1.2 -i 0.002
in vm: ping -f 10.0.1.1 -i 0

5. in running script, run command "u" (without quotes), which means
live-update.

6. you may also pass a counter, like "u 1000", to update 1000 times,
which helps to catch racy bugs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 python/qemu/machine/machine.py |  37 ++--
 python/tap-migration-stand.py  | 348 +++++++++++++++++++++++++++++++++
 2 files changed, 369 insertions(+), 16 deletions(-)
 create mode 100755 python/tap-migration-stand.py

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ebb58d5b68..fed54f768d 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -360,6 +360,7 @@ def _pre_launch(self) -> None:
         # _post_shutdown()!
         # pylint: disable=consider-using-with
         self._qemu_log_path = os.path.join(self.log_dir, self._name + ".log")
+        print(f"Open log file: {self._qemu_log_path}")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
         self._iolog = None
@@ -435,17 +436,17 @@ def _post_shutdown(self) -> None:
         self._user_killed = False
         self._launched = False
 
-    def launch(self) -> None:
+    def launch(self, do_launch=True, do_post_launch=True) -> None:
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
         """
 
-        if self._launched:
+        if self._launched and do_launch:
             raise QEMUMachineError('VM already launched')
 
         try:
-            self._launch()
+            self._launch(do_launch, do_post_launch)
         except BaseException as exc:
             # We may have launched the process but it may
             # have exited before we could connect via QMP.
@@ -468,23 +469,26 @@ def launch(self) -> None:
             # that exception. However, we still want to clean up.
             raise
 
-    def _launch(self) -> None:
+    def _launch(self, do_launch=True, do_post_launch=True) -> None:
         """
         Launch the VM and establish a QMP connection
         """
-        self._pre_launch()
-        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
+        if do_launch:
+            self._pre_launch()
+            print('VM launch command: %r', ' '.join(self._qemu_full_args))
 
-        # Cleaning up of this subprocess is guaranteed by _do_shutdown.
-        # pylint: disable=consider-using-with
-        self._popen = subprocess.Popen(self._qemu_full_args,
-                                       stdin=subprocess.DEVNULL,
-                                       stdout=self._qemu_log_file,
-                                       stderr=subprocess.STDOUT,
-                                       shell=False,
-                                       close_fds=False)
-        self._launched = True
-        self._post_launch()
+            # Cleaning up of this subprocess is guaranteed by _do_shutdown.
+            # pylint: disable=consider-using-with
+            self._popen = subprocess.Popen(self._qemu_full_args,
+                                           stdin=subprocess.DEVNULL,
+                                           stdout=self._qemu_log_file,
+                                           stderr=subprocess.STDOUT,
+                                           shell=False,
+                                           close_fds=False)
+            self._launched = True
+
+        if do_post_launch:
+            self._post_launch()
 
     def _close_qmp_connection(self) -> None:
         """
@@ -732,6 +736,7 @@ def cmd(self, cmd: str,
             conv_keys = True
 
         qmp_args = self._qmp_args(conv_keys, args)
+        print(cmd, qmp_args)
         ret = self._qmp.cmd(cmd, **qmp_args)
         if cmd == 'quit':
             self._quit_issued = True
diff --git a/python/tap-migration-stand.py b/python/tap-migration-stand.py
new file mode 100755
index 0000000000..24e0e58e40
--- /dev/null
+++ b/python/tap-migration-stand.py
@@ -0,0 +1,348 @@
+#!/usr/bin/env python3
+import argparse
+import subprocess
+import time
+from enum import Enum
+from typing import Tuple
+
+from qemu.machine import QEMUMachine
+
+
+IMAGE = "/home/vsementsov/work/vms/newfocal.raw"
+
+
+def run(cmd: str, check: bool = True) -> None:
+    subprocess.run(cmd, check=check, shell=True)
+
+
+def del_tap(tap: str) -> None:
+    run(f"sudo ip tuntap del {tap} mode tap multi_queue", check=False)
+
+
+def init_tap(tap: str) -> None:
+    run(f"sudo ip tuntap add dev {tap} mode tap multi_queue")
+    run(f"sudo ip link set dev {tap} address e6:1d:44:b5:03:5d")
+    run(f"sudo ip addr add 10.0.1.1/24 dev {tap}")
+    run(f"sudo ip link set {tap} up")
+
+
+class MigrationFailed(Exception):
+    pass
+
+
+class MyVM(QEMUMachine):
+    class Mode(Enum):
+        CPR = "cpr"
+        CPR_NO_TAP = "cpr-no-tap"
+        NO_TAP = "no-tap"
+        OPEN_SAME_TAP = "open-same-tap"
+        OPEN_NEW_TAP = "open-new-tap"
+        NEW = "new"
+
+    def __init__(
+        self,
+        binary: str,
+        mode: Mode,
+        incoming: bool = False,
+        ind: int = 0,
+        vhost: bool = False,
+    ):
+        assert ind in (0, 1)
+        self.tap_name = f"tap{ind}" if mode == MyVM.Mode.OPEN_NEW_TAP else "tap0"
+        self.cpr = mode in (MyVM.Mode.CPR, MyVM.Mode.CPR_NO_TAP)
+        self.no_tap = mode in (MyVM.Mode.NO_TAP, MyVM.Mode.CPR_NO_TAP)
+        self.mode = mode
+        self.ind = ind
+        self.qemu_binary = binary
+        self.vhost = vhost
+        self.fds = None
+        auxshare_str = "-machine aux-ram-share=on" if self.cpr else ""
+
+        additional_args = []
+        if incoming:
+            additional_args = ["-incoming", "defer"]
+            if self.cpr:
+                additional_args += [
+                    "-incoming",
+                    '{"channel-type": "cpr","addr": '
+                    '{ "transport": "socket","type": "unix", "path": "/tmp/cpr.sock"}}',
+                ]
+
+        new_traces = "-trace tap_*" if mode == MyVM.Mode.NEW else ""
+
+        super().__init__(
+            binary=binary,
+            log_dir="/tmp/logdir/",
+            name=f"mytest{ind}",
+            args=f"""
+                -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1
+                -device pcie-root-port,id=s0,slot=0,bus=pcie.1
+                -device pcie-root-port,id=s1,slot=1,bus=pcie.1
+                -device pcie-root-port,id=s2,slot=2,bus=pcie.1
+
+                -hda {IMAGE}
+                -m 4G -enable-kvm -M q35 -vnc :{ind} -nodefaults -vga std
+                -qmp stdio
+                -msg timestamp
+                -S
+                -trace migrate_*
+                -trace migration_cleanup
+                -trace migration_cancel
+                -trace handle_qmp_command
+                -trace monitor_qmp_respond
+                {new_traces}
+                -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
+                -machine memory-backend=ram0 {auxshare_str}
+            """.split()
+            + additional_args,
+        )
+
+    def add_tap_netdev(self, tap, vhost: bool, local_incoming: bool = False):
+        args = {
+            "id": "netdev.1",
+            "vhost": vhost,
+            "vhostforce": vhost,
+            "type": "tap",
+            "ifname": tap,
+            "script": "no",
+            "downscript": "no",
+            "queues": 4,
+        }
+
+        if self.cpr:
+            args["cpr"] = True
+        elif local_incoming:
+            args["local-incoming"] = True
+
+        self.cmd("netdev_add", args)
+
+        self.cmd(
+            "device_add",
+            driver="virtio-net-pci",
+            romfile="",
+            id="vnet.1",
+            netdev="netdev.1",
+            mq=True,
+            vectors=18,
+            bus="s1",
+            mac="d6:0d:75:f8:0f:b7",
+            disable_legacy="off",
+        )
+
+    def setup_network_first_time(self):
+        if self.no_tap:
+            return
+
+        del_tap("tap0")
+        del_tap("tap1")
+        assert self.tap_name == "tap0"
+        init_tap("tap0")
+
+        self.add_tap_netdev(self.tap_name, self.vhost)
+
+    def setup_network_incoming(self, fds=None):
+        if self.no_tap:
+            return
+
+        if self.mode == MyVM.Mode.OPEN_NEW_TAP:
+            run(f"sudo ip tuntap add dev {self.tap_name} mode tap multi_queue")
+            run(f"sudo ip link set {self.tap_name} up")
+            tap = self.tap_name
+        else:
+            tap = "tap0"
+
+        self.add_tap_netdev(
+            tap, self.vhost, local_incoming=(self.mode == MyVM.Mode.NEW)
+        )
+
+    def pre_start_network_switch(self):
+        assert self.mode == MyVM.Mode.OPEN_NEW_TAP
+
+        a = time.time()
+        prev_tap = f"tap{1 - self.ind}"
+        run(f"sudo ip link set {self.tap_name} down")
+        run(f"sudo ip link set {prev_tap} down")
+        run(f"sudo ip addr delete 10.0.1.1/24 dev {prev_tap}")
+        run(f"sudo ip link set dev {self.tap_name} address e6:1d:44:b5:03:5d")
+        run(f"sudo ip addr add 10.0.1.1/24 dev {self.tap_name}")
+        run(f"sudo ip link set {self.tap_name} up")
+        b = time.time()
+        print("network switch:", b - a)
+
+    def wait_migration_complete(self) -> bool:
+        while True:
+            event = self.event_wait("MIGRATION", timeout=1000)
+            print("source:", event)
+            assert event
+            if event["data"]["status"] == "completed":
+                return True
+            if event["data"]["status"] == "failed":
+                print("MIGRATION FAILED!")
+                print(self.cmd("query-migrate"))
+                return False
+
+    def mig_cap(self):
+        if self.cpr:
+            self.cmd("migrate-set-parameters", {"mode": "cpr-transfer"})
+        cap_list = ["events", "x-ignore-shared"]
+        if self.mode == MyVM.Mode.NEW:
+            cap_list.append("local-tap")
+        caps = [{"capability": c, "state": True} for c in cap_list]
+        self.cmd("migrate-set-capabilities", {"capabilities": caps})
+
+    def migrate(self):
+        self.mig_cap()
+        if self.cpr:
+            self.cmd(
+                "migrate",
+                {
+                    "channels": [
+                        {
+                            "channel-type": "main",
+                            "addr": {
+                                "transport": "socket",
+                                "type": "unix",
+                                "path": "/tmp/migr.sock",
+                            },
+                        },
+                        {
+                            "channel-type": "cpr",
+                            "addr": {
+                                "transport": "socket",
+                                "type": "unix",
+                                "path": "/tmp/cpr.sock",
+                            },
+                        },
+                    ]
+                },
+            )
+        else:
+            self.cmd("migrate", uri="unix:/tmp/migr.sock")
+
+    def live_update(self) -> Tuple["MyVM", float]:
+        ind = 1 - self.ind
+        target = MyVM(
+            binary=self.qemu_binary,
+            ind=ind,
+            mode=self.mode,
+            incoming=True,
+            vhost=self.vhost,
+        )
+
+        if self.cpr:
+            print("launch target (cpr)")
+            target.launch(do_post_launch=False)
+            time.sleep(1)
+
+            print("call migrate on source, will pass fds")
+            self.migrate()
+
+            print("vm:", self.cmd("query-status"), self.cmd("query-migrate"))
+            print("post launch and qmp connect to target..")
+            target.launch(do_launch=False)
+        else:
+            print("launch target (usual)")
+            target.launch()
+
+        target.setup_network_incoming(self.fds)
+
+        target.mig_cap()
+
+        if self.cpr:
+            freeze_start = time.time()
+            target.cmd("migrate-incoming", {"uri": "unix:/tmp/migr.sock"})
+        else:
+            target.cmd("migrate-incoming", {"uri": "unix:/tmp/migr.sock"})
+            freeze_start = time.time()
+            self.migrate()
+
+        print("wait migration on source")
+        if not self.wait_migration_complete():
+            target.shutdown()
+            raise MigrationFailed
+
+        print("wait source STOP")
+        stop_event = self.event_wait("STOP", timeout=1000)
+        assert stop_event
+        print(stop_event)
+
+        print("wait migration on target")
+        assert target.wait_migration_complete()
+
+        result = self.qmp("query-status")
+        assert result["return"]["status"] == "postmigrate"
+
+        result = target.qmp("query-status")
+        assert result["return"]["status"] == "paused"
+
+        if self.mode == MyVM.Mode.OPEN_NEW_TAP:
+            target.pre_start_network_switch()
+
+        print("target CONT")
+        target.qmp("cont")
+        freeze_end = time.time()
+
+        freeze_time = freeze_end - freeze_start
+        print("freeze-time: ", freeze_time)
+
+        self.shutdown()
+
+        if self.mode == MyVM.Mode.OPEN_NEW_TAP:
+            del_tap(self.tap_name)
+
+        print(target.cmd("query-version"))
+        print(target.cmd("query-status"))
+        return target, freeze_time
+
+
+def main():
+    # cleanup previous test runs
+    run("rm -rf /tmp/logdir", check=False)
+    run("mkdir /tmp/logdir", check=False)
+    run("killall qemu-system-x86_64", check=False)
+
+    p = argparse.ArgumentParser()
+    p.add_argument("--qemu-binary", required=True)
+    p.add_argument("--vhost", action="store_true")
+    p.add_argument("--mode", choices=[e.value for e in MyVM.Mode], required=True)
+    args = p.parse_args()
+
+    print("vhost:", args.vhost)
+    print("mode:", args.mode)
+
+    vm = MyVM(binary=args.qemu_binary, mode=MyVM.Mode(args.mode), vhost=args.vhost)
+    vm.launch()
+    vm.setup_network_first_time()
+    vm.cmd("cont")
+
+    while True:
+        cmd = input().strip()
+        if cmd == "q":
+            break
+
+        if cmd == "s":
+            print(vm.cmd("query-status"))
+            vm.cmd("cont")
+            continue
+
+        if cmd.startswith("u"):
+            spl = cmd.split()
+            assert len(spl) <= 2
+            num = int(cmd.split(maxsplit=1)[1]) if len(spl) == 2 else 1
+            total_freeze_time = 0
+            try:
+                for i in range(num):
+                    vm, freeze_time = vm.live_update()
+                    print("DONE:", i)
+                    total_freeze_time += freeze_time
+            except MigrationFailed:
+                continue
+
+            print(f"avg freeze-time: {total_freeze_time / num}")
+            continue
+
+    vm.shutdown()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.48.1


