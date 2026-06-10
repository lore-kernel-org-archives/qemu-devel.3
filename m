Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA5CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYj-0003jq-68; Wed, 10 Jun 2026 12:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYf-0003Jp-5c
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYd-0006UJ-7E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so30280295e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108014; x=1781712814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ErkFwBq79DqN7zlpJQ41gBrrnkpgikacB47fgBRmT3Y=;
 b=zyyhubu8z7TXH0cpL/F7BoTjB+mefBw4Axxke8BdwECqeVwdNq3D8sGUjbsF1iHiiH
 bWshQcjUsB8KldJVckGSFsaSqiM4tBIwIYzPx8saXJBMdvBTe+SArGJ7kreNyBgU721f
 cHM8v55DqAxgKp2/yPs3Er+c/m/xWnYuVMpPiYwv04zy71vUauVUl5J2zSmP62NzUQpf
 +7ZAJ/9+pEQJwqBpj0yMQJXMeNcd4px6y58eiaH0chcJtX/rRKN7IlQ9fTo+Mik97AbQ
 D2ZRxneRoetS69PxhWm3TgDWfGYpRHzVmbxtohUNGYrq0uSPP3rczQjNkx3hxmy+u1co
 aQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108014; x=1781712814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ErkFwBq79DqN7zlpJQ41gBrrnkpgikacB47fgBRmT3Y=;
 b=POYSorIRIMB8OYue7g09WAw+wY0bxN6mriDQ7K5l8OiPlUREVJvakde2FcSBLp6sNW
 AItEi2eKuaFTY95QafiH3KCE/QoZ0PFSJrO0nbtf76XnFMJh+wsVmsYFzMnzXstaVGc/
 IOzdK6eCpPMX1iSF4XIYRKsnDn8SWRf30SAy4oib+cPaGZzoPls3u+1m8yc7UCsv4y70
 aQsydSFvzg9ZE8nkFd8EQ95cVqIep9h1haCLPDn5JdH1HXwvw3jTuOesqQCT6QlAmH7d
 0+5gTht6NSsMxue/WJ61LdUt6sF7EapTU94z2NVepHZetfvrZxKboNIeufGzSrN0WxTD
 QBEg==
X-Gm-Message-State: AOJu0YzYp76ZCgBBpYh9uIBbka+tIofGXqa+qMmuIObDZmnDYH8axDNj
 A3D12klzDr50Q7Ya4VWpmTkP5TgUBCUYZhLZRICjY4uKtntA9AVknp5n2VQZHo9WiLxO2tGGo+F
 s10Ui
X-Gm-Gg: Acq92OGRNS1+H8hZrGSLiPgaCA/pcon68SDuA9dH5ceA+vIlPyZeAMsVugW0g6eyd7n
 IVug/i5l+AQ5sYF1mXrCdZaX4Zni7g+qlpHXHOlwmgRt8Al9TrWJSVNMCyXrhBQMSgJ+lLA/C3f
 tyejxWroicKuvBF22mn57O7isgYnqRbpgj+4NbKNA6lvUdef17pfCRFZk4AU5/hT+fc69tw24ff
 Z6u9dcNRv6ahXjKbuUKb3mJ3Ydj8Roc/SlndR1DAQV0U5zRiI1pcV8JqI4ux28R3mAMrLyDDIfQ
 qpO+KwgTSIQuXUAVKt90cNz45CTsY3B3wFNkyrlTkl5gYPEzXogH6CCCjaA4rVOXd6Q/4YyYDvJ
 0KOcNj7MfpCkZGUvD/fEIioiC7MAva5SHPmMuxH4B+toJMAKMRBfZFo/QYmsZvxCNtcSdvPewU7
 u3C/UvxT+WFAAMX+XjkQ88bNQ/w1uUf7Fm/8BBhWIKXvHBpHpmSjHPYe21JZkNMRPN+5+kL1NWU
 fRAwEzB+0d6NBHcToHbPRnkqHu7x6GjWdNgAoeAJ/r4zxyMYwa8mQ==
X-Received: by 2002:a05:600c:8b85:b0:490:9d5b:d721 with SMTP id
 5b1f17b1804b1-490c25f166fmr418797495e9.16.1781108013826; 
 Wed, 10 Jun 2026 09:13:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/71] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:57 +0100
Message-ID: <20260610161202.2235298-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Message-id: 20260609192110.752384-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/a64.decode        |  2 ++
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/translate-a64.c   |  1 +
 5 files changed, 35 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1745989bce..be3db5300f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1645,6 +1645,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
 }
 
+static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a3e404e7fe..6922e91010 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1227,6 +1227,8 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
+FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 065df24b84..b9d4ba3b6a 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -807,3 +807,28 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint64_t *n = vn;
+    uint64_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float32 d0 = f8dotadd_s(n[0], m[0], 8, d[H4(0)], &ctx);
+        float32 d1 = f8dotadd_s(n[0], m[1], 8, d[H4(1)], &ctx);
+        float32 d2 = f8dotadd_s(n[1], m[0], 8, d[H4(2)], &ctx);
+        float32 d3 = f8dotadd_s(n[1], m[1], 8, d[H4(3)], &ctx);
+
+        d[H4(0)] = d0;
+        d[H4(1)] = d1;
+        d[H4(2)] = d2;
+        d[H4(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5995d77577..3c74f02022 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e4c539fb18..ffe59b9471 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7515,6 +7515,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
+TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
-- 
2.43.0


