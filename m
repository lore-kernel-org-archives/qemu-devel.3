Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E29C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfe-0007VB-CY; Wed, 02 Jul 2025 08:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfb-0007SF-1G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:35 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfP-0000vd-L0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:34 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ea2fee5471so3668056fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459657; x=1752064457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feRjxLmhrg6X+CnBaSEjpc+GubWFISEAMkyHftCn26M=;
 b=Jp4PPDI7h8MCrZJnf0p5Ab/n9hr3Cc2asfrAlw3Pdk5GgK90n9l3EY1tJnCYGtl8Q6
 UcmdbUNwfe0YZgoQTxt5kmcaq/Lm/QI/joNJadVRR5WUaeWd0TIvlPy9HbHUqx1X3tlS
 qk/K3I1X4dlZ2qmno4mHSQI6sREBrTSAqeJHIqY+oEOQMqQE8hXlchai/010xVurE7q2
 y3G/ifH0nZwgxuxIRQKs5uvDflHfy8H28NVISSv5lV5jTcNjh76F3i83T3THB1sMmMCx
 vK8V6qnI+lu6mKAz0fQMWKtOkqAae6IFH2PKpjbIazVtdHEFBYXl3uYZCZkZIQQF3RsL
 Z3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459657; x=1752064457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feRjxLmhrg6X+CnBaSEjpc+GubWFISEAMkyHftCn26M=;
 b=aQyXpB1vcCagMcdPib1HYdHWlqjHM2dI2IuFumN0M1Uwkh4O6tVN4HUDOmw7QzPTmi
 wtGPv3aSoyKPGCyA9HPKrhv3P7USxFM3n2hUkkIZL/Mdut1dzrbHpYzNrT3Zco2hYxiq
 S/reDKbmCUm1ELLcMpmSTmUKKTQ9975fMbq9trpWs7TaaccWcu4odMXCuiEePSG+WkGg
 TLJdppjWGwMvGO5SoGUcsUvi38XgTvYZPw7nbqBqrfjqWa3gJxAjBOtnWDzJEKAKT+ps
 81lAsjZjXHgIHfwKG6UBpLC8ikx5Nmbpa1XCuffQdBUc946szDkmE6axcUuQ7JKnu9pl
 07uw==
X-Gm-Message-State: AOJu0YyOmQntUWfy89m9wYQqGXPoWQ8nIaeA427LEBswB+FF9QYLPTMe
 BllR8REzWB7MXwemB3t4OKLsXuhbcWgpHC2B2OUPITKEnaGGCfunwsqffQ+rJt61KHOwOn3PfjN
 tcw2KFNM=
X-Gm-Gg: ASbGncuWqsjWcyzgSfj3kZZsMVV2CWaGpXymFHUUcQYynwvnbVGHsAJUXg43b2Qr4cE
 CDQzlRUABpQUrsFfdp/qjGKops8ESWMepbGmgopgafWZuTVC9188XKoJoVpGUQCnbB1WxTpfgdt
 Kz00v6YSr6VfnUlX4dgoCTqoG5V5ucfARYlOA4BuIz005T+uYleMdevzrYNHLlCybrVkTljRSfy
 1+Sg9gT0x7gK6Hdj7M0xOyvf4EN7JPAxQOOe1AVYldGOPBgFfveLVqSFWfQG+sl028Sigf1gwSW
 Lv+4Qf0w/f0u7Ri8N071Zvml7VwF3V5VqpDS60pA4r/JXkcimOE+SPs/RUPuKHVujXVooQ==
X-Google-Smtp-Source: AGHT+IHVExvlFNpQ6wR2MqzJlQkFes3TksAYP4wGQqBKQilq9ZPPF6XTe8rj101hk4hmN7oZeac2IQ==
X-Received: by 2002:a05:6870:d696:b0:2ea:9932:f1ac with SMTP id
 586e51a60fabf-2f664836d8dmr2029548fac.12.1751459656946; 
 Wed, 02 Jul 2025 05:34:16 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 03/97] target/arm: Rename zarray to za_state.za
Date: Wed,  2 Jul 2025 06:32:36 -0600
Message-ID: <20250702123410.761208-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The whole ZA state will also contain ZT0.
Make things easier in aarch64_set_svcr to zero both
by wrapping them in a common structure.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 48 +++++++++++++++++++---------------
 linux-user/aarch64/signal.c    |  4 +--
 target/arm/cpu.c               |  4 +--
 target/arm/helper.c            |  2 +-
 target/arm/machine.c           |  2 +-
 target/arm/tcg/sme_helper.c    |  6 ++---
 target/arm/tcg/translate-sme.c |  4 +--
 7 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c5060bcb97..052ca20283 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -714,27 +714,33 @@ typedef struct CPUArchState {
 
     uint64_t scxtnum_el[4];
 
-    /*
-     * SME ZA storage -- 256 x 256 byte array, with bytes in host word order,
-     * as we do with vfp.zregs[].  This corresponds to the architectural ZA
-     * array, where ZA[N] is in the least-significant bytes of env->zarray[N].
-     * When SVL is less than the architectural maximum, the accessible
-     * storage is restricted, such that if the SVL is X bytes the guest can
-     * see only the bottom X elements of zarray[], and only the least
-     * significant X bytes of each element of the array. (In other words,
-     * the observable part is always square.)
-     *
-     * The ZA storage can also be considered as a set of square tiles of
-     * elements of different sizes. The mapping from tiles to the ZA array
-     * is architecturally defined, such that for tiles of elements of esz
-     * bytes, the Nth row (or "horizontal slice") of tile T is in
-     * ZA[T + N * esz]. Note that this means that each tile is not contiguous
-     * in the ZA storage, because its rows are striped through the ZA array.
-     *
-     * Because this is so large, keep this toward the end of the reset area,
-     * to keep the offsets into the rest of the structure smaller.
-     */
-    ARMVectorReg zarray[ARM_MAX_VQ * 16];
+    struct {
+        /*
+         * SME ZA storage -- 256 x 256 byte array, with bytes in host
+         * word order, as we do with vfp.zregs[].  This corresponds to
+         * the architectural ZA array, where ZA[N] is in the least
+         * significant bytes of env->za_state.za[N].
+         *
+         * When SVL is less than the architectural maximum, the accessible
+         * storage is restricted, such that if the SVL is X bytes the guest
+         * can see only the bottom X elements of zarray[], and only the least
+         * significant X bytes of each element of the array. (In other words,
+         * the observable part is always square.)
+         *
+         * The ZA storage can also be considered as a set of square tiles of
+         * elements of different sizes. The mapping from tiles to the ZA array
+         * is architecturally defined, such that for tiles of elements of esz
+         * bytes, the Nth row (or "horizontal slice") of tile T is in
+         * ZA[T + N * esz]. Note that this means that each tile is not
+         * contiguous in the ZA storage, because its rows are striped through
+         * the ZA array.
+         *
+         * Because this is so large, keep this toward the end of the
+         * reset area, to keep the offsets into the rest of the structure
+         * smaller.
+         */
+        ARMVectorReg za[ARM_MAX_VQ * 16];
+    } za_state;
 
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index bc7a13800d..d50cab78d8 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -248,7 +248,7 @@ static void target_setup_za_record(struct target_za_context *za,
     for (i = 0; i < vl; ++i) {
         uint64_t *z = (void *)za + TARGET_ZA_SIG_ZAV_OFFSET(vq, i);
         for (j = 0; j < vq * 2; ++j) {
-            __put_user_e(env->zarray[i].d[j], z + j, le);
+            __put_user_e(env->za_state.za[i].d[j], z + j, le);
         }
     }
 }
@@ -397,7 +397,7 @@ static bool target_restore_za_record(CPUARMState *env,
     for (i = 0; i < vl; ++i) {
         uint64_t *z = (void *)za + TARGET_ZA_SIG_ZAV_OFFSET(vq, i);
         for (j = 0; j < vq * 2; ++j) {
-            __get_user_e(env->zarray[i].d[j], z + j, le);
+            __get_user_e(env->za_state.za[i].d[j], z + j, le);
         }
     }
     return true;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6111b9db91..f7cbdd6814 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1335,8 +1335,8 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             qemu_fprintf(f, "ZA[%0*d]=", svl_lg10, i);
             for (j = zcr_len; j >= 0; --j) {
                 qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%c",
-                             env->zarray[i].d[2 * j + 1],
-                             env->zarray[i].d[2 * j],
+                             env->za_state.za[i].d[2 * j + 1],
+                             env->za_state.za[i].d[2 * j],
                              j ? ':' : '\n');
             }
         }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 889d308807..617097a9e7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6663,7 +6663,7 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
      * when disabled either.
      */
     if (change & new & R_SVCR_ZA_MASK) {
-        memset(env->zarray, 0, sizeof(env->zarray));
+        memset(&env->za_state, 0, sizeof(env->za_state));
     }
 
     if (tcg_enabled()) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e442d48524..6e73368ef9 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -315,7 +315,7 @@ static const VMStateDescription vmstate_za = {
     .minimum_version_id = 1,
     .needed = za_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(env.zarray, ARMCPU, ARM_MAX_VQ * 16, 0,
+        VMSTATE_STRUCT_ARRAY(env.za_state.za, ARMCPU, ARM_MAX_VQ * 16, 0,
                              vmstate_vreg, ARMVectorReg),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 9942d717aa..7b0bc1b17c 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -39,12 +39,12 @@ void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
     uint32_t i;
 
     /*
-     * Special case clearing the entire ZA space.
+     * Special case clearing the entire ZArray.
      * This falls into the CONSTRAINED UNPREDICTABLE zeroing of any
      * parts of the ZA storage outside of SVL.
      */
     if (imm == 0xff) {
-        memset(env->zarray, 0, sizeof(env->zarray));
+        memset(env->za_state.za, 0, sizeof(env->za_state.za));
         return;
     }
 
@@ -54,7 +54,7 @@ void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
      */
     for (i = 0; i < svl; i++) {
         if (imm & (1 << (i % 8))) {
-            memset(&env->zarray[i], 0, svl);
+            memset(&env->za_state.za[i], 0, svl);
         }
     }
 }
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 51175c923e..e8b3578174 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -92,7 +92,7 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     offset = tile * sizeof(ARMVectorReg);
 
     /* Include the byte offset of zarray to make this relative to env. */
-    offset += offsetof(CPUARMState, zarray);
+    offset += offsetof(CPUARMState, za_state.za);
     tcg_gen_addi_i32(tmp, tmp, offset);
 
     /* Add the byte offset to env to produce the final pointer. */
@@ -112,7 +112,7 @@ static TCGv_ptr get_tile(DisasContext *s, int esz, int tile)
     TCGv_ptr addr = tcg_temp_new_ptr();
     int offset;
 
-    offset = tile * sizeof(ARMVectorReg) + offsetof(CPUARMState, zarray);
+    offset = tile * sizeof(ARMVectorReg) + offsetof(CPUARMState, za_state.za);
 
     tcg_gen_addi_ptr(addr, tcg_env, offset);
     return addr;
-- 
2.43.0


