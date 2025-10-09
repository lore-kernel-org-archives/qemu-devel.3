Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D8CCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsI-0005LA-3f; Thu, 09 Oct 2025 04:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsF-0005I2-E4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsC-00088X-1w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so3918895e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997977; x=1760602777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEbDG9nSLIOGyvvOyaB58KCpKqNvID5tlXo2yfv3uh0=;
 b=LX6zxPRPse/8TFi+Cbmyof9ka5y39ykle2l3QBHkcZXD8/1xf3zfFh3sy69GTKgzJ+
 +ydASqiybXRYlAO49Td0FJBW/XDmKFn2oEZcz6Icxdvg6abSoW9wJnEXm0PGodGrKxCv
 tvH1buTegLqbRNDJceWmgMi1d5gBsiF/NOlPM8UQFYwowUOnIxxgFU3X+lF0OM7XAnA+
 +T/m/JQkK0ewsryB6Pn1XpbSy5uJmaodSOzdDqiPCheJfPNhKMeoeLdA6PPdDwbJ8K87
 uCRhrTy78TtFCJ9p6x4tJjra7sCL4/mhff8XgvJ4wFK+1vm8PFMl4Vl38mNHgu304mLe
 +6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997977; x=1760602777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEbDG9nSLIOGyvvOyaB58KCpKqNvID5tlXo2yfv3uh0=;
 b=eYy08BZ5bYlZlro+7ycMFLwmKeehjINfp51wUXQ5tp7OvMlW8aOVjUE0J+1beBRyli
 5MiHepLi65Qy5mG+uukYmseyK7tXesDW0phtpnb2RWhS+7irbxn5vpTHwxHo2FepcVdK
 Yw605DEsxUJ3RpwMREtWlHeMcWRFQuYkNGseNKL0t6hlUo1B/sDzCwSUMLWnPxchgMMQ
 EhYLA80W4aaaTd5HfBesE/vFb8Hn8Bqb83YgQYFoXOoHQ8u/TgoY3pX3rxTSuDKLbMCn
 NBxFNkwQ/CRT6NPIIci34SnkOOGlzBEp7fLdO8Dm5KysN0Rvm4XjeKhDunXRpox7g5ig
 hxOQ==
X-Gm-Message-State: AOJu0YzA2keBBILKjhUAoG1Jw+Q8u1rfeTvuwxNT3XWCpukR7cr0o5Pi
 OBH0d0mzeuj6kIHBrCPCPD/szQ1V/yNqPiwKVlVzOMyGR7LhU7iNLbrXVza6JiJslhe1cacXjAm
 VZHc3COAOVIyn
X-Gm-Gg: ASbGncv10wgLe5TJpeE3Cz+OpR9GNQQMF8oYaHVrJT+tEZSaI8+VwcYwGAAPBe2UyAO
 SB/IBU0uyMylppHdTaMS8s5FVwpMUnMqCQzySCybbdns0pbWaxCckUlkKENasFscil6ft32EzKI
 Oa/Ka2XGgrfyXLgkzE8TfSD1w5ibsXE0NNyjIMrKsWaSRoNBBsoNfpt4cWxaPOFbzid4s25jBrh
 ndzD71ufG1OpXHdY93wi+qOrqBnyLsFjJIwF+UAWfP8ddKChP3SLZ2kooxtWlCF214zVwSR80iw
 6+f3X4R3mmcDeJNj/7mlQ4QPBvG9GF1+F5gn5x1vx2qbch5QkzLWVQYcGXlgzC4t+kUv3dXvEpk
 PdS8mq1ucQwWBYSuq48a6uaC8N1axtWCsuEVXMCv0kHbLsUlEYo30wH8Hk6s/pUpwT9uJmqABH7
 efT3ayYoLMFsfJ5IaY9z9x9Zqk
X-Google-Smtp-Source: AGHT+IG5r65qaW+hK/so4ReIi0pQdaC3PTp566Obdvn4WZfCs4qrcyPOFS7cSUsSWMuCt43j3FCFWA==
X-Received: by 2002:a05:600c:34cc:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-46fa9aa2076mr67801135e9.16.1759997977508; 
 Thu, 09 Oct 2025 01:19:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf7f80sm72573535e9.1.2025.10.09.01.19.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/10] target/openrisc: Use vaddr type for $pc jumps
Date: Thu,  9 Oct 2025 10:18:59 +0200
Message-ID: <20251009081903.13426-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4ece2547614..06625367ae4 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -51,7 +51,7 @@ typedef struct DisasContext {
     uint32_t avr;
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
-    target_ulong jmp_pc_imm;
+    vaddr jmp_pc_imm;
 
     /* The temporary corresponding to register 0 for this compilation.  */
     TCGv R0;
@@ -580,7 +580,7 @@ static bool trans_l_muldu(DisasContext *dc, arg_ab *a)
 
 static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
 
     tcg_gen_movi_tl(jmp_pc, tmp_pc);
     dc->jmp_pc_imm = tmp_pc;
@@ -590,8 +590,8 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 
 static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
-    target_ulong ret_pc = dc->base.pc_next + 8;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr ret_pc = dc->base.pc_next + 8;
 
     tcg_gen_movi_tl(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
@@ -605,7 +605,7 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 
 static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
     TCGv t_next = tcg_constant_tl(dc->base.pc_next + 8);
     TCGv t_true = tcg_constant_tl(tmp_pc);
 
@@ -1586,7 +1586,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong jmp_dest;
+    vaddr jmp_dest;
 
     /* If we have already exited the TB, nothing following has effect.  */
     if (dc->base.is_jmp == DISAS_NORETURN) {
-- 
2.51.0


