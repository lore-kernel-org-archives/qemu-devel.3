Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55826CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENvZ-0001yy-E0; Wed, 07 Oct 2026 05:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENA0-0001gL-0o; Wed, 07 Oct 2026 04:38:00 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9y-0006XA-3f; Wed, 07 Oct 2026 04:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=99qf/l2hm1FuxqZDomIozoDf2qiSquzS4qjRio0BAu4=; b=JMgfXV991hJCgcF
 6NoSStfWZRbHX9RaL/VES/70dd2DVFLiIbH+0NcqhczSeoFa/PrXsiDgkOEgEXCaHiH2sMAh/djWZ
 XBFG8RxpNy5zqx3H5Z1jHdSdQ9pOVg2jUZJxcRbQdOgFznMMupqKE/Ib+jHn5GZDMP/27d/CrazRy
 d4=;
Date: Wed, 07 Oct 2026 10:43:13 +0200
Subject: [PATCH v2 07/18] target/riscv: Runtime register MAX and BARE CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-7-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=3978;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=t9/N+zUDJTNxnN0dAedqA1IbUNoARAX4eUhu9lg6V2E=;
 b=nmesCUatKP9DjORKRxiZY5fMFCubREavsi6cD3msMxMJNMigKsmnzo/l8yT8NQnT6yyPrpbjm
 lErb2GUT0xeDEKPPWXcsOKh83g6UUeIbPhI54xKabk9FPrNkvVC3gdt
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

Moves MAX and BARE cpus to separate typeinfo tables indexed by
target_riscv64() during registration, similar to how ARM handles MAX cpu
types.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.c | 86 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cfc80aaaf1..d1727ce2f5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3365,41 +3365,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
-
-        /* Set to QEMU's first supported priv version */
-        .priv_spec = PRIV_VERSION_1_10_0,
-
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
-
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
-#if defined(TARGET_RISCV32)
-        .misa_mxl_max = MXL_RV32,
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#elif defined(TARGET_RISCV64)
-        .misa_mxl_max = MXL_RV64,
-        .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
-    ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
         .misa_ext = RVI | RVM | RVA | RVC | RVU,
@@ -3838,4 +3803,55 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV64_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
 };
 
+
+static const TypeInfo riscv_cpu_bare_type_infos[] = {
+    /*
+     * Bare CPUs do not inherit the timer and performance
+     * counters from the parent class (see riscv_cpu_init()
+     * for info on why the parent enables them).
+     *
+     * Users have to explicitly enable these counters for
+     * bare CPUs.
+     *
+     * Support all available satp_mode settings. By default
+     * only MBARE will be available if the user doesn't enable
+     * a mode manually (see riscv_cpu_satp_mode_finalize()).
+     */
+
+    /* 32-bit entry */
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
+        /* Set to QEMU's first supported priv version */
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .bare = true,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+    ),
+    /* 64-bit entry */
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
+        /* Set to QEMU's first supported priv version */
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .bare = true,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+};
+
+static const TypeInfo riscv_cpu_max_type_infos[2] = {
+    /* 32-bit entry */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+    ),
+    /* 64-bit entry */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+};
+
+static void riscv_register_max_bare_types(void)
+{
+    bool rv64 = target_riscv64();
+    type_register_static(&riscv_cpu_bare_type_infos[rv64]);
+    type_register_static(&riscv_cpu_max_type_infos[rv64]);
+}
+type_init(riscv_register_max_bare_types)
 DEFINE_TYPES(riscv_cpu_type_infos)

-- 
2.52.0


