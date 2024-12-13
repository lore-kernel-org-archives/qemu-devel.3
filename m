Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648EEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YZ-00038D-Ns; Fri, 13 Dec 2024 12:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XP-0007D7-Sy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XN-0001bS-Tg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so2405865e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111192; x=1734715992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZ7MqaY3Qm/rDAv4NgSeRnPhhcH+SNF8CM2XZWn6Fc8=;
 b=lsIgNc74e5xJa3VBydEawqPhP07LFyFV0dsNDQogKNuVHuQeY/96kBRzsAAwvFQFgB
 EI3mwH2Imemq6NnOaILnGJxTNypPXb336HdKApHsNT+xoPtNo8c8qSxP8tp1yLjkbBS4
 bLlU7YHIFLLLqZI5WpbUFUq++ZUG5U45RP7qi7rXEMR3ocxq5DHD0aji9XJeYBM5kZR7
 KUrIZ2TcI3cLrjEgDWGA2GjlqXJJY/XfgDc86cZ4RwDrvXVzGTFyetSJ2NTlbovr7+g9
 s/O1KBZvGXV38MXdOTVaWy6oT983Hii7tCcv6TP4Jhs7T3WIA5qTyJQB0WFo+/e39rER
 hjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111192; x=1734715992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZ7MqaY3Qm/rDAv4NgSeRnPhhcH+SNF8CM2XZWn6Fc8=;
 b=D/dwDWLBrssmvaa9JdPNFgyEOO0zGtWyDXa3xUB7+uo12ELqYjMTKXFyIYgJv61LDD
 dJdDY4o/2Q2omh3CJJuM7/RidAdTFJ8iMFNorRZnrE8H/9kvGgnD1jk32RhgQQY4Frzc
 NZV8QMNknHVHKqmpYq6ubVLdURwqvhnqtfn9F2f0aw3Plasu7kqNkKx03yBSCvm8oTrr
 35FYjIcB4QqGJcRoD8NYeDKfZIzMm0ABcxGTHssQ9YYYhbduaDaCde3LY2LffRIvWLTE
 ZV177mLa1QHyBeFXbtkJRYN5rj0Z265aQRZ6XGt7QCj9vJ3OEk1oTyqb/ezNMWldE1uI
 FtSQ==
X-Gm-Message-State: AOJu0Yx75dTPI9mK9mJLkufTEBzQSr4yibGtCovTfSCi2RL1TqYnEaMK
 OBpYB8WOaznwV7upg5vMvvPDHTk8Z9gqGEI1exwgTehM4UvxUYgkgJZlg5KPPPBy8YiDgQ50g4W
 Y
X-Gm-Gg: ASbGnculfyTb6TnLh/CGDsWhIbb4ukwKlKY/JqOM6VV1ghvf6IutnFGpB/EZWZGa9JH
 elUCaeANqY03qf9MdhFZnlE7v9o1b3O+DL9BpXwaHGfa1WmsPOTKssTgBndNfShsg3IZqZoVV2j
 HswVNhrbVqe6Q2qJrJ2Pa/3goJ1+cW6IfzqRAsL15l6FbHe37sKt25+Abbigkl0o37k18mpE3Ol
 dNZTnjUr8/7+okLk9Wo28rcsK+VU6RSsoE2DIqNWobNrpU0y9I+m2jrxL9VUQ==
X-Google-Smtp-Source: AGHT+IHkf5Jx9Z8mzuX0NC++gggkqqg9qwjypTTKRTNvwzLyOTPbe1icMO+gl8bjFaeReHPRmHIeeA==
X-Received: by 2002:a5d:6d03:0:b0:385:dc45:ea26 with SMTP id
 ffacd0b85a97d-38880ac244fmr2870102f8f.12.1734111192403; 
 Fri, 13 Dec 2024 09:33:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/85] target/arm: Convert CLS, CLZ (vector) to decodetree
Date: Fri, 13 Dec 2024 17:31:42 +0000
Message-Id: <20241213173229.3308926-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++------------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f112951df72..32355ee6331 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1641,3 +1641,5 @@ SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
+CLS_v           0.00 1110 ..1 00000 01001 0 ..... .....     @qrr_e
+CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 387bbbf906b..ecb45789986 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8916,6 +8916,20 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
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
@@ -9215,13 +9229,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
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
@@ -9283,6 +9290,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     default:
+    case 0x4: /* CLS, CLZ */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
@@ -10089,12 +10097,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 
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
@@ -10299,6 +10301,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
     default:
     case 0x3: /* SUQADD, USQADD */
+    case 0x4: /* CLS, CLZ */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
@@ -10321,13 +10324,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10351,6 +10347,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0xa: /* CMLT */
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
+    case 0x4: /* CLZ, CLS */
     case 0xb:
         g_assert_not_reached();
     }
-- 
2.34.1


