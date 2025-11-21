Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C233CCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4Z-0002qa-1n; Fri, 21 Nov 2025 21:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcQD-0006kF-RQ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:28:17 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcOB-00009Y-AQ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:28:14 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5957d7e0bf3so3410769e87.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763774751; x=1764379551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/moKxyhhhNUAAssiCB4z5/4yHLvVf9L6ospDexZsZ8=;
 b=PG13HG37yyVlU69B01i5+DpTCK4cumYnGbejPOA2eKkLGYymoloWK3GjPcVQUAmAvv
 2A6HT4M1YLiQqbhHt7augbZHQOX/HmzAmBGFqxUiQNPpXxV7I6vztkCKTM1cDXzTwH4h
 aTvUGm5lKQ/qrmQ0sNlwVA3pNjBzb1fgvVyV1UKGMeGOb7VkzKHGig+N1Op4cpBKB7ih
 +45+C9ek614rXQ6CjYSY6prEjmuyVHvxKzEjonciAcUvYQEr242dCorNAH4VxTNRU/mc
 UPdvuG3+m61kuValvMTIHqbGCgk9/6naZw/JPAM1j1EX4nmFI4KzMELTiDUWG2kZVirC
 MEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763774751; x=1764379551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/moKxyhhhNUAAssiCB4z5/4yHLvVf9L6ospDexZsZ8=;
 b=NX1A6XUmwQJdgVcr5Qz9jjQKOeITr8SU3ZkeAdbjP4RJsMLQsDlhoMdjhHGbp2UHri
 5oZZcradTAh/g14z5/mJ0pQeE3dSNfgkmVl0IkZWgzcUgqHElt1pIqfB6GifsPo57y/i
 3mi4VIp5jmZB2wPIHN/gyLo6ct3H3pqcfbDJ5FBi0wRWzWAPyruyy0L1ufHZmTU+/Pqy
 d9u7PiXB5X2AbhCYFiwFGiMYXeNap1U954BX8NikasvrFW9my3RypUeDve+ZOE2i4vmw
 JmFe4RIYt8l3nthb9mTsYGGx24nfFoF1QzxwB4Mdd1nxW27AL3eTAwkLMHADUaL8Q147
 pX8Q==
X-Gm-Message-State: AOJu0YytBSCXv9mq2CZN/hymOMU8bzQ/tI321W/ZrVRnJv9Nsgx7SJtH
 pz5fdByazOTdkOM2yZSrzKl7Y7suUSJBd2xT5H0edF1Okeswffz+pk859QWs7nabebJtJQteLLk
 mZ7U5rkdiPA==
X-Gm-Gg: ASbGncureaCQhgsFm2QfcH6Msgtl/fSdyHsLW5cxngZ+ipsXG6CzQ/Fxn0JKG+r/Mt7
 uJWZzR1qb8FpEyWlWXbE9Ybw+qhWGumLNxs+J5awpVeCtAUfvAvdqWBVCFXcX5cch2kivDpfLtc
 xuhB2WYtdADZZK0fGkjA8EPpmelczV8tAeyFYLN0biTy2Hfx2pOYpjY8rCkTKRfKkAkcPw8VhFU
 lbcWCXPae8ebox5rp18OcfNxktXoDCHyeaPIskBhDMoXm8zD7ERWzx8g4PvKWc6CMArqplT+kBx
 dUMTkfo12+hLcdNR44JKBvKjWW1+GKpsWHoRJswncay5EKnPo2JLd3Ux2huG0Bbogxu1bOvCcZE
 B0KpGiFGM7TRcvBRPix7yp7mJaLaiUfNT2jTNz2bLsUca2VwfxN/VfjCnIuMsHyVKPyReEEAkDm
 JpJO2J8/Eg7Gv6Op6kjH4KRM5CW9U87cwqKc9f+1/ZDEiF+Hxl5tmEHCatSKPm
X-Google-Smtp-Source: AGHT+IFbzcN20DaScomzYsmHRjV5CSt4lWO3KEMLbuCDkYs27Zm60r6STNqOz8jmbV2tgt6MpEztDw==
X-Received: by 2002:a5d:5850:0:b0:429:c719:e0aa with SMTP id
 ffacd0b85a97d-42cba63a6f8mr7604810f8f.6.1763732825240; 
 Fri, 21 Nov 2025 05:47:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm10967945f8f.43.2025.11.21.05.47.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:47:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 18/21] target/riscv: Use little-endian variant
 of cpu_ld/st_data*() for vector
Date: Fri, 21 Nov 2025 14:45:00 +0100
Message-ID: <20251121134503.30914-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

RISC-V vector "elements are simply packed in order from
the least-signicant to most-signicant bits of the vector
register" [*] which is little endianness, therefore the
cpu_ld/st_data*() definitions expand to the little endian
declarations. Use the explicit little-endian variants.

[*] RISC-V "V" Vector Extension v1.0

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee86..caa8dd9c125 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -193,9 +193,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
 static inline QEMU_ALWAYS_INLINE                            \
@@ -214,9 +214,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
-- 
2.51.0


