Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD79CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8U-00066g-Ma; Fri, 21 Nov 2025 21:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcvl-0001Oz-AX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:00:53 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcuG-0008NW-2m
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:00:50 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so560312366b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763776738; x=1764381538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgM8VF9g+T2JoeRRqaHzTf5tHPKfcxDzwnP0zHhd7Bo=;
 b=ySCzrNpxdXy6lpblNnG3/V3c6kfjw7GSy0XJjOwSzAtkSiNWtIYFO/84J9seLrqHCZ
 xJhfObBey/Sp7yWw42hrkbgArxIHnXp2vlJnwL2A3lTCuh9iYfP40xtypi278D6kkP3g
 4I7Qh2qUbtCrI/l89OkPUyJsmS62GAKnbsy8ZhWm6vZQo52Ofa8Gni3vdZml8i3UYgQd
 qnAxuukP7uPnWQ7QtTFuIQLgBtVF3ak9lgEzg9e8zXBq7a0c57PoY3iE3cRtRvlLZjcA
 bkerFjeHlpfN29r9vGUzONKihg6/wAjViiD9svr3EDoIHkzlDZqLsr/kV0EIyuNCpP1/
 WcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763776738; x=1764381538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TgM8VF9g+T2JoeRRqaHzTf5tHPKfcxDzwnP0zHhd7Bo=;
 b=eh9jzAX0ZtSeawtrrf1AVqUbnCcUgJCS6mFFh7hNKf8i7wJgFgq1bsgsyekTTkf1qc
 SXR+wbFA+pn5ZYjlGBh+sHgFn5R2qpoLGg8YLdLWuT9ptH/i/aMXt80qBHUU441RpnGN
 7P7sBau7xIkiLcPWgcjLmZnnvc3Wu6QzJVnPUEEAwrfSClZPg6nx9ZimDbULVvwJFDwI
 YhvcHBvnEuhsu3z/sCRsyWN8X4QFtaf6PGwRfOJ9kjYnVvdm0KpoUUs/QupJJJWzZrc5
 zlG2z9xku4Icu4fVirIm8dkJ75Vzrmb1OB2pfs2zgW/lmTT7G42hiqqCJ/RRsv7o10W/
 6Zuw==
X-Gm-Message-State: AOJu0YxI3Qk8XRdBDlPBKYFuLNaRYN1YFzKJKwml1YQzya9h2mnBJ46v
 xyttg88c4SkfZWLUS9zi2+uY4Z7of9P1wvPLAeKb/iissWTbiKRZn9/tNsJ43MrR2Z5PJFO+/WZ
 +80y1QBg0lA==
X-Gm-Gg: ASbGncsEZbqQ6LKEnmLKWV8XYx8RAaORC3HMXULJolvO/7+R/a84LGZYGhaVNc9I7Lp
 2Vn+HbfQl2Atty7iIRSuBDI7AN+GfRwDzTr2SIvNocvD+kjdrSezvXx5FUCG4kNNQdIXG3vj/uc
 r9yFaRaWVcHoRohdGjMkYa+gpKE35cYW4QAkxcmDIVtKq1Y6mHhcUYzgNHK0YTBkclbaqeqDukC
 o7jQJb8yV2dJD/6rF9H32ZTGl4JY4dYFzsBwwLFSc56Luk8K2kXyuhT1RqY3L6fNghGW9G2CrPp
 Cdb871pbDfuI6qLkGUt7c5S9uat9VXsQiATohgpYdg/pGqGDtZ/XcvN7//Y6JoRUS0FILeVaHxj
 ogjB0gs3IIC6PVKVrauNxoIHKF3gtry274kAWhBP6dlijN1oY/GaSTMGMvVltbvECePloIValKR
 +JRUKNZrDuNUV/QMAUzhcT5Bw1SbXUEtWyjXv1xeTjQyFgple+wtoiNAH/80Nz
X-Google-Smtp-Source: AGHT+IF3EsSzc0eJZJYndSarF3h0dI4pV449x9CnhsCZOYGbm8OepOHZAGRyHDokyTGWlmDUQPVNvg==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-477c1132bf2mr25241485e9.30.1763732724874; 
 Fri, 21 Nov 2025 05:45:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df3d5sm45386075e9.2.2025.11.21.05.45.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 03/21] target/loongarch: Use little-endian
 variant of cpu_ldl_code()
Date: Fri, 21 Nov 2025 14:44:45 +0100
Message-ID: <20251121134503.30914-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

LoongArch instructions are always stored in little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9d..3f4b5f9258e 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,7 +140,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+        env->CSR_BADI = cpu_ldl_le_code(env, env->pc);
     }
 
     /* Save PLV and IE */
-- 
2.51.0


