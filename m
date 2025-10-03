Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8B2CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jM1-00082z-Ga; Fri, 03 Oct 2025 13:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKX-0005KU-OZ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJu-0007gw-BH
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2460842b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511500; x=1760116300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NNf1WmXSTI58NaZyRuQIPA+gxIE0nBNVq/aWBPGCWw=;
 b=xTguVO8gOcrfwHIplj561xyJzMSF6Jle2daZSmYoi3/ceXkA5LP2YhdMDYo9vQi9Wr
 gNeazMiumVG/kD0HB8l4b1kLnxNXEHF9psCgqpM2USlc4D7frEQbhevs9oAyG03kZ6xn
 mHHjihdyjXCjco9vjwtkZy7a5f1iyxZ8uDx6VYmezd3Z1z/LNnm35K4+Pzjn4Eajbu8i
 /4SXPDBnJ1sCheSYVayP7/mP9OAOHKQPXrQisL1jFCGLmLeWiFNF6tkuIOkn8p89K2AF
 xjViNJB40fZ+9IQRVboNl+zVtQWWY6y9f/B9wqRsyguPUOdVhwEYH6qi1e5aCA0Pb+vQ
 jS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511500; x=1760116300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NNf1WmXSTI58NaZyRuQIPA+gxIE0nBNVq/aWBPGCWw=;
 b=TnDWc/wdXgVVaeK6c86Ckn2cuWSI8GSoleO9V/3URkhovsbmMvRdYuAPQt820CYgcW
 LpzoxsXwT41y/DFQQ7bVplLlXMXp5GK1y0qduG4Dd7e4tDJogCcwXKRK+ny9EsEY2kwa
 TnIcCqLH1kGIhr1gLasMwWZbbvOFP+AR685qLNtex6jnMT7rny1H3qB2cUIIaMbFzzlQ
 fAFnOoSwQqof9w1/SIH55mWkhYXNHHIYHlTypSSa/l9JgRCeHBfnlepiTdoOhjjYX0Tl
 KK3kL0WQHytxegFbDlfexxXHY+KkP3/Nf1o7dN0xI79+ofaBGuQNSDxFaOVBmO8yogcz
 H32Q==
X-Gm-Message-State: AOJu0YxWvEVVrwWIcvtGaFASIia7yOwA364aOLYW8RAyECLenPb2Ihol
 tiepf60CEq9Y1EwaTACGzUu1tOoEFXd2ImfkH3FB/GUWMYYcvAY5dQmME+SO/gU85x5EnwQxRdC
 beExY7MA=
X-Gm-Gg: ASbGncuHcBaWIOggku31xRGX7aSW95lu7LCY3CUgUklGqqKAUNYSQSddCshgMi5zaWL
 5rhCCyQ7rRCHq/s7KT+5IP0bAfaIchYRTRfKqUUUml+KUl1OCacTUIEys3ZrloxPUHoyJ7APveC
 QSTDnYeLcENMjmzm7fuv3rlHVM7AiTb7v41/j4T9WR+FaP0veGKyli2ueH+kj9ztd2QYDfNQHIN
 D97dS1mdFMg5YhnuzJipJuCWwNB8m/B9RsojcykGMaad+SCUZyJwBLvnm+8gSSoraqIPbt7h4w6
 KIs4CtWQaYOEByqXzHs0iF8dF+lzgFP82VzYNm1p1A6EnEZbTj4XvocBOmi0l1luXh+Qx+LM0h+
 acBZADQj7V/j/KX/hbG9M4rM9zAuVKfOBgBcPFXJWtcg/ise9eTTRCzNN9zsq/JMMGKs=
X-Google-Smtp-Source: AGHT+IHk9b1ZGhEfBxMKtwTCGyYw+7H6cpCqG4xB6kcAlyj1Fv37Gi2qiTviQxt0eZnMNnvx7+plkw==
X-Received: by 2002:a05:6a00:94a7:b0:78c:99a8:b748 with SMTP id
 d2e1a72fcca58-78c99a8b97bmr4549535b3a.0.1759511500254; 
 Fri, 03 Oct 2025 10:11:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 43/73] target/arm: Introduce delay_exception{_el}
Date: Fri,  3 Oct 2025 10:07:30 -0700
Message-ID: <20251003170800.997167-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 20 +++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 943dfd45fe..9a85ea74db 100644
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
index 1337e16a96..c037119cdf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10601,6 +10601,8 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e62dcc5d85..78d26aac04 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1088,6 +1088,57 @@ void gen_exception_insn(DisasContext *s, target_long pc_diff,
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
@@ -6791,6 +6842,8 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, curr_insn_len(dc));
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 static const TranslatorOps arm_translator_ops = {
-- 
2.43.0


