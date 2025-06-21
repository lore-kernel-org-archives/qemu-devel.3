Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C00C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82f-0003LU-Cg; Sat, 21 Jun 2025 19:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82S-0002LW-Rp
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82R-0005Aw-7M
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso234466b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550062; x=1751154862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8EtlLBp+HVhoQ869WpxoCy9SLx2DoSJRlXXH9wDNtJc=;
 b=wUNXuT6r8dbDLoNVVIiBWrGUfdZblBKcCG2+2XdWR1o5PNeCL8t1Pn2c0SXirovd68
 XPWt0hrufoqULD7t5lgZvoy8P4sPUIWP48AQJKIpnigQ8fM16FtoFIoOgyVedqkCNLRd
 zbG05ZdP3iTVXQLQ0yLr4c1nTTHFtSlptf7IUBSX6+NPEB5miTV2S4LPAMSXlCZ+K4So
 S8YzIrCDAWMkzgJGVcu4c2JzcJJ902g+bswGtj53n2uDhA6pjr7RbU3fCyEIbdwRUBnQ
 cWO9HydHE0yxw6T0VLq5qLf5CNR4pHSuE3qufMmMPx7++JVwPKa+VrtJGUvDSiqnux0l
 I3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550062; x=1751154862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EtlLBp+HVhoQ869WpxoCy9SLx2DoSJRlXXH9wDNtJc=;
 b=Q2bLU/9fon0SnPf+6zEZ8L0K16yT4+W28SPpdb2X7QJRNkITUu9h0rl4qaGhT0nFBT
 ROB1Msew6wLvIXzeFx/avHJ90nYeppai/kv+NKkZsPUDT7mSLGHBCPYO/omL7kPLuPN4
 97xoPgGZz7J03FghpYg75k3bmXZrqhMoI+XNK7o1JRKzYjnjGdVJHoR4pq+QvXbOqzLN
 TMTkULmk67zaacMkHZxoZCMKJNqETukGvnrN1ieG4DtEw9qOIIxVldCiPHsemDaxoLZr
 T2l+0NWuhH+tD0lqGAXvwr/e5xAHOx5s0OaGLb/CbmiQ4bFT6DI529T5Rj3bpiIUvJ2h
 ZRpQ==
X-Gm-Message-State: AOJu0Yyjeygq7boQeKr1VYVpmXsUg1ofynPh+TSy2akE3iI858KhFte+
 UtYaK4AtKKGapAv1xzgAVfJ4NZG9RcXWSmMk3E7y5tGKYTkBYhE6gsaHjao/TaDggOFvf++KgXU
 yv+0FAvE=
X-Gm-Gg: ASbGnctnMTnaQAc8XQND9wxBvjnbiGTwrphY+hE70NQl058jllb+kaaLAeeRODOaR0e
 ivFNr9/zmYNZUcopekDvxlgDlgCuH0zqYVAbE4FGwLBwnth/X3TDn3LY5E0ELVwJ9orA/c/fxqH
 TC4LbgIovogx8IBmG3GK3ad2LKPwAy6jzBR1S2j5AH3Lk6fsD+cJN6prZAxP9gTX/JxuF4sEsWv
 0IX1u5PkMnLcTUatg46Al/tJiGv4OrgxguQGqufbRXhkb1tpM2do7Q4CiRQHU1tEuVJv4SLBxJP
 sY+ha/vbZxqSPJeHbo2wCvwzaG16awLF081TkuMIKE5pb2UZck+hgrv53sHW/4NWOSYJdMSQcLq
 0PIZcyB/NYrXa/9WQ/X1W
X-Google-Smtp-Source: AGHT+IGrqerGxGmf8K+kWbH+N+xpPmYPK1rIn/de2iXVWXYhmzrQcO0WuwyexES2N16zkR5EsoOBoA==
X-Received: by 2002:a05:6a00:4612:b0:746:3040:4da2 with SMTP id
 d2e1a72fcca58-7490d51ba3emr12130745b3a.8.1750550061814; 
 Sat, 21 Jun 2025 16:54:21 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 067/101] target/arm: Implement FCLAMP for SME2, SVE2p1
Date: Sat, 21 Jun 2025 16:50:03 -0700
Message-ID: <20250621235037.74091-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is the single vector version within SVE decode space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index abdcafd952..235022110f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7381,6 +7381,28 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 
 TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
+static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
+{
+    static gen_helper_gvec_3_ptr * const fn[] = {
+        gen_helper_sme2_bfclamp,
+        gen_helper_sme2_fclamp_h,
+        gen_helper_sme2_fclamp_s,
+        gen_helper_sme2_fclamp_d,
+    };
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8
+        ? dc_isar_feature(aa64_sve_b16b16, s)
+        : dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+
+    /* So far we never optimize rda with MOVPRFX */
+    assert(a->rd == a->ra);
+    return gen_gvec_fpst_zzz(s, fn[a->esz], a->rd, a->rn, a->rm, 1,
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
 TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7e29882a71..b0c7b58271 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1722,3 +1722,5 @@ PSEL            00100101 .1 1 000 .. 01 .... 0 .... 0 ....  \
 
 SCLAMP          01000100 .. 0 ..... 110000 ..... .....          @rda_rn_rm
 UCLAMP          01000100 .. 0 ..... 110001 ..... .....          @rda_rn_rm
+
+FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
-- 
2.43.0


