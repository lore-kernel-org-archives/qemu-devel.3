Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ACACD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23I-0004Dq-K4; Tue, 09 Jun 2026 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21R-0003H7-4E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:11 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21C-00049T-7T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:51 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c8585c51f1fso2867197a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032899; x=1781637699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X6cHTMEhKqvTK1riJnePZp1c9cIoZy4I30BOx01ie8=;
 b=j0RswhS4GCIslUsnpADDWpN9HyBgUUrMeOYs5YemXnHdQUjly/qWRvbr2CFdxhQ8iQ
 VH4y07VnlIFt+EKdJQPWP2LcQGr7O4Ac73jsdAuNSrVBzSu3JZ34Yi/G9BmKELUQwGzj
 0A4d4t3mpGA0ahuTUj6gBytc49CJz/FQyiMvbgx57ynof1fducrt+y5FHq067ULSDmTs
 x6FpiaTYnl3fDN9+YW15tRIq59LdcSOrrA12ovO6nlHbQieaP/cXLN7MerAcSXjKyxgz
 CSygusGHEJmTwuEw7B1ClCqoOZ308UgyBs+GnO927x8mZzOohqqiqN3BbiOjrmRd7/2V
 SpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032899; x=1781637699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X6cHTMEhKqvTK1riJnePZp1c9cIoZy4I30BOx01ie8=;
 b=ZZv60fGxQyhucUTdSZZexrThOmC/q3gkCzqFDNCZKc8xcDAEJp7vTw/33DbsmItewo
 OyKfF7LUvVEOpqtc1m7RaakEA1tnqGCf3mDx7YVZxVDg7brdgg67S5CjaFFT0bry7aX/
 rWd4oFnLldUYe7XVmDCWP68hc09uG1FJNipq/S1Wnk3xC1ERlOHkesxz2u6vFDo+Z4qi
 rD+OWUtQjHSLaRdEjMdBpiTD1edpBL649Zd/2qJyJsHpQxUTPLcZNjWUa1zN7SmSUekl
 9mx+/hFpeVdw4CDnr+WZUqiSvce+eSKKT8/522HwxxZS5xus7iMklMQl6UQkLThzZ6dE
 N55w==
X-Gm-Message-State: AOJu0Yy9DmdSI94twTLKsI2wKw5aT7p3QkZ8tSB0cp1kvx4zeO04W+8X
 Yj+uDRP6uqlde5lHUs1DwPzkxV3n8+YLclEataPwnvLBqDkG3ZoZkrEWL+BRgFvPse9KZzEJ2pj
 khpoLiBk=
X-Gm-Gg: Acq92OG9zxuHH+TFTWcMUSgDZcVhHRj7dAjYYMmp2i1D5HmR2LkxSUe3azfOVfaqVLo
 sHJ86mRiAhuk+F8AsQT+sFxEqz2BrEP/SXdgKb4nDkcC44Ghuur+5s7Sp2pDLQbc23h4vaj1QJ6
 ozlHEqFYLnTd5jN9EYSHYmBSKmMPrY3MOgtSHMEYPHVNuchc0F6xqhwBLRGxFPC39VohRh97j2A
 PQ9yaUEu4G9MWg5Npdv0CeDkvOkp60HQjnf9P162/2F+1UDdKbZOII2OQzOd1oc9ujPNaBAfHC+
 rIfgBmVodQ8toAJ3brHvrqENSqAlm140oRiqj/ft2WiUlfY17Ph3n1o9wQ43oGidPaP9/e1C2y3
 WhVlbVbVjuIfyaJOimfy9uAazq01nzo+DoSJR1jbu7yWqNsG6PRk0UnSGifMfLlI+/K2J4/WMe0
 09JEHPgTN7STqkDXSPzfEkNYBEADloGtF/UKZkQIiOz7L4pLnUCw==
X-Received: by 2002:a17:903:acf:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c1ec551c58mr183633555ad.13.1781032898510; 
 Tue, 09 Jun 2026 12:21:38 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 35/45] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Tue,  9 Jun 2026 12:20:59 -0700
Message-ID: <20260609192110.752384-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4342a2461e..fbf4decd74 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1560,6 +1560,11 @@ static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9f207a32b9..582471b380 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8391,3 +8391,38 @@ TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
 TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
+static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp4 = dc_isar_feature(aa64_f8dp4, s);
+    bool ssve_fp8dp4 = dc_isar_feature(aa64_ssve_f8dp4, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp4 || (fp8dp4 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp4) {
+            s->is_nonstreaming = !ssve_fp8dp4;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           tcg_env, vsz, vsz,
+                           index, fn);
+    }
+    return true;
+}
+
+TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
+      a->rd, a->rn, a->rm, a->index)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 06bbd7fa63..c49e992f10 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1874,6 +1874,8 @@ FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
+FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 floating-point multiply-add long (indexed)
 
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
@@ -1897,6 +1899,8 @@ FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
+FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+
 ### SVE broadcast predicate element
 
 &psel           esz pd pn pm rv imm
-- 
2.43.0


