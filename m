Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07426E64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8n-0000gF-Kg; Tue, 03 Dec 2024 06:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8l-0000eB-MG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8k-0000as-23
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1462623f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225544; x=1733830344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KV+7GY90q7nCs2B4ZjKF0flW7Qs4QTHZjk/KQDAdUzg=;
 b=DKWTq6Je5KjJX+h801XNTMLG845h780GM/1HQHatx/sA5w/4POvIUBzFTqwqKKMduL
 jr0gWATevUTqYkK4DsLx8mpZh6VKjxqj0YeQaVs4LzpyFBGCJWiWTvyAyGNKi/4MGAW9
 eQ+bKpUqo2q/w9W3jevfcaiBCO7FZ7SfCYZHirsCpokzDYKasD7NDuCnE6OLHCWOcxhO
 JSXTfH+ccc+C1FztBuqKRFjz286PxPDuDVHZQM8/7FuK+JUr7S1ccf4kqyR6IPdPcyqs
 IhjCjiH6I51UJiYIqIfF5auC/f5gcVjjFf0sjqg3Tfs034H+sKw/WrHEEO0qsXcBbVui
 KdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225544; x=1733830344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KV+7GY90q7nCs2B4ZjKF0flW7Qs4QTHZjk/KQDAdUzg=;
 b=KRCRnVoS+YrNmwiu+kGqwNt9Tda8vH8hfJsnz2DDznnxcSoKtEPQMWwwEnaQSIMHfw
 mgzc21MaFW76jSTHnm8mI54Fa/DGy9zuUktd6BI3gtRTSihaOsgfM8pCZGBx3rnO5xVE
 91rYBruFkoK9pWutDPPSfSf9zKGjqhSV4SMc3CnUjiGivXXjhFDgrq/aunj4f/EPJqNx
 FANM77S1huQrOv6hOdos9uNpVMAh26/yX77Nk0T1HI2ame9LWmxBWfkeTj8RIVZfm5W2
 qMB91io3nh9i74pkQ607uD1Zd7IlvS3Mq6i0ccJLIATvbx6sxICvLa97c/Ggbq81WwMM
 ugAQ==
X-Gm-Message-State: AOJu0YzHBourDcEwjUn0HYYroy8i93ARVxy0H/8dMbvPiRTFmd9qqtFb
 vnYzpdOR38YAjRUqawdbeo1lcviXHTB1uriXE6yFn+lcZNVhIggQW4p5c2ZMhZU6z3L3YrmRnje
 OBu8=
X-Gm-Gg: ASbGncuC6UEmTv80msHzRjWsiCcHsSX1IIvgNmoy7jRGh0vh47T6ZG1CgcXJKNv7llL
 8xalZmEaWDX8Vxsjp37tp/Z3nXu0mN6YmuLmdki8PCKf8n0mqMSUdDdK9jRiIIqq6AD7NJxbybx
 0lCXIHtQYAPuXbvGQ85Xj/Kry1fCZlDflswJAG+1U1jGRM8Np53qkH9EQQj1gegSjWYew2UIdHk
 v1EWDlT7gUIW4QG90ghiwQUym2jdZtAampDO+5Kh/2xcXyyAbrKl5bYg844XY3URHtU0yoM
X-Google-Smtp-Source: AGHT+IFe/zsGEFqAIcb2SE0WjPZdATlKo2/5b0UzqQymNiqdUccyDBy3vC30l2rcBkTeXw2L0C0lTg==
X-Received: by 2002:a05:6000:156c:b0:382:4eef:270 with SMTP id
 ffacd0b85a97d-385fd3e9678mr1913180f8f.16.1733225544264; 
 Tue, 03 Dec 2024 03:32:24 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ee60549dsm6885508f8f.34.2024.12.03.03.32.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/13] target/riscv: Avoid bad shift in riscv_cpu_do_interrupt()
Date: Tue,  3 Dec 2024 12:31:35 +0100
Message-ID: <20241203113140.63513-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
cs->exception as a shift value.  However this value can be larger
than 31, which means that "1 << cause" is undefined behaviour,
because we do the shift on an 'int' type.

This causes the undefined behaviour sanitizer to complain
on one of the check-tcg tests:

$ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
    #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
    #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9

In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.

Use 1ULL instead to ensure that the shift is in range.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241128103831.3452572-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69eab..45806f5ab0f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1802,10 +1802,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     uint64_t deleg = async ? env->mideleg : env->medeleg;
-    bool s_injected = env->mvip & (1 << cause) & env->mvien &&
-        !(env->mip & (1 << cause));
-    bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
-        !(env->mip & (1 << cause));
+    bool s_injected = env->mvip & (1ULL << cause) & env->mvien &&
+        !(env->mip & (1ULL << cause));
+    bool vs_injected = env->hvip & (1ULL << cause) & env->hvien &&
+        !(env->mip & (1ULL << cause));
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
-- 
2.45.2


