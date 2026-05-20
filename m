Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABC2CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPld0-0005RG-7W; Wed, 20 May 2026 14:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcP-0004LL-JS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcM-0002Aw-HW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so25116535ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301558; x=1779906358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ3I4CizPNDr7l3Qj3+qL13Yx8GTzrnhQalZXWGErYg=;
 b=vmQwoyK3e4W8ddUINE+a6UkOljIeMUu8T9CH7nn7bzDXiuYr67OtWrS2+QzyJmgBN2
 eX2mjxxNuUu5G62Uo2ApEWhTKtxNASppVv1HmgB9HdpvkDj6PnUdHfYQklNuSadGiTgJ
 IHZK2vW3MbEcrgg20bK1oZiAbtOFGLi7kXYMB12Cy7zJ1ZNh3vQs8CQs+hsZB/BVMlK1
 CVRiWHlxXkVLsqS6Da0IrjU9c3IxBZmaq1QgboC9ZpnJ6+kPYdBDFb7+8NQFw/ZhfzUb
 iB0EWPrW2wom0Z4UmrQpslWJJ3Tjzz6RCOUeovy6vllQQvkkU07+5yi+dGigyY6Qi97M
 e02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301558; x=1779906358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZ3I4CizPNDr7l3Qj3+qL13Yx8GTzrnhQalZXWGErYg=;
 b=T+aptMHIFxwKtLrRhQDbGf5oDErOWPsMraf5+GDtllTxZ1vl0YtMQAGH7IYfH8wfqT
 or+Pmk9QPdCY9Ub5adak3kNMkiLJD6WOS76s7OcLc58B2eJmYategEc4m9uV3VM9tyJ1
 FwAOEZhcZ37Isb5NTK86QXLQUbk2Pu0bwqeX5sYgFq36pQC1NHfdVkFd0FgPtNE+CBt+
 K4/9rIeze2HQ6b1t+/NsP2/jvYZZ5wOnWhKmK1dG24fmtkx5yRzrPDcnlT/AXmLwHGhg
 3utrMPkAXoNry3RoCjOKpmvyUqVYtB0Lf+QwO6/ncIwqBUbddf7L6Q//Fp9wYrwnmTd+
 KpcQ==
X-Gm-Message-State: AOJu0YwK0re7U1g9BMGwrpfUOugIqhzI5rAdBBheysXPVl6MBHLCIIGN
 FGD9GtP5i9UTiL/BXavirYzhF154tKH7kWXLLZt6a4BRstmSLCh1SQPYH8Pu9c2OrV7Nq5mdBY+
 77KRiYQ8=
X-Gm-Gg: Acq92OHPjgdH89q1ZBip4FmavYJya5iPypZFH2fpvhEEV1EONrldzekHtCgNYEvIcqi
 2ZwB4A2bo8VxZYbAzHO8M01xgVxK9aKIVcNFXtSjT/JWRBoxlvnaPgUWXeWcQa2HY/T1jM8Ul1M
 Sl3D3BhDOyy9r6+UjXTEKGiJIK6Lw5VNX76N6rJ4ztD07R4utSjht7JRgtWVhfnlgdAOJsbtuv3
 0nx/8ENLF2uZyI7+OaUI8ZONYKv6r6hMSc17tYdqbZw4se1+aG6bDFu33X3S00EknTd8iqVIbnd
 MNKrV1viD6o3FXmAxcbWWDPSphgogZfiK+1TVEn8lOn6a/wKGiAgCIQDRgGjLwL40JpBLLbhCVr
 cDT0Nh1II0UIoxt2G7lpkQ4dlYA6A4CTlBNKksm9HAFlc7yrqgYRjR/HEyiHi/mGzNxY9ibTwxz
 VpQQ2K6xUs/Au8b0I/5q4om2Z+RKMf0ZtvbKMGp1I=
X-Received: by 2002:a17:902:da8c:b0:2b2:5597:bad4 with SMTP id
 d9443c01a7336-2bd7e9adf9emr278246955ad.30.1779301557523; 
 Wed, 20 May 2026 11:25:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 58/64] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Wed, 20 May 2026 11:22:07 -0700
Message-ID: <20260520182213.872945-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 67b9d7e982..8f6cc2974f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1693,6 +1693,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8d622f9a1c..5bda5f6c01 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8442,3 +8442,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 26b3c7697a..6610432528 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1808,6 +1808,8 @@ BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
 FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
+FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load (scalar plus 64-bit unscaled offsets)
-- 
2.43.0


