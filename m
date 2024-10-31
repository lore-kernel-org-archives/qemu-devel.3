Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0E6E68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mhr-0007Cj-VS; Thu, 31 Oct 2024 00:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mhq-000762-Hr
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:46 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mho-0006ry-SE
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:46 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so7306561fa.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348563; x=1730953363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkDlginaqK1R/XkBdNnRtGHhPuwXCcLg0DNmwOvev8w=;
 b=u7vQJovg/a0jB9HfrVJLCbU5myUFMnlxTbO1euFwyz5ShkCPazYPn+CGQOJxC90l59
 S8NvMuYxuCFNYiUuKbsp7AAT5DLFxHvG7nkPh2PmAj7LWvUhlBraUQXY9PJdCUIvbu1P
 Clr2JX9SHdb7gqhuHk1svSVMAgMxmPCnTboiMVhCs19Y/pMhdB5dWwqnuU66WIXvhkAQ
 Zx8eKQtY+cvjOuaZXv2AqabPKicAEImYY6nHhHGOYZsT0b59CvugrkKRF+2m6q2vcOiM
 G8ghUM3VxTNWdHn8vXORRg87EVmYp1RGZtZBaCI7ybg3gEzt9V6YQTTG46Mgy6qyOra6
 U9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348563; x=1730953363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkDlginaqK1R/XkBdNnRtGHhPuwXCcLg0DNmwOvev8w=;
 b=lnrdELlc0KeMZG0sYz0EaTzY4olRje8L+ME/W+yXLS1qtb18GSXAsX4+Yw1Y4gfQyo
 gSi6JKemx7MdqveSlLhLnurtRo8N7w5/kU0hYaJa088ckAiwpOmNP2W9TED5KuANvnxw
 Lr8pWW9GvO/JrO7lz5PSG+UWsNSmym5cx9RUem42Zjjvk+4Ifd05g0p+xgpl2Z+HfU6G
 AAit5VE09vQQb+tA9YK4azICkAS4zcCPUt+kdPeRtCPiTEJ94fRsmDc/E1vTozGC63XE
 oJG018JW/mpSgUw0eMs2/9Uxern43fMzRjWH0/NpuCAtWZRTptqDSgpIbG/C4tCg7mL1
 cJhQ==
X-Gm-Message-State: AOJu0YyIEXixO6EECBfYJOdTiVW6/054aP1BV9X5zcvy8PHhEtSZNBPl
 aNq73R4lKlLGqObTTJlwh2sb6x2CIoXkFs8+huurapvswI57dXb7nTY/nQk2g2guMs4egZ1m/hq
 P
X-Google-Smtp-Source: AGHT+IHLxRqJLq5BEq0GYbKh9cftFvO9yTTmLbXDHSjeuWmPaYK5WQCkU8TymTRZpWAUqVmu+yZerA==
X-Received: by 2002:a05:651c:b0b:b0:2fa:d84a:bda5 with SMTP id
 38308e7fff4ca-2fcbdf616b6mr128760791fa.7.1730348562765; 
 Wed, 30 Oct 2024 21:22:42 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef8a62e3sm941161fa.88.2024.10.30.21.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:22:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/14] target/mips: Simplify Loongson MULTU.G opcode
Date: Thu, 31 Oct 2024 01:21:20 -0300
Message-ID: <20241031042130.98450-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Since MULTU opcodes don't record the most significant bits
of the infinite result, sign-extending the sources make no
difference in the result.

Once we remove the sign extension of source registers, MULT
and MULTU are identical (as are DMULT and DMULTU).

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241026175349.84523-3-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6c881af5618..6d7e913263e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -3615,8 +3615,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_MULTU_G_2E:
     case OPC_MULTU_G_2F:
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-- 
2.45.2


