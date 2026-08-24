Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A53C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcE-0000XK-77; Mon, 24 Aug 2026 01:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc9-0008J1-NT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc8-0003Ex-2e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf452def93so28805405ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550775; x=1788155575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xa78VJXkRTr/R10IbacHsImvODmXgVktvTMEhHcpiSY=;
 b=pei0Sc3AJwGyRG4Mn1D1BlwzcCQTUlk/xFS/AIC3CDPgKsliAUTqJoLV6ndsSgktnG
 MqcRhfjqsm3ohgylya+t0djSlfTLDrbmYHIkmzC7QN5q144sINKXCMXRTH2uwbn1zWEN
 XmHYe8AXoELVKjle//9OV+bZBK+aZUcSc8WkONsuR/yIDdY20T9tqCfsDXbUHUgxuAcp
 +si8UzaNMZOBKq0KpKOozDiRamG09GXlZFmYLkkLInHBsB45WdfpCris0kjoKEHJXml0
 3+oipxjyezo4Ixfa87dVlBpPgL18nBCY83VMsH53hrxkDQLYsqo6YivObfh1D9yW/ouk
 kp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550775; x=1788155575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xa78VJXkRTr/R10IbacHsImvODmXgVktvTMEhHcpiSY=;
 b=LV3EXVaZYRPROm8Kqg9ZQN6rP/B7iFG3uQxVcSynzZi9mylkYhPfubtf4yIvhdhLMx
 6Kp+h2IyWU6diSnk5nX4LXx6DZtcqIRzA14Xu3wcDBeW0+ZolBpmD31U9zoPXDqmdnCr
 F897WXjC+5XjCol6q9clqtPfaifE5d9gKNL7w0ikDe5BlbAGY2zZxPOOoKpZGIbJn9jW
 fUorkgNc9NyPUqXX7oWShxvgMm7O8s/ECngPUcwC3iq3CY8mSx1Pkyp4eGWd7I5GAYWl
 q6GRLVCvWKCGHe+X7P988wZlbxrXy4rPOD4ZCzPXl21LmBR3jGXNc1pGQYJpcJ5xVjBU
 PEIg==
X-Gm-Message-State: AFuF++nVU5x/iUM0XbfSezwQzuUV1x26id1+Do5Nwi94reZnnAluLchn
 FBfWGjCjy7Q4qZEGrkc1G60eJm/1sV89QnE+lRRpTvRsCb09cHd94a0Kz4Ypeg==
X-Gm-Gg: AR+sD12MLte6NpZe0UhCjxYrfngdt0ZOjH3aXFTQ2T790M6S0aKUBBvBIjneGJ4/2iB
 LquM/Qwt1It2mZ8aHhlUyMrz/nuTAm9j9P8F5I62G6GUUco4QRUNLvJpwis+K4QOWpEKAy6jXpK
 dTxmkzpBRlYpvsjXe3MWAL+4kxKRhoz5P/syP7Z7Qh33IkA5oSXzMd6G9SzU4zwUZBzTI/owRo4
 Rh3moEDQyG80JPL2/Orhn12no1SDMj1J8Zx+hz6gNgfiYdFMu6QG9AaSXPbE/IQSdM0VicJwDjD
 mtk4i936s7uG6xXReY8XLyWu+zR2qAdB/+d1eIv6VFYjiMmannmLmXsHc8Gg6Tvc7DaTxIPBfRS
 1tOA84bjMqLzuQ9717X/S/qugN2Ur3Rnks/6ZGHjzRIaCZSoNOi+HO6NzKFrRygc2iTOgCj762L
 k+maRqYU+6Lr+adpEAQaYevGErfZg+QyqUbM+NgbyqEhqhhkD62tqUwaeVVQoEt2sk5kIgQDy8h
 7BivAbO2WbPjfce2eFDabqJRphg
X-Received: by 2002:a17:90b:2e4b:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-395c514b5cbmr22308232a91.10.1787550774750; 
 Sun, 23 Aug 2026 22:52:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Anton Johansson <anjo@rev.ng>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 90/96] target/riscv: Restore register dump zero padding
Date: Mon, 24 Aug 2026 15:48:00 +1000
Message-ID: <20260824054806.2790041-91-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Joel Stanley <joel@jms.id.au>

The register values lost their leading zeroes when the underlying type
was changed, resulting in mismatched padding and harder to read output.

Print with a runtime field width based on MXL, so values are 16 hex
digits on rv64 and 8 on rv32, matching the csr and fp dump. This avoids
adding target_ulong back into the dump.

Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260813032421.54438-1-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 79ddde419a..a13177b7b7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -651,6 +651,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    int width = rv32 ? 8 : 16;
+    uint64_t mask = rv32 ? UINT32_MAX : UINT64_MAX;
     int i, j;
     uint8_t *p;
 
@@ -665,7 +668,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
+    qemu_fprintf(f, " %-13s %0*" PRIx64 "\n", "pc", width, env->pc & mask);
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
@@ -692,8 +695,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s %" PRIx64,
-                     riscv_int_regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %-8s %0*" PRIx64,
+                     riscv_int_regnames[i], width, env->gpr[i] & mask);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
-- 
2.54.0


