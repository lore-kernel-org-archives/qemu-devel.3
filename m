Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADCE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xi-0007lU-0v; Fri, 13 Dec 2024 12:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XK-0007BO-Sn
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XI-0001Zl-SX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:10 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1477163f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111186; x=1734715986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K6tFM8RqNXAp8SOBzyhkiiQ54MPDAGBytFPbzLtpuXE=;
 b=WlNpwxzbpZjDU4AhOZS3f/+kcM24JD+DbCYvDGspPgHP4ORzfwRBTvWzPROnvxCvhu
 bXt04cg/yvXjxWBGny8cnscoe1psKpJM66PxiCjXEKjruoFth6QpBV7giWka/BIxRRxP
 dl2jO0LlrYraVBVsLk8J7uMCp2doMxl7R9Hch6IxS7KYj1dnrk9tYuUSIJSz1dEv66dd
 O5A1wXOGHPY4MNa9VRuu1V5BdKcVCGw0y5+EY8GlZ1UjWUvlgYyvwFm3LXIIzSsmnnSF
 dG5N5qAtrsKoE0yzuzlBzuQG6xqOYgv8jkGlbg4IRz7sqkA1LNw9xlzFRirx3fP2T/SK
 M5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111186; x=1734715986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6tFM8RqNXAp8SOBzyhkiiQ54MPDAGBytFPbzLtpuXE=;
 b=V6kz+7Dr7M8c3LCEyb84bGtfrgLLhK1xAzMRA4MWqMsoYh4mh2k9hOJ5P0Mm0sFMFJ
 Cw0pzHLduv9m+AGlRkcxDuvtpNA+m38JLFZvuUgeXkE3BS5pLpyFKPwFEMrofz0mzW5e
 88o43/4HdwqD6ZxkFczJcwRGNf4YyAvnA9rpe+5VKSTv7oof0/VZ5aF/WnfNLwKvGXKS
 MqByaPABfjv1Lvps5+xeg5Aij8ZbCHz6dz6Q/MUCZKYeg4spTdPNQjKrxn4m8Dnf0Ev3
 7NkEo9+JWy0mOs66VLDfQ/2GoWPXpX7/VrOXfD3UhTSpkI+Vogq0Jsu98Rk4GhHTA2VL
 2Ejw==
X-Gm-Message-State: AOJu0YwbQyNgJqWBEzQ1UAXYU1UO1YEQYDbt8Y3V1XPEqpG018oM2dPI
 Jk5kS48hbbk62xnKrvFBGaH6XIg4KOJ7vcdvqAGxhPLrFeAIvVcbaaZ1zwcFtxhtG2G4TLghP1g
 p
X-Gm-Gg: ASbGnctkXt+Q8tF8HLF7VHFXJYa5LOZ3gCQgbpOAfMd3Q7q42EwpiACV7Zjgi0rL7Cs
 PVQCLhOvbRYymhdmzfu+lzA2NINUcF93yMJwVTdUATdn1p7ogr2FR9JZAhEX8OoZnxMI/FMdPbT
 59tvsk9ydTtpSUOhxKidDOtiDZnBefkOyK8MPh3YVt8FV3fBau8wEMrkTGyhDS2xjQZ0wENBfGZ
 QGxlIU3tuOJ00JPCfKGazfx2dSUasTszDC8Ik7pYuGNZvXHCAYK/8a0T/wBtQ==
X-Google-Smtp-Source: AGHT+IGUgRmY+dQjo3kO4AiHxkbBh9eXyuS+zsrjVhbnaUsyKTLck5lupM3qJK3w8/U0Pe5APthXJw==
X-Received: by 2002:a05:6000:4012:b0:385:ecdf:a30a with SMTP id
 ffacd0b85a97d-38880adb32cmr3273864f8f.33.1734111186486; 
 Fri, 13 Dec 2024 09:33:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/85] target/arm: Convert FJCVTZS to decodetree
Date: Fri, 13 Dec 2024 17:31:37 +0000
Message-Id: <20241213173229.3308926-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-id: 20241211163036.2297116-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 41 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5e170cec7a8..cd109616184 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1363,6 +1363,8 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
 FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
 FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
+FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
+
 # Floating-point data processing (1 source)
 
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 67227e26767..d260b45ddb2 100644
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
-- 
2.34.1


