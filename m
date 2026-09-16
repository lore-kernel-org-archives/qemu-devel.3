Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23533C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lic-0001Mb-1g; Wed, 16 Sep 2026 05:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li9-0001DF-7n; Wed, 16 Sep 2026 05:13:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li7-00088U-Bb; Wed, 16 Sep 2026 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=RrRRTM+hKW9E9aukXzHv56EvBVfkTulUw32ij3Vb0sg=; b=jxxYAyX0DSLszxz
 HC/uCM59ZE9LLc9vtEwR9gkZ77LiuPLibt4lrWOIvPjwxIGzo9J1FWHWsuA4GNoTlKAxHmiP6XLCD
 O35BUZCDYiCBtG/vHpTK2J5lZMTe+ZGhTKrlnL+5iBWpgapSZy0OideNq7z1yrfA86NjbZyfH2nSC
 gE=;
Date: Wed, 16 Sep 2026 11:19:02 +0200
Subject: [PATCH v4 07/12] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-7-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, Chao Liu <chao.liu.zevorn@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=5281;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=Q90V/MFI44KOgxihm0cIMXrVnnoPikfVf+Znrq0exHg=;
 b=cQr/tINaFYB/lhz1s73bD8xkC+3zoaFGH4pEOrytQhViqOaAfG6Z6oF0B6Yz8inbjlPNTgxkM
 HS1p/rcpTTYCCZWsCRBmz11AAEpC9VjirApKZf4mxYWho5xr5Kg8Yxv
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Macros are removed and replaced with inlined ternary statements.  The
now empty sifive_cpu.h header is then removed.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/sifive_cpu.h | 31 -------------------------------
 include/hw/riscv/sifive_e.h   |  1 -
 include/hw/riscv/sifive_u.h   |  1 -
 hw/riscv/sifive_e.c           |  3 ++-
 hw/riscv/sifive_u.c           |  7 +++++--
 5 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
deleted file mode 100644
index 136799633a..0000000000
--- a/include/hw/riscv/sifive_cpu.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * SiFive CPU types
- *
- * Copyright (c) 2017 SiFive, Inc.
- * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HW_SIFIVE_CPU_H
-#define HW_SIFIVE_CPU_H
-
-#if defined(TARGET_RISCV32)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
-#elif defined(TARGET_RISCV64)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
-#endif
-
-#endif /* HW_SIFIVE_CPU_H */
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 4cf902ebc0..0f0d407d5d 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -20,7 +20,6 @@
 #define HW_SIFIVE_E_H
 
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_cpu.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "hw/core/boards.h"
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index aed966a62d..c12cf22b41 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -24,7 +24,6 @@
 #include "hw/dma/sifive_pdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_cpu.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_u_otp.h"
 #include "hw/misc/sifive_u_prci.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 35ed7f42a4..1b6f9ab4fe 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -150,7 +150,8 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = sifive_e_machine_init;
     mc->max_cpus = 1;
-    mc->default_cpu_type = SIFIVE_E_CPU;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
+                                              : TYPE_RISCV_CPU_SIFIVE_E31;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b7d5e7b4da..344f3d915d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -661,7 +661,8 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = sifive_u_machine_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpu_type = SIFIVE_U_CPU;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_U54
+                                              : TYPE_RISCV_CPU_SIFIVE_U34;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
     mc->auto_create_sdcard = true;
@@ -693,6 +694,8 @@ type_init(sifive_u_machine_init_register_types)
 static void sifive_u_soc_instance_init(Object *obj)
 {
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
+    const char *e_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
+                                                : TYPE_RISCV_CPU_SIFIVE_E31;
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
@@ -701,7 +704,7 @@ static void sifive_u_soc_instance_init(Object *obj)
                             TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
-    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", e_cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);

-- 
2.52.0


