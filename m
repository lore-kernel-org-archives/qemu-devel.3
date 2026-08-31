Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B31C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wdu-0003WN-BQ; Mon, 31 Aug 2026 03:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x0wdq-0003WB-Tf; Mon, 31 Aug 2026 03:41:19 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x0wdn-0004ml-Am; Mon, 31 Aug 2026 03:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788162050; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=EyMzEUFX18h3H7e54rfyjeZ+71H4oGlpgGNQWBVUORs=;
 b=aThZzsc01WbTlaSZNZJvAkRoX3v4ZUF2SEV9LodGx/WL634W6L63jJPksmrjUMHjARb9bWvKw0UWeBb6/qMnTaA+wWtDOMFLX9ge4/+yTeiaZqmKIZReMixpDlR41avB5reRU/x7ag87/+pYgs4wCA1n0Gq3yRe0deCTxm1lr1A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X9v6Xbf_1788162044; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X9v6Xbf_1788162044 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 15:40:49 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 31 Aug 2026 15:40:35 +0800
Subject: [PATCH] target/riscv/tcg: fix user option hash table leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-b4-riscv-cpu-user-option-leak-v1-1-6b020c8b6964@linux.alibaba.com>
X-B4-Tracking: v=1; b=H4sIAPIvlWoC/x3MTQ5AMBBA4avIrE1CWz9xFbGoGkwITYtIxN1NL
 N/iew9ECkwRmuSBQBdH3jeJPE3AzXabCHmQBpWpMqt1jr3BwNFd6PyJp2jc/SEIV7ILmtqaSld
 DMVoF8vCBRr7/f9u97wcbj/jPbwAAAA==
X-Change-ID: 20260831-b4-riscv-cpu-user-option-leak-48a4737d5fa2
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788162049; l=10681;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=ViRIE0gWRAoMlBPw1LyxfuB2Died6CDpQQf0hy76HOQ=;
 b=M2zO+mf/GmRcOHVWRUeryyF0GznKkEecg+OtKMjAxsTjSFYPRH2uBDQf0GXNUM0hOsg2sW3Jr
 kwu0HJdCvrEDjiGLW61hwqU10IFOEe1BDvbJqE6pdHpLOdjvDFVTP6G
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The misa_ext_user_opts and multi_ext_user_opts hash tables are global,
but riscv_tcg_cpu_instance_init() recreates both for every CPU instance.
Creating a second CPU overwrites the only references to the first CPU's
tables. LeakSanitizer reports two direct and four indirect leaks, 320
bytes in total, when a two-hart virt machine exits.

The option state belongs to a CPU instance, like user_options. Move both
tables into RISCVCPU, pass the CPU to their access helpers, and free them
from the existing instance finalizer. Keep the implied-rule tables global
because those are initialized once and shared.

Fixes: 549cbf789ef8 ("target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig")
Fixes: 21915d16c6fb ("target/riscv/tcg: add MISA user options hash")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
The misa_ext_user_opts and multi_ext_user_opts hash tables are global, but
riscv_tcg_cpu_instance_init() creates both for every CPU instance.  A second
CPU therefore overwrites the only references to the first CPU's tables.

Move the tables into RISCVCPU and release them from the existing CPU instance
finalizer.  Keep the implied-rule tables global because they are initialized
once and shared.

Testing:
- No ASan/LSan errors after QMP quit for virt TCG with
  -cpu rv64 and both -smp 1 and -smp 2.
- Expected dependency errors were reported for:
  -cpu rv64,zce=true,zca=false
  -cpu rv64,zfa=true,f=false
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu.h         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 54 ++++++++++++++++++++++------------------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 61109672d60b4fa554e10401d58e5a27d7f2f679..c0f979ae0586c7e377fdfe328689d5953a0c1216 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3279,6 +3279,8 @@ static void riscv_cpu_instance_finalize(Object *obj)
     g_clear_pointer(&cpu->pmu_event_ctr_map, g_hash_table_destroy);
 #endif
     g_clear_pointer(&cpu->user_options, g_hash_table_destroy);
+    g_clear_pointer(&cpu->misa_ext_user_opts, g_hash_table_destroy);
+    g_clear_pointer(&cpu->multi_ext_user_opts, g_hash_table_destroy);
 }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 718b66487a21b42f6df55c8f754c5fc2e54ce864..afce7c2eca708256a4310caa7d0f5a89093d1999 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -582,6 +582,8 @@ struct ArchCPU {
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
     GHashTable *user_options;
+    GHashTable *misa_ext_user_opts;
+    GHashTable *multi_ext_user_opts;
     const GPtrArray *decoders;
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54f1b66216cabb731222bce7115f2f4c59de18e0..b68160af8307c1e46d3f200c5313823d240eb7b3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -41,34 +41,32 @@
 #include "target/riscv/tcg/csr.h"
 #endif
 
-/* Hash that stores user set extensions */
-static GHashTable *multi_ext_user_opts;
-static GHashTable *misa_ext_user_opts;
-
 static GHashTable *multi_ext_implied_rules;
 static GHashTable *misa_ext_implied_rules;
 
-static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+static bool cpu_cfg_ext_is_user_set(RISCVCPU *cpu, uint32_t ext_offset)
 {
-    return g_hash_table_contains(multi_ext_user_opts,
+    return g_hash_table_contains(cpu->multi_ext_user_opts,
                                  GUINT_TO_POINTER(ext_offset));
 }
 
-static bool cpu_misa_ext_is_user_set(uint32_t misa_bit)
+static bool cpu_misa_ext_is_user_set(RISCVCPU *cpu, uint32_t misa_bit)
 {
-    return g_hash_table_contains(misa_ext_user_opts,
+    return g_hash_table_contains(cpu->misa_ext_user_opts,
                                  GUINT_TO_POINTER(misa_bit));
 }
 
-static void cpu_cfg_ext_add_user_opt(uint32_t ext_offset, bool value)
+static void cpu_cfg_ext_add_user_opt(RISCVCPU *cpu, uint32_t ext_offset,
+                                     bool value)
 {
-    g_hash_table_insert(multi_ext_user_opts, GUINT_TO_POINTER(ext_offset),
+    g_hash_table_insert(cpu->multi_ext_user_opts,
+                        GUINT_TO_POINTER(ext_offset),
                         (gpointer)value);
 }
 
-static void cpu_misa_ext_add_user_opt(uint32_t bit, bool value)
+static void cpu_misa_ext_add_user_opt(RISCVCPU *cpu, uint32_t bit, bool value)
 {
-    g_hash_table_insert(misa_ext_user_opts, GUINT_TO_POINTER(bit),
+    g_hash_table_insert(cpu->misa_ext_user_opts, GUINT_TO_POINTER(bit),
                         (gpointer)value);
 }
 
@@ -358,7 +356,7 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
         return;
     }
 
-    if (cpu_cfg_ext_is_user_set(ext_offset)) {
+    if (cpu_cfg_ext_is_user_set(cpu, ext_offset)) {
         return;
     }
 
@@ -491,7 +489,7 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
 {
     const char *warn_msg = "RVG mandates disabled extension %s";
     uint32_t g_misa_bits[] = {RVI, RVM, RVA, RVF, RVD};
-    bool send_warn = cpu_misa_ext_is_user_set(RVG);
+    bool send_warn = cpu_misa_ext_is_user_set(cpu, RVG);
 
     for (int i = 0; i < ARRAY_SIZE(g_misa_bits); i++) {
         uint32_t bit = g_misa_bits[i];
@@ -734,7 +732,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
+        if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_zicntr))) {
             error_setg(errp, "zicntr requires zicsr");
             return;
         }
@@ -742,7 +740,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zihpm && !cpu->cfg.ext_zicsr) {
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zihpm))) {
+        if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_zihpm))) {
             error_setg(errp, "zihpm requires zicsr");
             return;
         }
@@ -802,8 +800,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
         (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||
-            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {
+        if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_smctr)) ||
+            cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_ssctr))) {
             error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrind");
             return;
         }
@@ -820,7 +818,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
         cpu->cfg.ext_svpbmt = false;
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
+        if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_svpbmt))) {
             warn_report("svpbmt requires at least satp sv39, "
                         "current satp mode: %s",
                         satp_mode_str(cpu->cfg.max_satp_mode,
@@ -830,7 +828,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     if (cpu->cfg.ext_svnapot && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
         cpu->cfg.ext_svnapot = false;
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svnapot))) {
+        if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_svnapot))) {
             warn_report("svnapot requires at least satp sv39, "
                         "current satp mode: %s",
                         satp_mode_str(cpu->cfg.max_satp_mode,
@@ -1007,7 +1005,7 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
                      * If the user disabled the misa_bit do not re-enable it
                      * and do not apply any implied rules related to it.
                      */
-                    if (cpu_misa_ext_is_user_set(misa_bits[i]) &&
+                    if (cpu_misa_ext_is_user_set(cpu, misa_bits[i]) &&
                         !(env->misa_ext & misa_bits[i])) {
                         continue;
                     }
@@ -1143,7 +1141,7 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
     }
 
     if (set_misa_c) {
-        if (cpu_misa_ext_is_user_set(RVC)) {
+        if (cpu_misa_ext_is_user_set(cpu, RVC)) {
             warn_report("RVC mandated by Zca/Zcf/Zcd extensions");
             return;
         }
@@ -1285,7 +1283,7 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
             continue;
         }
 
-        cpu_misa_ext_add_user_opt(bit, profile->enabled);
+        cpu_misa_ext_add_user_opt(cpu, bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
@@ -1296,7 +1294,7 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
             cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
+        cpu_cfg_ext_add_user_opt(cpu, ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -1356,7 +1354,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_misa_ext_add_user_opt(misa_bit, value);
+    cpu_misa_ext_add_user_opt(cpu, misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -1520,7 +1518,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_cfg_ext_add_user_opt(cfg_offset, value);
+    cpu_cfg_ext_add_user_opt(cpu, cfg_offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, cfg_offset);
 
@@ -1684,8 +1682,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif
 
-    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-    multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+    cpu->misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+    cpu->multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
 
     if (!misa_ext_implied_rules) {
         misa_ext_implied_rules = g_hash_table_new(NULL, g_direct_equal);

---
base-commit: aee18ec8d3c54fa98d33acdf617ad5af96d8e9fe
change-id: 20260831-b4-riscv-cpu-user-option-leak-48a4737d5fa2

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


