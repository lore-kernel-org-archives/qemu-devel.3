Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7456CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYm-0007B3-Sf; Tue, 12 May 2026 02:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYb-0006QW-R6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYa-0007B7-AB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso30887765e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567126; x=1779171926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NxrosfhIy8+CqlY7B+TrpDgj57GBLoeZesxkHF+4QDk=;
 b=bWPJOwhud89dsv0foxGNw4nIpqPXJGuQNfeUW6J4Gux5LHfMbQv9e3nOx9npySERZb
 BMeRQaG59zuAVs3rqxD5cDIPfxoTcnjgR5fIjv8Qt5dOGeY12ZfD77DIgd6T8u1DyD31
 m/LToolVWxo2LGkqBXWw/IwdmP9J1cpNRjcsdzM4Tyf7MHu/s9HRXaLWSMeiwRT9/tMx
 lzUNC1R2aoBZIo0MfdwG4tLi2Bz6DEKqq/U946OG3ZUFD2lgcVvNZcydzRFetQBNANxf
 1TNrRc4NB+Fw26bhxW9P90/MtgaQP5uuTRSAm3/GGQYJFbAvFnptlaV+fh15N5SB8PUg
 Rizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567126; x=1779171926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NxrosfhIy8+CqlY7B+TrpDgj57GBLoeZesxkHF+4QDk=;
 b=XRTv/ZuGrTTs2I1MG6zD5tNx9lHaKtIIW2Ke6gQLmDo0R6bBSgxVeAsk39ELGW3Tlt
 KubAqKkEBS/EF5dRSM/0FPyy9uTBW7kXMfck9VLXJXB+NPuyonNSkeUS9aMOh+cOxjP1
 gz8zHBxTB90LhMuW88ts4Kr/Ob/p5kR81v6K6UHkPB1ReopXb6VnNpVnIgZXUNxOJFgw
 GXy3mF615vSrfZiBdrU0UTc7m/+Gvaus8D0rYEyNT0L60fTk7vmdeZ54NNNV5zIEeCw4
 f6YDyKbDRz5CUd+OmMs1r1k6LIASizvs7Wz4TlmQQNN3VzAju46gYwgCNTZ8PQt55Q5i
 E1FQ==
X-Gm-Message-State: AOJu0Ywb6gMUltSyWqsPtdAzVwaz7k8MUyTp5otK6J7xUl7Q0GGbn0o+
 HCtc3Tt+5HtzA03lm82ghwJVSm/+deE9hyByADQ/oSyAzWFJoIgktCA/Q7a8Ows2MTvQNO9U/xS
 mC5sN12c=
X-Gm-Gg: Acq92OG8sS/w2jiHCy+DbgeGaO/X7EJwWs5NNgyO4lPeEGKpPzbkCMm8FH2+8sWEf8y
 AQPY1WQt4dJAtkKoy3HXxcQMmxwYIjFlP8pRusI37nqIjOfeQk+4XGbv+Vy9DFQNw3TdIKO8I7e
 i0Krszp6opPF6I5VGlgHkKaHdNlo29HwAMbzgZqYVGfYLqBrhJycv76z+1sVSeXiXIesJp4Q1RP
 IC1AmH6Z3R70PxlqudDzjmOGKQyV/Vbh6O55MoECVX3ZfYNKX2YEGz7RswNEe4B33YJYjx/Lnax
 wUfnZ7bgtDA0n3S5mO2pMGXd88BC6OsbX39AdzKOO/cJ9m76e9yDFQV5bknmyNylal45evEjiYH
 rp7wmI7+hWLiqOyC2H1Dbt9SoABPOWjYsRGjhuFhHEy2NCo0fFbxoC3LI+HUC0jnCG33efK2oUD
 W3BFYUDvA1DUtD/TUW7CgPD/1DJqdi+iaheoRegs0ay2g/Ae64yIBvvhLVgd1Cyad6Yr9M7GgC
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id
 5b1f17b1804b1-48e676b6393mr180787645e9.24.1778567126471; 
 Mon, 11 May 2026 23:25:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e60f3d1sm16052525e9.3.2026.05.11.23.25.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] target/xtensa/xtensa-semi: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:32 +0200
Message-ID: <20260512062142.67998-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We want to remove the cpu_get_phys_addr_debug() function; update the
xtensa semihosting code to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-23-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/xtensa-semi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 9a6a9c8b4e4..3340bd1d415 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -215,15 +215,20 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t len_done = 0;
 
             while (len > 0) {
-                hwaddr paddr = cpu_get_phys_addr_debug(cs, vaddr);
+                TranslateForDebugResult tres;
                 uint32_t page_left =
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
                 hwaddr sz = io_sz;
-                void *buf = address_space_map(as, paddr, &sz, !is_write, attrs);
+                void *buf = NULL;
                 uint32_t io_done;
                 bool error = false;
 
+                if (cpu_translate_for_debug(cs, vaddr, &tres)) {
+                    buf = address_space_map(as, tres.physaddr, &sz,
+                                            !is_write, attrs);
+                }
+
                 if (buf) {
                     vaddr += io_sz;
                     len -= io_sz;
-- 
2.53.0


