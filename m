Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241ECC4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWotu-0001Rh-VP; Sun, 04 Feb 2024 21:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWott-0001RO-Dw
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:40:01 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWotr-0003bV-Es
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:40:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so32565075ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707100797; x=1707705597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=758g2WVfCmSr7yE/Jykawsl4J6dqw18g8wokjT3TaQQ=;
 b=N1mFUTmn/n6YQ9lYrjUejes65sB19VJo7IMVEdeR5Z0Ob0Fm1JvMGizR8GGXWaG3sJ
 uSE3FiAx+loM9NvoQROXznKNMRJVciBbrepuix6+wmAGUL6F1A1Hh/COm9JLh37Wga+B
 PhoFV5r4I95GSNHVXe/eZr/UdtiVqdmFPnO/S8TtwfKD94pTvD6rnvzEswliNYEAew2r
 jXyjAP46qXS7J2qOvPT8U5O6jIJTb1xsYln8FKpoNDZQhPbxwWzZ16afh6gIT6OWY7p2
 YHWV7mVuIaQ+18af42iRQVYOeWxG47GmoSdAaMZ35WEOnWIYICphCKojsaxY/lns6jXf
 9EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707100797; x=1707705597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=758g2WVfCmSr7yE/Jykawsl4J6dqw18g8wokjT3TaQQ=;
 b=r4GruOXt2gbHVhMIAhdI5BtiHE+ETk+pLz1pD0blw1Sjct8Ok5l+lCnYghKS05TZ4k
 yIgMmjXyqd1yGCAOvMMKFtKFWR3V0BG/ujjUPR5G1zTLYkPiJWro7ofty1BkiOQkqgNX
 RaGw+jaY+AILNdbtad8MAHs5OxzIoNW96dpx17LKmHzE2ZvDPxEPekMZgTYNHNL5KCVk
 pTGEzS5WdHtjpSDbd5cVYAOXbMfGZI6LtC4tQKNC8p/dQ4AHV/lf0khKxnPhZ0QqUiKp
 yTgYbioZNdiDEtN/Gd4m2Ca/1xcLvwfVpqnYCgmvL6SqhjaDBmhRupi4m5PIi3BwbcSf
 W2Zw==
X-Gm-Message-State: AOJu0YxxN2IR58uOi7OcCYsFCzIeqpuwwcDVaWbSjvNnZvT+S+tgLXF7
 MsyXE6nxiw3mCA/4wsnLf9YM64lU1oBPnURj5ku7lxI8bmT3Y7NeBLyrOPirZjV4xQby3/D5L8+
 DyBo=
X-Google-Smtp-Source: AGHT+IE+6u35CHCbGQX5t5VqLaV+3vsY3t09+aa7UYVCQSo2rCs2ncvWMERwvCk+U/leyDVoNrnDsQ==
X-Received: by 2002:a17:902:eb90:b0:1d9:63ac:f54a with SMTP id
 q16-20020a170902eb9000b001d963acf54amr13564151plg.36.1707100797164; 
 Sun, 04 Feb 2024 18:39:57 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 d20-20020a170903209400b001d98942d290sm3292130plc.124.2024.02.04.18.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 18:39:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 2/3] target/arm: Move SVE/SME MTE disable checks inward
Date: Mon,  5 Feb 2024 12:39:47 +1000
Message-Id: <20240205023948.25476-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205023948.25476-1-richard.henderson@linaro.org>
References: <20240205023948.25476-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 32 +---------------
 target/arm/tcg/sve_helper.c | 76 +++++++++----------------------------
 2 files changed, 20 insertions(+), 88 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 904bfdac43..b3e0ba9b29 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -459,14 +459,7 @@ void sme_ld1(CPUARMState *env, void *za, uint64_t *vg,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, esize, esize,
                               BP_MEM_READ, ra);
 
-    /*
-     * Handle mte checks for all active elements.
-     * Since TBI must be set for MTE, !mtedesc => !mte_active.
-     */
-    if (mtedesc) {
-        sve_cont_ldst_mte_check(&info, env, vg, addr, esize, esize,
-                                mtedesc, ra);
-    }
+    sve_cont_ldst_mte_check(&info, env, vg, addr, esize, esize, mtedesc, ra);
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -567,17 +560,10 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
                  CopyFn *cpy_fn)
 {
     uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    int bit55 = extract64(addr, 55, 1);
 
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
-        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
-        mtedesc = 0;
-    }
-
     sme_ld1(env, za, vg, addr, desc, ra, esz, mtedesc, vertical,
             host_fn, tlb_fn, clr_fn, cpy_fn);
 }
@@ -655,14 +641,7 @@ void sme_st1(CPUARMState *env, void *za, uint64_t *vg,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, esize, esize,
                               BP_MEM_WRITE, ra);
 
-    /*
-     * Handle mte checks for all active elements.
-     * Since TBI must be set for MTE, !mtedesc => !mte_active.
-     */
-    if (mtedesc) {
-        sve_cont_ldst_mte_check(&info, env, vg, addr, esize, esize,
-                                mtedesc, ra);
-    }
+    sve_cont_ldst_mte_check(&info, env, vg, addr, esize, esize, mtedesc, ra);
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -744,17 +723,10 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
     uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    int bit55 = extract64(addr, 55, 1);
 
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
-        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
-        mtedesc = 0;
-    }
-
     sme_st1(env, za, vg, addr, desc, ra, esz, mtedesc,
             vertical, host_fn, tlb_fn);
 }
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 6853f58c19..9fd469b00f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5604,6 +5604,13 @@ void sve_cont_ldst_mte_check(SVEContLdSt *info, CPUARMState *env,
                              int msize, uint32_t mtedesc, uintptr_t ra)
 {
     intptr_t mem_off, reg_off, reg_last;
+    int bit55 = extract64(addr, 55, 1);
+
+    /* Perform gross MTE suppression early. */
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
+        return;
+    }
 
     /* Process the page only if MemAttr == Tagged. */
     if (info->page[0].tagged) {
@@ -5677,14 +5684,9 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_READ, retaddr);
 
-    /*
-     * Handle mte checks for all active elements.
-     * Since TBI must be set for MTE, !mtedesc => !mte_active.
-     */
-    if (mtedesc) {
-        sve_cont_ldst_mte_check(&info, env, vg, addr, 1 << esz, N << msz,
-                                mtedesc, retaddr);
-    }
+    /* Handle mte checks for all active elements. */
+    sve_cont_ldst_mte_check(&info, env, vg, addr, 1 << esz, N << msz,
+                            mtedesc, retaddr);
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -5794,17 +5796,10 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
     uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    int bit55 = extract64(addr, 55, 1);
 
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
-        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
-        mtedesc = 0;
-    }
-
     sve_ldN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn);
 }
 
@@ -5999,10 +5994,13 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     flags = info.page[0].flags;
 
     /*
-     * Disable MTE checking if the Tagged bit is not set.  Since TBI must
-     * be set within MTEDESC for MTE, !mtedesc => !mte_active.
+     * Perform gross MTE suppression early.
+     * Since TBI must be set for MTE, !mtedesc => !mte_active.
      */
-    if (!info.page[0].tagged) {
+    int bit55 = extract64(addr, 55, 1);
+    if (!info.page[0].tagged ||
+        !tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6150,17 +6148,10 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
                        sve_ldst1_tlb_fn *tlb_fn)
 {
     uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    int bit55 = extract64(addr, 55, 1);
 
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
-        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
-        mtedesc = 0;
-    }
-
     sve_ldnfff1_r(env, vg, addr, desc, retaddr, mtedesc,
                   esz, msz, fault, host_fn, tlb_fn);
 }
@@ -6295,14 +6286,8 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_WRITE, retaddr);
 
-    /*
-     * Handle mte checks for all active elements.
-     * Since TBI must be set for MTE, !mtedesc => !mte_active.
-     */
-    if (mtedesc) {
-        sve_cont_ldst_mte_check(&info, env, vg, addr, 1 << esz, N << msz,
-                                mtedesc, retaddr);
-    }
+    sve_cont_ldst_mte_check(&info, env, vg, addr, 1 << esz, N << msz,
+                            mtedesc, retaddr);
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -6404,17 +6389,10 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
     uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
-    int bit55 = extract64(addr, 55, 1);
 
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
-        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
-        mtedesc = 0;
-    }
-
     sve_stN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn);
 }
 
@@ -6596,12 +6574,6 @@ void sve_ld1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /*
-     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
-     * offset base entirely over the address space hole to change the
-     * pointer tag, or change the bit55 selector.  So we could here
-     * examine TBI + TCMA like we do for sve_ldN_r_mte().
-     */
     sve_ld1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
               esize, msize, off_fn, host_fn, tlb_fn);
 }
@@ -6804,12 +6776,6 @@ void sve_ldff1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /*
-     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
-     * offset base entirely over the address space hole to change the
-     * pointer tag, or change the bit55 selector.  So we could here
-     * examine TBI + TCMA like we do for sve_ldN_r_mte().
-     */
     sve_ldff1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
                 esz, msz, off_fn, host_fn, tlb_fn);
 }
@@ -7006,12 +6972,6 @@ void sve_st1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     /* Remove mtedesc from the normal sve descriptor. */
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
-    /*
-     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
-     * offset base entirely over the address space hole to change the
-     * pointer tag, or change the bit55 selector.  So we could here
-     * examine TBI + TCMA like we do for sve_ldN_r_mte().
-     */
     sve_st1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
               esize, msize, off_fn, host_fn, tlb_fn);
 }
-- 
2.34.1


