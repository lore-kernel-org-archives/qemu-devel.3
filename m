Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2225C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONp-0001ZJ-H0; Tue, 01 Sep 2026 09:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONi-0001Sw-UZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:31 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONg-0007MT-Ub
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:30 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c25420fe973so145499966b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268707; x=1788873507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mJPX7g4lwA4PbIILtRfdM6oz+DiiUaRatUWoaotsO/0=;
 b=AFxgQkgYC7D02eRTpAd6t5YmC4tKA+z8UGbiBMirum4eIm9P7Hi5MNn7rNCF8X8Lhi
 TRoloMEq3cl3CTO/Z9SN3RsizuKLlM4trl6vNp6njUwiAtX6JDGEkL/GjSIIIPdr+5Ca
 H0H8ZwIachYU+z4o0AF5/WGQhStEqGFQuyvw9PvjlKtW9CtePRrx6SJwM3euKDvY5YeN
 UyvuR6tzK4LT9JvHN+PVgmvGrCUjU/HOPE95wiAkpQ/EpFV1dZr0xpb25E9cVy/9mzui
 tw28O2aaAa3LPLvB8k4IhRtP9zG61fc6198XcQddok4cfr52bAoSF5WIWwp26TvFiaOZ
 7F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268707; x=1788873507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mJPX7g4lwA4PbIILtRfdM6oz+DiiUaRatUWoaotsO/0=;
 b=XjAIr8aVSCZce9cWVYbTZLg66qQBtgqFghFJEnHAVXoy8+RxjBk4MQVJATGfZWkBr5
 90xuCMmZBxHB+h26sc9g/ebXn9J3ohWUypISYqIiW6q+BTwQuNR6KlVUr+wqPP/qT3nA
 wGwftoimxg7tul6xmZi/FZhTzGh+2JLurPF1ulu42U5My6BPsL7kmQD+H6wVk3WYKv2m
 1oVcRG0Pnw5R9/vxkPTkU3Li3d3b/gl1DPLgDt0nrLuGs/7iU0fYpV999KMy95bCtuQv
 Ir6IF281U9qjmupY2Bw4WuwgG+bW55KBYecpHdb2fngBotIMSU9Igyqvm0W93ud9soiC
 dRqA==
X-Gm-Message-State: AFuF++mQEJKL876lHVj73YX9vPOWomWtsokQkB09NCdOiVfuXXu4kF+/
 w7es/0GgwV4gRKC24QkwEBVJqoVdXMms4qTpndg/Y5evFAAdTSerF6b9d2oXYDHd4y74n7DmlCu
 0JYkWJtA=
X-Gm-Gg: AR+sD12nBFL90hKbI/K+ZWAAfV5/r7H4+6nJytwHITAIOq1qMpcFmq+oQPBaEw6KJzV
 EjQ+eC4na+Xqonw+o92XMKg/B48YTZS095V+KZ2KohLwtrSiq7nLqJM5PxcIrddBzv2GsnTpZNx
 Jb00SFxRWn/Xj032Rrj/nuUaLS1eZPfefaJC45RmgmY4AaXoJPEf+FNcER2ahNyv2jqMGTOPyrw
 4jLC3yHxSE3UUyPD3RZcg88T0aCGcQgZzLLzKe1sAowHbZiNpgvTKQFmEeTjUqy7Tjqn1m05ikf
 uYQVkIWsnSixqXr5EXK+CdGXkCJNBIvfCVeTZfuabe1mvcJHdzHQxBMjSgxWHi6JGhfT6dgVFLp
 ziJk5s2XnEVRTV2lu8USwqODe+tQ0mw2NCK8wz7P6SPNazZNjVMHRg3V+WKT06j9R5I8wQ8Gn1E
 W9u8ONHwY/HB8g5jqI9zt0Cqz9hdzzWLRiQuf8n0UpKBn9FvCgnh24ausnEIbSZoP/6FsBPX7yO
 dPiTsEOXI3C21FDB+l35WddOsA/A82hITBdQJC8z6e6UL6TxfWgLbfAtCabAuWDmEMFAII8Stzq
 CMlW
X-Received: by 2002:a17:907:849:b0:c21:180c:d82d with SMTP id
 a640c23a62f3a-c255748756amr2064749266b.20.1788268707231; 
 Tue, 01 Sep 2026 06:18:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/58] target/arm: Implement AESD (indexed)
Date: Tue,  1 Sep 2026 14:17:28 +0100
Message-ID: <20260901131732.2263947-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Message-id: 20260826174213.614571-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 47 +++++++++++++++++++++++++---------
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/sve.decode      |  3 +++
 target/arm/tcg/translate-sve.c |  2 ++
 4 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 27b5813b6d9..05f193b3d17 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -99,6 +99,23 @@ void HELPER(crypto_aese_idx)(void *vd, void *vn, void *vm, uint32_t desc)
     } while (s > 0);
 }
 
+static void aesd_kernel(AESState *ad, const AESState *st, const AESState *rk)
+{
+    AESState t;
+
+    /* Our uint64_t are in the wrong order for big-endian. */
+    if (HOST_BIG_ENDIAN) {
+        t.d[0] = st->d[1] ^ rk->d[1];
+        t.d[1] = st->d[0] ^ rk->d[0];
+        aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
+        ad->d[0] = t.d[1];
+        ad->d[1] = t.d[0];
+    } else {
+        t.v = st->v ^ rk->v;
+        aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
+    }
+}
+
 void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -107,23 +124,29 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
         AESState *ad = (AESState *)(vd + i);
         AESState *st = (AESState *)(vn + i);
         AESState *rk = (AESState *)(vm + i);
-        AESState t;
 
-        /* Our uint64_t are in the wrong order for big-endian. */
-        if (HOST_BIG_ENDIAN) {
-            t.d[0] = st->d[1] ^ rk->d[1];
-            t.d[1] = st->d[0] ^ rk->d[0];
-            aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
-            ad->d[0] = t.d[1];
-            ad->d[1] = t.d[0];
-        } else {
-            t.v = st->v ^ rk->v;
-            aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
-        }
+        aesd_kernel(ad, st, rk);
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aesd_idx)(void *vd, void *vn, void *vm, uint32_t desc)
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
+            aesd_kernel(vd + s, vn + s, &rk);
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 9b320b5c97e..1a0e4130aa2 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -462,6 +462,7 @@ DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 64e0dd0eae9..1ab1b4042b5 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1985,6 +1985,9 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 AESE_idx        01000101 00 1 .. .10111010 ..... ....0   @aes2_2
 AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
 
+AESD_idx        01000101 00 1 .. .10111011 ..... ....0   @aes2_2
+AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9ce172dd939..cb1542f3931 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8344,6 +8344,8 @@ static bool do_aes2_idx(DisasContext *s, arg_rx_n *a, gen_helper_gvec_3 *fn)
 
 TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aese_idx)
+TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesd_idx)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


