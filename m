Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A02C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofB-0003YX-46; Thu, 29 Aug 2024 19:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjof8-0003PF-6B
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjoev-00038Q-Re
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-715cc93694fso1109491b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974472; x=1725579272;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=esQ5McqLiuPOSDZzcsSvhHg2CVvK93+xXV8jrrV+bkgCE8CpAFSb/LEarYSL2abp1K
 GJSd2jAGFtjj7D1ru9PY8MTK+l7B/L1eHDJGDZQrJYy3DMjMoqGzZIqBZPg48EYgAq67
 8bgLtsePPS4YXzZED/puAI58K82KS2GLV4h442/6HAMynXjLFy0UW+OFqAlzWu5DMhtR
 rDRtTSgYTYaI/xXTfZOcGMd9wbjxsZ3zW/t1R9s28EOffVlfP4G9nP89Zn5e3a+zOtT3
 rQn9VC93GR7cUoZIcNUIGoEinhmOFNUR9q4v7UmBuEI3L8GMPXd4KyS6XNiUlM44mIYc
 WNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974472; x=1725579272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=oyxNU4qgnvrOv8yEhuR27iLISsiacf0gatksUgLdCP2R26LXkbIuwIJk1rLHLtWfaY
 OZYpA69Oqmn6BZ8iN8phBrr7KtD8vVb7cV+/9USbOAfc3IlF/rTVjHREGllM2GhuOK0c
 7ptr8UwOttQTq9gKCIpAUD+K1BzPa1jFOYnPn4cL1izN9t0qV49s48FD6HG+0uoHdVDH
 sKX1lwgoVEb3faOYrKOaE9IXJjyV4CCHnnmHBDPnjPMNXWRS9j5pduC7QXxAUiRNURCz
 thhLn+TE7MgswEnF0xSzWPKmjaAQ64+2nWUy28DA3Yw9eyS3OdVVhMXvl5gH2q5k8iWc
 cBUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhT1wU8gCY7NdKhxzTx+bEbGmNAl3CzW5z/01SsVU3x72oEK02LzMdBnuYt4v8qw/TVYxK8JcT9A8Z@nongnu.org
X-Gm-Message-State: AOJu0Ywc+4Jta6ixrNZ1hT2QeYAkTRfMY9EK6F2pQMJqKcOj5hWn68ON
 fhRpiDVefEDPJkqg3dwWvq6am/Qga522VqxWr49SxqnfxrlebBLdCUImWHP5et4=
X-Google-Smtp-Source: AGHT+IHc9YuBthDrY9vJ5omdFuOkRhsSwYvBm8BocqJ0k3tp/awKCnsREMdoJN+8bDoZ1MDoryRF0Q==
X-Received: by 2002:a05:6a20:e607:b0:1cc:be05:ffe2 with SMTP id
 adf61e73a8af0-1cce100ec67mr4074769637.18.1724974472244; 
 Thu, 29 Aug 2024 16:34:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:31 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 02/20] target/riscv: Add zicfilp extension
Date: Thu, 29 Aug 2024 16:34:06 -0700
Message-ID: <20240829233425.1005029-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 1 +
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c4ea1d4038..e3f0bd9242 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 120905a254..88d5defbb5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..ed19586c9d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.44.0


