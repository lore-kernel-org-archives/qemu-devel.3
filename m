Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08543CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwQ-0003ka-Um; Wed, 07 Oct 2026 05:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENA0-0001ic-Ij; Wed, 07 Oct 2026 04:38:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9y-0006X9-2D; Wed, 07 Oct 2026 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=InZlIDuQ4iugllfC8M4po0Owp7+YI9p2slLva+aLiY8=; b=ebp96u16RYCFBW0
 k58R8BYyV0XvpV/q92qYodjX6E6myGot3ss+td02eVKcUyxJuagYZcXbI++mGa9iTzl14gZC9CyvH
 sm85RH0MF0Dbx9Q6iBRhYDOL06NdCGhb6mMxUi1gj/q5HZzQWgk5g1hzhZCcsA9tkewMDfGch25bz
 Eg=;
Date: Wed, 07 Oct 2026 10:43:12 +0200
Subject: [PATCH v2 06/18] target/riscv: Runtime CPU registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-6-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=13141;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=51w3h7rtNGdVwQnnk2Q7QdFUFwFA5tav/53OV2Z6hVM=;
 b=xZ11SJ0T1DbNyCIDNk5WmyKK4PmNWW0DHVZQZq23gEwPYQ81OTXiuaYdCuiXZ8U/tV/xTnZjW
 UcJw4hLIFW9As6i+/x2Sa3mbsQnV1oPBVPVzjTdd1iHZxxmDgwDzuHW
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Uses TypeInfo::is_available to determine what CPUs to register,
convenience macros are modified slightly to make this conversion
more ergonomic.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.c | 156 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 59 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8c8f08bb50..cfc80aaaf1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/tcg/csr.h"
@@ -3259,34 +3260,76 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = (parent_type_name),                       \
-        .abstract = true,                                   \
-        .class_data = &(const RISCVCPUDef) {                \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-             __VA_ARGS__                                    \
-        },                                                  \
+/*
+ * Returns true for targets supporting 32-bit CPUs
+ * (32-bit user-/system-mode or 64-bit system-mode).
+ */
+static bool riscv_cpu_supports_rv32(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return target_riscv32();
+#else
+    return true;
+#endif
+}
+
+/*
+ * Returns true for targets supporting 64-bit CPUs
+ * (64-bit user and system-mode).
+ */
+static bool riscv_cpu_supports_rv64(void)
+{
+    return target_riscv64();
+}
+
+/*
+ * Returns true for targets supporting 128-bit CPUs
+ * (64-bit system-mode on TCG).
+ */
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+static bool riscv_cpu_supports_rv128(void)
+{
+    return target_riscv64();
+}
+#endif
+
+#define DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, \
+                              abstract_, avail_fn, ...)    \
+    {                                                      \
+        .name = (type_name),                               \
+        .parent = (parent_type_name),                      \
+        .abstract = (abstract_),                           \
+        .class_data = &(const RISCVCPUDef) {               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,       \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,       \
+             .cfg.max_satp_mode = -1,                      \
+             __VA_ARGS__                                   \
+        },                                                 \
+        .is_available = (avail_fn),                        \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, true, NULL, __VA_ARGS__)
+
+#define DEFINE_RISCV64_PROFILE_CPU(type_name, parent_type_name, profile_) \
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, false,             \
+                          riscv_cpu_supports_rv64,                        \
+                          .profile = &(profile_))
+
 #define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = (parent_type_name),                       \
-        .class_data = &(const RISCVCPUDef) {                \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-             __VA_ARGS__                                    \
-        },                                                  \
-    }
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, false, NULL, __VA_ARGS__)
 
-#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
-    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
-        .profile = &(profile_))
+#define DEFINE_RISCV32_CPU(type_name, parent_type_name, ...)  \
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, false, \
+                          riscv_cpu_supports_rv32, __VA_ARGS__)
+
+#define DEFINE_RISCV64_CPU(type_name, parent_type_name, ...)  \
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, false, \
+                          riscv_cpu_supports_rv64, __VA_ARGS__)
+
+#define DEFINE_RISCV128_CPU(type_name, parent_type_name, ...)  \
+    DEFINE_RISCV_CPU_FULL(type_name, parent_type_name, false,  \
+                          riscv_cpu_supports_rv128, __VA_ARGS__)
 
 static void riscv_cpu_instance_finalize(Object *obj)
 {
@@ -3380,9 +3423,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
 
@@ -3408,7 +3449,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI | RVM | RVC | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3425,37 +3466,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xlrbr = true
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV32_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
-#endif
 
-#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+#ifndef CONFIG_USER_ONLY
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
     ),
 #endif
 
-#if defined(TARGET_RISCV64)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV64,
 
@@ -3481,19 +3520,19 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_11_0,
@@ -3521,7 +3560,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3568,12 +3607,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
         .vext_spec = VEXT_VERSION_1_00_0,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3637,7 +3676,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3673,7 +3712,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3696,7 +3735,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3756,7 +3795,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     /* https://mips.com/products/hardware/p8700/ */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3778,26 +3817,25 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+    DEFINE_RISCV128_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV128,
     ),
-#endif /* CONFIG_TCG */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+#endif
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVE
     ),
 
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
-#endif /* TARGET_RISCV64 */
+    DEFINE_RISCV64_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
+    DEFINE_RISCV64_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
+    DEFINE_RISCV64_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
+    DEFINE_RISCV64_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)

-- 
2.52.0


