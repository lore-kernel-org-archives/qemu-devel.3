Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE6AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2yC-0008Tt-WC; Tue, 10 Dec 2024 11:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y9-0008Dy-TD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:18 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y7-0006qt-NT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:17 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so6638621e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847614; x=1734452414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUmkPDjfVEf4M3Y0WpkeuqJdcwozkZ699EhdgSni6SA=;
 b=UOaQIgVpiLquLsOIyKGVCOoy705NC8TefL/4sIN+3IJ0UM7+fGboeY5gkcahF43H/O
 +rhCMV2TKcO9zuLWmIFD6avN0OTLzfhyY4gKzjeUGEgnhT+vRclmYDzMVzzp++0p1qh4
 63wy+fwoAzfRh8l6/T/+7hnt/uvQ7UEchOjB83O6+Fnfpwy2JcSfrQ5UkmRs904SOGmy
 G8y64GRN7R/VK3ZyuLsuQZ+14Xu3B6tI1hdjYEbBuYLrK2/YxdSP0VDhoZTblAug1j3z
 HIuW3DInSzR2vKuoIDa9DYNsV/hBG7GsUFru1gmAPovCkohq4f6IiSCcowWFR3Jbhuhb
 AlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847614; x=1734452414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUmkPDjfVEf4M3Y0WpkeuqJdcwozkZ699EhdgSni6SA=;
 b=XfobpVh1D5epGbZA9o3ngfj2kFlH3udYazEAkgZvWsdSoxJ6ehAW8gy5X0zkaGK/kq
 OUuvHkwEH5bn3ss5hTugau741+1iENbe2e6572srWygrFkJbhUCf2almc02pEmbxYv1G
 iZA0Kp7Q3/G7iJwKP//lDzUt81jew0ryKKqExDv+Fnavmw8pJDpNDKuqzYEiFiV4141o
 IopwBIau073StqKtwA+cnr90AmvVts4l9T4F3+CRx5QcRTG2YAN7urmXJbwen+l9jGbQ
 KhbN6tlDDHoZpjh8Z05QiOM1SMunrtAP9HYhuTyoK6asRZyspYPSjPbKDWoqrvnaeuqx
 4wWQ==
X-Gm-Message-State: AOJu0YwstPmB+LgjxbcO85a672US9ubWgT+G5m7unu169/xmvIdFP5gE
 A5JGrD8YKhcwjbKgNXDg278PDnlFOItfJIkZe8gp1nETaisr9CCnSxgGrujFzmUhHWKYVkN2Qts
 d798s5H3O
X-Gm-Gg: ASbGncsFoYOostbxdpGO70Z96BIpU3dbKf3K1sblpYPLjzW/3IfbEp03xrA2zeoQCf9
 v3bUrEB1kZaLldO8v/k34fyGRkXIK2hmkIhSsXUd4wSzntWRalRSHS1OW3zC5G3XbJ9QhLZJ7oo
 1b7xhlcrqXiXfYyEEm9BqWaK6uKlSKn/v+tNzLKlX2pM7bOyUuuwxRYBlQ8FhEu2vpumgJTX/re
 omeAYyMLH/kmn4keAJYoPTJuLQo8bSHMSCBtLZDRl+j2qjyPGB2E4VuniE=
X-Google-Smtp-Source: AGHT+IEiiBqVv/vhVnquvBp2aCILhPmigWIQbzhoZJLE+Eqqz56hq7bO/JA84wGqarFiOU4ZYti0yA==
X-Received: by 2002:a05:6512:159a:b0:540:1e5e:3876 with SMTP id
 2adb3069b0e04-5401e5e398amr3404427e87.52.1733847613943; 
 Tue, 10 Dec 2024 08:20:13 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:20:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 38/69] target/arm: Convert CLS, CLZ (vector) to decodetree
Date: Tue, 10 Dec 2024 10:17:02 -0600
Message-ID: <20241210161733.1830573-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77d9f6452a..bf993783ac 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f112951df7..32355ee633 100644
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


