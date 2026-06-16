Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA679CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk4-0000yg-Ks; Tue, 16 Jun 2026 06:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjv-0008MD-VK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:52 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjt-00049J-TL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:51 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8583b8fd89so2610530a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604588; x=1782209388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVkyfPCQGMRLChnENkb4WZSDiUfeKQOkpPMn/WD6mhs=;
 b=mmyLFeCKSdxX3umYgY28NN66/n7ONnf2NMmsxT0ioJzxeJ5BPtkdivwtZcnGTMX4P0
 7SXMJdOkKES01TbgRp75p6oCW6P7UrOS4PHm4u1LMNd01bFTfOpmBvStKgQSfdi+N9DS
 fgE6gW4VK4A9VQY4UJggnkZu0d3r+Np2Fm+ZJ+D+5paCiepsW/4wB5Euu3gm2UdAMT5/
 3ANKTj9nlyO7QtDQPB98Ys8FqbKJTXjhTYlwuRr81EVzv95Uuhc4NQz/MksrbpWh7o4T
 gVP13GHh2N7xRzL3dgGTNS2BQy+WyqNZw7c3/SOB746yL4dB+KU0KfthnRTzLDAREzlT
 dRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604588; x=1782209388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVkyfPCQGMRLChnENkb4WZSDiUfeKQOkpPMn/WD6mhs=;
 b=QaulRtT59sOm/KMBCmpCzMAGdMML2fCSvJEdk2dTe6VjVJYY19v8EaZDM72ZpAn7AX
 TOhundFb58gg34FBM5tFjOyd2tjSB1133+XmHOVnagYrdQ+MeJ/5NolHTl+hpFfBTNEW
 h1iWF7oQh0XouVezoOJZ6tV8c37mqbc13gAr1+3n8nZH1u3uDKvtBaFpSz3QH9v+7fUi
 dilixTTGu4XFvJqtxL7pD1d7KoDqXayBaZSGUJFk7gI4+Pn/EqgYAkydI/I9NsCEsfjs
 j+JahGTcTt/nCQG/o8FMqJNXA3brMF3TMT8snF1KCo51GJEJDG96JmYy7WaLiBnWAsxu
 9AOg==
X-Gm-Message-State: AOJu0YyD4IA/dxhClrTNH4KWAuHxjp/FxIqipjNt7KE3MYzTiWeJ0SL6
 sChxzz8vzF2hUzpWGEc6rN75b2ToBw+vBnxqnSu85ZYLYeWRK3QMKqO9TtPJtxCT
X-Gm-Gg: Acq92OF9qPmOm+T0nPAI6QVLq2IfoeVPrQxVLxYm/bDx3UvN8v7Fi4N7Ov9yrKze1Gb
 Zo3fE7p2eZLJQ6/U9/uEPslnifeN96te8kqdzMi5SBNqfiB+WbHx/D8CcnP3XHuQOgt/NG2PITC
 YIq1NxlhIRm7/ct3MeY8DMKSP9VeoU3Dv4Dr9yIUNw/8YNSMu8zmJiTh20KyzU5h1RRXUgRcSp1
 fbd4QX9XZo/96VeIdu+gT/SLnA5VnDiZlrtdtxMgE98T1fSIR/8aMhPKQ2H3IEjUAVVVd0Jghx4
 j5dzf2hzYY+2xNof3LgST5DCD58mZ2EEDHMcGTo8HJyoZoOS26IdunBmINXN+Sal6jWrqBNeqGC
 beXJfUda96PnnkNc4y7Kz3hawLNXru/XP6wzEE2iJoZZKgv3h9q4Ki1Nu0AEGQSz0IDNlpyIUxZ
 mzxx+GV7EiQhnjttqRep2JijAArpY1wnOo2gUaOK9WOKOKQiQJHic=
X-Received: by 2002:a05:6a20:1615:b0:3b4:736b:da61 with SMTP id
 adf61e73a8af0-3b784193115mr21617730637.35.1781604588457; 
 Tue, 16 Jun 2026 03:09:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 72/83] hw/riscv: add fdt-common helper
Date: Tue, 16 Jun 2026 20:05:15 +1000
Message-ID: <20260616100527.1939565-73-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

There's too much duplication between RISC-V boards and one of the most
common culprits is the FDT functions.

Add a new file for board FDT helpers.  Start by creating a helper that
initializes the FDT and init it with the common board boilerplate.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h | 14 +++++++++++++
 hw/riscv/fdt-common.c         | 37 +++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c           | 20 +++----------------
 hw/riscv/spike.c              | 19 +++---------------
 hw/riscv/virt.c               | 19 +++---------------
 hw/riscv/meson.build          |  1 +
 6 files changed, 61 insertions(+), 49 deletions(-)
 create mode 100644 include/hw/riscv/fdt-common.h
 create mode 100644 hw/riscv/fdt-common.c

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
new file mode 100644
index 0000000000..adf9b33dfd
--- /dev/null
+++ b/include/hw/riscv/fdt-common.h
@@ -0,0 +1,14 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_VIRT_FDT_H
+#define RISCV_VIRT_FDT_H
+
+void *create_board_device_tree(const char *model, const char *compatible,
+                               int *fdt_size);
+#endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
new file mode 100644
index 0000000000..b155246998
--- /dev/null
+++ b/hw/riscv/fdt-common.c
@@ -0,0 +1,37 @@
+/*
+ * RISC-V board helpers for FDT generation.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/error-report.h"
+#include "system/device_tree.h"
+#include "hw/riscv/fdt-common.h"
+
+void *create_board_device_tree(const char *model, const char *compatible,
+                               int *fdt_size)
+{
+    void *fdt = create_device_tree(fdt_size);
+
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_setprop_string(fdt, "/", "model", model);
+    qemu_fdt_setprop_string(fdt, "/", "compatible", compatible);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+
+    return fdt;
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3abbd6c823..5d3b2751ad 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -52,6 +52,7 @@
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/machines-qom.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -112,23 +113,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         "sifive,plic-1.0.0", "riscv,plic0"
     };
 
-    fdt = ms->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
-    qemu_fdt_setprop_string(fdt, "/", "compatible",
-                            "sifive,hifive-unleashed-a00");
-    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
-
-    qemu_fdt_add_subnode(fdt, "/soc");
-    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+    fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
+        "sifive,hifive-unleashed-a00", &s->fdt_size);
 
     hfclk_phandle = phandle++;
     nodename = g_strdup_printf("/hfclk");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f9d00e0d5c..79c9bb041f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -32,6 +32,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
@@ -66,16 +67,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         "sifive,clint0", "riscv,clint0"
     };
 
-    fdt = ms->fdt = create_device_tree(&fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
-    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+    fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
+        "ucbbar,spike-bare-dev", &fdt_size);
 
     qemu_fdt_add_subnode(fdt, "/htif");
     qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
@@ -84,12 +77,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
     }
 
-    qemu_fdt_add_subnode(fdt, "/soc");
-    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
-
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0c489bb412..cb1d83fd48 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/fdt-common.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
@@ -1150,22 +1151,8 @@ static void create_fdt(RISCVVirtState *s)
     uint8_t rng_seed[32];
     g_autofree char *name = NULL;
 
-    ms->fdt = create_device_tree(&s->fdt_size);
-    if (!ms->fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
-    }
-
-    qemu_fdt_setprop_string(ms->fdt, "/", "model", "riscv-virtio,qemu");
-    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-virtio");
-    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
-
-    qemu_fdt_add_subnode(ms->fdt, "/soc");
-    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus");
-    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
+    ms->fdt = create_board_device_tree("riscv-virtio,qemu", "riscv-virtio",
+                                       &s->fdt_size);
 
     /*
      * The "/soc/pci@..." node is needed for PCIE hotplugs
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 09cf855984..b70a054579 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,6 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
-- 
2.54.0


