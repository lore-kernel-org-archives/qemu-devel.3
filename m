Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63A4CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqJ-0007CR-A3; Fri, 10 Oct 2025 09:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cq0-0006un-60
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpG-0003xM-3o
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1429505f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101579; x=1760706379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K7Y5RxnInLeoArE7Yi+6qmjYD7sMXgKe51eDntl5Zkc=;
 b=z8BvLjAn6+9b4ORSzj4ji6QLsCVIMCnzZtGtoIuTwLgwz6QqrPMhj9FcXQTF0fSBDf
 11g9K01xH1xr0qT3K7xW90hRp3K0usPc00Sp8me28+Sx5Vu+NXQuSt45RfXxelb93m7u
 BBdWblunxss10Gvbh2PK05mlu3ZKt0H9nskLyLg179h22YdHs1/hO5IP77MjczrFbXfQ
 fdD//Wtu/YSGBLX9+Af1S932TCGW6kVXxHt05qew1gswMismbpjcHRybZesyhn3P4lCI
 SsCB9NfNK6RcgWXT3ThjuKrcWO8V6JijssdCWYpCGWdSdb9bLAfaetnwvnauhDC1gGGs
 jtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101579; x=1760706379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7Y5RxnInLeoArE7Yi+6qmjYD7sMXgKe51eDntl5Zkc=;
 b=DcxL5J+ib2OzyPV/58GuhU05uTOBnSI/fOhILaDxj/eSDhXrcLL6UnTnyrZavRrdrc
 u+DQVX8qrK7fYJAEwc4DR/3pK8L/VTdgal693Tfti0Qj9VRy57GuuVaXkJhuZ/L6Mwkc
 WVuS7GH4t5kJVien2aw3auVldnT36seZ1Fmaxty80g+sTC6qTHQc69ZKACsAkej8v2Qx
 TbtSKccT5gZgIFpARaMnglwYD/kukPAqQOjUrWrjGnz1UP74Wy/kUHf2Cd/9/WFsBI+j
 ZbVTrlDzmu8snbKZpDn0jJzycBSmD6nCDgvX/jk+5Q+QFFsmuN8E019T6lgzr62n/mPE
 HJOg==
X-Gm-Message-State: AOJu0YxM7NlFHaNfRt90ElZdNAO/HWQ24HE1fsqc1NgCD2uYVvV6yDSk
 s48UhkQ6b/MeuKOqn9nLDW3ZKf9r68lh0v9rgFtb4GdwKqLcBpQhXC9t8Bxsnb3hFcVO5fBLLcS
 xwaUO
X-Gm-Gg: ASbGnctyRFQD4vQPR+cku264kzEHIJHHfZXW7HAeBu1mPsZUwsOe9UbtMoaHIz8IlRu
 9b+gNWI0uzR4wHSAJIUHJkLLOVOpshg3Odp9LCNsdwuh6vm7Ms1InynUgjKJJn91RsRoHG3iojH
 9HX9zKUpP5IGflcRdN/xOHWQEmUzN/bvSygAl16xnPAJnDfFJeU7fkdDBZwzW1qRLrp1i9LDmms
 D91z6cRkmUPUyUq8y9cFptbE1ajHNaPE6y2NJ/kAQy1jZMGUy0wwuw4RLgEYeszso3Inff8pjaJ
 /5YR0FQtIKivXRlBGUzJ37+91gpN9rGbSYNXXnAactVI9uSF4unebxV17RrH6B54knEqug4B8k+
 EPV3TagLx/5mW7dWCUYRWg5+4EUDXVQJDBBPvfX28AfE+sUE7L9F8zkbBs7grWw==
X-Google-Smtp-Source: AGHT+IHw8XSVHjZMHCw88nLjmslHCSrnKsSNnhpk3i0T+kiZYiAwFtiyOTKzQgTC/RKzw03PQPgSxg==
X-Received: by 2002:a05:6000:26c9:b0:425:7679:ea72 with SMTP id
 ffacd0b85a97d-4266e8e0959mr7793313f8f.47.1760101578890; 
 Fri, 10 Oct 2025 06:06:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/76] target/arm: Introduce delay_exception{_el}
Date: Fri, 10 Oct 2025 14:04:54 +0100
Message-ID: <20251010130527.3921602-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Add infrastructure to raise an exception out of line.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-44-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     | 20 +++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 943dfd45fe7..9a85ea74dbb 100644
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
index 1337e16a96b..c037119cdf9 100644
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
index e62dcc5d85d..78d26aac043 100644
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


