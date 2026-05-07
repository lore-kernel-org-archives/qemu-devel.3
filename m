Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28997CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SE-0008DN-Ps; Thu, 07 May 2026 19:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S1-0007U4-2H
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:17 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rw-0002AS-2e
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:16 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4243bf9be36so701310fac.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197690; x=1778802490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtIBkbT81J+BgKXr02F37hxzamy6ljmyZBL+9ZpX8bo=;
 b=OgeQmQBNWmZ4j7UtxoVWRgt0jwCqrXaeeaKUdPRVb9Gu1YbzdI4MASz6JMVbH7ZbYs
 7+7z8O8PRSlet10bQEjeTeVE3NCqyQ+wpdvCVOhR+4qGi1VABO1bsRGkGWPcggTSPS68
 TvIA3gZG/9cKLWny1v0ENsmz+tUuP6Bm9SDVE+17m0LCrYVhXWpYM3oeJbw9I1hR7YPi
 0S5GkUPvdyJjvnO/rnF8Jir2g0xgavfPAxDbvymWdUx4/m09yMIZpLnkPnByz8nReh4S
 nZu7KgUeSg1rOGS0MYFQTZhDIl/g8OmHYi/JfPLNzGL/CyLZsbjFDeQ6FCaoLALeQn3H
 oD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197690; x=1778802490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jtIBkbT81J+BgKXr02F37hxzamy6ljmyZBL+9ZpX8bo=;
 b=q4p0rsFstb6d5izY9pM8zk7TqsTx7DFs4Z7aTjIVoVxre9uh8hlYnyx+nvrf4LnIoH
 2rspC16WUqrqlzfl37JaTUDjDmn8C60P+4bbZqnDj6/MkX4ac0K32GuvjnxLi9E7Kzpd
 WqAKE4oIClPnIwj0iBaSapAL9jOV1ET58fjAmfWK3d23M2T4MNjs+JMMOn74xT1gNjJ6
 EyIA1M6GesAQpClESf4y+okpT2P/9sWYK+wRIt1WBdrAnFqthx05Z7IXa+WIKuuNFvJJ
 Yi5Kq93KTV16eNVpS/YMnRyojMWB3kCjr+1fSJodWitz6Q89lz8aj6QBW95/eZOliItE
 SKNg==
X-Gm-Message-State: AOJu0Yyig+C8jAow0Buqzu4iexPRrf+Rvy93Xhcfs5AS/v6sZv+ZwD07
 P/+iPZCdzA48JQEI/k2PuMrHJJidu0wAVeeZTw86KRGXsBCzYBMGDtVryaroW+CWju4btgLiROu
 7pyVa
X-Gm-Gg: Acq92OHvXAGOjTmep8AmPZz6PTLlJIbLIreWQO19kK/cnMD3Yj4WmzLgzudroLoVopP
 2g00QkJ+L2/GGBoR6EEqB22cetugMd3+h6dmU36JG6PazKkoSv60aK67ejajXua/+LpcFT0QzQW
 pbWzBWWldm6ZxEC4a/Pf7i403dHLc0D67jDhjX/4krEnBSG+MZNXCG/pzU0UPlVVWq+3iq0WnDu
 9XYHil9+n7Ivb2QAl20U5WqpTGtxZvJ40mTggE/IsPCWoWyFrKNl2FIdOuT3pSZ/vW3LxQLt8wi
 ZVtD/eC1HdmtlTHlo3vS21zF0s1+4etUt9RHKZSryb9DChHGV2bSyHnb5+w+vfchWDve+YfAV/g
 zGEmnsf/neAkmfuyhYYdBnHLv4dSNB01C1O52jqICWavjGmX39B50hU5fBv5cxDFIq9Vf9lzZuS
 2tQggAmlwfM78B5WNqXcbj3F9K+u4Gry3dLM9l0fNZRvAZ/XDmqkqr5+F2
X-Received: by 2002:a05:6870:2807:b0:417:533b:7999 with SMTP id
 586e51a60fabf-434f58cae02mr6929035fac.1.1778197689706; 
 Thu, 07 May 2026 16:48:09 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 55/60] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Thu,  7 May 2026 18:44:08 -0500
Message-ID: <20260507234413.643512-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 36 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 9825262284..1f1c090ef5 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1614,6 +1614,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
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
index d169e8327f..c90b276913 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -813,3 +813,29 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
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


