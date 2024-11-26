Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7672D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7e-0002ou-LO; Tue, 26 Nov 2024 09:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7J-0002hd-M0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7G-00058n-83
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so17280325e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629631; x=1733234431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBBHCx9PUnnDkPAs2eAZXUzo+YrGmCMQRcywZOpNLGo=;
 b=UtMR9rkE3fQZvsKhitt0m9azRM/9LJV4RojnA4jCLia+ke43VuSSMZwr7j1eJE96Za
 C8lVwlTUBd3SmJin8zbpHJ9oQfR0b59Bnn3IpPIfVjap3w7ipeHucuqNLY7z/7PVbLk0
 WeF4oTFRR9BYCcURjDqraMKvtpiLZSQWkK4BVg6qs1dl1Untx65lzhsb2Gdsru0rtO8Q
 QjZNGqyia2OPXfDTxDb7HNkoP3HcmC/65VQkqQlo/URbVx6TylxpM+XrUB7qPXg0y/dM
 1tSpuJH5xBHkfmuAL930bnu4k3qFkNEoeL8pYuKQdszLM7DWfyyUvUhDF5yD1tFaGeja
 C5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629631; x=1733234431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBBHCx9PUnnDkPAs2eAZXUzo+YrGmCMQRcywZOpNLGo=;
 b=EGxIbutvbs/S4hgEACY9iGyXnJs0i/wsBw53/RexL29UV45xmD7kFU4DwCQtpRnY55
 jI1K1uJgjhwCWeVEVhmDvxLs/3yZrAuwmPjcNp6ym9OFS3kAnJ3DCxmpXVjsgOAjD3Qd
 QbQWbGFMyq74VwwYpX4q4d1uwPfq3ZZHMe3GUjpvkMSY31DO4MsTbBmtTCbmKcAB9apl
 bYSyJh2n2LychwZvSCG38yzVl1AA8I229Yxzo3TIlZ8K6+oafGD0QrUDYPCa+td54Yup
 ePYkFdSJZ5FS5IXCyH0n+H4rQ9VSv05WfD3/V+fDVZARIbWauFNghwonqwDHGB1kbDW0
 nwmw==
X-Gm-Message-State: AOJu0YxPaEe2DwD2JoeeWcNugJyA0Bw4SG6lFIH411BobgVV9GL6v8qu
 xT4lR/I91MHyei3/yy/4B4EfBWa5Re+Jq4GXB//1ksYz9gQS4mbvLc11KbRzNHCyKrUjVFF90MW
 0
X-Gm-Gg: ASbGncu5XmPdsYS7c8fZC/G3BcHzvT35KlpWBwOIIxgM4j0c+L+dlz6oDBWEm/gdWlQ
 gDbWtv1uqi89Q7Oypp+DImxQZP94R0PSedvoEH0dCgWbAtKwYHEDh75NcZYUhk+DujUK93N5Qq+
 q629hkpSFoPfU3LTl5l3nmdaJPdbvhLHK+l8PJ+ggVgoXYZCfHwblCqCheFDe1AOMDZIKvLHgD3
 sE3hAKbnF89YMUBzrMhcr9RKbDvZx/1aGf/3moSF7oJ0124KhShljZsicZf2nGFnfBJcvj0hkpY
 zg==
X-Google-Smtp-Source: AGHT+IH8xLWQb58rDXd3zqZXchXnYgj1aOb3wzzKQoheV6zap4VZEknB9Fc4g2bruEuw25S3KuHtKA==
X-Received: by 2002:a5d:5849:0:b0:382:2f62:bd4b with SMTP id
 ffacd0b85a97d-38260b86b74mr14326525f8f.33.1732629630785; 
 Tue, 26 Nov 2024 06:00:30 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe831sm13525611f8f.40.2024.11.26.06.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 04/16] target/mips: Call translator_ld() in
 translate_insn() callees
Date: Tue, 26 Nov 2024 14:59:50 +0100
Message-ID: <20241126140003.74871-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Historically we were only calling decode_opc() from the MIPS
translate_insn() handler. Then variable instruction length
ISAs were added, we kept using the same pattern but call
yet more translator_ld() in the callees when necessary.

This is cumbersome and bug prone, so better move all
translator_ld() calls to the callees where it is more
logical.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c               |  6 ++----
 target/mips/tcg/micromips_translate.c.inc |  3 +++
 target/mips/tcg/mips16e_translate.c.inc   |  5 +++--
 target/mips/tcg/nanomips_translate.c.inc  | 12 +++++++++---
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6fd5462a24f..0495fbe1dc6 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15000,6 +15000,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         gen_set_label(l1);
     }
 
+    ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+
     /* Transition to the auto-generated decoder.  */
 
     /* Vendor specific extensions */
@@ -15120,17 +15122,13 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
     if (ctx->insn_flags & ISA_NANOMIPS32) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
         insn_bytes = decode_isa_nanomips(env, ctx);
     } else if (!(ctx->hflags & MIPS_HFLAG_M16)) {
-        ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
         insn_bytes = 4;
         decode_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
         insn_bytes = decode_isa_micromips(env, ctx);
     } else if (ctx->insn_flags & ASE_MIPS16) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
         insn_bytes = decode_ase_mips16e(env, ctx);
     } else {
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index c479bec1081..98a00125520 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -2973,6 +2973,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
 
 static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint32_t opcode;
     uint32_t op;
 
     /* make sure instructions are on a halfword boundary */
@@ -2982,6 +2983,8 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    ctx->opcode = opcode;
     op = (ctx->opcode >> 10) & 0x3f;
     /* Enforce properly-sized instructions in a delay slot */
     if (ctx->hflags & MIPS_HFLAG_BDS_STRICT) {
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index a9af8f1e74a..defef3ce559 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -453,11 +453,9 @@ static void decode_i64_mips16(DisasContext *ctx,
 
 static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
-    int extend = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
     int op, rx, ry, funct, sa;
     int16_t imm, offset;
 
-    ctx->opcode = (ctx->opcode << 16) | extend;
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 22) & 0x1f;
     funct = (ctx->opcode >> 8) & 0x7;
@@ -658,6 +656,7 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
     int funct;
     int n_bytes;
 
+    ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 2) & 0x7;
     sa = sa == 0 ? 8 : sa;
@@ -1103,6 +1102,8 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case M16_OPC_EXTEND:
+        ctx->opcode <<= 16;
+        ctx->opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
         decode_extended_mips16_opc(env, ctx);
         n_bytes = 4;
         break;
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 1e274143bbd..6ee0c4fca3b 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4467,10 +4467,11 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
 static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint64_t opcode;
     uint32_t op;
-    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
-    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
-    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
+    int rt;
+    int rs;
+    int rd;
     int offset;
     int imm;
 
@@ -4482,6 +4483,11 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    ctx->opcode = opcode;
+    rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
+    rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
+    rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
     op = extract32(ctx->opcode, 10, 6);
     switch (op) {
     case NM_P16_MV:
-- 
2.45.2


