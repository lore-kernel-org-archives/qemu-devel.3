Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C79CE67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKJW-0003pY-TC; Sun, 21 Dec 2025 09:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKJV-0003hv-5k
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:37 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKJT-0000jV-0Z
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3NZIUDzncXS/ABiVLpfXYHfk+qKOZAkW4KHzDEB9STE=; b=aM04ImAjtBwdH1l
 XT6fyDOO2coZe+bK09vMISEaT1m4+iW/WU3YiFIFkJlAdIOaxkzoBOsxoyTiJoAiQR+dmk22QKOqG
 SDmRphFBPK7tAKDi4qWfrnDB1y3qi3pgvt4OGFh7P0DpSy8HePGMV2lXYc/4jKL3erZlJHGlQABqm
 f0=;
Date: Sun, 21 Dec 2025 15:23:17 +0100
Subject: [PATCH v2 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251221-hw-riscv-cpu-int-v2-13-eb49d72c5b2f@rev.ng>
References: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
In-Reply-To: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Macros are removed and replaced with inlined ternary statements.  The
now empty sifive_cpu.h header is then removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 31180a680e..ff42ca9c9c 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -20,7 +20,6 @@
 #define HW_SIFIVE_E_H
 
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_cpu.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "hw/boards.h"
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0696f85942..5a735bd128 100644
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
index 7ed419cf69..20433ac6ce 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -151,7 +151,8 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = sifive_e_machine_init;
     mc->max_cpus = 1;
-    mc->default_cpu_type = SIFIVE_E_CPU;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
+                                              : TYPE_RISCV_CPU_SIFIVE_E31;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2ff2059bb9..b3b739bc37 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -723,7 +723,8 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = sifive_u_machine_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpu_type = SIFIVE_U_CPU;
+    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_U54
+                                              : TYPE_RISCV_CPU_SIFIVE_U34;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
     mc->auto_create_sdcard = true;
@@ -756,6 +757,8 @@ type_init(sifive_u_machine_init_register_types)
 static void sifive_u_soc_instance_init(Object *obj)
 {
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
+    const char *e_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
+                                                : TYPE_RISCV_CPU_SIFIVE_E31;
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
@@ -764,7 +767,7 @@ static void sifive_u_soc_instance_init(Object *obj)
                             TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
-    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", e_cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);

-- 
2.51.0


