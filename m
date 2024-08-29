Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598FBC87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofJ-00041r-Et; Thu, 29 Aug 2024 19:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofF-0003pw-SC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjof6-0003AZ-85
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d3da6d3f22so930904a91.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974483; x=1725579283;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeeCRIsnXL52eEPzBogz3tXPgD4tDBSBBKhZX1512Uw=;
 b=wWzWVdojtBFyuBZoqfCQABGGAwdRyMklq4K9f4UZxMXL+SGIU0dbn14GiGT8kARKJJ
 yIgymHIkcxv5CwjaNeOWMBOli8yXFuDo1UCGUO6LlRB8Xkc29Xoi5aRptEET6dLNmCsl
 M5wMLMr6c1BZMFoBUAspqIaKMuRexNQmYecYGI8Luh0PMWLcZld2tn7HsOffCE9iiavG
 a6PtV+nduKStx6fyj9D3jNiZ6iWOUiNQUKkNtLFkcwyhxcphwMA4wl+b35lwtrpcaHd0
 7Hie60TtV9FxA38QasWU4fSMVe2Y3fmYEMs+AQ7KgbNPRkUOf+f4XaEowpw2JzRgq3vv
 7P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974483; x=1725579283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeeCRIsnXL52eEPzBogz3tXPgD4tDBSBBKhZX1512Uw=;
 b=RKSXzj2AS2St2elTOQP0T+TIsmef0mHQ6OJctxiH2F8SdtsJY1NmUT/zxWCpHOAVVF
 jXF28o78B3uCaHn9Y/d+W5k3A2394dCvpd2t82FUg0d2c+SnY9GKg28eYr6F9n48QZH4
 Rt0TCpVcnmlO6D6OMlRcQ7fETDsdK8ogZuzvWcSGQXo2xMLz60V1DQ5kecS238b36AQv
 13IpRiZEwg6HEEShObD/P8Dq6pXxJD3HzeaHpK2RYKn9+MPze3tWEolgv8G3dSwcGUT2
 fpw95p0XFOvptn42DS1q9pxKv0e5xrulQWpE2WScUNmDcPkDCoF2ZWSjtHNJfn0XGcMC
 eRYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9QqGST5gc1iqPduSHP9zbmt4hpvu78LWK4RekM3DMQAytSFNOGr0epuhvilJfG+4+jIKq4k1NEcn/@nongnu.org
X-Gm-Message-State: AOJu0YwXQkSSScRp5OpUPhzOkjlBiy56vSSdPLVU2sBCpXWe2XIn7oCj
 VKfp4XPSOltOOmFcv+EhjnCBfiW/fbBlo+17eGTRy9yBE8si7Fh2IfWrsWXH3NI=
X-Google-Smtp-Source: AGHT+IEfUm1gq2NZtxOvxrRg1CPlwGEJxdK2zQVUuhhDkKIUbHU4DGE9RP5Tvx4ZqOxMMNhbtYY63A==
X-Received: by 2002:a17:90b:3a8a:b0:2d1:ba43:1303 with SMTP id
 98e67ed59e1d1-2d8561c5dbfmr4543775a91.21.1724974482672; 
 Thu, 29 Aug 2024 16:34:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 10/20] target/riscv: Add zicfiss extension
Date: Thu, 29 Aug 2024 16:34:14 -0700
Message-ID: <20240829233425.1005029-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1033.google.com
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


