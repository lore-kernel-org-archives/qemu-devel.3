Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE0CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpF-0006Gy-OB; Fri, 10 Oct 2025 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpC-0006BG-50
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coh-0003oQ-1b
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4257aafab98so1792390f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101543; x=1760706343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9dcfmwjYkbZTi8Wx9NVyh7rWPBg1Bwuq1q8D9KfASMg=;
 b=KMZAjugfrUXzwptjHpuarjgCgzDugLoAVAg5Ku7ZPSjZt8tU3mtESbkuKc5NgqDGpy
 STqz+iNLOQNG/SnbRERumYMkbdI/iyIDSBVmOLV0YuTUl3QgGcniobH/ujrNWHIYVx1b
 VF0vZml6DPHDEw05vyJeJPc3yAmkdLj0hp4whFWjetTsCb49UYLmwF4gMTvptXdw8QEl
 4l7dEfEQskrDNc+e+HkBoVd4ApQ09TkEcdAuYAzlhYH1wCTCs8UAe8+CjUFSDQqyjjtd
 VLWsvQiTNQPuadlyUmHfFcoAvM7wHxxDKG0IUvVlm3jL1HLOyOzmkDJvbsGwp0Py2TTA
 7M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101543; x=1760706343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dcfmwjYkbZTi8Wx9NVyh7rWPBg1Bwuq1q8D9KfASMg=;
 b=oAa0xxU6Q94/rEZ4PU3wUHvvFwHgAHLtiVEWIQQU5v1LYwt8XGwT/124fPPJuIG9/V
 HELHnZfC4Pn/XS+CR1231YfgUyECKZ4YXddQ6WfnzweNZEgDektU9TkCIQTSJuVvJiuR
 LjKeb7ehBrQB915uf1mDkDK/YvjC/7p7EJU054MxVz4HRYm4gUdpTuKmMrE0QbmCZtRg
 WSxWWikZCsFe6igfyXQLnMdpeBWDsG0/hp/TgBJQsXiCAnLSeiHpmTpH2QFNGST3O9cC
 o2M12e7SGu3TvfzYgSvf5vTTDQSjsmHNV3hJ6LfV9IoN4bj9xXhmgyUXwFL5Lgcvvp8B
 8Rcw==
X-Gm-Message-State: AOJu0Yyg65d9KonsQS8Q0Rd5SZ7bpujIMusmMC+NNjpcFW3RYFW+jPQr
 0Uo1TbFFnbkzYNFNm+bNQw64H77Ly/69I70Zcosbxf+VoIc6U9b5vs8pGNZyfYFTjaz28aATtOe
 QcEJk
X-Gm-Gg: ASbGncsr4+Wzg7iieprX/HCUwgwLTm5msF0d9G6SbGJ5xhbjv82zZdsaEcC99nwqVK5
 zUx+NqaDsJ9wHRvCt1ZUi0mhgnFgoLZZub4eHOWyG7skXSH+nKJbOSuXIjqY1b0pSDhvsbapppT
 984XqjUng2ZmrYva+gE/K0nQGQIClZHeIaaPxTKg3wSvY+1iSYyUA6JPy/86k9qlBQmHgHw9nLC
 1+ggY4lfZ+GFvF9LcealO2h1zG7oj9maDZf3tVzOZdOHTdaVBvwT7htRqDV/NL6I4k7/DcTU4ki
 AYqQnBWq1Kv3K0Mqk2aJMeOgFwhqjJSlo6Cc4OJXS7hxbqdpjWANIT4v6KMbI5EgDcZ1/fpD7uv
 LsLjlxsOHkExoMK3p/Jr6GVGoY1ZLII5eAxy71xIyRJu1g/RQ5+g=
X-Google-Smtp-Source: AGHT+IFgMEIdujMWVwC9MiC7RDIha0IW2vZX87omVv1bDowj2OFfGxTxWXG4dbAl8Cghq0lPikniqg==
X-Received: by 2002:a05:6000:26c5:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-4266e7d9252mr6968186f8f.30.1760101543087; 
 Fri, 10 Oct 2025 06:05:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/76] target/arm: Expand syndrome parameter to raise_exception*
Date: Fri, 10 Oct 2025 14:04:22 +0100
Message-ID: <20251010130527.3921602-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Prepare for raising exceptions with 64-bit syndromes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     | 6 +++---
 target/arm/tcg-stubs.c     | 2 +-
 target/arm/tcg/op_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 22947c4b78a..b59650959ec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -304,14 +304,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
  * and never returns because we will longjump back up to the CPU main loop.
  */
 G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint32_t syndrome, uint32_t target_el);
+                                uint64_t syndrome, uint32_t target_el);
 
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
 G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                      uint32_t syndrome, uint32_t target_el,
-                                      uintptr_t ra);
+                                   uint64_t syndrome, uint32_t target_el,
+                                   uintptr_t ra);
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aac99b2672a..aeeede80661 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,7 +16,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5373e0e998c..dd3700dc6f2 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -46,7 +46,7 @@ int exception_target_el(CPUARMState *env)
 }
 
 void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+                     uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -70,7 +70,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cpu_loop_exit(cs);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0


