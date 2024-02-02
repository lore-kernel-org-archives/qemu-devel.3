Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42AEC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWp-0007I4-Ez; Fri, 02 Feb 2024 00:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWk-0007Cv-SM
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:50 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWh-0003XZ-Ar
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d7881b1843so14574395ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853346; x=1707458146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KteVrj8gst013uyEXcP3e0N3hZHJ2ci9f+j/2/rpEZc=;
 b=hhFcpSBpUS7cZfLiMhSZXQJkotr+tSJmE+HIBBb64TsVm7FbwKUwIsQqWuAWPO9iLQ
 Q/UyOFRHzprRbpZ2fW95xt94XDnB+w3dDKteluOo6NUp0do6DEzTPXKD6rJhRzKI8E3c
 +ouryT3V3NGzdF+iZClOJaSnFhO0GPHDxbTwffa3HttY09Z6I0oCas5OcREo/1NHIoLJ
 fUvcG4fDtYyTbl/7v9qW1MiuFlsiWiEv+wp7embQusllBB0+hwHLGWNEpwqHSUXbJ/wG
 bB0UWGvGPmpTdxv1648SM8jry/ymUZjW1CFXm3rxBftON7wvkNj8Ru4o36U2s1f06MtF
 WonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853346; x=1707458146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KteVrj8gst013uyEXcP3e0N3hZHJ2ci9f+j/2/rpEZc=;
 b=lJjBwTqD/iUu3Zw+nV88uBEKQAdUCPZGSbQO5/uF4sNJx6q5cnm0KcMjyKxa1aXSDp
 beW847o1Y4w5F+DDRlm1VTCqICRerV1/G/YwIm/WyMPchh8LxFrH22JxniOwv5m1Lofn
 yr/t7TbKwGJB4c1eDEKRIvMag5OwjEJCks2BiAej017Nm8irn1omuxqs4mGOJpzA7y4O
 mP16fSA1TOp4drjwlWi1lIR/nphkp5e0RlFC8nomU8Pl0PjyCYABMAkivJL1/CN/ccrR
 4NmiYV+z62LHMUif647to/k3NSTfcmSjnM/Q5Crt/S6X4+IQVlzhzQrOQIbeLFZHkFBp
 Sw6g==
X-Gm-Message-State: AOJu0YxIHraCs1GU+pXsxbN3+lYs5yIrEdP9ilA1eTrAlwu4M9w60ZwU
 FjA7tTAxAMA8yyRBsrRHrFLyD/EYMki213DeJsZoQQg/B8oDk7/dM8M74YOv6Zckw9eisvWpfFx
 /FoY=
X-Google-Smtp-Source: AGHT+IEJ30lbbjkVxbXFXxg2WtpfZLKdlkpadrQA67dc90cJMaa8WDslvzfl+FbqTYND4gi1N5xYJg==
X-Received: by 2002:a17:902:fc85:b0:1d9:6e29:ea86 with SMTP id
 mf5-20020a170902fc8500b001d96e29ea86mr1538662plb.64.1706853346029; 
 Thu, 01 Feb 2024 21:55:46 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 56/57] target/sparc: Split fcc out of env->fsr
Date: Fri,  2 Feb 2024 15:50:35 +1000
Message-Id: <20240202055036.684176-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Represent each fcc field separately from the rest of fsr.
This vastly simplifies floating-point comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-22-richard.henderson@linaro.org>
---
 target/sparc/cpu.h        |  20 +-
 target/sparc/helper.h     |  34 +--
 target/sparc/fop_helper.c | 169 ++++++-------
 target/sparc/translate.c  | 503 +++++++++-----------------------------
 4 files changed, 201 insertions(+), 525 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index c5be9e37de..986c7217ed 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -31,8 +31,10 @@
 
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
+#define TARGET_FCCREGS 1
 #else
 #define TARGET_DPREGS 32
+#define TARGET_FCCREGS 4
 #endif
 
 /*#define EXCP_INTERRUPT 0x100*/
@@ -203,24 +205,19 @@ enum {
 #ifdef TARGET_SPARC64
 #define FSR_FTT_NMASK      0xfffffffffffe3fffULL
 #define FSR_FTT_CEXC_NMASK 0xfffffffffffe3fe0ULL
-#define FSR_LDFSR_OLDMASK  0x0000003f000fc000ULL
-#define FSR_LDXFSR_MASK    0x0000003fcfc00fffULL
-#define FSR_LDXFSR_OLDMASK 0x00000000000fc000ULL
 #else
 #define FSR_FTT_NMASK      0xfffe3fffULL
 #define FSR_FTT_CEXC_NMASK 0xfffe3fe0ULL
-#define FSR_LDFSR_OLDMASK  0x000fc000ULL
 #endif
-#define FSR_LDFSR_MASK     0xcfc00fffULL
 #define FSR_FTT_IEEE_EXCP (1ULL << 14)
 #define FSR_FTT_UNIMPFPOP (3ULL << 14)
 #define FSR_FTT_SEQ_ERROR (4ULL << 14)
 #define FSR_FTT_INVAL_FPR (6ULL << 14)
 
-#define FSR_FCC1_SHIFT 11
-#define FSR_FCC1  (1ULL << FSR_FCC1_SHIFT)
-#define FSR_FCC0_SHIFT 10
-#define FSR_FCC0  (1ULL << FSR_FCC0_SHIFT)
+#define FSR_FCC0_SHIFT    10
+#define FSR_FCC1_SHIFT    32
+#define FSR_FCC2_SHIFT    34
+#define FSR_FCC3_SHIFT    36
 
 /* MMU */
 #define MMU_E     (1<<0)
@@ -467,8 +464,9 @@ struct CPUArchState {
                           temporary register when possible) */
 
     /* FPU State Register, in parts */
-    target_ulong fsr;       /* rm, tem, aexc, fcc* */
-    uint32_t fsr_cexc_ftt;  /* cexc, ftt */
+    uint32_t fsr;                    /* rm, tem, aexc */
+    uint32_t fsr_cexc_ftt;           /* cexc, ftt */
+    uint32_t fcc[TARGET_FCCREGS];    /* fcc* */
 
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
     uint32_t cwp;      /* index of current register window (extracted
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index c8e14fe371..6a42ba4e9e 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -36,36 +36,16 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
-DEF_HELPER_FLAGS_2(set_fsr_noftt, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(set_fsr_nofcc_noftt, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_WG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_WG, f64, env, f64)
 DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_WG, i128, env, i128)
-DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, void, env, i128, i128)
-#ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc3, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd_fcc1, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc2, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc3, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes_fcc1, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc2, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, void, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpq_fcc1, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc2, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc3, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc1, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc2, TCG_CALL_NO_WG, void, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc3, TCG_CALL_NO_WG, void, env, i128, i128)
-#endif
+DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, i32, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, i32, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 796f448bfd..1205a599ef 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -343,113 +343,80 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
     return f128_ret(ret);
 }
 
-#define GEN_FCMP(name, size, FS, E)                                     \
-    void glue(helper_, name)(CPUSPARCState *env, Int128 src1, Int128 src2) \
-    {                                                                   \
-        float128 reg1 = f128_in(src1);                                  \
-        float128 reg2 = f128_in(src2);                                  \
-        FloatRelation ret;                                              \
-        target_ulong fsr;                                               \
-        if (E) {                                                        \
-            ret = glue(size, _compare)(reg1, reg2, &env->fp_status);    \
-        } else {                                                        \
-            ret = glue(size, _compare_quiet)(reg1, reg2,                \
-                                             &env->fp_status);          \
-        }                                                               \
-        check_ieee_exceptions(env, GETPC());                            \
-        fsr = env->fsr;                                                 \
-        switch (ret) {                                                  \
-        case float_relation_unordered:                                  \
-            fsr |= (FSR_FCC1 | FSR_FCC0) << FS;                         \
-            fsr |= FSR_NVA;                                             \
-            break;                                                      \
-        case float_relation_less:                                       \
-            fsr &= ~(FSR_FCC1) << FS;                                   \
-            fsr |= FSR_FCC0 << FS;                                      \
-            break;                                                      \
-        case float_relation_greater:                                    \
-            fsr &= ~(FSR_FCC0) << FS;                                   \
-            fsr |= FSR_FCC1 << FS;                                      \
-            break;                                                      \
-        default:                                                        \
-            fsr &= ~((FSR_FCC1 | FSR_FCC0) << FS);                      \
-            break;                                                      \
-        }                                                               \
-        env->fsr = fsr;                                                 \
-    }
-#define GEN_FCMP_T(name, size, FS, E)                                   \
-    void glue(helper_, name)(CPUSPARCState *env, size src1, size src2)  \
-    {                                                                   \
-        FloatRelation ret;                                              \
-        target_ulong fsr;                                               \
-        if (E) {                                                        \
-            ret = glue(size, _compare)(src1, src2, &env->fp_status);    \
-        } else {                                                        \
-            ret = glue(size, _compare_quiet)(src1, src2,                \
-                                             &env->fp_status);          \
-        }                                                               \
-        check_ieee_exceptions(env, GETPC());                            \
-        fsr = env->fsr;                                                 \
-        switch (ret) {                                                  \
-        case float_relation_unordered:                                  \
-            fsr |= (FSR_FCC1 | FSR_FCC0) << FS;                         \
-            break;                                                      \
-        case float_relation_less:                                       \
-            fsr &= ~(FSR_FCC1 << FS);                                   \
-            fsr |= FSR_FCC0 << FS;                                      \
-            break;                                                      \
-        case float_relation_greater:                                    \
-            fsr &= ~(FSR_FCC0 << FS);                                   \
-            fsr |= FSR_FCC1 << FS;                                      \
-            break;                                                      \
-        default:                                                        \
-            fsr &= ~((FSR_FCC1 | FSR_FCC0) << FS);                      \
-            break;                                                      \
-        }                                                               \
-        env->fsr = fsr;                                                 \
+static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
+{
+    check_ieee_exceptions(env, ra);
+
+    /*
+     * FCC values:
+     * 0 =
+     * 1 <
+     * 2 >
+     * 3 unordered
+     */
+    switch (r) {
+    case float_relation_equal:
+        return 0;
+    case float_relation_less:
+        return 1;
+    case float_relation_greater:
+        return 2;
+    case float_relation_unordered:
+        env->fsr |= FSR_NVA;
+        return 3;
     }
+    g_assert_not_reached();
+}
 
-GEN_FCMP_T(fcmps, float32, 0, 0);
-GEN_FCMP_T(fcmpd, float64, 0, 0);
+uint32_t helper_fcmps(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    FloatRelation r = float32_compare_quiet(src1, src2, &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
-GEN_FCMP_T(fcmpes, float32, 0, 1);
-GEN_FCMP_T(fcmped, float64, 0, 1);
+uint32_t helper_fcmpes(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    FloatRelation r = float32_compare(src1, src2, &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
-GEN_FCMP(fcmpq, float128, 0, 0);
-GEN_FCMP(fcmpeq, float128, 0, 1);
+uint32_t helper_fcmpd(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    FloatRelation r = float64_compare_quiet(src1, src2, &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
-#ifdef TARGET_SPARC64
-GEN_FCMP_T(fcmps_fcc1, float32, 22, 0);
-GEN_FCMP_T(fcmpd_fcc1, float64, 22, 0);
-GEN_FCMP(fcmpq_fcc1, float128, 22, 0);
+uint32_t helper_fcmped(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    FloatRelation r = float64_compare(src1, src2, &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
-GEN_FCMP_T(fcmps_fcc2, float32, 24, 0);
-GEN_FCMP_T(fcmpd_fcc2, float64, 24, 0);
-GEN_FCMP(fcmpq_fcc2, float128, 24, 0);
+uint32_t helper_fcmpq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    FloatRelation r = float128_compare_quiet(f128_in(src1), f128_in(src2),
+                                             &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
-GEN_FCMP_T(fcmps_fcc3, float32, 26, 0);
-GEN_FCMP_T(fcmpd_fcc3, float64, 26, 0);
-GEN_FCMP(fcmpq_fcc3, float128, 26, 0);
-
-GEN_FCMP_T(fcmpes_fcc1, float32, 22, 1);
-GEN_FCMP_T(fcmped_fcc1, float64, 22, 1);
-GEN_FCMP(fcmpeq_fcc1, float128, 22, 1);
-
-GEN_FCMP_T(fcmpes_fcc2, float32, 24, 1);
-GEN_FCMP_T(fcmped_fcc2, float64, 24, 1);
-GEN_FCMP(fcmpeq_fcc2, float128, 24, 1);
-
-GEN_FCMP_T(fcmpes_fcc3, float32, 26, 1);
-GEN_FCMP_T(fcmped_fcc3, float64, 26, 1);
-GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
-#endif
-#undef GEN_FCMP_T
-#undef GEN_FCMP
+uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
+{
+    FloatRelation r = float128_compare(f128_in(src1), f128_in(src2),
+                                       &env->fp_status);
+    return finish_fcmp(env, r, GETPC());
+}
 
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
     target_ulong fsr = env->fsr | env->fsr_cexc_ftt;
 
+    fsr |= env->fcc[0] << FSR_FCC0_SHIFT;
+#ifdef TARGET_SPARC64
+    fsr |= (uint64_t)env->fcc[1] << FSR_FCC1_SHIFT;
+    fsr |= (uint64_t)env->fcc[2] << FSR_FCC2_SHIFT;
+    fsr |= (uint64_t)env->fcc[3] << FSR_FCC3_SHIFT;
+#endif
+
     /* VER is kept completely separate until re-assembly. */
     fsr |= env->def.fpu_version;
 
@@ -465,7 +432,7 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 {
     int rnd_mode;
 
-    env->fsr = fsr & ~(FSR_VER_MASK | FSR_CEXC_MASK | FSR_FTT_MASK);
+    env->fsr = fsr & (FSR_RD_MASK | FSR_TEM_MASK | FSR_AEXC_MASK);
 
     switch (fsr & FSR_RD_MASK) {
     case FSR_RD_NEAREST:
@@ -488,10 +455,18 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
 {
     env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
+
+    env->fcc[0] = extract32(fsr, FSR_FCC0_SHIFT, 2);
+#ifdef TARGET_SPARC64
+    env->fcc[1] = extract64(fsr, FSR_FCC1_SHIFT, 2);
+    env->fcc[2] = extract64(fsr, FSR_FCC2_SHIFT, 2);
+    env->fcc[3] = extract64(fsr, FSR_FCC3_SHIFT, 2);
+#endif
+
     set_fsr_nonsplit(env, fsr);
 }
 
-void helper_set_fsr_noftt(CPUSPARCState *env, target_ulong fsr)
+void helper_set_fsr_nofcc_noftt(CPUSPARCState *env, uint32_t fsr)
 {
     env->fsr_cexc_ftt &= FSR_FTT_MASK;
     env->fsr_cexc_ftt |= fsr & FSR_CEXC_MASK;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cf8cfe5cc4..7df6f83b13 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -83,8 +83,6 @@
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
-# define FSR_LDXFSR_MASK                        0
-# define FSR_LDXFSR_OLDMASK                     0
 # define MAXTL_MASK                             0
 #endif
 
@@ -130,6 +128,7 @@ static TCGv cpu_gsr;
 
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
+static TCGv_i32 cpu_fcc[TARGET_FCCREGS];
 
 #define env_field_offsetof(X)     offsetof(CPUSPARCState, X)
 #ifdef TARGET_SPARC64
@@ -719,159 +718,6 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
-// 1
-static void gen_op_eval_ba(TCGv dst)
-{
-    tcg_gen_movi_tl(dst, 1);
-}
-
-// 0
-static void gen_op_eval_bn(TCGv dst)
-{
-    tcg_gen_movi_tl(dst, 0);
-}
-
-/*
-  FPSR bit field FCC1 | FCC0:
-   0 =
-   1 <
-   2 >
-   3 unordered
-*/
-static void gen_mov_reg_FCC0(TCGv reg, TCGv src,
-                                    unsigned int fcc_offset)
-{
-    tcg_gen_shri_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
-}
-
-static void gen_mov_reg_FCC1(TCGv reg, TCGv src, unsigned int fcc_offset)
-{
-    tcg_gen_shri_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
-}
-
-// !0: FCC0 | FCC1
-static void gen_op_eval_fbne(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_or_tl(dst, dst, t0);
-}
-
-// 1 or 2: FCC0 ^ FCC1
-static void gen_op_eval_fblg(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_xor_tl(dst, dst, t0);
-}
-
-// 1 or 3: FCC0
-static void gen_op_eval_fbul(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-}
-
-// 1: FCC0 & !FCC1
-static void gen_op_eval_fbl(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_andc_tl(dst, dst, t0);
-}
-
-// 2 or 3: FCC1
-static void gen_op_eval_fbug(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    gen_mov_reg_FCC1(dst, src, fcc_offset);
-}
-
-// 2: !FCC0 & FCC1
-static void gen_op_eval_fbg(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_andc_tl(dst, t0, dst);
-}
-
-// 3: FCC0 & FCC1
-static void gen_op_eval_fbu(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_and_tl(dst, dst, t0);
-}
-
-// 0: !(FCC0 | FCC1)
-static void gen_op_eval_fbe(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_or_tl(dst, dst, t0);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// 0 or 3: !(FCC0 ^ FCC1)
-static void gen_op_eval_fbue(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_xor_tl(dst, dst, t0);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// 0 or 2: !FCC0
-static void gen_op_eval_fbge(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !1: !(FCC0 & !FCC1)
-static void gen_op_eval_fbuge(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_andc_tl(dst, dst, t0);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// 0 or 1: !FCC1
-static void gen_op_eval_fble(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    gen_mov_reg_FCC1(dst, src, fcc_offset);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !2: !(!FCC0 & FCC1)
-static void gen_op_eval_fbule(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_andc_tl(dst, t0, dst);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
-// !3: !(FCC0 & FCC1)
-static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
-{
-    TCGv t0 = tcg_temp_new();
-    gen_mov_reg_FCC0(dst, src, fcc_offset);
-    gen_mov_reg_FCC1(t0, src, fcc_offset);
-    tcg_gen_and_tl(dst, dst, t0);
-    tcg_gen_xori_tl(dst, dst, 0x1);
-}
-
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -1096,82 +942,62 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
 static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
 {
-    unsigned int offset;
-    TCGv r_dst, fsr;
+    TCGv_i32 fcc = cpu_fcc[cc];
+    TCGv_i32 c1 = fcc;
+    int c2 = 0;
+    TCGCond tcond;
 
-    /* For now we still generate a straight boolean result.  */
-    cmp->cond = TCG_COND_NE;
-    cmp->c1 = r_dst = tcg_temp_new();
-    cmp->c2 = 0;
-
-    switch (cc) {
-    default:
-    case 0x0:
-        offset = 0;
+    /*
+     * FCC values:
+     * 0 =
+     * 1 <
+     * 2 >
+     * 3 unordered
+     */
+    switch (cond & 7) {
+    case 0x0: /* fbn */
+        tcond = TCG_COND_NEVER;
         break;
-    case 0x1:
-        offset = 32 - 10;
+    case 0x1: /* fbne : !0 */
+        tcond = TCG_COND_NE;
         break;
-    case 0x2:
-        offset = 34 - 10;
+    case 0x2: /* fblg : 1 or 2 */
+        /* fcc in {1,2} - 1 -> fcc in {0,1} */
+        c1 = tcg_temp_new_i32();
+        tcg_gen_addi_i32(c1, fcc, -1);
+        c2 = 1;
+        tcond = TCG_COND_LEU;
         break;
-    case 0x3:
-        offset = 36 - 10;
+    case 0x3: /* fbul : 1 or 3 */
+        c1 = tcg_temp_new_i32();
+        tcg_gen_andi_i32(c1, fcc, 1);
+        tcond = TCG_COND_NE;
+        break;
+    case 0x4: /* fbl  : 1 */
+        c2 = 1;
+        tcond = TCG_COND_EQ;
+        break;
+    case 0x5: /* fbug : 2 or 3 */
+        c2 = 2;
+        tcond = TCG_COND_GEU;
+        break;
+    case 0x6: /* fbg  : 2 */
+        c2 = 2;
+        tcond = TCG_COND_EQ;
+        break;
+    case 0x7: /* fbu  : 3 */
+        c2 = 3;
+        tcond = TCG_COND_EQ;
         break;
     }
-
-    fsr = tcg_temp_new();
-    tcg_gen_ld_tl(fsr, tcg_env, offsetof(CPUSPARCState, fsr));
-    switch (cond) {
-    case 0x0:
-        gen_op_eval_bn(r_dst);
-        break;
-    case 0x1:
-        gen_op_eval_fbne(r_dst, fsr, offset);
-        break;
-    case 0x2:
-        gen_op_eval_fblg(r_dst, fsr, offset);
-        break;
-    case 0x3:
-        gen_op_eval_fbul(r_dst, fsr, offset);
-        break;
-    case 0x4:
-        gen_op_eval_fbl(r_dst, fsr, offset);
-        break;
-    case 0x5:
-        gen_op_eval_fbug(r_dst, fsr, offset);
-        break;
-    case 0x6:
-        gen_op_eval_fbg(r_dst, fsr, offset);
-        break;
-    case 0x7:
-        gen_op_eval_fbu(r_dst, fsr, offset);
-        break;
-    case 0x8:
-        gen_op_eval_ba(r_dst);
-        break;
-    case 0x9:
-        gen_op_eval_fbe(r_dst, fsr, offset);
-        break;
-    case 0xa:
-        gen_op_eval_fbue(r_dst, fsr, offset);
-        break;
-    case 0xb:
-        gen_op_eval_fbge(r_dst, fsr, offset);
-        break;
-    case 0xc:
-        gen_op_eval_fbuge(r_dst, fsr, offset);
-        break;
-    case 0xd:
-        gen_op_eval_fble(r_dst, fsr, offset);
-        break;
-    case 0xe:
-        gen_op_eval_fbule(r_dst, fsr, offset);
-        break;
-    case 0xf:
-        gen_op_eval_fbo(r_dst, fsr, offset);
-        break;
+    if (cond & 8) {
+        tcond = tcg_invert_cond(tcond);
     }
+
+    cmp->cond = tcond;
+    cmp->c2 = c2;
+    cmp->c1 = tcg_temp_new();
+    tcg_gen_extu_i32_tl(cmp->c1, c1);
 }
 
 static bool gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
@@ -1261,148 +1087,6 @@ static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
     tcg_gen_concat_i64_i128(dst, l, h);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmps(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmps_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmps_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmps_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmpd(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmpd_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmpd_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmpd_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmpq(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmpq_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmpq_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmpq_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-static void gen_op_fcmpes(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmpes(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmpes_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmpes_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmpes_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmped(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmped_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmped_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmped_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
-{
-    switch (fccno) {
-    case 0:
-        gen_helper_fcmpeq(tcg_env, r_rs1, r_rs2);
-        break;
-    case 1:
-        gen_helper_fcmpeq_fcc1(tcg_env, r_rs1, r_rs2);
-        break;
-    case 2:
-        gen_helper_fcmpeq_fcc2(tcg_env, r_rs1, r_rs2);
-        break;
-    case 3:
-        gen_helper_fcmpeq_fcc3(tcg_env, r_rs1, r_rs2);
-        break;
-    }
-}
-
-#else
-
-static void gen_op_fcmps(int fccno, TCGv r_rs1, TCGv r_rs2)
-{
-    gen_helper_fcmps(tcg_env, r_rs1, r_rs2);
-}
-
-static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
-{
-    gen_helper_fcmpd(tcg_env, r_rs1, r_rs2);
-}
-
-static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
-{
-    gen_helper_fcmpq(tcg_env, r_rs1, r_rs2);
-}
-
-static void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
-{
-    gen_helper_fcmpes(tcg_env, r_rs1, r_rs2);
-}
-
-static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
-{
-    gen_helper_fcmped(tcg_env, r_rs1, r_rs2);
-}
-
-static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
-{
-    gen_helper_fcmpeq(tcg_env, r_rs1, r_rs2);
-}
-#endif
-
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
 {
     /*
@@ -4400,11 +4084,10 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
     return true;
 }
 
-static bool do_ldfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop,
-                     target_ulong new_mask, target_ulong old_mask)
+static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
-    TCGv tnew, told;
+    TCGv_i32 tmp;
 
     if (addr == NULL) {
         return false;
@@ -4412,19 +4095,48 @@ static bool do_ldfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop,
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    tnew = tcg_temp_new();
-    told = tcg_temp_new();
-    tcg_gen_qemu_ld_tl(tnew, addr, dc->mem_idx, mop | MO_ALIGN);
-    tcg_gen_ld_tl(told, tcg_env, offsetof(CPUSPARCState, fsr));
-    tcg_gen_andi_tl(tnew, tnew, new_mask);
-    tcg_gen_andi_tl(told, told, old_mask);
-    tcg_gen_or_tl(tnew, tnew, told);
-    gen_helper_set_fsr_noftt(tcg_env, tnew);
+
+    tmp = tcg_temp_new_i32();
+    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
+
+    tcg_gen_extract_i32(cpu_fcc[0], tmp, FSR_FCC0_SHIFT, 2);
+    /* LDFSR does not change FCC[1-3]. */
+
+    gen_helper_set_fsr_nofcc_noftt(tcg_env, tmp);
     return advance_pc(dc);
 }
 
-TRANS(LDFSR, ALL, do_ldfsr, a, MO_TEUL, FSR_LDFSR_MASK, FSR_LDFSR_OLDMASK)
-TRANS(LDXFSR, 64, do_ldfsr, a, MO_TEUQ, FSR_LDXFSR_MASK, FSR_LDXFSR_OLDMASK)
+static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
+{
+#ifdef TARGET_SPARC64
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    TCGv_i64 t64;
+    TCGv_i32 lo, hi;
+
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    t64 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(t64, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
+
+    lo = tcg_temp_new_i32();
+    hi = cpu_fcc[3];
+    tcg_gen_extr_i64_i32(lo, hi, t64);
+    tcg_gen_extract_i32(cpu_fcc[0], lo, FSR_FCC0_SHIFT, 2);
+    tcg_gen_extract_i32(cpu_fcc[1], hi, FSR_FCC1_SHIFT - 32, 2);
+    tcg_gen_extract_i32(cpu_fcc[2], hi, FSR_FCC2_SHIFT - 32, 2);
+    tcg_gen_extract_i32(cpu_fcc[3], hi, FSR_FCC3_SHIFT - 32, 2);
+
+    gen_helper_set_fsr_nofcc_noftt(tcg_env, lo);
+    return advance_pc(dc);
+#else
+    return false;
+#endif
+}
 
 static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 {
@@ -5075,9 +4787,9 @@ static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     if (e) {
-        gen_op_fcmpes(a->cc, src1, src2);
+        gen_helper_fcmpes(cpu_fcc[a->cc], tcg_env, src1, src2);
     } else {
-        gen_op_fcmps(a->cc, src1, src2);
+        gen_helper_fcmps(cpu_fcc[a->cc], tcg_env, src1, src2);
     }
     return advance_pc(dc);
 }
@@ -5099,9 +4811,9 @@ static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     if (e) {
-        gen_op_fcmped(a->cc, src1, src2);
+        gen_helper_fcmped(cpu_fcc[a->cc], tcg_env, src1, src2);
     } else {
-        gen_op_fcmpd(a->cc, src1, src2);
+        gen_helper_fcmpd(cpu_fcc[a->cc], tcg_env, src1, src2);
     }
     return advance_pc(dc);
 }
@@ -5126,9 +4838,9 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     if (e) {
-        gen_op_fcmpeq(a->cc, src1, src2);
+        gen_helper_fcmpeq(cpu_fcc[a->cc], tcg_env, src1, src2);
     } else {
-        gen_op_fcmpq(a->cc, src1, src2);
+        gen_helper_fcmpq(cpu_fcc[a->cc], tcg_env, src1, src2);
     }
     return advance_pc(dc);
 }
@@ -5334,6 +5046,18 @@ void sparc_tcg_init(void)
         "f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",
     };
 
+    static const struct { TCGv_i32 *ptr; int off; const char *name; } r32[] = {
+#ifdef TARGET_SPARC64
+        { &cpu_fprs, offsetof(CPUSPARCState, fprs), "fprs" },
+        { &cpu_fcc[0], offsetof(CPUSPARCState, fcc[0]), "fcc0" },
+        { &cpu_fcc[1], offsetof(CPUSPARCState, fcc[1]), "fcc1" },
+        { &cpu_fcc[2], offsetof(CPUSPARCState, fcc[2]), "fcc2" },
+        { &cpu_fcc[3], offsetof(CPUSPARCState, fcc[3]), "fcc3" },
+#else
+        { &cpu_fcc[0], offsetof(CPUSPARCState, fcc[0]), "fcc" },
+#endif
+    };
+
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
 #ifdef TARGET_SPARC64
         { &cpu_gsr, offsetof(CPUSPARCState, gsr), "gsr" },
@@ -5357,6 +5081,10 @@ void sparc_tcg_init(void)
                                          offsetof(CPUSPARCState, regwptr),
                                          "regwptr");
 
+    for (i = 0; i < ARRAY_SIZE(r32); ++i) {
+        *r32[i].ptr = tcg_global_mem_new_i32(tcg_env, r32[i].off, r32[i].name);
+    }
+
     for (i = 0; i < ARRAY_SIZE(rtl); ++i) {
         *rtl[i].ptr = tcg_global_mem_new(tcg_env, rtl[i].off, rtl[i].name);
     }
@@ -5379,11 +5107,6 @@ void sparc_tcg_init(void)
                                             offsetof(CPUSPARCState, fpr[i]),
                                             fregnames[i]);
     }
-
-#ifdef TARGET_SPARC64
-    cpu_fprs = tcg_global_mem_new_i32(tcg_env,
-                                      offsetof(CPUSPARCState, fprs), "fprs");
-#endif
 }
 
 void sparc_restore_state_to_opc(CPUState *cs,
-- 
2.34.1


