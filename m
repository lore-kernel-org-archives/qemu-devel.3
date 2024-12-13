Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBD0E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XO-0007BC-9E; Fri, 13 Dec 2024 12:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Ws-0006sY-P1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:43 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wp-0001SD-Qx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:42 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1067566f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111157; x=1734715957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zyX98l1sgiigpgu1GmM5ikNVQf0pOEJ5j7Qe12nx3Rg=;
 b=y2ZBNuxzdEHl2i/d/W5yAEwnsjvoCQOXuRuqjz5QWimzcFv1vB9sZR5Es4H1am8QeL
 6bheXRYPtIrIswZVzhRYFJvaUtmLFS1n2agVHRpDW0sDp/C271aHy4j8K+ueyuEK1MMM
 jrKXI1fsPy9bKUmC/YNSxWcKIaQO7sDdU+ou/e0rkjVdD3950C/vmQvt/q3uHrHkgsQN
 7T0NKiQrsgyYi7Qrd7VuwBMJjwiMYBFJaO1DPuZ6EEhYKXAjms1il25vrL5aF68pH8dN
 lbUdwm+DXW1oCdpzdy6lfrGtfChnkYg2m7/6h33GKv1+CH/z/Valis8lHNTLK3S+cQdw
 KquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111157; x=1734715957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyX98l1sgiigpgu1GmM5ikNVQf0pOEJ5j7Qe12nx3Rg=;
 b=h9/A1fUz8WhoSXaN0rTyrg+o7Igbl9LqUC/D/s4+PMJeWaimAdzdJvdhBFALoxz0Be
 iaoJvhE7j/zd/AjnX3GpjUOnk2wjmW8yrqPnQavLuo3/g87kijji+2XqwGq1PL7VX4eb
 P9eVVNQADFqoBM7Z/43YOTwRel0lYAYoQqoOHaBIxZ8CRjpflf5ykIXIAps8Ev+c3wbs
 7sRctu+A4ISScyTuAYHJtnjUE+p1QdyiOMCas2Mkv/3qpbNute0LjJMphShCDAyuA8+Z
 BfdTWpy5FDRSKlDuOVyxT2ik070lKRBnfLgYPB8g7c81PZu+nNIjGulpoAf+6wswkIrf
 Q/Fg==
X-Gm-Message-State: AOJu0Ywtbddyd6i7reVGCJT33pVzcDbnCbgcz1tHg1+D2V68aZ6bwD+9
 VtCfnCYhSpbTMOkznwQu8S9+2uEuUMEDQu3v9zEZCKGuo+2UvTcxxi1JA9xvLScoSvl4olomgfb
 p
X-Gm-Gg: ASbGnctnNw9ilIQ1aCZYTTg5YHj26vremHbNJKBcdsj8gsr61SI9fizhMT+y5fJNTM0
 pZWNXYK9Cof5mwI8VsDNj7pUAL5ZwVlr12tToVMn2mCsQHeRCWRQQaaw+RPirtgkZBx+HGaEq5U
 DYgf9pK4Qc+O48Aa/Kb8+S9OiTFOlpYHVT3esUZtUUOpSm/Sl1xFtTZj5Ck7xBJQX4JUcrtTOov
 fZhQ6d1IA68fy524PhvIstNsdAxOsEb7aNpX3FGbprQRElq8Y7rAE4TLm2SzA==
X-Google-Smtp-Source: AGHT+IHuDlibtEU3zEyQdxwb1GWPUDzzFWjEwLgnSIRh/nx9oaK7RKrHZb3Zmcgc1mP1skatDaCJLw==
X-Received: by 2002:a5d:64c3:0:b0:386:62f:cf18 with SMTP id
 ffacd0b85a97d-3888e0bf878mr2777831f8f.49.1734111157259; 
 Fri, 13 Dec 2024 09:32:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/85] target/arm: Convert SUBP, IRG, GMI to decodetree
Date: Fri, 13 Dec 2024 17:31:09 +0000
Message-Id: <20241213173229.3308926-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20241211163036.2297116-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 +++
 target/arm/tcg/translate-a64.c | 94 +++++++++++++++++++---------------
 2 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1664f4793c1..f0a5ffb1cd8 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -26,6 +26,7 @@
 %hlm            11:1 20:2
 
 &r              rn
+&rrr            rd rn rm
 &ri             rd imm
 &rri_sf         rd rn imm sf
 &rrr_sf         rd rn rm sf
@@ -656,6 +657,7 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
 # Data Processing (2-source)
 
+@rrr            . .......... rm:5 ...... rn:5 rd:5      &rrr
 @rrr_sf         sf:1 .......... rm:5 ...... rn:5 rd:5   &rrr_sf
 
 UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
@@ -675,6 +677,11 @@ CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
 CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
 CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d
 
+SUBP            1 00 11010110 ..... 000000 ..... .....  @rrr
+SUBPS           1 01 11010110 ..... 000000 ..... .....  @rrr
+IRG             1 00 11010110 ..... 000100 ..... .....  @rrr
+GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 22594a1149d..00e55d42ffd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7625,6 +7625,55 @@ static bool do_crc32(DisasContext *s, arg_rrr_e *a, bool crc32c)
 TRANS_FEAT(CRC32, aa64_crc32, do_crc32, a, false)
 TRANS_FEAT(CRC32C, aa64_crc32, do_crc32, a, true)
 
+static bool do_subp(DisasContext *s, arg_rrr *a, bool setflag)
+{
+    TCGv_i64 tcg_n = read_cpu_reg_sp(s, a->rn, true);
+    TCGv_i64 tcg_m = read_cpu_reg_sp(s, a->rm, true);
+    TCGv_i64 tcg_d = cpu_reg(s, a->rd);
+
+    tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
+    tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
+
+    if (setflag) {
+        gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
+    } else {
+        tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
+    }
+    return true;
+}
+
+TRANS_FEAT(SUBP, aa64_mte_insn_reg, do_subp, a, false)
+TRANS_FEAT(SUBPS, aa64_mte_insn_reg, do_subp, a, true)
+
+static bool trans_IRG(DisasContext *s, arg_rrr *a)
+{
+    if (dc_isar_feature(aa64_mte_insn_reg, s)) {
+        TCGv_i64 tcg_rd = cpu_reg_sp(s, a->rd);
+        TCGv_i64 tcg_rn = cpu_reg_sp(s, a->rn);
+
+        if (s->ata[0]) {
+            gen_helper_irg(tcg_rd, tcg_env, tcg_rn, cpu_reg(s, a->rm));
+        } else {
+            gen_address_with_allocation_tag0(tcg_rd, tcg_rn);
+        }
+        return true;
+    }
+    return false;
+}
+
+static bool trans_GMI(DisasContext *s, arg_rrr *a)
+{
+    if (dc_isar_feature(aa64_mte_insn_reg, s)) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        tcg_gen_extract_i64(t, cpu_reg_sp(s, a->rn), 56, 4);
+        tcg_gen_shl_i64(t, tcg_constant_i64(1), t);
+        tcg_gen_or_i64(cpu_reg(s, a->rd), cpu_reg(s, a->rm), t);
+        return true;
+    }
+    return false;
+}
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8528,48 +8577,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0: /* SUBP(S) */
-        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
-            goto do_unallocated;
-        } else {
-            TCGv_i64 tcg_n, tcg_m, tcg_d;
-
-            tcg_n = read_cpu_reg_sp(s, rn, true);
-            tcg_m = read_cpu_reg_sp(s, rm, true);
-            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
-            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
-            tcg_d = cpu_reg(s, rd);
-
-            if (setflag) {
-                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
-            } else {
-                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
-            }
-        }
-        break;
-    case 4: /* IRG */
-        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
-            goto do_unallocated;
-        }
-        if (s->ata[0]) {
-            gen_helper_irg(cpu_reg_sp(s, rd), tcg_env,
-                           cpu_reg_sp(s, rn), cpu_reg(s, rm));
-        } else {
-            gen_address_with_allocation_tag0(cpu_reg_sp(s, rd),
-                                             cpu_reg_sp(s, rn));
-        }
-        break;
-    case 5: /* GMI */
-        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
-            goto do_unallocated;
-        } else {
-            TCGv_i64 t = tcg_temp_new_i64();
-
-            tcg_gen_extract_i64(t, cpu_reg_sp(s, rn), 56, 4);
-            tcg_gen_shl_i64(t, tcg_constant_i64(1), t);
-            tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t);
-        }
-        break;
     case 12: /* PACGA */
         if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
@@ -8579,8 +8586,11 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         break;
     default:
     do_unallocated:
+    case 0: /* SUBP(S) */
     case 2: /* UDIV */
     case 3: /* SDIV */
+    case 4: /* IRG */
+    case 5: /* GMI */
     case 8: /* LSLV */
     case 9: /* LSRV */
     case 10: /* ASRV */
-- 
2.34.1


