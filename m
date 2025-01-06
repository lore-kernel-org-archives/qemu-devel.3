Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C8E7719A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 17:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUr36-0001T1-Ae; Mon, 06 Jan 2025 12:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUr2x-0001Ri-MD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:37:52 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUr2w-00059Z-0Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:37:47 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so21222102a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736185064; x=1736789864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vEPaDYMTmy26J/4RhVLGeEBUZMGkiMwnubqyq0F7bs=;
 b=KB5N+ikbTR4kPZ/gvXrUfnmJyUnM2SNHnFB/4/oM4DS1BmT5rI/o3hRg8QhIdyUhOy
 JJnAvZ3zeHFtaB9P8ZTIz9KMHkiT8B7oZ6qUg9XYt9/ZeXuHFc7kqL2epCVXvW/L+J/T
 oK2Q5iclBsCO4+AMmkz/LpQMXjG8k4FC4eFud+qXtrmpJZgXbt02IHTMnmSmdYJMfpot
 wsNmA4cqcMrUCGmY563jPPvaoPixM5o73XU2jOIfjgeqZzsiHLQDYSdaSTNT2CB9yqX3
 qwyLSlSKA/HimZmVY4uEvvlZT2A3f66JvfXzxukP96eBHT0jeYnUAGRJ/K9xJXQ5nt4F
 elmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736185064; x=1736789864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vEPaDYMTmy26J/4RhVLGeEBUZMGkiMwnubqyq0F7bs=;
 b=GY4vCmabg4+NjDwJ1AWrVJWZq/Y2F+nl/fxsOEbNT0uRv9k38SaMcNj+Iqw04b8Ff/
 BG/3OV4Mk4qTSs6O9d/RBibu85RTCC9onTscN6DZjVAsgFHAe1uv128y2xU3qK6W2gm9
 3m9Yfgre9d8l2KrfHvlmpFoBLeTX4goZfM0oVWnl1m84QyAaHRnb2k+XK7h4jDmrT1Pc
 qUxeEedluGq9u1EYVKPQCYn++IgWd4jT+D+ISuopZm/AxxiwlJyZbw395rGlj5IRJS0I
 D6NTiC3F4EH042w5cx9JgNnkTjcgzlOKov+vhUWbQ8rWE6BAwbvEO+tlwI+LjDPO0XlC
 TMAg==
X-Gm-Message-State: AOJu0YzGBSSV0RAt9+Jyk6UNoXIMEblvcV4EkE0XJobDtaCz5YOeLJRn
 Wz1QZzF6vOxt63Yw56iyLbr2ezL6jyCW1uMOqaIas/CXdy/yMmGaSvlibBnSJ4XnIa4q2JGFsyZ
 yc9M=
X-Gm-Gg: ASbGncukx65n93Rh7mAjFPLZJ7l0P7FiaHFpUTv4FAKmr614Q71dZXP1GkIMJuQTyMy
 721XQuGBeIsoop1nDAKczJmHzb4RcnA82cFKnMnEfX2MTEiB0t8bK/S8MIzkMZ2M5f6As7ceI1K
 WzQn/p/pMMlD5X/AHsMpruu7iSBKmRhiYuHP64gFqiwf+Swn62IiDPsLBQPw5Kkg0X4yNsKUcFp
 cjjTWiRPf7BKgF7JVGt6jHVjQpeUHGxacWDPdTOlDUNzcwR+taBpXrm18mr/vstTl//6COJBzmH
 djo+30+wbQ==
X-Google-Smtp-Source: AGHT+IGrsoTurh9eO7bLfQY22rkBasvkH6TZOVwu8qJLFl7laanpLuq1Na30qnoU7Gkmh0YvrCv81g==
X-Received: by 2002:a17:90b:2543:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f452e372edmr79415834a91.21.1736185064015; 
 Mon, 06 Jan 2025 09:37:44 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478ac7dbsm34139317a91.50.2025.01.06.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 09:37:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] target/riscv: use RISCVException enum in exception
 helpers
Date: Mon,  6 Jan 2025 14:37:33 -0300
Message-ID: <20250106173734.412353-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106173734.412353-1-dbarboza@ventanamicro.com>
References: <20250106173734.412353-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do a cosmetic change in riscv_raise_exception() to change 'exception'
type from uint32_t to RISCVException, making it a bit clear that the
arg is directly correlated to the RISCVException enum.

As a side effect, change 'excp' type from int to RISCVException in
generate_exception() to guarantee that all callers of
riscv_raise_exception() will use the enum.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h       | 3 ++-
 target/riscv/op_helper.c | 3 ++-
 target/riscv/translate.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 252fdb8672..3d9c404254 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -606,7 +606,8 @@ void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
 
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      uint32_t exception, uintptr_t pc);
+                                      RISCVException exception,
+                                      uintptr_t pc);
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..29c104bc23 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -27,7 +27,8 @@
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      uint32_t exception, uintptr_t pc)
+                                      RISCVException exception,
+                                      uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
     cs->exception_index = exception;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a992d4f3c6..f46d76c785 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -245,7 +245,7 @@ static void gen_update_pc(DisasContext *ctx, target_long diff)
     ctx->pc_save = ctx->base.pc_next + diff;
 }
 
-static void generate_exception(DisasContext *ctx, int excp)
+static void generate_exception(DisasContext *ctx, RISCVException excp)
 {
     gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
-- 
2.47.1


