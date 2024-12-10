Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A0E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2w8-0002UZ-Il; Tue, 10 Dec 2024 11:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2w5-0002Tn-Dm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:09 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2w3-0006Iu-5X
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:09 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso2534509e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847485; x=1734452285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OheJzngdS+HhJoEVosRxkCExJJDmRaec59L8+hjrWV0=;
 b=UUtj3BR8ZVebn1zMm/dxDMHkSNLuk4w21fZHE4SvxGscyzfM5z7swfUDQvX5WPlipU
 zkCVF5acsShyiqUfJm9L5mPo2LC6euS8i2Erj60LQLBAoUSuvGdxcfTZE1VmGwlEbh7z
 g1bkUXr33eYVpTbMgG6Nr3j2HMXyQSquijdzNzkMy0eqOxzPbLDMSswwxGw0SrVfqZfS
 MaUt2r0ZbrYhPL4A8SmWeYT6+OPJN0N9wHa8371+PHFArjcyLo9KG9FWj8KCXjjMEpLf
 kNmTrqomKUSRB0nuNVvoPP1+KsjXGTblWwfYJwW9R9h4dp+JC7KhHUlNge0/qIAE3XtT
 owQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847485; x=1734452285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OheJzngdS+HhJoEVosRxkCExJJDmRaec59L8+hjrWV0=;
 b=gzNiJJvl6BcWts76SYbQLa7/tORj0QlzF5fkXD1hFuKgZNz1r+YyKAA209jNYutkvr
 72yvNi8kv8WLWivqsVk59EAERhtdsEtzov18OeWpg8WkegMVWpUMSB9aXsD/faZi+phg
 E+8w7tYci6cdeqrg3G3nMH7BZWSgoCTKYI3dTU6Q5/q07AneEvUSMq3mpCJpkCgBOJLi
 CyLPqte9xZ9QckYQ+YnMzqMTcgOOtp8e5b0TMPyncBSCiYmu/zMYkXe7fbXKWr7VnbyX
 MfQWAl3zWCcEHuJAkddABpEGKSEjk2zr4JZI6hVV1C3Za5crRXcQ6ABAyuuMeRUjXCa5
 /nxA==
X-Gm-Message-State: AOJu0YwCAqgdiATNwF9F/9jlomvyub7EQe2RI1nBLbvcTKSpn372Z3Bq
 x7N1vbq6An84VuMchopcOo4hu12HY9wmAC4cv2+s2xzhE4Ovga5AS8bXWkJ336TuF1lbfPPSisX
 DvZGSHXej
X-Gm-Gg: ASbGnct8c3FNLuurSvzlVEV90n89/EcGW/wECMc7eUVocskbi65+ntup7YOy1U/hveA
 YZAjQBod1D1pi/tqDVD1z7CIEdTdIbQM78b5W8geMyui945vvnGcFdgXUQ/PhVc95mxQioFGsMG
 qrnrquvSnYCg3uPObAL9h2c9ylVNtzjOeAaCFCMVVE/C+3zgPPndp/f/3Vz5qcR+fvjGAZ1+ka2
 zmG9e1V0SQnqpZmRQBkGLNN+3Vz7f77HsycyFwsCHop7W1qlV0b42d2dHI=
X-Google-Smtp-Source: AGHT+IHC5H/BHhmpWYcXDgh675SI3Wre+dOeDOB8Gmk/rSYLwd4c8H09EDf6i2BEXyRlJZS3GhXOPg==
X-Received: by 2002:a05:6512:23a9:b0:53e:6503:4b45 with SMTP id
 2adb3069b0e04-540240bc9abmr2437525e87.17.1733847485005; 
 Tue, 10 Dec 2024 08:18:05 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/69] target/arm: Convert PACGA to decodetree
Date: Tue, 10 Dec 2024 10:16:30 -0600
Message-ID: <20241210161733.1830573-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
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

Remove disas_data_proc_2src, as this was the last insn
decoded by that function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 65 ++++++----------------------------
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00e55d42ff..ca8b644dc7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7674,6 +7674,16 @@ static bool trans_GMI(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+static bool trans_PACGA(DisasContext *s, arg_rrr *a)
+{
+    if (dc_isar_feature(aa64_pauth, s)) {
+        gen_helper_pacga(cpu_reg(s, a->rd), tcg_env,
+                         cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm));
+        return true;
+    }
+    return false;
+}
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8555,59 +8565,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* Data-processing (2 source)
- *   31   30  29 28             21 20  16 15    10 9    5 4    0
- * +----+---+---+-----------------+------+--------+------+------+
- * | sf | 0 | S | 1 1 0 1 0 1 1 0 |  Rm  | opcode |  Rn  |  Rd  |
- * +----+---+---+-----------------+------+--------+------+------+
- */
-static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
-{
-    unsigned int sf, rm, opcode, rn, rd, setflag;
-    sf = extract32(insn, 31, 1);
-    setflag = extract32(insn, 29, 1);
-    rm = extract32(insn, 16, 5);
-    opcode = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (setflag && opcode != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 12: /* PACGA */
-        if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        gen_helper_pacga(cpu_reg(s, rd), tcg_env,
-                         cpu_reg(s, rn), cpu_reg_sp(s, rm));
-        break;
-    default:
-    do_unallocated:
-    case 0: /* SUBP(S) */
-    case 2: /* UDIV */
-    case 3: /* SDIV */
-    case 4: /* IRG */
-    case 5: /* GMI */
-    case 8: /* LSLV */
-    case 9: /* LSRV */
-    case 10: /* ASRV */
-    case 11: /* RORV */
-    case 16:
-    case 17:
-    case 18:
-    case 19:
-    case 20:
-    case 21:
-    case 22:
-    case 23: /* CRC32 */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 /*
  * Data processing - register
  *  31  30 29  28      25    21  20  16      10         0
@@ -8674,7 +8631,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         if (op0) {    /* (1 source) */
             disas_data_proc_1src(s, insn);
         } else {      /* (2 source) */
-            disas_data_proc_2src(s, insn);
+            goto do_unallocated;
         }
         break;
     case 0x8 ... 0xf: /* (3 source) */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f0a5ffb1cd..a23d6a6645 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -682,6 +682,8 @@ SUBPS           1 01 11010110 ..... 000000 ..... .....  @rrr
 IRG             1 00 11010110 ..... 000100 ..... .....  @rrr
 GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 
+PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
-- 
2.43.0


