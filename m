Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A7DCD13DD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 16:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJDwm-0001Ro-HY; Wed, 12 Nov 2025 11:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vJDuH-0007g5-Ji; Wed, 12 Nov 2025 11:41:20 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vJDuE-0007zt-Lb; Wed, 12 Nov 2025 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=7ZOowEZ2uXhtXPyyFDxTZw4mF9ye7De92pk040iwuXQ=; b=sImQbIsZ9UE2
 daD4SmDnqHX/f6uWh4fP7jZm8x209FKvtNcHlh5ROu0ME7qcL8emDR9PjBTEtGtNARc4/JeRgiEB2
 Ry/2EzP0sdsyRIWIYZl9e6nHY2JkS8WWFz+HmxGAXrM5mTJYD+N7F08jhujxTy00BtEAJFl7Wk5QI
 3zdzUexg2esM2K6xfnfG1wA7bhhGLAOIDN3+QTONqT5AIb47cJYqAOLKMJhdkMk0Y7T5iMPKioXeK
 ogBuKRD6dHspvQGt6ZgG4FauexUeQc4xUDv3PK8Vy1+jLaybnVMSc57mLLf41vF0NHAkOcfkgQ59o
 unvCnsZv6BAXgslY69YSxA==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vJDsg-00H2e8-0v;
 Wed, 12 Nov 2025 17:41:07 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, f.ebner@proxmox.com,
 hreitz@redhat.com, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com
Subject: [BUG] Block graph assertion failure on blockdev-add
Date: Wed, 12 Nov 2025 18:41:07 +0200
Message-ID: <20251112164108.506976-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Hi all,

There's a bug in block layer which leads to an assertion failure and crash.
The reproduce is flaky, which suggests there's a race involved.  Here's how
it's reproduced:

1. Run QEMU with 2 disks: one system (with actual guest) and one empty; attach
them to an iothread;
2. In the guest, format the empty disk and start sequential IO on it;
3. At the host, start growing a chain of snapshots upon the empty image.

Here're the scripts:

1. Running QEMU:

QMPSOCK=/var/run/qmp.sock
SERIALSOCK=/var/run/serial.sock
ROOTIMG=/path/to/rootimg.qcow2
EMPTYIMG=/path/to/emptyimg.qcow2

rm -f $EMPTYIMG
qemu-img create -f qcow2 \
    -o cluster_size=1M,extended_l2=on,lazy_refcounts=on \
    $EMPTYIMG 64G

/path/to/qemu/build/qemu-system-x86_64 -enable-kvm \
    -machine q35 -cpu Nehalem \
    -name guest=guestvm,debug-threads=on \
    -m 2g -smp 2 \
    -nographic \
    \
    -serial unix:$SERIALSOCK,server=on,wait=off \
    -qmp unix:$QMPSOCK,server=on,wait=off \
    \
    -object iothread,id=iothread1 \
    \
    -blockdev node-name=disk-storage,driver=file,filename=$ROOTIMG,aio=native,cache.direct=on,cache.no-flush=off,auto-read-only=true,discard=unmap \
    -blockdev node-name=disk-prealloc,driver=preallocate,file=disk-storage,discard=unmap \
    -blockdev node-name=disk-format,driver=qcow2,file=disk-prealloc,read-only=false,discard=unmap \
    \
    -blockdev node-name=empty-storage,driver=file,filename=$EMPTYIMG,aio=native,cache.direct=on,cache.no-flush=off,auto-read-only=true,discard=unmap \
    -blockdev node-name=empty-prealloc,driver=preallocate,file=empty-storage,discard=unmap \
    -blockdev node-name=empty-format,driver=qcow2,file=empty-prealloc,read-only=false,discard=unmap \
    \
    -device pcie-root-port,id=root_port0,slot=1,bus=pcie.0 \
    -device pcie-root-port,id=root_port1,slot=2,bus=pcie.0 \
    -device virtio-blk-pci,drive=disk-format,id=virtio-disk0,bus=root_port0,bootindex=1 \
    -device virtio-blk-pci,drive=empty-format,iothread=iothread1,id=virtio-disk1,bus=root_port1

2. Formatting the disk in the guest and running sequential IO:

BLKDEV=$(ls /dev/[sv]d[b-z] | sort | sed -n '1p')

sgdisk -Z -n 1:0:0 -t 1:8300 $BLKDEV
mkfs.ext4 -F "${BLKDEV}1"
mkdir -p /mnt/empty
mount "${BLKDEV}1" /mnt/empty

fio --name=grow-disk --filename=/mnt/empty/growing.data \
    --rw=write --bs=4K --size=60G --time_based --runtime=900 \
    --ioengine=libaio --iodepth=32 --numjobs=4 --direct=0

3. Grow a chain of snapshots:

TESTDIR=/path/to/testdir
QMPSOCK=/var/run/qmp.sock
QMPSHELL=/path/to/qemu/scripts/qmp/qmp-shell

rm -f $TESTDIR/snap*.qcow2
SNAPNODE=empty-format

for i in {1..200} ; do
    SNAPIMG=$TESTDIR/snap$i.qcow2
    qemu-img create -f qcow2 \
        -o cluster_size=1M,extended_l2=on,lazy_refcounts=on \
        $SNAPIMG 64G

$QMPSHELL -p $QMPSOCK <<EOF
    blockdev-add node-name=snap${i}-storage driver=file filename=$SNAPIMG auto-read-only=true aio=native cache={"no-flush":false,"direct":true} discard=unmap
    blockdev-add node-name=snap${i}-prealloc driver=preallocate discard=unmap file=snap${i}-storage
    blockdev-add node-name=snap${i}-format driver=qcow2 read-only=false cache={"no-flush":false,"direct":true} discard=unmap file=snap${i}-prealloc
    blockdev-snapshot node=$SNAPNODE overlay=snap${i}-format
EOF

    SNAPNODE=snap${i}-format
done


Then, at some point, we get:

qemu-system-x86_64: ../block/io.c:441: bdrv_drain_assert_idle: Assertion `qatomic_read(&bs->in_flight) == 0' failed.

Stack trace:

(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007f92e52a15a3 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at pthread_kill.c:78
#2  0x00007f92e5254d06 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007f92e52287f3 in __GI_abort () at abort.c:79
#4  0x00007f92e522871b in __assert_fail_base (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:92
#5  0x00007f92e524dca6 in __assert_fail (assertion=0x555c50966200 "qatomic_read(&bs->in_flight) == 0", file=0x555c509660eb "../block/io.c", line=441, function=0x555c50966e60 <__PRETTY_FUNCTION__.33> "bdrv_drain_assert_idle") at assert.c:101
#6  0x0000555c505cb3f7 in bdrv_drain_assert_idle (bs=0x555c5384de20) at ../block/io.c:441
#7  0x0000555c505cb757 in bdrv_drain_all_begin () at ../block/io.c:531
#8  0x0000555c505c93c3 in bdrv_graph_wrlock_drained () at ../block/graph-lock.c:168
#9  0x0000555c505b83e3 in blk_remove_bs (blk=0x555c535b89f0) at ../block/block-backend.c:892
#10 0x0000555c505b73cb in blk_delete (blk=0x555c535b89f0) at ../block/block-backend.c:487
#11 0x0000555c505b77ac in blk_unref (blk=0x555c535b89f0) at ../block/block-backend.c:547
#12 0x0000555c5058f7f9 in bdrv_open_inherit (filename=0x0, reference=0x0, options=0x555c5386a530, flags=8194, parent=0x0, child_class=0x0, child_role=0, parse_filename=true, errp=0x7ffd1d8cba68) at ../block.c:4196
#13 0x0000555c5058fd89 in bdrv_open (filename=0x0, reference=0x0, options=0x555c53687680, flags=0, errp=0x7ffd1d8cba68) at ../block.c:4285
#14 0x0000555c5057ade1 in bds_tree_init (bs_opts=0x555c53687680, errp=0x7ffd1d8cba68) at ../blockdev.c:680
#15 0x0000555c50581c24 in qmp_blockdev_add (options=0x7ffd1d8cbaa0, errp=0x7ffd1d8cba68) at ../blockdev.c:3434
#16 0x0000555c506b28f8 in qmp_marshal_blockdev_add (args=0x7f92c400a9e0, ret=0x7f92d9fe3da8, errp=0x7f92d9fe3da0) at qapi/qapi-commands-block-core.c:1417
#17 0x0000555c5073d311 in do_qmp_dispatch_bh (opaque=0x7f92d9fe3e40) at ../qapi/qmp-dispatch.c:128
#18 0x0000555c5076a318 in aio_bh_call (bh=0x555c53640580) at ../util/async.c:172
#19 0x0000555c5076a43b in aio_bh_poll (ctx=0x555c52f635f0) at ../util/async.c:219
#20 0x0000555c5074aac2 in aio_dispatch (ctx=0x555c52f635f0) at ../util/aio-posix.c:436
#21 0x0000555c5076a8d5 in aio_ctx_dispatch (source=0x555c52f635f0, callback=0x0, user_data=0x0) at ../util/async.c:364
#22 0x00007f92e6913e3f in g_main_dispatch (context=0x555c52f69c10) at ../glib/gmain.c:3364
#23 g_main_context_dispatch (context=0x555c52f69c10) at ../glib/gmain.c:4079
#24 0x0000555c5076c13c in glib_pollfds_poll () at ../util/main-loop.c:290
#25 0x0000555c5076c1c3 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
#26 0x0000555c5076c2e3 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#27 0x0000555c502126b2 in qemu_main_loop () at ../system/runstate.c:903
#28 0x0000555c50681fb1 in qemu_default_main (opaque=0x0) at ../system/main.c:50
#29 0x0000555c50682060 in main (argc=39, argv=0x7ffd1d8cbf68) at ../system/main.c:93
(gdb) frame 6
#6  0x0000555c505cb3f7 in bdrv_drain_assert_idle (bs=0x555c5384de20) at ../block/io.c:441
441     {
(gdb) printf "%s (%s): %d\n", bs->node_name, bs->drv->format_name, bs->in_flight
snap40-storage (file): 1


So draining doesn't work as expected: in-flight requests are supposed to be
polled right before calling bdrv_drain_assert_idle(), but there's new IO
arriving:

void coroutine_mixed_fn bdrv_drain_all_begin(void)
{
...
    bdrv_drain_all_begin_nopoll();

    /* Now poll the in-flight requests */
    AIO_WAIT_WHILE_UNLOCKED(NULL, bdrv_drain_all_poll());   <---------

    while ((bs = bdrv_next_all_states(bs))) {
        bdrv_drain_assert_idle(bs);
    }
}

I've bisected the issue, and it seems to be introduced by Fiona's series [0]
for fixing a deadlock.  Namely, before the commit b13f546545 ("block: move
drain outside of bdrv_root_unref_child()") my reproducer above produces a
deadlock similar to what we had in [1].  And after commit b13f546545 is
applied, we get the crash.

Attached is a naive fix which simply eliminates global draining (i.e. draining
of all the block graph) in problematic codepaths.  While global draining might
indeed be redundant there, the real problem, i.e. the race, still remains.

Any comments and suggestions are welcomed.  Thanks!

[0] https://lore.kernel.org/qemu-devel/20250530151125.955508-1-f.ebner@proxmox.com/
[1] https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/

Andrey Drobyshev (1):
  block: avoid global drain on graph subtrees manipulation

 block.c               |  8 +++++++-
 block/block-backend.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.43.5


