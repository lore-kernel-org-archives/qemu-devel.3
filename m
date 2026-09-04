Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C1C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLz-0006Oz-Dm; Fri, 04 Sep 2026 01:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLx-0006NL-VD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLv-0001IE-68
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-848643382fcso629296b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499238; x=1789104038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GPrfp88ogz4tD9DNngXxMsmxVqrldb0v5scyqRFRYzI=;
 b=aQdf4zapV7TU/JYTIZoBbZ14R88aRxSYiIA17gtc9v2hAcj3ln9TFEKvZ1eZT932aP
 CkO/PntoS05//aD2fyFlyirT4qnIY6aSzcT4PRJIaEOitb6sn1kMA++Ymwv3Zn6wZo03
 vAMpRnevLkChtqv6kSNZrzmM1PeDXgEMWPc+tQxdrVCVtTlCofSqqjQavUPasn/iIaft
 9O1YpPoLvfh9OP/feOfsf8o7HuntoRy4UxdcP+PFlRXOhDcNFxgjPD93RE576H8mn7WA
 F1xhlsIgGbiJUvDPlEOsfMm0+HFyeWqfb1J13+5MiGgp75+ZRU9kXhmoOKgCkWbJgHaC
 Zs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499238; x=1789104038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GPrfp88ogz4tD9DNngXxMsmxVqrldb0v5scyqRFRYzI=;
 b=WcO5+3WNhJFST7aw64llwUs3acBFXuJuOLfZhjT+JTcXfmJEDpcDEDNDDznNXJ/M4P
 V6/LWmrGFjC+BA1AixmIOO7teX1LlCpciNKSsxKP1YHjwqVve3ge0B7XyAA9eabW/Pn4
 AHB9g239SqeNNibofPZ558PfjHl06Purc6A48LY3p/XOh8RQ30uso/Gs+9nQEoJq1gS8
 DHvd+LvxYTQo6jHslJ5mLs0SJgsnQQ0nt3EezsE0Droax8A2+BbxPrsnpGRaVRdqtgOx
 ZuerVeCiff8HtaVtrhFy41phkzJQ6L4IKW4VzBgnyyN7fNhZZf6B9qjUwyYuzqRzjMSG
 SLGw==
X-Gm-Message-State: AFuF++lIE4mNOpTUD5TbzoyV/inb46MtvrgYuRt5m75Gvp/k7CuFxTGC
 u9EPTfez0bZ6ZTmSViLFGH3C5Hl5OXPMuvPpn2BE0TQrQ0mb+Np7Wk/0a1kQVQ==
X-Gm-Gg: AYBFou3mDjf3/VJ7hnc57ZI7XYm0Djm/J5ExGtHbmDfh0LuhPjSkF5w3m6I7N2aDoB6
 R7sFM4fdQowr28LH4CkJ/mbmAmrNT+ivdLgE558Ydexb5RrV5oBnahLaiey0uSjORf59p0QjCP4
 Y2qRmNlAqC9TJb7LxM8ky96LfbV6CoR40KzIL6EQAhbBSmOp0/WMdLT6BOWf/PFb3tRU8EFhhVp
 kbUGpvUxBA1ok2Y3jEcJU54s0DszNks/JApMDECgeuTZ9MTpc4LnZv5XKABFjtGmrYQARd4JVhq
 VtUAPmSGwuUmV6POSxEp68+S2JZBNTHoeqNVAyn7SVwW8hZ7TiaajtSqdQMC16zFKYlH2Xwnt5F
 52mx5QlPSgJWRhNU/hgp09vmsCu3mrHJ4ZMUXn7e+XYc9JCVuhu+T1cwXg17Ae/Eok460xkFGQw
 vdCN2aMho7CwzEaJ7UUw90nfBq9M/ZGS+KoO+sPCQ/boA22MRDWwF99r/uTfLztHiVzftlK0GuJ
 ZYIE3a4NtvInaud
X-Received: by 2002:a05:6a20:9f86:b0:3d0:cc29:ff64 with SMTP id
 adf61e73a8af0-3da39ff00c1mr5646562637.15.1788499237596; 
 Thu, 03 Sep 2026 22:20:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/47] hw/riscv/fdt-common: prepend helpers with "riscv_"
Date: Fri,  4 Sep 2026 15:19:10 +1000
Message-ID: <20260904051943.799041-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

Given that the helpers are public API we should prefix them with
"riscv_" to avoid conflicts when linking with different targets in the
future, i.e. we should not use generic names like
"create_fdt_socket_memory".

Despite the amount of lines this is a mechanical change and no real
FDT changes are intended.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260828203918.350131-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
 hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
 hw/riscv/sifive_u.c           | 34 +++++++++++++------------
 hw/riscv/spike.c              | 30 ++++++++++++----------
 hw/riscv/tt_atlantis.c        | 22 ++++++++--------
 hw/riscv/virt.c               | 42 +++++++++++++++---------------
 6 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 1729a6abc6..371971d79d 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,29 +11,31 @@
 
 #include "target/riscv/cpu.h"
 
-void *create_board_device_tree(const char *model, const char *compatible,
-                               int *fdt_size);
-void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
-                              int socket_id, bool numa_enabled);
-void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
-                      uint32_t *intc_phandles, int num_harts);
-void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
-                             int socket_id, uint32_t *intc_phandles,
-                             int num_harts, bool numa_enabled);
-void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency);
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit);
-void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
-                                  int cpu_id, int socket_id,
+void *riscv_create_board_device_tree(const char *model, const char *compatible,
+                                     int *fdt_size);
+void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                                    int socket_id, bool numa_enabled);
+void riscv_create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
+                            uint32_t *intc_phandles, int num_harts);
+void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                                   int socket_id, uint32_t *intc_phandles,
+                                   int num_harts, bool numa_enabled);
+void riscv_fdt_create_cpu_socket_subnode(void *fdt,
+                                         uint64_t timebase_frequency);
+void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                                  int socket_id, int num_harts_socket,
                                   int socket_hartid_base, uint32_t *phandle,
-                                  uint32_t *intc_phandles);
-void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
-                     uint32_t plic_phandle, uint32_t int_cells,
-                     uint32_t addr_cells, uint32_t *plic_cells,
-                     uint32_t cells_size, uint32_t ndev_sources,
-                     bool numa_enabled, int socket);
+                                  uint32_t *intc_phandles, bool numa_enabled,
+                                  bool is_32_bit);
+void riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                        int cpu_id, int socket_id,
+                                        int socket_hartid_base,
+                                        uint32_t *phandle,
+                                        uint32_t *intc_phandles);
+void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                           uint32_t plic_phandle, uint32_t int_cells,
+                           uint32_t addr_cells, uint32_t *plic_cells,
+                           uint32_t cells_size, uint32_t ndev_sources,
+                           bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index aa143a618b..3a8da03cfb 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -14,8 +14,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 
-void *create_board_device_tree(const char *model, const char *compatible,
-                               int *fdt_size)
+void *riscv_create_board_device_tree(const char *model, const char *compatible,
+                                     int *fdt_size)
 {
     void *fdt = create_device_tree(fdt_size);
 
@@ -38,8 +38,8 @@ void *create_board_device_tree(const char *model, const char *compatible,
     return fdt;
 }
 
-void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
-                              int socket_id, bool numa_enabled)
+void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                                    int socket_id, bool numa_enabled)
 {
     g_autofree char *mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
 
@@ -52,9 +52,9 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
     }
 }
 
-void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
-                             int socket_id, uint32_t *intc_phandles,
-                             int num_harts, bool numa_enabled)
+void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                                   int socket_id, uint32_t *intc_phandles,
+                                   int num_harts, bool numa_enabled)
 {
     g_autofree uint32_t *clint_cells = g_new0(uint32_t, num_harts * 4);
     g_autofree char *clint_name = NULL;
@@ -84,7 +84,8 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
     }
 }
 
-void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
+void riscv_fdt_create_cpu_socket_subnode(void *fdt,
+                                         uint64_t timebase_frequency)
 {
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
@@ -169,11 +170,11 @@ create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
     qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
 }
 
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit)
+void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                                  int socket_id, int num_harts_socket,
+                                  int socket_hartid_base, uint32_t *phandle,
+                                  uint32_t *intc_phandles, bool numa_enabled,
+                                  bool is_32_bit)
 {
     g_autofree char *clust_name = NULL;
 
@@ -191,21 +192,21 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
 }
 
 void
-create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
-                             int cpu_id, int socket_id,
-                             int socket_hartid_base, uint32_t *phandle,
-                             uint32_t *intc_phandles)
+riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                   int cpu_id, int socket_id,
+                                   int socket_hartid_base, uint32_t *phandle,
+                                   uint32_t *intc_phandles)
 {
     create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
                                    socket_id, socket_hartid_base,
                                    phandle, intc_phandles, false, false);
 }
 
-void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
-                     uint32_t plic_phandle, uint32_t int_cells,
-                     uint32_t addr_cells, uint32_t *plic_cells,
-                     uint32_t cells_size, uint32_t ndev_sources,
-                     bool numa_enabled, int socket_id)
+void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                           uint32_t plic_phandle, uint32_t int_cells,
+                           uint32_t addr_cells, uint32_t *plic_cells,
+                           uint32_t cells_size, uint32_t ndev_sources,
+                           bool numa_enabled, int socket_id)
 {
     g_autofree char *nodename = NULL;
     static const char * const plic_compat[2] = {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 997ee91aa0..a40f82e7a5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -107,8 +107,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
     g_autofree char *clust_name = NULL;
 
-    fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
-        "sifive,hifive-unleashed-a00", &s->fdt_size);
+    fdt = ms->fdt = riscv_create_board_device_tree(
+        "SiFive HiFive Unleashed A00",
+        "sifive,hifive-unleashed-a00",
+        &s->fdt_size);
 
     hfclk_phandle = phandle++;
     nodename = g_strdup_printf("/hfclk");
@@ -132,10 +134,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     g_free(nodename);
 
-    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
-                             ms->ram_size, 0, false);
+    riscv_create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
+                                   ms->ram_size, 0, false);
 
-    fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
 
     clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
     qemu_fdt_add_subnode(fdt, clust_name);
@@ -156,15 +158,15 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
 
-        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
-                                     &phandle, intc_phandles);
+        riscv_create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
+                                           &phandle, intc_phandles);
 
         g_free(nodename);
     }
 
-    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
-                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
-                            intc_phandles, ms->smp.cpus, false);
+    riscv_create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
+                                  memmap[SIFIVE_U_DEV_CLINT].size, 0,
+                                  intc_phandles, ms->smp.cpus, false);
 
     nodename = g_strdup_printf("/soc/otp@%lx",
         (long)memmap[SIFIVE_U_DEV_OTP].base);
@@ -208,12 +210,12 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         }
     }
 
-    create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
-                    memmap[SIFIVE_U_DEV_PLIC].size,
-                    plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
-                    SIFIVE_U_PLIC_ADDR_CELLS, cells,
-                    cells_length * sizeof(uint32_t),
-                    SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
+    riscv_create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
+                          memmap[SIFIVE_U_DEV_PLIC].size,
+                          plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
+                          SIFIVE_U_PLIC_ADDR_CELLS, cells,
+                          cells_length * sizeof(uint32_t),
+                          SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
     g_free(cells);
 
     gpio_phandle = phandle++;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index e36fe996b0..5fd4109d29 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -60,8 +60,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     uint32_t phandle = 1;
     bool numa_enabled = riscv_numa_enabled(ms);
 
-    fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
-        "ucbbar,spike-bare-dev", &fdt_size);
+    fdt = ms->fdt = riscv_create_board_device_tree(
+        "ucbbar,spike-bare,qemu",
+        "ucbbar,spike-bare-dev",
+        &fdt_size);
 
     qemu_fdt_add_subnode(fdt, "/htif");
     qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
@@ -70,7 +72,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
     }
 
-    fdt_create_cpu_socket_subnode(fdt, RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt,
+                                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
         g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
@@ -79,20 +82,21 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize =  riscv_socket_mem_size(ms, socket);
 
-        create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
-                               s->soc[socket].num_harts,
-                               s->soc[socket].hartid_base,
-                               &phandle, intc_phandles, numa_enabled,
-                               is_32_bit);
+        riscv_create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
+                                     s->soc[socket].num_harts,
+                                     s->soc[socket].hartid_base,
+                                     &phandle, intc_phandles, numa_enabled,
+                                     is_32_bit);
 
-        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
-                                 riscv_numa_enabled(ms));
+        riscv_create_fdt_socket_memory(fdt, memaddr, memsize, socket,
+                                       riscv_numa_enabled(ms));
 
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
-        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
-                                socket, intc_phandles,
-                                s->soc[socket].num_harts, numa_enabled);
+        riscv_create_fdt_socket_clint(fdt, clint_addr,
+                                      memmap[SPIKE_CLINT].size, socket,
+                                      intc_phandles, s->soc[socket].num_harts,
+                                      numa_enabled);
     }
 
     riscv_socket_fdt_write_distance_matrix(ms);
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index fda848c3a6..db8a1805d7 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -90,16 +90,17 @@ static void create_fdt_memory(TTAtlantisState *s)
         size_hi = MACHINE(s)->ram_size - size_lo;
     }
 
-    create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
-                             0, false);
+    riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
+                                   size_lo, 0, false);
     if (size_hi) {
         /*
          * The first part of the HI address is aliased at the LO address
          * so do not include that as usable memory. Is there any way
          * (or good reason) to describe that aliasing 2GB with DT?
          */
-        create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_HI].base + size_lo,
-                                 size_hi, 0, false);
+        riscv_create_fdt_socket_memory(fdt,
+                                       s->memmap[TT_ATL_DDR_HI].base + size_lo,
+                                       size_hi, 0, false);
     }
 }
 
@@ -224,11 +225,11 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
     void *fdt = MACHINE(s)->fdt;
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
-    fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
-                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
-                           false, false);
+    riscv_create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
+                                 s->soc.hartid_base, &fdt_phandle,
+                                 intc_phandles, false, false);
 
     create_fdt_memory(s);
 
@@ -366,8 +367,9 @@ static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
 
-    ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
-                                       "tenstorrent,atlantis", &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree(
+        "Tenstorrent Atlantis RISC-V Machine",
+        "tenstorrent,atlantis", &s->fdt_size);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c43a23af02..ef97d04031 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -359,12 +359,12 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
 
     plic_phandles[socket] = (*phandle)++;
 
-    create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
-                    plic_phandles[socket], FDT_PLIC_INT_CELLS,
-                    FDT_PLIC_ADDR_CELLS, plic_cells,
-                    cells_length * sizeof(uint32_t),
-                    VIRT_IRQCHIP_NUM_SOURCES - 1,
-                    numa_enabled, socket);
+    riscv_create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
+                          plic_phandles[socket], FDT_PLIC_INT_CELLS,
+                          FDT_PLIC_ADDR_CELLS, plic_cells,
+                          cells_length * sizeof(uint32_t),
+                          VIRT_IRQCHIP_NUM_SOURCES - 1,
+                          numa_enabled, socket);
 
     if (!socket) {
         platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
@@ -600,7 +600,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
 
-    fdt_create_cpu_socket_subnode(ms->fdt,
+    riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
@@ -614,14 +614,14 @@ static void create_fdt_sockets(RISCVVirtState *s,
 
         phandle_pos -= s->soc[socket].num_harts;
 
-        create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
-                               s->soc[socket].num_harts,
-                               s->soc[socket].hartid_base,
-                               phandle, &intc_phandles[phandle_pos],
-                               numa_enabled, is_32_bit);
+        riscv_create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
+                                     s->soc[socket].num_harts,
+                                     s->soc[socket].hartid_base,
+                                     phandle, &intc_phandles[phandle_pos],
+                                     numa_enabled, is_32_bit);
 
-        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
-                                 socket, riscv_numa_enabled(ms));
+        riscv_create_fdt_socket_memory(ms->fdt, memaddr, memsize,
+                                       socket, riscv_numa_enabled(ms));
 
         if (virt_aclint_allowed() && s->have_aclint) {
             create_fdt_socket_aclint(s, socket,
@@ -630,10 +630,11 @@ static void create_fdt_sockets(RISCVVirtState *s,
             hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
                                s->memmap[VIRT_CLINT].size * socket;
 
-            create_fdt_socket_clint(ms->fdt, clintaddr,
-                                    s->memmap[VIRT_CLINT].size,
-                                    socket, &intc_phandles[phandle_pos],
-                                    s->soc[socket].num_harts, numa_enabled);
+            riscv_create_fdt_socket_clint(ms->fdt, clintaddr,
+                                          s->memmap[VIRT_CLINT].size,
+                                          socket, &intc_phandles[phandle_pos],
+                                          s->soc[socket].num_harts,
+                                          numa_enabled);
         }
     }
 
@@ -1020,8 +1021,9 @@ static void create_fdt(RISCVVirtState *s)
     uint8_t rng_seed[32];
     g_autofree char *name = NULL;
 
-    ms->fdt = create_board_device_tree("riscv-virtio,qemu", "riscv-virtio",
-                                       &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree("riscv-virtio,qemu",
+                                             "riscv-virtio",
+                                             &s->fdt_size);
 
     /*
      * The "/soc/pci@..." node is needed for PCIE hotplugs
-- 
2.55.0


