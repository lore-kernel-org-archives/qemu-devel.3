Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349BEE7FDEF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1hc-0007M2-C8; Mon, 02 Feb 2026 16:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1ha-0007LQ-Ay
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:43:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1hY-00045L-V4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:43:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso41407805e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770068599; x=1770673399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxQiPZT5UD27d36G9e1jm2zCp7hGnuyHF/hoh1rkDRI=;
 b=OF2LH6gq1ZMcj6oiYVQw5Bl57UGnderZA3cxNIdwX2KWyEFgvpbSUUX8c+m4OcmavM
 inJXqj/cneL+WxNfLbdqpzUkU5pbj8L+jOh8fyD/vKIX56uRGBFHvR5Jikfis6bG+XLV
 S2A25O/zO8hBvtx8KIpyROihh83ifBkhTRRtr661P2anOkJwsCPNVxCYw5yV2iChXaxW
 9tWhHyHqblQwQdzbdAUEMeKGXl1W6IDdqvn5ZB/vAmmYjq3PL8SibpVZmQIZfLtNOPi5
 c5ItwwQ5cB4aqsIIjoe6UQ97JFweDqH8AxA+eXVq1wdy7OsnYAPT3tn+DAwGfKIqPRek
 C2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770068599; x=1770673399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxQiPZT5UD27d36G9e1jm2zCp7hGnuyHF/hoh1rkDRI=;
 b=U+lYHFBnSW/g7MyYS5vfhCJVzwSvKnV+xVmUz0T04kHvG3aYLZdFoTgNB5Fs1xZdV4
 idTpHL8O9kG4PQQpB/zezABKfDydCD3cjfG3CnWdbt0Q04QFg0z1SW+n2kPGBsaNWa1z
 UHJI57G2bcXqzBOnMrJTCEGBqKdNLrtdC0zwNLvED1Yi7+c+jE+IR0BPZEaFNG1i7DvV
 Hv6mPoIWHarJis/z9Q6y0t1u+BNFJkOJ+pXSqTlwqP7RcalvoKwnZrwdejeCM+80H+hO
 xi5tQ67W6OCdM2ZdWLWvWj2HUr7ceBk9c6+GU84yfslV6KLaVNyBaCZ0urx0NsYWu2pV
 XSIg==
X-Gm-Message-State: AOJu0YyhHeosR2hj63xjaHLK75Jb/5LH0o1bqZycvaarW1GcWbJg+QY4
 EtQfDiT8NUnrwloMoyakQJU/LOT14OicJPDBc47+oGv+a3Ug0LUG/jTcmIo9vq+oYiEEKWvS8E4
 MFtTuODM=
X-Gm-Gg: AZuq6aLwffIpHwjRoy+uiJGaTyd+oRdEq3mSp4CmnbxxPNPpa+RXvih1BLF2QFzLny2
 WPBfvT2MM6q5XQ3sZKZ1sNn97l8KYOjV8BiJVg2rBufKIFWY/KxSBJdWsqNrWQXTCw0ikTn4o1G
 KmJP00TJ/eYdeOpHfuT5Z1vep92Bg8KwFahK1EW+dGZQ5jIKRmKtDPA6wBhvgRZatLh5ExARyDO
 3tgKHC18zOD9s0Qxxn5x76oOw99ytTTY4QRV20z6pnh8FauKerBJo7/y2hECLfn9yjkkJkES5Po
 rr8t04eImZaItF3VI6wEGD1y2oxzuLO6+F9QaLd1jWSsObiEeoBZuFODkz+l/ta55xGQi7WnHH4
 3az4Z+9QznrUl9MsFdeil6+2kGRyFF5xRWdRwP0HW9wqp6/4vipb4uUloZOWdzOlOUP/M8cumMv
 zUsmO6LmfRbnKRr1WjCyspgbpxwAG+llfqXdQJbUIozQS1HNmgO5UDg0MlhmTG
X-Received: by 2002:a05:600c:4e56:b0:480:1b1a:551d with SMTP id
 5b1f17b1804b1-482db47cf43mr162933085e9.18.1770068599022; 
 Mon, 02 Feb 2026 13:43:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cefdsm47773030f8f.23.2026.02.02.13.43.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:43:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/riscv: Inline cpu_ld[lq]_code() calls
Date: Mon,  2 Feb 2026 22:43:17 +0100
Message-ID: <20260202214317.99090-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In preparation of removing the cpu_ldl_code() and cpu_ldq_code()
wrappers, inline them.

Since RISC-V instructions are always stored in little-endian order
(see "Volume I: RISC-V Unprivileged ISA" document, chapter
'Instruction Encoding Spaces and Prefixes': "instruction fetch
in RISC-V is little-endian"), replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c  | 3 ++-
 target/riscv/zce_helper.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d8261aeb662..cb4f4436018 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1181,8 +1181,9 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cpu, true));
 
-    return cpu_ldl_code(env, pc);
+    return cpu_ldl_code_mmu(env, pc, oi, 0);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index 55221f5f375..15bf0a99c8a 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -23,6 +23,8 @@
 
 target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 {
+    unsigned mmu_index = cpu_mmu_index(env_cpu(env), true);
+    MemOpIdx oi;
 
 #if !defined(CONFIG_USER_ONLY)
     RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_JVT);
@@ -43,11 +45,13 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
     }
 
     if (xlen == 32) {
+        oi = make_memop_idx(MO_LEUL, mmu_index);
         t0 = base + (index << 2);
-        target = cpu_ldl_code(env, t0);
+        target = cpu_ldl_code_mmu(env, t0, oi, 0);
     } else {
+        oi = make_memop_idx(MO_LEUQ, mmu_index);
         t0 = base + (index << 3);
-        target = cpu_ldq_code(env, t0);
+        target = cpu_ldq_code_mmu(env, t0, oi, 0);
     }
 
     return target & ~0x1;
-- 
2.52.0


