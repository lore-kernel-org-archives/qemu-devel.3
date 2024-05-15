Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8Z-00086a-H1; Wed, 15 May 2024 05:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8M-0006gr-2E
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8H-0001hd-6k
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34d96054375so5141207f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766066; x=1716370866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8q1OpwWihKw1ijiMc4D+Z2wUuOrfl9evV0q3/vj37w=;
 b=m8+AjhmqnzMmm4HveXEy3RVVKCW7Rb1SKF/crjhGYVZE4qhRWnp/fjqKYYyfRhAyx9
 HKF7nyRp6UaqGX4WYcopkJoyXz0uH/VcsWaeuRpGESboE7pTc2QNLTmtt6YHvQjiskpi
 37qYRohwWeoAVnYleC5peXcrF6csKw56RVD0P5RRafaLdWi0xiJKcDikUyr5WF3iPzP7
 QBhV5/5D62bdrhN2WkbVrt9dBvKzg3g50hTBkofrFxJPGCYM8vunVggq7R3t2mZ0p/az
 SYxBajbfLQNJh4rRG6tSQAS4RKY+J1o0Xa3w9l1e3jWdRtL/BnOkZdw52gzt/MRAKNXm
 fDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766067; x=1716370867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8q1OpwWihKw1ijiMc4D+Z2wUuOrfl9evV0q3/vj37w=;
 b=tGWvpvBMWQcAOJIe2pFK5V9DVc7D6Dp/oNKZGaRO/0QyPXNN9xWWoajeuWcjJYDkWT
 somuKdspU1I/Nr29Tk1TnHQ5w7Rd/PrPad/d2xuDt45EsUTp0KbpyHYU3syv0hb26sGK
 ubSFr++bo9LqMIB4aBVLC5S1/NBLjoKWXM/GkgugzGy76LkrNMWmcXvm+K8y3zdDxfCj
 qPdkHxqDXaKzo/1UFXWRLa3M+x8b/7JBVBNHsEQxRMdI385PXlCV2LmueY8a+JEhfagq
 tX3BfzNU+Ds5Tr/qHb7XJ5NpJV7baoIWGMRcfBBZy5DDWnKGw/zYHrcyNk9ctOT7g+dU
 SBSA==
X-Gm-Message-State: AOJu0YxwBY12zcLOxeMBvodRViVdmjm0h+GwWAT8fREmsu7zRHkwpmmx
 WFFetFxk7wE8N8nAQTGtdmxZaNQzdkoNqxi500PTGB0tXWkkycK4ZV5dvV85uS0mPr9oGWXcY3H
 eoR8=
X-Google-Smtp-Source: AGHT+IG6FKWWOvqyjMMFok0LtbsDn11qFlgYk0q4vG+MAN9ArMYleHYUbLV/Y4JfHOQtG54NDG2CyA==
X-Received: by 2002:a05:6000:1a8d:b0:351:b882:4e2f with SMTP id
 ffacd0b85a97d-351b8824fa3mr7733237f8f.57.1715766066670; 
 Wed, 15 May 2024 02:41:06 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 30/43] target/hppa: Use delay_excp for conditional trap on
 overflow
Date: Wed, 15 May 2024 11:40:30 +0200
Message-Id: <20240515094043.82850-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c |  2 +-
 target/hppa/op_helper.c  |  7 -------
 target/hppa/translate.c  | 21 +++++++++++++--------
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 3d0d143aed..c12b48a04a 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,5 +1,4 @@
 DEF_HELPER_2(excp, noreturn, env, int)
-DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 1aa3e88ef1..97e5f0b9a7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -134,13 +134,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         switch (i) {
         case EXCP_ILL:
         case EXCP_BREAK:
+        case EXCP_OVERFLOW:
         case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
             /* IIR set via translate.c.  */
             break;
 
-        case EXCP_OVERFLOW:
         case EXCP_ASSIST:
         case EXCP_DTLB_MISS:
         case EXCP_NA_ITLB_MISS:
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a8b69fd481..66cad78a57 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -42,13 +42,6 @@ G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
-{
-    if (unlikely((target_long)cond < 0)) {
-        hppa_dynamic_excp(env, EXCP_OVERFLOW, GETPC());
-    }
-}
-
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ae291124f2..16b25a9ede 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1136,6 +1136,17 @@ static void gen_tc(DisasContext *ctx, DisasCond *cond)
     }
 }
 
+static void gen_tsv(DisasContext *ctx, TCGv_i64 *sv, bool d)
+{
+    DisasCond cond = do_cond(ctx, /* SV */ 12, d, NULL, NULL, *sv);
+    DisasDelayException *e = delay_excp(ctx, EXCP_OVERFLOW);
+
+    tcg_gen_brcond_i64(cond.c, cond.a0, cond.a1, e->lab);
+
+    /* In the non-trap path, V is known zero. */
+    *sv = tcg_constant_i64(0);
+}
+
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
@@ -1178,10 +1189,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2, orig_in1, shift, d);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
@@ -1282,10 +1290,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
-- 
2.34.1


