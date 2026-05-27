Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD35CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 19:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSJfm-0006Xp-2w; Wed, 27 May 2026 15:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJff-0006WU-8O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:03 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJfb-0000ZT-23
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 179C68846D;
 Wed, 27 May 2026 22:11:54 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qBf3L80XU0U0-WudqLmRk; Wed, 27 May 2026 22:11:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779909113;
 bh=baDN5MFrrJnasvlDANZGJUy8nlquw0iSNhmO4CN4MsY=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=T51jdpI6cYSL4Y2/E4CyvQC5KLxUhiKHkivODJl60QRrdv6sPJVaU57fZDPSYhtgh
 ko3p04fdokaBKjYpNA6ygM1kTXWHLrvSy7zXxv86TTpLwgB4FHA/HzSxVQPuZMcS4z
 lkECiQxoVAN8Rz2Zdd8j5Rc+fMUxJCWs6uFiMxZ0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v17 00/10] virtio-net: live-TAP local migration
Date: Wed, 27 May 2026 22:11:39 +0300
Message-ID: <20260527191150.250333-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

v17: rework interface
02-04: new
07: - drop local-migration parameter for virtio-net and the whole
      code to migrate backends (they should migrate by themselves).
    - drop virtio_net_update_host_features(), and call
      peer_test_vnet_hdr() and virtio_net_get_features() directly
      from post-load handlers
    - drop r-b
08: - add local-migratieon-supported property (instead of
      local-migration that is dropped in 07)
    - register own vmstate
    - add check for being in incoming migration when use incoming-fds
    - drop r-b, a-b
10: only move 'local_migration=local' from virtio-net device
    to 'local-migration-supported": local' in netdev. keep r-bs

Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
    "[PATCH v4 00/13] net: refactoring and fixes"

v17 is pushed to

    https://gitlab.com/vsementsov/qemu.git
      tag: up-tap-fd-migration-with-bk-opt-v17

To run the test, use sudo, as test needs to configure TAP device:

    sudo PYTHONPATH=python:tests/functional \
    QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
    MESON_BUILD_ROOT=$PWD/build \
    ./build/pyvenv/bin/python3 tests/functional/x86_64/test_tap_migration.py

Or, to test the feature by hand, you may follow the instruction:

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

Open terminal A, and run:

    $QEMU \
        -name source \
        -machine q35 \
        -accel kvm \
        -m 1G \
        -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
        -machine memory-backend=ram0 \
        -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
        -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
        -netdev tap,id=netdev.1,ifname=tap0,queues=4,vnet_hdr=on,script=no,downscript=no,local-migration-supported=on \
        -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
        -serial stdio \
        -nographic \
        -qmp unix:/tmp/qmp-source.sock,server=on,wait=off

Wait for Alpine to boot.  When you see the login prompt, log in as root
(no password):

    localhost login: root

Configure the guest network:

    ip addr add 192.168.100.2/24 dev eth0
    ip link set eth0 up

Verify connectivity from the guest:

    ping -c 3 192.168.100.1

And from the host (in another terminal):

    ping -c 3 192.168.100.2


3. Start target VM
------------------

Open terminal B.  The target VM uses the same shared memory file and
the same ISO.  The NIC is configured with incoming-fds=on — it will
not open tap0 itself; instead it will receive the TAP file descriptors
from the source over the migration channel.

    $QEMU \
        -name target \
        -machine q35 \
        -accel kvm \
        -m 1G \
        -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
        -machine memory-backend=ram0 \
        -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
        -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
        -netdev tap,id=netdev.1,queues=4,script=no,downscript=no,local-migration-supported=on,incoming-fds=on \
        -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
        -serial stdio \
        -nographic \
        -qmp unix:/tmp/qmp-target.sock,server=on,wait=off \
        -incoming defer


4. Start migration
------------------

Open terminal C and connect to the source QMP socket:

    socat - UNIX-CONNECT:/tmp/qmp-source.sock

Negotiate capabilities and configure migration:

    {"execute": "qmp_capabilities"}

    {"execute": "migrate-set-capabilities", "arguments": {
        "capabilities": [
            {"capability": "events",          "state": true},
            {"capability": "x-ignore-shared", "state": true}
        ]
    }}

    {"execute": "migrate-set-parameters", "arguments": {"local": true}}

Open terminal D and connect to the target QMP socket:

    socat - UNIX-CONNECT:/tmp/qmp-target.sock

Negotiate capabilities and configure migration:

    {"execute": "qmp_capabilities"}

    {"execute": "migrate-set-capabilities", "arguments": {
        "capabilities": [
            {"capability": "events",          "state": true},
            {"capability": "x-ignore-shared", "state": true}
        ]
    }}

    {"execute": "migrate-set-parameters", "arguments": {"local": true}}

Tell the target to listen for the incoming migration (terminal D):

    {"execute": "migrate-incoming",
     "arguments": {"uri": "unix:/tmp/migration.sock"}}

Trigger the migration from the source (terminal C):

    {"execute": "migrate",
     "arguments": {"uri": "unix:/tmp/migration.sock"}}

Poll migration status until it completes (terminal C):

    {"execute": "query-migrate"}
    # repeat until "status" == "completed"

Or just wait for the MIGRATION event that QEMU emits automatically:

    # {"event": "MIGRATION", "data": {"status": "completed"}, ...}

Once the source reports "completed", resume the target VM (terminal D):

    {"execute": "cont"}

The target VM is now running with the migrated state and the TAP file
descriptors that were passed from the source.

Verify that the guest is still reachable from the host:

    ping -c 3 192.168.100.2

And from inside the guest (terminal B, target serial console):

    ping -c 3 192.168.100.1


5. Cleanup
----------

Shut down the target VM (terminal D):

    {"execute": "quit"}

Shut down the source VM (terminal C):

    {"execute": "quit"}

Remove the TAP device:

    sudo ip tuntap del tap0 mode tap multi_queue

Remove the shared memory file:

    rm /dev/shm/qemu_migration_test

Remove leftover sockets if they still exist:

    rm -f /tmp/migration.sock /tmp/qmp-source.sock /tmp/qmp-target.sock 

Vladimir Sementsov-Ogievskiy (10):
  net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
  net/tap: move vhost initialization to tap_setup_vhost()
  net/tap: use container_of instead of DO_UPCAST
  net/tap: QOMify tap backend
  net/tap: add TYPE_VMSTATE_IF interface
  qapi: add local migration parameter
  virtio-net: support local migration of backend
  net/tap: support local migration with virtio-net
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_tap_migration

 hw/core/machine.c                             |   2 +
 hw/net/virtio-net.c                           |  89 +++-
 include/hw/virtio/virtio-net.h                |   1 +
 include/migration/misc.h                      |   2 +
 include/migration/vmstate.h                   |   2 +
 include/net/net.h                             |   9 +
 include/net/tap.h                             |   2 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  14 +-
 net/tap.c                                     | 429 +++++++++++++---
 qapi/migration.json                           |  12 +-
 qapi/net.json                                 |  20 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
 15 files changed, 986 insertions(+), 89 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.52.0


