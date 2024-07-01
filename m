Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FADEC3064D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78Z-00031u-Kk; Sun, 30 Jun 2024 22:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78X-00030g-84
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78S-0008Vs-2z
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so1308153a12.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802279; x=1720407079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uYPQnTpDkityzLolaGQ63NdFXXcedgiMTlSb315wZQ=;
 b=AGQf/h9Tm9ZDOHxbD7gnwh4KeCRPat0bH7RtRenbXXWduENbHx/E0RHyNXod69o4IS
 cx0YVkm0tLoiggEMM074mrfLEEbuj3zNZSlnyc7sy17l1yZ05Lf9gXL6GAqIYGY9TE33
 HWxfypXIj/mg49yjgh6Aqd2HQOcVVAiUcOviBcueA5U/5XhuP0a7XidGyWB2CFiOQxFp
 SQjxfpJbH2+5MbVLklT+m5UzY9kv+eeFUaVgd3n0vIhK5bEXzW+9llmz1thOq+zuIYTD
 RRVirF5fQs7t6netCbJV6hNiqftPeEFWVjtlW20t2IkIrVgH1162pBt0rHh5jO+QZZGk
 Rp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802279; x=1720407079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uYPQnTpDkityzLolaGQ63NdFXXcedgiMTlSb315wZQ=;
 b=TdK5FFWK7KTLYgjZqPFAd5ir+FV0SldkY+mw6NSH1rWrhlYnKXLnzwWPcfGUL2oFQJ
 p1w/RZ+Xq3LRYCMXWhUyuG7B3wy6UsFsVUESylryXHqWQxb6e3a0NdYlzJkt53yw7Gcs
 v8Ing9Bf6WYFxA0Ox7O24fYcoK/x1iXypEGDu6e43oz/Mukpb+t6lpqQmu6ckLuZOheb
 elzU2P6FkZjPLU6dWDAjuXqjQ40ehxcMAdMuk9Jl2yIDOm/HfohgbAnkfJNGRU4zXbXO
 SkmLink9Z+NfnkHQzkIIS+WB6lrYM8dg3K6csqorg1o+zJBQk6YDZ/gbC4udkqQaJ6XI
 /eXQ==
X-Gm-Message-State: AOJu0YyC70h0ComYR0ecY+Io2wDYcwhchA9ff9FyMMPgKQls9Ut4yq7E
 0V+W+GGVzmcnLrn83Xz2sViswICZn/YvuTJVAkb4VjgDc6wl6wPPq2D1SzENNa1/mT59ZwNmh9R
 N
X-Google-Smtp-Source: AGHT+IELSYvp+N+Rp7B7MSQP6p7wWyGbOrfSctWPobh4fogKBulgBP1/NNLgQNMrzTpYlzD8kQKiAg==
X-Received: by 2002:a17:90a:f28b:b0:2c9:35c4:dabe with SMTP id
 98e67ed59e1d1-2c93d786945mr1646441a91.44.1719802278376; 
 Sun, 30 Jun 2024 19:51:18 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/5] target/i386: Convert cc_op_live to a function
Date: Sun, 30 Jun 2024 19:51:12 -0700
Message-Id: <20240701025115.1265117-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Assert that op is known.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c      | 56 +++++++++++++++++++-------------
 target/i386/tcg/decode-new.c.inc |  2 +-
 target/i386/tcg/emit.c.inc       |  6 ++--
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 95bad55bf4..e5a8aaf793 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -290,26 +290,38 @@ enum {
 };
 
 /* Bit set if the global variable is live after setting CC_OP to X.  */
-static const uint8_t cc_op_live[CC_OP_NB] = {
-    [CC_OP_DYNAMIC] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_EFLAGS] = USES_CC_SRC,
-    [CC_OP_MULB ... CC_OP_MULQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_ADDB ... CC_OP_ADDQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_ADCB ... CC_OP_ADCQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_SUBB ... CC_OP_SUBQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRCT,
-    [CC_OP_SBBB ... CC_OP_SBBQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_LOGICB ... CC_OP_LOGICQ] = USES_CC_DST,
-    [CC_OP_INCB ... CC_OP_INCQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_DECB ... CC_OP_DECQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_SHLB ... CC_OP_SHLQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
-    [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_CLR] = 0,
-    [CC_OP_POPCNT] = USES_CC_DST,
-};
+static uint8_t cc_op_live(CCOp op)
+{
+    switch (op) {
+    case CC_OP_CLR:
+        return 0;
+    case CC_OP_EFLAGS:
+        return USES_CC_SRC;
+    case CC_OP_POPCNT:
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
+        return USES_CC_DST;
+    case CC_OP_MULB ... CC_OP_MULQ:
+    case CC_OP_ADDB ... CC_OP_ADDQ:
+    case CC_OP_INCB ... CC_OP_INCQ:
+    case CC_OP_DECB ... CC_OP_DECQ:
+    case CC_OP_SHLB ... CC_OP_SHLQ:
+    case CC_OP_SARB ... CC_OP_SARQ:
+    case CC_OP_BMILGB ... CC_OP_BMILGQ:
+    case CC_OP_ADCX:
+        return USES_CC_DST | USES_CC_SRC;
+    case CC_OP_ADOX:
+        return USES_CC_SRC | USES_CC_SRC2;
+    case CC_OP_SUBB ... CC_OP_SUBQ:
+        return USES_CC_DST | USES_CC_SRC | USES_CC_SRCT;
+    case CC_OP_DYNAMIC:
+    case CC_OP_ADCB ... CC_OP_ADCQ:
+    case CC_OP_SBBB ... CC_OP_SBBQ:
+    case CC_OP_ADCOX:
+        return USES_CC_DST | USES_CC_SRC | USES_CC_SRC2;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
@@ -320,7 +332,7 @@ static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
     }
 
     /* Discard CC computation that will no longer be used.  */
-    dead = cc_op_live[s->cc_op] & ~cc_op_live[op];
+    dead = cc_op_live(s->cc_op) & ~cc_op_live(op);
     if (dead & USES_CC_DST) {
         tcg_gen_discard_tl(cpu_cc_dst);
     }
@@ -816,7 +828,7 @@ static void gen_mov_eflags(DisasContext *s, TCGv reg)
     src2 = cpu_cc_src2;
 
     /* Take care to not read values that are not live.  */
-    live = cc_op_live[s->cc_op] & ~USES_CC_SRCT;
+    live = cc_op_live(s->cc_op) & ~USES_CC_SRCT;
     dead = live ^ (USES_CC_DST | USES_CC_SRC | USES_CC_SRC2);
     if (dead) {
         TCGv zero = tcg_constant_tl(0);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0d846c32c2..ba4b8d16f9 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2792,7 +2792,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
         }
         set_cc_op(s, decode.cc_op);
-        cc_live = cc_op_live[decode.cc_op];
+        cc_live = cc_op_live(decode.cc_op);
     } else {
         cc_live = 0;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc7477833b..38b399783e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3531,18 +3531,20 @@ static void gen_shift_dynamic_flags(DisasContext *s, X86DecodedInsn *decode, TCG
 {
     TCGv_i32 count32 = tcg_temp_new_i32();
     TCGv_i32 old_cc_op;
+    uint8_t live;
 
     decode->cc_op = CC_OP_DYNAMIC;
     decode->cc_op_dynamic = tcg_temp_new_i32();
 
     assert(decode->cc_dst == s->T0);
-    if (cc_op_live[s->cc_op] & USES_CC_DST) {
+    live = cc_op_live(s->cc_op);
+    if (live & USES_CC_DST) {
         decode->cc_dst = tcg_temp_new();
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_dst, count, tcg_constant_tl(0),
                            cpu_cc_dst, s->T0);
     }
 
-    if (cc_op_live[s->cc_op] & USES_CC_SRC) {
+    if (live & USES_CC_SRC) {
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src, count, tcg_constant_tl(0),
                            cpu_cc_src, decode->cc_src);
     }
-- 
2.34.1


