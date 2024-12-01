Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7CAD49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX9-0001bq-ER; Sun, 01 Dec 2024 10:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX6-0001Zp-OP
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:48 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX4-0004Le-Je
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:48 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so174790fac.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065605; x=1733670405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmXfcGZY+uOUXXSUJkFqHvnMcpF+Gs5GFplkRxYn1Z4=;
 b=mOj4xZQLBMTnsZdMnBgwQY+QfATpbQ60VjyrHChuLkslZlJ9y6cBJsWf+pR9mzFKkW
 EvL3Q/PwNL3ZBJ3kcFDGEFiZ1aoQIFkoBU93hZgyYczEOVY0uZZARAX/c6fosuPkMAKt
 pTSbYI0D+ZeF+VhZlHwuryovZHZa2SRK9d1zvF62ExFAoYdrRzO2uepcL1Sacvfxt0Qo
 5a0jK2GxK4+ypkeM3rzaa9eo1V6EUUnNib4ntlZWirRz5m7Rhz8LIYssUMemBkgx2Xfg
 4tiRg3GaDeRaTycXKIL4G+RLN6TxQd5bo60VUxlRUSV8idTF/wW82KLYPV/NHjurT7Sb
 uCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065605; x=1733670405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmXfcGZY+uOUXXSUJkFqHvnMcpF+Gs5GFplkRxYn1Z4=;
 b=pwgfWFwTuTNPTXU0UD9aZuQN5ZVQ8gj2O4p5wS6JS2CR+h21e4Q7RW/wkR2lG/UO2Q
 PIJW32m135+dCl7K4vnV6OhmDbBhYPpV074rRX6rSnGv01oxhXgkvqVuKc6FSyWKzVfq
 yVEMDZrRq58HvZI0sLGhpX4B+X75gEgHtblOWP6/Jt4Wysku9AgIGuc3KgcpSaW9kHNO
 iF2S+Br8/TQJ8FyiAC4roTDWqq6Bm2O8NWOXSAaBQcseG/hgrWZYNZ6wdHVnONJdw+wP
 HEKI2oDrFbRC42wk2fSP9UFGrQE7s+vb9fDPq5rl5aDCMb9xOewEbPR6BBBZ1tLPkcmd
 ruDg==
X-Gm-Message-State: AOJu0YzKm3N09zP8FMKZtv5rwMLNJ76+PaKadHenUyC7U+bd+eKY4Swn
 Myf9GVHVj3mBwlXy/ovHUs756BrdZLb3tN/dcWwtaiwzJ0Z6D4H20wZEAmNjbr5JDgPOP8GB3o+
 zPqc=
X-Gm-Gg: ASbGncvyerS0ZJKvY8lYW0/zOddmk7gdVWbDtFvv3ZW3bsAX+U7384YRmg9tLu3hdxR
 rfBVeafJpkaL3Iqy7Peh5YVeB5XDWTrAaSyYXx1SdERze9v0klk2w5U++8ptdXMvjRhAgLn3g5B
 XtDPQw22+3zW/3CFjDwm1vwsPcC0Ik2uJIg4MMpTvZ7TH/4TMJ5c/79wVOOO4rlRE7jnbNFMx6U
 2j1kYCqBZNH18+5YPDzTwhtCQLu3G0UiokUhHl2MqoOkOqCzCDc3WL5zQjBWBQGCTraeQ4QRF4U
 7qQbGEQmE3q+4P+yg5EQ5sSc113icJztJuoq
X-Google-Smtp-Source: AGHT+IE6I1P7oIHOMxAR5CA+FzCHbpq2M935z2BNgm1gGEoM65Qh+esw/C42bDCC2xkGFun7Tl8Fnw==
X-Received: by 2002:a05:6871:7b08:b0:29e:5897:e9ed with SMTP id
 586e51a60fabf-29e5897ed21mr1399903fac.35.1733065605487; 
 Sun, 01 Dec 2024 07:06:45 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 32/67] target/arm: Convert FJCVTZS to decodetree
Date: Sun,  1 Dec 2024 09:05:31 -0600
Message-ID: <20241201150607.12812-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
 target/arm/tcg/translate-a64.c | 41 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 68bef0963b..90e1567ad1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8718,6 +8718,26 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
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
@@ -8779,20 +8799,6 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -8847,13 +8853,6 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
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
index 427924ad95..7b83d06d0d 100644
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


