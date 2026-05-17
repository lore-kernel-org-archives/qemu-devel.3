Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A07CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSr-0000hL-Rx; Sat, 16 May 2026 20:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSF-0007An-9A
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:10 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSA-0006ra-2A
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c80227c9572so381760a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978037; x=1779582837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzT2KDZzhG3LXMrDA2qkHOOkx7LXkk0rS86HuhIOidw=;
 b=ED49BpSI30daHyraYsYtkj/gBvmqHNkG9vHYjIgfxzCt9Lom/3lsNtPDARVBPF3l/1
 rY1NefoM6PYNQaH/mo0/gJ/686rDdp53KcpZDmi6hZBpmfSm0IYO5FhnzT4/cJk7+twu
 8RFl9oP/JbmquitxoS/YEv3CZehf4mdZGt4LmBDHPVFtFBW1ubIgw4pG18bG7wEfAOqQ
 A/kKvxpCe9nlINT/yN1c0ZcQuRcgxtNBBHko2By3/U4DjbEyvGdK1n6POA0PRaGL8BEu
 OjNRDcrVUeJan7mJhORJMrBRlgNaHx3rX8ABthgM7BbLHDvq3KUXxm0c0DMQRTAKjPJW
 Ujwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978037; x=1779582837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bzT2KDZzhG3LXMrDA2qkHOOkx7LXkk0rS86HuhIOidw=;
 b=MYDmaAKNdLP6tienS74J5+7wiGgKedYQwwvq74sW6fruH/kLXjhuIrjzdGVQefTet2
 0jlK3uXiQpxirO3RLQCOdmZxm+1rNCP97bTxabdVvOf0lysEZc4OZGK7GfFTCozqPtIq
 SXS5oOUCPT1TP56Af/Au6O8Wwjbb/8SwkQAWLxUKru2NgtAVvdvERtIlXRWE68lG8dqC
 7iAAHVXe7pbxQaI3WjIv6bdwtBSSMPHNNVdGWx5oK9/UmBAFjLZZsOXlDjQvg+/dweJd
 8WH+0lsJbQE79sFxf08GfGowmPWYvn5JTMXIb31BKcwO97D+lGSEh/+0SMHrpHKcbp27
 twyQ==
X-Gm-Message-State: AOJu0YyxtcitdVbD3hGUGNhJc6fzmg9tlJDATPnzHfToqYiFSKejJhag
 CsDYovbbyJMXpjaE1AtdAcatbgCJ02ZopDtp/65LI94R0qvmmyctBu3Lt2tB8orQT0xJjsEDmba
 dg7TQ
X-Gm-Gg: Acq92OGm+WIYaqsYnSbyS9zJr0gIYcecBCzcQ0KuTpn8dz7Vy8HtEhdSWLeoThWzLS/
 yQ+vkr54SRFdkTy47TeZ3DIAfFDw42P8gkR9BkNJqKVOIpDmSzqBCpss4igSwiRxw/Oe+4A+oAj
 zGSnNb3rC3FZGmE4WDN6fpI5MTwgoOzB6gO2j4jvoqBv38muycztGTft1tMCtIGcLdidKUmYRyG
 ZqMvPlF+1bsxFWPHs6hyblX4LiMvC9PXUsTrI2fWQImg7cPH5P8yXHVgoD5ookaJHmKb4MapxlM
 fbeAfyiim9EI42hFIg+/M3w+SZh2PnUbtjCfXLBc+KQoBpYGrLkdJDo+f9CuC5mz9k7CeQo6JOI
 3v6JTZUzt6ujTxeJvgy1fc4ubpmCw/b1YzXIZMC9thRfzsrtLFij6+Lb5ZneNnDKL2HicMtelrY
 29YrZOWoVzU3S7TFKSuBnYYrEeerKN
X-Received: by 2002:a05:6a21:600d:b0:3b2:6988:a6f5 with SMTP id
 adf61e73a8af0-3b26988d373mr2480041637.4.1778978036623; 
 Sat, 16 May 2026 17:33:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 56/63] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Sat, 16 May 2026 17:29:55 -0700
Message-ID: <20260517003002.321430-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 36 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 90098c3cbe..67b9d7e982 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1620,6 +1620,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5995d77577..3c74f02022 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 913c91fa06..bb1d48c3e0 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -823,3 +823,29 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
     fp8_mul_finish(env, &ctx);
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
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c5ea6b27a9..02d5e007f9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7418,6 +7418,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
+TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d1254355b6..6404c26540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1216,6 +1216,8 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
+FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


