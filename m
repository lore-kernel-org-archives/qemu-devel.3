Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEB-0008Rb-4q; Fri, 04 Jul 2025 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE9-0008QE-Nz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE7-0006A5-Jy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso11814855e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646326; x=1752251126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gmc/qX5hnqvVyOg3tLZ5xhJ8CZIIWAPZFOvrCJ6HrLo=;
 b=IOdbVNpRAa+RPK6/v50vYxztrtPdCXr6e/ShMsfewWfmU50pIiUrf6zJ5dDKOEk7Vk
 THL6VedXkI4wIgzxjGKtYCPcPQwXzonHmkkQ/cgTcsmt7PzJmWe5+vVUVCsfEzPxuNPN
 Fb8FKAqHfalfW47KNyB1bilBhrlgHTRKb7lbRlyhiaAVp1pNrzv2OqCc2c6BufcdpLTl
 IFJ6GdDlzjLpA2qcPNAGUN9ixNnAxsPePvFm5YxO+Z/5SKoQoi0PiL6eCwsIoT15NMyS
 Epb2NYalYd8AXlE7eDDZyFlJH+nPX3UX3wfnKTUuiQEErncqUb4l67u1P5K544QALSI7
 X8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646326; x=1752251126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmc/qX5hnqvVyOg3tLZ5xhJ8CZIIWAPZFOvrCJ6HrLo=;
 b=km+bLEXxFAwMBOwNJXSlysvqspfqdZCDYAP5j5DC/Dm2R2gvTFdGCbFpPvn3pUQhAg
 BdWi93nD9p2IBiPc/TQbdafv8VMhMmK0oHaui9X5FgP+E2OZpmUFJ1vwOLzZbKqtAehh
 ROoiSITyLksrexwUkpc/kXi/qsgUOMqDXTdS8c8Z40ZcpsURSlXqkb3Xa+o88EzqTF4Y
 fOHp/8TuTqka6xVATwu6URVVc8wy7SQ7g0guFsEkzvvTF3xXXNA9PlX+3ZF8lkWYUmRD
 1bafNd93tBTuxFSyBnBVpyLr33B7HSbLf7x7Zn0XpcRslolgZ7phQAyxRDXgrACCvzhM
 cDCA==
X-Gm-Message-State: AOJu0YxiTDmvY9OrW8zeCx79/b73F29k4vT1ZeLwDBLrzd0X3BwxB9RJ
 lBEpZsCf7Izzd0VvJnTF8eWXYpGcJmKGRyDk2/TTSoGtCeWysvtS4B4hcYbn8W4aHvXG45qZkn3
 ruks+
X-Gm-Gg: ASbGncvf1UYXSPz5TMAxdZZ/cR6XRwwxsEFvke2CjPuthBmx8sh9aDGM/udhcRsHR2W
 J3DbuuBuS4TV9N8c0Pa8Sj0W0ZVMuNoixjC1xZzw1RjB/maciqVgjbXtuUC6kWYoyuDRmMjisDh
 3IRh1ApFxR5u7mDkZlXZWubuMeZpox5WeMXw4Np3ZTUk3YkCYUWUUeqTwKAeqsuu6DDZZR3yNii
 qDtLzSmMm0Ik7SHeQxStn6RpTwSHT0ZllzYf9f0eS9/PUYYEr24JIpNYl/d+RJS8JC/+K7jyfGW
 E68HF+6bm3P7joGehHR6qSW38lOhiKT89+IjTx5jMwtz4vjJZJ356NqQ4oEnJ+nNzWZG
X-Google-Smtp-Source: AGHT+IE2omN88sDEWc+RDHVMU6SCjbiSacRRMnlwBT4jUfbDRTS+rhb/uIrSTZVyAzE+YKMOdxHaJQ==
X-Received: by 2002:a05:600c:3e09:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-454b4ec8adamr23832985e9.33.1751646326057; 
 Fri, 04 Jul 2025 09:25:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 025/119] target/arm: Rename zarray to za_state.za
Date: Fri,  4 Jul 2025 17:23:25 +0100
Message-ID: <20250704162501.249138-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The whole ZA state will also contain ZT0.
Make things easier in aarch64_set_svcr to zero both
by wrapping them in a common structure.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 2530aaca22c..7db97e80386 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -715,27 +715,33 @@ typedef struct CPUArchState {
 
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
index bc7a13800da..d50cab78d83 100644
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
index 7b207f2620c..62656277625 100644
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
index c311d2df217..3879bce8489 100644
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
index e442d485241..6e73368ef97 100644
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
index 9942d717aaa..7b0bc1b17c0 100644
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
index 51175c923ef..e8b35781741 100644
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


