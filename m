Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E830D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd7-0001cI-2J; Mon, 26 Jan 2026 12:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQch-0001K4-TH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcf-0008V9-71
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-480142406b3so32372085e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449411; x=1770054211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JVcXy0dwK/92fGA+np6cVxIVwdiBdpVuuBvIqmsfVg=;
 b=LGwrmPOP57ZB4GCtoSDiDT5dfLyiLDq8rHNofyKZCZ1yxWCbP2XKOYfHPs5hzXmB9c
 tidxZ1F+EQn1FU4p/teVW95USRpxZN9h9NPKErP81UdXqX/vyQ1wV8PoKgisNXkStBH0
 Tzm35+MaU6I9cccN8VO3XL5YQliII4FeaiEVR4cGCCGV+67CR75FfAbUVLK9f3QLm/ws
 DC+Vu+tXzEqA2ItZ57YYh7YAtj0NyYfVY/1pJSZu88l5aGmwkjzRh+/7xnqKKtrwZ6XI
 g0XzWG8DcHbtL2J6EstYnTq2vrdWU0p3bkWEqBq/IfA7neOTQyU1OvB81ZaD2kBoMWZf
 9DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449411; x=1770054211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JVcXy0dwK/92fGA+np6cVxIVwdiBdpVuuBvIqmsfVg=;
 b=J5MLfWAGrvDUGFaCkt4JkNomD3vfEzhbYIugfQq4D6RiaLMyzF3ddt5li0ZbK2m63h
 uMH9qsdsh18vNy123k8h+mSGfG9NvdZ4rMa6m5fpeP5sNB+GJgtzHgtl5FH46ICRy/3O
 bmE5ZxDbF1rdEAbGb3sGAuvQBw27cmD5y71PYBmoBKcsrQj+U5qYOIzOFkS09igU//XY
 xifH24KiZXCJVq30NKS7r33Eo+/y6uY8DJNcqS6+KdocY96CTt1BxLjaefAFEXWC3MWv
 dB//u/plaYsv6mRTc4U5xsW7eeDQcLFNiNJLqL4huusGoXE0LBeIg779WO3OLq8HTZgU
 z5vw==
X-Gm-Message-State: AOJu0YwWl0vkQfyQStodMCNLARxd2he6d2WJHtVBTqOSKtoDV1nFjmNc
 U/HalzWenAZaIqufhc/9LlzTImFqecrEE2/1Q+jfY1L8jgT6hqqRF/P+e1DpzLv4
X-Gm-Gg: AZuq6aKgLNP+bkjjrdoB4qAZId8b+UgTG2Oo/0paNUqr/Y/AYeQqgmCbMwF9PIIBLB2
 ZYGfZFFAgkuH/aDmlx1Dw+Se6JGXPYxgjQJmaI8kiiEZTyVd1WsqqvfP2NwhJCsMwkz4TamtL/j
 XkfrodIxWuTdz1NzM3s05kPvMFuh180zHH5RxpHSwKsl/Uhh+ceXg5bjz3NwsCufcOKPbWAZV68
 5TVbwBer/yikenZZ8yBCpUaFQSU62+lmVZKQtqwkO/6GcMha7Am/MLZwuUunJzUNKHvU8qs6bty
 8RujrLEqdda289YfoijKhF29QG59/HAxL6ZooyMdreq1zgCmnxWIphGX47JahO2/TL7053U6Jq8
 pTWVE+naVVCg1zezvkOZ2RfYGM8PUMUD5kUpF0TxYmzYTV4eLSvxlWh7w/pLsb0uJFpA7LMBwWc
 yKQCniM59KB6KHswJf96zCH9mR9bozAU/ePuLYA7GCs90zS5Yypk6iRg==
X-Received: by 2002:a05:600c:a00f:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-4805cf6365bmr83782395e9.24.1769449411109; 
 Mon, 26 Jan 2026 09:43:31 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:30 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 07/27] hw/core/fdt_generic_util: implement main fdt parse
 routine
Date: Mon, 26 Jan 2026 18:42:53 +0100
Message-ID: <20260126174313.1418150-8-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement main fdt_generic_create_machine() routine.

As of now do the following:

- parse each node and subnode in device tree
- check node has correct compatible or device types
- call fdt_init_qdev() which will eventually create
  device object.

The MIT license of fdt_generic_util.c preserved as in original
file from https://github.com/Xilinx/qemu.git repo.

The license for fdt_generic_util.h derived from matching
fdt_generic_util.c file.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 242 +++++++++++++++++++++++++++++
 include/hw/core/fdt_generic_util.h |  19 +++
 2 files changed, 261 insertions(+)
 create mode 100644 hw/core/fdt_generic_util.c
 create mode 100644 include/hw/core/fdt_generic_util.h

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
new file mode 100644
index 0000000000..4338dc956b
--- /dev/null
+++ b/hw/core/fdt_generic_util.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Utility functions for fdt generic framework
+ *
+ * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (c) 2009 Michal Simek.
+ * Copyright (c) 2011 PetaLogix Qld Pty Ltd.
+ * Copyright (c) 2011 Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/fdt_generic_util.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
+#include "hw/core/sysbus.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/config-file.h"
+#include "hw/core/boards.h"
+#include "qemu/option.h"
+
+#ifndef FDT_GENERIC_UTIL_ERR_DEBUG
+#define FDT_GENERIC_UTIL_ERR_DEBUG 3
+#endif
+#define DB_PRINT(lvl, ...) do { \
+    if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
+        qemu_log_mask(LOG_FDT, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DB_PRINT_NP(lvl, ...) do { \
+    if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(LOG_FDT, "%s", node_path); \
+        DB_PRINT((lvl), ## __VA_ARGS__); \
+    } \
+} while (0)
+
+/* FIXME: wrap direct calls into libfdt */
+
+#include <libfdt.h>
+#include <stdlib.h>
+
+static int fdt_generic_num_cpus;
+
+static int simple_bus_fdt_init(char *bus_node_path, FDTMachineInfo *fdti);
+
+FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
+{
+    char node_path[DT_PATH_LENGTH];
+    FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
+
+    fdti->irq_base = cpu_irq;
+
+    /* parse the device tree */
+    if (!qemu_devtree_get_root_node(fdt, node_path)) {
+        memory_region_transaction_begin();
+        fdt_init_set_opaque(fdti, node_path, NULL);
+        simple_bus_fdt_init(node_path, fdti);
+        while (qemu_co_enter_next(fdti->cq, NULL)) {
+            ;
+        }
+        memory_region_transaction_commit();
+    } else {
+        fprintf(stderr, "FDT: ERROR: cannot get root node from device tree %s\n"
+            , node_path);
+    }
+
+    /* FIXME: Populate these from DTS and create CPU clusters.  */
+    current_machine->smp.cores = fdt_generic_num_cpus;
+    current_machine->smp.cpus = fdt_generic_num_cpus;
+    current_machine->smp.max_cpus = fdt_generic_num_cpus;
+
+    DB_PRINT(0, "FDT: Device tree scan complete\n");
+    return fdti;
+}
+
+struct FDTInitNodeArgs {
+    char *node_path;
+    char *parent_path;
+    FDTMachineInfo *fdti;
+};
+
+static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat);
+
+static int check_compat(const char *prefix, const char *compat,
+                        char *node_path, FDTMachineInfo *fdti)
+{
+    char *compat_prefixed = g_strconcat(prefix, compat, NULL);
+    const int done = !fdt_init_compat(node_path, fdti, compat_prefixed);
+    g_free(compat_prefixed);
+    return done;
+}
+
+static void fdt_init_node(void *args)
+{
+    struct FDTInitNodeArgs *a = args;
+    char *node_path = a->node_path;
+    FDTMachineInfo *fdti = a->fdti;
+    g_free(a);
+
+    simple_bus_fdt_init(node_path, fdti);
+
+    const char *prop;
+    char *all_compats = NULL, *node_name;
+    char *device_type = NULL;
+    int prop_len;
+
+    DB_PRINT_NP(1, "enter\n");
+
+    /* try instance binding first */
+    node_name = qemu_devtree_get_node_name(fdti->fdt, node_path);
+    DB_PRINT_NP(1, "node with name: %s\n", node_name ? node_name : "(none)");
+    if (!node_name) {
+        printf("FDT: ERROR: nameless node: %s\n", node_path);
+    }
+    if (!fdt_init_inst_bind(node_path, fdti, node_name)) {
+        DB_PRINT_NP(0, "instance bind successful\n");
+        goto exit;
+    }
+
+    /* fallback to compatibility binding */
+    prop = qemu_fdt_getprop(fdti->fdt, node_path, "compatible",
+                            &prop_len, false, NULL);
+    all_compats = g_memdup2(prop, prop_len);
+    if (all_compats) {
+        char *compat = all_compats;
+        char * const end = &all_compats[prop_len - 1]; /* points to nul */
+
+        while (compat < end) {
+            if (check_compat("compatible:", compat, node_path, fdti)) {
+                goto exit;
+            }
+
+            if (!fdt_init_qdev(node_path, fdti, compat)) {
+                check_compat("postinit:", compat, node_path, fdti);
+                goto exit;
+            }
+
+            /* Scan forward to the end of the current compat. */
+            while (compat < end && *compat) {
+                ++compat;
+            }
+
+            /* Replace nul with space for the debug printf below. */
+            if (compat < end) {
+                *compat++ = ' ';
+            }
+        };
+    } else {
+        DB_PRINT_NP(0, "no compatibility found\n");
+    }
+
+    /*
+     * Try to create the device using device_type property
+     * Not every device tree node has compatible  property, so
+     * try with device_type.
+     */
+    prop = qemu_fdt_getprop(fdti->fdt, node_path,
+                            "device_type", &prop_len, false, NULL);
+    device_type = g_memdup2(prop, prop_len);
+    if (device_type) {
+        if (check_compat("device_type:", device_type, node_path, fdti)) {
+            goto exit;
+        }
+
+        if (!fdt_init_qdev(node_path, fdti, device_type)) {
+            goto exit;
+        }
+    }
+
+    if (all_compats) {
+        DB_PRINT_NP(0, "FDT: Unsupported peripheral invalidated - "
+                    "compatibilities %s\n", all_compats);
+        qemu_fdt_setprop_string(fdti->fdt, node_path, "compatible",
+                                "invalidated");
+    }
+exit:
+
+    DB_PRINT_NP(1, "exit\n");
+
+    if (!fdt_init_has_opaque(fdti, node_path)) {
+        fdt_init_set_opaque(fdti, node_path, NULL);
+    }
+    g_free(node_path);
+    g_free(all_compats);
+    g_free(device_type);
+    return;
+}
+
+static int simple_bus_fdt_init(char *node_path, FDTMachineInfo *fdti)
+{
+    int i;
+    int num_children = qemu_devtree_get_num_children(fdti->fdt, node_path,
+                                                        1);
+    char **children;
+
+    if (num_children == 0) {
+        return 0;
+    }
+    children = qemu_devtree_get_children(fdti->fdt, node_path, 1);
+
+    DB_PRINT_NP(num_children ? 0 : 1, "num child devices: %d\n", num_children);
+
+    for (i = 0; i < num_children; i++) {
+        struct FDTInitNodeArgs *init_args = g_malloc0(sizeof(*init_args));
+        init_args->node_path = children[i];
+        init_args->fdti = fdti;
+        qemu_coroutine_enter(qemu_coroutine_create(fdt_init_node, init_args));
+    }
+
+    g_free(children);
+    return 0;
+}
+
+static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
+{
+    return 0;
+}
+
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
new file mode 100644
index 0000000000..e18c4f9c8b
--- /dev/null
+++ b/include/hw/core/fdt_generic_util.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: MIT
+
+#ifndef FDT_GENERIC_UTIL_H
+#define FDT_GENERIC_UTIL_H
+
+#include "qemu/help-texts.h"
+#include "fdt_generic.h"
+#include "system/memory.h"
+#include "qom/object.h"
+
+/*
+ * create a fdt_generic machine. the top level cpu irqs are required for
+ * systems instantiating interrupt devices. The client is responsible for
+ * destroying the returned FDTMachineInfo (using fdt_init_destroy_fdti)
+ */
+
+FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
+
+#endif /* FDT_GENERIC_UTIL_H */
-- 
2.43.0


