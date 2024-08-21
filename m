Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094B2C5320E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgtDv-0005bn-7K; Wed, 21 Aug 2024 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDs-0005R9-Lb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDq-000871-Ti
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201cd78c6a3so1109955ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724277030; x=1724881830;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4mAJdMCJKnSHTZBg24BmY/PI6LJMup/le/nWxFZ0Nw=;
 b=gKYAxiSzte+QMdsbrN3Voybeah/JUhPOjrWy5e0prdUOUvUO0/QgJbvLHmr2VSGymK
 4rtNkWbqTnK5yCcQFuC6Jf/NXBbhGV9efNpP0PKhrPeT3TkXR2twFkNtD7/rmFZHK4nd
 Gg7/pi8WlEr79PM72ee3BY6PLwitpJ9IlRtwf9vIrGy4B21vQrhS8B47o9GuE6UTqjdG
 jtsaQZ2WCvBghkWWclHbIXCWr5jOmXHz+FZ7BezkntRDEOfIIJK9W/D6X3RGBRyAx8UU
 XDHZJueOL7kSVInOSfd/crfpNpInjB/fCfpb8Ae0sOKb+x9wzTFNpQYUk3bEqI5CnmOY
 xrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277030; x=1724881830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4mAJdMCJKnSHTZBg24BmY/PI6LJMup/le/nWxFZ0Nw=;
 b=QyS5EKrWhqbnU8GVK37jR98pZRgbyLkNW2t9AparF6X1kuyIhI9ToicGzRsCVDa2As
 5EJjJLfiCJc6SZa6aWqIJSYodyEdsOr+VRZPAdmwpRiwbBMVOl9ZSsGp6EtaoFn8XWgl
 SiyIIiXY8ru01Ybem2w3J4yu4qjlA2zNjz4U7CeqqR7fOVXC2thDtwCXFyVj3aYiVon3
 sJgVPxlmczlwQVeUquMxv+6G3rPXqXrOGU7WjpaMQq+ZwGqO37/OD+0qOpnBHNsAVjHR
 LSK/5ZYKmOg86faT5FVp8PCIbP6PI5jRARedLNlhK6pwCVH/mXvMpug5fjoz04A6JfSg
 hybA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy+52aEuZ7gu5UMbdhd5olF1/qr04T2yYDnH91WgTZwu2wH3IRo3tK6U4t2UnFNc+b0z5r4P1GVxRv@nongnu.org
X-Gm-Message-State: AOJu0YyiPA8BjfzCmFEj+iizS1hD3yFUFV4TNjUz5VR1g4itlc4lvHZt
 r7OWp/xB4zZDd7Xp3zUEWyE2sg9aFRmQlYg5fsuzuq8WmNWPyALIi0Qjz5fmLFrffPZIJGyhtvv
 y
X-Google-Smtp-Source: AGHT+IGIKyPWdNmh/9izFWjN19Vphr8mipro07I2zPUQRIcLtvT8y6bSsRtdkZwJDLSSWQ1P9aMPLw==
X-Received: by 2002:a17:903:1cf:b0:202:1db8:d9aa with SMTP id
 d9443c01a7336-20367d32357mr49647485ad.30.1724277029567; 
 Wed, 21 Aug 2024 14:50:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859ef0fdsm586345ad.248.2024.08.21.14.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:50:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 08/16] target/riscv: Add zicfiss extension
Date: Wed, 21 Aug 2024 14:50:06 -0700
Message-ID: <20240821215014.3859190-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821215014.3859190-1-debug@rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
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
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 083d405516..10a2a32345 100644
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
@@ -1482,6 +1483,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
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


