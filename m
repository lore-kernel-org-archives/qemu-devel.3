Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA52CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28F-0003ve-9w; Tue, 09 Jun 2026 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24r-0005bs-AO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX24k-0005Wi-9Y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:25:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso41522345ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781033083; x=1781637883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGO1KH2dWLuKc0TZeKusI9hi1gX1fWKEPTW0xxCeIvs=;
 b=RbTrJc96OHtmu94OqVJKL5e8THERAANcN3Ma7AmPu1/haiWQq2GLwuQt7WW9qr120G
 cmYSRTqw6wiVbNsiEYhSGs9VPoEd+N6I+1kgjOTJxgW/kA+AVN5+oHnGqbVnsjiaV1iI
 fW9nnRe62MhgbmtZoH8Cxum/H3sdoiKYy6LFL8sTZOg2mlo05v94TxSBoC1/938fBGXQ
 WwPG+HMPpyxaXhjZFXTeiqDobHJWjkdkhPQ/ZSkgn5tMCdsaIOqfwqGc7TP0VJ6Q7G/9
 y5P4hSoEmvnhoMZvfMvLREeR/WqrRfx2ywt+4IN60s9dTmokj9WzrW3AqiQFOWexgQiW
 LfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033083; x=1781637883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wGO1KH2dWLuKc0TZeKusI9hi1gX1fWKEPTW0xxCeIvs=;
 b=fBt8zx+OthpxvwGy1HyBMcQcrLtRZ+Ji5AQf/ZWdamNSvU0R8RgOGxErJy4H5qjTlX
 DwOcOWtY+TsbKh+sw7EPYlNkjyftY+9h+i+2GDTIQ7BYhx0fdz19H4k3vSdwbXgiJ+9i
 u8rTTjo9cvNteBt7qKZIu2KT08L0xJ8ePT2/ryq8NS1ECMFSAFgAqtqFP/6yKQhVz9C/
 Nac9vm3wJT8KU33ZnaMcRYwSAYl1yvlQdLwEDl/HwcuvcOtOAVN8yNCggEO0ikrSbrT6
 2LmAAKyiTQetFPkkSBcgOXY94ARvLMGCihx5Kl9KxskRl6SAVEUzXPsXNCwWXA8qDe9p
 BVaw==
X-Gm-Message-State: AOJu0YyeF2uFfROUo8s0j27IJLArrZQCBWxu4Apj9S6Knm21y/rqd/kH
 OZx/nW8pYHYH05rla/GNKHl+OHlBx5myEzqDpXNIU13Uf9a8tUY2/Er6Bz6fqsOUc7Srf9mXBgP
 b8AXI14Q=
X-Gm-Gg: Acq92OFN248O+O9nnTn7jrI62sMaW44dBzBkSBH6aSsuOx+5q+86jR6I8IuuRb9ub9y
 o+uBzrIBrWEeSrdPvXVds2r+Qqucvtcxv44eN26Lavv3uIt0j3NxSOXiVAkr0tRn35QBUAce+g+
 gupp7dZHn7NJLldwHCCwaLLSWjG1oHN9eOtjpdVfD8ocoepJ2/yDPRCsmY/Y7vrKySxJrF4j8cz
 bcdr9OnC69IuutnW1g080juWddtWVpsSkxUFr7tHaRuQA59rgTmPUYubeW2m78JzUCjK+R4i64L
 vCHvMO64TAHHYPm79wbCHJhWdcW5766kU4Tmlp1PgIsVmd9yzswd7FoL7CiIaArfd0kAvPfGEsT
 2cztlG++ETDH9Hbx3VZnITJIndzlU/PRi1cdDVUtGaOqIwQwdYP3WSmpTXE0uW810ly6ctsMrzY
 ssIvabLu/IE4Ohf5fSYxdTsYMxX9IljQPvPPdpAI3EOcsR10wMUQ==
X-Received: by 2002:a17:902:ebc3:b0:2c2:7baf:139f with SMTP id
 d9443c01a7336-2c2a1c9b30dmr52135825ad.30.1781033083488; 
 Tue, 09 Jun 2026 12:24:43 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm212247045ad.32.2026.06.09.12.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:24:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 41/45] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Tue,  9 Jun 2026 12:21:05 -0700
Message-ID: <20260609192110.752384-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1fc8db8d58..2b1d1034c0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1703,6 +1703,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
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
index 2cc5e129e9..f6705ee95d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8461,3 +8461,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
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


