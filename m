Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E566BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1J1R-0007H1-CQ; Wed, 24 Sep 2025 02:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v1J1P-0007GH-V5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v1J1L-0005lk-ES
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758695428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZBFbT/0UOIAnFVc+lcWU/h/CTIl7iEPK7PR/yeNyXUk=;
 b=QtwKah2iOsmjz30xzvDUlNsH0AY4E9ynmd32Quv422tAgXLDdEAovdWtZiX4h+A1WG8Z4t
 PcMtzy6ZU3rg1P+DY68wGUAwWVhfpVQLCQmNhkrkMJA3IE75RlBdGhLRvZGwUKTY0Hmcgi
 sv4KfCtM8dZzUePfXbDXZwfy9RM843M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-2bnaE451P3ao-yEJPgEunw-1; Wed,
 24 Sep 2025 02:28:53 -0400
X-MC-Unique: 2bnaE451P3ao-yEJPgEunw-1
X-Mimecast-MFC-AGG-ID: 2bnaE451P3ao-yEJPgEunw_1758695333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E57E21956086
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 06:28:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.72.116.111])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28B701800451; Wed, 24 Sep 2025 06:28:49 +0000 (UTC)
From: "Houqi (Nick) Zuo" <hzuo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Subject: [PATCH] net/net.c: add tap device fd validity check to prevent abort
 on deleted device
Date: Wed, 24 Sep 2025 14:28:31 +0800
Message-ID: <20250924062831.1788305-1-hzuo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hzuo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch addresses a scenario where QEMU would abort with a core dump
when a tap device created by QEMU is manually deleted from the host while
the guest is running.

The specific negative test case is:
1. Start QEMU with a tap device (created by QEMU)
2. Manually delete the tap device on the host
3. Execute shutdown in the guest
4. QEMU attempts to clean up the tap device but finds the file descriptor
   in a bad state, leading to abort and core dump

The patch introduces a tap device file descriptor validity check using
the TUNGETIFF ioctl to detect when the underlying tap device has been
removed. When detected, the operations are skipped gracefully instead
of proceeding with invalid file descriptors that cause ioctl failures.

The validity check is integrated into:
- qemu_set_vnet_hdr_len() in net/net.c
- qemu_set_offload() in net/net.c

This ensures that when the tap device is no longer valid, these functions
return early without attempting operations that would fail and trigger
aborts, thus achieving the expected behavior of error reporting without
crashing.

(gdb) bt full
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
        tid = <optimized out>
        ret = 0
        pd = <optimized out>
        old_mask = {__val = {10}}
        ret = <optimized out>
#1  0x00007f1710b6bff3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x00007f1710b15f56 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
        ret = <optimized out>
#3  0x00007f1710afd8fa in __GI_abort () at abort.c:79
        save_stage = 1
        act = {__sigaction_handler = {sa_handler = 0x20, sa_sigaction = 0x20}, sa_mask = {__val = {16929458408262392576, 18446744073709550848, 139737042419943, 139737042419943, 0, 94049703655600, 139737042419943, 139737042670528, 18446744073709550328, 77, 139705603579344, 18446744073709551615, 139737041472378, 139705595179568, 16929458408262392576, 94049679794864}}, sa_flags = 281695456, sa_restorer = 0xa}
#4  0x000055899a71de58 in tap_fd_set_vnet_hdr_len (fd=<optimized out>, len=10) at ../net/tap-linux.c:204
#5  tap_set_vnet_hdr_len (nc=<optimized out>, len=10) at ../net/tap.c:269
        s = <optimized out>
#6  0x000055899a8be67f in qemu_set_vnet_hdr_len (nc=0x2956, len=10588) at ../net/net.c:573
#7  virtio_net_set_mrg_rx_bufs (n=0x5589a72cfa10, mergeable_rx_bufs=<optimized out>, version_1=<error reading variable: Incompatible types on DWARF stack>, hash_report=<optimized out>) at ../hw/net/virtio-net.c:664
        i = 0
        nc = 0x5589a730ab28
#8  virtio_net_set_features (vdev=0x5589a72cfa10, features=0) at ../hw/net/virtio-net.c:897
        n = 0x5589a72cfa10
        err = 0x0
        i = 0
#9  0x000055899a8e4eaa in virtio_set_features_nocheck (vdev=0x5589a72cfa10, val=0) at ../hw/virtio/virtio.c:3079
        k = <optimized out>
        bad = <optimized out>
#10 virtio_reset (opaque=0x5589a72cfa10) at ../hw/virtio/virtio.c:3184
        vdev = 0x5589a72cfa10
        k = 0x5589a5c162b0
        i = 0
#11 0x000055899a630d2b in virtio_bus_reset (bus=0x5589a72cf990) at ../hw/virtio/virtio-bus.c:109
        vdev = <optimized out>
#12 virtio_pci_reset (qdev=0x5589a72c7470) at ../hw/virtio/virtio-pci.c:2311
        proxy = 0x5589a72c7470
        i = 0
        bus = 0x5589a72cf990
#13 0x000055899a686ded in memory_region_write_accessor (mr=<optimized out>, addr=<optimized out>, value=<optimized out>, size=<optimized out>, shift=<optimized out>, mask=<optimized out>, attrs=...) at ../system/memory.c:490
        tmp = <optimized out>
#14 0x000055899a686cbc in access_with_adjusted_size (addr=20, value=0x7f0fbedfde00, size=1, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=0x55899a686d30 <memory_region_write_accessor>, mr=0x5589a72c8040, attrs=...) at ../system/memory.c:566
        print_once_ = false
        access_mask = 255
        access_size = 1
        i = 0
        r = 0
        reentrancy_guard_applied = <optimized out>
#15 0x000055899a686ac5 in memory_region_dispatch_write (mr=<optimized out>, addr=20, data=<optimized out>, op=<optimized out>, attrs=...) at ../system/memory.c:1545
        size = <optimized out>
#16 0x000055899a69f7da in flatview_write_continue_step (attrs=..., buf=0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>, len=<optimized out>, mr_addr=20, l=0x7f0fbedfde28, mr=0x5589a72c8040) at ../system/physmem.c:2972
        val = 6
        result = 0
        release_lock = <optimized out>
#17 0x000055899a697c15 in flatview_write_continue (fv=0x7f0f6c124d90, addr=61675730370580, attrs=..., ptr=0x7f1711da6028, len=1, mr_addr=6, l=1, mr=0x0) at ../system/physmem.c:3002
        result = 0
        buf = 0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>
#18 flatview_write (fv=0x7f0f6c124d90, addr=61675730370580, attrs=..., buf=0x7f1711da6028, len=1) at ../system/physmem.c:3033
--Type <RET> for more, q to quit, c to continue without paging--
        l = <optimized out>
        mr_addr = 6
        mr = 0x0
#19 0x000055899a697a91 in address_space_write (as=0x55899bceeba0 <address_space_memory>, addr=61675730370580, attrs=..., buf=0x7f1711da6028, len=1) at ../system/physmem.c:3153
        _rcu_read_auto = 0x1
        result = 0
        fv = 0x2956
#20 0x000055899a91159b in address_space_rw (addr=10588, attrs=..., buf=0x7f1711da6028, len=0, as=<optimized out>, is_write=<optimized out>) at ../system/physmem.c:3163
#21 kvm_cpu_exec (cpu=0x5589a5d68b40) at ../accel/kvm/kvm-all.c:3255
        attrs = {secure = 0, space = 0, user = 0, memory = 0, debug = 0, requester_id = 0, pid = 0, address_type = 0, unspecified = false, _reserved1 = 0 '\000', _reserved2 = 0}
        run = 0x7f1711da6000
        ret = <optimized out>
        run_ret = <optimized out>
#22 0x000055899a9189ca in kvm_vcpu_thread_fn (arg=0x5589a5d68b40) at ../accel/kvm/kvm-accel-ops.c:51
        r = <optimized out>
        cpu = <optimized out>
#23 0x000055899aba817a in qemu_thread_start (args=0x5589a5d72580) at ../util/qemu-thread-posix.c:393
        __clframe = {__cancel_routine = <optimized out>, __cancel_arg = 0x0, __do_it = 1, __cancel_type = <optimized out>}
        qemu_thread_args = 0x5589a5d72580
        start_routine = 0x55899a918850 <kvm_vcpu_thread_fn>
        arg = 0x5589a5d68b40
        r = 0x0
#24 0x00007f1710b6a128 in start_thread (arg=<optimized out>) at pthread_create.c:448
        ret = <optimized out>
        pd = <optimized out>
        out = <optimized out>
        unwind_buf = {cancel_jmp_buf = {{jmp_buf = {32, 8894544057743421332, -1288, 0, 140726164742416, 140726164742679, -8831356496486092908, -8844535456800460908}, mask_was_saved = 0}}, priv = {pad = {0x0, 0x0, 0x0, 0x0}, data = {prev = 0x0, cleanup = 0x0, canceltype = 0}}}
        not_first_call = <optimized out>
#25 0x00007f1710bda924 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:100

Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
---
 include/net/net.h |  2 ++
 net/net.c         |  7 +++++--
 net/tap-linux.c   | 11 +++++++++++
 net/tap.c         |  9 +++++++++
 net/tap_int.h     |  1 +
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 84ee18e0f9..9e435f3275 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -69,6 +69,7 @@ typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
+typedef int (QueryValidity)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -96,6 +97,7 @@ typedef struct NetClientInfo {
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
     GetVHostNet *get_vhost_net;
+    QueryValidity *query_validity;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/net.c b/net/net.c
index da275db86e..c0750fd0b9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -57,6 +57,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "standard-headers/linux/virtio_net.h"
+#include "qemu/log.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -543,7 +544,8 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                           int ecn, int ufo, int uso4, int uso6)
 {
-    if (!nc || !nc->info->set_offload) {
+    if (!nc || !nc->info->set_offload ||
+        (nc->info->query_validity && nc->info->query_validity(nc) != 1)) {
         return;
     }
 
@@ -561,7 +563,8 @@ int qemu_get_vnet_hdr_len(NetClientState *nc)
 
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
 {
-    if (!nc || !nc->info->set_vnet_hdr_len) {
+    if (!nc || !nc->info->set_vnet_hdr_len ||
+        (nc->info->query_validity && nc->info->query_validity(nc) != 1)) {
         return;
     }
 
diff --git a/net/tap-linux.c b/net/tap-linux.c
index e832810665..2911c66149 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -346,3 +346,14 @@ int tap_fd_set_steering_ebpf(int fd, int prog_fd)
 
     return 0;
 }
+
+int tap_fd_query_validity(int fd)
+{
+    struct ifreq ifr;
+
+    if (ioctl(fd, TUNGETIFF, &ifr) != 0) {
+        error_report("The tap device fd: %d is NOT valid.", fd);
+        return -1;
+    }
+    return 1;
+}
diff --git a/net/tap.c b/net/tap.c
index f37133e301..a9af3c7279 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -364,6 +364,14 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static int tap_query_validity(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return tap_fd_query_validity(s->fd);
+}
+
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -383,6 +391,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .query_validity = tap_query_validity,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d..5deb380201 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -46,5 +46,6 @@ int tap_fd_enable(int fd);
 int tap_fd_disable(int fd);
 int tap_fd_get_ifname(int fd, char *ifname);
 int tap_fd_set_steering_ebpf(int fd, int prog_fd);
+int tap_fd_query_validity(int fd);
 
 #endif /* NET_TAP_INT_H */
-- 
2.47.3


