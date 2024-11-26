Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11872D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw8k-0004i9-GC; Tue, 26 Nov 2024 09:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8H-0004Jz-Nq
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8F-0005OT-Ip
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:36 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a8b94fb5so2285565e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629693; x=1733234493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsJ6Yh+YQIX9fCAehh/cKi7Uu1GgsUp/kUVg81Uxhdg=;
 b=kf8v+yLVGQWlo/z3JPyKpiJu6ZPQ/jlJwKo4a9eYavl44BcOAIxjeBZbG6y8KYTosl
 iUpvRndZs3C/Ao7tqyDPobSg1DIDsSL+ViIJDKPGz8oY6MC+Evr7aI8kcaFBmFDlplj/
 Q3u1WVwzDEH3AJr5SELw1h0uocALIDFKB8AfnDUw/TSpVaAckxnWG5cO+l2ouaIPc4fs
 zbxgBlKKeyWL1cnzrCagRYbfmbSiXa2oTGL8SBC7FO7KBtKSDl1xOqdUN64ddto52mE6
 tN4YzjpHv8AWdF/2EgUGfROqgaA4h/cz5Hg+EkDVEapA6omEuMqZLuafvkVhFB/M/4bs
 BdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629693; x=1733234493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsJ6Yh+YQIX9fCAehh/cKi7Uu1GgsUp/kUVg81Uxhdg=;
 b=W4KNCxqGYKK+GpLJaushuPDZbmyDzG91Aj+7aUiYQIyoeOGcXd4BUV5taKZXZPpz8d
 22vZVThS1FayMv9BstrIi5nHt/H0vy5OVsTKK8Xc+7umEJI5u91jr/IdWJHjVPXiVgFO
 JZgXfIJNPSdCt0oP0riC/INkzQ9oZbITrI5FSUW43srlMGZ16J7d8vuFfbqFQAjBjvCx
 ZP4He14tMCXNQashpQmJSUgTNvbzAm6AT3dth6YeQhRlCtSmsiRKi0agdQiSqSZ/fyg5
 BYpteY1nYxQjsnOQyvMwFigxZluVFn4BhNKnwkN4lM7kCV4OXYL1iexloiTBH6TL6DVG
 J35Q==
X-Gm-Message-State: AOJu0YwWSVLjf80lsJP2Vf421bNQwwGLkg8u6rJUI9CqfEWzWEpKPI4m
 uZVSJ1tmh+LtlMNWXesVMSmoJrHZPLVoogeJ7NsHudMDT7d1rae3t7n8bz9qEpJPKnm8a1exiGH
 b
X-Gm-Gg: ASbGncsC7BgFxCrsORs7WSXHl5w8g43nd2p54PSz6Z35Ohk8U815ejCaVFStzW28yMB
 XxyK7+dLUsaUGD923+/Uvhml+kTdJJxX3ES0JQf4ZlvFG7A4LCt/lJYlzR0yCatL9UZCwGW/Cr+
 9ha0knJDZs9LGAI2vMrmVpVSS++fyuWwRoNDNxdlkACuVFO1DM2bwQKtz1bKRDepcndLN7H5ILK
 wliWxV1qbSgQej/KyvG9eh48xURe4/P6nu84FLU9un4bvpeN7snu0BaW6tMI0VaLMTskFNC
X-Google-Smtp-Source: AGHT+IFIwqEJXvc2BnadJkv+2gzjVm44SF+kLfXTwJtmoiMo3ofxQoj6Dgum4UJV7AuPKOJsC59lTQ==
X-Received: by 2002:a05:600c:b51:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-434a4e56412mr29545955e9.3.1732629693209; 
 Tue, 26 Nov 2024 06:01:33 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349f2e1b3bsm78086625e9.25.2024.11.26.06.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 13/16] target/mips: Add gen_li() helper
Date: Tue, 26 Nov 2024 14:59:59 +0100
Message-ID: <20241126140003.74871-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

gen_li() is the trivial 'Load Immediate' instruction.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h        |  1 +
 target/mips/tcg/comput_translate.c | 21 +++++++++++++++++++++
 target/mips/tcg/meson.build        |  1 +
 3 files changed, 23 insertions(+)
 create mode 100644 target/mips/tcg/comput_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 7fe34a1d891..222fa9e1e8b 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -168,6 +168,7 @@ void gen_store_fpr32(DisasContext *ctx, TCGv_i32 t, int reg);
 void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg);
 int get_fp_bit(int cc);
 
+void gen_li(DisasContext *ctx, int rd, int imm);
 void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop);
 void gen_ldxs(DisasContext *ctx, int base, int index, int rd);
 void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt, int bp);
diff --git a/target/mips/tcg/comput_translate.c b/target/mips/tcg/comput_translate.c
new file mode 100644
index 00000000000..3414cc079af
--- /dev/null
+++ b/target/mips/tcg/comput_translate.c
@@ -0,0 +1,21 @@
+/*
+ * MIPS emulation for QEMU - computational translation routines
+ *
+ * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* logical instructions */
+
+void gen_li(DisasContext *ctx, int rd, int imm)
+{
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    tcg_gen_movi_tl(cpu_gpr[rd], imm);
+}
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index f674819e6a8..a46c13f3e75 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,6 +18,7 @@ gen = [
 
 mips_ss.add(gen)
 mips_ss.add(files(
+  'comput_translate.c',
   'dsp_helper.c',
   'exception.c',
   'fpu_helper.c',
-- 
2.45.2


