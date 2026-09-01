Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A656C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OO3-0002jb-5x; Tue, 01 Sep 2026 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OO1-0002hT-Fa
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONz-0007Ok-5g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:49 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c255c58156bso852260266b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268726; x=1788873526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e+huNV0XUXsfMeFYnUN9+kY8XeA1aqA5GoBm8P+gf+g=;
 b=mPMoi6Rm7x1Rlp+YfQHYsvHzJoldRIGpGFVYXdGJmVxSzHZClzIaRy3RiaegUsiOgg
 E5VtqP4H4WVgOf4e+tKKbr17C/yfLPNWwM+paI1e/7QmoQCVQxIr2HGBd4Dnx9p7wPJE
 R9QGZ4rZgiTGZKXMFl67W4IxKbIlKfjn8bERA1Ta8TMx0pvFu/zypKeDCjmJ4kQKSXvk
 2gVL2nna6PcHcWZvFmDTwfqZtgWWO4Gd2mSDJpncaSro3DHO/0/Sl4VGW6drcCg3gjdX
 0Ccop1v4NeJ6BqBQB98+h9IiAo6O8Tbzy+GyjCCjHv+boldRpJG32IKTiu6E/+u76R3C
 tBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268726; x=1788873526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e+huNV0XUXsfMeFYnUN9+kY8XeA1aqA5GoBm8P+gf+g=;
 b=A2/epDigdHiWgPQEq6oge2XdEzKfZKhurApa/5KiLkymnR+YCMW+iyW/NOsfEWElc3
 awYnd3tvw4pSgLcy0evtznfjV/ExS99OVY9oeil+5odUBZggQf8InMF+lRRdQRlTJSUO
 6YcUkgRzk5kMOo7fvK7/QtIxnzWQDC1i8C386rrxW68Z4fZedJTaqxJWfqdcFWoQyRV/
 8LNYeAHKb9Y3yI4wnHUKS5/cGBJternppVDK0Fq18U3thpVdiRGAsgvDK9krynHztNTH
 4/dwcTzVP8aeeNlexCZ3hbXG3APpUp8WxM5W+wzRQOikcWOEtkAUuB+WdZ0MGJjgi6yd
 hPaA==
X-Gm-Message-State: AFuF++kHodY//mBY58UKYqHNiVbiM7E0q6wA5yzXEg5FCeoLLEoubanh
 lhbvrVuIHDbQbc2N1FBzBSE2mewdbeiiGqFngCo11uOsagNMtfRloTucZ6ksZro6JX+JWBzlr3M
 31o00ma4=
X-Gm-Gg: AR+sD127Iwf0TcmWNc5pLfhUgmgMOLwNjw9P9jfbnlm2rALExPuUYbYhpP/FdZ2nsCZ
 /r2DDlptvekh94YJmAMEBONo6Pmri9T+XxOErzXEuBjrr/0d1WTT1Sm2dPTRtk4BSrQPYaBIPVC
 nOH6esoUQZdo1zX6ZBSXccDBIlY1egVzHVuVrTkbCqZTsjofv0uNHKdQna/CrqPRWz0l0wodu9e
 GNZI5FUWdUNCK17VkWpw6kq7XtOjL19sirCEJLiVZoPvtaxSFZ5nBG2TcerpRkyvFt8fzDvjjbg
 h30wcukgsdgdhrJEutJu+C7/OCHJzKQ66MH9jfwwqr/vDw2woxzAgnDAMXkhH3K/RGkQf+qZC/6
 MgSe7bz85EtiNYu79grPjg0h38BfyXKGTYCFA7WOtfg69ZHrj+PA/p6M8gxy9qtFX3qeLDfyLha
 AN+wtJMDcMy0Tgz3txFtCxrqB2RCEhWK+LPQOtG9wWyFS+W1wvuGx/S0izCWQXscW6w80XAL2yy
 P0bgN5mtRjKDVm9XEEQcfXV+oosxVVbZE4Mw65lvLgRA+LeVRkkFmPbfCcnUeYfLiodbw==
X-Received: by 2002:a17:906:fe0b:b0:bec:64d4:3872 with SMTP id
 a640c23a62f3a-c2557411026mr2003349066b.24.1788268706226; 
 Tue, 01 Sep 2026 06:18:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/58] target/arm: Implement AESE (indexed)
Date: Tue,  1 Sep 2026 14:17:27 +0100
Message-ID: <20260901131732.2263947-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++++
 target/arm/tcg/crypto_helper.c | 55 ++++++++++++++++++++++++----------
 target/arm/tcg/helper-defs.h   |  2 ++
 target/arm/tcg/sve.decode      | 13 ++++++--
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++
 5 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b23b5a83c68..eecbc3b889e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1544,6 +1544,11 @@ static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
 
+static inline bool isar_feature_aa64_sve_aes2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 3;
+}
+
 static inline bool isar_feature_aa64_sve_bitperm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 11977cb7723..27b5813b6d9 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -47,6 +47,27 @@ static void clear_tail_16(void *vd, uint32_t desc)
 
 static const AESState aes_zero = { };
 
+static void aese_kernel(AESState *ad, const AESState *st, const AESState *rk)
+{
+    AESState t;
+
+    /*
+     * Our uint64_t are in the wrong order for big-endian.
+     * The Arm AddRoundKey comes first, while the API AddRoundKey
+     * comes last: perform the xor here, and provide zero to API.
+     */
+    if (HOST_BIG_ENDIAN) {
+        t.d[0] = st->d[1] ^ rk->d[1];
+        t.d[1] = st->d[0] ^ rk->d[0];
+        aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+        ad->d[0] = t.d[1];
+        ad->d[1] = t.d[0];
+    } else {
+        t.v = st->v ^ rk->v;
+        aesenc_SB_SR_AK(ad, &t, &aes_zero, false);
+    }
+}
+
 void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -55,27 +76,29 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
         AESState *ad = (AESState *)(vd + i);
         AESState *st = (AESState *)(vn + i);
         AESState *rk = (AESState *)(vm + i);
-        AESState t;
 
-        /*
-         * Our uint64_t are in the wrong order for big-endian.
-         * The Arm AddRoundKey comes first, while the API AddRoundKey
-         * comes last: perform the xor here, and provide zero to API.
-         */
-        if (HOST_BIG_ENDIAN) {
-            t.d[0] = st->d[1] ^ rk->d[1];
-            t.d[1] = st->d[0] ^ rk->d[0];
-            aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
-            ad->d[0] = t.d[1];
-            ad->d[1] = t.d[0];
-        } else {
-            t.v = st->v ^ rk->v;
-            aesenc_SB_SR_AK(ad, &t, &aes_zero, false);
-        }
+        aese_kernel(ad, st, rk);
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aese_idx)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            aese_kernel(vd + s, vn + s, &rk);
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 42376af2c68..9b320b5c97e 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -461,6 +461,8 @@ DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ed19ae237f4..64e0dd0eae9 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -60,6 +60,8 @@
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx    0:5
 
+%zd_ax2         1:4 !function=times_2
+%zd_ax4         2:3 !function=times_4
 %rn_ax2         6:4 !function=times_2
 
 %pnd            0:3 !function=plus_8
@@ -70,6 +72,7 @@
 # when creating helpers common to those for the individual
 # instruction patterns.
 
+&rx_n           rdn rm index n
 &rr_esz         rd rn esz
 &rri            rd rn imm
 &rr_dbm         rd rn dbm
@@ -1974,6 +1977,14 @@ AESE            01000101 00 10001 0 11100 0 ..... .....  @rdn_rm_e0
 AESD            01000101 00 10001 0 11100 1 ..... .....  @rdn_rm_e0
 SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 
+@aes2_2         ........ .. . index:2 0........ rm:5 ..... \
+                &rx_n n=2 rdn=%zd_ax2
+@aes2_4         ........ .. . index:2 1........ rm:5 ..... \
+                &rx_n n=4 rdn=%zd_ax4
+
+AESE_idx        01000101 00 1 .. .10111010 ..... ....0   @aes2_2
+AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
@@ -2078,8 +2089,6 @@ FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
 &zcrr_ldst      rd png rn rm esz nreg
 &zcri_ldst      rd png rn imm esz nreg
 %png            10:3 !function=plus_8
-%zd_ax2         1:4 !function=times_2
-%zd_ax4         2:3 !function=times_4
 
 LD1_zcrr        10100000000 rm:5 0 esz:2 ... rn:5 .... - \
                 &zcrr_ldst %png rd=%zd_ax2 nreg=2
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8a5903da4fc..9ce172dd939 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8310,6 +8310,41 @@ TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve_sm4, gen_gvec_ool_arg_zzz,
 TRANS_FEAT_STREAMING_IF(RAX1, aa64_sve_sha3, aa64_sme2p1,
                         gen_gvec_fn_arg_zzz, gen_gvec_rax1, a)
 
+static bool do_aes2_idx(DisasContext *s, arg_rx_n *a, gen_helper_gvec_3 *fn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        int overlap = -1;
+        int index, mofs;
+
+        if (vsz == 16) {
+            index = 0;
+        } else if (vsz == 32) {
+            index = a->index % 2;
+        } else {
+            index = a->index;
+        }
+
+        mofs = vec_full_reg_offset(s, a->rm);
+
+        for (int i = 0, n = a->n; i < n; i++) {
+            int dofs = vec_full_reg_offset(s, a->rdn + i);
+            if (dofs == mofs) {
+                overlap = i;
+            } else {
+                tcg_gen_gvec_3_ool(dofs, dofs, mofs, vsz, vsz, index, fn);
+            }
+        }
+        if (overlap >= 0) {
+            tcg_gen_gvec_3_ool(mofs, mofs, mofs, vsz, vsz, index, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aese_idx)
+
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVTNT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
-- 
2.43.0


