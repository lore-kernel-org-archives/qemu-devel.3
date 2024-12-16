Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E3E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBwc-0004Z2-2L; Mon, 16 Dec 2024 09:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwJ-0004FM-Rx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:16 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwH-0000F4-Lu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:15 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728f1e66418so3545675b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358752; x=1734963552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94ccA70iDICvEcEEecoRJQseSGw3jJcmWkfmX5CpvjY=;
 b=AWr/Phz6g4sCNr3kVmbk6B/aM9XaFP/blpVT0AGE7X2I1rBYtlrqxdqeAnDjfwX5+x
 H+jyjTI4wEC3k3n08c5Kq/p5NPpQKvgyEH6DHrIubRYcsII+JSlln0EVEBZ0XuOnbWIw
 3btC0z7H5UZV4ha0VaywLDMi5ehF0rjhWBGNXoWHHwfFTSAb11a8shNXjOH4/fqg/SAM
 5Ncg9rU1j/jdSmpcJSyOqfKOTB44Lwlavcf3ewrfgYvLMpYxSEKI7AHRh9drWTzpTEL0
 PZi3CuOzJmKU7o/tMFZoWKCyuo960dULDpvBeQhZAx3WlMSwvzn9h8Dx9+d7wcbtnaj4
 QGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358752; x=1734963552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94ccA70iDICvEcEEecoRJQseSGw3jJcmWkfmX5CpvjY=;
 b=PEjDiKE43jawzPei6QXfXSpuYSVjYFdOk5ac381QDKLkyMEOsq9/lAzDGajnjkeiRQ
 NNIOvr0QAaMfclN7M/U7zmjtxwAzlLkBtW1hTvqPxeIO7UZDMa/Odv8DFnrjPnlLAtnn
 PFajwAKLUoRPND9aYm+QwfNSlv5lBC1YVbm4es4NFWQkCyFGkbuo52++4cObs4RqdBxz
 zA7GDkNkogi2Grb981q5qxH9OBlhAyZ4kHiBFGAFHwNWhkRBGt0jxOeKFnh4DCvWHYJr
 8kzL/LVOkqAgq9Dke8J8e/Y08u0Kh/QO8j3MuB6VQ4EZsZwgimNDLKb1CXmyRi+7gxXV
 YCBQ==
X-Gm-Message-State: AOJu0Yz4vfZ4n9hwOWy1m8k9w6gHLT1D/WCNRWczi0R2xlnHu1pWlUT5
 /9NBqYMPuHtRHWfZOnknk8ap3Bf5NQEx1G13JUKmZKq575qPNTF0121GzXJd2aWP06vIW4EoE3R
 0
X-Gm-Gg: ASbGncsUw6UalnumxM//tMaETtasSgdjK9NqLn+fb7wE4+dYJ51tLCWsT1iwGKJtNw/
 RsBFb4x5DSch/lrqFB5XePzHA5IvBeud1eUpmho2VGnX1lyO4FbI5McldL1SCSpMAqyBAoi+g21
 /WZRe5TzTilWeNBp4/da6m2QEReanisJd09Wk0FNu/1Z0UAdw6NLW4cB54gpsY8QpXfz3/m7Vs6
 4CXCsxg+Cz0HrwTIudiMcY1pgH2Z/6UCQjQW/lKO/ADru7PA2CMV3vMXLuGMHk=
X-Google-Smtp-Source: AGHT+IHZiMKCJVcdmkDgAGPVguj+/fHzriRMCIzGP4HKMXfGp497ep12JcCbEbnCLd4Igqv7ZoG3tQ==
X-Received: by 2002:a05:6a00:c96:b0:724:bf30:147d with SMTP id
 d2e1a72fcca58-7290c17f109mr17786307b3a.11.1734358751898; 
 Mon, 16 Dec 2024 06:19:11 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:19:11 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 7/7] tests/qtest: Add ivshmem-flat test
Date: Mon, 16 Dec 2024 14:18:18 +0000
Message-Id: <20241216141818.111255-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit adds a qtest for the ivshmem-flat device to test memory
sharing, IRQ triggering, and the memory mapped registers in the device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/ivshmem-flat-test.c | 338 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +
 2 files changed, 340 insertions(+)
 create mode 100644 tests/qtest/ivshmem-flat-test.c

diff --git a/tests/qtest/ivshmem-flat-test.c b/tests/qtest/ivshmem-flat-test.c
new file mode 100644
index 0000000000..b6f59bba54
--- /dev/null
+++ b/tests/qtest/ivshmem-flat-test.c
@@ -0,0 +1,338 @@
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
+ * Check if exactly 1 positive pulse (low->high->low) on 'irq' qtest IRQ line
+ * happens. N.B.: 'irq' must be intercepted using qtest_irq_intercept_* before
+ * this function can be used on it. It returns 0 when pulse is detected,
+ * otherwise 1.
+ */
+static int test_ivshmem_flat_irq_positive_pulse(QTestState *qts, int irq)
+{
+    uint64_t num_raises = 0;
+    uint64_t num_lows = 0;
+    int attempts = 0;
+
+    while (attempts < 5) {
+        num_raises = qtest_get_irq_raised_counter(qts, 0);
+        if (num_raises) {
+            num_lows = qtest_get_irq_lowered_counter(qts, 0);
+            /* Check for exactly 1 raise and 1 low IRQ event */
+            if (num_raises == num_lows && num_lows == 1) {
+                return 0; /* Pulse detected */
+            }
+        }
+
+	g_usleep(10000);
+	attempts++;
+    }
+
+    g_message("%s: Timeout expired", __func__);
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
+    /*
+     * x-bus-address-{iomem,shmem} are just random addresses that don't conflict
+     * with any other address in the lm3s6965evb machine. shmem-size used is
+     * much smaller than the ivshmem server default (4 MiB) to save memory
+     * resources when testing.
+     */
+    cmd_line = g_strdup_printf("-machine lm3s6965evb "
+                               "-chardev socket,path=%s,id=ivshm "
+                               "-device ivshmem-flat,chardev=ivshm,"
+                               "x-irq-qompath='/machine/soc/v7m/nvic/unnamed-gpio-in[0]',"
+                               "x-bus-address-iomem=%#x,"
+                               "x-bus-address-shmem=%#x,"
+                               "shmem-size=%d",
+                               server_socket_path,
+                               IVSHMEM_FLAT_MMR_ADDR,
+                               IVSHMEM_FLAT_SHM_ADDR,
+                               SHM_SIZE);
+
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
+                                  "sysbus-irq");
+
+    /* IVPOSTION has the device's own ID distributed by the ivshmem-server. */
+    own_id = read_reg(vm_state, IVPOSITION);
+
+    /* Make device notify itself. */
+    write_reg(vm_state, DOORBELL, (own_id << 16) | 0 /* vector 0 */);
+
+    /*
+     * Check intercepted device's IRQ output line. 'sysbus-irq' was associated
+     * to qtest IRQ 0 when intercepted and after self notification qtest IRQ 0
+     * must be toggled by the device. The test fails if no toggling is detected.
+     */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm_state,
+                                                  0 /* qtest IRQ */) == 0);
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
+                                  "sysbus-irq");
+
+    /* Notify (interrupt) VM1 from VM0. */
+    write_reg(vm0_state, DOORBELL, (vm1_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM1 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm1_state,
+                                                  0 /* qtest IRQ */) == 0);
+
+    /* Secondly, observe VM0 IRQ output line first. */
+    qtest_irq_intercept_out_named(vm0_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "sysbus-irq");
+
+    /* ... and do the opposite: notify (interrupt) VM0 from VM1. */
+    write_reg(vm1_state, DOORBELL, (vm0_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM0 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm0_state,
+                                                  0 /* qtest IRQ */) == 0);
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
+    if (!qtest_has_machine("lm3s6965evb")) {
+        g_test_skip("Machine Stellaris (lm3s6965evb) not found, "
+                    "skipping ivshmem-flat device test.");
+        return 0;
+    }
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
index bf1fd12a9e..29e800999b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -225,6 +225,7 @@ qtests_stm32l4x5 = \
    'stm32l4x5_usart-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_IVSHMEM_FLAT_DEVICE') ? ['ivshmem-flat-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
@@ -362,6 +363,7 @@ qtests = {
                              'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'ivshmem-flat-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
-- 
2.34.1


