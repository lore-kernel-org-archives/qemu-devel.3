Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA1ECDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFsr-0005YJ-8x; Wed, 24 Jun 2026 01:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsH-0005Gx-Gn; Wed, 24 Jun 2026 01:10:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsE-000631-5Q; Wed, 24 Jun 2026 01:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277633; bh=BeCM0RUuRRvOh24wgT1LYrTgGlkDqTNpjYmrIFgqr0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p50qv2zsMAMGddw5HF8sCoko6QEBLM/fDuUle+uXmTVpbzPE9Fwa06Ztq2LKGxoea
 5sOXYsftGKnINkTzP5pxDyBCgvjZ1ej3dzSdrBV6PwQAF/3yBzYKOtBDJkm1SliAWi
 T/oxQPePntbcv0pyMykCkf/wP7cF07Vlop6iTdXANlRi5RT6K1ZixMU8DgG65h3tNM
 4zHpJZzRnZPfECAYoH66YpFd+b93R8LVETeUcfdlZJNJk51H2H7ZbM/yhSksgtD8C7
 bHkWcxxJEaXhxPUjauDE12t0PZNCFRuSV0pyBlzODuQtKwy+8PEol+RPGCCE8OgobC
 AryLGvtdiwaRg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 113131BA678;
 Wed, 24 Jun 2026 08:07:13 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EDB5B3DDB15;
 Wed, 24 Jun 2026 08:07:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 90/95] target/xtensa: add cpu_set_fcr/fsr helpers to
 sync fp_status
Date: Wed, 24 Jun 2026 08:05:25 +0300
Message-ID: <20260624050541.395079-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

Factor FCR→fp_status and FSR→fp_status synchronisation out of the
wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
mode and exception flags without duplicating the flag-mapping tables.

cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
that FCR bits valid only on fpu2k configs are preserved while MBZ bits
7-11 are always cleared.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 7e859bacea09a626c239f14ab9c01f13d5225723)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 74122ebe15..e7c7eefa73 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -643,6 +643,10 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
 
+uint32_t cpu_get_fsr(CPUXtensaState *env);
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v);
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v);
+
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
 
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 5358060c50..2e51cabe3f 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -64,46 +64,39 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
                              &env->fp_status);
 }
 
-void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
+uint32_t cpu_get_fsr(CPUXtensaState *env)
 {
-    static const int rounding_mode[] = {
-        float_round_nearest_even,
-        float_round_to_zero,
-        float_round_up,
-        float_round_down,
-    };
+    uint32_t flags = 0;
+    int fef = get_float_exception_flags(&env->fp_status);
+    unsigned i;
 
-    env->uregs[FCR] = v & 0xfffff07f;
-    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
+            flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
+        }
+    }
+    return flags << XTENSA_FSR_FLAGS_SHIFT;
 }
 
-void HELPER(wur_fpu_fcr)(CPUXtensaState *env, uint32_t v)
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v)
 {
-    static const int rounding_mode[] = {
+    static const FloatRoundMode rounding_mode[] = {
         float_round_nearest_even,
         float_round_to_zero,
         float_round_up,
         float_round_down,
     };
 
-    if (v & 0xfffff000) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "MBZ field of FCR is written non-zero: %08x\n", v);
-    }
-    env->uregs[FCR] = v & 0x0000007f;
+    env->uregs[FCR] = v & 0xfffff07f;
     set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
 }
 
-void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v)
 {
     uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
     int fef = 0;
     unsigned i;
 
-    if (v & 0xfffff000) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "MBZ field of FSR is written non-zero: %08x\n", v);
-    }
     env->uregs[FSR] = v & 0x00000f80;
     for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
         if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
@@ -113,19 +106,35 @@ void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
     set_float_exception_flags(fef, &env->fp_status);
 }
 
-uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
+void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
-    uint32_t flags = 0;
-    int fef = get_float_exception_flags(&env->fp_status);
-    unsigned i;
+    cpu_set_fcr(env, v);
+}
 
-    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
-        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
-            flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
-        }
+void HELPER(wur_fpu_fcr)(CPUXtensaState *env, uint32_t v)
+{
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FCR is written non-zero: %08x\n", v);
     }
-    env->uregs[FSR] = flags << XTENSA_FSR_FLAGS_SHIFT;
-    return flags << XTENSA_FSR_FLAGS_SHIFT;
+    cpu_set_fcr(env, v & 0x0000007f);
+}
+
+void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
+{
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FSR is written non-zero: %08x\n", v);
+    }
+    cpu_set_fsr(env, v);
+}
+
+uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
+{
+    uint32_t fsr = cpu_get_fsr(env);
+
+    env->uregs[FSR] = fsr;
+    return fsr;
 }
 
 float64 HELPER(abs_d)(float64 v)
-- 
2.47.3


