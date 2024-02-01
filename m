Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1680C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXd8-0000VL-BX; Thu, 01 Feb 2024 09:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXd0-0000Rf-2g; Thu, 01 Feb 2024 09:01:20 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcy-0005M9-Ia; Thu, 01 Feb 2024 09:01:17 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so140269466b.3; 
 Thu, 01 Feb 2024 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796073; x=1707400873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHG3fRFIEdXtO4/0BiGBMl5kPd2uNPVRIA8jKGOUdA8=;
 b=Y2dNjGCvw3NUXiWiq/cppNDqrtZKClK2uhXiH94X7ZQE2GZp3b5wCfqQn6Zz31f6NK
 84tiSNmjohYtzz1JEt/Dst0qDVdjt99wMUHCJF6+dH7pVq9LGMb0uNrPXnJTX0cmEgIl
 y+8agKuxABrTGHwTe5C1GxOuHp5fdM3jsCj1kf1IXwBXZWF3TZfyJ+uqMRm8GFseoxzn
 THdUZwan6O58lJdpYet7SzAOrYbP5d2Jns5wbQ5T9KFMCXC3G0c2R8q46TJ2fApfqh9c
 BNTNgWBEx69lNtq9gzv83ZghF5Q71DBKEvVMFxwcg1Qyh3LXwSI4iNiZyMrCf8hk47nr
 4sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796073; x=1707400873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHG3fRFIEdXtO4/0BiGBMl5kPd2uNPVRIA8jKGOUdA8=;
 b=MfAiyez6Xoz1F9y/qTUjVL0wmWNbTG+b77D0o/wYS/H9ECJAxBt/iG0rQ6zfhsQiis
 6LVnQI0tKNNr1Huh0ErDdXhPnTB8Z6sPcbdJXrdG5Qwqg3m5SQugLG1q9vLZc13xIbka
 mUQQgU5OuJsjELsk9JFkHpGcRoSe5VLZxEzadxzuUOshG9afmPPGWkTkROLnZQUVrw5Q
 P9iZ+RsaEEa2wyKlvBGqD63nfkgXsczy2ejyuiD+W9F67VIv8qMbTPyoz17VYV/gPPPM
 D2FSmnAHjhMu26Q/UASNzuZCyOiO3/ZtqShNoiDVJ5qQrAHKbpVIAoiF5dPmLegp1G5h
 q9Jw==
X-Gm-Message-State: AOJu0YxSp/w9WVQb7Sn8dL1/czXJzzdy4pwgWAAgqsh/j5f7o60DPJQb
 yLJvBErWki6F1JZc1wEhjCga8A81pczWggqVZW0e9h6bKZPP1KOM
X-Google-Smtp-Source: AGHT+IH/E7Z7iqcNDtj+iBmG9av3L+fBDCoYiImEEmkuuAfVNVJfsWGCz6uxSc3BSCWPzZdEY1UBtg==
X-Received: by 2002:a17:906:b754:b0:a35:fd93:8be3 with SMTP id
 fx20-20020a170906b75400b00a35fd938be3mr1451889ejb.2.1706796068704; 
 Thu, 01 Feb 2024 06:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVV5TLfVN+exMKZtk4r6lTBIDQLvO4xXXzEsGEtrpHIVyVmP5ylF+g8HMI+lyXRSIATjE9xm0gzdbRed0XgfWeluJAoYirM9LS9tElcunib6eCsW1oeJAKXshOoz6jnARIdIoRe4sUaq0fKWJ7MOfj9rEsoiQt4uOK7Xvadmo317qkrv2n5TZgByX7mMiPBSvLfJ71P6B86f5rR6htwPlkeiZKi/xIMJO7wRoSa9KvaXCBxezhyAU/y4nvR8ze3xwVEvbLjwRQUTWFkgS541nNTH3uV7q72sgTg4PsHEhhUeu8q5V1hu+2om4aRidA504pfZtZMHOqXo1/YpDUV2xB3pTmVJuBNqNggzjTlBc7Yh3sGhVh+rkGUSDA=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a36a7f0f087sm902728ejc.222.2024.02.01.06.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:01:08 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 5/6] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Thu,  1 Feb 2024 14:00:46 +0000
Message-Id: <20240201140047.3456114-6-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140047.3456114-1-me@deliversmonkey.space>
References: <20240201140047.3456114-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.693, TVD_PH_BODY_META_ALL=2.546,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e40a31f8db..f2b00fcdb8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -579,8 +579,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
 
     return addr;
@@ -593,8 +595,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
     return addr;
 }
@@ -1180,8 +1184,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_width = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_width = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_width = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f6be88dcf0..9d1d627d64 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -105,6 +105,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+    int pmlen = riscv_pm_get_pmlen(pmm);
+    bool signext = riscv_cpu_virt_mem_enabled(env);
+    addr = addr << pmlen;
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
     return addr;
 }
 
-- 
2.34.1


