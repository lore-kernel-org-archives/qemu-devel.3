Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C21C636ED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMmD-0007da-0O; Wed, 28 Aug 2024 13:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm9-0007OM-Hf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm2-0004TN-S1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso704276b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867281; x=1725472081;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqFlP0luzPOIPv6o8uMxmJcQE/TtCWtRiNQMFRFBMB4=;
 b=mCgWft19zdN3s+iwK7CHj16qeouUSHjSDkOG0Zm6vFwPlv8PPdVDOJw/biiY/nvn1b
 URNCdWC1fQZtB8fgwpGjFC1cnYUwxeuJjNwbUuKJXEN9dpISS2NjegAFQI/+n0WHYCJY
 1jNSSNzc0p0KALLrDJCWiDhz7FpQ1cElbQSjJ5AOX2T5L/1KR0/bs2cUvzbmn/Fmwiwz
 nhXlc9F68/86Q61rIaEZvwzbWMO22HqpBCQfdDdLO9Zk8DLHB4jZia0VAE6tPEaPwLCo
 i/gDRK4t4OiAXlYb586JTCtpGHP28MytrLzKwTZuqBfGp68L99WOsAmjXnbxueHWghLl
 KJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867281; x=1725472081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqFlP0luzPOIPv6o8uMxmJcQE/TtCWtRiNQMFRFBMB4=;
 b=V6AXpCT2T7L6e0COYF/YKFnCLkbZovUtTtF3fWSURT4uVmpnH0Ew/Qj6f5ZXHL7PXk
 EzPFDHQE/fu0j5dQU0AItV0ggw04XEPV8S8vnHp+UrV9lEzjSypoT+q8ZMcAw5Md7WuL
 FQsepwjKc95Soh0dbrLiygtVvR3up2dAAU5aV36p0OMYRNUp8WW2AE2OMKJ6qgCE2C2u
 uFdBf7aoKMz1KYYpns4yC6Ak85jTtcFu2fwf1ULmpXzVCVewgkjNIIguVMzm3+bK1yz9
 8Su6+1l/jaaOPravKI2Y4Wwi4P29/11YlI60POwjSreQ22IyF9CIqcS90SVCLHobtB4c
 NVBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+nU71iYcv+ujHfq/t1KUFh29UrDQraJW9FYSI171r+GWRo8TV/zz7HdRjklb4ER8TVOkyC2LRyp0@nongnu.org
X-Gm-Message-State: AOJu0YyuXyyw3rHSUstEGjVhT+Z7a0BeZ+F6IBz28ZM/4vP9J1BGPS5r
 cckDxEk8VsxhH/Od67mihWl1bIGnJzRKPuGC/isuRmNswgl1ywUas4YcHDmmsUo=
X-Google-Smtp-Source: AGHT+IHw12aWvaxOwY+T1UtLUTcVbcx1ebR6XPhSf1oiSK4KkUcX541Al8hSBtpUMya2FqSSF8BTKw==
X-Received: by 2002:a05:6a20:4310:b0:1c6:b0cc:c44b with SMTP id
 adf61e73a8af0-1ccd1b1cb0bmr4713224637.19.1724867281206; 
 Wed, 28 Aug 2024 10:48:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:48:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 12/20] target/riscv: tb flag for shadow stack instructions
Date: Wed, 28 Aug 2024 10:47:30 -0700
Message-ID: <20240828174739.714313-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4ace54a2eb..e758f4497e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -612,6 +612,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f7e97eabfa..be4ac3d54e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -169,6 +169,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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


