Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED60FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Dk-0003Nc-Lj; Fri, 24 Apr 2026 00:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Dc-00036B-DI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:44 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Da-0003fj-6O
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:43 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4243bf9be36so3461595fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005161; x=1777609961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89Ve9V43x0EDfFcuX4z32PJFwEIHKLJcoTkwxamYsNA=;
 b=UWID8dPbrf3zrbvlpvjikcYlmdVWY+ohHm/XT2Tb7Zgva0lRQuERQbP/4YBRXm4QyD
 TVc9VyOX3Xh2g5aofNkW5Efxo7TWEF6O9I01PTJdJirx8QMEoyzKNvTH7nBIz6HmooOK
 YnKDdoeAwcEr9Bt2baHE7XNV6+x4pz0gx4ymo1NINxNn9lG8kUPZbigvQATwX9blv/QJ
 X1EMWIsY0zshHKM2DXwAvqpka0ejSvUH6utqnLknLuSpgTspPoMC8XvnW4CvTKXsHnNA
 m5aFRunrWWoaKOitpYGOdb+e7CQQ3+19I1d/FVRADiIps4pFkoFveCO0Rbh1mCIwSSeS
 HKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005161; x=1777609961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=89Ve9V43x0EDfFcuX4z32PJFwEIHKLJcoTkwxamYsNA=;
 b=JT8R7CzYtm0YFwiNwXjLzDHZRBMW3f/gM49tVUIdMrU38V65Z5dQjv5CdTf+oWgrZL
 d3iSbQrC/yYOrMDUkBaRZBLTzNc3xZwjf28zs+TXXIrKEiF5KH+rJecoD6d3E84jPGJq
 DimOPW8lWUJqkd6uSuvw31KyASkjIMfJe3Q9a6EyzQEeJg6646qPRMj4FK3244GR0T3m
 qMRRYihnll+nbluRdxEpo4KlzwTtTrJ+LELdlLsTaxm2QVH/rRiroxSelekfZbGKnyj0
 1lWZSEgF/jogcnkcwtgFHLvZLbkuVZnqzb+k5Rpb0lF2aGkcYM254Ft1S0MMCP+3sGFx
 KUmg==
X-Gm-Message-State: AOJu0YwGBtP2xTxkL2f1Es7mZm4xRBrf6C6QNvGk3rtOpzcWAjuQUG4a
 IT/LdYiHX0++bmUuggi6mrYADmL/gHQItOlDLJsASV/4gXrPglxwjocx/e/CxYYGvXu03OUZZrh
 bRR7mtGw=
X-Gm-Gg: AeBDieuo2lPTydGTIKDDnsYtUYBGBTkH/LRNjxZt5kzCJOMF5pE+h/sQYQMmOSrXmuR
 qSpcojPtWFGTAfaHOaRb1P1CXufDmRObV4Dy4zspv8fYSc2sRc3e1s8BCnTtxbvTlp/b24Ry5Vy
 YB9fiailPvI5RMsIrbq0/a8dDs36KZTknwbR+RbEMdTc28rLHlcv7i95IpAjPaoLc3ewtodrbHW
 gYJRztRKsS68FPutPdDDlBf32nW8k5IgNFEql3IedtKctevj2C4GxBMtHaKrhLk8qfcU6gr2K59
 /nr7Bi0bsetV1+tE83nFQxjYaifUSWqYKtBtwyfRtUP9FPQ0R0HbSCYKEKBrzcwMV00KusVIQk4
 vFxwD72+9T6BYETW0HJEZQGtYqB/745ZFBJ8n3P/r86sUlwAVx/oVhX2CvdyOwmQ0M1pFlggv+S
 uD8XgYUoiMVABX8hLpaNfCp3zWaKh5uG2vqcyZNQWfTNn6gU0YquXVeKamLqq0PQ==
X-Received: by 2002:a05:6871:c005:b0:42c:7f89:2916 with SMTP id
 586e51a60fabf-42c7f892ceamr9629273fac.20.1777005160998; 
 Thu, 23 Apr 2026 21:32:40 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 35/40] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Fri, 24 Apr 2026 14:30:09 +1000
Message-ID: <20260424043014.46305-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 29d116a57a..b112f16cd7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1555,6 +1555,22 @@ TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
 TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
 TRANS_FEAT(BF2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 1)
 
+static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
+{
+    if (!dc_isar_feature(aa64_sme2_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zn + 1),
+                           tcg_env, svl, svl,
+                           FPST_ZA << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index d6192eb59d..a02bcc0e22 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -863,6 +863,8 @@ BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
 BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
 BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
+FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


