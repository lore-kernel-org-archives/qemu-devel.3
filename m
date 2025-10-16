Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EFCCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MwH-00025P-8K; Thu, 16 Oct 2025 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw4-0001eI-Ra
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvp-0008PM-BD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46fc5e54cceso4943635e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617079; x=1761221879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u4sma6tnxm2+2BpzP75arc+gydsj1jHi+sRhrnGIVhc=;
 b=cHToIA2/GQz0QLe39X5yzhm2MLvR7H71e5/1jma0FtRbT+1JigbKhBfMv5N7jmnNsT
 4kbcWhzPp2oQC2vN1pAN4SOKkYcQiFftot4+8lN9zSozlNtql9oGJh7Xz/XKW4Dl5k/N
 yA2IfMxxAoHF2RmxlrFrqFcnsE3uOL64k3UgHM30MEJ4HEVRanxVL64uXnYjjHsI7GdO
 e2FUxdt9IK3G3UR9jcyG9UUDkhtL6Y28McDH09qrnBMaFDQK+HlIfETf2FoR8jBU7ppl
 oAmvCp5aBkWCIfy64jKJNksDGTwehyHIrsTMgl9id3IU2kYvGevGjmbTfivo1OXiQCCg
 d+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617079; x=1761221879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4sma6tnxm2+2BpzP75arc+gydsj1jHi+sRhrnGIVhc=;
 b=bkYrD97873Ph7Akpo8y59j9XtHhApROnoDwmcwu3lOim+dLe07P13JgzmdDTAA5XEx
 N4m7xOpzA3/QRhRIyRTJ3kI2Lm9THROXJUPS7xf7dH0wFJz7AoGu/yB9mWw4l95nqIzI
 F2wT4PBCrsAV7EJiAbDopJ5x5WRtwQtFdR0zwxriygrLBGU73jK6lSITHExrOjWeqIJW
 05ZQoncJkeI7DLa2DAwFTAWolAnP8UxV82fKpflL0o0BcJHHD/3w4o0wwzGuSiStINFQ
 RDYhhQFyqWLmS03iElwW/dcGqN313jSSqiD3KpE8U13jo08hRF2YyczfK5RifxNlU+Dd
 eFPA==
X-Gm-Message-State: AOJu0YzGGurn52v1ZTiN/9pMPElmA8UQPyWAf/r0/jjY5BfyvHigwnIN
 xcB22tq4DCSCfreNhwMXK4VRcpPe/LEAjdAcjiGsBwnph6OjkgCse3rPoAHSKGo9846bwncODXd
 3nwfr3ZM=
X-Gm-Gg: ASbGncuE3VUvI4XJ1voCi0LMc9k2a/cjKp2T1f1dX/bKlqPWVTESFKUSR2FbYV/2JwA
 ZmUlZjYaZlCPylGPrf7VNI6DucA0FayB1NYUGNooGK+535+XixN6WfI+Qk1y+wCc982UsbGYSou
 Ip3F6ZEWpvZfAXqSyn/4Neu/YZlMhhS01vgmTNeyi+/g/0yuQ44gwmu7hd82gUsZS+LSAIyGUUj
 wD9+iGDy2jCY74DLyvJnOZ8+DEBZrz62QBiXnHxW8ts968SrD/dnPcho6MqTiwqlaxep1ZvZoWG
 RuQUsQL9HTl57nNeA0MN+cZCy/LVKIz9M48ivpiENjiReYz5fOnLxjmAkXn+ntWaqKWrLWTiKMg
 Ctule+f3mqdwrXR+Q65359Y+nKDp7r646IEO1220JQT/3lsSAYZE/rMWCCxcz2w+8KK/FMUb0Lh
 NCWPEWJGUuAoTVr29w3qeJAU4hjAFrzBCWW5J/I+TfFL0dZhGm/zo7ow==
X-Google-Smtp-Source: AGHT+IHzCgb4Y5nnDhxy6yksiGo90LTXlioOewqNbplMX81N8G1Jp+K5DqXt0lSmCP2CEZn4ZktZxA==
X-Received: by 2002:a05:600c:a301:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4710700f403mr32264765e9.25.1760617078830; 
 Thu, 16 Oct 2025 05:17:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm36006425f8f.10.2025.10.16.05.17.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/75] target/openrisc: Use vaddr type for $pc jumps
Date: Thu, 16 Oct 2025 14:14:47 +0200
Message-ID: <20251016121532.14042-32-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-6-philmd@linaro.org>
---
 target/openrisc/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 5ab3bc7021d..9f61f917b3b 100644
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


