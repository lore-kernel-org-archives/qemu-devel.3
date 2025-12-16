Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1BCD637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenG-0001GF-Ot; Tue, 16 Dec 2025 18:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen6-0001Ca-LP
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen4-0006mK-Tg
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nNu+hhZPCxg3t1C9ePlO/uOhsAN+U4ctEJxn/FIV/o4=; b=qV+pUzzeZWA8/Cn
 mNhG50JGCbz7n9+mv1C975nB8UNcwnoH24FhhGOqYUMau5p0bsXjf58gjyWSAC3m3kFXRJkq3anl6
 d3p1mWLhYN6CPzf0qBRzTg/0lYdNcdpUXjuLEeNqBsPIAvTlaTrVST/4k1YP0Wi8NntOsjRLdRhR9
 nc=;
Date: Wed, 17 Dec 2025 00:51:18 +0100
Subject: [PATCH 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/sifive_cpu.h | 26 +++++++++++++++++++-------
 hw/riscv/sifive_e.c           |  2 +-
 hw/riscv/sifive_u.c           |  4 ++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
index 136799633a..8391141d5e 100644
--- a/include/hw/riscv/sifive_cpu.h
+++ b/include/hw/riscv/sifive_cpu.h
@@ -20,12 +20,24 @@
 #ifndef HW_SIFIVE_CPU_H
 #define HW_SIFIVE_CPU_H
 
-#if defined(TARGET_RISCV32)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
-#elif defined(TARGET_RISCV64)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
-#endif
+#include "qemu/target-info.h"
+
+static inline const char *sifive_e_cpu(void)
+{
+    if (target_riscv64()) {
+        return TYPE_RISCV_CPU_SIFIVE_E51;
+    } else {
+        return TYPE_RISCV_CPU_SIFIVE_E31;
+    }
+}
+
+static inline const char *sifive_u_cpu(void)
+{
+    if (target_riscv64()) {
+        return TYPE_RISCV_CPU_SIFIVE_U54;
+    } else {
+        return TYPE_RISCV_CPU_SIFIVE_U34;
+    }
+}
 
 #endif /* HW_SIFIVE_CPU_H */
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7ed419cf69..458b21b9e3 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -151,7 +151,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = sifive_e_machine_init;
     mc->max_cpus = 1;
-    mc->default_cpu_type = SIFIVE_E_CPU;
+    mc->default_cpu_type = sifive_e_cpu();
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2ff2059bb9..a04481806e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -723,7 +723,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = sifive_u_machine_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpu_type = SIFIVE_U_CPU;
+    mc->default_cpu_type = sifive_u_cpu();
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
     mc->auto_create_sdcard = true;
@@ -764,7 +764,7 @@ static void sifive_u_soc_instance_init(Object *obj)
                             TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
-    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", sifive_e_cpu());
     qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);

-- 
2.51.0


