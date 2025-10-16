Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D937CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvf-00086T-Fs; Thu, 16 Oct 2025 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mun-0007Bq-Vm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mue-0008GO-Lx
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so341924f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617006; x=1761221806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pUBl5eiKlG+DGbCAbFTBp5G4jNqRxWSFACnuFGQauxg=;
 b=WkRN8a+M7hLUrErXrmvww2Qb4QhTuchzlcMM/Y3PcIbrWaiY/dZ35gVrjyrd3KTAtP
 skEOySJgXS5ATnw2sG7xxs/jdz2C7nfZVWtYjItqLAc88uoTHAaW1aK9AsbE2eNmf9Y6
 7NamHZrEPLhqqd0ltnWm69e5AH80VdhgUcHWTNxs+Evdw1Jn+xHGF/zLPjvs62tZ8KZk
 pDCXryuBB5wybasRjJiHJ1dJ2XwocU1zFNgG80oiEJDz6sSB/HvEk2+zTFX2nAAUqYVh
 VIq3UkW/fMkHpyv1O2BUj+mjW4LahF/GHJgf+Na/s/FtJuej6ImbXZj4y9QmM0ScOj68
 eLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617006; x=1761221806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUBl5eiKlG+DGbCAbFTBp5G4jNqRxWSFACnuFGQauxg=;
 b=FWWI/owSD0A5W6LFyw66LHf45qVmxh2Pxcx182+QkUiBOaSXgL1pAgJdZPj4QEYyFo
 gDsR0Z5HOxVL5bgnEcsXmkE3Hd4JRjnidCnN1kmVPIFzDgdCbBX+xtZi/KxLDuA9jx64
 D4DJqIcWvQpKwlI+tlpgqnHAl7J0BuF79nC9/h/q6WwPPUs7BJhE6evqREzhdSb3WPC3
 BbsF4SLtDJs4dk5UO0o3Nha3PUgapOfdS9oetbmzYa3BWOSAygQr/viAFHcd0HCu6ZPD
 PXcFX/BR+kFH1ABODvClyzzFUsjNTFwGoFQrhazU8AiwemcX2xkirZ3BCT1aWbjSNCZZ
 8z5g==
X-Gm-Message-State: AOJu0YzDJfpALkmW2WVru7V0uKG+dRf8nWgGOPxfMsz3hHYmD55DHiwa
 /bKWBbaQdx3KqfAVKyVBnL/oM/ebj6SGF82FXx4+d/zy1j3xM5QhoHSucvPlKotCbIJLKv7aaMn
 oCoiZ/d8=
X-Gm-Gg: ASbGncsrUxTPw20SK+JuAHiGg1Tu5G7+g0wr5HIqL2ihKEE5KAd0l6+V2P+vifhNN/x
 rOmNHDATiDUWv9njk5gs22woDPiKV7Hi9kOe+zh+U78SNi0tC0Z5c/eUz7rT+DXFEZOomIGnHT5
 iOx6K2G1LwM2h1cYBRxKNIS/BG3Vxk4H3z3Ltyp0FnB3QgoV7fYuxV7EQL+cL3qgfCbu/9tIV8V
 Q5YuY//ys/yXnLczBcsi2F/WOCmSVmdu5+2V3Qq5EDa2plV18P1kfpsUVM62ZByiXmcNBJhy8xc
 UKyHTN65Fzj+nfYfL04GweLv0CBGD64SA8tvAvuEnWAdSCc/gRT7o9U7538h/e8U9wDeK28LVBU
 WUCmfFnxXnlmTVUD3iJGFMeDtI6rH8pCB4exPbrV0nyFtMq0JXqkWjuBJPITt+0RvpwijacTqvi
 n0ZZC+EnF0T8oJdQ/wEg8v6W0JQ63v+r2Wqs4hw3G6z762YIwUj1ITsleqDffd7RQ+
X-Google-Smtp-Source: AGHT+IHb6Hz2irUQHgnWRK08nVLm5wOkuC7/bOiag5wEezJT7/rWa2N87FwWoCrYlaosgbqDqy7yBA==
X-Received: by 2002:a05:6000:25c4:b0:426:ee84:25a1 with SMTP id
 ffacd0b85a97d-426ee842899mr7598575f8f.38.1760617005873; 
 Thu, 16 Oct 2025 05:16:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42700072619sm2945477f8f.46.2025.10.16.05.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/75] target/loongarch: Remove target_ulong use in
 gen_goto_tb()
Date: Thu, 16 Oct 2025 14:14:31 +0200
Message-ID: <20251016121532.14042-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
translator*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20251009201947.34643-3-philmd@linaro.org>
---
 target/loongarch/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 57c3b8c4bb2..055f6fb6046 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -99,8 +99,7 @@ void generate_exception(DisasContext *ctx, int excp)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
 {
     if (ctx->va32) {
         dest = (uint32_t) dest;
-- 
2.51.0


