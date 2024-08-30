Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB430CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nP-00013r-Cm; Fri, 30 Aug 2024 12:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nN-0000ym-Vw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:22 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nM-0006z8-1N
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:21 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d8818337a5so398063a91.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036499; x=1725641299;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42c+0ssg4UxcWQyw4BQBXw5g7XhhKTApWOAdg7dkQD8=;
 b=xy7lfYaNscqbeZWi1xolqHUtTSZT8gLGCX63JoEYPef22Irz0NP781pQQ8hm0wRUNy
 jCzP7Xxo1rpia5XrAcFUVUObDPAKHaI9jBGxRhY54bp43b26dDgIwkNRGuquE+bU4TQt
 RfoFpzEHaEhlEjH+F1fpnSqjbYs0czxWChsChb8rJM1xzsrYtUyYFoA6FbT6NTCVs3VH
 UGAgFmpDfbWAO3LYLPvr5/1M3f+56225NzTcf6u4Ll/Q0ONYq+qwtq1pIRnvNe3HBY3w
 WjQHkVWC9VspQUASp0JVEGljF/rBjhhlCzzidM9+eEOcqDFobNv/+C7Mgu1GrVA58oxz
 JJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036499; x=1725641299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42c+0ssg4UxcWQyw4BQBXw5g7XhhKTApWOAdg7dkQD8=;
 b=Br0C32jj4OJLb16P4HNKOlH/gPDPEy54JR6LH1lCeTBr7ZzZGuCfXuD80i9iQs+Wzi
 ms5wphe07rAj0VJX54z8Gaq0Ao0NXLJJI7Ue9AkLT2kifKmZcB88xfG9EGceg5VLOVeX
 8yr9T7rx6pKZMGl7SGnvb0lgEXN13o+DsduD8zmIV+ct5FtVrR0qrip7qFJMc5P0h1H7
 aPwHR+2kBU9zR9a5albfnaafTuiVlZBi2aBRGI5W0mvA9aAQfGcMUnXX2lUnyeiOTSsD
 RNrhzfjM2S5raXVQRpoNLesJaIpcvPtvKWA+0NtwH0eKgwhN0r9NiT7xPi0oINjX/VS7
 tGBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjxZCqYiv22XxjauyfvqBc2AAmxuRSEeM2BO0o34IfsTfRe8N4f/sOi1SH/yrpGejoNf7rbzNyyLx1@nongnu.org
X-Gm-Message-State: AOJu0YwrL0YVGPLbxcheajZCTBmFmfGFyR/Nz3BK9qp+evblYRAQ95h3
 PD8sJgER7pvp3geWDwz6PkZIx/LSnXeuBujRLX7+gZoBfrLzuswwKkz5AMu+KxM=
X-Google-Smtp-Source: AGHT+IHSHOJ+gCS/G8b1RwJCSp4IcGNXS9XIGrexXhjjDYz92tn++Fyd25eZfHMK0hvHdOFKixnuEQ==
X-Received: by 2002:a17:90b:4c84:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2d86af76912mr4553835a91.10.1725036498552; 
 Fri, 30 Aug 2024 09:48:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 10/20] target/riscv: Add zicfiss extension
Date: Fri, 30 Aug 2024 09:47:46 -0700
Message-ID: <20240830164756.1154517-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102a.google.com
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
 target/riscv/tcg/tcg-cpu.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

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
index ed19586c9d..ad1295ce41 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,29 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
+        if (!riscv_has_ext(env, RVS)) {
+            error_setg(errp, "zicfiss extension requires S");
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


