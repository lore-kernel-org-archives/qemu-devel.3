Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A243ACFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4u-00034C-5Z; Fri, 21 Nov 2025 21:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcoZ-0004c7-ER
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:53:27 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcmX-00061N-S1
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:53:24 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b728a43e410so476360966b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763776259; x=1764381059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fq19cbHx1urHYB7WgX1thdWAR2rwXrisZPcOy65hifc=;
 b=CXTXrC03rOGdUjmC4vE1dPAaL4l+wKMr5Jd92rM60YVAFNblM7f5Pr/juvB5RPA6lp
 Q4pNe8tiQXbBEi0CwAEWIK8YIY1DhpbCwOuU4ti1PlrTurHzTdwYJB72D+qgHvV4IrUu
 Mg+SJeC2CPYi0VHiieMnvraCR6GAnLWA+hTbPhUv3shsx+oFw54KF0mdefnTBL1g2/uy
 b2e+JZwcjBOrsOMAWH5ithZyI9BKLS0C5V/VTggwrtTq/ZcUuhUESMXKCC8KZkcHOWPD
 1JEbfzxGr2co6Ak2a2i3FB7udzyTYjO5rAKcPyC6tzC/aIvlRsWJOAfxaByzY1pGaGr2
 JxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776259; x=1764381059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fq19cbHx1urHYB7WgX1thdWAR2rwXrisZPcOy65hifc=;
 b=E4yPCKNoQuoRcQoFCwOySxHp84i1IG+Yw4JG7YspAfeHZojIkH9F0W68pt/1KqSF1y
 PYKq2W5/XlQzLZhSoCp43h/hiRqxzkNfYBpH2x6RUo8x3wIScGmi06VPBM7BKQtnT2/x
 3d/VEchycGOX8bFS5K96yufgb2uBomA1Uj0WZof3lgmaRG1SnN3OMFTeeOw+sIg8wNZ1
 DoA5Stb4azW4DpGbXsS7Lrxkzi3m2lA5zbJ4VaXb+XWMndqxSQNX76DvVfQV2qSZjiGH
 8EQ7mzpEkLQvIlKgL5guFOMmjguRg66BwpshxtmjqYnn8t50N510XLRHSpUkY3jcofAc
 rZ6g==
X-Gm-Message-State: AOJu0YwvscoBub++rHLTQ1E1k2QPGf3RkUVyra3pEVDe959F3FemEwh3
 VkTa81PDZ1qcg0n49Dg4lS6CxNW9CPaZXsBigc3cMJekTK2quU8acJIGUVQDu0nDVCApKk7MDKb
 I4OAMum6bUQ==
X-Gm-Gg: ASbGncvQzg7bBVWdbTcyWu383iu3i9UGaAiX9/LaBOEzdJEs51pUDVhf1opJMMCcJkb
 iJ9i36YMJz7PJwjlfq5uXkOmvfQfsQs6KmyccxH1+POdEwAOs9jEWpVeskYmv1M82ok2ehC/2Tc
 7TCZ8D1iZPj8W42AVVgv/AZJqn+I4SGk7crtJUEcANl0lhzQEkw7OG2VBOaYO6+Ds0CdFqlOKUp
 T3WCoXQo9e53YGoavpLeFbupYmqigBbxDHVJf6v/1LPq6y1sODkRePpma85GN3KAijEQfaJcU5e
 70j9QAD3JnnuPhL2bmxsV5vCa046ucuhp6mml7sz2NIVi7QUQ1mGrGqiDhyj/BoNk6iKoRYfAys
 dDeQ9i8ZTxEqWdJLlcbELvZ+JNBqbbtcZl0TUsh8UG0THWc8YUZM/q9sp1NiBq7dHd70p2CqEKh
 HxpGMH2lUXudteNa04NoUrNkxKpTDteRnP9G0u6F89joriRnFXpnMEZMyIZFeC
X-Google-Smtp-Source: AGHT+IFNOpsJhQzQPin1axIEEtvxDd8MYGAjtHV1dNpSExkzS4tkHFNwrMPxw8oYK/UwOJeSPwDpOg==
X-Received: by 2002:a05:6000:2281:b0:42b:2e1c:6341 with SMTP id
 ffacd0b85a97d-42cc1abe28bmr2632465f8f.9.1763732752391; 
 Fri, 21 Nov 2025 05:45:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a76sm11017266f8f.24.2025.11.21.05.45.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 07/21] target/ppc: Replace cpu_ldl_code() by
 explicit endianness variants
Date: Fri, 21 Nov 2025 14:44:49 +0100
Message-ID: <20251121134503.30914-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
 target/ppc/tcg-excp_helper.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..b2d36ab11b1 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -424,22 +424,10 @@ G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
     cpu_loop_exit_noexc(cs);
 }
 
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
 uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
-
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
+    return FIELD_EX64(env->msr, MSR, LE) ? cpu_ldl_le_code(env, addr)
+                                         : cpu_ldl_be_code(env, addr);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.51.0


