Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3CBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mqe-0003sv-SG; Sun, 05 May 2024 21:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mps-0008Bn-QZ
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:08:12 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpZ-0003Nd-S4
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:08:01 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-23f5a31d948so592611fac.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957668; x=1715562468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpXjS9tobDhG3l17XoJprAZ2Q1ufWgiGLdE8QhqEwo4=;
 b=AtJeqHJpeTausUsBogbBa9hSlDDNEKeM+A5Lq5sgN3fbL3YpAWKim7Wds5xtL/5e3F
 AzzepyEqm653kq4h2sOLu0GIkdp1uqF9sUnGgD0os50LAXwMrrYWeQfAakW1AisrOlKK
 suASoWu4U6mHQ0OPl2Cl4TqSJ/WH4BAH1OmbmVSZ2frqNhS8t5EQ6RK1qKNpWNKWsOX/
 5gIrzCeYCKpAdEzuMOpzTJePAhPRd8BaHeBeRBS5aaU4sqU9F2CVt5L2xCrG/WCDSS6h
 xN0C44CpN4HmwTgMCajvDoUKSwTb5xws0xfiZL+CcYNZ/YjmKZBcGmGE4ThTUfOgyPxj
 7yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957668; x=1715562468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpXjS9tobDhG3l17XoJprAZ2Q1ufWgiGLdE8QhqEwo4=;
 b=PdUHWQAGszValp6ttn+HkTSfaBlQCmGrjGpEatHsVsqlZ1WjhRhrt81YTMVu4y/oYJ
 p4yGpLSrE0SzmDvYo5Yy3ZpecaSfMH194ZNxs/3kVMiIHVIO8SyoNb8xg2Lrv3ok8YZu
 /RNZVRUAl5EOFm6wd/5QC4v1j433LHXUDK4wZKbNNBfw+17O/6XYOz5TwlxuzCxGYauC
 Lor/VFkv+sHdKjjtO8w+3rDNzfPkT4Em9I8c4g43tCt7Z5c/JLzr39NFoCuauHoGTFSm
 V7qKn8kV+DkeohoWkrllsGM9ZxLQx3OzqkZ/7nC4ZpXvT/FDI4w4rP2KTbz8TTBRRgW6
 Em8Q==
X-Gm-Message-State: AOJu0YzzxmcubHE0cN4jcon3s2zy1KRZE6A8P7j4LOozWoqM66EeveWB
 YneEzi9Nx9x34gmHCLAegOvF7fMeFE3mHGxnKLIh1650X924KClJxLPbXwPwct1k9+1CB8sWHTy
 Q
X-Google-Smtp-Source: AGHT+IEiN8SXkuLMAogOV2uB7YgL57RB9IwcHhb/8fHrM5ks99GDQF0dCiEaJrTPi4U9fHtSCZr+gg==
X-Received: by 2002:a05:6870:c98a:b0:23d:45cd:ee66 with SMTP id
 hi10-20020a056870c98a00b0023d45cdee66mr10352857oab.55.1714957668628; 
 Sun, 05 May 2024 18:07:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 52/57] target/arm: Convert SMAX, SMIN, UMAX, UMIN to decodetree
Date: Sun,  5 May 2024 18:03:58 -0700
Message-Id: <20240506010403.6204-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index fc8a5ca14f..9b68444595 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -918,6 +918,10 @@ SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 SRHADD_v        0.00 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
 URHADD_v        0.10 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
+SMAX_v          0.00 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+UMAX_v          0.10 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+SMIN_v          0.00 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
+UMIN_v          0.10 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b707c6ae4d..9ab73fc330 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5461,6 +5461,10 @@ TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
 TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 TRANS(SRHADD_v, do_gvec_fn3_no64, a, gen_gvec_srhadd)
 TRANS(URHADD_v, do_gvec_fn3_no64, a, gen_gvec_urhadd)
+TRANS(SMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smax)
+TRANS(UMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umax)
+TRANS(SMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smin)
+TRANS(UMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umin)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10919,8 +10923,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0xc: /* SMAX, UMAX */
-    case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
     case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
@@ -10953,6 +10955,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
     case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x0c: /* SMAX, UMAX */
+    case 0x0d: /* SMIN, UMIN */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
@@ -10964,20 +10968,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0c: /* SMAX, UMAX */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smax, size);
-        }
-        return;
-    case 0x0d: /* SMIN, UMIN */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umin, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
-        }
-        return;
     case 0xe: /* SABD, UABD */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
-- 
2.34.1


