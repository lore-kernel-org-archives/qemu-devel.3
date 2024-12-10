Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3693E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xJ-0003B0-7H; Tue, 10 Dec 2024 11:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wo-0002na-R7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:01 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wm-0006Qk-Rj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:54 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53ff1f7caaeso3305173e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847531; x=1734452331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LirZcHgHdp9tBVrM59CgIjq2zHMAEgw0F35SBHQ2JzQ=;
 b=LqQVUnBlT6ufxGBO4V/GjZlv61xRLFywlYNyyWRscreY0OisqGB2+IxCNQFLHCVHT6
 GcEGdnge0m18VzRWhzvm+8YVvYl0JOXeaB6WTGkBe5yu1OY82QZNx81ulYuN67SrDLqF
 ci0roFzIjOYqAqdDuNeMqeQ58rjCgP6FijNw0JrrKfa5mlRadsoZQPvQb1T3uiiS9b6k
 dNPqK7TPTKaLTk2PgFhyqM5i62/6cY92kGARclj9mivuPJHCkFut7Jx5M/r3dPajZm8u
 NvsP/r8dHO6Y8NBMvG3csU0H6EpDTvZN0/eSpiayR39PCOipdpOOBVSp9cQ+B1iXmcge
 nRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847531; x=1734452331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LirZcHgHdp9tBVrM59CgIjq2zHMAEgw0F35SBHQ2JzQ=;
 b=w1pJ8+mPlDoWMoQDRH99luet6tT8raYms8vJpI+VrOeEmT+HG9GLGL/SYXXUWiMvx2
 rHYJsOMs002K4P34VkkaQZ4LSrsncbcSmjBbtDC3w2mgsGEBlWMw5o30B0d3wuhFDAJi
 MCp4FjXP2Jzj5wAH5Y14flGu4MKRg1zguy2DVLeNjUxbW5CmXOCH4vrcPIGOr2Y0NNR2
 45/l0XBdDKR//slhC2HvUjo3K20XohlvmQxz2q18dfk7z5ahE6XgBks9izZ6o1x7J1/x
 i63q5Zw5nhinNtU1lKfH+lkGcSWwUXvZa6BNmEiKuBxw2E7qKZYDmIB4uQGS1F3IP/DA
 8axw==
X-Gm-Message-State: AOJu0YxFrDK+rvWcN7SeEKLtfEW4M14wWT98fWh2+B3uQB1Z3x7gAOsG
 rCK7sk0aU1Be91pCRdBSgJwKM3boj58m6XMuZBu+gXedJhCiXh1XWt3h704h+eOpVjaMFAEq5es
 AFySqzcFZ
X-Gm-Gg: ASbGncspo8BbB+rjrYl6LOJIrsgvsGU7bEzmOweP9tiRzZ5YLSxFueEkhEhloaP3ivS
 KuIxT2FbHvqKBjF3HT21f6IWZOPgXq1GcbvRjjyftsQRCpyqpfPAXkoOKZWe++OtL68LO79DtiS
 M1C4rojI2zhvdnBu1KqMh7+BWgVRiFtpdcZrTVKR9mlZrvpngt9tThgKdtc1OsAkESG3QMMDqqZ
 CqhQmN/9X51CDpqh4lITfCvK4Gg37AHrqGXpW7IJHXl6q4+ZwhGpHHm0bk=
X-Google-Smtp-Source: AGHT+IF+IA0GWrudDbzOzmyd+9cjSFjOnA40P5TUZrurpx/WAArOD8ZMONWaD1LkrVCVVdvP8WHa0g==
X-Received: by 2002:a05:6512:3e01:b0:53e:389d:8ce4 with SMTP id
 2adb3069b0e04-540240e1cf3mr1970327e87.34.1733847531019; 
 Tue, 10 Dec 2024 08:18:51 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/69] target/arm: Convert SETF8, SETF16 to decodetree
Date: Tue, 10 Dec 2024 10:16:41 -0600
Message-ID: <20241210161733.1830573-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 48 +++++-----------------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1af41e22eb..774689641d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8077,38 +8077,21 @@ static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
     return true;
 }
 
-/*
- * Evaluate into flags
- *  31 30 29                21        15   14        10      5  4      0
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 | opcode2 | sz | 0 0 1 0 |  Rn  |o3| mask |
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- */
-static void disas_evaluate_into_flags(DisasContext *s, uint32_t insn)
+static bool do_setf(DisasContext *s, int rn, int shift)
 {
-    int o3_mask = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int o2 = extract32(insn, 15, 6);
-    int sz = extract32(insn, 14, 1);
-    int sf_op_s = extract32(insn, 29, 3);
-    TCGv_i32 tmp;
-    int shift;
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    if (sf_op_s != 1 || o2 != 0 || o3_mask != 0xd ||
-        !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-    shift = sz ? 16 : 24;  /* SETF16 or SETF8 */
-
-    tmp = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rn));
     tcg_gen_shli_i32(cpu_NF, tmp, shift);
     tcg_gen_shli_i32(cpu_VF, tmp, shift - 1);
     tcg_gen_mov_i32(cpu_ZF, cpu_NF);
     tcg_gen_xor_i32(cpu_VF, cpu_VF, cpu_NF);
+    return true;
 }
 
+TRANS_FEAT(SETF8, aa64_condm_4, do_setf, a->rn, 24)
+TRANS_FEAT(SETF16, aa64_condm_4, do_setf, a->rn, 16)
+
 /* Conditional compare (immediate / register)
  *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
  * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
@@ -8277,30 +8260,12 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
     int op1 = extract32(insn, 28, 1);
     int op2 = extract32(insn, 21, 4);
-    int op3 = extract32(insn, 10, 6);
 
     if (!op1) {
         goto do_unallocated;
     }
 
     switch (op2) {
-    case 0x0:
-        switch (op3) {
-        case 0x02: /* Evaluate into flags */
-        case 0x12:
-        case 0x22:
-        case 0x32:
-            disas_evaluate_into_flags(s, insn);
-            break;
-
-        default:
-        case 0x00: /* Add/subtract (with carry) */
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            goto do_unallocated;
-        }
-        break;
-
     case 0x2: /* Conditional compare */
         disas_cc(s, insn); /* both imm and reg forms */
         break;
@@ -8311,6 +8276,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
     default:
     do_unallocated:
+    case 0x0:
     case 0x6: /* Data-processing */
     case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 454494742e..ae2c6831d7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -757,6 +757,10 @@ SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
 
 # Evaluate into flags
+
+SETF8           0 01 11010000 00000 000010 rn:5 01101
+SETF16          0 01 11010000 00000 010010 rn:5 01101
+
 # Conditional compare (regster)
 # Conditional compare (immediate)
 # Conditional select
-- 
2.43.0


