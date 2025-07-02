Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE73C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwpz-0005rU-Dj; Wed, 02 Jul 2025 08:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0008So-5s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:16 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwmm-00037I-Hr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:09 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso4580693fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460119; x=1752064919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YM8SgpcnePCIIRu/BR9umdB360cvU+pmOX3eBs2ijXI=;
 b=G7Qw8edutHzQTDGuACAv/ue/LuTVefTZs2bSSoLIy2o4RgHW2LlV++pefctZ6eeKrm
 ROraqJB03zqsaIXln98q+1wmNLIe41t9exBx46Oi3gFn9ol+mAc6BYFjPbozpwXN4GOz
 H3HAamHBUgDY/Da+KKhLGKLWeJmox6ugIawTMEJxvrSzTx1YUBtpchopJGFZ2aLm9b/F
 3mgOHn/t13H/Qr8kDNR+SZ2zgBcBrO7Hc+0cIa99cc1HInDQR9yMgNjM0KRGOE4TbGNw
 rv4gwpjo/biSyXp0HMQ/OsUCqpazo+bSrFWvQyoOo6BKtZDqnsCEjNKu9l6GDV5egHP6
 JXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460119; x=1752064919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YM8SgpcnePCIIRu/BR9umdB360cvU+pmOX3eBs2ijXI=;
 b=f3xzAIanMNrWLaBPck/VDWB2c0P8w2+2Ump8CemITpww7ogGP8m9Ogj8UxLgaNyyOB
 UxxtWLiYuU9umdeRKNL0DosCs9qCsWuUp+SZ7WHDpSj6B/wTOeeNqMGTFWg8XMEuWfjd
 WM7DM0SEkrWyms7uYulQBR/2Y+3OnOeueKb0IqnGxO9e+WKGFwQR+4lt+BsTk62+acTM
 T3DY7YdVHsi8aP32KN2c+JVWexHEmrry0vjrIs9AEX20jqea/rtwGkmEglwfMNsVNYkJ
 TvGW1EEyfhYjMzS02TwO01pVl376sts3TA1MgJpGxAfoc4CtZRfLjQfHhujPZbe/v/3/
 D24w==
X-Gm-Message-State: AOJu0YyC+NKTezaGG7Seyf1eSJK1NK2FPqg+Up8if3FHpjltWqWTSws8
 cAWp15nXhhTZFs+Wv8KjcT/HZLSQ7C3vroxPGtPBOBGRwHirBJm+BHQELzyEnrGo4cTJSncrWGQ
 VVSXmKM4=
X-Gm-Gg: ASbGncu7zYnTq2DJbqNRrrroZnbdqdSbr0eGR98C1fNCj3T2G3kBCWhX1wzE+5/A1AX
 kZDrglU5JaarqH/eAPlB2P0ycPEacgveERBz9QxySn8UTot1obtoDG4sJoFwqID0GZpWNrb8dpY
 aoxqmP0k8kntQr30bOBs9PnYNR4xhJPgdr5JEtCdpNo/MzdhZP44BSyqb1aEZc9twTiCNKM4ZtM
 GgmHsGeCObjf7GlGtigmijhOxBoITKiywfgtIT0PEubMzmczc6xpFCmAS3xaTgAg+KhCm/Wjbwb
 ldQeO7BtG6oOVEh6cNw9Mw+h5y/IYjvs6rsHOkoieL74glXWDS4LiLp9FbMxqou7Y7qxlw==
X-Google-Smtp-Source: AGHT+IF7l4wY/qf7eWRCX3g2W2xXeYmswlwB1bOXev2eMW9y0M9jy22mQTZxacU3REKg7co8ZajcaQ==
X-Received: by 2002:a05:6870:ef05:b0:2f3:e087:7ced with SMTP id
 586e51a60fabf-2f5a8ba6a07mr1866793fac.2.1751460118990; 
 Wed, 02 Jul 2025 05:41:58 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:41:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 82/97] target/arm: Implement SME2 counted predicate
 register load/store
Date: Wed,  2 Jul 2025 06:33:55 -0600
Message-ID: <20250702123410.761208-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Implement the SVE2p1 consecutive register LD1/ST1,
and the SME2 strided register LD1/ST1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  16 ++
 target/arm/tcg/sve_helper.c    | 493 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 103 +++++++
 target/arm/tcg/sve.decode      |  50 ++++
 4 files changed, 662 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 5f4b4aa036..c4736d7510 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -3048,3 +3048,19 @@ DEF_HELPER_FLAGS_3(pmov_pv_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(pmov_vp_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(pmov_vp_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(pmov_vp_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ld1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ld1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_st1bb_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1hh_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1hh_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1ss_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1ss_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1dd_le_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
+DEF_HELPER_FLAGS_5(sve2p1_st1dd_be_c, TCG_CALL_NO_WG, void, env, ptr, tl, i32, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c45d36433c..34e0a9752a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7857,6 +7857,499 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
 
+/*
+ * SVE2.1 consecutive register load/store
+ */
+
+static unsigned sve2p1_cont_ldst_elements(SVEContLdSt *info, vaddr addr,
+                                          uint32_t png, intptr_t reg_max,
+                                          int N, int v_esz)
+{
+    const int esize = 1 << v_esz;
+    intptr_t reg_off_first = -1, reg_off_last = -1, reg_off_split;
+    DecodeCounter p = decode_counter(png, reg_max, v_esz);
+    unsigned b_count = p.count << v_esz;
+    unsigned b_stride = esize * p.stride;
+    intptr_t page_split;
+
+    /* Set all of the element indices to -1, and the TLB data to 0. */
+    memset(info, -1, offsetof(SVEContLdSt, page));
+    memset(info->page, 0, sizeof(info->page));
+
+    if (p.invert) {
+        if (b_count >= reg_max * N) {
+            return 0;
+        }
+        reg_off_first = b_count;
+        reg_off_last = reg_max * N - b_stride;
+    } else {
+        if (b_count == 0) {
+            return 0;
+        }
+        reg_off_first = 0;
+        reg_off_last = MIN(b_count - esize, reg_max * N - b_stride);
+    }
+
+    info->reg_off_first[0] = reg_off_first;
+    info->mem_off_first[0] = reg_off_first;
+
+    page_split = -(addr | TARGET_PAGE_MASK);
+    if (reg_off_last + esize <= page_split || reg_off_first >= page_split) {
+        /* The entire operation fits within a single page. */
+        info->reg_off_last[0] = reg_off_last;
+        return b_stride;
+    }
+
+    info->page_split = page_split;
+    reg_off_split = ROUND_DOWN(page_split, esize);
+
+    /*
+     * This is the last full element on the first page, but it is not
+     * necessarily active.  If there is no full element, i.e. the first
+     * active element is the one that's split, this value remains -1.
+     * It is useful as iteration bounds.
+     */
+    if (reg_off_split != 0) {
+        info->reg_off_last[0] = ROUND_DOWN(reg_off_split - esize, b_stride);
+    }
+
+    /* Determine if an unaligned element spans the pages.  */
+    if (page_split & (esize - 1)) {
+        /* It is helpful to know if the split element is active. */
+        if ((reg_off_split & (b_stride - 1)) == 0) {
+            info->reg_off_split = reg_off_split;
+            info->mem_off_split = reg_off_split;
+        }
+        reg_off_split += esize;
+    }
+
+    /*
+     * We do want the first active element on the second page, because
+     * this may affect the address reported in an exception.
+     */
+    reg_off_split = ROUND_UP(reg_off_split, b_stride);
+    if (reg_off_split <= reg_off_last) {
+        info->reg_off_first[1] = reg_off_split;
+        info->mem_off_first[1] = reg_off_split;
+        info->reg_off_last[1] = reg_off_last;
+    }
+    return b_stride;
+}
+
+static void sve2p1_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
+                                         target_ulong addr, unsigned estride,
+                                         int esize, int wp_access, uintptr_t ra)
+{
+#ifndef CONFIG_USER_ONLY
+    intptr_t count_off, count_last;
+    int flags0 = info->page[0].flags;
+    int flags1 = info->page[1].flags;
+
+    if (likely(!((flags0 | flags1) & TLB_WATCHPOINT))) {
+        return;
+    }
+
+    /* Indicate that watchpoints are handled. */
+    info->page[0].flags = flags0 & ~TLB_WATCHPOINT;
+    info->page[1].flags = flags1 & ~TLB_WATCHPOINT;
+
+    if (flags0 & TLB_WATCHPOINT) {
+        count_off = info->reg_off_first[0];
+        count_last = info->reg_off_split;
+        if (count_last < 0) {
+            count_last = info->reg_off_last[0];
+        }
+        do {
+            cpu_check_watchpoint(env_cpu(env), addr + count_off,
+                                 esize, info->page[0].attrs, wp_access, ra);
+            count_off += estride;
+        } while (count_off <= count_last);
+    }
+
+    count_off = info->reg_off_first[1];
+    if ((flags1 & TLB_WATCHPOINT) && count_off >= 0) {
+        count_last = info->reg_off_last[1];
+        do {
+            cpu_check_watchpoint(env_cpu(env), addr + count_off,
+                                 esize, info->page[1].attrs,
+                                 wp_access, ra);
+            count_off += estride;
+        } while (count_off <= count_last);
+    }
+#endif
+}
+
+static void sve2p1_cont_ldst_mte_check(SVEContLdSt *info, CPUARMState *env,
+                                       target_ulong addr, unsigned estride,
+                                       int esize, uint32_t mtedesc,
+                                       uintptr_t ra)
+{
+    intptr_t count_off, count_last;
+
+    /*
+     * TODO: estride is always a small power of two, <= 8.
+     * Manipulate the stride within the loops such that
+     *   - first iteration hits addr + off, as required,
+     *   - second iteration hits ALIGN_UP(addr, 16),
+     *   - other iterations advance addr by 16.
+     * This will minimize the probing to once per MTE granule.
+     */
+
+    /* Process the page only if MemAttr == Tagged. */
+    if (info->page[0].tagged) {
+        count_off = info->reg_off_first[0];
+        count_last = info->reg_off_split;
+        if (count_last < 0) {
+            count_last = info->reg_off_last[0];
+        }
+
+        do {
+            mte_check(env, mtedesc, addr + count_off, ra);
+            count_off += estride;
+        } while (count_off <= count_last);
+    }
+
+    count_off = info->reg_off_first[1];
+    if (count_off >= 0 && info->page[1].tagged) {
+        count_last = info->reg_off_last[1];
+        do {
+            mte_check(env, mtedesc, addr + count_off, ra);
+            count_off += estride;
+        } while (count_off <= count_last);
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE
+void sve2p1_ld1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
+                  uint32_t png, uint32_t desc,
+                  const uintptr_t ra, const MemOp esz,
+                  sve_ldst1_host_fn *host_fn,
+                  sve_ldst1_tlb_fn *tlb_fn)
+{
+    const unsigned N = (desc >> SIMD_DATA_SHIFT) & 1 ? 4 : 2;
+    const unsigned rstride = 1 << ((desc >> (SIMD_DATA_SHIFT + 1)) % 4);
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    const intptr_t reg_max = simd_oprsz(desc);
+    const unsigned esize = 1 << esz;
+    intptr_t count_off, count_last;
+    intptr_t reg_off, reg_last, reg_n;
+    SVEContLdSt info;
+    unsigned estride, flags;
+    void *host;
+
+    estride = sve2p1_cont_ldst_elements(&info, addr, png, reg_max, N, esz);
+    if (estride == 0) {
+        /* The entire predicate was false; no load occurs.  */
+        for (unsigned n = 0; n < N; n++) {
+            memset(zd + n * rstride, 0, reg_max);
+        }
+        return;
+    }
+
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, ra);
+
+    /* Handle watchpoints for all active elements. */
+    sve2p1_cont_ldst_watchpoints(&info, env, addr, estride,
+                                 esize, BP_MEM_READ, ra);
+
+    /*
+     * Handle mte checks for all active elements.
+     * Since TBI must be set for MTE, !mtedesc => !mte_active.
+     */
+    if (mtedesc) {
+        sve2p1_cont_ldst_mte_check(&info, env, estride, addr,
+                                   esize, mtedesc, ra);
+    }
+
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
+        /*
+         * At least one page includes MMIO.
+         * Any bus operation can fail with cpu_transaction_failed,
+         * which for ARM will raise SyncExternal.  Perform the load
+         * into scratch memory to preserve register state until the end.
+         */
+        ARMVectorReg scratch[4] = { };
+
+        count_off = info.reg_off_first[0];
+        count_last = info.reg_off_last[1];
+        if (count_last < 0) {
+            count_last = info.reg_off_split;
+            if (count_last < 0) {
+                count_last = info.reg_off_last[0];
+            }
+        }
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+
+        do {
+            reg_last = MIN(count_last - count_off, reg_max - esize);
+            do {
+                tlb_fn(env, &scratch[reg_n], reg_off, addr + count_off, ra);
+                reg_off += estride;
+                count_off += estride;
+            } while (reg_off <= reg_last);
+            reg_off = 0;
+            reg_n++;
+        } while (count_off <= count_last);
+
+        for (unsigned n = 0; n < N; ++n) {
+            memcpy(&zd[n * rstride], &scratch[n], reg_max);
+        }
+        return;
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+
+    for (unsigned n = 0; n < N; ++n) {
+        memset(&zd[n * rstride], 0, reg_max);
+    }
+
+    count_off = info.reg_off_first[0];
+    count_last = info.reg_off_last[0];
+    reg_off = count_off % reg_max;
+    reg_n = count_off / reg_max;
+    host = info.page[0].host;
+
+    set_helper_retaddr(ra);
+
+    do {
+        reg_last = MIN(count_last - reg_n * reg_max, reg_max - esize);
+        do {
+            host_fn(&zd[reg_n * rstride], reg_off, host + count_off);
+            reg_off += estride;
+            count_off += estride;
+        } while (reg_off <= reg_last);
+        reg_off = 0;
+        reg_n++;
+    } while (count_off <= count_last);
+
+    clear_helper_retaddr();
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    count_off = info.reg_off_split;
+    if (unlikely(count_off >= 0)) {
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+        tlb_fn(env, &zd[reg_n * rstride], reg_off, addr + count_off, ra);
+    }
+
+    count_off = info.reg_off_first[1];
+    if (unlikely(count_off >= 0)) {
+        count_last = info.reg_off_last[1];
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+        host = info.page[1].host;
+
+        set_helper_retaddr(ra);
+
+        do {
+            reg_last = MIN(count_last - reg_n * reg_max, reg_max - esize);
+            do {
+                host_fn(&zd[reg_n * rstride], reg_off, host + count_off);
+                reg_off += estride;
+                count_off += estride;
+            } while (reg_off <= reg_last);
+            reg_off = 0;
+            reg_n++;
+        } while (count_off <= count_last);
+
+        clear_helper_retaddr();
+    }
+}
+
+void HELPER(sve2p1_ld1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
+                            uint32_t png, uint32_t desc)
+{
+    sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), MO_8,
+                 sve_ld1bb_host, sve_ld1bb_tlb);
+}
+
+#define DO_LD1_2(NAME, ESZ)                                             \
+void HELPER(sve2p1_##NAME##_le_c)(CPUARMState *env, void *vd,           \
+                                  target_ulong addr, uint32_t png,      \
+                                  uint32_t desc)                        \
+{                                                                       \
+    sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
+                 sve_##NAME##_le_host, sve_##NAME##_le_tlb);            \
+}                                                                       \
+void HELPER(sve2p1_##NAME##_be_c)(CPUARMState *env, void *vd,           \
+                                  target_ulong addr, uint32_t png,      \
+                                  uint32_t desc)                        \
+{                                                                       \
+    sve2p1_ld1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
+                 sve_##NAME##_be_host, sve_##NAME##_be_tlb);            \
+}
+
+DO_LD1_2(ld1hh, MO_16)
+DO_LD1_2(ld1ss, MO_32)
+DO_LD1_2(ld1dd, MO_64)
+
+#undef DO_LD1_2
+
+static inline QEMU_ALWAYS_INLINE
+void sve2p1_st1_c(CPUARMState *env, ARMVectorReg *zd, const vaddr addr,
+                  uint32_t png, uint32_t desc,
+                  const uintptr_t ra, const int esz,
+                  sve_ldst1_host_fn *host_fn,
+                  sve_ldst1_tlb_fn *tlb_fn)
+{
+    const unsigned N = (desc >> SIMD_DATA_SHIFT) & 1 ? 4 : 2;
+    const unsigned rstride = 1 << ((desc >> (SIMD_DATA_SHIFT + 1)) % 4);
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    const intptr_t reg_max = simd_oprsz(desc);
+    const unsigned esize = 1 << esz;
+    intptr_t count_off, count_last;
+    intptr_t reg_off, reg_last, reg_n;
+    SVEContLdSt info;
+    unsigned estride, flags;
+    void *host;
+
+    estride = sve2p1_cont_ldst_elements(&info, addr, png, reg_max, N, esz);
+    if (estride == 0) {
+        /* The entire predicate was false; no store occurs.  */
+        return;
+    }
+
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_STORE, ra);
+
+    /* Handle watchpoints for all active elements. */
+    sve2p1_cont_ldst_watchpoints(&info, env, addr, estride,
+                                 esize, BP_MEM_WRITE, ra);
+
+    /*
+     * Handle mte checks for all active elements.
+     * Since TBI must be set for MTE, !mtedesc => !mte_active.
+     */
+    if (mtedesc) {
+        sve2p1_cont_ldst_mte_check(&info, env, estride, addr,
+                                   esize, mtedesc, ra);
+    }
+
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
+        /*
+         * At least one page includes MMIO.
+         * Any bus operation can fail with cpu_transaction_failed,
+         * which for ARM will raise SyncExternal.  Perform the load
+         * into scratch memory to preserve register state until the end.
+         */
+        count_off = info.reg_off_first[0];
+        count_last = info.reg_off_last[1];
+        if (count_last < 0) {
+            count_last = info.reg_off_split;
+            if (count_last < 0) {
+                count_last = info.reg_off_last[0];
+            }
+        }
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+
+        do {
+            reg_last = MIN(count_last - count_off, reg_max - esize);
+            do {
+                tlb_fn(env, &zd[reg_n * rstride], reg_off, addr + count_off, ra);
+                reg_off += estride;
+                count_off += estride;
+            } while (reg_off <= reg_last);
+            reg_off = 0;
+            reg_n++;
+        } while (count_off <= count_last);
+        return;
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+
+    count_off = info.reg_off_first[0];
+    count_last = info.reg_off_last[0];
+    reg_off = count_off % reg_max;
+    reg_n = count_off / reg_max;
+    host = info.page[0].host;
+
+    set_helper_retaddr(ra);
+
+    do {
+        reg_last = MIN(count_last - reg_n * reg_max, reg_max - esize);
+        do {
+            host_fn(&zd[reg_n * rstride], reg_off, host + count_off);
+            reg_off += estride;
+            count_off += estride;
+        } while (reg_off <= reg_last);
+        reg_off = 0;
+        reg_n++;
+    } while (count_off <= count_last);
+
+    clear_helper_retaddr();
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    count_off = info.reg_off_split;
+    if (unlikely(count_off >= 0)) {
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+        tlb_fn(env, &zd[reg_n * rstride], reg_off, addr + count_off, ra);
+    }
+
+    count_off = info.reg_off_first[1];
+    if (unlikely(count_off >= 0)) {
+        count_last = info.reg_off_last[1];
+        reg_off = count_off % reg_max;
+        reg_n = count_off / reg_max;
+        host = info.page[1].host;
+
+        set_helper_retaddr(ra);
+
+        do {
+            reg_last = MIN(count_last - reg_n * reg_max, reg_max - esize);
+            do {
+                host_fn(&zd[reg_n * rstride], reg_off, host + count_off);
+                reg_off += estride;
+                count_off += estride;
+            } while (reg_off <= reg_last);
+            reg_off = 0;
+            reg_n++;
+        } while (count_off <= count_last);
+
+        clear_helper_retaddr();
+    }
+}
+
+void HELPER(sve2p1_st1bb_c)(CPUARMState *env, void *vd, target_ulong addr,
+                           uint32_t png, uint32_t desc)
+{
+    sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), MO_8,
+                 sve_st1bb_host, sve_st1bb_tlb);
+}
+
+#define DO_ST1_2(NAME, ESZ)                                             \
+void HELPER(sve2p1_##NAME##_le_c)(CPUARMState *env, void *vd,           \
+                                  target_ulong addr, uint32_t png,      \
+                                  uint32_t desc)                        \
+{                                                                       \
+    sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
+                 sve_##NAME##_le_host, sve_##NAME##_le_tlb);            \
+}                                                                       \
+void HELPER(sve2p1_##NAME##_be_c)(CPUARMState *env, void *vd,           \
+                                  target_ulong addr, uint32_t png,      \
+                                  uint32_t desc)                        \
+{                                                                       \
+    sve2p1_st1_c(env, vd, addr, png, desc, GETPC(), ESZ,                \
+                 sve_##NAME##_be_host, sve_##NAME##_be_tlb);            \
+}
+
+DO_ST1_2(st1hh, MO_16)
+DO_ST1_2(st1ss, MO_32)
+DO_ST1_2(st1dd, MO_64)
+
+#undef DO_ST1_2
+
 void HELPER(sve2_eor3)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cf8497a388..469fda6f63 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7858,3 +7858,106 @@ TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_uqcvtn_sh, a->rd, a->rn, 0)
 TRANS_FEAT(SQCVTUN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtun_sh, a->rd, a->rn, 0)
+
+static bool gen_ldst_c(DisasContext *s, TCGv_i64 addr, int zd, int png,
+                       MemOp esz, bool is_write, int n, bool strided)
+{
+    typedef void ldst_c_fn(TCGv_env, TCGv_ptr, TCGv_i64,
+                           TCGv_i32, TCGv_i32);
+    static ldst_c_fn * const f_ldst[2][2][4] = {
+        { { gen_helper_sve2p1_ld1bb_c,
+            gen_helper_sve2p1_ld1hh_le_c,
+            gen_helper_sve2p1_ld1ss_le_c,
+            gen_helper_sve2p1_ld1dd_le_c, },
+          { gen_helper_sve2p1_ld1bb_c,
+            gen_helper_sve2p1_ld1hh_be_c,
+            gen_helper_sve2p1_ld1ss_be_c,
+            gen_helper_sve2p1_ld1dd_be_c, } },
+
+        { { gen_helper_sve2p1_st1bb_c,
+            gen_helper_sve2p1_st1hh_le_c,
+            gen_helper_sve2p1_st1ss_le_c,
+            gen_helper_sve2p1_st1dd_le_c, },
+          { gen_helper_sve2p1_st1bb_c,
+            gen_helper_sve2p1_st1hh_be_c,
+            gen_helper_sve2p1_st1ss_be_c,
+            gen_helper_sve2p1_st1dd_be_c, } }
+    };
+
+    TCGv_i32 t_png, t_desc;
+    TCGv_ptr t_zd;
+    uint32_t desc, lg2_rstride = 0;
+    bool be = s->be_data == MO_BE;
+
+    assert(n == 2 || n == 4);
+    if (strided) {
+        lg2_rstride = 3;
+        if (n == 4) {
+            /* Validate ZD alignment. */
+            if (zd & 4) {
+                return false;
+            }
+            lg2_rstride = 2;
+        }
+        /* Ignore non-temporal bit */
+        zd &= ~8;
+    }
+
+    if (strided || !dc_isar_feature(aa64_sve2p1, s)
+        ? !sme_sm_enabled_check(s)
+        : !sve_access_check(s)) {
+        return true;
+    }
+
+    if (!s->mte_active[0]) {
+        addr = clean_data_tbi(s, addr);
+    }
+
+    desc = n == 2 ? 0 : 1;
+    desc = desc | (lg2_rstride << 1);
+    desc = make_svemte_desc(s, vec_full_reg_size(s), 1, esz, is_write, desc);
+    t_desc = tcg_constant_i32(desc);
+
+    t_png = tcg_temp_new_i32();
+    tcg_gen_ld16u_i32(t_png, tcg_env,
+                      pred_full_reg_offset(s, png) ^
+                      (HOST_BIG_ENDIAN ? 6 : 0));
+
+    t_zd = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(t_zd, tcg_env, vec_full_reg_offset(s, zd));
+
+    f_ldst[is_write][be][esz](tcg_env, t_zd, addr, t_png, t_desc);
+    return true;
+}
+
+static bool gen_ldst_zcrr_c(DisasContext *s, arg_zcrr_ldst *a,
+                            bool is_write, bool strided)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
+    tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
+    return gen_ldst_c(s, addr, a->rd, a->png, a->esz, is_write,
+                      a->nreg, strided);
+}
+
+static bool gen_ldst_zcri_c(DisasContext *s, arg_zcri_ldst *a,
+                            bool is_write, bool strided)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
+                     a->imm * a->nreg * vec_full_reg_size(s));
+    return gen_ldst_c(s, addr, a->rd, a->png, a->esz, is_write,
+                      a->nreg, strided);
+}
+
+TRANS_FEAT(LD1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, false, false)
+TRANS_FEAT(LD1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, false, false)
+TRANS_FEAT(ST1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, true, false)
+TRANS_FEAT(ST1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, true, false)
+
+TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
+TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
+TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
+TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 52a56d3341..bf3d4f4853 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1812,3 +1812,53 @@ SCLAMP          01000100 .. 0 ..... 110000 ..... .....          @rda_rn_rm
 UCLAMP          01000100 .. 0 ..... 110001 ..... .....          @rda_rn_rm
 
 FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
+
+### SVE2p1 multi-vec contiguous load
+
+&zcrr_ldst      rd png rn rm esz nreg
+&zcri_ldst      rd png rn imm esz nreg
+%png            10:3 !function=plus_8
+%zd_ax2         1:4 !function=times_2
+%zd_ax4         2:3 !function=times_4
+
+LD1_zcrr        10100000000 rm:5 0 esz:2 ... rn:5 .... - \
+                &zcrr_ldst %png rd=%zd_ax2 nreg=2
+LD1_zcrr        10100000000 rm:5 1 esz:2 ... rn:5 ... 0- \
+                &zcrr_ldst %png rd=%zd_ax4 nreg=4
+
+ST1_zcrr        10100000001 rm:5 0 esz:2 ... rn:5 .... - \
+                &zcrr_ldst %png rd=%zd_ax2 nreg=2
+ST1_zcrr        10100000001 rm:5 1 esz:2 ... rn:5 ... 0- \
+                &zcrr_ldst %png rd=%zd_ax4 nreg=4
+
+LD1_zcri        101000000100 imm:s4 0 esz:2 ... rn:5 .... - \
+                &zcri_ldst %png rd=%zd_ax2 nreg=2
+LD1_zcri        101000000100 imm:s4 1 esz:2 ... rn:5 ... 0- \
+                &zcri_ldst %png rd=%zd_ax4 nreg=4
+
+ST1_zcri        101000000110 imm:s4 0 esz:2 ... rn:5 .... - \
+                &zcri_ldst %png rd=%zd_ax2 nreg=2
+ST1_zcri        101000000110 imm:s4 1 esz:2 ... rn:5 ... 0- \
+                &zcri_ldst %png rd=%zd_ax4 nreg=4
+
+# Note: N bit and 0 bit (for nreg4) still mashed in rd.
+# This is handled within gen_ldst_c().
+LD1_zcrr_stride 10100001000 rm:5 0 esz:2 ... rn:5 rd:5 \
+                &zcrr_ldst %png nreg=2
+LD1_zcrr_stride 10100001000 rm:5 1 esz:2 ... rn:5 rd:5 \
+                &zcrr_ldst %png nreg=4
+
+ST1_zcrr_stride 10100001001 rm:5 0 esz:2 ... rn:5 rd:5 \
+                &zcrr_ldst %png nreg=2
+ST1_zcrr_stride 10100001001 rm:5 1 esz:2 ... rn:5 rd:5 \
+                &zcrr_ldst %png nreg=4
+
+LD1_zcri_stride 101000010100 imm:s4 0 esz:2 ... rn:5 rd:5 \
+                &zcri_ldst %png nreg=2
+LD1_zcri_stride 101000010100 imm:s4 1 esz:2 ... rn:5 rd:5 \
+                &zcri_ldst %png nreg=4
+
+ST1_zcri_stride 101000010110 imm:s4 0 esz:2 ... rn:5 rd:5 \
+                &zcri_ldst %png nreg=2
+ST1_zcri_stride 101000010110 imm:s4 1 esz:2 ... rn:5 rd:5 \
+                &zcri_ldst %png nreg=4
-- 
2.43.0


