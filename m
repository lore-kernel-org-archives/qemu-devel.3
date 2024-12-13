Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F4FE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9X3-0006xG-5N; Fri, 13 Dec 2024 12:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wp-0006rQ-3I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wl-0001Ra-OK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43618283dedso19157705e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111154; x=1734715954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xRqNcB49wUmV6toPbS85zu415uBU5pRnCBAfEyn015o=;
 b=fHSNjQTT5RjdkX+TezN856A2NenJX0SvGlDPvO1hSn0JdLNq4BRXAGthWaGl8Krpgy
 kK7aWHFiU3kVzCHQn/mrF+pIyZCfbVirLgNT/zm+PxUVoi3OaukiG4hKDNjIvxaOHLiI
 +n1Kc+z8bBW77igg/GIUfhAPpIqaLQopZA5tmBJZRUPzYM9ttfvtI68wU/zmcnH6Ly4L
 ARU6zDRJZtAFRNpKa0tQMb4j8zE7VTxBS9QkMBPSCYwbFc4n16Gt655Y38MT8h7Hl8DW
 EGLAhL3PBTnZM9Z+Psgkcrn2kf1irNFj7wLF02aVsUrrQfuJ8JfB36EG7SXtBqnCzPuz
 0ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111154; x=1734715954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRqNcB49wUmV6toPbS85zu415uBU5pRnCBAfEyn015o=;
 b=LZBEH4PHGns5sEMlfe90pWKskENdfZIIPgHom7XVOa7K2A2fgxDw7OcLbDHd3zclFT
 XMqOyliPQs+U9ktyJescH1ZEtu78P3n7dEGg+sZTYGs6fPHJBnxaZ6Jun0OETWYj7XUS
 BpSl+gTmSIqOMqBwt/sBQIDZo4QqGutqqS1nYunRSgr6T6Xo4JFAEA+Jg1OXJFpCE335
 X8FoIaJzmF7AhEjyqKigc72Q0aRmnPU3xCmt6wbFWVxxIX6MtpQvcRUIGUznRMLwnS6W
 hdbOnZD9chKTVBREDftd101V0BF0X+o5QhCaymF8CB5rW9sx3451DAyiOZJk6aLIacp8
 qnxA==
X-Gm-Message-State: AOJu0Yzvj0DX2NjTgyLZJT17qIb/CcEtdnom7EfUEW1BdxLCcI4zs1L9
 mzqRDAlbe1cRNJtRLtWqlrGegEZsmhNegwslhXNvHK4PJtaLdcnCLJH9dlHxXqW5w5Tn3TWTzoF
 R
X-Gm-Gg: ASbGncsKzLeybm60dtSoy7+rA0sGnvJlY6tBz1VnC2vpF1bhIBlTNMUcTfqoyXLIzUN
 CTJnyp1dux+5EcsnJFBsGdUIwGOioGiOVi8Fi/TyRL6o+uelCiPEGoo5blvMVkxnBCyd5LM4C34
 cGz12KFhtdwCThtyzBftGwfsw0duF6tJGwSK6VpRYXVIKN7gOuDbiLFedsWY4tF9kmgOguJLLys
 SBhdyflIa79fJ7QNod/YeEALCadfBTyzZ6w/XbHOU0XziY76VAjgSMlfiYplg==
X-Google-Smtp-Source: AGHT+IHsfA/D/URYKXVmEiZkqZSnPyKoPiiKIKqu5l0/1YsEQr7omyclrUalUiPRT0GuM13+po0BDQ==
X-Received: by 2002:a05:600c:1e8a:b0:434:f5d1:f10f with SMTP id
 5b1f17b1804b1-4362aa52fa7mr33090445e9.17.1734111153980; 
 Fri, 13 Dec 2024 09:32:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/85] target/arm: Convert UDIV, SDIV to decodetree
Date: Fri, 13 Dec 2024 17:31:06 +0000
Message-Id: <20241213173229.3308926-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 ++++
 target/arm/tcg/translate-a64.c | 64 +++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d28efb884df..c218f6afbcc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -28,6 +28,7 @@
 &r              rn
 &ri             rd imm
 &rri_sf         rd rn imm sf
+&rrr_sf         rd rn rm sf
 &i              imm
 &rr_e           rd rn esz
 &rri_e          rd rn imm esz
@@ -652,6 +653,12 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 ### Data Processing (register)
 
 # Data Processing (2-source)
+
+@rrr_sf         sf:1 .......... rm:5 ...... rn:5 rd:5   &rrr_sf
+
+UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
+SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b2851ea5032..9f687ba840a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7485,6 +7485,36 @@ TRANS(UQRSHRN_si, do_scalar_shift_imm_narrow, a, uqrshrn_fns, 0, false)
 TRANS(SQSHRUN_si, do_scalar_shift_imm_narrow, a, sqshrun_fns, MO_SIGN, false)
 TRANS(SQRSHRUN_si, do_scalar_shift_imm_narrow, a, sqrshrun_fns, MO_SIGN, false)
 
+static bool do_div(DisasContext *s, arg_rrr_sf *a, bool is_signed)
+{
+    TCGv_i64 tcg_n, tcg_m, tcg_rd;
+    tcg_rd = cpu_reg(s, a->rd);
+
+    if (!a->sf && is_signed) {
+        tcg_n = tcg_temp_new_i64();
+        tcg_m = tcg_temp_new_i64();
+        tcg_gen_ext32s_i64(tcg_n, cpu_reg(s, a->rn));
+        tcg_gen_ext32s_i64(tcg_m, cpu_reg(s, a->rm));
+    } else {
+        tcg_n = read_cpu_reg(s, a->rn, a->sf);
+        tcg_m = read_cpu_reg(s, a->rm, a->sf);
+    }
+
+    if (is_signed) {
+        gen_helper_sdiv64(tcg_rd, tcg_n, tcg_m);
+    } else {
+        gen_helper_udiv64(tcg_rd, tcg_n, tcg_m);
+    }
+
+    if (!a->sf) { /* zero extend final result */
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
+}
+
+TRANS(SDIV, do_div, a, true)
+TRANS(UDIV, do_div, a, false)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -8425,32 +8455,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #undef MAP
 }
 
-static void handle_div(DisasContext *s, bool is_signed, unsigned int sf,
-                       unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_n, tcg_m, tcg_rd;
-    tcg_rd = cpu_reg(s, rd);
-
-    if (!sf && is_signed) {
-        tcg_n = tcg_temp_new_i64();
-        tcg_m = tcg_temp_new_i64();
-        tcg_gen_ext32s_i64(tcg_n, cpu_reg(s, rn));
-        tcg_gen_ext32s_i64(tcg_m, cpu_reg(s, rm));
-    } else {
-        tcg_n = read_cpu_reg(s, rn, sf);
-        tcg_m = read_cpu_reg(s, rm, sf);
-    }
-
-    if (is_signed) {
-        gen_helper_sdiv64(tcg_rd, tcg_n, tcg_m);
-    } else {
-        gen_helper_udiv64(tcg_rd, tcg_n, tcg_m);
-    }
-
-    if (!sf) { /* zero extend final result */
-        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
-    }
-}
 
 /* LSLV, LSRV, ASRV, RORV */
 static void handle_shift_reg(DisasContext *s,
@@ -8552,12 +8556,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
             }
         }
         break;
-    case 2: /* UDIV */
-        handle_div(s, false, sf, rm, rn, rd);
-        break;
-    case 3: /* SDIV */
-        handle_div(s, true, sf, rm, rn, rd);
-        break;
     case 4: /* IRG */
         if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
             goto do_unallocated;
@@ -8616,6 +8614,8 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     }
     default:
     do_unallocated:
+    case 2: /* UDIV */
+    case 3: /* SDIV */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


