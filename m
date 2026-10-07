Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B427ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENrh-0003Nz-2N; Wed, 07 Oct 2026 05:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9x-0001Le-6r; Wed, 07 Oct 2026 04:37:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9u-0006WN-9Y; Wed, 07 Oct 2026 04:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=i5tJPz1WwK/KvahIqlTmngvmH9g8sIIWzFNvED7a2p4=; b=G3rLrkFAxIbOarz
 ZvgNkvfdtyGFJSDQeK9pCa2At1GfX87LV9Pv1D2ZoB1b+AekFzwPy/cEjKEKp8lANb9U3q1qghKGa
 la+LcXdx3579vLhyL8W1oKYsLiPj+pzaMVSLjNvRaYTzd4q69t5zPiaOtTR6O2DZK8dsioAK64iAX
 js=;
Date: Wed, 07 Oct 2026 10:43:10 +0200
Subject: [PATCH v2 04/18] target/riscv: Make debug.c target agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-4-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=15710;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=gVi7jn/u9NZUpPtfr/UMNf9vPyEodNub8/glN/6f1nQ=;
 b=7vqo0YzGp6xWh84fxL7jpxpPXsst3izJjOKmNwZambt7GWJkbv8CF8jheVwj6s/SgsnL5lYbL
 +/LMxuTqdn0BOkmFOGInh962eo/tzv/tGvO3FGr+UQYPEDAQ0j4TyA/
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

This is not enough to compile debug.c once for system-mode, since it
pulls in helper function prototypes which depend on target_long.
Inclusion of "exec/target_long.h" from debug.h is removed in a follow up
commit once the CSR functions have been made agnostic.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/debug.c | 140 +++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index e4d719a1da..90172298ce 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -82,8 +82,8 @@ static bool debug_trigger_version_1_0(CPURISCVState *env)
     return riscv_cpu_cfg(env)->ext_sdtrig;
 }
 
-static inline target_ulong extract_trigger_type(CPURISCVState *env,
-                                                target_ulong tdata1)
+static inline uint64_t extract_trigger_type(CPURISCVState *env,
+                                            uint64_t tdata1)
 {
     switch (riscv_cpu_mxl(env)) {
     case MXL_RV32:
@@ -96,16 +96,16 @@ static inline target_ulong extract_trigger_type(CPURISCVState *env,
     }
 }
 
-static inline target_ulong get_trigger_type(CPURISCVState *env,
-                                            target_ulong trigger_index)
+static inline uint64_t get_trigger_type(CPURISCVState *env,
+                                        uint8_t trigger_index)
 {
     return extract_trigger_type(env, env->tdata1[trigger_index]);
 }
 
 static trigger_action_t get_trigger_action(CPURISCVState *env,
-                                           target_ulong trigger_index)
+                                           uint8_t trigger_index)
 {
-    target_ulong tdata1 = env->tdata1[trigger_index];
+    uint64_t tdata1 = env->tdata1[trigger_index];
     int trigger_type = get_trigger_type(env, trigger_index);
     trigger_action_t action = DBG_ACTION_NONE;
 
@@ -135,11 +135,11 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
     return action;
 }
 
-static inline target_ulong build_tdata1(CPURISCVState *env,
-                                        trigger_type_t type,
-                                        bool dmode, target_ulong data)
+static inline uint64_t build_tdata1(CPURISCVState *env,
+                                    trigger_type_t type,
+                                    bool dmode, uint64_t data)
 {
-    target_ulong tdata1;
+    uint64_t tdata1;
 
     switch (riscv_cpu_mxl(env)) {
     case MXL_RV32:
@@ -183,11 +183,11 @@ void tselect_csr_write(CPURISCVState *env, target_ulong val)
     }
 }
 
-static target_ulong tdata1_validate(CPURISCVState *env, target_ulong val,
-                                    trigger_type_t t)
+static uint64_t tdata1_validate(CPURISCVState *env, uint64_t val,
+                                trigger_type_t t)
 {
     uint32_t type, dmode;
-    target_ulong tdata1;
+    uint64_t tdata1;
 
     switch (riscv_cpu_mxl(env)) {
     case MXL_RV32:
@@ -217,7 +217,7 @@ static target_ulong tdata1_validate(CPURISCVState *env, target_ulong val,
     return tdata1;
 }
 
-static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
+static inline void warn_always_zero_bit(uint64_t val, uint64_t mask,
                                         const char *msg)
 {
     if (val & mask) {
@@ -225,11 +225,11 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
-static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
+static uint64_t textra_validate(CPURISCVState *env, uint64_t tdata3)
 {
-    target_ulong mhvalue, mhselect;
-    target_ulong mhselect_new;
-    target_ulong textra;
+    uint64_t mhvalue, mhselect;
+    uint32_t mhselect_new;
+    uint64_t textra;
     const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
 
     switch (riscv_cpu_mxl(env)) {
@@ -237,11 +237,11 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
         mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
         /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
+        warn_always_zero_bit(tdata3, (uint32_t)TEXTRA32_SBYTEMASK,
                              "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
+        warn_always_zero_bit(tdata3, (uint32_t)TEXTRA32_SVALUE,
                              "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
+        warn_always_zero_bit(tdata3, (uint32_t)TEXTRA32_SSELECT,
                              "sselect");
         break;
     case MXL_RV64:
@@ -249,11 +249,11 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
         mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
         /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
+        warn_always_zero_bit(tdata3, TEXTRA64_SBYTEMASK,
                              "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
+        warn_always_zero_bit(tdata3, TEXTRA64_SVALUE,
                              "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
+        warn_always_zero_bit(tdata3, TEXTRA64_SSELECT,
                              "sselect");
         break;
     default:
@@ -285,7 +285,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
     return textra;
 }
 
-static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
+static void do_trigger_action(CPURISCVState *env, uint8_t trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
@@ -314,9 +314,9 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
  * level.
  */
 static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
-                               int trigger_index)
+                               uint8_t trigger_index)
 {
-    target_ulong ctrl = env->tdata1[trigger_index];
+    uint64_t ctrl = env->tdata1[trigger_index];
 
     switch (type) {
     case TRIGGER_TYPE_AD_MATCH:
@@ -373,10 +373,10 @@ static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
 }
 
 static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
-                                 int trigger_index)
+                                 uint8_t trigger_index)
 {
-    target_ulong textra = env->tdata3[trigger_index];
-    target_ulong mhvalue, mhselect;
+    uint64_t textra = env->tdata3[trigger_index];
+    uint64_t mhvalue, mhselect;
 
     if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
         /* textra checking is only applicable when type is 2, 3, 4, 5, or 6 */
@@ -416,7 +416,7 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
 
 /* Common matching conditions for all types of the triggers. */
 static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
-                                 int trigger_index)
+                                 uint8_t trigger_index)
 {
     return trigger_priv_match(env, type, trigger_index) &&
            trigger_textra_match(env, type, trigger_index);
@@ -424,7 +424,7 @@ static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
 
 /* type 2 trigger */
 
-static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong ctrl)
+static uint32_t type2_breakpoint_size(CPURISCVState *env, uint32_t ctrl)
 {
     uint32_t sizelo, sizehi = 0;
 
@@ -435,7 +435,7 @@ static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong ctrl)
     return (sizehi << 2) | sizelo;
 }
 
-static inline bool type2_breakpoint_enabled(target_ulong ctrl)
+static inline bool type2_breakpoint_enabled(uint64_t ctrl)
 {
     bool mode = !!(ctrl & (TYPE2_U | TYPE2_S | TYPE2_M));
     bool rwx = !!(ctrl & (TYPE2_LOAD | TYPE2_STORE | TYPE2_EXEC));
@@ -443,10 +443,10 @@ static inline bool type2_breakpoint_enabled(target_ulong ctrl)
     return mode && rwx;
 }
 
-static target_ulong type2_mcontrol_validate(CPURISCVState *env,
-                                            target_ulong ctrl)
+static uint64_t type2_mcontrol_validate(CPURISCVState *env,
+                                        uint64_t ctrl)
 {
-    target_ulong val;
+    uint64_t val;
     uint32_t size;
 
     /* validate the generic part first */
@@ -479,10 +479,10 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
     return val;
 }
 
-static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
+static void type2_breakpoint_insert(CPURISCVState *env, uint8_t index)
 {
-    target_ulong ctrl = env->tdata1[index];
-    target_ulong addr = env->tdata2[index];
+    uint64_t ctrl = env->tdata1[index];
+    vaddr addr = env->tdata2[index];
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
@@ -517,7 +517,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 }
 
-static void type2_breakpoint_remove(CPURISCVState *env, target_ulong index)
+static void type2_breakpoint_remove(CPURISCVState *env, uint8_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -532,10 +532,10 @@ static void type2_breakpoint_remove(CPURISCVState *env, target_ulong index)
     }
 }
 
-static void type2_reg_write(CPURISCVState *env, target_ulong index,
-                            int tdata_index, target_ulong val)
+static void type2_reg_write(CPURISCVState *env, uint8_t index,
+                            int tdata_index, uint64_t val)
 {
-    target_ulong new_val;
+    uint64_t new_val;
 
     switch (tdata_index) {
     case TDATA1:
@@ -563,7 +563,7 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
 
 /* type 6 trigger */
 
-static inline bool type6_breakpoint_enabled(target_ulong ctrl)
+static inline bool type6_breakpoint_enabled(uint64_t ctrl)
 {
     bool mode = !!(ctrl & (TYPE6_VU | TYPE6_VS | TYPE6_U | TYPE6_S | TYPE6_M));
     bool rwx = !!(ctrl & (TYPE6_LOAD | TYPE6_STORE | TYPE6_EXEC));
@@ -571,10 +571,10 @@ static inline bool type6_breakpoint_enabled(target_ulong ctrl)
     return mode && rwx;
 }
 
-static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
-                                             target_ulong ctrl)
+static uint64_t type6_mcontrol6_validate(CPURISCVState *env,
+                                         uint64_t ctrl)
 {
-    target_ulong val;
+    uint64_t val;
     uint32_t size;
 
     /* validate the generic part first */
@@ -609,10 +609,10 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     return val;
 }
 
-static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
+static void type6_breakpoint_insert(CPURISCVState *env, uint8_t index)
 {
-    target_ulong ctrl = env->tdata1[index];
-    target_ulong addr = env->tdata2[index];
+    uint64_t ctrl = env->tdata1[index];
+    vaddr addr = env->tdata2[index];
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
@@ -646,15 +646,15 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 }
 
-static void type6_breakpoint_remove(CPURISCVState *env, target_ulong index)
+static void type6_breakpoint_remove(CPURISCVState *env, uint8_t index)
 {
     type2_breakpoint_remove(env, index);
 }
 
-static void type6_reg_write(CPURISCVState *env, target_ulong index,
-                            int tdata_index, target_ulong val)
+static void type6_reg_write(CPURISCVState *env, uint8_t index,
+                            int tdata_index, uint64_t val)
 {
-    target_ulong new_val;
+    uint64_t new_val;
 
     switch (tdata_index) {
     case TDATA1:
@@ -682,20 +682,20 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
 
 /* icount trigger type */
 static inline int
-itrigger_get_count(CPURISCVState *env, int index)
+itrigger_get_count(CPURISCVState *env, uint8_t index)
 {
     return get_field(env->tdata1[index], ITRIGGER_COUNT);
 }
 
 static inline void
-itrigger_set_count(CPURISCVState *env, int index, int value)
+itrigger_set_count(CPURISCVState *env, uint8_t index, int value)
 {
     env->tdata1[index] = set_field(env->tdata1[index],
                                    ITRIGGER_COUNT, value);
 }
 
 static inline void
-itrigger_set_pending(CPURISCVState *env, int index, int val)
+itrigger_set_pending(CPURISCVState *env, uint8_t index, int val)
 {
     if (!debug_trigger_version_1_0(env)) {
         return;
@@ -705,9 +705,9 @@ itrigger_set_pending(CPURISCVState *env, int index, int val)
                                    ITRIGGER_PENDING, val);
 }
 
-static bool check_itrigger_priv(CPURISCVState *env, int index)
+static bool check_itrigger_priv(CPURISCVState *env, uint8_t index)
 {
-    target_ulong tdata1 = env->tdata1[index];
+    uint64_t tdata1 = env->tdata1[index];
     if (env->virt_enabled) {
         /* check VU/VS bit against current privilege level */
         return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
@@ -835,10 +835,10 @@ void riscv_itrigger_update_priv(CPURISCVState *env)
     riscv_itrigger_update_count(env);
 }
 
-static target_ulong itrigger_validate(CPURISCVState *env,
-                                      target_ulong ctrl)
+static uint64_t itrigger_validate(CPURISCVState *env,
+                                  uint64_t ctrl)
 {
-    target_ulong val;
+    uint64_t val;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_INST_CNT);
@@ -855,10 +855,10 @@ static target_ulong itrigger_validate(CPURISCVState *env,
     return val;
 }
 
-static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
-                               int tdata_index, target_ulong val)
+static void itrigger_reg_write(CPURISCVState *env, uint8_t index,
+                               int tdata_index, uint64_t val)
 {
-    target_ulong new_val;
+    uint64_t new_val;
 
     switch (tdata_index) {
     case TDATA1:
@@ -989,8 +989,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     CPUBreakpoint *bp;
-    target_ulong ctrl;
-    target_ulong pc;
+    uint64_t ctrl;
+    vaddr pc;
     int trigger_type;
     int i;
 
@@ -1035,8 +1035,8 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong ctrl;
-    target_ulong addr;
+    uint64_t ctrl;
+    vaddr addr;
     int trigger_type;
     int flags;
     int i;
@@ -1131,7 +1131,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
-    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
+    uint64_t tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
     int i;
 
     /* init to type 2 triggers */

-- 
2.52.0


