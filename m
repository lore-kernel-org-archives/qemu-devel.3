Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC8ECD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYH-0003Rf-RF; Wed, 27 May 2026 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYF-0003Jj-Hu
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYD-0000op-U7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso6442615f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877908; x=1780482708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eAeAS637wuKZNTrGUk8qfUmYuZS+oEmQbAobgzLnoz4=;
 b=VWTCTCyaF+zFTgUUPMjIh9pFH0QRan1zr9a+8MBh/52XrpsRotB+eNt9WUOY/MN4oA
 spZ95cW9Oj9Dxs1nZ9am07ZRt93I37mIOuNEUTZ7fYtNu10XJYrH3yB6lCqtcASkGMps
 3urbBbtOaoEc/qdinglQRlFNLPMshaNuDh9RzdVbBpkfBYCj0EpFlMbB9mnb/hEP8c9b
 6Sizr5T4WTEOtr/RGbFZyoGCbgyfZ74pbhIr/6y/el5PtuVTh84XDWKz/LdhSb1sdFj4
 hFRmUSFyY9DH2Bm/RViVcFqBJj4DtAtmRK0m75LqeNW14dXWht1qw1n2pmXS+9kVYujR
 LEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877908; x=1780482708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eAeAS637wuKZNTrGUk8qfUmYuZS+oEmQbAobgzLnoz4=;
 b=FJGXaG0kqt6wJDTiIhSXcRbAwMa3c/q3WJ16deFUJZQcMtBS30KDLUubxU3lgXxJXc
 L+cVb9WRlM9KIVw3AGW+WA98DqYE8iN00BNHzmZVTT41Kewcxk0XztAnaDV2DG1H84Sp
 cxJYSzlZTeOZzo/Q61YqD18UspzJ+mjOFI+2hT8kGpnyPpWgR3qt3QO48GmoWE89KsT5
 Fh28lFqWw7Dxn2BhJmSwMo/1KhWa2w0NwldMuN7auN6WedSUWgRo8/iSyqCweoCCGcoJ
 vyqmwZJQoNU8zkjlvMhI2vI302d8n/CBcO0aoU1OcGkyFIntFkMa1+1w0BvMClMHnWrT
 Lukw==
X-Gm-Message-State: AOJu0Yx+LBIZ69oc4oHPkSH5gbM8/flDC8PJ2D0PMR7ijy0Ky16weJyB
 VWsshnLU2h/kqqAZlZ+d4lyHwP2uTdgf+IwvMCToAnoqFpzqnDaDDsT1AMViYYKnaFiWQs+393T
 9QLQed6idTQ==
X-Gm-Gg: Acq92OG0OiW5Z450RD3bGN2Z+XxXHo5OnOmj8QS0qZMuea9MJC2EbpXLaBEAuoEUFKK
 Yv7tSRdaA3MnQg1TGD+mbqOT+ixmYr1JLbK3+so5N/InGJSJLebf6Kr8V8/lgc3yCmfhLNsTyp9
 H/lqW6oQrDVNlNtCnKnMNu7Wsq3klMz+BH3QKNp/BjLUQy3vAmftNAY30n65+GkVP+5gCDZj+hk
 OF0S1BtR1ZEprCjSrOSfngIZyvY89+XhdH7SB0C2iXT8SnkjoK/PEOa7lnFvAQN2R2BN7I1nvFr
 DfYDabR1BYFFxrmv3/cLEFIKF+JJIXt9kpi/wG8sUjMYRGeZPLd9fGC1fSJ36rMnlksmixqhCVx
 V8v3u7BpeO3OIaNrsIKoUVEEBBZXH0CE8hO0bWqzeTeD/AEAR4f4zwXnyo2xOW6j0vVn8W7Z9K5
 /cD2jQ8hjsvFueDMdfrXaVuBqS9Ac64w7t+GqkMnSAil32j5VZqfC3CMGte56eVbOtIg==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:c3fb with SMTP id
 5b1f17b1804b1-490428ddd40mr397436575e9.33.1779877907730; 
 Wed, 27 May 2026 03:31:47 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm366945225e9.6.2026.05.27.03.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] target/hppa: Use DisasContext::mo_align in system
 emulation
Date: Wed, 27 May 2026 12:30:14 +0200
Message-ID: <20260527103037.4461-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename 'unalign' as 'mo_align' and use it in system emulation too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-Id: <20260513074323.10616-2-philmd@linaro.org>
---
 target/hppa/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cf57ec518d4..a05e7e70d19 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -91,16 +91,14 @@ typedef struct DisasContext {
     bool is_pa20;
     bool insn_start_updated;
 
-#ifdef CONFIG_USER_ONLY
-    MemOp unalign;
-#endif
+    MemOp mo_align;
 } DisasContext;
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)       (C)->unalign
+#define UNALIGN(C)       ((C)->mo_align)
 #define MMU_DISABLED(C)  false
 #else
-#define UNALIGN(C)       MO_ALIGN
+#define UNALIGN(C)       ((C)->mo_align)
 #define MMU_DISABLED(C)  MMU_IDX_MMU_DISABLED((C)->mmu_idx)
 #endif
 
@@ -4654,12 +4652,13 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
+    ctx->mo_align = (ctx->tb_flags & TB_FLAG_UNALIGN) ? MO_UNALN : MO_ALIGN;
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D
                     ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
                     : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
+    ctx->mo_align = MO_ALIGN;
 #endif
 
     cs_base = ctx->base.tb->cs_base;
-- 
2.53.0


