Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C34EC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMga-0006RE-7g; Fri, 24 Jan 2025 11:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYo-0004za-Mr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYn-0005fH-17
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso24071665e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736171; x=1738340971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qs+MQLYyxydi0FLdHXNe7tQBtwbpgP1LG2ASJBHmqjY=;
 b=yYGtQUG0I7+/cLlW9WUyoHq/U9dq9XO5l/FOSAMH49EYSkMCZ8segxdUcfty4Kzw49
 NLEUN62eNzun+dNEptLE2O5uj1Q2kzxMz8385B9wkX8kUb409ubgAH7We3Lbcacw6BTY
 TSzUm/0r9u/FqhSENqk/tr70Hy47sCwa4PGRuSOl6SeibjeArqkMYltdYl57X+4YTRsZ
 ZCDIB+vVoXFySpwX2CYgd6Dfz6rkoQE+SJU6/G+K3kxttu0RP02wuDTo9B9H5j9Wyq0m
 D8LXTbJU+9mE1ztDaa/ahwQeyGk2EgYlKsqtgLDcWO+ON0uHLmgoefxJrbkqmeoTB31t
 HI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736171; x=1738340971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qs+MQLYyxydi0FLdHXNe7tQBtwbpgP1LG2ASJBHmqjY=;
 b=f5wv3mphQwquJDRbKK4HwY8PhKTqQckTXGdYtUI1wk5nQWv8jzrKDbiADXiQE6f2bH
 /M0Q0wIqZETkPoGfY7fVmBnsLaAAAs9H7LpekclBv49m/U1A67E+7gG/UjqwP7oq6bKy
 20ByCvThQOdscO+41NsK9dD7pOotnDUeUjKadIeOYG6ksqTJ/aqtCQto53pgjP85+OdB
 ORPX1gCiFiTFMfeL1z/nK596fy3nhCxObGZIsiVzNp2v3JvhH9rjNWBAXBTkx60M24Zp
 V9kB7EfYrGbxToQi6TSWN6bNtW+64FpkgYpIppGAOM/IDBxps7xK2XBN0u/8fdqycHXH
 aC1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX88op/5tGwF4f0mcLOgt5Ef+Le5RhjlMTlYZkzslDMP9fsvrRdnF0YaE5kVdN6/WYzgSIWzbUFYK0c@nongnu.org
X-Gm-Message-State: AOJu0Yw8em1KTrL4J6n6zYCgiMn6YW/g//MhMZYNS717sLZIroHSPrdg
 JKQTF0zHhJRUXHaL7d8gcWwPdN1C80LUhp5HlgqvwyHxRhTkSrbbIhp5ZJzoMFM=
X-Gm-Gg: ASbGncshdFlDZUmPnC7Y/AU5/6fmPvOgpZ9TXa4alZhfs7o1+b11TEtP/py83v8z+Wu
 Ft82W0pO7d3WZO4aB5FVvyfgaENywhV77nY1kkWktnHyLu7USFechfOBURkbqHrcoWwvIKqDgae
 JzFRThjt0OvQCxqaTQEtCkTmeTz9afBWUcfSexarL2ExG4UKkijcfiKlZIwQ202rpm2mUdJ0Bqs
 iCX/QM2WKvMX1N4+MVIUA9uq41bSAVu9I7sDJpLidTbD89Pc0uxVMXN41O05UTlqQjdOOAk579D
 1xwEoohIM40=
X-Google-Smtp-Source: AGHT+IEROCAWkmMtxspg31uKBd2VdUvuVOX8pzRxz8F6lcRHaXhprg6s9co5Bri43tuYkOdxhkW2yA==
X-Received: by 2002:a05:600c:3b0a:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438913ca93cmr315685425e9.11.1737736171426; 
 Fri, 24 Jan 2025 08:29:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 43/76] target/arm: Handle FPCR.NEP for FCVTXN (scalar)
Date: Fri, 24 Jan 2025 16:28:03 +0000
Message-Id: <20250124162836.2332150-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Unlike the other users of do_2misc_narrow_scalar(), FCVTXN (scalar)
is always double-to-single and must honour FPCR.NEP.  Implement this
directly in a trans function rather than using
do_2misc_narrow_scalar().

We still need gen_fcvtxn_sd() and the f_scalar_fcvtxn[] array for
the FCVTXN (vector) insn, so we move those down in the file to
where they are used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7412787b6b6..6dc5648cb1b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9258,24 +9258,21 @@ static ArithOneOp * const f_scalar_uqxtn[] = {
 };
 TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
 
-static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+static bool trans_FCVTXN_s(DisasContext *s, arg_rr_e *a)
 {
-    /*
-     * 64 bit to 32 bit float conversion
-     * with von Neumann rounding (round to odd)
-     */
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR_A64));
-    tcg_gen_extu_i32_i64(d, tmp);
+    if (fp_access_check(s)) {
+        /*
+         * 64 bit to 32 bit float conversion
+         * with von Neumann rounding (round to odd)
+         */
+        TCGv_i64 src = read_fp_dreg(s, a->rn);
+        TCGv_i32 dst = tcg_temp_new_i32();
+        gen_helper_fcvtx_f64_to_f32(dst, src, fpstatus_ptr(FPST_FPCR_A64));
+        write_fp_sreg_merging(s, a->rd, a->rd, dst);
+    }
+    return true;
 }
 
-static ArithOneOp * const f_scalar_fcvtxn[] = {
-    NULL,
-    NULL,
-    gen_fcvtxn_sd,
-};
-TRANS(FCVTXN_s, do_2misc_narrow_scalar, a, f_scalar_fcvtxn)
-
 #undef WRAP_ENV
 
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
@@ -9377,11 +9374,27 @@ static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
+static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    /*
+     * 64 bit to 32 bit float conversion
+     * with von Neumann rounding (round to odd)
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR_A64));
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
 static ArithOneOp * const f_vector_fcvtn[] = {
     NULL,
     gen_fcvtn_hs,
     gen_fcvtn_sd,
 };
+static ArithOneOp * const f_scalar_fcvtxn[] = {
+    NULL,
+    NULL,
+    gen_fcvtxn_sd,
+};
 TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
 TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
-- 
2.34.1


