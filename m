Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE4CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slP0h-0002HZ-ET; Tue, 03 Sep 2024 04:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slP0e-00028f-Vc; Tue, 03 Sep 2024 04:35:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slP0a-00084h-60; Tue, 03 Sep 2024 04:35:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wyf391zf9z6K6nR;
 Tue,  3 Sep 2024 16:31:01 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id E7A8F14038F;
 Tue,  3 Sep 2024 16:35:21 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.99) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 09:35:21 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <linuxarm@huawei.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@Huawei.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>, 
 <jiangkunkun@huawei.com>
Subject: [PATCH v4] target/arm/tcg: refine cache descriptions with a wrapper
Date: Tue, 3 Sep 2024 09:35:20 +0100
Message-ID: <20240903083520.209-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.30.99]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch allows for easier manipulation of the cache description
register, CCSIDR. Which is helpful for testing as well. Currently,
numbers get hard-coded and might be prone to errors.

Therefore, this patch adds a wrapper for different types of CPUs
available in tcg to decribe caches. One function `make_ccsidr` supports
two cases by carrying a parameter as FORMAT that can be LEGACY and
CCIDX which determines the specification of the register.

For CCSIDR register, 32 bit version follows specification [1].
Conversely, 64 bit version follows specification [2].

Changes from v2 [3] -> v3:

1) add only one function instead of ccsidr32 and ccsidr64
2) use deposit32 and deposit64 in ccsidr function

Chnages from v3 [4] -> v4:
1) Use only one variable in the make_ccsidr function.
2) Include qemu/host-utils.h to get is_power_of_2() declaration.

[1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
edition, https://developer.arm.com/documentation/ddi0406
[2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
https://developer.arm.com/documentation/ddi0487/latest/
[3] https://lore.kernel.org/qemu-devel/20240830184713.224-1-alireza.sanaee@huawei.com/
[4] https://lore.kernel.org/qemu-devel/20240902203211.270-1-alireza.sanaee@huawei.com/

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 target/arm/cpu-features.h |  50 ++++++++++++++++++
 target/arm/cpu64.c        |  19 ++++---
 target/arm/tcg/cpu64.c    | 108 +++++++++++++++++++-------------------
 3 files changed, 117 insertions(+), 60 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c59ca104fe..a4fcbe160c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_FEATURES_H
 
 #include "hw/registerfields.h"
+#include "qemu/host-utils.h"
 
 /*
  * Naming convention for isar_feature functions:
@@ -1022,6 +1023,55 @@ static inline bool isar_feature_any_evt(const ARMISARegisters *id)
     return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
 }
 
+typedef enum {
+    CCSIDR_FORMAT_LEGACY,
+    CCSIDR_FORMAT_CCIDX,
+} CCSIDRFormat;
+
+static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
+                                   unsigned linesize, unsigned cachesize,
+                                   uint8_t flags)
+{
+    unsigned lg_linesize = ctz32(linesize);
+    unsigned sets;
+    uint64_t ccsidr = 0;
+
+    assert(assoc != 0);
+    assert(is_power_of_2(linesize));
+    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
+
+    /* sets * associativity * linesize == cachesize. */
+    sets = cachesize / (assoc * linesize);
+    assert(cachesize % (assoc * linesize) == 0);
+
+    if (format == CCSIDR_FORMAT_LEGACY) {
+        /*
+         * The 32-bit CCSIDR format is:
+         *   [27:13] number of sets - 1
+         *   [12:3]  associativity - 1
+         *   [2:0]   log2(linesize) - 4
+         *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+         */
+        ccsidr = deposit32(ccsidr, 28,  4, flags);
+        ccsidr = deposit32(ccsidr, 13, 15, sets - 1);
+        ccsidr = deposit32(ccsidr,  3, 10, assoc - 1);
+        ccsidr = deposit32(ccsidr,  0,  3, lg_linesize - 4);
+    } else {
+        /*
+         * The 64-bit CCSIDR_EL1 format is:
+         *   [55:32] number of sets - 1
+         *   [23:3]  associativity - 1
+         *   [2:0]   log2(linesize) - 4
+         *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+         */
+        ccsidr = deposit64(ccsidr, 32, 24, sets - 1);
+        ccsidr = deposit64(ccsidr,  3, 21, assoc - 1);
+        ccsidr = deposit64(ccsidr,  0,  3, lg_linesize - 4);
+    }
+
+    return ccsidr;
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 262a1d6c0b..458d1cee01 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
+#include "qemu/units.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/qtest.h"
@@ -642,9 +643,12 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 48KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    /* 2048KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -700,9 +704,12 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x1;
     cpu->isar.reset_pmcr_el0 = 0x41033000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe07a; /* 1024KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
+    /* 1024KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fe232eb306..904a7e90b4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -29,32 +29,6 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 
-static uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
-                              unsigned cachesize)
-{
-    unsigned lg_linesize = ctz32(linesize);
-    unsigned sets;
-
-    /*
-     * The 64-bit CCSIDR_EL1 format is:
-     *   [55:32] number of sets - 1
-     *   [23:3]  associativity - 1
-     *   [2:0]   log2(linesize) - 4
-     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
-     */
-    assert(assoc != 0);
-    assert(is_power_of_2(linesize));
-    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
-
-    /* sets * associativity * linesize == cachesize. */
-    sets = cachesize / (assoc * linesize);
-    assert(cachesize % (assoc * linesize) == 0);
-
-    return ((uint64_t)(sets - 1) << 32)
-         | ((assoc - 1) << 3)
-         | (lg_linesize - 4);
-}
-
 static void aarch64_a35_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -106,9 +80,12 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x410a3000;
 
     /* From B2.29 Cache ID registers */
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x703fe03a; /* 512KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
 
     /* From B3.5 VGIC Type register */
     cpu->gic_num_lrs = 4;
@@ -272,9 +249,12 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.23 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x200fe01a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x703fe07a; /* 512KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
 
     /* From B2.96 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -338,9 +318,12 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41023000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 48KB L1 dcache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    /* 1MB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -397,9 +380,12 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.18 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x701fe01a; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe01a; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe03a; /* 512KB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
 
     /* From B2.93 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -449,9 +435,12 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = 0x0000000000010001;
     cpu->isar.id_aa64zfr0 = 0x0000000000000000;
     cpu->clidr = 0x0000000080000023;
-    cpu->ccsidr[0] = 0x7007e01c; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x2007e01c; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07c; /* 8MB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
+    /* 8MB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
     cpu->dcz_blocksize = 6; /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -637,9 +626,12 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.23 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x701fe01a; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe01a; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe03a; /* 1MB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 1MB L2 dcache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
 
     /* From B2.98 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -721,9 +713,12 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * L2: 8-way set associative, 64 byte line size, either 512K or 1MB.
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
-    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB); /* L1 dcache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];                 /* L1 icache */
-    cpu->ccsidr[2] = make_ccsidr64(8, 64, 1 * MiB);  /* L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];
+    /* 1MB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0);
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -959,9 +954,12 @@ static void aarch64_a710_initfn(Object *obj)
      * L1: 4-way set associative 64-byte line size, total either 32K or 64K.
      * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
      */
-    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB);   /* L1 dcache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];                   /* L1 icache */
-    cpu->ccsidr[2] = make_ccsidr64(8, 64, 512 * KiB);  /* L2 cache */
+    /* L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    /* L1 icache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];
+    /* L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
 
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
@@ -1057,10 +1055,12 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
      * L1: 4-way set associative 64-byte line size, total 64K.
      * L2: 8-way set associative 64 byte line size, total either 512K or 1024K.
      */
-    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB);   /* L1 dcache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];                   /* L1 icache */
-    cpu->ccsidr[2] = make_ccsidr64(8, 64, 512 * KiB);  /* L2 cache */
-
+    /* L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    /* L1 icache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];
+    /* L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
 
-- 
2.34.1


