Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30516CF042A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2S-0000Ly-Sn; Tue, 08 Oct 2024 18:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2Q-0000Ko-Ap
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2C-0003xc-Dy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso49208675ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427827; x=1729032627;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSlgYdm9NcEEC03pLWzOP8mzYKDOti/jL3SV8YBZHEI=;
 b=Oh3vSYlWbv5GwYiB71N2Z+YdJnTpJn96IBC12JO3ZDtJew1zsPk3IWmnZf/ctb5Bk9
 fQ+x/tou6WZFMWZMGy0lwmJJ2VPRgP/7Z6CRVbMdo9IQxmVzeKenfZswUeaHSZYfI/m5
 s5tYPcsV/KBxjrxL4nIi6mSw6AYJpDc6/Xg80QmWIoRigcyrck251KfQ8qdiA6A6R0Dg
 gJEUkweDYq2DatQNEz5O1zh6N/zSK16lL3JxTLJMxqTgjdf9nmN28S0jbCocbERbdxxZ
 19tP28S2sFuu44qXhdJUl3SU/JucLkGAo9SrUDgJ3zWAJMvGte904TnrxICT697mv8IU
 iE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427827; x=1729032627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSlgYdm9NcEEC03pLWzOP8mzYKDOti/jL3SV8YBZHEI=;
 b=BnoP4scqXyE/ZFyuLxrO321MW9qzlaDEyUhjAumLQSO0+y5HzpFcWeQlFl4V3QWwZI
 DvI0yfPs/XJhmaSrkt+m2tZkGXrTHIUz17UoIL2efAQf+V1IMdMhhPR3o68LWWLLp/xT
 gkaj2/s+JttiSLiCv9zT+oXVqIokSEpLLUvAJZYnZfEoXjx1HKHHJD28urN0h/ZGV0sT
 Oglq5tKEDpHn1oVcWzB1ohcDqtu6Lcv1EvLDccKPoYdZOPaKnfOSaKXQwqGeuES4HUax
 zcX6cn2ybBwwFQ+wOnx5anrbsk20db60aR7lrx3EFaRm2bwuRKVt5s2EL9nypOETHqp4
 hy5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA97FRG311xwJumKzcohQPsgj8CEab84C6d6+FnNxaTS4hHnxYorMZtCK9GXPZ7KRnYNT6wQWkq24i@nongnu.org
X-Gm-Message-State: AOJu0Yy3bA4Mnth8CzvKwdzEdHCmbs4qZlDypQviOmN56m78ANwXKULk
 3DlFJ4NS+N6BTy4sFNRMyLOca7VOCra+rechnfEd9Ca60MFefN948vIA4Ca73a4=
X-Google-Smtp-Source: AGHT+IGkj6DFWfQG+1D1HT0nCu2mm07lvgbFQNlrVNw0EVAwC17EWXbwCIxdFpMZe3+SQi1pC6ipQA==
X-Received: by 2002:a17:902:f542:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-20c6377c213mr7417015ad.46.1728427827159; 
 Tue, 08 Oct 2024 15:50:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 10/20] target/riscv: Add zicfiss extension
Date: Tue,  8 Oct 2024 15:50:00 -0700
Message-ID: <20241008225010.1861630-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 135559fc95..09e0b7e0e5 100644
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
index fe7ad85b66..59d6fc445d 100644
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
index 963c1c604a..6c0c319499 100644
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
2.45.0


