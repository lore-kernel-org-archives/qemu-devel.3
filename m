Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B208AE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdi-0007E6-Ef; Wed, 11 Dec 2024 11:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcj-0004T5-5d
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:46 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPch-0001Hd-8p
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:40 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4675118f591so8195611cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934698; x=1734539498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oj/RkpXIcAPwY3YCVzEeJhtiY5v3oKNvSYJvuwDEeY=;
 b=g4IArppNRNWFntlRyw3n+L73c8qmPsV2lnn/XKo3BQIJwj4pTgzYLd3ddBrLoNF2ts
 glrwtY5AakGgSu0Ht/DHy022UWMOGkDekJkbkCq7G/XkZznBcJmmsnr6Zje3GUimTkLG
 INBqT8LmFH/YDIWnIpOR9I7m4BF0Ep0d80l/4o9Cc1pDPAyAWkixH1ZP2OgNK4EjGaPf
 Q12aV804uyoU6jCKoOkjILWvs/rLv9mrT1zqSqzazT4lYsSE7Nt9bt5hLXNPGDsgexv1
 fqJCwYLP2QPU/ymC3VaDJLbz7tTpwmS6Ja8af7UUUxhUNc3ei5+et6XOZB/3wAMKx/Sh
 H7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934698; x=1734539498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oj/RkpXIcAPwY3YCVzEeJhtiY5v3oKNvSYJvuwDEeY=;
 b=IDNp8c9owZcT0mKrHeC+m/meWQO73O4hxkjUOBUII6zcZOpfgf10zOsnaGGQAXb/R3
 XEKVIx2S0CumPsxGDHwnWT/dY+nXZjwEcEIamu2TzxSMfnbiKBjOYDrIZ3MfQ/ydhEu8
 wj5/jMnqn8rnSnbfKZzbxCOSpz9JpF0XwRjygwU7pR6Oy0V+ZnpRN50ewhZhTFYHKgPd
 Un2WvXhGOBRPn43u1FQM5CLH8DtwfvXzODw3zMNR4IxOYhd669ydD/ArOVaxq1Xrhw6c
 U6vUjUmkgurVpFwzoeEOPe4kpSIf1oZ3uc2+j52NT+Ads3cCoMq+PrnxwJozop7HL6c+
 ROQg==
X-Gm-Message-State: AOJu0YxRDpUzmSkmR7ppOMSIjg9BnN1Zfybt0WD1GxlLlErIIMHk6HJY
 NPuNLNC4DCVoAuDg2rXyYAWq2WT0i7/iQE7TRaOI30BHMc0Xz1CT69EZBpSmneg19Z4RI7LH+Vm
 Ikuyl/ZhI
X-Gm-Gg: ASbGnctgwYxJJBxZgOFya8omOlTI+GR2ntPkiuK2/3krWuYTTUMtKAgIrkS/8U1cJMX
 fA6NQi6s1TrMYrvflAjXjnopnHFK/SQnYup+0rxrOv7D9twxJi9JsPRdvuCwsrtmUsOjczdjzUB
 DRTqjf81sJe3PH0yHqgvBJN/XnXhByeXQzrUCY4J5EtPRIis1V8D4eSTUEH2Hc4/UvtlRDGAHNS
 5jPazi+mcoRxI8Oe82nq4O3PUyYVyBcOE7uExy4CvYjPwXauYiTur6kYrUOWA==
X-Google-Smtp-Source: AGHT+IEOx5fmsYe4SxamX4imBfzM0O6rMb1M8c36Mcc4cfbQMTc/8oEpjFMr5aGDs5Xw42QN6q6iyA==
X-Received: by 2002:a05:622a:8c16:b0:467:7315:c63d with SMTP id
 d75a77b69052e-4678960e78amr53047251cf.23.1733934698344; 
 Wed, 11 Dec 2024 08:31:38 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/69] target/arm: Convert RMIF to decodetree
Date: Wed, 11 Dec 2024 10:29:43 -0600
Message-ID: <20241211163036.2297116-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 32 +++++++++-----------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d7747fcf57..1af41e22eb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8045,30 +8045,18 @@ TRANS(SBC, do_adc_sbc, a, true, false)
 TRANS(ADCS, do_adc_sbc, a, false, true)
 TRANS(SBCS, do_adc_sbc, a, true, true)
 
-/*
- * Rotate right into flags
- *  31 30 29                21       15          10      5  4      0
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 |  imm6  | 0 0 0 0 1 |  Rn  |o2| mask |
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- */
-static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
+static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
 {
-    int mask = extract32(insn, 0, 4);
-    int o2 = extract32(insn, 4, 1);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 15, 6);
-    int sf_op_s = extract32(insn, 29, 3);
+    int mask = a->mask;
     TCGv_i64 tcg_rn;
     TCGv_i32 nzcv;
 
-    if (sf_op_s != 5 || o2 != 0 || !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
+    if (!dc_isar_feature(aa64_condm_4, s)) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, 1);
-    tcg_gen_rotri_i64(tcg_rn, tcg_rn, imm6);
+    tcg_rn = read_cpu_reg(s, a->rn, 1);
+    tcg_gen_rotri_i64(tcg_rn, tcg_rn, a->imm);
 
     nzcv = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(nzcv, tcg_rn);
@@ -8086,6 +8074,7 @@ static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
     if (mask & 1) { /* V */
         tcg_gen_shli_i32(cpu_VF, nzcv, 31 - 0);
     }
+    return true;
 }
 
 /*
@@ -8297,11 +8286,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     switch (op2) {
     case 0x0:
         switch (op3) {
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            disas_rotate_right_into_flags(s, insn);
-            break;
-
         case 0x02: /* Evaluate into flags */
         case 0x12:
         case 0x22:
@@ -8311,6 +8295,8 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
         default:
         case 0x00: /* Add/subtract (with carry) */
+        case 0x01: /* Rotate right into flags */
+        case 0x21:
             goto do_unallocated;
         }
         break;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7a40ca455e..454494742e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,9 @@ SBC             . 10 11010000 ..... 000000 ..... .....  @rrr_sf
 SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 
 # Rotate right into flags
+
+RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
+
 # Evaluate into flags
 # Conditional compare (regster)
 # Conditional compare (immediate)
-- 
2.43.0


