Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A0C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZL-0005kh-C7; Mon, 29 Jul 2024 13:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ8-0004uG-Bf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:46 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ6-0000KD-Hl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:46 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70944dc8dc6so1531007a34.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275623; x=1722880423;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpTED6uOZV4AODyPSsvTHdTqj2NIb+fx5aC8tDZo5rs=;
 b=2b8JG20bh/bpPFazQeBnBAsjWLZ7+t5zsx9Lq+NBMukoOyFNhzOPPpEBJtb1Do4QSZ
 Yb+zb6NrKPs/o2eq95oSc1N9V20ApHvAlCYHzc6l6/9BZLKccG35UJPauOeeqBJbpU6q
 /1MuYl+wsxnGhwX7oLYCOJZlbgZN1oJ7wT1Aj8UaoFaDF/r3CUOKRb7kofevJxATRCWA
 bD57dNdLfSPnBGu3Rcz9oYT9UBUnKn8vWZnin2UKnnG1UY59+VZpcd0Dc4KrQFs0ujUU
 pyl/w4ni81lNIT+ozJgZI3cwAOJTfT46qrgoKG29YkL2DaO6YmpkS9jx1ddGmeq+9hrB
 sEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275623; x=1722880423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpTED6uOZV4AODyPSsvTHdTqj2NIb+fx5aC8tDZo5rs=;
 b=O60VLgYopb/46DlRLn8OudpFBJnCzkw/9vR6gVyyRo6AH/7HpIGQp+mF973NysAq1x
 KQ2Ixa+IQaL71oCbLBMG6GybaF2wdWaPCiA5YkpPoNOIN5O6P54ynjSJlnTnUUUu3VSp
 mFE8s+DzMThXTx/z46UTBcsucePGxcOzCfmi7z9zHXwPw2qHrsUsyH/vjQv4apc7syJX
 YsoPVN4aXlAQEtoR1188Ilc01kFsW4qUeqai0j6pjig6P+ObSYpkF9am9tR+bIuK68q8
 Cn710cXV1XJcrgYl/BjShNS8p3GoHscCpUOlGyjyJbMrSq+JEx0P4Qv7P678OpTWlG/I
 mJNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsVRmADBznsdQbM1SxYKa8/albv4sMpGtI9pUh4fG4TVAlfoYALf2emqOmz4yVByBkcp3RcJT9DIKVW+8GSvSbRIDavbc=
X-Gm-Message-State: AOJu0YzxUHQDF3ZRi0sDdewg/pHYAXmn8LdO1Dx3zi6sHdVcW/fXYy9i
 tVGfVh7kJYZgGkaC+kMnS1LL4zDwLvuQ06KCqVdfzKBRFyB+UcpVnoO3RJcnVMs=
X-Google-Smtp-Source: AGHT+IEaAKiIpw2xAP6k1znIUKS9eCOZjJxYxNVdUY83w4/UWouKPQjgEyDluqxv21LZjTrIuLvfkQ==
X-Received: by 2002:a05:6871:3a27:b0:261:1f7d:cf61 with SMTP id
 586e51a60fabf-267d4d159femr11391782fac.9.1722275623043; 
 Mon, 29 Jul 2024 10:53:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 10/24] target/riscv: Add zicfiss extension
Date: Mon, 29 Jul 2024 10:53:12 -0700
Message-ID: <20240729175327.73705-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e1526c7ab5..54fcf380ff 100644
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
index ed19586c9d..4fd2fd7a28 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,21 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zihpm = false;
     }
 
+    if (cpu->cfg.ext_zicfiss) {
+        if (!cpu->cfg.ext_zicsr) {
+            error_setg(errp, "zicfiss extension requires zicsr extension");
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


