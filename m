Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FBAE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKcG-0007n7-QA; Thu, 19 Dec 2024 12:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKcA-0007S4-TA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKc8-0003Ip-SD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2167141dfa1so10237445ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734630427; x=1735235227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBkYbbxlHHc91zOQdjdwvPfvCFzP4hS8ldCxa5I2Cfc=;
 b=eN/xnelGZrOw+l+hU5Sd0WRo8+Rx4JRTRbSNnu0laIQk53Thj+x+bQWsOWArvg3U7E
 0X/PF76JVnq0bBRex1ujF0OYSM6lxmyqSgO3hubv5uEWqXeQMa1kExy7PGS5Zz2j4R6/
 HAQjeKfuLYDmX5oPrxWYBq13yZfAmeYCU//F9/JJZuhs/m6cZIksRvbSRnKCYUfumKjo
 dQY4JDg8WiNYh0erlCnFz0yTslrrLfMUzSeK1vpXd/ftBbxTiLtCd/OfHii4eWx7g64T
 L2n1hSGXjoNxIiiFbax0VuAeDxHOrnc11kNcrQChW6t6RKw3X9EXe6R5rIIFIikCmJZH
 ccVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630427; x=1735235227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBkYbbxlHHc91zOQdjdwvPfvCFzP4hS8ldCxa5I2Cfc=;
 b=MSEK4FfprG9F5qxKeFklsabmgtRAK5hkdMXT3emulDt3LCn0hlGLJ340Ygw2uhXNYO
 JlKu3JxjBc2rlQclP2420XicwSnnYXQ0F69QcZsWow2RNetgAjbsyQJCYohrvdwjvmyG
 ZGloAUbna3rI0khAFvPTbx4tyNMrWq95wXKp27D4OStVn9RTBfvP6kEcDqVh6ry6KHiq
 CCar7kpFXCz2LlRgiWjK1FqD8X/T+/UprtivPKvd6xwokoUqhbUg2CH4vVf7ZVjotHA3
 TDbErNNOWlrpz3+CPjibk+ZNxZPGOWoyKrTvTWncOknuj7SPQ2oH2s6KsyG/I+UYOr5D
 H5hQ==
X-Gm-Message-State: AOJu0YwY4Fdaq4ivdPZ/vKLcfRkB/B06hhHdJ8PALEmfjCZGKicaVSDs
 jEoN2iL4K8T9P1BZZQnSW0SGep/LkQZJHf8hFH19NsIhF4770gS8IPZrPO5yoWLemBPwXeBrYfi
 XUWd0bA==
X-Gm-Gg: ASbGncsNHmjb/WosrfndWWwxQ3PusYMPErM9kXb8hlKnTmx86yDuRJ0pcakC1C6dUAl
 LnPpBNsdrQxELESfi8T86wqCgEQcn3I1rWHF0XDq40PAPdfPNV/6BaGgxZsTtGIQEeLaxJO9eOZ
 BHON/arGw/9NQ5JrlupxVcRUyx3amcfk0JPmrIRuiJc8R8W2HhnDxxtQRyfWzYp6ppeJfgv+B1x
 ECpdMA5cXwkJbqdHRujdBzTcj3/U2CIMwHPqYGAIgDMbqxfLlVyRLL3keN9O9RA6wBC7bVlgzll
 hwlahqU=
X-Google-Smtp-Source: AGHT+IEar+ZxP4N5k3+CqzSKQXFh7oo5v6r/McHtVO5P+1VTka7NWoal+HaNKTI+zgWDuE2MQwrZfw==
X-Received: by 2002:a17:902:fc84:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-219da6ec0e4mr70342245ad.20.1734630426828; 
 Thu, 19 Dec 2024 09:47:06 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f7307sm15099505ad.195.2024.12.19.09.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:47:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv: use RISCVException enum in exception helpers
Date: Thu, 19 Dec 2024 14:46:56 -0300
Message-ID: <20241219174657.1988767-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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

Do a cosmetic change in riscv_raise_exception() to change 'exception'
type from uint32_t to RISCVException, making it a bit clear that the
arg is directly correlated to the RISCVException enum.

As a side effect, change 'excp' type from int to RISCVException in
generate_exception() to guarantee that all callers of
riscv_raise_exception() will use the enum.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h       | 3 ++-
 target/riscv/op_helper.c | 3 ++-
 target/riscv/translate.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..2b85e558f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -603,7 +603,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_translate_init(void);
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
index bccaf8e89a..ebae1807a4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -244,7 +244,7 @@ static void gen_update_pc(DisasContext *ctx, target_long diff)
     ctx->pc_save = ctx->base.pc_next + diff;
 }
 
-static void generate_exception(DisasContext *ctx, int excp)
+static void generate_exception(DisasContext *ctx, RISCVException excp)
 {
     gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
-- 
2.47.1


