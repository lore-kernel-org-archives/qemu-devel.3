Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FF9D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWl-0001Hp-IS; Sun, 01 Dec 2024 10:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWe-0001B1-9Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:20 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWa-00043z-Pv
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:19 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ea4f9825f6so1367042b6e.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065575; x=1733670375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRWtrYSiSJQgzSgTc/b6lhmlDw1xagT8Y+Nf8NxJVEA=;
 b=pAwsQj278B+4olUz2F3fURLrPrgprguzFTRKZcW27K9Mq0XVSoUeffHlKpzzVuC2v8
 +M/ocirJeAdJxa7G7oiNAMqNc7wClm8AbajqK024c3HanlCkxdZkejN+FnpWvdF92l5e
 1Qud/G9m/lFBRNYvsSTq4eIuaCgVCOSH2OpgLq41OlI58xYqajXSr08RYglUVWUYwGF2
 bAJxQEfSBgf4P87WJKL/Bdh8ZySXH8eVMzbBr31AGCvJ9W0n/RtGqvBndFErEhJ533PU
 GdT2QRa386+mzOW0raik+ow09dTHtVEtCdAFNKLye9keOmHsMd+g/6HWdjp6oVsveh01
 2rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065575; x=1733670375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRWtrYSiSJQgzSgTc/b6lhmlDw1xagT8Y+Nf8NxJVEA=;
 b=UVjakFv/iqFJ0K7HmIFYLE2uptHAQc5jb7Dl75IADgBfGrD/ITcbrqsKJ+ng8yI/1/
 Ke7mHEQj9TMM+znzkRhafl9MD1bEeyjN4Wf1hpdBzBQHIXIgThwJCKzfUd1SD1BC1vnZ
 OQ9QBa8eiQLi2Tn8I0d2nHgUz0swpYYjPWwwuKysYGs57CcdhiwhUYTMOet8ydIC2+vG
 MSxdWfyTVQf2epkagSUcVtop0+awoKS5G6nuukdtXUl5TMmuk/WwW6RPIsl/gIvJen5T
 krHvDGG9tNaIV8GbKQNpFm0LhcZ5trSeJodF9P3Knb295dHwvhYqsQav7crXWHku54mv
 dDzw==
X-Gm-Message-State: AOJu0Yyo2u9RY7/NWtJ5PQhqlBJ9sq3qSbpLnJmAxkf1omqLWpk/bwHA
 Lntkt05f3ihSosoQBX35X7YqPhKRKoXIC7Q4SCkCP6pwDVLJ5HhrwgkrQ+DEmrTF2NHml23iJxW
 1Nc8=
X-Gm-Gg: ASbGncsDvOWY75bfoysE7su4qBItsSVTyLAH8fSdfgkL25tagRS4sFy9QDWqN38TuA6
 iY7L4oQpzuIvdVGO2Te1yHB7HtRKEdMZmHBVxHHwk5s0pfBs5PPkxjHWJrWymTo3AqamZlUnNs3
 sg+YEn/HNAdsb2wNrz1LFF2s0++HLK+qsB/jiM93cGuc7+mfB8Fc428p9KL8DPr5w+KJ8714ANi
 oLCUZijTdA1kwu42mlbVEIm8PFsyKG0EC21OI0GBegCW/oQhWZGFj5H0lsRKjYqSiy7b4V/h6jv
 G8ytq8nlTQp866SFuJGjmd0xQYy448SGfHY9
X-Google-Smtp-Source: AGHT+IEBAHDmguQ5PwU57cqxlXs/+6zMSi772pIN5MbAt6kFkxq/sBPB1YuBUJdHyg4LIvz+QHtHng==
X-Received: by 2002:a05:6830:3143:b0:717:fe94:4089 with SMTP id
 46e09a7af769-71d65cf0f0dmr13794441a34.19.1733065575444; 
 Sun, 01 Dec 2024 07:06:15 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/67] target/arm: Convert SUBP, IRG, GMI to decodetree
Date: Sun,  1 Dec 2024 09:05:04 -0600
Message-ID: <20241201150607.12812-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 target/arm/tcg/translate-a64.c | 94 +++++++++++++++++++---------------
 target/arm/tcg/a64.decode      |  7 +++
 2 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 22594a1149..00e55d42ff 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1664f4793c..f0a5ffb1cd 100644
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
-- 
2.43.0


