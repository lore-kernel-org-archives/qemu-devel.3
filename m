Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D1AC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibgI-00026m-2Q; Mon, 26 Aug 2024 11:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfy-0000m4-5n
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfl-0003ei-MW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7148912a1ebso793556b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724686223; x=1725291023;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYm8/9jgywmCj/ElgHn9yuTvP9ALyRJoBpxeWehJuBk=;
 b=f/NQzXbp5n/DNyPHiB43h0Ex2dtZMOQBcIdwuLQKtJTaUNePrlyr5qEBENAEFwi2DI
 aoduYM+cNqLo4uzMm78nEP/b+LWP8bLHJs+FuN11q4KMVZJjnrvbEq4LZLc+1SVsN4rT
 PaP2xrtmsqVqeN/imRZd/55sAQYefWmZ3m466TzTkLvCQUqdxkrCk0Kn78JPAiqz7bId
 Dop32uqBabdw6UFxN3HUV5d53YPTx6Bvb4EDpEUR7CX8RXshgUxNk6eWTy0uFsikRYhO
 UjNyAcWEC59xbXKj226YsDDOpYd839W7JIz+XTWWSBJDLxPgCg0JruosnR8hjbWmskBS
 IWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686223; x=1725291023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYm8/9jgywmCj/ElgHn9yuTvP9ALyRJoBpxeWehJuBk=;
 b=coW6yxNJ2zJtF4beXkkhx52fIhRErFMSdXeHsLOKGPCr5d8dgNj6AOyln+rz1lXj3R
 Oeoe3gVVRkmX6Ha3gI2QArEAi2Vrswlwd8cvoJgkTUFHkcp+f/CxdIjbzeVgSNE2r8FU
 D+zRIEowTI/sCyiJCcHm5kw7KLfpVdrgOTDcM/aN10oEtIFKH1mHXbr7TD0FfQLf9tzi
 D06ZJlGi2SxvJBQD1xxkbVvnUhFztEdd0TkZ+jtEASl0pRmWvjFhTVDzrSxJRn/3X8ux
 NWdZMGAH2qwBPxyC5/fNYXecrtjFVdhWw+Z8EUtTbVSGAGH88Lm/Yi5gaT5ErqtPhDk7
 npnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy4psSDvOs0zQYIY47KFVkiWMn7LzUkugaACitBIN09kCr6LsxOOYAycDblMhKVyU6e3r5kSZBmFrD@nongnu.org
X-Gm-Message-State: AOJu0YxPphoqSMknozYuo7dNZP087rpP6XVw2fUWzZmgvOjU9XratN8t
 c0xm3vPpg7R02gd8+NHvrigBKtwIQN3mudInil6ELMwjOYruRd4jDQEonLBQOkA=
X-Google-Smtp-Source: AGHT+IGo+tIUq/8H49AUo3vmrri+wH3+hcMHom63AMWUGze8MVhLU2kAUMgZYhG+nYdDfoHsKE1z7A==
X-Received: by 2002:a05:6a00:23c7:b0:706:375e:220d with SMTP id
 d2e1a72fcca58-714458b2edcmr8875711b3a.30.1724686222751; 
 Mon, 26 Aug 2024 08:30:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7396525b3a.12.2024.08.26.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:30:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v9 10/17] target/riscv: tb flag for shadow stack instructions
Date: Mon, 26 Aug 2024 08:29:42 -0700
Message-ID: <20240826152949.294506-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826152949.294506-1-debug@rivosinc.com>
References: <20240826152949.294506-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
instructions depending on whether shadow stack are enabled at current
privilege. This requires a TB flag so that correct TB generation and correct
TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
enabled or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5a57099d59..dcc3bc9d93 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c9165b1d86..ca6d8f1f39 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -168,6 +168,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
     }
 
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b5c0511b4b..b1d251e893 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     /* zicfilp extension. fcfi_enabled, lp expected or not */
     bool fcfi_enabled;
     bool fcfi_lp_expected;
+    /* zicfiss extension, if shadow stack was enabled during TB gen */
+    bool bcfi_enabled;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1241,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = cpu_get_bcfien(env) &&
+                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
-- 
2.44.0


