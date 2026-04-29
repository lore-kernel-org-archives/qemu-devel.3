Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D38FFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrV-00026w-Dt; Wed, 29 Apr 2026 00:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrT-0001xS-Sq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrS-0008PR-5Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so58101315ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438161; x=1778042961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DU3UjdfEZ3JGk1yzzSHiuHXC6FomJ4ypw5VY1zuKTMU=;
 b=nIbJ2a3plfB5kFBvKEi207oVs8AYn35VdU6Dly3c3H3jfQuCn4hUWb0swMdYdJoOCs
 NRqdCtviqen8pPmEMZc3RarU82tPYXb+4h8SlEnzEqmFoa3G+8TDQpV2Nettr7kxFiu6
 4OZ5XaGa/h02R1CNrW4QM8tQ6ws/Zhzkh/TJiy0IRGu0PDWgfM14ZKR8M00W9YpkCB66
 5SLh/FEpF7V7JdMc29kX/NUXdodx40b3cFOJcszzg/Pa0Ij0cYeXoaaGWl4YQf2IofzE
 Jg/2nIm5tHPmp7h5ZXyWlBoNfTEE66TNq2pch8Y5qiLo1GbFvGQkaubuo3KcjuDO96Vy
 JuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438161; x=1778042961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DU3UjdfEZ3JGk1yzzSHiuHXC6FomJ4ypw5VY1zuKTMU=;
 b=VxiW4sx91THYY5MYLotngzR9YbBM0CWJoWFFVAX7xKe0Q3y8P31rOl+K5uIsK9N/Gn
 qoltAbXb0t+9rmog7wq9isa6/SmgHA78GyP7J8ZXmyjwTZY1g9GD6mvZ+uBW89RAspk3
 u71JOED03Uq6HGLAF8ORK/esopdIE3iVxpSJI30w0p7Y2jM+nj4940PbUyhdYM0qE68K
 dse5Mofg+/do/i5LjwhBQuttb8WJDkyFLfoopHZ90IkZdcu8EgeKlVxM4yUTANoWVomt
 T3PxPIeLfIeaNuYZsbLTNGniFEGtDmz/F25ZjM0SpjKct1dtJhxvSSmTqX8iCwbdk0Tb
 ET9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bLcF9NXpJFdDZ36xQAOWPFjzj8JnjNo4/w41ooHtFsrR2+A1AvxSxyVzxMUPMNtbfskqiRbThmsTf@nongnu.org
X-Gm-Message-State: AOJu0YyEKJjYDLK8aZGVB/4uTwAXJYFx4eYcYRJP8RfrnsnR1hhFPDJw
 nJqr4FmUm4HwkAguRlxVzm42og5OxtEbdc9ptsfB5L8U1DYVJ2dmNKlc
X-Gm-Gg: AeBDievpCTlAfibx2u3ddHClXG3qvp1fO4hHQc18QO5CP5trZkiUV91AivM9nQVNUDv
 kstkL/Fkg/0ZXCviuwEA68gVWjTc5nsNsFFc5kHzpId+7MSCqDie/mvG1PZf9qM6esclfTTFkHh
 CZTuZCauMVC11IPYp4O8e7HQCwqPu1pNtRwqSvAnx4eOPMIW8loPYfwDQXyUaGyM/tuchrUjEBS
 nk7avQTf0SY7CCXxXrRtcYQlvkOeNdvS014t59Y2TQcaJ6vjW6cRCtbjCOfykMh0hi7UY3eqEIT
 jFH0Gqf7wtguXQaXlRXzXhCPByeLHHc56b80aMGEHpJGS/fdGzC0YpG0iLsD9CpDom9zW3OLIr2
 XW7vdikegi+5lPw96MeIM7u3YD4f8IWyTrfdm17Wjp11ps83DCPr7eFd/6uYrqsl54EMZGrnYjw
 Rrhy2ycnITdILwkS1YZpMmtediA3LxyzawT3/81jFsfEekhzR/A4Qm
X-Received: by 2002:a17:903:3c6b:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2b97c3d4e15mr62585895ad.3.1777438160824; 
 Tue, 28 Apr 2026 21:49:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/51] target/riscv: Replace MO_TE by mo_endian (MIPS extension)
Date: Wed, 29 Apr 2026 14:47:15 +1000
Message-ID: <20260429044752.4176397-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-12-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xmips.c.inc | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index 37572563ae..c1a30156d3 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,6 +47,8 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
+    MemOp memop = MO_SQ | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
 
@@ -56,11 +58,11 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_y);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -69,6 +71,8 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
+    MemOp memop = MO_SL | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
 
     TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -77,11 +81,11 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_x);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -90,6 +94,8 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
+    MemOp memop = MO_UQ | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
 
@@ -99,10 +105,10 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_w);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
 
     return true;
 }
@@ -110,6 +116,8 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
+    MemOp memop = MO_SL | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
 
     TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -118,10 +126,10 @@ static bool trans_swp(DisasContext *ctx, arg_swp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_v);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
 
     return true;
 }
-- 
2.53.0


