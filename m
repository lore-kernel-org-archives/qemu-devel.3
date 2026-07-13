Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E2C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPft-0006AX-W1; Mon, 13 Jul 2026 19:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfr-00068S-Bg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfp-0005o2-I0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so32857555ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983772; x=1784588572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKjINVU4cgcSq/r8Q0p1zL0dVvca6JAQIxpELWKZess=;
 b=sjdBBMxNQx7qUwfZBDf3Cp9LSWGmij27L+B8wmlUM2H9/yXFJaGQfTPskveVk3xPzD
 dkk9YSLuKmEN7GZQDyJGNB5v0AuGGBfNYRQYLW145FfV2Wp25QkB+wrOTPZqjuXr+2nT
 xCbdIHKnYtjApSJ9UdcVmjxZY6bVbNjvZhEdplLPiSgiDi6TM2C3lIjuF9KyChGxT7jH
 0UnVG5oql5ejD52auihuomp3MI05MvAUd6AJXN81N2ydyTE/ockE4YESNwNY8foJsUOd
 TLbisZFcT9RUi1/Qr2lvEvl7l3CAk8QARoyVpAO08JVP8ijCfk5H+1YO2S1dDj1fMB5T
 PQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983772; x=1784588572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lKjINVU4cgcSq/r8Q0p1zL0dVvca6JAQIxpELWKZess=;
 b=ebL1icaV1JaWpGhWrIPv84lY9SIdLPnhismTU6B8cuiRxkLQeJm4w8m269Fa8oh/Ka
 MFG7hNO0qf+KkvxzyIoFSFbBjJIhd3wXfDblchP7LC/tH7pF7MI/Oha4FQEahZsU9jik
 8T3KQCqoH1cKMyeLZEIx8mnpxRy5kuUzX0n7yFyKv8J5+2vue3A3ZvITdjFzRHHgwEkN
 +zJDbGkuOP7HWD9Hr8mKo+MjfWe+QMG/hRODeBTzNmriT/WoExag2OwzE/3n9Ypsm2EJ
 cGzC1kfRqy3UOKgrKlzcCc6PERmTQi/y3V3CWTdaJ/XF4TcaZsrEeFkfNJ259Giytbpy
 vRlw==
X-Gm-Message-State: AOJu0Yzet1JqWU6LfKyggGLRAODxGQR9fBHbGHgEfrAXEyWTCbOLH72n
 of0OpyUrpolKuci/K2+cZk7nQtGzz9iwcSVLoTjYUbw/fvrIdzHfjFZi6+qgU3YGKBCcEEA9wDJ
 mHYET
X-Gm-Gg: AfdE7cnLrMsI47LMi8Ljdju9ka4jR4/cAYUPztGsSCGTQm4AxyPqnJQZL+lIVF1GPNe
 jmInIygWwAGgsEKvg0PBzsyMHnPMFBEgQgkMZQtrzVVaWcElbo5v3VGYfMGTbvZrafs3mJ6nPao
 5YuOyi1MV/bpfHtiLBTvpH2vFmhUNFkK1fZH5TsXBC8fy8itoGDb5vEi3rFlMMT7f6QGIwgXLPT
 inRth5CYTiVv7RkP6glUg5P+qKYI66rBxZACPoHb4xLz1D86dcPSbcVPAJP6Ev2PyfxrboBb1p6
 ow2q2CSQjvIM39OkYxeW6Wa2/rkImzLnsVlbUnylSRBNRJhkDI6rnZWmQxfS8yyTMdJAD+fhpup
 LqCUr9TdqdpyM7UKH5T9VAGk8P85RKuDt81Qj0ipqGvhE8ZqakfgLHFXNXsTiDOijMT1BfE0OrN
 Agg3pmtss72bGEQuh+ekH6Wc0GPu9b
X-Received: by 2002:a17:90b:3f0c:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-38e1ae634a3mr70201a91.1.1783983771970; 
 Mon, 13 Jul 2026 16:02:51 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/10] target/arm: Implement [SU]TMOPA (2-way)
Date: Mon, 13 Jul 2026 16:02:42 -0700
Message-ID: <20260713230244.70174-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713230244.70174-1-richard.henderson@linaro.org>
References: <20260713230244.70174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/tcg/helper-sme-defs.h |  3 +++
 target/arm/tcg/sme_helper.c      | 12 ++++++++++++
 target/arm/tcg/translate-sme.c   | 21 +++++++++++++++++++++
 target/arm/tcg/sme.decode        |  3 +++
 4 files changed, 39 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8a959447b2..1de72b7472 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -411,3 +411,6 @@ DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fps
 
 DEF_HELPER_FLAGS_6(sme_bftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_stmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme_utmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3d7aefac5b..951cbbf58e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -3123,6 +3123,18 @@ IMOP4_2WAY(umop4s_sh, -, int32_t, uint16_t, uint16_t)
 
 #undef IMOP4_2WAY
 
+#define ITMOP_2WAY(TNAME, MNAME)                                        \
+void HELPER(sme_##TNAME)(void *vza, void *vzn, void *vzm,               \
+                         void *vzk, uint32_t desc)                      \
+{                                                                       \
+    sme_tmop_2way_sh(vza, vzn, vzm, vzk, NULL, desc, inner_##MNAME);    \
+}
+
+ITMOP_2WAY(stmopa_sh, smop4a_sh)
+ITMOP_2WAY(utmopa_sh, umop4a_sh)
+
+#undef ITMOP_2WAY
+
 #define IMOP4_4WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
 static void inner_##NAME(void *vd, void *vn, void *vm, void *vinfo)     \
 {                                                                       \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0fda2d9ac5..9c641de5c0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2181,3 +2181,24 @@ TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
            a, MO_16, gen_helper_sme_ftmopa_hb)
 TRANS_FEAT(FTMOPA_sb, aa64_sme_tmop_f8f32, do_tmop_fp8,
            a, MO_32, gen_helper_sme_ftmopa_sb)
+
+static bool do_tmop_int(DisasContext *s, arg_tmop *a, MemOp esz,
+                        gen_helper_gvec_4 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, a->idx);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr zk = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, zk, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(STMOPA_sh, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_stmopa_sh)
+TRANS_FEAT(UTMOPA_sh, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_utmopa_sh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index eab1f7e8fb..08036c60c0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1151,3 +1151,6 @@ FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_sb       1000 0000 011 ..... 000 ... .... .. 00 ..       @tmop_o2
+
+STMOPA_sh       1000 0000 010 ..... 100 ... .... .. 10 ..       @tmop_o2
+UTMOPA_sh       1000 0001 010 ..... 100 ... .... .. 10 ..       @tmop_o2
-- 
2.43.0


