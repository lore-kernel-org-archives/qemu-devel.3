Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649C0CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGY-0000aR-QF; Tue, 09 Apr 2024 15:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGX-0000a3-Qk
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGW-0004eG-5O
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e220e40998so38065785ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691379; x=1713296179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcOly76/DhggOn/gIOyjbUFt0Yi/pTy/JSDCl4K3h8A=;
 b=jwqxI3/4Zfon+kR8l7DTN8rsjOlg6srLqxNmOC/f2Dg0C38qoU1GjeD8gpruqlqyyi
 SYZ6jPr676/iLBdm+aTEVU3B7UcJnBW3tUBcTGjaRu/Qpfepnm3DAD/iHRXoGExC5tuT
 Ap0qYqhKPd5SithiuFnEy651oG1gzzefygP2wugdrFwN5eHOZIudV3kYQj9rk3XJET1X
 b3I7josc37xF6XXnLGVGlzrOrF3+hsphZY9ST0FDoBk9CZslvt3iU3Twag9/tGxYDPXw
 und2zIZ7a2iw+++0j9qR7xYBj3saKfM5DrZWGqYdXADS5xY7O9nkLDbTuaNbSKz2mXY0
 WLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691379; x=1713296179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcOly76/DhggOn/gIOyjbUFt0Yi/pTy/JSDCl4K3h8A=;
 b=Fl6CKWKFrX/Nq252By6fOveyn+J51+fCzlUekwTzpgFfcTTZ90YrbESlBmvLyIhobs
 CHbjBIaz+GLGwTS7v1S1BPomxfrdRDGqwx10+5I5znSK/ov6SszwamcAlVC3R5YyTY/1
 D8fkHbJEAyBiey93l4phbvgb1UbQpRYMe+MqbInEPhfu9sQP6gJ/5J3X6qY/9m4rlWS/
 90AtJxwXWuSXU8EfgbCHmmEdAiKPS6WEQQpAbF0GQhyF2oIHjHvJtuu4QWDs+5LimjI4
 5WTbuWKi54NorVHomhEVtAes63Jt7h8sbdG1v68ti9iIGyjWYOh7Z0R8+I3MEnjlzazL
 iZYQ==
X-Gm-Message-State: AOJu0Yz8PcnwUN2zjpEonQoEKVR9GycZt8VM1B0YohuUtYfSbezZ/G2S
 5sqXn6+NGLFdiwBg1IKJ1s8ZM51IIflkGYL7uvHGUArO6rtMmnPkUkj5UuJyadZR6Pm4L/xa0+U
 m
X-Google-Smtp-Source: AGHT+IGGEQQmz0lhqU+loLwbNXpebCVyuRZBoyrFzYYjmVg828heLfHcB8ZYLyDPSy/Uo6BjeTdGtw==
X-Received: by 2002:a17:902:e80f:b0:1e3:e0a2:ccc3 with SMTP id
 u15-20020a170902e80f00b001e3e0a2ccc3mr875818plg.30.1712691378795; 
 Tue, 09 Apr 2024 12:36:18 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL v2 09/20] target/sh4: add missing CHECK_NOT_DELAY_SLOT
Date: Tue,  9 Apr 2024 09:35:52 -1000
Message-Id: <20240409193603.1703216-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Zack Buhman <zack@buhman.org>

CHECK_NOT_DELAY_SLOT is correctly applied to the branch-related
instructions, but not to the PC-relative mov* instructions.

I verified the existence of an illegal slot exception on a SH7091 when
any of these instructions are attempted inside a delay slot.

This also matches the behavior described in the SH-4 ISA manual.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240407150705.5965-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewd-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/sh4/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6643c14dde..ebb6c901bf 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -523,6 +523,7 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_movi_i32(REG(B11_8), B7_0s);
         return;
     case 0x9000: /* mov.w @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -530,6 +531,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xd000: /* mov.l @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -1236,6 +1238,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xc700: /* mova @(disp,PC),R0 */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
                                   4 + B7_0 * 4) & ~3);
         return;
-- 
2.34.1


