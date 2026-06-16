Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD22CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkJ-0002q8-9N; Tue, 16 Jun 2026 06:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkH-0002cu-Jw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:13 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkF-0004Qf-Aw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:13 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8585c51f1fso1923285a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604610; x=1782209410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDcBqXOk+JVQEs3ga9uCnVy4SK8KaG7zGbX66L90UAg=;
 b=O7WRxs1USbeTXl1fm66NlsBh7LQ5j5JWSFrxLg56e9hYX49TfN9u8NrPXnxeAZeYtU
 2jeNE1CWDbN7n6DMnE+PYM885DkdJM7ZhScmyR29zUPqZfYqmH7VHLwUV2gwfUkTergj
 2WK0HyaWEsmW9Kzynx5R3pUZuf0XAa5KSdzNezHnL4qzw2OQHc5Mw30BeTUJdj/ShUE+
 90OXVDJzlFjjUPrdDg5ellCQjgDuhnIQfZtAikPjtF73aAndBHZVhGMH1VqRtPh5+Fl5
 qrvV57/KNi7RIYctGfpOZ2rNq1G2CSxYiHhm6P5sHNW+YHxHFR2nk63j4jhF7Ui8K2rq
 qFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604610; x=1782209410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDcBqXOk+JVQEs3ga9uCnVy4SK8KaG7zGbX66L90UAg=;
 b=f/PSmbto9btF9Zkl18Or6sUJ3iKuPz+/Di//WWcS8FeJn0T0aHnIZfx3XHJJwNjlC8
 4+Ua7yiQXDyIeuc2LKFFirmdGShymN9idxTDk9zBUeO0Onlu2pky2NaVgJi1+TujDYH9
 WI/zlcjLBTeX4Mzif996mIU9vxKRbNKTl9sjQduFFxB6BDRtcSJxgETRDzhBezD3ydW8
 OZK7jFSIJ4jAW7qRra65sM1Mx9cYckYIhImb+w0c6Q1HxirOoEbT2Y9fDIT9xnGWhCpu
 iZxvBMTxPuSjrxPkaprvEHz4bH+lFLjpIDmk0qgGdi1Am1+ojHM3u63uPSW5JK6wFjvp
 HeDQ==
X-Gm-Message-State: AOJu0YyOm8rNphfT0O2Ggj0WTWYGV5jDY68Fe5PVkcNLDs5LxgXTrgtt
 LZL5gGvkq84ueIfGGcQvB8vhcoNHM3n8fT+s2vAtXwmYMmu1Tqeoin6OQVetgZwL
X-Gm-Gg: Acq92OFJjC0GuEBwLhpSZL9XOFi3q7U3oRHHzFtKDmnGgC7UzvYbhrJC0AozHCqWRKO
 w3vn+w3BbT/tDZsYwJvPM1KZOs5avLCqSn8T52mJ4pkvHle0tQBDgpk9j3MSGDjV8QLTUod1iv3
 OtWWMOKl+EtZXIFfBFNvASlT0JuWuWbfHshYe6M+gpi6aBlYCLDGX2r/go8u3r5H9UNwPjvOIU3
 6frAvRT2GvnAFxQRGsZ9ig4Uc3BQ+RPtCgKiTDhHijj5+Ya3YR+puwA24jfacgE9fYst0u9UkU0
 POiiqpgHr3LGG+wR6PoNTwRw9EDOXjS7yRMj8yQxmaqbLcyQRNWvladLjsMtXW6rNt6Pw2FtADV
 uwb7swTjnnVPuOLjkYSkGtq6qU5+RvMjiy5MW0mkgoyViFho2cJBfw5ECE5u00cOY5jYizagkg6
 wm6dClkjrTgOngIUG9rrdCZOXtnAeegw+uEQZrzMRt
X-Received: by 2002:a05:6a20:9f43:b0:3a2:ed4a:5d7e with SMTP id
 adf61e73a8af0-3b7e2494868mr2967541637.22.1781604609766; 
 Tue, 16 Jun 2026 03:10:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 79/83] hw/riscv: add fdt_create_cpu_socket_subnode() helper
Date: Tue, 16 Jun 2026 20:05:22 +1000
Message-ID: <20260616100527.1939565-80-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

Consolidate the '/cpus' FDT root node creation into a single place.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-10-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  1 +
 hw/riscv/fdt-common.c         | 10 ++++++++++
 hw/riscv/sifive_u.c           |  7 +------
 hw/riscv/spike.c              |  7 +------
 hw/riscv/virt.c               | 11 +++--------
 5 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 6e81d6cd6c..27020e69c6 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -18,4 +18,5 @@ void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
 void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
                              int socket_id, uint32_t *intc_phandles,
                              int num_harts, bool numa_enabled);
+void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index d2661ec389..02ac9ddcd8 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -83,3 +83,13 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
         qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket_id);
     }
 }
+
+void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
+{
+    qemu_fdt_add_subnode(fdt, "/cpus");
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
+                          timebase_frequency);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a4265fed0f..27c1a74d99 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -139,12 +139,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
                              ms->ram_size, 0, false);
 
-    qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
-        CLINT_TIMEBASE_FREQ);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
-    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+    fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
 
     clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
     qemu_fdt_add_subnode(fdt, clust_name);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b15188fb07..ee8232f734 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -73,12 +73,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
     }
 
-    qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
-        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
-    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+    fdt_create_cpu_socket_subnode(fdt, RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
         g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b134f11266..6641b60131 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -694,14 +694,9 @@ static void create_fdt_sockets(RISCVVirtState *s,
     int socket_count = riscv_socket_count(ms);
     bool numa_enabled = riscv_numa_enabled(ms);
 
-    qemu_fdt_add_subnode(ms->fdt, "/cpus");
-    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
-                          kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
-                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
-    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
-    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
+    fdt_create_cpu_socket_subnode(ms->fdt,
+        kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
     intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
-- 
2.54.0


