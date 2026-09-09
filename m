Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690FFC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HzW-0008Bj-50; Wed, 09 Sep 2026 09:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HvT-0007Nh-CX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HvQ-0000s6-Q5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788958876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRlw7v5QNO60ljLFjnMuVIX4GUu6COj5uHQn8c91o78=;
 b=UyNbJSemEyVjsGBnajt1CG0c5Qxvu6tDkUjYBi3LVNcgXZWZe9CjybUDeDR6kO6WE2G3OE
 2PS1nTruY/CuTaCm7w2V3F5DYkzAs1D7iZokrp9+XFkSXhYrRihoe1weZQFb99p6TikZwH
 7VYTfE/GNAWzgy/gFJ4zyGONoy1O+b4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-pnk309SfNYCvq9UpFiVpwA-1; Wed,
 09 Sep 2026 09:00:09 -0400
X-MC-Unique: pnk309SfNYCvq9UpFiVpwA-1
X-Mimecast-MFC-AGG-ID: pnk309SfNYCvq9UpFiVpwA_1788958808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92B761800BCB; Wed,  9 Sep 2026 13:00:08 +0000 (UTC)
Received: from Alexs-MacBook-Air.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE0F3000218; Wed,  9 Sep 2026 13:00:05 +0000 (UTC)
From: Alex Fishman <afishman@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, Alex Fishman <afishman@redhat.com>
Subject: [PATCH v1 2/2] tests/qtest: Add vhost-user memslot boundary test
Date: Wed,  9 Sep 2026 15:59:23 +0300
Message-ID: <20260909125923.75340-3-afishman@redhat.com>
In-Reply-To: <20260909125923.75340-1-afishman@redhat.com>
References: <20260909125923.75340-1-afishman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afishman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Sep 2026 09:05:26 -0400
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

Extend the fake vhost-user backend with configurable memory slot
support and add a virtio-mem test that places a vring across adjacent
dynamic memslots.

Activate another memslot after configuring the boundary-crossing vring
to trigger a vhost memory table update. Verify that the new slot is
advertised as a separate region instead of extending the merge required
by the vring.

Buglink: https://redhat.atlassian.net/browse/RHEL-146583

Signed-off-by: Alex Fishman <afishman@redhat.com>
---
 tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
 1 file changed, 385 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index c8b5f8ff71..db57d3695f 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -13,16 +13,19 @@
 #include "libqtest-single.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
+#include "qemu/bswap.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
+#include "qemu/units.h"
 #include "chardev/char-fe.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "system/system.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
+#include "libqos/virtio-net.h"
 #include "libqos/virtio-pci.h"
 
 #include "libqos/malloc-pc.h"
@@ -31,6 +34,8 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_net.h"
+#include "standard-headers/linux/virtio_mem.h"
+#include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_gpio.h"
 #include "standard-headers/linux/virtio_scmi.h"
 
@@ -39,11 +44,13 @@
 #endif
 
 
-#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM," \
-                        "mem-path=%s,share=on -numa node,memdev=mem"
-#define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=mem,size=%dM," \
-                        " -numa node,memdev=mem"
-#define QEMU_CMD_SHM    " -m %d -object memory-backend-shm,id=mem,size=%dM," \
+#define QEMU_CMD_MEM \
+    " -m %d%s -object memory-backend-file,id=mem,size=%dM," \
+    "mem-path=%s,share=on -numa node,memdev=mem"
+#define QEMU_CMD_MEMFD \
+    " -m %d%s -object memory-backend-memfd,id=mem,size=%dM," \
+    " -numa node,memdev=mem"
+#define QEMU_CMD_SHM    " -m %d%s -object memory-backend-shm,id=mem,size=%dM," \
                         " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce=on"
@@ -62,8 +69,11 @@
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 #define VHOST_USER_PROTOCOL_F_CONFIG 9
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
 
 #define VHOST_LOG_PAGE 0x1000
+#define TEST_VHOST_USER_MAX_MEM_SLOTS 1024
+#define TEST_VHOST_USER_MEM_REGS 64
 
 typedef enum VhostUserRequest {
     VHOST_USER_NONE = 0,
@@ -87,6 +97,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_GET_CONFIG = 24,
     VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+    VHOST_USER_ADD_MEM_REG = 37,
+    VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -103,6 +116,11 @@ typedef struct VhostUserMemory {
     VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserMemRegMsg {
+    uint64_t padding;
+    VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -122,6 +140,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_state state;
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
+        VhostUserMemRegMsg mem_reg;
         VhostUserLog log;
     } payload;
 } QEMU_PACKED VhostUserMsg;
@@ -169,6 +188,11 @@ typedef struct TestServer {
     bool test_fail;
     int test_flags;
     int queues;
+    bool configure_mem_slots;
+    unsigned int get_max_mem_slots_count;
+    unsigned int add_mem_reg_count;
+    unsigned int rem_mem_reg_count;
+    VhostUserMemoryRegion add_mem_regs[TEST_VHOST_USER_MEM_REGS];
     struct vhost_user_ops *vu_ops;
 } TestServer;
 
@@ -220,8 +244,9 @@ static void append_vhost_gpio_opts(TestServer *s, GString *cmd_line,
                            chr_opts);
 }
 
-static void append_mem_opts(TestServer *server, GString *cmd_line,
-                            int size, enum test_memfd memfd)
+static void append_mem_opts_full(TestServer *server, GString *cmd_line,
+                                 int size, enum test_memfd memfd,
+                                 const char *size_opts)
 {
     if (memfd == TEST_MEMFD_AUTO) {
         memfd = qemu_memfd_check(MFD_ALLOW_SEALING) ? TEST_MEMFD_YES
@@ -229,16 +254,25 @@ static void append_mem_opts(TestServer *server, GString *cmd_line,
     }
 
     if (memfd == TEST_MEMFD_YES) {
-        g_string_append_printf(cmd_line, QEMU_CMD_MEMFD, size, size);
+        g_string_append_printf(cmd_line, QEMU_CMD_MEMFD,
+                               size, size_opts, size);
     } else if (memfd == TEST_MEMFD_SHM) {
-        g_string_append_printf(cmd_line, QEMU_CMD_SHM, size, size);
+        g_string_append_printf(cmd_line, QEMU_CMD_SHM,
+                               size, size_opts, size);
     } else {
         const char *root = init_hugepagefs() ? : server->tmpfs;
 
-        g_string_append_printf(cmd_line, QEMU_CMD_MEM, size, size, root);
+        g_string_append_printf(cmd_line, QEMU_CMD_MEM,
+                               size, size_opts, size, root);
     }
 }
 
+static void append_mem_opts(TestServer *server, GString *cmd_line,
+                            int size, enum test_memfd memfd)
+{
+    append_mem_opts_full(server, cmd_line, size, memfd, "");
+}
+
 static bool wait_for_fds(TestServer *s)
 {
     gint64 end_time;
@@ -501,6 +535,40 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE + msg.size);
         break;
 
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        s->get_max_mem_slots_count++;
+        msg.flags |= VHOST_USER_REPLY_MASK;
+        msg.size = sizeof(m.payload.u64);
+        msg.payload.u64 = TEST_VHOST_USER_MAX_MEM_SLOTS;
+        p = (uint8_t *) &msg;
+        qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE + msg.size);
+        g_cond_broadcast(&s->data_cond);
+        break;
+
+    case VHOST_USER_ADD_MEM_REG:
+        g_assert_cmpuint(msg.size, ==, sizeof(msg.payload.mem_reg));
+        g_assert_cmpint(qemu_chr_fe_get_msgfds(chr, &fd, 1), ==, 1);
+        g_assert_cmpint(fd, >=, 0);
+        close(fd);
+        g_assert_cmpuint(s->add_mem_reg_count, <,
+                         G_N_ELEMENTS(s->add_mem_regs));
+        s->add_mem_regs[s->add_mem_reg_count] = msg.payload.mem_reg.region;
+        s->add_mem_reg_count++;
+        g_test_message("add_mem_reg: gpa=0x%" PRIx64 " size=0x%" PRIx64,
+                       msg.payload.mem_reg.region.guest_phys_addr,
+                       msg.payload.mem_reg.region.memory_size);
+        g_cond_broadcast(&s->data_cond);
+        break;
+
+    case VHOST_USER_REM_MEM_REG:
+        g_assert_cmpuint(msg.size, ==, sizeof(msg.payload.mem_reg));
+        s->rem_mem_reg_count++;
+        g_test_message("rem_mem_reg: gpa=0x%" PRIx64 " size=0x%" PRIx64,
+                       msg.payload.mem_reg.region.guest_phys_addr,
+                       msg.payload.mem_reg.region.memory_size);
+        g_cond_broadcast(&s->data_cond);
+        break;
+
     case VHOST_USER_SET_VRING_ENABLE:
         /*
          * Another case we ignore as we don't need to respond. With a
@@ -1048,6 +1116,301 @@ static void *vhost_user_test_setup_multiqueue(GString *cmd_line, void *arg)
     return s;
 }
 
+static void *vhost_user_test_setup_mem_slots(GString *cmd_line, void *arg)
+{
+    TestServer *s = test_server_new("mem-slots", arg);
+
+    s->configure_mem_slots = true;
+    test_server_listen(s);
+
+    append_mem_opts_full(s, cmd_line, 256, TEST_MEMFD_YES,
+                         ",maxmem=4G,slots=32");
+    g_string_append(cmd_line,
+                    " -object memory-backend-memfd,id=vmem,size=3G,share=on"
+                    " -device virtio-mem-pci,memdev=vmem,dynamic-memslots=on,"
+                    "requested-size=3G,unplugged-inaccessible=on,addr=05.0");
+    s->vu_ops->append_opts(s, cmd_line, "");
+
+    g_test_queue_destroy(vhost_user_test_cleanup, s);
+
+    return s;
+}
+
+static QVirtioPCIDevice *virtio_mem_init(QPCIBus *bus,
+                                         QGuestAllocator *alloc,
+                                         QVirtQueue **vq)
+{
+    QPCIAddress addr = { .devfn = QPCI_DEVFN(5, 0) };
+    QVirtioPCIDevice *dev = virtio_pci_new(bus, &addr);
+    uint64_t features;
+
+    g_assert_nonnull(dev);
+    g_assert_cmpuint(dev->vdev.device_type, ==, VIRTIO_ID_MEM);
+
+    qvirtio_pci_device_enable(dev);
+    qvirtio_start_device(&dev->vdev);
+
+    features = qvirtio_get_features(&dev->vdev);
+    g_assert_true(features & (1ULL << VIRTIO_F_VERSION_1));
+    g_assert_true(features &
+                  (1ULL << VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE));
+    features = (1ULL << VIRTIO_F_VERSION_1) |
+               (1ULL << VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE);
+    qvirtio_set_features(&dev->vdev, features);
+
+    *vq = qvirtqueue_setup(&dev->vdev, alloc, 0);
+    qvirtio_set_driver_ok(&dev->vdev);
+
+    return dev;
+}
+
+static void virtio_mem_request(QVirtioPCIDevice *dev, QVirtQueue *vq,
+                               QGuestAllocator *alloc, uint16_t type,
+                               uint64_t addr, uint16_t nb_blocks)
+{
+    QTestState *qts = global_qtest;
+    struct virtio_mem_req req = {
+        .type = cpu_to_le16(type),
+    };
+    struct virtio_mem_resp resp;
+    uint64_t req_addr, resp_addr;
+    uint32_t free_head;
+
+    if (type == VIRTIO_MEM_REQ_PLUG) {
+        req.u.plug.addr = cpu_to_le64(addr);
+        req.u.plug.nb_blocks = cpu_to_le16(nb_blocks);
+    } else {
+        g_assert_cmpuint(type, ==, VIRTIO_MEM_REQ_UNPLUG);
+        req.u.unplug.addr = cpu_to_le64(addr);
+        req.u.unplug.nb_blocks = cpu_to_le16(nb_blocks);
+    }
+
+    req_addr = guest_alloc(alloc, sizeof(req));
+    resp_addr = guest_alloc(alloc, sizeof(resp));
+    memwrite(req_addr, &req, sizeof(req));
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, sizeof(req), false, true);
+    qvirtqueue_add(qts, vq, resp_addr, sizeof(resp), true, false);
+    qvirtqueue_kick(qts, &dev->vdev, vq, free_head);
+    qvirtio_wait_used_elem(qts, &dev->vdev, vq, free_head, NULL,
+                           5 * G_TIME_SPAN_SECOND);
+
+    memread(resp_addr, &resp, sizeof(resp));
+    g_assert_cmpuint(le16_to_cpu(resp.type), ==, VIRTIO_MEM_RESP_ACK);
+
+    guest_free(alloc, resp_addr);
+    guest_free(alloc, req_addr);
+}
+
+static bool gpa_covered_by_mem_regs(const VhostUserMemoryRegion *regs,
+                                    unsigned int count,
+                                    uint64_t gpa, uint64_t size)
+{
+    uint64_t covered = gpa;
+    uint64_t end = gpa + size;
+
+    while (covered < end) {
+        uint64_t next = covered;
+        unsigned int i;
+
+        for (i = 0; i < count; i++) {
+            uint64_t reg_start = regs[i].guest_phys_addr;
+            uint64_t reg_end = reg_start + regs[i].memory_size;
+
+            if (reg_start <= covered && reg_end > next) {
+                next = reg_end;
+            }
+        }
+
+        if (next == covered) {
+            return false;
+        }
+        covered = next;
+    }
+
+    return true;
+}
+
+static bool has_mem_reg(const VhostUserMemoryRegion *regs,
+                        unsigned int count, uint64_t gpa, uint64_t size)
+{
+    unsigned int i;
+
+    for (i = 0; i < count; i++) {
+        if (regs[i].guest_phys_addr == gpa &&
+            regs[i].memory_size == size) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void wait_for_mem_coverage(TestServer *s, unsigned int from,
+                                  uint64_t gpa, uint64_t size)
+{
+    gint64 end_time;
+
+    g_mutex_lock(&s->data_mutex);
+    end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    while (!gpa_covered_by_mem_regs(&s->add_mem_regs[from],
+                                    s->add_mem_reg_count - from,
+                                    gpa, size)) {
+        if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+            break;
+        }
+    }
+    g_assert_true(gpa_covered_by_mem_regs(&s->add_mem_regs[from],
+                                          s->add_mem_reg_count - from,
+                                          gpa, size));
+    g_mutex_unlock(&s->data_mutex);
+}
+
+static void wait_for_mem_reg(TestServer *s, unsigned int from,
+                             uint64_t gpa, uint64_t size)
+{
+    gint64 end_time;
+
+    g_mutex_lock(&s->data_mutex);
+    end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    while (!has_mem_reg(&s->add_mem_regs[from],
+                        s->add_mem_reg_count - from, gpa, size)) {
+        if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+            break;
+        }
+    }
+    g_assert_true(has_mem_reg(&s->add_mem_regs[from],
+                              s->add_mem_reg_count - from, gpa, size));
+    g_mutex_unlock(&s->data_mutex);
+}
+
+static QVirtioPCIDevice *recreate_net_with_boundary_vring(QVirtioNet *net,
+                                                           uint64_t boundary)
+{
+    QVirtioPCIDevice *old_pdev = container_of(net->vdev,
+                                              QVirtioPCIDevice, vdev);
+    QPCIBus *bus = old_pdev->pdev->bus;
+    QPCIAddress addr = { .devfn = QPCI_DEVFN(4, 0) };
+    QVirtioPCIDevice *pdev;
+    QVirtioDevice *vdev;
+    QVirtQueue vq = { };
+    uint64_t features;
+
+    qpci_unplug_acpi_device_test(global_qtest, "net0", 4);
+    qtest_qmp_device_add(global_qtest, "virtio-net-pci", "net1",
+                         "{'netdev': 'hs0', 'addr': '04.0'}");
+
+    pdev = virtio_pci_new(bus, &addr);
+    g_assert_nonnull(pdev);
+    vdev = &pdev->vdev;
+
+    qvirtio_pci_device_enable(pdev);
+    qvirtio_start_device(vdev);
+    features = qvirtio_get_features(vdev);
+    features &= ~(QVIRTIO_F_BAD_FEATURE |
+                  (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+                  (1ULL << VIRTIO_RING_F_EVENT_IDX));
+    qvirtio_set_features(vdev, features);
+
+    vdev->bus->queue_select(vdev, 0);
+    vq.vdev = vdev;
+    vq.index = 0;
+    vq.size = vdev->bus->get_queue_size(vdev);
+    vq.free_head = 0;
+    vq.num_free = vq.size;
+    vq.align = VIRTIO_PCI_VRING_ALIGN;
+
+    /*
+     * Place the new queue's descriptor table so that the first descriptor is
+     * in the lower memslot and all following descriptors are in the upper
+     * memslot.
+     */
+    qvring_init(global_qtest, NULL, &vq,
+                boundary - sizeof(struct vring_desc));
+    vdev->bus->set_queue_address(vdev, &vq);
+
+    /* qvirtqueue_setup() normally performs this final modern PCI step. */
+    qpci_io_writew(pdev->pdev, pdev->bar,
+                   pdev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_enable), 1);
+    qvirtio_set_driver_ok(vdev);
+
+    return pdev;
+}
+
+static void test_mem_slots_boundary(void *obj, void *arg,
+                                    QGuestAllocator *alloc)
+{
+    TestServer *s = arg;
+    QVirtioNet *net = obj;
+    QPCIBus *bus;
+    QVirtioPCIDevice *dev;
+    QVirtioPCIDevice *net_dev;
+    QVirtQueue *vq;
+    gint64 end_time;
+    uint64_t block_size, mem_addr, region_size;
+    unsigned int initial_add_count;
+    unsigned int third_slot_add_from;
+    unsigned int i;
+
+    g_mutex_lock(&s->data_mutex);
+    end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    while (!s->get_max_mem_slots_count || !s->add_mem_reg_count) {
+        if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+            break;
+        }
+    }
+    g_assert_cmpuint(s->get_max_mem_slots_count, ==, 1);
+    g_assert_cmpuint(s->add_mem_reg_count, >, 0);
+    initial_add_count = s->add_mem_reg_count;
+    g_mutex_unlock(&s->data_mutex);
+
+    bus = qpci_new_pc(global_qtest, alloc);
+    dev = virtio_mem_init(bus, alloc, &vq);
+    block_size = qvirtio_config_readq(&dev->vdev,
+                                      offsetof(struct virtio_mem_config,
+                                               block_size));
+    mem_addr = qvirtio_config_readq(&dev->vdev,
+                                    offsetof(struct virtio_mem_config, addr));
+    region_size = qvirtio_config_readq(&dev->vdev,
+                                       offsetof(struct virtio_mem_config,
+                                                region_size));
+    g_assert_cmpuint(region_size, ==, 3 * GiB);
+
+    g_assert_cmpuint(block_size, <=, GiB);
+    g_assert_true(QEMU_IS_ALIGNED(GiB, block_size));
+
+    /* One request crossing the boundary has to activate slots 0 and 1. */
+    virtio_mem_request(dev, vq, alloc, VIRTIO_MEM_REQ_PLUG,
+                       mem_addr + GiB - block_size, 2);
+    wait_for_mem_coverage(s, initial_add_count, mem_addr, 2 * GiB);
+
+    net_dev = recreate_net_with_boundary_vring(net, mem_addr + GiB);
+
+    g_mutex_lock(&s->data_mutex);
+    third_slot_add_from = s->add_mem_reg_count;
+    g_mutex_unlock(&s->data_mutex);
+
+    /* The third slot must remain separate from the merged first two slots. */
+    virtio_mem_request(dev, vq, alloc, VIRTIO_MEM_REQ_PLUG,
+                       mem_addr + 2 * GiB, 1);
+    wait_for_mem_reg(s, third_slot_add_from, mem_addr + 2 * GiB, GiB);
+
+    g_mutex_lock(&s->data_mutex);
+    for (i = 0; i < 3; i++) {
+        g_assert_true(gpa_covered_by_mem_regs(
+            &s->add_mem_regs[initial_add_count],
+            s->add_mem_reg_count - initial_add_count,
+            mem_addr + i * GiB, GiB));
+    }
+    g_mutex_unlock(&s->data_mutex);
+
+    qvirtqueue_cleanup(dev->vdev.bus, vq, alloc);
+    qos_object_destroy(&dev->obj);
+    qos_object_destroy(&net_dev->obj);
+    qpci_free_pc(bus);
+}
+
 static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *s = arg;
@@ -1090,6 +1453,10 @@ static void vu_net_get_protocol_features(TestServer *s, CharFrontend *chr,
     if (s->queues > 1) {
         msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
     }
+    if (s->configure_mem_slots) {
+        msg->payload.u64 |= 1ULL <<
+                            VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS;
+    }
     qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
 }
 
@@ -1151,6 +1518,14 @@ static void register_vhost_user_test(void)
     qos_add_test("vhost-user/multiqueue",
                  "virtio-net",
                  test_multiqueue, &opts);
+
+    if (qemu_memfd_check(MFD_ALLOW_SEALING) &&
+        qtest_has_device("virtio-mem-pci")) {
+        opts.before = vhost_user_test_setup_mem_slots;
+        opts.edge.extra_device_opts = "id=net0";
+        qos_add_test("vhost-user/mem-slots/boundary",
+                     "virtio-net", test_mem_slots_boundary, &opts);
+    }
 }
 libqos_init(register_vhost_user_test);
 
-- 
2.52.0


