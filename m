Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B359C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhD3-0007hV-QW; Fri, 21 Mar 2025 14:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhCv-0007fo-2s
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhCt-0006R6-FL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1903992f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742582098; x=1743186898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RE0wVdA5EPxT4KkB4AoQ5ApL61ocTdG+Qs76h+UaNCY=;
 b=YZ6+tjZGFvEqvuZK0tstaJ0MSwCntg3m6IyPfui4uJwNLQfA+7F3HNYg3lK9PbbYZJ
 FuYIX/xWAOeHNzCEAhmVx/T3YCPZM32dByaiIfKkYyuM7pxQ0aQ2049tWhHbtaMSjNZ5
 0ys/7AuC9MJUnhBxSfjM8ApzhPJpg8+u8KBXa6KTOFl+YrSEHY8Mrj3FPRQsEvrDRvax
 k/1KNEzTRUrGKvCXD0OAtkMN636d4ddheJQttTFwS8qWpAU2szrfvBEVLJG/BGb8F2/d
 3nRhmJle/ezGOOQl6WX0HkDAsaiMYtPKGOIx5b2uFwDKZuKEAyWjPktPLP3/SBW1jDtR
 w66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582098; x=1743186898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE0wVdA5EPxT4KkB4AoQ5ApL61ocTdG+Qs76h+UaNCY=;
 b=vZkSotuSYF0Qa4kr/fVvk4j1iFPbfhRFqwbwtjbwUNxjjlbV4oPW++O4FPz8zaU8Ze
 rI85yUBS+Gg7khPjPL6sXFR/XxOg3k2hdUmqw/h2GLxVZ8D7k8FQfBmVmCXKK8Whby4Q
 /kvDkf5k9FI2oPKqSs67BTvS1v5+FdBhPPRz3xD/08msBTxGPGMYiDZBWVZh7JLJ1BIx
 Gmu/NdRepxRVrqPnBq2Z5G5ifAJuwcBhSzb9VvYo8JKk5Ttd9XZW270iOMMHuw/YXvgh
 CuFRju2W8gukRd3L14DRGQT3NoXq5lIAlYUprIfw0iVVBV8xITODrK2Im/XLiB9qk3ti
 I7Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvzl6yv1BM3Ly+Md2Ef7LzlKbJb1DUtNnCGY2VwTGGcnh1f0zptGH6ZkeLu3gyvhdofiXQ1OkMHahL@nongnu.org
X-Gm-Message-State: AOJu0YwbHSBGrLrsVpniX5qlmkDka3b7hYhmDU82lmdZPIg4lGul0x3K
 1jl4jBj1h3ue1LKQl2S0dX0tvoGd+QCW2xS5BDV/O0Wc9CPbOGfpFyvcD7AfRD4=
X-Gm-Gg: ASbGncsZbxRdJ3ZxthdnwjsyGRbt6VNBRG/RyuFSIz83KOcj8aCktfT4k7FerZGwz4+
 sku8msLbjA+o9A2r5D6G/biRr0HzOW+N96sc0+K+KqVtTmJh6Clc+HEDCnAv7kc5tWg9otWpBaR
 48b4zgR/mdmJIdi11kggwXM71AQD/Bl1ovpPu9rq2RmCWhS58C9Q80obepi1Y6XfaYzmtzNA6BM
 0WQgaaa1PapIy75g78WGkaq5WOT27ukNZdv/cNdn+D2q39m+9dAksLemWH7F27UPW72E/E+Wap5
 lKwa7MjzvygV70Nl3Uv1nVedZGIugYCXWv7nzO8p9dSkWPgbAoWsZqbBlYLdwSXaaJ8ASmbRUV9
 aYlHj019+7BaOjLhuaQ8=
X-Google-Smtp-Source: AGHT+IG6Esu3iwpzPMz3MOkCpCUUQL9/f96DI7HFBCTVQe7G5H4jcwe6XF6odMJKIT9iqSubRS2DPw==
X-Received: by 2002:a05:6000:18a3:b0:38f:2efb:b829 with SMTP id
 ffacd0b85a97d-3997f940da2mr3370977f8f.50.1742582097698; 
 Fri, 21 Mar 2025 11:34:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3428sm3073186f8f.26.2025.03.21.11.34.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:34:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
Date: Fri, 21 Mar 2025 19:34:46 +0100
Message-ID: <20250321183450.3970-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321183450.3970-1-philmd@linaro.org>
References: <20250321183450.3970-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Multi-threaded TCG only concerns system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fb903992faa..60a26acc503 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1050,6 +1050,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+#ifndef CONFIG_USER_ONLY
     if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
@@ -1058,7 +1059,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-#ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.47.1


