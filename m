Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE54E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPf8-0002Tx-L4; Wed, 11 Dec 2024 11:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdT-00067q-QI
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:30 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdS-0001Ro-Ac
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:27 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4678664e22fso13286441cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934744; x=1734539544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2ENayoApwQgHueuvDfyYv5kDSTUxHtmNfYBpEtIZmY=;
 b=EsaEtbcZfnCvm7sJ9cVPYJLtrK183grJVdygFUcS7rLJpPEkTuKwvG9djW4VOVwbTX
 lfNqFzvU0nqRa0DelDlPI7f1F6N8yIpzfMQ3krW6pal0rabrjfj+8jyUt07rnFXeV4pE
 9KQPpI46C+C4Yg2XoIVMq9IyCABEDELfHpQFNkI6ProNK6ExkpCzKn4UzyNa2yn5lNWP
 W3a2jf3vSEorTuGbCh+5wnxppGhHAqT94VEXz1pVM0oIDXCAXS3VbQmVKaY0AUpTWbeR
 o0tkygvEE1tJ0M07AwpglbJVF+dXDpFZyTo2J9sqlvOJWWpeBXnPRg7AeLMx71/tr9wn
 c9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934744; x=1734539544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2ENayoApwQgHueuvDfyYv5kDSTUxHtmNfYBpEtIZmY=;
 b=LBZWO/OUThLUQc3jmvFJeh3rGKrtVAFFTZihRcVezKRVMpxo0dd7BkW7usvlhDB5X4
 SDuTAZGTB8XQeqEzbZaqngiAZ7wFrG07MsWZJTVhvC7YNNY1WqlKH1OFu/iMAi/h9XGT
 038z7q5kwtBwJ7DKXg47QVppbnPGkbRc85Hzst0ejysrcfDP+e9njG+RU+0erRS6ynxG
 Ucn0nUNDD5Re9RKKIj6ldEKChG3R2tqXxYbUYQ6501LufMDVUJB/EW4edchPAaKM2Par
 jZZlJT7sIGU4BZJ7GnBzAlmAH3XXv63hwEPSp+Zb14PXIdfvQBM4qSyYMHE9FMTXMcd2
 XU9Q==
X-Gm-Message-State: AOJu0Yx2Yhi66/IqUa7TIFgHh4eh1EiRu9Ah+wR8Fbxx7AeIkdwmJ2mg
 TPyABag2S95O7xi8/OAj8JrKafND/oJ4l46NhDP1zPQOTEKCjwqch/QALerwNmYr9euKKgqqhRN
 x3H1j2bJq
X-Gm-Gg: ASbGncuCaBW/6apE8K6Dy/oIRYCqJjoVDhC8s/RImgv0whrNb9GmC1pOygcYNpcZg9S
 uY+s+Y4T9YZ3p+jsK9wNkEk164z9DpZTosVZ/hK+OKviNSiLCsKQ7sLaC7Vr44+cQgYt1c3sdcR
 iiVxEUcEYHgfIhQDsggtqxEk503jtbx6QNSmmslQHiFtp+GAnTegIkvoaeJIh3tRat+9k6jwC3G
 RBl2d/kFIa8yDZmA0PMrGbrqJDnUxPlAluLw8e+j2Ain67MUd0ahFE7UGf1fQ==
X-Google-Smtp-Source: AGHT+IFMlKvgVAsQuUMnNJkzchX55tceXxbtaIESJs9Z3O/Tul7Z+j8gffjskInEQ2XTQri9vGPQCA==
X-Received: by 2002:a05:622a:5448:b0:467:5642:5917 with SMTP id
 d75a77b69052e-4678930a459mr79076701cf.32.1733934744228; 
 Wed, 11 Dec 2024 08:32:24 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 33/69] target/arm: Convert FJCVTZS to decodetree
Date: Wed, 11 Dec 2024 10:30:00 -0600
Message-ID: <20241211163036.2297116-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 41 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 67227e2676..d260b45ddb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8714,6 +8714,26 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
 TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
+static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
+{
+    if (!dc_isar_feature(aa64_jscvt, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
+
+        gen_helper_fjcvtzs(t, t, fpstatus);
+
+        tcg_gen_ext32u_i64(cpu_reg(s, a->rd), t);
+        tcg_gen_extrh_i64_i32(cpu_ZF, t);
+        tcg_gen_movi_i32(cpu_CF, 0);
+        tcg_gen_movi_i32(cpu_NF, 0);
+        tcg_gen_movi_i32(cpu_VF, 0);
+    }
+    return true;
+}
+
 static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 {
     /* FMOV: gpr to or from float, double, or top half of quad fp reg,
@@ -8775,20 +8795,6 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
     }
 }
 
-static void handle_fjcvtzs(DisasContext *s, int rd, int rn)
-{
-    TCGv_i64 t = read_fp_dreg(s, rn);
-    TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
-
-    gen_helper_fjcvtzs(t, t, fpstatus);
-
-    tcg_gen_ext32u_i64(cpu_reg(s, rd), t);
-    tcg_gen_extrh_i64_i32(cpu_ZF, t);
-    tcg_gen_movi_i32(cpu_CF, 0);
-    tcg_gen_movi_i32(cpu_NF, 0);
-    tcg_gen_movi_i32(cpu_VF, 0);
-}
-
 /* Floating point <-> integer conversions
  *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
@@ -8843,13 +8849,6 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
             break;
 
         case 0b00111110: /* FJCVTZS */
-            if (!dc_isar_feature(aa64_jscvt, s)) {
-                goto do_unallocated;
-            } else if (fp_access_check(s)) {
-                handle_fjcvtzs(s, rd, rn);
-            }
-            break;
-
         default:
         do_unallocated:
             unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5e170cec7a..cd10961618 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1363,6 +1363,8 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
 FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
 FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
+FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
+
 # Floating-point data processing (1 source)
 
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
-- 
2.43.0


