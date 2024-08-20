Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C03DC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKY-0001QK-Nb; Mon, 19 Aug 2024 20:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCK1-0000hU-EX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCJg-0001Bs-S2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:01:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-201cd78c6a3so37612485ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112097; x=1724716897;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=sKMt3cuN+S+bNFomYQJV6qGy+67CJnemhbkab8wNJ/kLBJsveADqAxddgRc9uIWB9v
 8XVWMoJ6NZeoJCHFJYmpIlVJpyqQRu7ciN00wQI94V4SVtjDzLbPTk4ijt6SmEqGpbd9
 ucAYeMlvv7vH2IymcBSguUtHDUteszMSHdMLRa4Bu0yfNm+Ddm7V9Us+LiFNM1jB0veM
 8zDhnA/SXr4CbX1Z/6N02gbY1bC0x/ljPetPw0YAcryNuQ9qcrYU8xYDtqmRo84PcDXh
 KxgAZMOZV4x4b96PZDnfXrAlY6KA/jUp4cNusqkdmgNQliend1f+eaLGpIOQz79eyCwx
 8xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112097; x=1724716897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=pgcumleFeY1rS2VHJftVBSjhEDKo6zca+IWNtU8s3ZHND8lGmyBGpLYocborq5g+7o
 2ArmM1jaxzpNiiYUMiQfASZnv9fDvrTuaQPkuXSrbJY6J6TzqL4NFHqMsAD9+X8gOEZP
 XXkMAUfFh6LiittQhdOQUSLQMdjNw07vMH+YAxYa/N4RdCA+JqA2KTocjAlLc0N7jUBZ
 gDQmtpIf0xposXcV/UR+imDDb++T7W/TvzoloPMPQFmv77j7T9SZ6pho1BI8xPnVSupO
 JNYZS/WC9jmVLT7AcnweFnLLVyYVNEYlfxjNfqXSCngEjsHF8WJzm4DWkBwJiE++BcK2
 +xpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9K5o8Jv9ywfvoUt+TqjB45DDOkoI4HcYYxdkfZ+oVMyqOTo0OHwKPt6hZ1rqD7ZK0b7svJRqDROUK@nongnu.org
X-Gm-Message-State: AOJu0YyTaOZZXiPQrV6Dr34WhI9YdD/lmXk47TOsPdy5572Ii0TNRUvb
 nHM3McDC45wM6suW+BX5Wj8selyJvstfTGRni7IUag0QwPVG/bU2xGpxGBVxg+Q=
X-Google-Smtp-Source: AGHT+IHBBFL19DdtaDHqRmtwVfYRcCNAkQB/maeO4REbIwoagHjfm3yWJtjy/bUFWZP4X9Sc5l+oJg==
X-Received: by 2002:a17:902:c40c:b0:1fa:9c04:946a with SMTP id
 d9443c01a7336-20203e55184mr130370045ad.1.1724112096433; 
 Mon, 19 Aug 2024 17:01:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 01/15] target/riscv: Add zicfilp extension
Date: Mon, 19 Aug 2024 17:01:15 -0700
Message-ID: <20240820000129.3522346-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..5dfb3f39ab 100644
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
@@ -1472,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
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


