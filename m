Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E1BC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPm-0003wa-LU; Sun, 27 Jul 2025 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPO-0001ov-UQ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPM-0004ki-TT
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2350b1b9129so23722765ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603619; x=1754208419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhhZA/6ifKL4l4jO2ipFN7HTrNIURT3W9UEWXRBt4U8=;
 b=rYMRsGyWEpPMC4XMooCswj/1+kIt7klBQYVBamYDf9FzpN9jyneWoxvd8/cLuHaiPo
 NSKJORIeEz41EuTWNunTpWYXxfAmdCD5gXTkCCClhUOPG2MvkUi3RN5GH1qqmP1iEVM7
 V2zHJ1WXkwPoOHQ8QnZXhCaGaNuuwFzVQ27LoLwWG1LfWBhfasbK1hIG+U0EqxZphth0
 V3M/lcux1qIbEkOVTlRprEDBDx7efajnJ4onH5OruKsFQKXrd0f33sFsTB2I9j/4C9tA
 Pt+Mtu7Q/IroIGtfGFc8e411f4Y76Llk1mQM7Do/sshSniutzU/ASN4kLPFwiLuPgr8D
 57ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603619; x=1754208419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhhZA/6ifKL4l4jO2ipFN7HTrNIURT3W9UEWXRBt4U8=;
 b=eSgHfkV2bt4py+/3eMtHRxpRHscEX3fdZ64XZ+wlwRThwPUMmn86o0zsSaT2H0RwcO
 kICbABjzH850ImU78QATdi7zpAQcBWLwYzCs09u/dF5vKw+qmG2k97ie/UbEVuzqQlyV
 4XYDJPZsa4rsHch69oQ7gmmgalc5cPtVyCeujzQBV7X8z4dOUalqL4sKvL7EJmYFaBdV
 zsu/KMgqx0VcmKN4DHCljmqury57cxGjA553UX5WV/RTtg21ThfRjpWaZjskfF19W0kq
 zOcibyGJ3NlWl61sw9XT56FuGEnpSX3X9i7aBA4tPvImVnVM16dgnbExTSE6gnImU/Jn
 aoaA==
X-Gm-Message-State: AOJu0YxQZDW04rAKJyn0vCUfH6KU6n/gB5pMHyMjjf47OJ6TvpqMyFIN
 TqZ1gYnItfxDaZEJSiWGtTv3XYVBRSmvEsElvtPOO5Y9h8XgnCg2s3+WIc06ix62AeXLZAIa7Ty
 g2ZsC
X-Gm-Gg: ASbGncsKJHeKnP9u/06G7LBKQK4fvHS+jmAzL7c+IOkRwk49ce1g0EyqQhL5Wrbuu/X
 q5KeS6SbrvyZcYbOyPO8XJzr//GyHrDWq2iGg4AuFiMtlD60bZHQpQdptGH+YEBLE3XGlXX+ikq
 uFHO5vHVEZp4vmCldKTTx2o6hPmnXvtm/A8y2q5QN3aEfpEvtRok2wIeLzhx9F0E4XrTCfNy03X
 jDhp1P42WhCPapi47d0FbTx9uD3GHaDRfw8GOWwzBlPJi3iQZlcoMdkv7doFFH2c7YnjlTWE03Q
 NfDrq6yXzxaaJeB6qRexGHJasXLaoSLMP+JDVMoT8ZTqmoVvCu/FSYET+PJy95rX7NPqktYM73r
 XhN/NN0qexADN8kXwMvmysdw5PZnuUDZaL6MRy1QKzbbxfr6PKl11fHB7m6gr29LBkzCqnHBhSa
 BuYPTICr96XA==
X-Google-Smtp-Source: AGHT+IHfTSQ9wxp+4X1iKjflsCFlCHe/KKq9Gu7Meweg8oD37rB/f0IOs+R+RL1AYj4sJfR08BwFGA==
X-Received: by 2002:a17:903:198d:b0:237:cadf:9aac with SMTP id
 d9443c01a7336-23fb30b2b1emr140422835ad.29.1753603619447; 
 Sun, 27 Jul 2025 01:06:59 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 51/82] target/arm: Introduce delay_exception{_el}
Date: Sat, 26 Jul 2025 22:02:23 -1000
Message-ID: <20250727080254.83840-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Add infrastructure to raise an exception out of line.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 20 +++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1479f5bf74..a40cbd4479 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -21,9 +21,25 @@ typedef struct DisasLabel {
     target_ulong pc_save;
 } DisasLabel;
 
+/*
+ * Emit an exception call out of line.
+ */
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    target_long pc_curr;
+    target_long pc_save;
+    int condexec_mask;
+    int condexec_cond;
+    uint32_t excp;
+    uint32_t syn;
+    uint32_t target_el;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
+    DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
     target_ulong pc_curr;
@@ -365,6 +381,10 @@ void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
 void gen_exception_insn(DisasContext *s, target_long pc_diff,
                         int excp, uint32_t syn);
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el);
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn);
+void emit_delayed_exceptions(DisasContext *s);
 
 /* Return state of Alternate Half-precision flag, caller frees result */
 static inline TCGv_i32 get_ahp_flag(void)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index eaeafdf138..d803c10ac7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10411,6 +10411,8 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f7d6d8ce19..c4dd3a747c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1090,6 +1090,57 @@ void gen_exception_insn(DisasContext *s, target_long pc_diff,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el)
+{
+    /* Use tcg_malloc for automatic release on longjmp out of translation. */
+    DisasDelayException *e = tcg_malloc(sizeof(DisasDelayException));
+
+    memset(e, 0, sizeof(*e));
+
+    /* Save enough of the current state to satisfy gen_exception_insn. */
+    e->pc_curr = s->pc_curr;
+    e->pc_save = s->pc_save;
+    if (!s->aarch64) {
+        e->condexec_cond = s->condexec_cond;
+        e->condexec_mask = s->condexec_mask;
+    }
+
+    e->excp = excp;
+    e->syn = syn;
+    e->target_el = target_el;
+
+    e->next = s->delay_excp_list;
+    s->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    return e->lab;
+}
+
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn)
+{
+    return delay_exception_el(s, excp, syn, 0);
+}
+
+void emit_delayed_exceptions(DisasContext *s)
+{
+    for (DisasDelayException *e = s->delay_excp_list; e ; e = e->next) {
+        gen_set_label(e->lab);
+
+        /* Restore the insn state to satisfy gen_exception_insn. */
+        s->pc_curr = e->pc_curr;
+        s->pc_save = e->pc_save;
+        s->condexec_cond = e->condexec_cond;
+        s->condexec_mask = e->condexec_mask;
+
+        if (e->target_el) {
+            gen_exception_insn_el(s, 0, e->excp, e->syn, e->target_el);
+        } else {
+            gen_exception_insn(s, 0, e->excp, e->syn);
+        }
+    }
+}
+
 static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
 {
     gen_set_condexec(s);
@@ -8107,6 +8158,8 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, curr_insn_len(dc));
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 static const TranslatorOps arm_translator_ops = {
-- 
2.43.0


