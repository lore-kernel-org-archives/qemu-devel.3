Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C552E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2wN-0002Yo-V3; Tue, 10 Dec 2024 11:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wM-0002YN-1y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:26 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wK-0006Lo-5x
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:25 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401b7f7141so2257609e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847502; x=1734452302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dd2z3le99kkpxlOwdQvMHijmJlZPpIOT1HfWKqviurA=;
 b=WDXaL0rZ9mz/5mxWvcgWSMSq5z80gVWsv4Pb9qVDWEAW0cIfz2MnnLIRhSbRREJeXy
 PLcTzjJ6mDB0aimZN1imXViI6rph3bJUl5MFhqovrEqHsE3BXOXEJLWcIpBDwMPw6wph
 j8wvPsWF27lqgMJx0+wgTntIQ0G3aRj1Ut60J3ydtBpCWVr0cpqjFlU8QIkd0ak8tBDa
 Olom+TT9xuRxlJjRtFoUvHxjbycdFDeAPIoiw7s6xvRJ0eyWQW/6DiRz0BiplyO+5/so
 HSfq71y2T/hGHFa+pmnQcVnyEoZyuTa9ifX/fgIPcQ0T0vrZVlO8mbjRHvpfJgsc3p8h
 ME1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847502; x=1734452302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dd2z3le99kkpxlOwdQvMHijmJlZPpIOT1HfWKqviurA=;
 b=Kotz9nCRNTnR2bHizqEKXc5BUXzVz86pzbXlz8vzSI88656Td7w5ZvASHkfjUaFpq5
 KD5se48J6RUjDzLz5JJop7IwZACjdfdL3u17/4ArgcN2//wD7IYOyThlPydF4PWkqVhx
 kOzOH4bPy7VgEEz661Xmv0j8AQ778K9h4TLvqgKX/vqGZGn/etnEsCD+hWPOD4GoZ1Fi
 qtzn/VZ3tFsXzJChHxAzNQLDIUsC9b3HnFEQoDap62oA1+OnfcP8xRH26Yo5h7MHbHAJ
 P4uy6lpm1msOyrLbiGlfyHA8H8KzpbKiS6EP8Cjqww1GSmv2u2KfSfdAmQlMA7xqtO3M
 jvUA==
X-Gm-Message-State: AOJu0Yy2A8utGQhD80LkxBdb3rFTLhIaVa1ysL8piekiAaeOjqlhNa72
 a3tdyxXY9rxkcxFuinJXC+9AzgP9RdVo1twV72c5i/cpGEWINlP1/umGxAJNDzRtmXm33dBK+B4
 m6yIzOOpo
X-Gm-Gg: ASbGnctD4AgjMLnt9EyHNXGKcuHn8TLci83/+WxZxmHRPZm6280ML0+O7zSePpZCjtd
 8KBFy5puGyqoaQx3iMsLHelRv8IP5X1oRu1pJ7YfUWVM+9XMVaHz4yO6wk/HyPr0MXPY4vrOy7c
 khmptVhgYZP/qWpCTUCqR1/GlBIqXjibpqC9ePhcakF4t9Z4Jp/pBTrYtuSl3OiFAgsUSn3zO25
 XEoNL8fnK8E4b0MTtvlih7bXUsYPvSXzdlrLLmGR+WR+v2RWldfgX1O+qQ=
X-Google-Smtp-Source: AGHT+IFIQUyYb7C2EGZczuTUvwZcmqGwBxxCQPZLLBK/HsJOmi0j+qZQVBsPCXNTvdsAVp5uqJYlow==
X-Received: by 2002:a05:6512:402a:b0:53e:39c2:f02b with SMTP id
 2adb3069b0e04-53e39c2f164mr4539323e87.42.1733847502509; 
 Tue, 10 Dec 2024 08:18:22 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/69] target/arm: Convert XPAC[ID] to decodetree
Date: Tue, 10 Dec 2024 10:16:34 -0600
Message-ID: <20241210161733.1830573-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

Remove disas_data_proc_1src, as these were the last insns
decoded by that function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 99 +++++-----------------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 16 insertions(+), 86 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 852545dfcc..d92fe68299 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7793,6 +7793,18 @@ TRANS_FEAT(AUTIB, aa64_pauth, gen_pacaut, a, gen_helper_autib)
 TRANS_FEAT(AUTDA, aa64_pauth, gen_pacaut, a, gen_helper_autda)
 TRANS_FEAT(AUTDB, aa64_pauth, gen_pacaut, a, gen_helper_autdb)
 
+static bool do_xpac(DisasContext *s, int rd, NeonGenOne64OpEnvFn *fn)
+{
+    if (s->pauth_active) {
+        TCGv_i64 tcg_rd = cpu_reg(s, rd);
+        fn(tcg_rd, tcg_env, tcg_rd);
+    }
+    return true;
+}
+
+TRANS_FEAT(XPACI, aa64_pauth, do_xpac, a->rd, gen_helper_xpaci)
+TRANS_FEAT(XPACD, aa64_pauth, do_xpac, a->rd, gen_helper_xpacd)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8377,84 +8389,6 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Data-processing (1 source)
- *   31  30  29  28             21 20     16 15    10 9    5 4    0
- * +----+---+---+-----------------+---------+--------+------+------+
- * | sf | 1 | S | 1 1 0 1 0 1 1 0 | opcode2 | opcode |  Rn  |  Rd  |
- * +----+---+---+-----------------+---------+--------+------+------+
- */
-static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
-{
-    unsigned int sf, opcode, opcode2, rn, rd;
-    TCGv_i64 tcg_rd;
-
-    if (extract32(insn, 29, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    sf = extract32(insn, 31, 1);
-    opcode = extract32(insn, 10, 6);
-    opcode2 = extract32(insn, 16, 5);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-#define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
-
-    switch (MAP(sf, opcode2, opcode)) {
-    case MAP(1, 0x01, 0x10): /* XPACI */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_xpaci(tcg_rd, tcg_env, tcg_rd);
-        }
-        break;
-    case MAP(1, 0x01, 0x11): /* XPACD */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_xpacd(tcg_rd, tcg_env, tcg_rd);
-        }
-        break;
-    default:
-    do_unallocated:
-    case MAP(0, 0x00, 0x00): /* RBIT */
-    case MAP(1, 0x00, 0x00):
-    case MAP(0, 0x00, 0x01): /* REV16 */
-    case MAP(1, 0x00, 0x01):
-    case MAP(0, 0x00, 0x02): /* REV/REV32 */
-    case MAP(1, 0x00, 0x02):
-    case MAP(1, 0x00, 0x03): /* REV64 */
-    case MAP(0, 0x00, 0x04): /* CLZ */
-    case MAP(1, 0x00, 0x04):
-    case MAP(0, 0x00, 0x05): /* CLS */
-    case MAP(1, 0x00, 0x05):
-    case MAP(1, 0x01, 0x00): /* PACIA */
-    case MAP(1, 0x01, 0x01): /* PACIB */
-    case MAP(1, 0x01, 0x02): /* PACDA */
-    case MAP(1, 0x01, 0x03): /* PACDB */
-    case MAP(1, 0x01, 0x04): /* AUTIA */
-    case MAP(1, 0x01, 0x05): /* AUTIB */
-    case MAP(1, 0x01, 0x06): /* AUTDA */
-    case MAP(1, 0x01, 0x07): /* AUTDB */
-    case MAP(1, 0x01, 0x08): /* PACIZA */
-    case MAP(1, 0x01, 0x09): /* PACIZB */
-    case MAP(1, 0x01, 0x0a): /* PACDZA */
-    case MAP(1, 0x01, 0x0b): /* PACDZB */
-    case MAP(1, 0x01, 0x0c): /* AUTIZA */
-    case MAP(1, 0x01, 0x0d): /* AUTIZB */
-    case MAP(1, 0x01, 0x0e): /* AUTDZA */
-    case MAP(1, 0x01, 0x0f): /* AUTDZB */
-        unallocated_encoding(s);
-        break;
-    }
-
-#undef MAP
-}
-
-
 /*
  * Data processing - register
  *  31  30 29  28      25    21  20  16      10         0
@@ -8464,7 +8398,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
  */
 static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
-    int op0 = extract32(insn, 30, 1);
     int op1 = extract32(insn, 28, 1);
     int op2 = extract32(insn, 21, 4);
     int op3 = extract32(insn, 10, 6);
@@ -8517,19 +8450,13 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         disas_cond_select(s, insn);
         break;
 
-    case 0x6: /* Data-processing */
-        if (op0) {    /* (1 source) */
-            disas_data_proc_1src(s, insn);
-        } else {      /* (2 source) */
-            goto do_unallocated;
-        }
-        break;
     case 0x8 ... 0xf: /* (3 source) */
         disas_data_proc_3src(s, insn);
         break;
 
     default:
     do_unallocated:
+    case 0x6: /* Data-processing */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9083ac4ac3..0e04ab6ce4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -712,6 +712,9 @@ AUTIB           1 10 11010110 00001 00.101 ..... .....  @pacaut
 AUTDA           1 10 11010110 00001 00.110 ..... .....  @pacaut
 AUTDB           1 10 11010110 00001 00.111 ..... .....  @pacaut
 
+XPACI           1 10 11010110 00001 010000 11111 rd:5
+XPACD           1 10 11010110 00001 010001 11111 rd:5
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
-- 
2.43.0


