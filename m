Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D7CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wtT-0007yW-Ky; Thu, 09 Oct 2025 16:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wtL-0007vq-5o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:05:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wtH-0005xE-73
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:05:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-4256866958bso800177f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760040327; x=1760645127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CoUvQ9nbly8+dvty8KME2tD8evW2VaAcWLjz90m2xgE=;
 b=ja3EU1xKZZYaY2UsS2rJWiISldPlVkvGm4Jz0cVVEW9JjXE7K+I1EIcnA961LgP3wx
 bbe6wRB40atBNEk1dDILRsVxpKWAToYQFP/YGtyydkZFeYdSX9xbGUJunis4/5VUK0pK
 1bthlrWz2MfpI5MnqesL8b3jg2mRpk+DMKFmVYRFaiygC+9Ql5rFhwCeXo7kPQ3b4khq
 ietDBZqn3gexOpYWDgCp8qpVY7u8IYUOBGSOLAGQJbq7WlTiT3Y+xhIyv2/7e2FXB3I3
 jKuwPEeBOI5WIynNKbOUU84whGZkqmVvJUfo1bZjKRk2sPEdkVMCwIb0ApkV3aU9tkgX
 kPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760040327; x=1760645127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CoUvQ9nbly8+dvty8KME2tD8evW2VaAcWLjz90m2xgE=;
 b=WHg45lApOpr5iNY9JEFOxJ8kZkIwFjj4kPxMMKtHw3s6sAqdQ91pScWUpsqcyOQ4UF
 aqlMN7MWpm0aj6kO/009e5ajsxZobN46b+MmdYfNAKw7otbpo4FDif3xg2HP2AhVtj5Q
 KvzUf0Zo6mrG1bCidfGSwoGdKvdksXHIovwUsMP0OXPEnRgU5WLlG9oP+X/HSuFrdyDE
 n9iovWYbv9orj2rGuFrGlpy2gjnaTlOt0Ltj2jcl0YNLuhpn6RlvIT1sWAu/YWmnaGle
 w2k6nl7qP4IBSN4EU5c4848zsocTG2DYM/+gEHmvm+6q7Aw87UvbWo8N0RdtObdCWh+v
 mpdg==
X-Gm-Message-State: AOJu0YywiUGZ5G2zUQXcSyouGEhg7jWnyDAMqLpLL3HseUwCWFN8lFqa
 UZpBUlXBgNsK+JjEobRf11TWDPc6rOvNW9gUsbTAvRZn0CWRLLWkB9FBdT96sB7Y3nn/asIavB1
 pQOabPSW3CUco
X-Gm-Gg: ASbGncvr0umV7ocUlMixUJQaktTr6DxzQEe4AOW7E3UPmQv2Br3AMmVHQjV2SjjHzQy
 m1Jbd//B9yWDez5iKaj95wTShFfk7WBpCzk2JcC2Gn2qF4JUs0sBZOfmcgdG3Q+oCZBA+51xP/e
 VOtjaePvwq7ICUjOKJ4TGgKeyLwkKB/K7+2d9ZLo+z1SwkmXPszOsuoEpwJdTWMsg5nnfVSWDVq
 XDoPpS/aw+YP0UCIOrU5FDCqVtC8QymboT7ALKbg0+iTRhcpKDgQwrLzbx9bwF3NjfXJESk9/F0
 0R6JRWFMF9ro0epTjT65HkVFexyPgnpugJSybHZDHeju19p3RDgWiwkn/o5G9d3G6HnPH6xtbPF
 I36oJ6uCRkKwvalCfzH2d9njaMDf8NI8CEuu9UjEkNnk3rk7qLKf7FmajMSpckZcRqmDa018ek9
 wecr4CBzsYgSRil27xTCdsH2+J
X-Google-Smtp-Source: AGHT+IFy2N2ztq8bF00YVnkc2AjL6IysON1rZ5UrsvqS5uh7NmB6js+HfUAuVx9mckNBap3uM7D+8g==
X-Received: by 2002:a05:6000:2884:b0:3ff:d5c5:6b03 with SMTP id
 ffacd0b85a97d-4266e7dfbafmr5977786f8f.35.1760040326864; 
 Thu, 09 Oct 2025 13:05:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8309sm548498f8f.50.2025.10.09.13.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:05:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/avr: Use vaddr type for $PC jumps
Date: Thu,  9 Oct 2025 22:05:25 +0200
Message-ID: <20251009200525.33987-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/translate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 804b0b21dbd..20191055861 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -87,7 +87,7 @@ struct DisasContext {
     CPUAVRState *env;
     CPUState *cs;
 
-    target_long npc;
+    vaddr npc;
     uint32_t opcode;
 
     /* Routine used to access memory */
@@ -981,7 +981,7 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
     }
 }
 
-static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
 {
     const TranslationBlock *tb = ctx->base.tb;
 
@@ -1004,7 +1004,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
  */
 static bool trans_RJMP(DisasContext *ctx, arg_RJMP *a)
 {
-    int dst = ctx->npc + a->imm;
+    vaddr dst = ctx->npc + a->imm;
 
     gen_goto_tb(ctx, 0, dst);
 
@@ -1072,8 +1072,8 @@ static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
  */
 static bool trans_RCALL(DisasContext *ctx, arg_RCALL *a)
 {
-    int ret = ctx->npc;
-    int dst = ctx->npc + a->imm;
+    vaddr ret = ctx->npc;
+    vaddr dst = ctx->npc + a->imm;
 
     gen_push_ret(ctx, ret);
     gen_goto_tb(ctx, 0, dst);
@@ -1094,7 +1094,7 @@ static bool trans_ICALL(DisasContext *ctx, arg_ICALL *a)
         return true;
     }
 
-    int ret = ctx->npc;
+    vaddr ret = ctx->npc;
 
     gen_push_ret(ctx, ret);
     gen_jmp_z(ctx);
@@ -1136,8 +1136,8 @@ static bool trans_CALL(DisasContext *ctx, arg_CALL *a)
         return true;
     }
 
-    int Imm = a->imm;
-    int ret = ctx->npc;
+    vaddr Imm = a->imm;
+    vaddr ret = ctx->npc;
 
     gen_push_ret(ctx, ret);
     gen_goto_tb(ctx, 0, Imm);
@@ -2743,7 +2743,7 @@ static void avr_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        target_ulong page_first = ctx->base.pc_first & TARGET_PAGE_MASK;
+        vaddr page_first = ctx->base.pc_first & TARGET_PAGE_MASK;
 
         if ((ctx->base.pc_next - page_first) >= TARGET_PAGE_SIZE - 4) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
-- 
2.51.0


