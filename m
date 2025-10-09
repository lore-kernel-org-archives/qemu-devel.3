Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B31CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNx-00018H-66; Thu, 09 Oct 2025 11:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNj-00014U-Ld
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNd-00013e-Fs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso8653865e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022989; x=1760627789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlW8PahjI8h9/ha2cpH5DtDr0zWPrjgePAymRRitTWg=;
 b=Gn8FH09Bl85rx9XZTQNE8VEFhXszYeSRnTBanoWvIpNecbCssQTSh+iZ7HigMweSx0
 mhT/hjeE+BsapvD65yYEVpWnvg0sziI/2YoGCAskleCH9zTmQRwNmr+1t2blNZJt1ID/
 8L5NFUCoNARx2K872DjIwBVroCVX4lUnyKb004vjGn512OJTIaiH5/QkNAxZWpQkZtsK
 i/qV5Exj8fKaOvSo2gmBzT6UV9NxtHuXfkY7C4HEuiYfkcQBusKTqle1baTEWdJZJG75
 XRQ4GIfrwjHxXONTDH2sfkkEItYT4FrgCTm1S1QI/+J7o85UUO6LGSRMLR2HNn3yhgX5
 6qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022989; x=1760627789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlW8PahjI8h9/ha2cpH5DtDr0zWPrjgePAymRRitTWg=;
 b=JkWwBCGHQP8FNhwIOoNJYvhoId0+OXTq8C40EwbnACLaQ5L82ivzbuBoOkDMOO8FaL
 LKUM3ju1P8dVmYt06FIBdjRhRtsDUUTAt7UpcHu6EyA9EFOrLKga4iVShWkHOkJmDvXe
 U/DOLAXDim3Mem1PyqpoPIz+OxRT1o9N+0Y4r3s5ixIa0o/kUjCue3uqf9WtdwH6KvII
 UeffVKVBQucEZacfkY+eOgF+sd+HMrsF3JH8BAIl2v7C42kxJr3+LyWMPsZzq9n9yw/3
 UHx8c2aJMDTjFyiwbIPvfvYAv36x9Ch3ShOCFD/P3lQJ1R45qJR1V7hbBnR7Ub/MeBxr
 agcA==
X-Gm-Message-State: AOJu0YwsyqHQ5lr8PZA1shiF3cZQhCT5q8JIVcGITpgzYZVMpzu00+26
 eD9TqNrnQ7/q8T2722MqS9bxfBIhIEOZ/GRpjt14Z7Z1jB7lGTdr4wjEHWdCdydZmHpLG3TP+GX
 DOwtoZScIILdS
X-Gm-Gg: ASbGncvz+xyIjASuAnvseEyRQUA6XDumRjtZvDR0+TEi8UvuiDDqdap/vBrYtFsBKDM
 kvQIR3GdgkXg1y3FUEwvcwE1vK35YJgv6DklVwf1WBueihxTVWxU8U9BWKbTnv37y8BId+++zvl
 SLlP1kQANU0Osj2pq99LfiBaUaoZ8wn7LKnjXveeygB3mB1/jzzdHb3+yJu2TVe4n9OkQP+bJTL
 vPRn3VgdjzZ8zmz3FbBOcBa5LvjqMBaWAegMTGpcO3e5PSrgig6ROxcal8/n9LWjXHC9r287PIg
 6uxc5qyjhgfTr7sAIm0jPCe3+1JSEPU3WSp8vFTPC4XRVbo8MXF7/n/F/lz6UKqp9gskaWVxMIF
 XZWtz3cCwfQ/QANln4921YVLnCkpSlDNW5/rW9A9AtCSV3wXyB2twsRzFRg1mEumiuMjUsW0rJ4
 SA8iWO8q1KkUv5Siqg4RzLIAD7
X-Google-Smtp-Source: AGHT+IGU8hnytgb9c9ueWSVvHy6D30eYojzSaPzKO+FXdz5IodS/ALy2yDouudyWu+OblhfwwQh59Q==
X-Received: by 2002:a05:600c:3acf:b0:45c:b53f:ad9 with SMTP id
 5b1f17b1804b1-46fa9b1ad15mr57177965e9.33.1760022988774; 
 Thu, 09 Oct 2025 08:16:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489af92sm2413555e9.17.2025.10.09.08.16.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] target/rx: Propagate DisasContext to push() / pop()
Date: Thu,  9 Oct 2025 17:16:03 +0200
Message-ID: <20251009151607.26278-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index f02a8cc5dc9..0d5356cd35d 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -414,13 +414,13 @@ static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
     }
 }
 
-static void push(TCGv val)
+static void push(DisasContext *ctx, TCGv val)
 {
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
     rx_gen_st(MO_32, val, cpu_sp);
 }
 
-static void pop(TCGv ret)
+static void pop(DisasContext *ctx, TCGv ret)
 {
     rx_gen_ld(MO_32, ret, cpu_sp);
     tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
@@ -619,7 +619,7 @@ static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
 {
     TCGv val;
     val = tcg_temp_new();
-    pop(val);
+    pop(ctx, val);
     move_to_cr(ctx, val, a->cr);
     return true;
 }
@@ -634,7 +634,7 @@ static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
     }
     r = a->rd;
     while (r <= a->rd2 && r < 16) {
-        pop(cpu_regs[r++]);
+        pop(ctx, cpu_regs[r++]);
     }
     return true;
 }
@@ -670,7 +670,7 @@ static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
     TCGv val;
     val = tcg_temp_new();
     move_from_cr(ctx, val, a->cr, ctx->pc);
-    push(val);
+    push(ctx, val);
     return true;
 }
 
@@ -685,7 +685,7 @@ static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
     }
     r = a->rs2;
     while (r >= a->rs && r >= 0) {
-        push(cpu_regs[r--]);
+        push(ctx, cpu_regs[r--]);
     }
     return true;
 }
@@ -772,7 +772,7 @@ static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
 {
     tcg_gen_addi_i32(cpu_sp, cpu_sp, a->imm  << 2);
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -792,9 +792,9 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
     tcg_gen_addi_i32(cpu_sp, cpu_sp, adj << 2);
     dst = a->rd;
     while (dst <= a->rd2 && dst < 16) {
-        pop(cpu_regs[dst++]);
+        pop(ctx, cpu_regs[dst++]);
     }
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -1585,7 +1585,7 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
 static inline void rx_save_pc(DisasContext *ctx)
 {
     TCGv pc = tcg_constant_i32(ctx->base.pc_next);
-    push(pc);
+    push(ctx, pc);
 }
 
 /* jmp rs */
@@ -1626,7 +1626,7 @@ static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
 /* rts */
 static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
 {
-    pop(cpu_pc);
+    pop(ctx, cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -2154,8 +2154,8 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     TCGv psw;
     if (is_privileged(ctx, 1)) {
         psw = tcg_temp_new();
-        pop(cpu_pc);
-        pop(psw);
+        pop(ctx, cpu_pc);
+        pop(ctx, psw);
         gen_helper_set_psw_rte(tcg_env, psw);
         ctx->base.is_jmp = DISAS_EXIT;
     }
-- 
2.51.0


