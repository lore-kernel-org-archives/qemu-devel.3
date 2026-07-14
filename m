Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF133C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfHg-0001LD-Vu; Tue, 14 Jul 2026 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHc-0001Ji-Sm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:42:57 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHZ-00082A-AH
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:42:56 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 3B29A809D8;
 Tue, 14 Jul 2026 18:42:49 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id lgRdV71YDKo0-Q1tlh2NX; Tue, 14 Jul 2026 18:42:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784043768;
 bh=8MJrzwBJBsziH4yBEZuOS+ferUWlr0k0mwCpL5SshwM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=w3ZLUIEawj6C3VPqjYXol+fxasUpsGtiyOciEgkQfBE6mNFEklcnQsnCesJW62XNV
 tx9QpyjWyT39gy+RZllKxGyRz6kOjEqwyXsh6VOgOpgwrR6JiWaxHioUlQh3WdAkx1
 drfb5n2iFtybGE83RY07ltsOMRM3fnM9frgySTts=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v19 00/15] virtio-net: live-TAP local migration
Date: Tue, 14 Jul 2026 18:42:28 +0300
Message-ID: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi all!

Here is a migration for TAP net backend, including its properties and
open fds.

With this new feature, management software doesn't need to initialize
new TAP and do a switch to it. Nothing should be done around
virtio-net in local migration: it just migrates and continues to use
same TAP device. So we avoid extra logic in management software, extra
allocations in kernel (for new TAP), and corresponding extra delay in
migration downtime.

v19:

02: add r-b by Markus
03: pass parameter name to improve error message; info str: "no" -> ""
09: better documentation wording, keep a-b marks
10: new
13: - better wording
    - keep new property false by default
    - better error message
    - move to errp-variants of pre/post _load functions

v19 is pushed to

    https://gitlab.com/vsementsov/qemu.git
      tag: up-tap-fd-migration-with-bk-opt-v19

To run the test, use sudo, as test needs to configure TAP device:

    sudo PYTHONPATH=python:tests/functional \
    QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
    MESON_BUILD_ROOT=$PWD/build \
    ./build/pyvenv/bin/python3 tests/functional/x86_64/test_tap_migration.py

Or, to test the feature by hand, you may follow the instruction.

The walkthrough uses four terminals:

  source-cmd  -- source VM console (serial output, guest login)
  source-qmp  -- QMP connection to the source QEMU
  target-cmd  -- target VM console (serial output, guest login after migration)
  target-qmp  -- QMP connection to the target QEMU

1. Prerequisites
----------------

    QEMU=/path/to/your/build/qemu-system-x86_64

# download same image as in test

    wget -O /tmp/alpine.iso "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"


# prepare tap device (be careful to not break your own networks)

    sudo ip tuntap add dev tap0 mode tap multi_queue
    sudo ip addr add 192.168.100.1/24 dev tap0
    sudo ip link set tap0 up


2. Start source VM
------------------

In source-cmd, run:

    $QEMU \
        -name source \
        -machine q35 \
        -accel kvm \
        -m 1G \
        -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
        -machine memory-backend=ram0 \
        -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
        -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
        -serial stdio \
        -nographic \
        -S \
        -qmp unix:/tmp/qmp-source.sock,server=on,wait=off

Note: the netdev and virtio-net device are added via QMP below for symmetry
with the target.  On the source you could also pass them on the command line
(with local-migration-supported=on).

In source-qmp, connect and add the TAP netdev and virtio-net device:

    socat - UNIX-CONNECT:/tmp/qmp-source.sock

    {"execute": "qmp_capabilities"}

    {"execute": "netdev_add", "arguments": {
        "id": "netdev.1",
        "type": "tap",
        "ifname": "tap0",
        "queues": 4,
        "vnet_hdr": true,
        "script": "no",
        "downscript": "no",
        "local-migration-supported": true
    }}

    {"execute": "device_add", "arguments": {
        "driver": "virtio-net-pci",
        "id": "vnet.1",
        "netdev": "netdev.1",
        "bus": "pci.1",
        "mq": true,
        "vectors": 18,
        "romfile": "",
        "disable-legacy": "off"
    }}

    {"execute": "cont"}

Wait for Alpine to boot in source-cmd.  When you see the login prompt, log
in as root (no password):

    localhost login: root

Configure the guest network:

    ip addr add 192.168.100.2/24 dev eth0
    ip link set eth0 up

Verify connectivity from the guest:

    ping -c 3 192.168.100.1

And from the host (in any spare terminal):

    ping -c 3 192.168.100.2


3. Start target VM
------------------

The TAP netdev must be created via QMP after enabling the "local" migration
parameter — the target will not open tap0 itself; instead it will receive the
TAP file descriptors from the source over the migration channel.

In target-cmd, run:

    $QEMU \
        -name target \
        -machine q35 \
        -accel kvm \
        -m 1G \
        -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
        -machine memory-backend=ram0 \
        -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
        -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
        -serial stdio \
        -nographic \
        -qmp unix:/tmp/qmp-target.sock,server=on,wait=off \
        -incoming defer

In target-qmp, connect, enable local migration, and add the TAP netdev and
virtio-net device.  The "local" parameter must be set before creating the TAP.
Do not pass ifname/fd — the fd will arrive via the migration channel:

    socat - UNIX-CONNECT:/tmp/qmp-target.sock

    {"execute": "qmp_capabilities"}

    {"execute": "migrate-set-capabilities", "arguments": {
        "capabilities": [
            {"capability": "events",          "state": true},
            {"capability": "x-ignore-shared", "state": true}
        ]
    }}

    {"execute": "migrate-set-parameters", "arguments": {"local": true}}

    {"execute": "netdev_add", "arguments": {
        "id": "netdev.1",
        "type": "tap",
        "queues": 4,
        "script": "",
        "downscript": "",
        "local-migration-supported": true
    }}

    {"execute": "device_add", "arguments": {
        "driver": "virtio-net-pci",
        "id": "vnet.1",
        "netdev": "netdev.1",
        "bus": "pci.1",
        "mq": true,
        "vectors": 18,
        "romfile": "",
        "disable-legacy": "off"
    }}

4. Start migration
------------------

In target-qmp, tell the target to listen for the incoming migration:

    {"execute": "migrate-incoming",
     "arguments": {"uri": "unix:/tmp/migration.sock"}}

In source-qmp, configure migration capabilities and parameters:

    {"execute": "migrate-set-capabilities", "arguments": {
        "capabilities": [
            {"capability": "events",          "state": true},
            {"capability": "x-ignore-shared", "state": true}
        ]
    }}

    {"execute": "migrate-set-parameters", "arguments": {"local": true}}

In source-qmp, trigger the migration:

    {"execute": "migrate",
     "arguments": {"uri": "unix:/tmp/migration.sock"}}

Poll migration status until it completes (source-qmp):

    {"execute": "query-migrate"}
    # repeat until "status" == "completed"

Or just wait for the MIGRATION event that QEMU emits automatically:

    # {"event": "MIGRATION", "data": {"status": "completed"}, ...}

Once the source reports "completed", resume the target VM (target-qmp):

    {"execute": "cont"}

The target VM is now running with the migrated state and the TAP file
descriptors that were passed from the source. Still, target console
(in target-cmd) may still be empty, until you at least press Enter in
it.

Verify that the guest is still reachable from the host:

    ping -c 3 192.168.100.2

And from inside the guest in target-cmd:

    ping -c 3 192.168.100.1


5. Cleanup
----------

Shut down the target VM (target-qmp):

    {"execute": "quit"}

Shut down the source VM (source-qmp):

    {"execute": "quit"}

Remove the TAP device:

    sudo ip tuntap del tap0 mode tap multi_queue

Remove the shared memory file:

    rm /dev/shm/qemu_migration_test

Remove leftover sockets if they still exist:

    rm -f /tmp/migration.sock /tmp/qmp-source.sock /tmp/qmp-target.sock 


Vladimir Sementsov-Ogievskiy (15):
  net/tap: rework tap_parse_script
  net/tap: improve script/downscript options documentation
  net/tap: deprecate "no" as special value for script/downscript
  net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
  net/tap: move vhost initialization to tap_setup_vhost()
  net/tap: use container_of instead of DO_UPCAST
  net/tap: QOMify tap backend
  net/tap: add TYPE_VMSTATE_IF interface
  qapi: add local migration parameter
  migration/channel: check that transfer is UNIX socket when "local" set
  virtio-net: support local migration of backend
  net/tap: disable read polling for stopped VM
  net/tap: support local migration with virtio-net
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_tap_migration

 docs/about/deprecated.rst                     |  18 +
 docs/system/i386/microvm.rst                  |   4 +-
 docs/system/i386/xenpvh.rst                   |   2 +-
 docs/system/ppc/ppce500.rst                   |   4 +-
 docs/system/riscv/microchip-icicle-kit.rst    |   2 +-
 docs/system/riscv/sifive_u.rst                |   2 +-
 hw/net/virtio-net.c                           |  89 +++-
 include/hw/virtio/virtio-net.h                |   1 +
 include/migration/misc.h                      |   2 +
 include/migration/vmstate.h                   |   2 +
 include/net/net.h                             |   9 +
 include/net/tap.h                             |   2 +
 migration/channel.c                           |  17 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  14 +-
 net/tap.c                                     | 441 +++++++++++++----
 qapi/migration.json                           |  15 +-
 qapi/net.json                                 |  38 +-
 qemu-options.hx                               |  12 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 455 ++++++++++++++++++
 22 files changed, 1057 insertions(+), 107 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.43.0


