Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8D9C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWi-0001uW-9B; Tue, 21 Jul 2026 14:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUv-00016G-ST
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUt-0006gC-Qa
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so7432955a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659638; x=1785264438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p25kpMnws/6Vm1k9eNq0cyT7i3Yzgo7M68XQGm/13eI=;
 b=wEHrsylKGOiUi1H4QK3dbGM8lEuulL5wEl1bMs7n2OjtTI5I92dL/PChMdkOb3zYVb
 IBId37dminE5osMUKpZT+inSRsZNLNzIWoSLpfJ9rywuIM/N3zQMVJ1uVKMba3ltzD+l
 cQPKGeFXKpLwKGsjh+ZboKaZ6fyr0GhDSVURML+maQ2XP19Uslxczhl/i2FWD277FaEP
 Xtx59QMbpfY58qtnnW+CA2Rz/3CbNVkLXP43Fa95+80GW+3G6N6fzDBXb0vAHodcOwnF
 bUNDhh2ml5m6E5+LawrQjYpRNIpjjDZJ3NE2C7yW5WGhg1Kcopa/Vd/GeVk1aDNqVNSZ
 HFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659638; x=1785264438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p25kpMnws/6Vm1k9eNq0cyT7i3Yzgo7M68XQGm/13eI=;
 b=enp24GUwrNty1mY3yRU1Oe2c5hArJppxm2Wr8TR0WPjo4pcljzHW6IN7TJDs9oBsT7
 AVstc9HHZTE1pS2Tb9lQ7NsvoDBben45F4yVyTcHJMY1VwGIqntSiN8Uuzvrv2joltdN
 R7tWMdpFbC3mZoIoHt9lrK7+1YQVLJxcLjQZMFGDpLsYFGfcWmRf7XprvzCDDY0//iO4
 T8UUptqII2hv5xouO+xDa7r7j0QOYoPRSpqmJ53ZAh6HzsfMAOAACbMbJrTh1PrPWzve
 tZv596TxQoNgbSD5AJilEap1h/IL0QvrabvSbfpOOqKSELJ4f/oMqAMBrZUwsFIWmZ0h
 /Byw==
X-Gm-Message-State: AOJu0YzJDpGOh78gSy4KJKZHRFytahz5b/lB4n5Dw2a5bpDz+xsrhks+
 Z0036se1KPXJe7QwwIqxggD6rcNGDOXMxPSvUGxNrCtDJFgFQojTDX9xyQyXUhBXTn8SfKyMMwL
 8OLXP
X-Gm-Gg: AR+sD12OdPeC0dS9gIBR617laFezP/YnW7AjI0ioWgoQeZS8gQ5LnsZo1DVIqUumnM4
 Gni2XNiTuy9g0ceGXbmtZ6HLowJYem5Q3KMk5lFINdLUf3MDEMnSsdSLm/qYNIaMsRZckPhgRQ1
 WoEzP3j6mGOAsv6fZmsQpdJR8FBWXXan1K38cuBqi9shX7qFCmMZPuJ0c5MZlgwvC8t80wi4Rnm
 zpDjn+NENmqbRuZ4EhM1Nep9HGNl5ZHWiyKf5gjPZFBkP8jcSw/Mp2OIyUZttHomGAX2ZAvE5dq
 kbGA3ghhvUfxkGvMQbvNt4SLI5Nvj7IavXWSu81PsWCP9DwhRLYDnB+M1aTL8qPK0SInK2ZUr7R
 0GgcL6r42Q9XfI59+8NkSYLzFLWupXWKM1zVJBsm92AQrkdcO/pUbERMzVC7OM8SqHOD4nhj4eV
 6Did5KY/Ux/0u5QtKRbA==
X-Received: by 2002:a17:90b:3904:b0:387:e0db:bc34 with SMTP id
 98e67ed59e1d1-38e4b5793d2mr19510249a91.42.1784659638317; 
 Tue, 21 Jul 2026 11:47:18 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/20] target/arm: Implement AESE (indexed)
Date: Tue, 21 Jul 2026 11:46:51 -0700
Message-ID: <20260721184656.530230-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++++
 target/arm/tcg/helper-defs.h   |  2 ++
 target/arm/tcg/crypto_helper.c | 55 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++
 target/arm/tcg/sve.decode      | 13 ++++++--
 5 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d3130fbe67..cfbe39394f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1539,6 +1539,11 @@ static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 0077aeb4e2..9d71277b47 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -462,6 +462,8 @@ DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 11977cb772..27b5813b6d 100644
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 08372d9d8b..5b6b66aaef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8300,6 +8300,41 @@ TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve_sm4, gen_gvec_ool_arg_zzz,
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ed19ae237f..64e0dd0eae 100644
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
-- 
2.43.0


