Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE78CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt80-00021G-Mi; Mon, 08 Apr 2024 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7z-000211-DO
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:55 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7x-0003eO-Nw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:55 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso3423624a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598592; x=1713203392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcOly76/DhggOn/gIOyjbUFt0Yi/pTy/JSDCl4K3h8A=;
 b=fe7aSgb4tOoRph5PuEeOTEVxldxZW8mMFcw3oObh7JhdNTA/tL1QquXF3rCmdVjd+D
 yHutsxrT2CxlPbwtXF4buIk1xQ5zjJs0hSI3Me3gOxkAFJh0VZ/pn5dbpanTbnt8r+o8
 AcrNVhmjDWTBF7qWn1tUDgUPpUhlIISqbselKydfIgCU4LFMpqvyhApxW/HwpP6U/rUO
 RTiqCLLP2s2Op+8/gmngKpecJj+DTCk6u+Xjx+Vy/kGkfkoyrh8NRiaaOebF4qcd8G4Q
 MobCYRCwHKp8FIp6PYG0uhsCfuJ16+ANk1wI6DQqCxlSe51W4KfYsfRXm5AWH44HwJkS
 yxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598592; x=1713203392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcOly76/DhggOn/gIOyjbUFt0Yi/pTy/JSDCl4K3h8A=;
 b=r/k5FpphgkGC2Ayr+PYaKoyzK4vUZA59r/POT5XPOgktTvGUwK4f7gLTDmGcVzTaLo
 AL2R0mrCur8gbJRfq7t/daarYViXsw+ZP1NnpOccrGWmSw8AhANHgwP9/CLKA6PUcuCv
 LJ03cHmSIRthXOIq5FzX/4KPAfsdFVjd9D2Lw6/dpplo01fnzGkrOPyYtxHG0/ehkssy
 Cm1zXqCji/VOYDjxjUvXsk/NvgoEIgNma2hnDntApLRylMoCOGI4WPaq63B3+YP/iIH/
 j6f4VDls+vtoIZaAAOC8nY6uavY+D/SEO7uS9s4AfmpJCCqRH2Ba/ththKfNYVFBDQjD
 ejlw==
X-Gm-Message-State: AOJu0YxtIybQyYmD38ZdBwxNlzsob4t2iP23PaU5K8hseBUE8ECIFwfX
 vM3/aZCPvStDU5sPdpn6R2nsANsxbWTbg0Jhs1M76ogEkplfImZ4MTW249r6L+QoLp4MmafCkQV
 i
X-Google-Smtp-Source: AGHT+IFiZwCw7WInyBhBXyvOvlay8fXeihUZXA0Y5DtaKagZLzKhRnvNZQDkGDWgWSnhQm/l6qlqUA==
X-Received: by 2002:a17:90a:1b8a:b0:2a2:5ef8:ae81 with SMTP id
 w10-20020a17090a1b8a00b002a25ef8ae81mr6960836pjc.3.1712598592323; 
 Mon, 08 Apr 2024 10:49:52 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 14/35] target/sh4: add missing CHECK_NOT_DELAY_SLOT
Date: Mon,  8 Apr 2024 07:49:08 -1000
Message-Id: <20240408174929.862917-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


