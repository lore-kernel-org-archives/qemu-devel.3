Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A636FD49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlXF-0001g2-2o; Sun, 01 Dec 2024 10:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXB-0001du-ON
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:54 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXA-0004P5-2u
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:53 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-29e5c0c46c3so238555fac.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065611; x=1733670411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4af4pVWGTdLxa/cMYsckd33eSI87cF6IivOWXbQ4r0=;
 b=YgnLcXGgvNKG9eII+lGGY5IQ+v/TWbxuT47mYkyqgMMirDD3ooM4MBElKxzXW0tIiY
 WpcL0d2gTor+CnC5HZKZ79ctUHDrlZgO+gYGfGllICMz8kuaZnk2TcQZeupzQ0dyftft
 UeO9FTbe4zAEz+i5XlwEpM+sxt9Le1wlEpawl3xhrsIf6E9EKT3wL0uBlZHSV5pbYBSc
 hYX9r4tjaLFaqWrj0+MRHWiSb0CW5nzMKY4oWLmLkeSYI7Co7r8XaHFghwJVoKd244MQ
 kmJFG/hiUA5NPQbAucgUygLMICkOKwVlDNRm0WgmbkiTz1qP3QbsoYVH14OksmUppvW6
 H76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065611; x=1733670411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4af4pVWGTdLxa/cMYsckd33eSI87cF6IivOWXbQ4r0=;
 b=qNbbup1QTuf9HHiP0cGrQNicPfeFI/DUiKl/zXTloCk2UY7ZOEf+zEBJZvZu1VB9Ma
 jV7TY7xEwA9NL9yA2ybJ90FPI2Ldaz3gNo4Y+gMwSrGttHZCFsofT7RAyl8MWlTD/fL8
 UwMDnEwnN+g+UXCtDSRNDiyz+gV8bUD44J4A0gs/iaVuMx5iHJuyEVLjd898S/gazIzp
 I1r11rb0DhSx/BXK2qPxSNWf/POl8ov/jwCxMaKq/vialBkCyChmYq8y4hFdtcwrvfu5
 GIdQPf1P03tB/Dku0Z9OnVl5BED67cHV4T4FsHOUKvuIyhs4RsaoTuc2kHQpl8Xvk3Gf
 rd0w==
X-Gm-Message-State: AOJu0YyJCig/qxxlyaX1QHHBk2sGRplO3iMRZvRQgZ2x5wvwkBgGjrOH
 JJWfYa6JxGyPNdBqoz3mzYf3CvgDAZf+Xxd4Yv0qVPd41laOX2kNVBF4S+y9QUOE0NZKAo1Qm7M
 g1cM=
X-Gm-Gg: ASbGncskVJjzpP4LYZhm+EzI3mFgIJ6EPQCzEo16Ui3NJ146OI9W8y7WCOATZqFnDKO
 P+B2J8HvT/1fbh0o8KDaIsdsLlpc+yL0hSqqyVaAemwhIqywj/nYFG1Dg/0U9gRnGxXzq0lE9V3
 Kd95iZp4m6Dr0JHxlka7S7gD2pXuKBpZ9k3d6Tb3uWCUwxOVS026ayLtGDGchCyaKh+fcgcjMvw
 qrr3FidJx+EWHLWP7uyVKiVIhMvLvIzYISaS0WQemHh5fEwgfVB3o715T3RwDAZK4GWMLtY7znX
 6H2EVMFu9giq6NTdPzFz3v8NZY/8XA947diZ
X-Google-Smtp-Source: AGHT+IEyMxWSn+EY6ewjk/57LX1bLETRoSdNTeinT40nbB18X/1CZRivWxXfecdOnLzdzITpC+q1jA==
X-Received: by 2002:a05:6870:6c16:b0:29e:4c12:9958 with SMTP id
 586e51a60fabf-29e4c129d78mr2107798fac.16.1733065610634; 
 Sun, 01 Dec 2024 07:06:50 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 37/67] target/arm: Convert CLS, CLZ (vector) to decodetree
Date: Sun,  1 Dec 2024 09:05:36 -0600
Message-ID: <20241201150607.12812-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4abc786cf6..312bf48020 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8920,6 +8920,20 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
 TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
 
+static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
+TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9219,13 +9233,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     TCGCond cond;
 
     switch (opcode) {
-    case 0x4: /* CLS, CLZ */
-        if (u) {
-            tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
-        } else {
-            tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
-        }
-        break;
     case 0x5: /* NOT */
         /* This opcode is shared with CNT and RBIT but we have earlier
          * enforced that size == 3 if and only if this is the NOT insn.
@@ -9287,6 +9294,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     default:
+    case 0x4: /* CLS, CLZ */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
@@ -10093,12 +10101,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 
         handle_2misc_narrow(s, false, opcode, u, is_q, size, rn, rd);
         return;
-    case 0x4: /* CLS, CLZ */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x2: /* SADDLP, UADDLP */
     case 0x6: /* SADALP, UADALP */
         if (size == 3) {
@@ -10303,6 +10305,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
     default:
     case 0x3: /* SUQADD, USQADD */
+    case 0x4: /* CLS, CLZ */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
@@ -10325,13 +10328,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x4: /* CLZ, CLS */
-        if (u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clz, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cls, size);
-        }
-        return;
     case 0x5:
         if (u && size == 0) { /* NOT */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
@@ -10355,6 +10351,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0xa: /* CMLT */
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
+    case 0x4: /* CLZ, CLS */
     case 0xb:
         g_assert_not_reached();
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 30cd05030a..c3acb5dc37 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1641,3 +1641,5 @@ SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
+CLS_v           0.00 1110 ..1 00000 01001 0 ..... .....     @qrr_e
+CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
-- 
2.43.0


