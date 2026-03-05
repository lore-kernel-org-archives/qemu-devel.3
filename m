Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87161F3D32A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBk3-000635-84; Thu, 05 Mar 2026 11:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjx-000624-1x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjq-0000YF-7k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUU03jfn1S/Xmk+XV/n4eBP9ME+gJywPqDFPRjRBDPs=;
 b=K+WE7Y66TgrCZVG4SKj4XjxeVkPSN958pD1wnzJOW76uuf0EMCSfGV0BJqeNRYVKlWKjTL
 96bT9Z1ei95N+HbWaS++eT421rLsaD0tIQROJgR83txFG2xroXogki3+MyKYOTzhv89GhI
 j/RGapQxALbAl8XT3uxwBeBuKLkA88c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-QwNru9kbNF2q5HtF2WaDgQ-1; Thu,
 05 Mar 2026 11:39:47 -0500
X-MC-Unique: QwNru9kbNF2q5HtF2WaDgQ-1
X-Mimecast-MFC-AGG-ID: QwNru9kbNF2q5HtF2WaDgQ_1772728787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5AD61956054; Thu,  5 Mar 2026 16:39:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A625E1958DC5; Thu,  5 Mar 2026 16:39:43 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 1/8] tests: vhost-vdpa: add initial VDUSE-based vhost-vdpa
 tests
Date: Thu,  5 Mar 2026 17:39:31 +0100
Message-ID: <20260305163938.3200787-2-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Based on vhost-user tests, the qos register itself as a VDUSE device and
receives the events from QEMU.

The test infrastructure creates a thread that acts as a VDUSE device,
while the regular test thread is managing QEMU.

This basic test just verify that the guest memory ring addresses are
accessible, similar to the already existing test in vhost-user.

This enables automated testing of vhost-vdpa code paths that previously
required manual testing with real hardware.

Changes from vhost-user test:
* Automatic cleanup of many things.
* Handle the vduse fd and timeout.
* VDPA device cannot be removed before deleting QEMU, killing QEMU in
  vhost_vdpa_test_cleanup.
* Read in enable callbacks, and the actual test_read_guest_mem is just
  waiting.
* Add vhost_vdpa_thread to abstract fd monitoring
* Use QemuMutex and QemuConf for scoped cleanup

RFC: I'm not sure if this is the right place to add the tests in meson.
Also, a few things are just with asserts() or g_spawn(), instead of
more elegant code.

Also, I don't know how to include the libvduse.a library as meson
complains it's out of the tests/ directory, so I'm including the .c
directly.  Ugly but it works.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/meson.build       |   3 +
 tests/qtest/vhost-vdpa-test.c | 426 ++++++++++++++++++++++++++++++++++
 2 files changed, 429 insertions(+)
 create mode 100644 tests/qtest/vhost-vdpa-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ba9f59d2f8f7..0fdc8fb4a764 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -346,6 +346,9 @@ endif
 if have_tools and have_vhost_user_blk_server
   qos_test_ss.add(files('vhost-user-blk-test.c'))
 endif
+if have_libvduse and have_vhost_vdpa
+  qos_test_ss.add(files('vhost-vdpa-test.c'))
+endif
 
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
new file mode 100644
index 000000000000..1fc5acacfed3
--- /dev/null
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -0,0 +1,426 @@
+/*
+ * QTest testcase for vhost-vdpa using VDUSE devices
+ *
+ * Based on vhost-user-test.c
+ * Copyright (c) 2014 Virtual Open Systems Sarl.
+ * Copyright (c) 2026 - VDUSE adaptation
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/lockable.h"
+
+#include "libqtest-single.h"
+#include "qapi/error.h"
+#include "libqos/qgraph.h"
+#include "hw/virtio/virtio-net.h"
+
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_net.h"
+
+#include "subprojects/libvduse/linux-headers/linux/vduse.h"
+#include "subprojects/libvduse/libvduse.h"
+
+#include <poll.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/vhost.h>
+
+/* TODO fix this */
+#include "subprojects/libvduse/libvduse.c"
+
+#define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM," \
+                        "mem-path=%s,share=on -numa node,memdev=mem"
+#define QEMU_CMD_VDPA   " -netdev type=vhost-vdpa,vhostdev=%s,id=hs0"
+#define VDUSE_RECONNECT_LOG "vduse_reconnect.log"
+
+typedef struct VdpaThread {
+    GThread *thread;
+    GMainLoop *loop;
+    GMainContext *context;
+} VdpaThread;
+
+static void *vhost_vdpa_thread_function(void *data)
+{
+    GMainLoop *loop = data;
+    g_main_loop_run(loop);
+    return NULL;
+}
+
+static void vhost_vdpa_thread_init(VdpaThread *t)
+{
+    t->context = g_main_context_new();
+    t->loop = g_main_loop_new(t->context, FALSE);
+    t->thread = g_thread_new("vdpa-thread", vhost_vdpa_thread_function, t->loop);
+}
+
+static void vhost_vdpa_thread_cleanup(VdpaThread *t)
+{
+    g_main_loop_quit(t->loop);
+    g_thread_join(t->thread);
+
+    while (g_main_context_pending(NULL)) {
+        g_main_context_iteration(NULL, TRUE);
+    }
+
+    g_main_loop_unref(t->loop);
+    g_main_context_unref(t->context);
+}
+
+static void vhost_vdpa_thread_add_source_fd(VdpaThread *t, int fd,
+                                            GUnixFDSourceFunc func, void *data)
+{
+    GSource *src = g_unix_fd_source_new(fd, G_IO_IN);
+    g_source_set_callback(src, (GSourceFunc)func, data, NULL);
+    g_source_attach(src, t->context);
+    g_source_unref(src);
+}
+
+typedef struct TestServer {
+    gchar *vduse_name;
+    gchar *vdpa_dev_path;
+    gchar *tmpfs;
+    int vq_read_num;
+    VduseDev *vdev;
+    VdpaThread vdpa_thread;
+    QemuMutex data_mutex;
+    QemuCond data_cond;
+    bool ready;
+} TestServer;
+
+static bool test_read_first_byte(int dev_fd, uint64_t addr)
+{
+    struct vduse_iotlb_entry entry;
+    int fd;
+    void *mmap_addr;
+
+    entry.start = addr;
+    entry.last = addr + 1;
+
+    fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+    if (fd < 0) {
+        g_test_message("Failed to get fd for iova 0x%" PRIx64 ": %s",
+                       addr, strerror(errno));
+        return false;
+    }
+
+    mmap_addr = mmap(0, 1, PROT_READ, MAP_SHARED, fd, 0);
+    if (mmap_addr == MAP_FAILED) {
+        close(fd);
+        g_test_message("Failed to mmap fd for iova 0x%" PRIx64 ": %s",
+                       addr, strerror(errno));
+        goto close_fd;
+    }
+
+    *(volatile  uint8_t *)mmap_addr;
+    munmap(mmap_addr, 1);
+
+close_fd:
+    close(fd);
+
+    return true;
+}
+
+static void vduse_read_guest_mem_enable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    TestServer *s = vduse_dev_get_priv(dev);
+    int dev_fd = vduse_dev_get_fd(dev);
+    struct vduse_vq_info vq_info;
+    int ret;
+
+    g_test_message("Enabling queue %d", vq->index);
+
+    /* Get VQ info to retrieve ring addresses */
+    vq_info.index = vq->index;
+    ret = ioctl(dev_fd, VDUSE_VQ_GET_INFO, &vq_info);
+    if (ret < 0 || !vq_info.ready) {
+        return;
+    }
+
+    test_read_first_byte(dev_fd, vq_info.desc_addr);
+    test_read_first_byte(dev_fd, vq_info.driver_addr);
+    test_read_first_byte(dev_fd, vq_info.device_addr);
+
+    QEMU_LOCK_GUARD(&s->data_mutex);
+    s->vq_read_num++;
+    if (s->vq_read_num == 2) {
+        /* Notify the test that we have read the rings for both queues */
+        qemu_cond_broadcast(&s->data_cond);
+    }
+}
+
+static void vduse_read_guest_mem_disable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    /* Queue disabled */
+}
+
+static const VduseOps vduse_read_guest_mem_ops = {
+    .enable_queue = vduse_read_guest_mem_enable_queue,
+    .disable_queue = vduse_read_guest_mem_disable_queue,
+};
+
+static gboolean vduse_dev_handler_source_fd(int fd, GIOCondition condition,
+                                            void *data)
+{
+    TestServer *s = data;
+    int r;
+
+    if (poll(&(struct pollfd){.fd = fd, .events = POLLIN}, 1, 0) <= 0) {
+        return G_SOURCE_CONTINUE /* Spurious */;
+    }
+
+    r = vduse_dev_handler(s->vdev);
+    assert (r == 0);
+    return G_SOURCE_CONTINUE;
+}
+
+typedef enum {
+    VDPA_DEV_ADD,
+    VDPA_DEV_DEL,
+} vdpa_cmd_t;
+
+/* TODO: Issue proper nl commands */
+static int netlink_vdpa_device_do(vdpa_cmd_t cmd, const char *vduse_name)
+{
+    g_autoptr(GError) err = NULL;
+    g_auto(GStrv) argv = g_strdupv(
+        (cmd == VDPA_DEV_ADD) ?
+            (char **)(const char *[]){"vdpa", "dev", "add", "name", vduse_name,
+                            "mgmtdev", "vduse", NULL} :
+            (char **)(const char *[]){"vdpa", "dev", "del", vduse_name, NULL});
+    GSpawnFlags flags = G_SPAWN_DEFAULT | G_SPAWN_SEARCH_PATH |
+                        G_SPAWN_STDIN_FROM_DEV_NULL |
+                        G_SPAWN_STDOUT_TO_DEV_NULL |
+                        G_SPAWN_STDERR_TO_DEV_NULL;
+    if (cmd == VDPA_DEV_DEL) {
+        /* TODO: del blocks in read() for the write_err_and_exit, or just for
+         * the child to properly close child_err_report_pipe. But, either way,
+         * it causes the test to hang if we don't set this flag.
+         *
+         * It seems run under gdb step by step also makes the parent able to
+         * continue, so probably a race condition?
+         *
+         * glib2-devel-2.84.4.
+         */
+        flags |= G_SPAWN_LEAVE_DESCRIPTORS_OPEN;
+    }
+    gint wait_status = 0;
+
+    if (!g_spawn_sync(/* working_dir */ NULL, argv, /* envp */ NULL, flags,
+                      /* child_setup */ NULL, /* user_data */ NULL,
+                      /* standard_output */ NULL, /* standard_error */ NULL,
+                      &wait_status, &err)) {
+        g_test_message("Failed to execute command: %s", err->message);
+        return -1;
+    }
+
+    assert(WIFEXITED(wait_status));
+    if (WEXITSTATUS(wait_status) != 0) {
+        g_test_message("Command failed with exit code: %d",
+                       WEXITSTATUS(wait_status));
+        return wait_status;
+    }
+
+    return WEXITSTATUS(wait_status);
+}
+
+static char *vhost_find_device(const char *name)
+{
+    /* Find vhost-vdpa device name */
+    g_autoptr(GDir) dir = NULL;
+    g_autoptr(GError) err = NULL;
+    g_autofree char *sys_path = g_strdup_printf("/sys/devices/virtual/vduse/%s/%s",
+                                                name,
+                                                name);
+    dir = g_dir_open(sys_path, 0, &err);
+    if (!dir) {
+        g_test_message("Failed to open sys path %s: %s", sys_path, err->message);
+        return NULL;
+    }
+
+    for (const char *entry; (entry = g_dir_read_name(dir)) != NULL; ) {
+        if (g_str_has_prefix(entry, "vhost-vdpa-")) {
+            return g_strdup_printf("/dev/%s", entry);
+        }
+    }
+
+    return NULL;
+}
+
+static bool test_setup_reconnect_log(VduseDev *vdev, const char *tmpfs)
+{
+    g_autofree char *filename = NULL;
+    g_autoptr(GError) err = NULL;
+    int fd, r;
+    bool ok;
+
+    filename = g_build_filename(tmpfs, "vhost-vdpa-test-XXXXXX", NULL);
+    fd = g_mkstemp_full(filename, 0, 0600);
+    if (fd < 0) {
+        g_test_message("Failed to create temporary file for reconnect log: %s",
+                       g_strerror(errno));
+        return false;
+    }
+
+    /* TODO: Properly handle errors here */
+    r = vduse_set_reconnect_log_file(vdev, filename);
+    assert(r == 0);
+    r = unlink(filename);
+    assert(r == 0);
+    ok = g_close(fd, &err);
+    assert(ok == TRUE);
+
+    return ok;
+}
+
+static TestServer *test_server_new(const gchar *name)
+{
+    TestServer *server = g_new0(TestServer, 1);
+    g_autoptr(GError) err = NULL;
+    g_autofree char *tmpfs = NULL;
+    char config[sizeof(struct virtio_net_config)] = {0};
+    uint64_t features;
+
+    vhost_vdpa_thread_init(&server->vdpa_thread);
+
+    server->vduse_name = g_strdup_printf("vdpa-test-%s", name);
+
+    qemu_mutex_init(&server->data_mutex);
+    qemu_cond_init(&server->data_cond);
+
+    features = vduse_get_virtio_features() |
+               (1ULL << VIRTIO_NET_F_MAC);
+
+    server->vdev = vduse_dev_create(server->vduse_name,
+                                    VIRTIO_ID_NET,
+                                    0x1AF4, /* PCI vendor ID */
+                                    features,
+                                    2, /* num_queues */
+                                    sizeof(config),
+                                    config,
+                                    &vduse_read_guest_mem_ops,
+                                    server);
+
+    if (!server->vdev) {
+        return server;
+    }
+
+    vhost_vdpa_thread_add_source_fd(&server->vdpa_thread, server->vdev->fd,
+                                    vduse_dev_handler_source_fd, server);
+
+    tmpfs = g_dir_make_tmp("vhost-test-XXXXXX", &err);
+    if (!tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+    }
+    g_assert_nonnull(tmpfs);
+    server->tmpfs = g_steal_pointer(&tmpfs);
+
+    test_setup_reconnect_log(server->vdev, server->tmpfs);
+    vduse_dev_setup_queue(server->vdev, 0, VIRTQUEUE_MAX_SIZE);
+    vduse_dev_setup_queue(server->vdev, 1, VIRTQUEUE_MAX_SIZE);
+
+    if (netlink_vdpa_device_do(VDPA_DEV_ADD, server->vduse_name) != 0) {
+        g_test_message("Failed to add vdpa device");
+        return server;
+    }
+    server->vdpa_dev_path = vhost_find_device(server->vduse_name);
+    if (!server->vdpa_dev_path) {
+        return server;
+    }
+
+    server->ready = true;
+
+    return server;
+}
+
+static void test_server_free(TestServer *server)
+{
+    g_test_message("About to call vdpa del device");
+
+    netlink_vdpa_device_do(VDPA_DEV_DEL, server->vduse_name);
+
+    /* finish the helper thread and dispatch pending sources */
+    vhost_vdpa_thread_cleanup(&server->vdpa_thread);
+
+    if (server->vdev) {
+        vduse_dev_destroy(server->vdev);
+    }
+
+    g_free(server->vduse_name);
+    g_free(server->vdpa_dev_path);
+    g_free(server->tmpfs);
+
+    qemu_cond_destroy(&server->data_cond);
+    qemu_mutex_destroy(&server->data_mutex);
+    g_free(server);
+}
+
+static void wait_for_vqs(TestServer *s)
+{
+    gint64 end_time_us;
+
+    QEMU_LOCK_GUARD(&s->data_mutex);
+    end_time_us = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    while (s->vq_read_num < 2) {
+        if (!qemu_cond_timedwait(&s->data_cond, &s->data_mutex,
+                                 end_time_us - g_get_monotonic_time())) {
+            /* timeout has passed */
+            g_assert_cmpint(s->vq_read_num, ==, 2);
+            break;
+        }
+    }
+}
+
+static void vhost_vdpa_test_cleanup(void *s)
+{
+    TestServer *server = s;
+
+    /* Cannot delete vdpa dev until QEMU stops using it. */
+    qtest_kill_qemu(global_qtest);
+    test_server_free(server);
+}
+
+static void *vhost_vdpa_test_setup_memfile(GString *cmd_line, void *arg)
+{
+    TestServer *server = test_server_new("vdpa-memfile");
+
+    if (!server->ready) {
+        g_test_skip("Failed to create VDUSE device");
+        test_server_free(server);
+        return NULL;
+    }
+
+    g_string_append_printf(cmd_line, QEMU_CMD_MEM, 256, 256, server->tmpfs);
+    g_string_append_printf(cmd_line, QEMU_CMD_VDPA, server->vdpa_dev_path);
+    g_test_message("cmdline: %s", cmd_line->str);
+
+    g_test_queue_destroy(vhost_vdpa_test_cleanup, server);
+
+    return server;
+}
+
+static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *server = arg;
+
+    wait_for_vqs(server);
+}
+
+static void register_vhost_vdpa_test(void)
+{
+    QOSGraphTestOptions opts = {
+        .before = vhost_vdpa_test_setup_memfile,
+        .subprocess = true,
+        .arg = NULL,
+    };
+
+    qos_add_test("vhost-vdpa/read-guest-mem/memfile",
+                 "virtio-net",
+                 test_read_guest_mem, &opts);
+}
+libqos_init(register_vhost_vdpa_test);
-- 
2.53.0


