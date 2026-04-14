Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C160F531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCS3M-00021P-I5; Mon, 13 Apr 2026 20:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS3L-0001rK-7d
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS3J-0000Rm-Nr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so54482355e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776128092; x=1776732892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHW44GHNwYo//iL9S+vNgBtIZBRoswNn2La2YETdq+g=;
 b=PbSCEJtjKZT+5bvc4i4kH7rPPgA7z/NaxzSesr+u6wP069oMPEn5oaKhemhaztXHK1
 dGyTwzGm9/MX0P3wcdzQgMzfFwjYtig0RsvrUZboODOqNDgl01pfoWYq+lp45SBjjjsy
 uQWFeQn5qHtZVWNLXzO23oNsGMqsvesGxQ+QFDNDV6cI1AJceufWvI4YzCKCurq5dXkM
 HLaeMss8RR/DYN4s2mawiOUNHu1JqQvXJloNVwupDg7kp8bAj6Y+qycC2VtQNoypXmwH
 wvSCMv/jHS+YlIZFMQq4Og8GfAwfzHKxMW6S/HfQ0qORnvxzFpIa1Ndq53NxJNbot2lz
 Rg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776128092; x=1776732892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cHW44GHNwYo//iL9S+vNgBtIZBRoswNn2La2YETdq+g=;
 b=SZbcgxOeiB9lMircfoT8mgiGlfaPtQ47yJHq9JzV9n/TuNB9I9S36ISPzLlFILmxu8
 WQ9mo7jMdXrs3OSheFwQXc62ksN4isEHhmYRP2V/kw4+obkCJCzshL3JRrqT4NsFCvEF
 zFs9g2ffD5jEA3sHP8CdYYeG2j2w1aEBco2gI8fCm2ZzQUW/w1UC+cwpIivO+KMfAhPB
 wXn77A/mm5N/2XTbmFIpjyTh+QfmQfXnzzqsszaXUBP/NKSkaSXi6hZOzfllq0Lzeg++
 1qtzK6fpK3UAw9lGSdf71UwNJhJmJy5SayYWxHyRIJzKxCwhXwmkyTuDIFFuvi+Rk7WR
 j6Kg==
X-Gm-Message-State: AOJu0Yz55ufweqU1O5kweQeuLj8k19C/dT5B8WcfZMo5ZQDjsrggSS0f
 DIpa/fDGrkhVHGt83AHKoLT7m0GzPkHxMh+ryJ1G+kQRer8TrIzHPI44YmNqkao4UwLAPPmPb8J
 s/GnXMQU=
X-Gm-Gg: AeBDieuE0Coy667O55/ekNk+ej3sZiwwTUkIYa/D4yUElsvgXuFy/WeATwRkw1xTEjb
 rLy79XjWUT6nywNHJi1UH8zUn9z/xO2u5sGk2p/dvYc/8d5NJQKHbPcQX3NHVvJwvYgKvXAUc8o
 ry50t+ZHGWKv/n1QTv2lI7OMvdYD/YlDBCa0LxG0MZ+lt2U2IMrvFKxWfsxTd9Cys/GagqLd/+z
 PJCigy82H24lZC9muTGyOniRsDOl//0LBFVzPPjgLeftvbuLxB0WMQnHno083juRGzeUf0GIzb8
 ZMth7q08LXVbPnmwXOdT3pYVFLfIr5iKxbJwub9NU7nT+mV9ul90cT2BzL44iVFZu/jmjJ0wGBW
 A1A4gTmV/BrVFjo0XYTJ74FmJ34DVfDy31aiMBJXq///rlBFndgBhszTIgKrtpJoYBo0zWhUVCI
 n4la95qVijygtldxj3ZTTrzOnJlae/a+6XU0A2LShg3AGUDU/sZiLa44CX4CfWLDbyvTJS8k6ne
 RPimO1wJZU=
X-Received: by 2002:a05:600c:474c:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488d68101edmr191625055e9.10.1776128091721; 
 Mon, 13 Apr 2026 17:54:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488eddb9751sm12940005e9.0.2026.04.13.17.54.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 8/9] target/arm: Replace MO_TE -> mo_endian() for Cortex-M
 helpers
Date: Tue, 14 Apr 2026 02:53:47 +0200
Message-ID: <20260414005348.4767-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414005348.4767-1-philmd@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/m_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f5954ce9bf9..1bec8e9aea3 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -634,7 +634,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 
     /* Note that these stores can throw exceptions on MPU faults */
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
     cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
     cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
@@ -1055,7 +1055,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
@@ -1131,7 +1131,7 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
-- 
2.53.0


