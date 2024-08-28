Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA46FC636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMmD-0007eO-4T; Wed, 28 Aug 2024 13:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm9-0007O6-Fu
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm1-0004SJ-JB
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70cec4aa1e4so4804993b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867279; x=1725472079;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeeCRIsnXL52eEPzBogz3tXPgD4tDBSBBKhZX1512Uw=;
 b=gvWN8STyotfI9xTBJmrwv2cCSuaLxkXBGiWoLW7tCVFtmIjD5euBcJe6uv5DW1EyMM
 FhIdA84KxjQ3I33vsWDd09mHOLku2KMG6LJlJOeYLgLkvFmJzu7jf+y3aL4QM4kQIwyL
 rV+8tp+0F9N+nUOpTjCH/d9v/2/P9G+9CT7RsPeO10/CtdlLq/Whu5EzhbrqeLPRCo93
 tknkBMez1n+h07+OoCUySpaghfdUESm+OydJeJ0DCfRV/n2WIAxEseugS8Wx5c08wVbk
 IW2kslczl7g2PUUklzMWTN+VKQXSdt/U4ulMfrcckqhh67RvFUZzK5neXXBSIeB/q9jM
 2uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867279; x=1725472079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeeCRIsnXL52eEPzBogz3tXPgD4tDBSBBKhZX1512Uw=;
 b=VMMA9KaElmrgunQ7z1IsqmD5TKIFCym0jZD/z8sKmbZN/+ED3fY5F16Vwk/E3sXR6g
 Ewew/ccz1Bt6BwSNvE0yW81KvFdqrYtOjS+OEOoD/94q5J2338wpZkd/R7ioEvJHJrWW
 zGiup7sg7IZV5hgFBA+3fuJVKTojFkRcLjHBVfaNuOU0RWvXg86/FHVBozMlE2Mj2FJH
 T/nkps72RH22T2K+JYmeVDiW2h5ZhP3NT5MT89uo2yZty/znGDp6hj1t+hO0sN1f9w6e
 SI5jVnFiMxUeAIjqDkNMOYLSw4T+zr7ZfqSqCw8SkzklBlBalx33ekUc2XKT/jXVtRHq
 SiTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbUqroR83BQU+ZWav7uQqKGUCROIrGRQPDIJYg4j1h4RPAgs72keii44RSiRULQfms2RxxR/c0qwkH@nongnu.org
X-Gm-Message-State: AOJu0YxuYjpcJBCuRyVph/5bO7JLliTVD09MB0QIht33dtNfMzSZ8kOT
 6DQbIP5Td4xxIiOw6i9z2/jxhOjwdOw8KptNd+xOgCxQ6uMXve29VThiiXGbBeixECSNOu+riUH
 8
X-Google-Smtp-Source: AGHT+IF9W78GoWmrg2Es48sSHz4c/ZKtjIny7TqMTJr+wo4RxwXkPjF5QKNaR2f2aWN2y2lLgI7+Ww==
X-Received: by 2002:a05:6a00:1884:b0:710:4cf5:c570 with SMTP id
 d2e1a72fcca58-715df9a26cfmr405069b3a.0.1724867278581; 
 Wed, 28 Aug 2024 10:47:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 10/20] target/riscv: Add zicfiss extension
Date: Wed, 28 Aug 2024 10:47:28 -0700
Message-ID: <20240828174739.714313-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on A, zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c9aeffee4e..29b4bdb40a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -107,6 +107,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
+    ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 88d5defbb5..2499f38407 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -68,6 +68,7 @@ struct RISCVCPUConfig {
     bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicfilp;
+    bool ext_zicfiss;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ed19586c9d..4da26cb926 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,25 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zihpm = false;
     }
 
+    if (cpu->cfg.ext_zicfiss) {
+        if (!cpu->cfg.ext_zicsr) {
+            error_setg(errp, "zicfiss extension requires zicsr extension");
+            return;
+        }
+        if (!riscv_has_ext(env, RVA)) {
+            error_setg(errp, "zicfiss extension requires A extension");
+            return;
+        }
+        if (!cpu->cfg.ext_zimop) {
+            error_setg(errp, "zicfiss extension requires zimop extension");
+            return;
+        }
+        if (cpu->cfg.ext_zca && !cpu->cfg.ext_zcmop) {
+            error_setg(errp, "zicfiss with zca requires zcmop extension");
+            return;
+        }
+    }
+
     if (!cpu->cfg.ext_zihpm) {
         cpu->cfg.pmu_mask = 0;
         cpu->pmu_avail_ctrs = 0;
-- 
2.44.0


