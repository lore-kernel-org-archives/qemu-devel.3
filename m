Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5166BC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 12:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATSH-0006Ae-KZ; Thu, 01 May 2025 08:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uATSD-00069y-0J
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:55:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uATS9-000687-Ka
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:55:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so354254f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746104147; x=1746708947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jzvxd3XHw/BlXHQr4fGCi2TYeUhGZ43epZiwxu05Yh4=;
 b=SE+P5MUTiCdlL5cK6ahRcmlepX0gyBHThkjQiuMpYo+Pb/LE7ozJTGslbHzY+go+bA
 B6z4K0m17SjecKqWf1IakcFm0QTxvy9VGpBY9JrNFzwY6GhHAV0caaKu2b7nGgSMGVY0
 FdAk8sTIVLk6vOKhqvOP410n2sfI1i+Vxiu3oMUgvfmgP7R69N2C7ajjCzLrrepOxzLT
 967+1skxrGsQ8O+P4cPBg4zZk1DNk9swIXv+xg75yv2GzX1L4aZL/w/o/1LBCS/SKnj3
 ywFuH8AtqVoi6TofaJo7GuSGX9cvl4uAiYRSItSuw9gPhpEK1OV6ImIu/8YEdBhNwGMi
 SVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746104147; x=1746708947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzvxd3XHw/BlXHQr4fGCi2TYeUhGZ43epZiwxu05Yh4=;
 b=gKEhJkPacro0/Fqtzxd9jLUMMnzjhzL1U6Q+l1e/TpK3X4RHLq3kSfBaCSGjBDM+Dy
 ri04iwSdlXTJQyi/4nKoxfeOe2eGUFLknWSj/Bj4Q4lEx86VRj2E9OtUVh8kC/I6g2dv
 gybDiOXmAnFs57BfH1HlYxMXgJK6U+UpJ/ok5fujCjFF1gms5r71jlGaBB5xAf9oFSkb
 QBCeTvg+oLIsRBOESEqbL7ucRfgpTpqxQnchtFp+PqaZ33QuzBdLzAB+BDKc72XmULa/
 rq5SHTZfL8leeTNwQS7F1gtFiwWmKHK0o+nhcEGP0tAb4Eq8BdTb9pgmulJFc6ivWF15
 jTww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjkexDFqAoGxZv9ZAWrMDzarI6jEeVHkramFw0UY4YScKHz2BWN0kBQJstIbc2rMKUa/4p1DNu6W/g@nongnu.org
X-Gm-Message-State: AOJu0YyO3Q0PxQ6PeQdv0hjwK+KHD2mh6f3zLsi8IK4GZ6tDgpQDMcLM
 3rJpk4ICZfsxOTFNubEFg4TuKN/zTs89QbQQyllhlm8Zoz1yi1NElgPPVreGqA4=
X-Gm-Gg: ASbGncu0N4aMrghgPf2LfOh407RxmFG/fQG0a4CgWSgSx8fXqwziXrmr50QFaTHVlr4
 iZKOMGL6zo+p5B5jJX8ddI8/3qXSc54fYehGu9mR51AY0frGDYmdtjKNA8LiHSOuLVNUTIP1jIg
 m/cbr/FJ+oL8GkIZ669CPxOTJxPUQLPEAV8F9+desR5G68taHlLxRveYmfkH7Ypt9oYUfBtTFB0
 B0Bn5rN5r1IgF1fy8ZjaAl1gR3bxOAJntEI1cZa99s6s9kjktTRK2QcJeBzrRRkd0PY5sNmO7nQ
 A4rZIGpx4pAGjvmQ8d+flWhPNUXoDNxV442RddYCXkXMqBw=
X-Google-Smtp-Source: AGHT+IHCbkypEeQBQc97TJeSOVUdCxvsYSUC5GYayhyyDJXoeBDZNR/pevifufR1wPvF1B8+Bx5Rmw==
X-Received: by 2002:a5d:64a5:0:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-3a09303c33fmr2243899f8f.34.1746104147322; 
 Thu, 01 May 2025 05:55:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a095a3e0b3sm810714f8f.14.2025.05.01.05.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 05:55:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Don't assert() for ISB/SB inside IT block
Date: Thu,  1 May 2025 13:55:44 +0100
Message-ID: <20250501125544.727038-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

If the guest code has an ISB or SB insn inside an IT block, we
generate incorrect code which trips a TCG assertion:

qemu-system-arm: ../tcg/tcg-op.c:3343: void tcg_gen_goto_tb(unsigned int): Assertion `(tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0' failed.

This is because we call gen_goto_tb(dc, 1, ...) twice:

 brcond_i32 ZF,$0x0,ne,$L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x73d948001b81

Both calls are in arm_tr_tb_stop(), one for the
DISAS_NEXT/DISAS_TOO_MANY handling, and one for the dc->condjump
condition-failed codepath.  The DISAS_NEXT handling doesn't have this
problem because arm_post_translate_insn() does the handling of "emit
the label for the condition-failed conditional execution" and so
arm_tr_tb_stop() doesn't have dc->condjump set.  But for
DISAS_TOO_MANY we don't do that.

Fix the bug by making arm_post_translate_insn() handle the
DISAS_TOO_MANY case.  This only affects the SB and ISB insns when
used in Thumb mode inside an IT block: only these insns specifically
set is_jmp to TOO_MANY, and their A32 encodings are unconditional.

For the major TOO_MANY case (breaking the TB because it would cross a
page boundary) we do that check and set is_jmp to TOO_MANY only after
the call to arm_post_translate_insn(); so arm_post_translate_insn()
sees is_jmp == DISAS_NEXT, and  we emit the correct code for that
situation.

With this fix we generate the somewhat more sensible set of TCG ops:
 brcond_i32 ZF,$0x0,ne,$L1
 set_label $L1
 add_i32 pc,pc,$0x4
 goto_tb $0x1
 exit_tb $0x7c5434001b81

(NB: the TCG optimizer doesn't optimize out the jump-to-next, but
we can't really avoid emitting it because we don't know at the
point we're emitting the handling for the condexec check whether
this insn is going to happen to be a nop for us or not.)

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2942
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 88df9c482ab..e773ab72685 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7760,7 +7760,8 @@ static bool arm_check_ss_active(DisasContext *dc)
 
 static void arm_post_translate_insn(DisasContext *dc)
 {
-    if (dc->condjmp && dc->base.is_jmp == DISAS_NEXT) {
+    if (dc->condjmp &&
+        (dc->base.is_jmp == DISAS_NEXT || dc->base.is_jmp == DISAS_TOO_MANY)) {
         if (dc->pc_save != dc->condlabel.pc_save) {
             gen_update_pc(dc, dc->condlabel.pc_save - dc->pc_save);
         }
-- 
2.43.0


