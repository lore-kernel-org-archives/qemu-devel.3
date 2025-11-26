Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F6D10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOADp-0004dD-WC; Wed, 26 Nov 2025 02:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vOADb-0004Wh-I1
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:45:39 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vOADW-0002jH-1y
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:45:39 -0500
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 5AQ7DQko079159
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 15:13:26 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5AQ7D9Qf079028
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Nov 2025 15:13:09 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 26 Nov 2025 15:13:08 +0800
From: Alvin Chang <alvinga@andestech.com>
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>,
 "Yu-Ming Chang" <yumin686@andestech.com>
Subject: [PATCH 1/2] target/riscv: Add 'debug_ver' to set version of debug
 specification
Date: Wed, 26 Nov 2025 15:12:57 +0800
Message-ID: <20251126071258.4132239-2-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126071258.4132239-1-alvinga@andestech.com>
References: <20251126071258.4132239-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5AQ7DQko079159
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The similar control did in 'priv_spec' and 'vext_spec' now is available
for version of debug specification. Currently we accept "v0.13" and
"v1.0" versions. Users can provide 'debug_spec' into CPU option to set
intended version of the debug specification.

For examples:
1. -cpu max,debug_spec=v0.13
2. -cpu max,debug_spec=v1.0

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
---
 target/riscv/cpu.c         | 69 ++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h         | 13 +++++++
 target/riscv/machine.c     |  5 +--
 target/riscv/tcg/tcg-cpu.c |  3 ++
 4 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280..dbcdfcd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.pmp_regions = 16;
     cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+    cpu->env.debug_ver = DEBUG_VERSION_0_13_0;
     cpu->cfg.max_satp_mode = -1;
 
     if (mcc->def->profile) {
@@ -1138,6 +1139,9 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
         cpu->env.vext_ver = mcc->def->vext_spec;
     }
+    if (mcc->def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.debug_ver = mcc->def->debug_spec;
+    }
 #ifndef CONFIG_USER_ONLY
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
@@ -1720,6 +1724,66 @@ static const PropertyInfo prop_priv_spec = {
     .set = prop_priv_spec_set,
 };
 
+static int debug_spec_from_str(const char *debug_spec_str)
+{
+    int debug_version = -1;
+
+    if (!g_strcmp0(debug_spec_str, DEBUG_VER_0_13_0_STR)) {
+        debug_version = DEBUG_VERSION_0_13_0;
+    } else if (!g_strcmp0(debug_spec_str, DEBUG_VER_1_00_0_STR)) {
+        debug_version = DEBUG_VERSION_1_00_0;
+    }
+
+    return debug_version;
+}
+
+static const char *debug_spec_to_str(int debug_version)
+{
+    switch (debug_version) {
+    case DEBUG_VERSION_0_13_0:
+        return DEBUG_VER_0_13_0_STR;
+    case DEBUG_VERSION_1_00_0:
+        return DEBUG_VER_1_00_0_STR;
+    default:
+        return NULL;
+    }
+}
+
+static void prop_debug_spec_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    g_autofree char *value = NULL;
+    int debug_version = -1;
+
+    visit_type_str(v, name, &value, errp);
+
+    debug_version = debug_spec_from_str(value);
+    if (debug_version < 0) {
+        error_setg(errp, "Unsupported debug spec version '%s'", value);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, debug_version);
+    cpu->env.debug_ver = debug_version;
+}
+
+static void prop_debug_spec_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    const char *value = debug_spec_to_str(cpu->env.debug_ver);
+
+    visit_type_str(v, name, (char **)&value, errp);
+}
+
+static const PropertyInfo prop_debug_spec = {
+    .type = "str",
+    .description = "debug_spec",
+    .get = prop_debug_spec_get,
+    .set = prop_debug_spec_set,
+};
+
 static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -2648,6 +2712,7 @@ static const Property riscv_cpu_properties[] = {
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
+    {.name = "debug_spec", .info = &prop_debug_spec},
 
     {.name = "vlen", .info = &prop_vlen},
     {.name = "elen", .info = &prop_elen},
@@ -2818,6 +2883,10 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             assert(def->vext_spec != 0);
             mcc->def->vext_spec = def->vext_spec;
         }
+        if (def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->debug_spec <= DEBUG_VERSION_LATEST);
+            mcc->def->debug_spec = def->debug_spec;
+        }
         mcc->def->misa_ext |= def->misa_ext;
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10..fc1ae7c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -100,6 +100,7 @@ typedef struct riscv_cpu_profile {
     bool present;
     bool user_set;
     int priv_spec;
+    int debug_spec;
     int satp_mode;
     const int32_t ext_offsets[];
 } RISCVCPUProfile;
@@ -123,6 +124,16 @@ enum {
     PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
+/* Debug specification version */
+#define DEBUG_VER_0_13_0_STR "v0.13"
+#define DEBUG_VER_1_00_0_STR "v1.0"
+enum {
+    DEBUG_VERSION_0_13_0 = 0,
+    DEBUG_VERSION_1_00_0,
+
+    DEBUG_VERSION_LATEST = DEBUG_VERSION_1_00_0,
+};
+
 #define VEXT_VERSION_1_00_0 0x00010000
 #define VEXT_VER_1_00_0_STR "v1.0"
 
@@ -245,6 +256,7 @@ struct CPUArchState {
 
     target_ulong priv_ver;
     target_ulong vext_ver;
+    target_ulong debug_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
@@ -563,6 +575,7 @@ typedef struct RISCVCPUDef {
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
+    int debug_spec;
     RISCVCPUConfig cfg;
     bool bare;
     const RISCVCSR *custom_csrs;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790a..8658f55 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -427,8 +427,8 @@ static const VMStateDescription vmstate_sstc = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -443,6 +443,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
+        VMSTATE_UINTTL(env.debug_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d396825..160fcf1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1598,6 +1598,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     /* set vector version */
     env->vext_ver = VEXT_VERSION_1_00_0;
 
+    /* Set debug version */
+    env->debug_ver = DEBUG_VERSION_0_13_0;
+
     /* Zfinx is not compatible with F. Disable it */
     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
     isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
-- 
2.43.0


