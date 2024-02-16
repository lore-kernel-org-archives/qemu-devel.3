Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132FCC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razTB-0005ir-Qc; Fri, 16 Feb 2024 09:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razTA-0005iG-SI
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:40 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razT8-0005aA-Ff
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so2012887a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094736; x=1708699536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KP3NDJ7dfHzQCSzt0PgrNJvgys3Oy0XprB8gfHPtz30=;
 b=SzmN/DfKCfAwW582Cvc2v0biW/fAtalTGq1AJWkI9i+9ZcXvaJjo8eNaddx1qW0pKk
 5ljPpcuunycwZGgPaz2mYsSXI+WcDWn8/+DaHCiEVU5S6F5XL/4qFWFnJvuggEU/2h76
 WmbrDts/3J7Uo49MGa2tk7P345eZxhQWROhs0asdYgYY7883HR/gwWqsb500CXqNNB0k
 sUzfW0SzD6BDNyjpzPKBL7PdV0QmpgIh3F1sn6ZsnmQ3PBKX21o3Npq1lzFe4foYvCqx
 jmeAK5+9gXISASm86rA9608uIJQGymya6sQugyF0Yn9hhLKDe42uD9G5uqQinx5wEzOA
 8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094736; x=1708699536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KP3NDJ7dfHzQCSzt0PgrNJvgys3Oy0XprB8gfHPtz30=;
 b=YQpl8vMfhvbXRXwy0pbW852dItOYfQou61JMP6RVzQpI0WI+SSdxBEArfu37zbH3jS
 N9TBF9OClxXx0zXB0Bf61aKe6X0433XapivYfhI0LACyBdgOHBtbERiBxa+Tpnyr5ReT
 RaE0vk+B3p7X+S6CrZloxLCPLkrCWwAaci2FXfjJdUYwP7Pg+QXh3T5pEIb5mdG0e1q1
 vWa72dX2m10mWPMgMD/5STbJUiXwRWl+/aPPo8T/zoNOJIramn5qKDRmDs6dQ++DbOk1
 6rvK8a1frcV2NUJftznKyIiCNTz4vsxllkdXEnGd1n16FdorSx5wqAF/LCDCpCRZfesH
 9B4w==
X-Gm-Message-State: AOJu0YzIqgBkc5eU8isUu+yuZTIITyilItK4bYXodsRimit1huXA5L7k
 eAnSyz7J+qlmbQo8A3NbK3LWX3+U9xB7iFs1UyV+vO7uj46MvhvItE0esniYaEyo2m4WxC0fjNa
 L
X-Google-Smtp-Source: AGHT+IFezJ1NTj0Ec/JML69adDR/zjxsCrFj4UPkbD8Hzygfn8YmPSIF0oVv3Yt9F2bgz1Z1iNIpbw==
X-Received: by 2002:a17:906:b794:b0:a3d:2233:13fa with SMTP id
 dt20-20020a170906b79400b00a3d223313famr3587856ejb.55.1708094736506; 
 Fri, 16 Feb 2024 06:45:36 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a170906561700b00a3d828c54f1sm1615697ejq.135.2024.02.16.06.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:45:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] tests/qtest: Add ivshmem-flat test
Date: Fri, 16 Feb 2024 15:44:56 +0100
Message-ID: <20240216144456.34992-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add qtest for the ivshmem-flat device.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20231127052024.435743-4-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ivshmem-flat-test.c | 320 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +
 2 files changed, 322 insertions(+)
 create mode 100644 tests/qtest/ivshmem-flat-test.c

diff --git a/tests/qtest/ivshmem-flat-test.c b/tests/qtest/ivshmem-flat-test.c
new file mode 100644
index 0000000000..5489a0d915
--- /dev/null
+++ b/tests/qtest/ivshmem-flat-test.c
@@ -0,0 +1,320 @@
+/*
+ * Inter-VM Shared Memory Flat Device qtests
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "ivshmem-utils.h"
+
+#define IVSHMEM_FLAT_MMR_ADDR 0x400FF000
+#define IVSHMEM_FLAT_SHM_ADDR 0x40100000
+#define SHM_SIZE 131072 /* 128k */
+
+static ServerThread thread;
+
+uint32_t *shm_ptr;
+char *shm_rel_path;
+char *server_socket_path;
+
+static void cleanup(void)
+{
+    if (shm_ptr) {
+        munmap(shm_ptr, SHM_SIZE);
+        shm_ptr = NULL;
+    }
+
+    if (shm_rel_path) {
+        shm_unlink(shm_rel_path);
+        shm_rel_path = NULL;
+    }
+
+    if (server_socket_path) {
+        unlink(server_socket_path);
+        server_socket_path = NULL;
+    }
+}
+
+static void abort_handler(void *data)
+{
+    test_ivshmem_server_stop(&thread);
+    cleanup();
+}
+
+/*
+ * Check if exactly 1 positive pulse (low->high->low) on 'irq' IRQ line happens
+ * in 'timeout' second(s). 'irq' must be intercepted using qtest_irq_intercept_*
+ * before this function can be used on it. It returns 0 when pulse is detected,
+ * otherwise 1.
+ */
+static int test_ivshmem_flat_irq_positive_pulse(QTestState *qts, int irq,
+                                                int timeout)
+{
+    uint64_t num_raises = 0;
+    uint64_t num_lows = 0;
+    uint64_t end_time;
+
+    end_time = g_get_monotonic_time() + timeout * G_TIME_SPAN_SECOND;
+    do {
+        num_raises = qtest_get_irq_raised_counter(qts, 0);
+        if (num_raises) {
+            num_lows = qtest_get_irq_lowered_counter(qts, 0);
+            /* Check for 1 raise and 1 low IRQ event. */
+            if (num_raises == num_lows && num_lows == 1) {
+                return 0;
+            } else {
+                g_message("%s: Timeout expired", __func__);
+                return 1;
+            }
+        }
+        qtest_clock_step(qts, 10000);
+    } while (g_get_monotonic_time() < end_time);
+
+    return 1;
+}
+
+static inline uint32_t read_reg(QTestState *qts, enum Reg reg)
+{
+    uint32_t v;
+
+    qtest_memread(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
+
+    return v;
+}
+
+static inline void write_reg(QTestState *qts, enum Reg reg, uint32_t v)
+{
+    qtest_memwrite(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
+}
+
+/*
+ * Setup a test VM with ivshmem-flat device attached, IRQ properly set, and
+ * connected to the ivshmem-server.
+ */
+static QTestState *setup_vm(void)
+{
+    QTestState *qts;
+    const char *cmd_line;
+
+    cmd_line = g_strdup_printf("-machine lm3s6965evb "
+                               "-chardev socket,path=%s,id=ivshm "
+                               "-device ivshmem-flat,chardev=ivshm,"
+                               "x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',"
+                               "x-bus-qompath='/sysbus',shmem-size=%d",
+                               server_socket_path, SHM_SIZE);
+    qts = qtest_init(cmd_line);
+
+    return qts;
+}
+
+static void test_ivshmem_flat_irq(void)
+{
+    QTestState *vm_state;
+    uint16_t own_id;
+
+    vm_state = setup_vm();
+
+    qtest_irq_intercept_out_named(vm_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* IVPOSTION has the device's own ID distributed by the ivshmem-server. */
+    own_id = read_reg(vm_state, IVPOSITION);
+
+    /* Make device notify itself. */
+    write_reg(vm_state, DOORBELL, (own_id << 16) | 0 /* vector 0 */);
+
+    /*
+     * Check intercepted device's IRQ output line. Named IRQ line 'irq-output'
+     * was associated to qtest IRQ 0 and after self notification qtest IRQ 0
+     * must be toggled by the device. The test fails if no toggling is detected
+     * in 2 seconds.
+     */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm_state, 0, 2) == 0);
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_write(void)
+{
+    QTestState *vm_state;
+    int num_elements, i;
+    uint32_t  *data;
+
+    vm_state = setup_vm();
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE / sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /*
+     * Write test data to VM address IVSHMEM_FLAT_SHM_ADDR, where the shared
+     * memory region is located.
+     */
+    qtest_memwrite(vm_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /*
+     * Since the shared memory fd is mmapped into this test process VMA at
+     * shm_ptr, every byte written by the VM in its shared memory region should
+     * also be available in the test process via shm_ptr. Thus, data in shm_ptr
+     * is compared back against the original test data.
+     */
+    for (i = 0; i < num_elements; i++) {
+        g_assert_cmpint(shm_ptr[i], ==, data[i]);
+    }
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_read(void)
+{
+    QTestState *vm_state;
+    int num_elements, i;
+    uint32_t  *data;
+    uint32_t v;
+
+    vm_state = setup_vm();
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE / sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /*
+     * Copy test data to the shared memory region so it can be read from the VM
+     * (IVSHMEM_FLAT_SHM_ADDR location).
+     */
+    memcpy(shm_ptr, data, SHM_SIZE);
+
+    /* Check data */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_pair(void)
+{
+    QTestState *vm0_state, *vm1_state;
+    uint16_t vm0_peer_id, vm1_peer_id;
+    int num_elements, i;
+    uint32_t  *data;
+    uint32_t v;
+
+    vm0_state = setup_vm();
+    vm1_state = setup_vm();
+
+    /* Get peer ID for the VM so it can be used for one notify each other. */
+    vm0_peer_id = read_reg(vm0_state, IVPOSITION);
+    vm1_peer_id = read_reg(vm1_state, IVPOSITION);
+
+    /* Observe vm1 IRQ output line first. */
+    qtest_irq_intercept_out_named(vm1_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* Notify (interrupt) VM1 from VM0. */
+    write_reg(vm0_state, DOORBELL, (vm1_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM1 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm1_state, 0, 2) == 0);
+
+    /* Secondly, observe VM0 IRQ output line first. */
+    qtest_irq_intercept_out_named(vm0_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* ... and do the opposite: notify (interrupt) VM0 from VM1. */
+    write_reg(vm1_state, DOORBELL, (vm0_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM0 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm0_state, 0, 2) == 0);
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE / sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /* Write test data on VM0. */
+    qtest_memwrite(vm0_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /* Check test data on VM1. */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm1_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    /* Prepare new test data with random values. */
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /* Write test data on VM1. */
+    qtest_memwrite(vm1_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /* Check test data on VM0. */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm0_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    qtest_quit(vm0_state);
+    qtest_quit(vm1_state);
+}
+
+int main(int argc, char *argv[])
+{
+    int shm_fd, r;
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* If test fails, stop server, cleanup socket and shm files. */
+    qtest_add_abrt_handler(abort_handler, NULL);
+
+    shm_rel_path = mktempshm(SHM_SIZE, &shm_fd);
+    g_assert(shm_rel_path);
+
+    /*
+     * Map shm to this test's VMA so it's possible to read/write from/to it. For
+     * VMs with the ivhsmem-flat device attached, this region will also be
+     * mapped in their own memory layout, at IVSHMEM_FLAT_SHM_ADDR (default).
+     */
+    shm_ptr = mmap(0, SHM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
+    g_assert(shm_ptr != MAP_FAILED);
+
+    server_socket_path = mktempsocket();
+    /* It never fails, so no assert(). */
+
+    /*
+     * Currently, ivshmem-flat device only supports notification via 1 vector,
+     * i.e. vector 0.
+     */
+    test_ivshmem_server_start(&thread, server_socket_path, shm_rel_path, 1);
+
+    /* Register tests. */
+    qtest_add_func("/ivshmem-flat/irq", test_ivshmem_flat_irq);
+    qtest_add_func("/ivshmem-flat/shm-write", test_ivshmem_flat_shm_write);
+    qtest_add_func("/ivshmem-flat/shm-read", test_ivshmem_flat_shm_read);
+    qtest_add_func("/ivshmem-flat/pair", test_ivshmem_flat_shm_pair);
+
+    r = g_test_run();
+
+    test_ivshmem_server_stop(&thread);
+    cleanup();
+
+    return r;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bc6457220c..c0468bc6e0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -205,6 +205,7 @@ qtests_stm32l4x5 = \
    'stm32l4x5_syscfg-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_IVSHMEM_FLAT_DEVICE') ? ['ivshmem-flat-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
@@ -320,6 +321,7 @@ qtests = {
   'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'ivshmem-flat-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
-- 
2.41.0


