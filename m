Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E485DCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPT6-0002la-Hp; Sat, 16 May 2026 20:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSJ-0007BA-UD
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSD-0006sN-Q5
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:05 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso443910a91.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978039; x=1779582839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqM0kwivlcqgiKDIp6aI8NDlZBpv/udHWgNE0+iVW9I=;
 b=IW9JYn6/n+HBDcdu86xKKyZsde3ErwEBp7H8FHnogceKLeOX/XaY6TiekW3yfPjOYU
 0092xrErWUcwH8tN2Szt5EbzG/wQZ0ktSYzdXZ0LpyrKQLnkd9KEBOOfZhUDHe0Hnr/O
 gtCMMbwRavdRIEd7dTOk4uOehvSi1oF5ovUUPwmnzB1I+tb3H8a/JJ8Jd8eMhQDD/+VT
 m9VaAhZxRh6X5YG2BuXkV6Mr0uCBHGsdk2XkXUPK/eLlvvCXpfSj1Hxs6QZU9dBC4BAO
 GF2GRn83sSalpBmWAwEIE4TUlGJYqOjanOtq8yP4Fg8+VhXUM9rTG1LFA7qhd9W0od3w
 JFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978039; x=1779582839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqM0kwivlcqgiKDIp6aI8NDlZBpv/udHWgNE0+iVW9I=;
 b=hZsu/sPA32GDtYYgt1RwrABsVfb8W+R0mQTZAaqyoPgir9ZyjFUl2flyATZSwxQpV8
 gB5Zy7s2cfHkO77tWMI1n8fOaIRw9mv+LLJv1hKW5RdpJb7D4tBN1StzUTlnbnH/UAfG
 01whfj6Yqi0CiDt5/AFkQvflXzTfLdbmxIayLYBDDx+5XULoOUu2lw+CdeD42POw7BJT
 dbDmrgQleUuSv3tfLnV8uAgb7gkcteq/BOuzjUlUbln3bvstZflkcwvxp8pTS/D8AM2E
 qAjsoZDXIOhKrHoywjGmfedVn8v98pQNQqjk/Hcfo89pOYgY1hFu8grk372NG9z80dYZ
 9Xvw==
X-Gm-Message-State: AOJu0YxXg0OwBC81sq7KUiRefN+pgdZV56JZAm1Wg5ReFzAfu+lhAi3Y
 3g7AezVyCaUPXrrbgWuNQu+TA8ln9+G4ciX0aYLY2s99aUo54YATFsFScNdDSILfUsx5uah3pyR
 cQCdx
X-Gm-Gg: Acq92OF2c2QHKLiN/O+VmETVrr/vcfrdrKRkoJHtPuoXoCaCI+ezZL2r4k8EXTTiThT
 C55GgCIdyvsDopGiW+X/ZBUelzQ0XZfO6mc3L41zXkukDsJRyFlDmCZw3KsuLx7voQuQwI7jzBu
 RosSFm+Isq0pxacjxE62tL0Wrj1jN3lloHVkylrR6f2urvJK9eZeTDzLykiv5AADZRqErV8PA/k
 dwtg7es6s2MsxVFSlh41qa6Giy+W1/JRjXngZWlg0NnHW9VM/doenoYUjPDa5sgARJ6GofZY1wm
 kOd23SbZzsMJmBdyMK9F/yWeUlNmui6dS4Z2K5ZtEp2/7DK1xzQJlMbzBuW7NZAt34pCfewUOVY
 3nmijL0ee9jjhZH7LDA9n8Sxl+8uUb8yTuxniIecZV1yQQtj8ntHMzKr7KFv6DNn/UGE0NiHH9s
 MXqiPtWaaR1z+Lz/mKb+SWxI5W60t9
X-Received: by 2002:a17:90b:33cd:b0:368:7536:b5b7 with SMTP id
 98e67ed59e1d1-36951b71e46mr9674376a91.16.1778978039240; 
 Sat, 16 May 2026 17:33:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 59/63] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Sat, 16 May 2026 17:29:58 -0700
Message-ID: <20260517003002.321430-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 34 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8f6cc2974f..fce38dfbb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1625,6 +1625,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index bb1d48c3e0..d5d1fe71c5 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -849,3 +849,29 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
     fp8_mul_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
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
index 02d5e007f9..aff0f332ac 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7419,6 +7419,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6404c26540..e7f2f30abb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1217,6 +1217,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


