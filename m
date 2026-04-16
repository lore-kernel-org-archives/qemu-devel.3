Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC56F8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTuZ-0003ii-Fl; Thu, 16 Apr 2026 17:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTuF-0003Jj-QH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTuA-0002o4-3i
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so1955969f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373538; x=1776978338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUAhKFrbXgJ52TQIirz4eY3ZfxYReDQPGbifO+GayW4=;
 b=m5+RshzOqMX/rRMrKYydaqUbOO32aoGPLMfj+efTs09tDN6FbMKGkO/1Xhv1ZWbL1X
 xNEJeNzxYlpU7D9RMjeLy9sE1LMYunp13PxN5eDe1mWAi3Paaeh3/HGD6TVBRoBBMhXg
 V8/uoWV5WjS4gbcgQV1uyZ4XMe0Obvu6hUp9/xTXYxiPiVvhxozplEK1sEJulCSlNL7k
 NX4h7xT9+g9Y9aUUOu1TKWzCqV+Lx1oVPIy9cZYfL4DJeDAjXtJajoQAPuEQTyWNGnIe
 EqJTvCk2S7bTIX1sqI9s8jqebhn55NeduENA1ht3LPtuMzGvQaNc8H+3QYBUbLFQspQQ
 l/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373538; x=1776978338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUAhKFrbXgJ52TQIirz4eY3ZfxYReDQPGbifO+GayW4=;
 b=EqDPha2iIAPTb2K1p1IK5yA2ro4bTHZ89NK19UMvlBEgh/TA6lFydxpvH1RlcDzSpN
 h9fI2kxlbf3/7Us5FZqx+pQlbQUOMx/C2h5AJiBdw239jiOpzB0PhJ8FusrOLUVT4Ae2
 n8fuvdsCbww6Y/5k5IEeeJN+LN3TnT5Iglt9moFA034jhOkJRtM5kNLervf7CSsl3lvl
 v6fhbc2ooYpKRHgAvTAGQMK5pP4zEX22iKtvCGN1IMa8EEQKSXb9AjJC0cUjqIT39dDa
 orSm3xs754D0NoQGXc/pVLsLwLeWmh0Mff2pwTrvHfTePZEqb+TAdP4k7JdUUx0fu3Vz
 cueg==
X-Gm-Message-State: AOJu0YwPGNNLWIjw/LbQ9Se+4cFTkExmhwDijIwULPwr5RRypeB2p9PU
 TfpzwX3vSGYogM8iL0vUMHU0cNJN2mJToi6b+pL6t4toCfoHZmEtWoTSUCwPmW4XC3e0KXdi0J3
 AN/maQF4=
X-Gm-Gg: AeBDiessrpqSM5yH/xR40Cj78HjhXG22r053GkvduOaDzzaejpLs2OFb53RsZjfGSuF
 EL1aF95H18uos0nMWZ/QntD76hR5Uv5L0a8FwRQPKLwQ7Bl2EeWAAMXsizLr/W2GOTzuxj0uM4o
 vEuZdOrEoiADoQI4EeM8r2Kjeen3vFlyy6btFwGD92vSwuYXN/dXrcadRcYHpPCl2YpRl+qYyhE
 HrSevPubie2KAqIBI/+AJT4XHXDVdOf4+MDnlRsIPH5dDYmbSsO61in3t5WM7YklyYo3/Yg89ki
 lRmQ1Getk1hpboJZCnv0JxpyS5NP5h3jP2RQ1UtRX7UKewHTvyUA94+LQP/O5rFqPc7OfAd97lm
 nT+kyMv6fOwd96wuwFwzNBYXfky8Hj2bgEv/FKFgbsAAWSoZsocAk8x3c6HiO0509aoN1/CX+LS
 hwuRAgGvPEPrtMprb6fh60XnVwFuE6U965Ixw8vqZAbBAS+KwlIjUhRLJg34tr+lvCXXA0O+u+9
 Y0qs7iKqRMd08e/hXjWDw==
X-Received: by 2002:a05:6000:18a3:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-43fe3dd4b7dmr138757f8f.21.1776373538433; 
 Thu, 16 Apr 2026 14:05:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm17954920f8f.18.2026.04.16.14.05.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 14:05:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
Date: Thu, 16 Apr 2026 23:05:08 +0200
Message-ID: <20260416210508.30686-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416210508.30686-1-philmd@linaro.org>
References: <20260416210508.30686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
Pass the MemOp alignment as argument to gen_ldst_multiple(). Keep
using MO_UNALN for REL6 decoder but use MO_ALIGN for the pre-REL6
part.

Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/micromips_translate.c.inc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index fb107eb91fe..efd9781c53b 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -690,10 +690,9 @@ static void gen_andi16(DisasContext *ctx)
 }
 
 static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
-                              int base, int16_t offset)
+                              int base, int16_t offset, MemOp mop)
 {
     TCGv t0, t1;
-    MemOp mop = MO_UNALN;
     MemOpIdx oi;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
@@ -772,7 +771,7 @@ static void gen_pool16c_insn(DisasContext *ctx)
             int offset = ZIMM(ctx->opcode, 0, 4);
 
             gen_ldst_multiple(ctx, LWM32, lwm_convert[(ctx->opcode >> 4) & 0x3],
-                              29, offset << 2);
+                              29, offset << 2, MO_ALIGN);
         }
         break;
     case SWM16 + 0:
@@ -784,7 +783,7 @@ static void gen_pool16c_insn(DisasContext *ctx)
             int offset = ZIMM(ctx->opcode, 0, 4);
 
             gen_ldst_multiple(ctx, SWM32, swm_convert[(ctx->opcode >> 4) & 0x3],
-                              29, offset << 2);
+                              29, offset << 2, MO_ALIGN);
         }
         break;
     case JR16 + 0:
@@ -887,7 +886,8 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
         {
             int lwm_converted = 0x11 + extract32(ctx->opcode, 8, 2);
             int offset = extract32(ctx->opcode, 4, 4);
-            gen_ldst_multiple(ctx, LWM32, lwm_converted, 29, offset << 2);
+            gen_ldst_multiple(ctx, LWM32, lwm_converted, 29, offset << 2,
+                              MO_UNALN);
         }
         break;
     case R6_JRC16: /* JRCADDIUSP */
@@ -927,7 +927,8 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
         {
             int swm_converted = 0x11 + extract32(ctx->opcode, 8, 2);
             int offset = extract32(ctx->opcode, 4, 4);
-            gen_ldst_multiple(ctx, SWM32, swm_converted, 29, offset << 2);
+            gen_ldst_multiple(ctx, SWM32, swm_converted, 29, offset << 2,
+                              MO_UNALN);
         }
         break;
     case JALRC16: /* BREAK16, SDBBP16 */
@@ -1861,7 +1862,8 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             /* fall through */
         case LWM32:
         case SWM32:
-            gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
+            gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12),
+                              MO_ALIGN);
             break;
         default:
             MIPS_INVAL("pool32b");
-- 
2.53.0


