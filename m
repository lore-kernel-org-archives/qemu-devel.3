Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29331CD129C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt87-000246-8U; Mon, 08 Apr 2024 13:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt84-000234-UP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:00 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt83-0003gi-F3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a54fb929c8so445000a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598598; x=1713203398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+ZfX4LwKFG2ttcKfBo5ylpdxbdzoWL4e0yutHC0vAw=;
 b=qkUGBiTIVoMMWc2uXRdFJV+eM9Dsy9Pnpm37uC8bErrzGtsRuCiai5pZwPYmrCc+pC
 4nJs8UrbxxuaaKr3OIaCKqDIrsudoKLZzAHJA4hiUDIKihuq94WEm+WLZgXiFemPaM/k
 6/8dY6U6KswealyXgvbNea+JgDcX2R3zt7PRMNFrogC1SMLexX9nlenBCmr8aA4M8AHE
 Nld+JOqT5RLhEYtDHC9bHH5WgRKHZknFHd7wN3bh+s9XaHO7xrw62nAbygIpmENSlqde
 DQyBEfaNTM8HdqxnazMASBaskQVUizi9OpcIwesjPbUBWw4xIifjNE4iAjFKBUzvAme8
 tS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598598; x=1713203398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+ZfX4LwKFG2ttcKfBo5ylpdxbdzoWL4e0yutHC0vAw=;
 b=QevCJkNl306icA/soUe6RUfcouARO6NpHtSu7M0f4cSLABVaIQKgzdfogaHL4Zku8J
 /CVB2m9MEH58CbXI8FtPS6U211VM9ZVaEWf/jHz1wLZ8iZY1Jzr0YzTPJhAuaHzck97z
 X29ZhKtjpm7OTQY4yv+5tEf6qCCTyIpNWWvzuL6rrYiuJSEd54p/q+bYUxuMU9Li7gIt
 3uP2HYsXCS9l5oTFDyxNOsl7CNwayckTx3duVU/l13vbhT4l/q56C5UzzBttssbokViy
 UH2oY6peCmmtQhJ1FBq4hSI0bStw1UEIa1m15hPINl7tzO/YPKZwPNb0Dd1XvsWdFg/m
 MvLg==
X-Gm-Message-State: AOJu0YwO7osU6zmetcSRLfHZEcyve1qk2l+FPCHUexzZ8YI9Z2lZL3mP
 YbDdosFqX614CGoKICMZEPFXLWSv4JB90eODd5iDyzYC4HdOhYrffQr+tCY1sn4ga+te7liMFT6
 p
X-Google-Smtp-Source: AGHT+IGNZ1B0D1k0ieHHBVgli7TqNo9v9dpTqN0h4xpyOk7lwpHXZoXer9je9RPKhsHIvMXBEr0wag==
X-Received: by 2002:a17:90b:1943:b0:2a2:c127:5aed with SMTP id
 nk3-20020a17090b194300b002a2c1275aedmr10438332pjb.0.1712598598262; 
 Mon, 08 Apr 2024 10:49:58 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PULL 18/35] target/m68k: Support semihosting on non-ColdFire targets
Date: Mon,  8 Apr 2024 07:49:12 -1000
Message-Id: <20240408174929.862917-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

From: Keith Packard <keithp@keithp.com>

According to the m68k semihosting spec:

"The instruction used to trigger a semihosting request depends on the
 m68k processor variant.  On ColdFire, "halt" is used; on other processors
 (which don't implement "halt"), "bkpt #0" may be used."

Add support for non-CodeFire processors by matching BKPT #0 instructions.

Signed-off-by: Keith Packard <keithp@keithp.com>
[rth: Use semihosting_test()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8f61ff1238..659543020b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2646,6 +2646,11 @@ DISAS_INSN(bkpt)
 #if defined(CONFIG_USER_ONLY)
     gen_exception(s, s->base.pc_next, EXCP_DEBUG);
 #else
+    /* BKPT #0 is the alternate semihosting instruction. */
+    if ((insn & 7) == 0 && semihosting_test(s)) {
+        gen_exception(s, s->pc, EXCP_SEMIHOSTING);
+        return;
+    }
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 #endif
 }
-- 
2.34.1


