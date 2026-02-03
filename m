Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C835E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyz-0003Kf-CN; Tue, 03 Feb 2026 10:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyn-000303-VB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyl-0002G9-S2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so44377495e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131169; x=1770735969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sTDZMTu0bvzB2QaTnI2t5fRpduKxAW0hgeqmee/mwkw=;
 b=U0RSQP/m5AG8XZwo1Ze0yoSxRszsmQ+qmDXiBqLno/tY56amQ3/mTvJwp8WAbY2dn1
 MsHiyBdbdNclvybXq2K6SC7UOF+B/CwVPXLOfLARTMeiH6sHquSFl12Qu1ZtGEdS7i1G
 vFL0RyWS9as5zgkM9VQlYk4Mlh6tGdAvVHKBsMPrCF3JAZG0+SDDzOMseXbJQxR63ood
 YqBPOEqGuwtkDKeFcISQqvT/IudazvkVVeiFWzwUjNqF2UY2wjoF71G2FY9bdispTEwd
 K/B2P75cz/xR2GBgWihBBsMwlUo3ytIRUiQXB13nYz7e5+V12eWzSW6Pbmx3+djS6dC5
 Iiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131169; x=1770735969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sTDZMTu0bvzB2QaTnI2t5fRpduKxAW0hgeqmee/mwkw=;
 b=fFWZCpdedtiEivqYZ9XrilT/x3k5Lz16ooDLiR9NLtZxJlRGyvUlFyAji07yDFfTfv
 i7tZMi5FFR/d/xgsIRCysiXdU4YoMX7UekXgOH7qqltFH4NhddVRAKAZDMrNwSXCGlX1
 NXhQp7ZO10M4gABIxjMBI4baBXq/GQnyksbTrs54+PnYlNIkwKFV8T2dqLeaAkFjCtG/
 R3suwTmL6GzBL3f/tgAO6cqJRUrjyRSyreq3ffQUg3DcV1znsV2NntznJ0ltIjAyFXuy
 QNwZtWEjWxJTF2b0LphECIYwnlnVqAT+Ib2Ct9EJqCwlvjhpS3Pm8TGhPWu0EVrH1E42
 HY1w==
X-Gm-Message-State: AOJu0YweG70gD6Pld93TmJ+ZjcU5fXP0ZTXCx7WanWOXySnhtD21+Sio
 qOXqliq4jBnVCuPBVs4HHH9CubDdX0hAF75UODNrrYOOPC7Whba7QE/CmNhJILmb72WciEWYqSp
 cMz6Dpq8=
X-Gm-Gg: AZuq6aI51iHBygeel44voirdw+NUQxMYHIKf9Atu00+QKQ4oCbZDH/vgubTFq5vqROt
 tBI+mT8/6E/sU43uhmJed7g5P4hNv1956p/X8PuylRrNtW6mKKcdZswT1t2BsHMWHwH9XtVv6XK
 hDYgyqaFh3RC/Dk/8EQPHRdDmL7LA70yLQyokSl0WBKIGApIqthyw96mWt4bZHLtryTDky+lyyB
 fYiXLavmqv0GZA/yT3lZBI3pWF4T1lla3lyX9CwfceUXfUNREABExdEre+FN3tbKfMaSTEqDtej
 YdWDsesQM93ALfTrlE40jDL8saSwpyEUKqM6UkOE5XD8xi1FCQoPrG52g+WgPKlmSSv3Pz9Vn+h
 JaihjK+js3YEIk979+yNUo7ICzLhtaKi+U1N598W6E6IJIhNCpmZ957QmAEdST51jdhJiTL/jHp
 l11qHl6WmF+YwGUo07Z3200bZ3HeTppzalph9hJW/qqELP13XDkeXG3kXuzuUu
X-Received: by 2002:a05:600c:4e87:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-482db4655c1mr197229435e9.13.1770131169206; 
 Tue, 03 Feb 2026 07:06:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051539ddsm74263115e9.9.2026.02.03.07.06.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] target/riscv: Inline cpu_ld[lq]_code() calls
Date: Tue,  3 Feb 2026 16:04:18 +0100
Message-ID: <20260203150436.71907-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In preparation of removing the cpu_ldl_code() and cpu_ldq_code()
wrappers, inline them.

Since RISC-V instructions are always stored in little-endian order
(see "Volume I: RISC-V Unprivileged ISA" document, chapter
'Instruction Encoding Spaces and Prefixes': "instruction fetch
in RISC-V is little-endian"), replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202214317.99090-1-philmd@linaro.org>
---
 target/riscv/translate.c  | 3 ++-
 target/riscv/zce_helper.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe43..4a2c08243d1 100644
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


