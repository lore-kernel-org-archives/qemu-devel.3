Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61480C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsU-0001QC-QA; Sat, 18 Jan 2025 20:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsO-0001EM-Au
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:20 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsM-0003Bu-Jb
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:20 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso4405684a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249195; x=1737853995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rK0uHdn5Dxhp1OIpBUDsNo1rifAKXctC3a0vuDqXztE=;
 b=Pk8z1n6pko1bsNq8twazbLKsdBZOntbXVeVweBXWSithzsuSLJEIbW6ogPU9fx/OxJ
 ZS6PPHoubLuCB+DIb1Qr1gR2CaAw/+l3EtFu1RbshZUQEZLGbd/m6CdyY/31GlUDIo3p
 ov+Ix4kjW4bXsIgeZucC6Jy8lqVeV0LalNA6yJ/xvs5BC100cq/tC2G7IdJch2pegqe4
 m4l5VFkddYX8ygUL5uBqJ9XLJkUXC4htMafSEAO3nFxrYReS3dHksudGeERUpGrO5OSm
 S0m+y3SiIrg3yc7COkUctfCIM0pTF4oXTgVGiTrv6zkUgNgqST0xiDj/VD2ej3XXHkoQ
 LsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249195; x=1737853995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rK0uHdn5Dxhp1OIpBUDsNo1rifAKXctC3a0vuDqXztE=;
 b=ndtKRCAvwL8AXaYzLniUgOHttXvqvbY6VoPlSAfxEDsQn7Yn6qRvb0ZqcB2THizd5K
 2vgyfxzUkJtpLpDNSyjdadwaD4+3xbWZdbJhmmRM2M7UrqRro1MMurNQHyACuuBAoMby
 RDCHu1XOKvQALmV/8hjQX/LbV29J2GR6Lvt1QABUlWw/ly1gx+YoWN9KzWgBSs9W+THz
 5YEqUT0SGb9kT/UVSw1HWjWDepMwfX4rBBGodHIj8jfGYpS5ttTR5kiHOTEZN5+8HZKK
 OtrSk59Rzpryv4RPVopigRN/0c4KB79dNQaavMKrqRivhMYBrsw7aUMxDQ73vMDjEC1e
 dorg==
X-Gm-Message-State: AOJu0Yy0afZCqkq6EDRvdxcmP7UBny1HCS0ctS84ZvnIpipWW9zZdzK4
 IiE1lXRlQtsIp2K+VJLRsljMuaJi1RRvTcW5M1yj944CS2dmBn6Cz7N5JGfE
X-Gm-Gg: ASbGnctvllKio0ZJYBVoggjbk+LfNLPGOBxi6ORhWhaYzhH1Xv6TR7y7JVdUMsWIJC1
 wQBfzUL/zGJbPRwj0JSwVjtrqvbRbq19vYBZHjGhN+CKaKrd9D1Lsdgas0/YGNTpcPjb9rjMWa9
 m37cEMcvPUQV/W7KsmfjU8+7epXhnqV36OygeJVs7sEhCWnRgyGjHUzS4waTXtqQA+fIZtR/XpK
 tUg/8zbTfQO2kFgfvQ2TPOTgXTJDcKaLWix9LZ1oQF5LNImHlyeel6mgz2q+cVX+zfIVgs7tFp3
 nOBF8LxOQlmo7vScghKEFhDtF18WWeZ95+P5jFgQBq9SDVGREjBbJPhnyZTwzZVpsoPHa7zV9A=
 =
X-Google-Smtp-Source: AGHT+IEygU1Gy+gnjd7aLV2alHWQfKPaJfgdp7dQTT27G5secGwx8Kog0VX9AKpL0f5+6Ay3z7DbBA==
X-Received: by 2002:a17:90b:4ed0:b0:2ee:c1d2:bc67 with SMTP id
 98e67ed59e1d1-2f782c99704mr12660169a91.16.1737249194996; 
 Sat, 18 Jan 2025 17:13:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 11/50] target/riscv: use RISCVException enum in exception
 helpers
Date: Sun, 19 Jan 2025 11:11:46 +1000
Message-ID: <20250119011225.11452-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Do a cosmetic change in riscv_raise_exception() to change 'exception'
type from uint32_t to RISCVException, making it a bit clear that the
arg is directly correlated to the RISCVException enum.

As a side effect, change 'excp' type from int to RISCVException in
generate_exception() to guarantee that all callers of
riscv_raise_exception() will use the enum.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250106173734.412353-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.48.1


