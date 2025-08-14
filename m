Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508A5CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeU-000474-KA; Thu, 14 Aug 2025 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdH-0002jj-Tw
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdD-0005FG-4e
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2eb49b83so527788b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176668; x=1755781468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ovJLOo5Iz7w9oyScfUfi5Nm6yOe9LOjZOdiP+PMnCQ=;
 b=ubqVVZTNMXb7wo8jxmHu/XAAHFZr/6gWyzAwFC2RBc+svnC/U/nSKl+HUMGbOcKjqm
 pQQHrPSN/km+G+F0QtDpDSRMTBf8qVJWM6T3AuSz8HqSxuP4TBgJ7LXrhEMQ0Y/8fcVe
 SWKCAOgV7OWnBaSU5qIvTF5cVTnIyIi+0hN15gyBvdq2sTkQbiErRC62e1i5n7BPcmRU
 JqUjsggh/73b0Xm6Z9tdLVMJ3dzAmt76JDiIK3hLEFDEYPg+Yn2c4ugNq5D7bfFJBQip
 Rz+EDq3P+Myz9KW4DLv/fF5wGWfhqtuo/ia0JtTiO/IdpmHNm8jkNYymEqV1CKzsLMky
 3b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176668; x=1755781468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ovJLOo5Iz7w9oyScfUfi5Nm6yOe9LOjZOdiP+PMnCQ=;
 b=Zp0IV0zKs4v+avhHIBTE67lxY0m3Gezu57NIceFMWBD9KOr4OM1z28QANlkyWWaMA9
 KRHSgoeFqg9dDwcPr3WyerdAwEBphIKStsxEnLd/hqmmtnVgZPcxske41v1IFFmysh7G
 P8lDWt5Vb2tJUr6wh0frNygTbHKRXfKFH1DU/I1aTi7SkBuoFbkNeJUj9shVMlBMKV0H
 tU7a34jEqbLTYtQBIjJSKfVGFf7hYxPFl9PLYFXiUc00Lm56CflRALaT5UXP5U+3QRyo
 C6iGlyAyEKP9kiVHQ7WR8QvXhZdd4opzx3Z90s0h2mv2X2Xc0V5C1BvHiunnXu5yivuk
 jcPw==
X-Gm-Message-State: AOJu0YwhUh1tLv0SY14dMAvasbSnHm3EwlhVtYJeneqzAW+U6AuxYfLy
 Pf8HRLOfT8guIDtGmaD/fQz7e53MDmheQFpjIKyDDsgc//Tgis3vthBRAtl2WRo3+bTTk2DWd/g
 WrSjsHck=
X-Gm-Gg: ASbGnct/84oguXUw4W/GHoAEBhgv1yBKVAJwODdHUN6CiXLW98JRdBs0qbSjOtMUaJw
 Y3hbXPYDmmA3cMQu9p5gHgW3YCZi4kd2kkzqIOlaZbSNM1UBmfajGmBvXRGeD4rzjTeulH1erg9
 esVpQ6ZtHuyrbrWa5YikHoS8CtK/dP7bMQjm0SXZ8W2q/5Qcl/N47dMdySf9GfJG/28n2p93VpZ
 UyWTPp9vqu5o0WoO5NkR5fldB8hU1hUfXH4H/VIrKczTcus+D7wTPiQt2f+v4F9UHTP9qjywPGX
 QDY0ekZ9lkvJ/tmWfY5ftZ9PpPMmHI3QTr+Bk+TXvTXgw8sLIFP0FdmG0gi7m1PMImI9xPvt9of
 pYXJiC7dY8Efi8RKs8TYJr4rGmb0aYBCjNf8BAp1LQ6Pu3lk=
X-Google-Smtp-Source: AGHT+IHhVG3d4/RQmmSImi5jHw22tv/coqFbAJRqG09RUr4+MwZWRZMtyvTr5Pv+5G3TqP4MhNUO/A==
X-Received: by 2002:a05:6a00:2d0d:b0:749:bc7:1577 with SMTP id
 d2e1a72fcca58-76e2fc2af7amr4107904b3a.9.1755176668327; 
 Thu, 14 Aug 2025 06:04:28 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 62/85] target/arm: Implement GCSPOPX
Date: Thu, 14 Aug 2025 22:57:29 +1000
Message-ID: <20250814125752.164107-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3d76afd20b..084ea00e51 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index c688d0c391..2d39b17188 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -116,6 +116,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 75a6ff0452..7a51836cdc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2560,6 +2560,33 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_qemu_ld_i64(tmp, gcspr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, gcspr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(gcspr, addr, 8);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2855,6 +2882,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


