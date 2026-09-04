Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25E4C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MM8-0006nq-2q; Fri, 04 Sep 2026 01:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM6-0006kv-OZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM4-0001Jo-QJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so2126726b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499247; x=1789104047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RhlCAMII/Yit9MnRBsICtHNCyrMlLxiF/pB/sqyr9Bo=;
 b=giYklhRDAoN3oiC6aVDRaPaPk0BbWBirGc6+p2UXE5LgSZkGqdknmexjuJzlL9j5xo
 ezOFIM7cK4NWGAvImBNJHjnqh7Xv1vMDtFkd694f0asqN0rNF4/uMQU2Jg/MRZuWm0fj
 WE0pnelfE/RUflRwmFQJ7wnZjBaG0RmTSD62GsDtuwsusDzR1uTV5SFoP+wUYb4sDWsW
 pUVw6g2fd3BztGu36MiWOfVpNcZZAmA5Q7AT/B4H4ET1ztHYUwphNeX9yITYGC9r1Rdr
 AENmPudBYf3HhFHmpeWX7iaIKhSf3sMfyG00o7Wl0YsJ63wlsMzrBwQHS1MBfofcacY8
 eN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499247; x=1789104047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RhlCAMII/Yit9MnRBsICtHNCyrMlLxiF/pB/sqyr9Bo=;
 b=fv9zt+dLRTnTxB3kIcCvYsPT0lDvSDDjO1/tWF1XA4S8ImtB3i0Bp5KfTHzbEjURF9
 wAsgBKjrS29HRhP83EW9RcW63mmYVwyq09QEAuMQRjNiVMJRUReiKoUN21WFTpm9YcaK
 WFZzy9Nk4p/nrFfkR3mgdzmNq1MTWyONmSCKlad4UwIV0ZmoPs+iZGlvGjv4DCrAutcd
 42kLhpjundqD9NJwkLv9o3jKqDraGXnQ6MvtR6VvlsfYXvhf0Q5r9zOu5axkPFYlBvrN
 +HiXh53YHd2Y2Me6qtXX9uUFyr0NZyxVjILfw4qfMzT8EeLCbLLXkkjgNs3DZboHaDpQ
 CdPw==
X-Gm-Message-State: AFuF++n9t7F1bhe8L9Ra6HuTRjOXp0J98qKkP1xEOXpdPNqfAxlBNf1c
 OFkVdXJAaBaYwE7xaYR9eYxIJkU2jY+37tVJM/S1Ca+lJkDIfzt1bBMfVmNmDw==
X-Gm-Gg: AYBFou0i9vF1h/ZeuAPtdfbG79U6Gcky3213cB3l1ty9Ffimz0v19nc975nobLH76Ji
 aEjzLGvZEpUlNM5d5vbxYAEr9ica5ZW3bUwSUfM6+TZd6e3x1O3h9zxvyZcDaIcDv1KEtaMFGw7
 MINgOWhYGhXpvnHbsTZiUp6SJxKLzixnNN++b1twjIGJYUUxCcgi+Vi6UiC0Ri2XYsf7UnEW5rx
 81EId4IEDkAukNDZHZ2bRRLA3hCMo8kI+7pPXUmjBxa8dwJjoOuh2DBzE7ToC5aP/AK7jsrFT/Q
 OdyZagnz6e/EA9neh/2P1cu4uek1tMKYRvrBQo8e75qMnBpKUU7MKvkGNh/cN9wp8HzoObHeaY+
 F3oPr4aOkjxBHh7wsgQF4sZX4DMUieXRY+MFyqUizqeUII/rsbvrCSsXmKHzJwjyKTcOyd1cjqn
 HHDEkvJhAVw4sxRoAwX7Jh3nca0KlJWSIABuMBPGWulrfq9HD2C4es7kGL/giNLBK9CNBM3oQfc
 XFmuw==
X-Received: by 2002:a05:6a21:2d05:b0:3cc:f9a0:3ada with SMTP id
 adf61e73a8af0-3da215a6cc6mr10307878637.16.1788499247375; 
 Thu, 03 Sep 2026 22:20:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/47] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_riscv_iommu_sys()
Date: Fri,  4 Sep 2026 15:19:13 +1000
Message-ID: <20260904051943.799041-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

Both the 'virt' board and the future 'riscv-server-ref' boards uses an
iommu-sys device that is declared in the DT.  Create a helper to
encapsulate the logic and avoid copy/pasting stuff between boards.

The helper will return the iommu phandle value instead of returning void
and writing the used phandle in an extra argument.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260828203918.350131-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  5 ++++
 hw/riscv/fdt-common.c         | 35 ++++++++++++++++++++++++
 hw/riscv/virt.c               | 50 ++++++-----------------------------
 3 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index e377682b32..65711468b8 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -43,4 +43,9 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
                              hwaddr addr, hwaddr size,
                              uint32_t reboot, uint32_t poweroff,
                              bool sifive_test_compat);
+uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                          uint32_t *next_phandle,
+                                          uint32_t irq_chip,
+                                          uint32_t msi_phandle,
+                                          uint32_t iommu_sys_irq);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index eac5ca9322..88589330fb 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -13,6 +13,8 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/riscv/iommu.h"
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -349,3 +351,36 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
     qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
     g_free(name);
 }
+
+uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                          uint32_t *next_phandle,
+                                          uint32_t irq_chip,
+                                          uint32_t msi_phandle,
+                                          uint32_t iommu_sys_irq)
+{
+    const char comp[] = "riscv,iommu";
+    g_autofree char *iommu_node = NULL;
+    uint32_t iommu_phandle;
+
+    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+
+    iommu_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_sys_irq + RISCV_IOMMU_INTR_CQ, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_FQ, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PM, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PQ, FDT_IRQ_TYPE_EDGE_LOW);
+
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
+    return iommu_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1f7b4343d3..b0b94af4a3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -868,46 +868,6 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
-static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
-                                 uint32_t msi_phandle,
-                                 uint32_t *iommu_sys_phandle)
-{
-    const char comp[] = "riscv,iommu";
-    void *fdt = MACHINE(s)->fdt;
-    uint32_t iommu_phandle;
-    g_autofree char *iommu_node = NULL;
-    hwaddr addr = s->memmap[VIRT_IOMMU_SYS].base;
-    hwaddr size = s->memmap[VIRT_IOMMU_SYS].size;
-    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
-    };
-
-    iommu_node = g_strdup_printf("/soc/iommu@%x",
-                               (unsigned int) s->memmap[VIRT_IOMMU_SYS].base);
-    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
-    qemu_fdt_add_subnode(fdt, iommu_node);
-
-    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
-    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
-
-    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
-
-    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
-
-    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
-
-    *iommu_sys_phandle = iommu_phandle;
-}
-
 static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 {
     const char comp[] = "riscv,pci-iommu";
@@ -946,8 +906,14 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
-        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-                             &iommu_sys_phandle);
+        iommu_sys_phandle =
+            riscv_create_fdt_riscv_iommu_sys(MACHINE(s)->fdt,
+                                             s->memmap[VIRT_IOMMU_SYS].base,
+                                             s->memmap[VIRT_IOMMU_SYS].size,
+                                             &phandle,
+                                             irq_mmio_phandle,
+                                             msi_pcie_phandle,
+                                             IOMMU_SYS_IRQ);
     }
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
-- 
2.55.0


