Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADCCDE007
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGJ-0004vx-T6; Wed, 24 Jun 2026 21:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGF-0004sP-44
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGC-0008Us-Ue
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c7f11646c3so6352535ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352328; x=1782957128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTCqTOITJlqgukL2kdByVePgUQQ/ifBjiiy5OVcoL3A=;
 b=d11XCMFWDYO7qjDNjEp6aPOifcZyBFExcojiAGiIhecCD4tOJFqlop7GjPHDn3/AdY
 upa5DgpHIuPiXDsmbGmxKVe9cb9KF43wTm2g93nzaRotlAFyFLIKK/7bLShjOJ45yPUr
 25K1jKVd2VIPZI9TyvUTa3WclClDt4BF9x+RgW6gxMIyx+xwNbhOm3UBQma/7y6SD84K
 r5GkHEm8tiRcH+B66G7y6NZfU0xtBViasEBFhfi314cTa0pA9lUP0UrWcLE5SEaHHKW6
 LEQVjs5u22OpS/HCFii239cOPmVJeUMsdPKcHvbNiomo6PfRfWJE4Ikan+9/DBrXIC7q
 bxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352328; x=1782957128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VTCqTOITJlqgukL2kdByVePgUQQ/ifBjiiy5OVcoL3A=;
 b=nrr/mD40b6koaVF6mdIXdtb5KTTwD17YGiHfbAEg9KERx0Soin2sdKTsG7/hcqXpUQ
 jyLL0TmzWhUoi8gWCUa3A7YgaN9o4Hd0llT0siUa3KEOFzKminbbRB3hrgnUVixJi0eN
 SVcetaBd5wxv6iUemnjJyn5YK+iekTapEJp7Dv/EZKQFXbZnND+Uk37RWCUCmlLPpPnB
 oO9AoX5E3NVk/3nRebBMQdMho1BHgH5++YjBOqfcoOlJis7xUACgIJBjCumb62n5X8vv
 ZU6NTCXP4Yq847TSvvFQDYk7ugSOYaOTXXyAmMWJsn6f4sbaJC1SKuDMRdvygOH6QvJw
 5Uqg==
X-Gm-Message-State: AOJu0YyiG8DzuE9znU3zRklvXenJPBN/6+vdJB2bjzQdME7wRjhi69GQ
 n9Atr3s8I0hppL4cVDU27toQUXTEmAswRa5o2/Dyo8yTWEdrP31CsciwBFAW/U9SXB5ehaaO/gk
 YkwNV
X-Gm-Gg: AfdE7cnaTtMP9Pqcus+9FVaOpq/aUN+YWjwuZ72FpF2B5Wr4vpzVi7MJE/Iwh6pvN6X
 JHfy1qM10I1b6+OQGybEWtnGFRjMwnO6i2xNqoWRpAdRcgQmJcJ591r7wH0P3WfHAC0QJwLRenU
 HShOCDNniMfw108x/3trwuzPASYSRDSyWIChOQmriTO5GlnZ4EwQpR/0xUogpt2DKvgtYnUab9W
 RCIPRDQMaBzcXPvJiRMiZQ4PrrSE+jePDeWbx9FXlE0W6wBpSxq4lzON3iAR+S5JojUK4dBBCqh
 roE9y0BMOxrentpu4fyqIJSh40ScghbgWzjQZACz5uVulaVolojR7xYhy+N0ZKunCTxeYJTg1wZ
 FJajc2lZa39ZVn63J52xFS4sJs/xPiixcLVH8Oxm6mJHCGwxsLtfGWqsiwDse6XtbDqL7AuD9ne
 adtAGq+F9gQzTH0mOnt9lhWuSCTmDMdAMfIZpTA6xsrBwKnkqYwtlY4/RIT0mH
X-Received: by 2002:a17:903:1a10:b0:2c2:245a:3366 with SMTP id
 d9443c01a7336-2c7fc76c3dfmr6751155ad.27.1782352327576; 
 Wed, 24 Jun 2026 18:52:07 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/10] target/arm: Implement FVDOT (FP8 to FP16)
Date: Wed, 24 Jun 2026 18:51:57 -0700
Message-ID: <20260625015159.719300-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  4 ++++
 target/arm/tcg/sme.decode        |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 05bf8dbdc2..126dcadf77 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -43,3 +43,4 @@ DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 5606f0fd8e..e1dcc2b70f 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -950,3 +950,26 @@ void HELPER(sme_fvdot_idx_sb)(void *vd, void *vn, void *vm,
         } while (++i & 3);
     } while (i < elements);
 }
+
+void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    int idx_n = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int idx_m = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    float16 *d = vd;
+    uint8_t *n0 = vn;
+    uint8_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *m = vm;
+    intptr_t i = 0;
+
+    do {
+        uint16_t mm = m[H2(2 * i + idx_m)];
+        do {
+            uint16_t nn = n0[H1(4 * i + idx_n)] | (n1[H1(4 * i + idx_n)] << 8);
+            d[H2(i)] = f8dotadd_h(nn, mm, 2, d[H2(i)], &ctx);
+        } while (++i & 7);
+    } while (i < elements);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 267a6b0d9b..ff5554eefb 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1273,6 +1273,10 @@ static bool do_fvdot_sb(DisasContext *s, arg_azx_n *a, bool top)
 TRANS_FEAT(FVDOTB_sb, aa64_sme_f8f32, do_fvdot_sb, a, false)
 TRANS_FEAT(FVDOTT_sb, aa64_sme_f8f32, do_fvdot_sb, a, true)
 
+TRANS_FEAT(FVDOT_hb, aa64_sme_f8f16, do_azz_acc_fp8,
+           a->n, 2, a->rv, a->off, a->zn, a->zm,
+           (a->idx << 1), 0, false, gen_helper_sme_fvdot_idx_hb)
+
 static bool do_fmla(DisasContext *s, arg_azz_n *a, bool multi,
                     ARMFPStatusFlavour fpst, gen_helper_gvec_3_ptr *fn)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 160cf130d4..3a65e1ad4b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -821,6 +821,8 @@ FDOT_nx_hb      11000001 0001 .... 1 .. 1.. ...10 0. ...    @azx_4x1_i3_o3
 FVDOTB_sb       11000001 1101 .... 0 .. 01. ....0 0. ...    @azx_4x2_i2_o3
 FVDOTT_sb       11000001 1101 .... 0 .. 01. ....0 1. ...    @azx_4x2_i2_o3
 
+FVDOT_hb        11000001 1101 .... 0 .. 1.. ....1 0. ...    @azx_2x1_i3_o3
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
-- 
2.43.0


