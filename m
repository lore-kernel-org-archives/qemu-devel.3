Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UrZ-0004Mn-My; Wed, 24 Sep 2025 15:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmI-000770-3H
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkJ-0007wK-GJ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f0efd84abso151147b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740491; x=1759345291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0sFf9ow/07V1OcgzR2bzFAiocH4tgXY/MTlOxdl/BE=;
 b=c4K8Z770Q/7B5uZEFqrNs0uFFIajBozmvBTE6mwITeBPCDNUwigZr51wpw1f1mwOWs
 32u4LZHjaBC/j13Kr1tazoOzppzVqCTccIGyYwRIsLLC7DPdOPCp9qEgznm5SUxyxlsX
 Hd1hEDBs7JiIPvqswMLw9QHhRg2eaCw3lTRW2PW1tGXZqegEoWnASHMODc0vbuAUOdHx
 Gc0v0likikuNCXZYGGNy2QGAdqdS1v/lN6cFllKtr1+3siPGWYMEvZI5raANyseQOloM
 Br0oBZIe2n8r9mXsihXcGQMrhxgRx54lBuaQ5isKTopYDcyxKZZJb04qVEyPpTaPVgNp
 aHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740491; x=1759345291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0sFf9ow/07V1OcgzR2bzFAiocH4tgXY/MTlOxdl/BE=;
 b=M6pH2RPOP7/3I0hEG6yIolZC3hj5Ba2MFisikZ/vomKIk/rLLRZSCYMhNsjc4hEB7d
 qajaPrWt2wPaU8SwwPfuwDGIRXVrv+wNZFgyXJvdS8LHVGg6UffnhFmnwPqUdgGyW4A9
 2jZ9ixeZRxApaUY02GNjBhQWJYs39E3FBEfxukW9cPwR4j+1SKQRecF6RzU8FoUweyMI
 Ub2g16TLogwWucVb9AbWrkfK/Ha44h87i7di4iTor1Aic+m2xoc4yy5lXKxpqL7zPM3N
 XIxC5ONRrjP0hRAw1F33dkB4VKpTCB7vYRcK7aV6uMf2F9zi0YPpV+RtccMw6HhJAz57
 bPVw==
X-Gm-Message-State: AOJu0YyqDeMbIydlgtRPRc1vhMC/pzDbrJEYswXNbaP2j2vhEtZFp5kF
 ct9/4JxFNnYrS6kUQHABtcvrGcHQbosCIm/uRkq9gYZByqFvVuCng3oY1NPbUD2aaFsxQBnZ0Wz
 e2SvW
X-Gm-Gg: ASbGncuI1rt6N/Du+iItEFxWH9BW+5RnlNCU6h8FeFhU+qnGC6/RIWo8vTZPf8RyUnb
 aNXoW2HMuFjnLysR2qk4ifA6a0G5rzW9B+4G0g6XRQpPhc06Hsb3eji9jnLWx7n6IvqiJM6ZJng
 PZ8V4BgiePrI1wwY62g9lBSmHe66Bqi6wGirl8/MjTGK+vzvzDZkXgixgSO6Gz79mCVIeEJu+mn
 VqEXPlH5Exnlcpkols5iKE1Cnt61yhfprRvulVf5KJQa86SvQrE9tDMIyjT9o7NJXUBMOvNuOx8
 Rk4fj9+ZVDHt2hN3oyUQ6uWgZX31outbKdZOn/otgG+3bcK8CiXmFca5Y4vC6Uqvfl8aB3bKENi
 w1sMxteov8V3dFQqxq/mIC03ClQbn
X-Google-Smtp-Source: AGHT+IHLX4trVhodTzNMQ/FvvtSbJ9Lg15twZyyjb/b7aotdkzso/AOXqFMGw9ezAhGSLLFzULnAkg==
X-Received: by 2002:a05:6a20:7f83:b0:249:824c:c620 with SMTP id
 adf61e73a8af0-2e7d4e035a6mr700366637.57.1758740491533; 
 Wed, 24 Sep 2025 12:01:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/32] accel/tcg: Remove cpu_loop_exit_restore() stub
Date: Wed, 24 Sep 2025 12:01:05 -0700
Message-ID: <20250924190106.7089-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Not needed since commit 63e7af20352 ("hw/mips: Restrict ITU to TCG").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250924165039.52250-1-philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 +-
 accel/stubs/tcg-stub.c    | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b658a3f48..f373781ae0 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -221,9 +221,9 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
 
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
+G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 3b76b8b17c..77055e3964 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -17,8 +17,3 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
     g_assert_not_reached();
 }
-
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
-{
-    g_assert_not_reached();
-}
-- 
2.43.0


