Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51BACE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvll-0006qn-K5; Fri, 14 Nov 2025 10:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvby-00068H-4P
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbw-0003tP-Ef
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so23877645e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133675; x=1763738475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZtUkU3Iq8T00E2//P0yo9sIxgGNCw9UjWil4f/LYN8=;
 b=W8bWdtFScMR1Wm17Z+SaRBzbdqmHZENWZLljmbTlm+rwlVcp6fIcKeJrR9Qv2PoE8M
 PsvNb09Cx3POeZ/itj6Mohs26itIvBk6WY9Zx0DxMYtLtZ2E/JwaJI40flNWVVgfRVKM
 1G7kKNWjI4GvFJeMtRKzh1wKjyRc3Vz/JJmYAmxdO2ge9rEmoT3K5mgmsdcwxXViJeoQ
 fefJkYw2KboxnkvVeoJQGKyMV35zZVFtwPBnvtxmP3pp8LsW6jX8DEpQQ0z+OZqxX4BX
 CqcH2booKFrjLImDzCqmYM1FfCsDwYgNSyJ5IKT54wfqPvaD8BodzNOzI9oTkPyg8OgQ
 8+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133675; x=1763738475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZtUkU3Iq8T00E2//P0yo9sIxgGNCw9UjWil4f/LYN8=;
 b=wK8oFSQyBJdphaW9+PUrYez0AJqIhh1gYtJ1BzZjLMLAcTbw1kuavEZl5ICzFS5cdG
 OcMOGD+IIzDhV0QQ7ljRO+g/F8ip2gBp/ZeR0JUUPQ8T7IhTL3V3twjFLe0GyO0ZLdc1
 VRPQ9L/aLckJ9OtY9KAHqAEuNmSx7tsCj1L7F2LP/Y/W1OQlJhwTKTzu+mv45HkxqFto
 V4l4qaXW5tX5Lv1h0F2HomiC45dK6bho/tVl8GYcy8d0Z5C9bEdWIs9GWWDV9M3F2NYV
 epxqY+xiw7ghd7aAROSoOua0T7f52+QVTeajz2UEM+3XhkH8gw/vZ2zl0GcwYN3sIhwP
 ts9A==
X-Gm-Message-State: AOJu0Yx0mFyJ2rmMdZWwV6oT1fCCHPeFIKdyg2TE0XcJCsVfmT+NG3F4
 ixPpLeBYEnD/c/ViquBLp+1gNgHw8iERVGyUBTxGK/ybM4+fagAYc+zsGKt+tmv763H8g7LQD8j
 yAgSo
X-Gm-Gg: ASbGncsm0dI7YiXSTWtURSYv9aHpiM71cb3L0v4YdcXPzs9fmG6zwimA7qAcxMuQuz7
 CBuRHEAi1a7s0/krBB2Jo7a2cwp74vMrPA6umKTR4rZKpwma0qkGBkVNmfKhkHIkmkvUJT13eaF
 QFQ3gsdkzfloPtjxdcp53dPIV2pcpeO7NwXhNn4R7tbFMsDsKGBbALdKc+p90KOm8ATQ5ZfiOuF
 /YZv39BGurZGP1VasCaaSDUDxM7DkG4C5cHTelTtCPpepTswACao4xs2U1NHMdQQOzm6kWiVUto
 Zfv4uusrgvvZa6BYFWIFKMihogbJsf8KWrMFr6WPe6a4Mp1Ye+zlFwdEsquR8ttzhpBKoWyYxPr
 iNznicCu4FlRTuk00aRPHFgSSacAsiI16vVUBATjuv2xMXguTLR+ggWcxKW+gjZzLearQvX81eT
 h6VzDJsGLb7XNtf7kL
X-Google-Smtp-Source: AGHT+IFIkT4ujWE20/hkb77WOkSU2Uy3mDGCkAcrbF3RqTiy24IO576GQfNWKbBB/d4bAuKiCFSkqA==
X-Received: by 2002:a05:600c:c4a1:b0:477:3f35:66d5 with SMTP id
 5b1f17b1804b1-4778fe95fedmr30829595e9.26.1763133674648; 
 Fri, 14 Nov 2025 07:21:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] target/arm: Fix accidental write to TCG constant
Date: Fri, 14 Nov 2025 15:21:02 +0000
Message-ID: <20251114152110.2547285-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Currently an unpredictable movw such as

  movw pc, 0x123

results in the tinycode

   and_i32 $0x123,$0x123,$0xfffffffc
   mov_i32 pc,$0x123
   exit_tb $0x0

which is clearly a bug: writing to a constant is incorrect and
discards the result of the mask.  Fix this by always doing an and_i32
and trusting the optimizer to turn this into a simple move when the
mask is zero.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: <gustavo.romero@linaro.org>
Message-id: 20251106144909.533997-1-richard.henderson@linaro.org
[rth: Avoid an extra temp and extra move.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: commit message tweak]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5f64fed2202..63735d97898 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -303,20 +303,23 @@ TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
    marked as dead.  */
 void store_reg(DisasContext *s, int reg, TCGv_i32 var)
 {
+    uint32_t mask = 0;
+
     if (reg == 15) {
-        /* In Thumb mode, we must ignore bit 0.
+        /*
+         * In Thumb mode, we must ignore bit 0.
          * In ARM mode, for ARMv4 and ARMv5, it is UNPREDICTABLE if bits [1:0]
          * are not 0b00, but for ARMv6 and above, we must ignore bits [1:0].
          * We choose to ignore [1:0] in ARM mode for all architecture versions.
          */
-        tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
+        mask = s->thumb ? 1 : 3;
         s->base.is_jmp = DISAS_JUMP;
         s->pc_save = -1;
     } else if (reg == 13 && arm_dc_feature(s, ARM_FEATURE_M)) {
         /* For M-profile SP bits [1:0] are always zero */
-        tcg_gen_andi_i32(var, var, ~3);
+        mask = 3;
     }
-    tcg_gen_mov_i32(cpu_R[reg], var);
+    tcg_gen_andi_i32(cpu_R[reg], var, ~mask);
 }
 
 /*
-- 
2.43.0


