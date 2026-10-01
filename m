Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13680CA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ81-0005PT-5Z; Thu, 01 Oct 2026 11:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ6w-0004ih-HP; Thu, 01 Oct 2026 11:54:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCJ6u-0005Z9-K7; Thu, 01 Oct 2026 11:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NUHHc5ZomslGBV5I5MZMn1xgMJmKcqAgUIGY3h0FmEk=; b=aTzE2RJoLxKT8bo
 fRRQcUwUinEqJLcekFXHI8kDVEWawtENtX5povlKlyiHy0kbHjp2mCNENpul0L9zlOUXebLCDpwHl
 tkNhB+f2dLVpLJjISgJL9LH4OisodbA1MRHEZBmwqLfPZ1M3YkFpsA4SGgIgt4jws40ZoY83J2os+
 lg=;
Date: Thu, 01 Oct 2026 17:59:30 +0200
Subject: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790870392; l=5745;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=YEQdylvAOODD493ZI2iW6OK+1PHKMr6Acd6Ak0yuQNk=;
 b=mHL9kglJB1GtgfSnNt3jrS/fnkaLBDMpmcrsT3wc1DO9nJHhnnAWslSaoNHrmjKjbdvPUUUqe
 LkmZzwK1X/EDyRbflLZbv/so96aUmnjxQ7tmM+8sC4TKBHH4Sn5PW50
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

Moves initialization of satp and mxl fields to a class initialization
function that checks target_riscv64().

Note: I'm aware the current iteration of this patch is rather hacky, I
don't like the introduction of runtime_misa_mxl_max, but I'm keeping
this in to get the series out there and collect feedback.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3fa322a8a9..0b17fd3db1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -590,6 +590,7 @@ typedef struct RISCVCPUDef {
     bool bare;
 #if !defined(CONFIG_USER_ONLY)
 #if defined(CONFIG_TCG)
+    bool runtime_misa_mxl_max; /* Skip max mxl base class validation */
     const RISCVCSR *custom_csrs;
 #endif
     uint8_t irq_local_guest_max;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cfc80aaaf1..39501c6c9f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3062,6 +3062,27 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_max_class_init(ObjectClass *c, const void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    bool rv64 = target_riscv64();
+    mcc->def->misa_mxl_max = (rv64) ? MXL_RV64 : MXL_RV32;
+    mcc->def->cfg.max_satp_mode = (rv64) ? VM_1_10_SV57 : VM_1_10_SV32;
+    riscv_cpu_validate_misa_mxl(mcc);
+}
+
+static void riscv_cpu_bare_class_init(ObjectClass *c, const void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    bool rv64 = target_riscv64();
+    /*
+     * Support all available satp_mode settings. By default
+     * only MBARE will be available if the user doesn't enable
+     * a mode manually (see riscv_cpu_satp_mode_finalize()).
+     */
+    mcc->def->cfg.max_satp_mode = (rv64) ? VM_1_10_SV57 : VM_1_10_SV32;
+}
+
 static bool profile_extends(RISCVCPUProfile *trial, RISCVCPUProfile *parent)
 {
     RISCVCPUProfile *curr;
@@ -3113,6 +3134,9 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
     if (data) {
         const RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        mcc->def->runtime_misa_mxl_max |= def->runtime_misa_mxl_max;
+#endif
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
             assert(mcc->def->bare);
@@ -3157,9 +3181,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 #endif
     }
 
-    if (!object_class_is_abstract(c)) {
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    if (!object_class_is_abstract(c) && !mcc->def->runtime_misa_mxl_max) {
         riscv_cpu_validate_misa_mxl(mcc);
     }
+#endif
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
@@ -3365,41 +3391,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
-    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
-        /*
-         * Bare CPUs do not inherit the timer and performance
-         * counters from the parent class (see riscv_cpu_init()
-         * for info on why the parent enables them).
-         *
-         * Users have to explicitly enable these counters for
-         * bare CPUs.
-         */
-        .bare = true,
 
-        /* Set to QEMU's first supported priv version */
-        .priv_spec = PRIV_VERSION_1_10_0,
+    {
+        .name = TYPE_RISCV_BARE_CPU,
+        .parent = TYPE_RISCV_CPU,
+        .abstract = true,
+        .class_data = &(const RISCVCPUDef) {
+            /* Set to QEMU's first supported priv version */
+            .priv_spec = PRIV_VERSION_1_10_0,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
 
-        /*
-         * Support all available satp_mode settings. By default
-         * only MBARE will be available if the user doesn't enable
-         * a mode manually (see riscv_cpu_satp_mode_finalize()).
-         */
-#ifdef TARGET_RISCV32
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#else
-        .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
-    ),
+            /*
+             * Bare CPUs do not inherit the timer and performance
+             * counters from the parent class (see riscv_cpu_init()
+             * for info on why the parent enables them).
+             *
+             * Users have to explicitly enable these counters for
+             * bare CPUs.
+             */
+            .bare = true,
+        },
+        .class_init = riscv_cpu_bare_class_init,
+    },
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
-#if defined(TARGET_RISCV32)
-        .misa_mxl_max = MXL_RV32,
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#elif defined(TARGET_RISCV64)
-        .misa_mxl_max = MXL_RV64,
-        .cfg.max_satp_mode = VM_1_10_SV57,
+    {
+        .name = TYPE_RISCV_CPU_MAX,
+        .parent = TYPE_RISCV_DYNAMIC_CPU,
+        .class_data = &(const RISCVCPUDef) {
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+            .runtime_misa_mxl_max = true,
 #endif
-    ),
+        },
+        .class_init = riscv_cpu_max_class_init,
+    },
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
         .misa_ext = RVI | RVM | RVA | RVC | RVU,

-- 
2.52.0


