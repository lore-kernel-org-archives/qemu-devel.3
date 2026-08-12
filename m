Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C2C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7sn-0003zR-4u; Wed, 12 Aug 2026 08:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sl-0003xC-DK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sj-0008Sz-JV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so6513885e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536988; x=1787141788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sgfkyaVUO6Rfswiynf5JvltQAap/fbV3GAIfhtK8Iew=;
 b=N2a0YUi7GeMWEwhd8R4289/5YCTlVHmT5ofQJ+zBLmSbG3DlO+0+5foGUIxJLkXJxx
 Bx0X3keBCqOe/pC5BnrwYhvcOAbVOzJ90y7OGY+bbr4GThXHtwht9fHJ7XDpoDnzfAgR
 Mwl3mwKFdRGk3olx2DlVKdi6J2QMu08ksH93qx8PssCbPgqyYYB66/8R120cZBrzwrY/
 CEBwyT+VbwYFMQQdyBKvCCnc7/F/iQ1X7QovcpeDkoNqLf4RdKGam8bvlP9hBZSEbypN
 rxvXAdomzEL6eaSte3IdUNXIXFxgxNMRU8yPCTAFDlSWaNVp6g1FxJDspJBAcwcEsF9H
 GYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536988; x=1787141788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sgfkyaVUO6Rfswiynf5JvltQAap/fbV3GAIfhtK8Iew=;
 b=PdRrTvqW2rclzsodJgLJ0ofmMEX0D+k4LoGiCULm7rYd+Yb/rSO1MntpVRhQmcWmyh
 ukGyBvyNlzRBPVEqI+R/3qWwzTu9lWKr/Gf6vS2bAjGGVNjGU4idRmHaQsingfgkWf/L
 upc87UQbgtHk87EQcqvqPJQ0A/gRK44h679yvscCbbC/Z3hbFDSBSXTakSspGneXoqnk
 uZqYgAPq2yDb+pEuo+sndBRPVIvdhzr4vtRPnfMavlhm2muiAT7KHtct4ARGBd9A1s4g
 rZ91UJB8cfKCptAq5CToMw6GU+hbA0CUr+pZ9wauqEBT/iga2xUW35jNC5pGgSvaz7LQ
 HrSQ==
X-Gm-Message-State: AOJu0Ywm1Dbv69Xmc92JrhVeI/exbcz0te6QLVEUfawoLzr0gMpnA9OB
 AsG4Gzujk40Y50W1ZpNURzIDtkfJVSl43GVCtoRM6o7Ahlq2zCjMCLzYbWyhTfp/CSndqoJEdwO
 6c87c
X-Gm-Gg: AR+sD11MuUQ+3tz9Q11ZlJMm9QCMBfIvm1A8gIEreUc4Y6A1rBvLyrBVQ3uRDC5GfW/
 fJV4HrAkQnIsM4R4MK7PDIFls13JnODmRFWJW/QIQceYTk99LN4akGTF18O4w1ArBNsJFJYaVIR
 6elb4JXFseTsFg/OOMGOJPzn2d+wZrXDIyiyh0D89Jr5fQy+CyVFWnNgF9FRxOei54+koBgRNwR
 FDtgE2YH6thUtGC5C+n9JL6sWSzaNARFboZq+R5+tojDeGECVWvDY4q70M9uqPhF/1edNQKMVOn
 R7+uIxsshhpuebj5D/uznK2e4VtsrF4hUTWn6PtavdFBZ+VQwucQWih2eXPkbhgwnrjHps2hv6t
 uQdLmwZvLr/BPK83b/3M6QS+doufDBc9R2LBqNtD3WnjRRBna7+/aU5hcpmR6/NiB7p+FWoxnNV
 lJuM6JoSzTVRU57lWDUDGoX5U645A5Xy0rsKU68Z06vuU/NeK32YSfT+7ODkiq6tE0zusK/jBXR
 DAWsmQ/C1k1sF5SHF09NsywIQW3N8kEk15bt8T1cD6PO41CJGicFgqdraMmuar+bxjdlP+//piL
 4Ck9
X-Received: by 2002:a05:600c:8209:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4997c126dbemr68617865e9.12.1786536987906; 
 Wed, 12 Aug 2026 05:16:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] target/arm: Implement FTMOPA (non-widening, FP32)
Date: Wed, 12 Aug 2026 13:15:57 +0100
Message-ID: <20260812121622.649730-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  2 ++
 target/arm/tcg/sme.decode        | 10 +++++++
 target/arm/tcg/sme_helper.c      | 49 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 26 +++++++++++++++++
 5 files changed, 92 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fb5ed25ad0..6370c03e2a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1590,6 +1590,11 @@ static inline bool isar_feature_aa64_sme_mop4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMOP4);
 }
 
+static inline bool isar_feature_aa64_sme_tmop(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, STMOP);
+}
+
 static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 7fc7129e54..8107eb40af 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -404,3 +404,5 @@ DEF_HELPER_FLAGS_4(sme_usmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 53e7e67feb..0250177d0d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1131,3 +1131,13 @@ UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 USMOP4_sb       1000 0001 000. ...0 1000 00.. ..0. 00..         @mop4_o2
 USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+# SME TMOP Sparse outer products
+
+&tmop           zad zn zm zk idx
+%tmop_zk        10:3 !function=expand_tmop_zk
+
+@tmop_o2        .... .... ... zm:5 ... ... .... idx:2 .. zad:2 \
+                &tmop zn=%zn_ax2 zk=%tmop_zk
+
+FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 23bb816b6a..571b0add34 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2636,6 +2636,49 @@ void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
     }
 }
 
+/*
+ * Sparse outer product, non-widening.  ESZ in {16, 32}.
+ */
+static void sme_tmop(void *vza, void *vzn, void *vzm, uint64_t *zk,
+                     void *fn_opaque, uint32_t desc, MemOp esz,
+                     void (*fn)(void *, void *, void *, void *))
+{
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t index = simd_data(desc);
+    intptr_t esize = 1 << esz;
+    intptr_t host_adj = HOST_BIG_ENDIAN ? 8 - esize : 0;
+    /* Base in bits for op3[index*:csize], csize = (VL * 2) / esize. */
+    intptr_t ctrl_base = index * oprsz * 2;
+    /* Create a zero for use with the largest esz. */
+    uint32_t zero = 0;
+
+    for (intptr_t row = 0; row < oprsz; row += esize) {
+        void *vza_row = vza + tile_vslice_offset(row);
+
+        for (intptr_t col = 0; col < oprsz; col += esize) {
+            void *e2 = vzm + (col ^ host_adj);
+            void *e3 = vza_row + (col ^ host_adj);
+
+            /*
+             * Two control bits select one element:
+             *   Zn[row], if [0] is set,
+             *   Zn+1[row], if [1] is set,
+             *   0, otherwise.
+             * Compute the address of that element.
+             */
+            void *e1 = &zero;
+            uint64_t this_ctrl = extractn(zk, (ctrl_base + 2 * col) >> esz, 2);
+            if (this_ctrl) {
+                e1 = vzn + (row ^ host_adj);
+                if (!(this_ctrl & 1)) {
+                    e1 += sizeof(ARMVectorReg);
+                }
+            }
+            fn(e3, e1, e2, fn_opaque);
+        }
+    }
+}
+
 static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float16 *d = vd, *n = vn, *m = vm;
@@ -2692,6 +2735,12 @@ void HELPER(sme_fmop4a_ss)(void *vza, void *vzn, void *vzm,
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_fmop4a_ss);
 }
 
+void HELPER(sme_ftmopa_ss)(void *vza, void *vzn, void *vzm, void *vzk,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_tmop(vza, vzn, vzm, vzk, fpst, desc, MO_32, inner_fmop4a_ss);
+}
+
 static void inner_fmop4s_ss(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0794794e3d..3cfd52dca4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -31,6 +31,12 @@
  * Include the generated decoder.
  */
 
+static int expand_tmop_zk(DisasContext *s, int x)
+{
+    /* Pseudocode for 1:K:1:zk. */
+    return 0b10100 | ((x & 4) << 1) | (x & 3);
+}
+
 #include "decode-sme.c.inc"
 
 static bool sme2_zt0_enabled_check(DisasContext *s)
@@ -2132,3 +2138,23 @@ TRANS_FEAT(USMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_usmop4s_sb : gen_helper_sme_usmop4a_sb)
 TRANS_FEAT(USMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_usmop4s_dh : gen_helper_sme_usmop4a_dh)
+
+static bool do_tmop_fp(DisasContext *s, arg_tmop *a, MemOp esz,
+                       int e_fpst, gen_helper_gvec_4_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, a->idx);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr zk = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr fpst = (e_fpst >= 0 ? fpstatus_ptr(e_fpst) : tcg_env);
+
+        fn(za, zn, zm, zk, fpst, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
+           a, MO_32, FPST_ZA, gen_helper_sme_ftmopa_ss)
-- 
2.43.0


