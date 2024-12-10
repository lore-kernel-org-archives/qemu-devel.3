Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2841E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2wK-0002Xn-3C; Tue, 10 Dec 2024 11:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wI-0002XV-IH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:22 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wG-0006LB-DX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:22 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53ff1f7caaeso3304413e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847499; x=1734452299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyFQvqa4ZP5fftH7OfmG1SrHIoV27DETz0Thv1W0mFA=;
 b=wxfCKH4677cCN8GoYrerGE1rI2rBtBzNBvte0dpw/en4y5/e6PI4PVMdhXnW9euEHY
 kMtHZT55h9wfDDAdPA4DjjDzEEmJeZCTtS36GOu/6yRe7fAjoba1MbvjyN5PKAj6cEFK
 0+AHec8XKcrVQ4cNq3fAshnDs9ZF93E2SkOjBYeX2HJjPOaWLsD4YMfL3ffoiqP3H19n
 WHtf33o/DR2cdpb1D5DQzroP2BqEB6vEtvIrIUlPq1+XS5lEWPacEhEd9ti0uygYf+nR
 RXrpqUGiYgsMMpNTKhbgJfNaKeFuR5FxLP3xj7PnoQ65IMTn6DtnP91jPzOmLQlvxTe1
 HIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847499; x=1734452299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyFQvqa4ZP5fftH7OfmG1SrHIoV27DETz0Thv1W0mFA=;
 b=YSsO/99DCRzfyhXA4jI5EhtujNXRq4Btavn8DeSR6chzAS69/muDaNHytGdgGNBYqy
 Lk0xa8lt2vfHPiHBcCEvHTyVahUBrTlVNyyS2+XyFduvURdLWcznbqfCiidO8iHrgdgx
 2Iyc32e/r+c9cxFzAtW8DA4H7qzyFiw4j+sFaosPgVahRQvI4PG2oxn6+3GcQeKWnyp1
 /9wZR/WUeZE8rYoD95amAwjracC6FGOFSiq+xC/eNIiL+eYPpj6+5eLcqvD1GNyDXG+I
 nzFI8+sWsBJ9k5czbAz+cBzb4UH/ur55FZ9wTfkyYy3IOy7+uhPc5oe3idkn4f4MYzP8
 q4Qw==
X-Gm-Message-State: AOJu0Yy0tpPtD4yGIbDAP/xEbNfT/AKnO6fq5rMfRi6yK0yfik1bmNh3
 Rux8CVZoQweauX9lr+O3ETNPRJizR/asb4Gkq3glE6GJtJXfXxvaf21yZ8Boj93+sKlzH4tIaZ2
 e7N2yVHuU
X-Gm-Gg: ASbGncshz8Dvxe1lkI3G2/WO+kQFT9+d0lTNfuaAa6ywxtZ5Z/dVWIt2ncEYvZTSfk4
 etcQvfLUAyxTX+9869rYrJUVxY2EKB4NJ9lMmld25phxVcMluUxyZyhi0L+XCi2sWn2x8FRzv2s
 uj4q/tyYanYMjQVREavHOM+teR0PuXl8376+s5H3tY0OOMCRBmkRulF332ZlIPjUU6xUVten1my
 igsKc7tSzIApc/rvkEWhDYMJuLnAh1iR0a+o/gVf3qUdGN7II36wtavBvM=
X-Google-Smtp-Source: AGHT+IF71oDLq2KyZhHmglvOYvUoedy+ilDRnfWHCOZqqcR9nG8aweeG2I+jeLll3aKbCuzc+JJ0Ow==
X-Received: by 2002:a05:6512:138c:b0:540:1a0c:9ba4 with SMTP id
 2adb3069b0e04-540240d2faemr1572220e87.29.1733847498707; 
 Tue, 10 Dec 2024 08:18:18 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/69] target/arm: Convert PAC[ID]*, AUT[ID]* to decodetree
Date: Tue, 10 Dec 2024 10:16:33 -0600
Message-ID: <20241210161733.1830573-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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

This includes PACIA, PACIZA, PACIB, PACIZB, PACDA, PACDZA, PACDB,
PACDZB, AUTIA, AUTIZA, AUTIB, AUTIZB, AUTDA, AUTDZA, AUTDB, AUTDZB.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 173 +++++++++------------------------
 target/arm/tcg/a64.decode      |  13 +++
 2 files changed, 58 insertions(+), 128 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 552b45b4e2..852545dfcc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7764,6 +7764,35 @@ static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
 TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
 
+static bool gen_pacaut(DisasContext *s, arg_pacaut *a, NeonGenTwo64OpEnvFn fn)
+{
+    TCGv_i64 tcg_rd, tcg_rn;
+
+    if (a->z) {
+        if (a->rn != 31) {
+            return false;
+        }
+        tcg_rn = tcg_constant_i64(0);
+    } else {
+        tcg_rn = cpu_reg_sp(s, a->rn);
+    }
+    if (s->pauth_active) {
+        tcg_rd = cpu_reg(s, a->rd);
+        fn(tcg_rd, tcg_env, tcg_rd, tcg_rn);
+    }
+    return true;
+}
+
+TRANS_FEAT(PACIA, aa64_pauth, gen_pacaut, a, gen_helper_pacia)
+TRANS_FEAT(PACIB, aa64_pauth, gen_pacaut, a, gen_helper_pacib)
+TRANS_FEAT(PACDA, aa64_pauth, gen_pacaut, a, gen_helper_pacda)
+TRANS_FEAT(PACDB, aa64_pauth, gen_pacaut, a, gen_helper_pacdb)
+
+TRANS_FEAT(AUTIA, aa64_pauth, gen_pacaut, a, gen_helper_autia)
+TRANS_FEAT(AUTIB, aa64_pauth, gen_pacaut, a, gen_helper_autib)
+TRANS_FEAT(AUTDA, aa64_pauth, gen_pacaut, a, gen_helper_autda)
+TRANS_FEAT(AUTDB, aa64_pauth, gen_pacaut, a, gen_helper_autdb)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8373,134 +8402,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(1, 0x01, 0x00): /* PACIA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacia(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x01): /* PACIB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacib(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x02): /* PACDA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacda(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x03): /* PACDB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacdb(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x04): /* AUTIA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autia(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x05): /* AUTIB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autib(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x06): /* AUTDA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autda(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x07): /* AUTDB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autdb(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x08): /* PACIZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacia(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x09): /* PACIZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacib(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0a): /* PACDZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacda(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0b): /* PACDZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacdb(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0c): /* AUTIZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autia(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0d): /* AUTIZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autib(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0e): /* AUTDZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autda(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0f): /* AUTDZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autdb(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
     case MAP(1, 0x01, 0x10): /* XPACI */
         if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
             goto do_unallocated;
@@ -8530,6 +8431,22 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
     case MAP(1, 0x00, 0x04):
     case MAP(0, 0x00, 0x05): /* CLS */
     case MAP(1, 0x00, 0x05):
+    case MAP(1, 0x01, 0x00): /* PACIA */
+    case MAP(1, 0x01, 0x01): /* PACIB */
+    case MAP(1, 0x01, 0x02): /* PACDA */
+    case MAP(1, 0x01, 0x03): /* PACDB */
+    case MAP(1, 0x01, 0x04): /* AUTIA */
+    case MAP(1, 0x01, 0x05): /* AUTIB */
+    case MAP(1, 0x01, 0x06): /* AUTDA */
+    case MAP(1, 0x01, 0x07): /* AUTDB */
+    case MAP(1, 0x01, 0x08): /* PACIZA */
+    case MAP(1, 0x01, 0x09): /* PACIZB */
+    case MAP(1, 0x01, 0x0a): /* PACDZA */
+    case MAP(1, 0x01, 0x0b): /* PACDZB */
+    case MAP(1, 0x01, 0x0c): /* AUTIZA */
+    case MAP(1, 0x01, 0x0d): /* AUTIZB */
+    case MAP(1, 0x01, 0x0e): /* AUTDZA */
+    case MAP(1, 0x01, 0x0f): /* AUTDZB */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 410eaa9333..9083ac4ac3 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -699,6 +699,19 @@ REV64           1 10 11010110 00000 000011 ..... .....  @rr
 CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
 CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
 
+&pacaut         rd rn z
+@pacaut         . .. ........ ..... .. z:1 ... rn:5 rd:5  &pacaut
+
+PACIA           1 10 11010110 00001 00.000 ..... .....  @pacaut
+PACIB           1 10 11010110 00001 00.001 ..... .....  @pacaut
+PACDA           1 10 11010110 00001 00.010 ..... .....  @pacaut
+PACDB           1 10 11010110 00001 00.011 ..... .....  @pacaut
+
+AUTIA           1 10 11010110 00001 00.100 ..... .....  @pacaut
+AUTIB           1 10 11010110 00001 00.101 ..... .....  @pacaut
+AUTDA           1 10 11010110 00001 00.110 ..... .....  @pacaut
+AUTDB           1 10 11010110 00001 00.111 ..... .....  @pacaut
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
-- 
2.43.0


