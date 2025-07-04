Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32EFC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMl-0003SD-CG; Fri, 04 Jul 2025 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeM0-0002W9-Lu
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:18 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLy-0003IM-Ph
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:16 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-311c95ddfb5so798763a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627593; x=1752232393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N57kfUKQDmNxAKJP5RLugaPyuMP/7dcniyDLG0IHlCM=;
 b=E198ui4B5qLr6grfLWqdO/CzXSlwPl/H11hnhG2HxYePNevwmftaRO/qraXfW8P/NF
 KpBAz+LyW5O5xlnHKzxy3PK86gzPDFoC+PtJksPRd9k1USfaXlOBmMMRyhK3NkDhndAM
 3TUIVDmQ/4+NRy3gErI2s2CWGOjtEYHA4AfGoy8wRjYHu/d1uZuZCmDDOWuSto7jJBvE
 uHNNz1o2kv9L8tlLNnNjdPXvMtQxAoylK1Dj8IHQEj5nvRrpqoYOhQ9nRAkz610fm6LG
 cm+D/UmX1g23I2PNVcRrOl4swwUUcYQzOCF9KOMc8k+/pSVFYu+2mUXw1dJ7U5ZH/opf
 RV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627593; x=1752232393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N57kfUKQDmNxAKJP5RLugaPyuMP/7dcniyDLG0IHlCM=;
 b=HDlJP63Rz1eeq+77PLTAc5IeT4oucjOSLLOxWlCBnzTdi+n8EOW0wpr7VleTX8dXpR
 AOvgGTKh46HlwrzkEpEvBcxYeJQfBC7ZBXp2rG5bO0pOtox156CdQt9F9pw8t9fHZ6iq
 SSdfQQ34LRY/EaMQ6w4wgQgZ0gZ6HWCq/Hb7y/DiHqpojw1khAYcIox+SO6HkkDkUTK2
 lV7VTinzTCQAE+rVQve3kd+d3c+A87sXdwpveTYBkWDZbrpG0EXNhOYoYdZ462PDNbZV
 6wZ7Ss9nt+uTswiYziWiM1vbZqd7DbKPkAhrUcpGRuAfcWSjcX9TCY1StFAyGGZ1RaEX
 iAHg==
X-Gm-Message-State: AOJu0Yw+8zVzn0zrLELQwu07WWPWa/D5LfuzwJbg/7uaPRyM/uVAYCEA
 XdI7C6KpGEvEdRKH5LHykEc3wy/HPpRiAttRGE0B39+FMIQpsd8891uhzxTEpw==
X-Gm-Gg: ASbGncu+A+lM6FyczBxBkpK9YKnq/Ot8I3STRURF456bMrks59cg8lJCkTFkoXhV/8V
 eBVoP4omdcCjusR1Ds6gtNv0SFdyNwupWzfGmAOEjRpQRsLhmEwHbRSnzesRTKjylX5yc+oPwpF
 uD32JTCs3Wxxh7HCTKkTUgqHOMD2O0Gu1rgyjdQsBME6V0VtirruzAoGE/UPW3Cz1V0auIpkDjh
 y+jvusQPJP5+OUJbObrhQeIi8txkYG49tS2OJTae/I3B5zN0TVz352o3SNg2W4NFU5spXp309zY
 sI2XdzPaxjHaeMERRzrYrGgK7P6WWZbkI1ea/2gzd7e1pKLR84Fbjuya7z8VFpMPGM7CBpBHSJm
 yfkNz/H1uQ+SI9q4lij/8Y8b+NsDtpdA23LJa6jNhTcyaO+1yksgJ19OLcpynFV5UFgM=
X-Google-Smtp-Source: AGHT+IHRu6FAlEm0CK50kvE71F7X1sWPt3OU5mm2MiTtLWiFyKSbJkss5p9YnJl1K2x+CDOjG7lFGg==
X-Received: by 2002:a17:90b:52c5:b0:312:1b53:5e98 with SMTP id
 98e67ed59e1d1-31aac5456e8mr2541933a91.34.1751627592696; 
 Fri, 04 Jul 2025 04:13:12 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/40] target/riscv: support atomic instruction fetch (Ziccif)
Date: Fri,  4 Jul 2025 21:11:41 +1000
Message-ID: <20250704111207.591994-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Support 4-byte atomic instruction fetch when instruction is natural
aligned.

Current implementation is not atomic because it loads instruction twice
for first and last 2 bytes. We load 4 bytes at once to keep the
atomicity. This instruction preload method only applys when instruction
is 4-byte aligned. If instruction is unaligned, it could be across pages
so that preload will trigger additional page fault.

We encounter this issue when doing pressure test of enabling & disabling
Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
modification and execution of instruction, so non-atomic instruction
fetch will cause the race condition. We may fetch the wrong instruction
which is the mixing of 2 instructions.

Also, RISC-V Profile wants to provide this feature by HW. RVA20U64
Ziccif protects the atomicity of instruction fetch when it is
natural aligned.

This commit depends on the atomic read support of translator_ld in
the commit 6a9dfe1984b0c593fb0ddb52d4e70832e6201dd6.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250508094838.19394-1-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 46 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..9ddef2d6e2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1217,13 +1217,35 @@ const RISCVDecoder decoder_table[] = {
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
+static void decode_opc(CPURISCVState *env, DisasContext *ctx)
 {
+    uint32_t opcode;
+    bool pc_is_4byte_align = ((ctx->base.pc_next % 4) == 0);
+
     ctx->virt_inst_excp = false;
-    ctx->cur_insn_len = insn_len(opcode);
+    if (pc_is_4byte_align) {
+        /*
+         * Load 4 bytes at once to make instruction fetch atomically.
+         *
+         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn't be
+         * across pages. We could preload 4 bytes instruction no matter
+         * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
+         * additional page fault.
+         */
+        opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+    } else {
+        /*
+         * For unaligned pc, instruction preload may trigger additional
+         * page fault so we only load 2 bytes here.
+         */
+        opcode = (uint32_t) translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    }
+    ctx->ol = ctx->xl;
+
+    ctx->cur_insn_len = insn_len((uint16_t)opcode);
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
-        ctx->opcode = opcode;
+        ctx->opcode = (uint16_t)opcode;
         /*
          * The Zca extension is added as way to refer to instructions in the C
          * extension that do not include the floating-point loads and stores
@@ -1233,15 +1255,17 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
             return;
         }
     } else {
-        uint32_t opcode32 = opcode;
-        opcode32 = deposit32(opcode32, 16, 16,
-                             translator_lduw(env, &ctx->base,
-                                             ctx->base.pc_next + 2));
-        ctx->opcode = opcode32;
+        if (!pc_is_4byte_align) {
+            /* Load last 2 bytes of instruction here */
+            opcode = deposit32(opcode, 16, 16,
+                               translator_lduw(env, &ctx->base,
+                                               ctx->base.pc_next + 2));
+        }
+        ctx->opcode = opcode;
 
         for (guint i = 0; i < ctx->decoders->len; ++i) {
             riscv_cpu_decode_fn func = g_ptr_array_index(ctx->decoders, i);
-            if (func(ctx, opcode32)) {
+            if (func(ctx, opcode)) {
                 return;
             }
         }
@@ -1319,10 +1343,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu_env(cpu);
-    uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
-    ctx->ol = ctx->xl;
-    decode_opc(env, ctx, opcode16);
+    decode_opc(env, ctx);
     ctx->base.pc_next += ctx->cur_insn_len;
 
     /*
-- 
2.50.0


