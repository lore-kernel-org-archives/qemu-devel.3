Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C5AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwpC-0003ea-S7; Wed, 02 Jul 2025 08:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwk6-0004rd-Jr
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:20 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjj-0002GM-5y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:05 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3840229fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459929; x=1752064729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcUtaxIWGiqWV3h8XEdJaLdVvYVoZ4GYfgwZtFj6i1Q=;
 b=vT4trptXb8X0S+/4mbB4vbW+7YdRG6GDPRMmLHxOFdrGiXbV934IB3ABxEUmW0NAjH
 RsKWtknq6q7oHrI/H37HfaRzVuF5wbFjwGk6MMDNdT/0B4SMMsMZWFgayCyVuFpugnGY
 rOEi6rKmkrNpfRIe/knl7T3jOks+pRGLK5AZs8TrOZV4eRMf/lRiiLCO2MJOQXPIjY0Y
 2m11s06ydn+/SkJ9vsGeQxZVNH31MM3pF833kr1oTXqx+s/qfWPinXkFpzMNt3YqHjYM
 ixxdDreM864kbVJtWIn4Q/xhgxI2gzHy6m74AD23XwIZuIj4f7MXKevyA9kYMshwJQKn
 GLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459929; x=1752064729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcUtaxIWGiqWV3h8XEdJaLdVvYVoZ4GYfgwZtFj6i1Q=;
 b=B5fSjU8HeeaSQ17IMMkaPlnQ9uhcXKfMbcD1jmTWKWv8ewFm6k8pTNHHhny4Y/Jjjr
 Kaz+rqfABdVFuBLbHXZ2IQNevihtqRACUvjZUk4Twl3eIJnLyBb1/amdop4txyhqcv+c
 IQq26m44+KvkXPfbMdYaurmJ4vqQVtANfnWAoPFoOvildfRTD1H7q50t1SaurOGTiSr1
 +sYulIB3CtpgXDqQA7k7/0zeqrJdRNHfzRL9YIDEZm/AknZup4fM571J8cOJKiCjNS+b
 5AmmsgrOs8ntY+vum8svN+bW91BgnXuX9WyEDfvONW5bF11BtZ08kSVo3KJ4mYk2KsJI
 rLOw==
X-Gm-Message-State: AOJu0YwS4/GdTaAQ6N0Etkv3b8OsT4qCPr+xxDkQAGfPhG3Rj9CkCYB7
 W77tAJfhjslB82cWJCML8Gr+ze2/m/rlDxkDApu7b7Kilbf+own+YPtr+YI8fd0QDrPPayeakb7
 0uVaJJ4c=
X-Gm-Gg: ASbGnctNH8uSc46BkdkXPwfJcpqefbhYThwJ2OQct3cHrqeY94b/jln37IFDPM+FCGA
 Y62NS7j+T9yhK2eWAjJ6OARM1FN73cyv3LhTyBmG3Zdr28kvOs54O8MD4ETMn45mLpYwY1IijaU
 ATGkxY1SUHi7Nr0d/wtZ4rIzKxi2jMwDcF8I45sW2Bl38EfNkC7j4qPI9KWmppEAGRlJsuY4cjN
 OWThMb9DxAEp/+9awRDI6kt/VvX0dC5nAwpThQjj+gNMdoWS3qnS1QWLL3tYL7DJQRrSPjbYQIQ
 1ODFABGbsAMdlLSMEyhnYntaJxm0HiZIrQg31b8w2E8Dq6hFAb/hcT0b2Xv3TsgL0eeK/Q==
X-Google-Smtp-Source: AGHT+IE0SbZbxVDP+3EJqmR2rIu8QrGkBikuWkI3rYJupi3D6GGGV1fjFHdnau9FJ2Hqe20mYtCK9w==
X-Received: by 2002:a05:6871:487:b0:29e:2da3:3f7b with SMTP id
 586e51a60fabf-2f5a8b95f72mr1853923fac.7.1751459928756; 
 Wed, 02 Jul 2025 05:38:48 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 75/97] target/arm: Implement BFMLSLB{L,T} for SME2/SVE2p1
Date: Wed,  2 Jul 2025 06:33:48 -0600
Message-ID: <20250702123410.761208-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 05c0fc948a..079d310960 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7421,6 +7421,36 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
 TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
 
+static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, false)
+TRANS_FEAT(BFMLSLT_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, true)
+
+static bool do_BFMLSL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, false)
+TRANS_FEAT(BFMLSLT_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, true)
+
 static bool trans_PSEL(DisasContext *s, arg_psel *a)
 {
     int vl = vec_full_reg_size(s);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 10cac2de22..0df3312739 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1727,18 +1727,24 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
+
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 FMLALT_zzxw     01100100 10 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 FMLSLB_zzxw     01100100 10 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
+
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
+BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
+BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
 ### SVE2 floating-point dot-product (indexed)
 
-- 
2.43.0


