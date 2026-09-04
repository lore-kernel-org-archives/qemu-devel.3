Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE49DC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMm-0008KP-T8; Fri, 04 Sep 2026 01:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMj-0007nU-3Y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMg-0001SG-Rv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so561192b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499285; x=1789104085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vcslFeOP012eH4+EAy6NfAnj8fM+0ewoRg4KYCFbUys=;
 b=pFl1ork7yOTos7n/sxqar+Hyoqja/2Z7cQt3y/rmQ5lNPJeK2UDisC+1pmzQGP3kYu
 eAFol0dSH32NQJRt4+3wHaCGYaeJcpKYEnFvHywiidJiTVTyv2jkwkz8nauOEvRUtLBU
 gZmuph3F6eNRJDLJMTcK2y3hwvFkwYZLrfmfbq0y8Umo5ummywa611fKfMOu6pZHljgA
 4mweBHTSCuZqxs6SCaeYqHMJb6aA3oZSPa2e5HkdPLqNhmM+C3BxYwI8w4yiV416NAJx
 cvDV8AdCu4WRbDlNrYrog+UR3HWnoRGAJ1AlqiV4+t0aoFMRwHXyQavaHcv631rbjCup
 iyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499285; x=1789104085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vcslFeOP012eH4+EAy6NfAnj8fM+0ewoRg4KYCFbUys=;
 b=nYh3Y4tg5nXPQeMv3cSnSP5oT/XsSl72ZOKb9cIOLEc7RuZ2UA4Am8DMyryG0nP9ZZ
 Q/e9kcNIMOrT27vlPXdAa7iSGAO6ht1q72L5jWukNE0Hz45MidoRfbxkdRqZ6nsCtL5V
 huO6vn2VYqz8p0gaHMHS9hT4zRxlLDct2JtdRO8CS+S+yIItvwJYkDBaLUZsBjc9ozwL
 oYZHJ+016+03uqq6TqKc1QTGUpPeQv9l+did+ikw3AyValSALdYDuRb6DG7ak7QFuPL4
 g/lTabb059xT77QAveBeVyN861IFR/ayDo/eNyUK8hrJoFmp2v6v3iUgQINQabzU8bz2
 dVBw==
X-Gm-Message-State: AFuF++mPfm2gLa3eZTq2A05niXTA+IUZS3RWhsAm8Dl9kpFlGuXhFvcj
 6AEjLk5FUss9hSlTO4hzSSbHOhaLnFQNvnJKwQD21hD0uGW/b1Nie2Sd1xx1dQ==
X-Gm-Gg: AYBFou1OIKRw7fHBwDRrW7UivI35ljdkAnxo5pA9BzBO3EIuDwUMJ/f3revdSy931Ek
 djGorXltozaRmyde4wqotOAMkXurCTiErMLnsVVtDwQ4z9H7ERhelEEYPYcWy85CwKhIIJDRaEb
 gu4SWmgtqSTY4rsLZfkz+k9fDPuhBDL7o8Owkq844N9AZkmMfM+MJ7hXiMlW56yfR0TeAfu4jcQ
 97R9OrqAbmzJSl416ZMtKFskpPssO2kargzqLudIqhNHaAbvJRcTRJqxvilVWHds95PLTRXKMPA
 PjVXEn1spsC+JXm74cZfWwi0nbGpAz0OoRT3MBVPkZZHvwm2NJnBu+o3uNVDsXx151xuE40ZXUh
 pycFKNABUN5jMWpBn2km46nfIPFC+CxBTqVuJeccq18J4j/k1Yg8/LB+iiyO2Osg71J4stJMsFv
 kUITS7ETGTwnvr6qjC6od67FmbiqrGkVlwzS+bVL5rjwxjYPjDK1lr5kgBK8/Iot6fuO6h7Ba8A
 lIj2LuM4Kkq1z7K
X-Received: by 2002:a05:6a20:3ca7:b0:3c3:a3fd:db0a with SMTP id
 adf61e73a8af0-3da39feac73mr6074667637.16.1788499285300; 
 Thu, 03 Sep 2026 22:21:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/47] target/riscv/tcg: fix user option hash table leaks
Date: Fri,  4 Sep 2026 15:19:25 +1000
Message-ID: <20260904051943.799041-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260831-b4-riscv-cpu-user-option-leak-v1-1-6b020c8b6964@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  2 ++
 target/riscv/cpu.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 54 ++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b974c2f4b4..c2138dbd4b 100644
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
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a760ba3a52..652311ddef 100644
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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54f1b66216..b68160af83 100644
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
-- 
2.55.0


