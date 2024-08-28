Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F211C636ED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMm5-00078Q-F7; Wed, 28 Aug 2024 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm1-0006ts-Sp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:01 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlp-0004Pl-WE
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:55 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-82784c8bca5so223940239f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867269; x=1725472069;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=JHSiaBHMi5eZ4vkfXhOuF8m3COg67H2tAFB2bBt3TJnFhoc0NSl5/t6lRY+YVbd572
 nro0aVDsCKp3b7BovPzPkb8P7/wzeTk/zRywv4EJ4DDk/PG2RP3+0hwfszGM3Jb6+kYw
 DnGkiEWoZ1GTAZ5zMw2q/fo6a3iM5t0p4ZpysHMUycTtPQC5NKVZ1ybll78tvy/67xLe
 VDGOufiQAT29KE/TDbZAZ3TeYx8qwIFG/q6GrNseNztrAT8JZVYK8skJkA+l5LdM1e1Q
 rkpACcR/qTSMikTpB1Uc2YR2T6Rk9cJild8Ikqz2G16yJzKb1KB/hEaS/Ks2EMb0a+1r
 XUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867269; x=1725472069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=DEm+tpugG8pJlpVcSVZp7ziefnGc2LnTGbdcgez7iNSsNIxD0ZToRr9AmqLIsoweA9
 hI6dbXnVSx+12OdddtrEK7mvWQPyf9Q3eHsYoXaUbhZmHtlHHU5Rt+tMCzsN1frR/ycV
 yQzpk13urDeRl1xkCo8oCRIlxKHSRnqzKjCn5UsBLuWkg4Vxp2VWAYUxYRHFC8vSngTY
 4QKJIRKgCcaM2SNF5cWL161ZFoIFCtroA9tS1QP6OJgPybcwNc+wSdW0LFiM2ion1WIP
 UVAcGKTW9WAP/9V00Ffo+oMookm3Xonk2nUgn81Saer2azX2Ors/uLUxV84HESO71z9I
 oimA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/RlpcM3/iOjS39kyUGalAFkRcJ0eiAkO5LTv7CTBsEFzq/OBT+8gFm2JM4fFhl1LCwbh3dqHLWthA@nongnu.org
X-Gm-Message-State: AOJu0YwiAGMFLm2OeIJ/QmzVfxAskKGdqyuub09/SE/S17x92ul3yhYZ
 QxMW3BW8bPZKpEnzPvXnGcD0A4yV8z9yvXpUj4AUbOl5qNvfNkyF4xXECYXlmDY=
X-Google-Smtp-Source: AGHT+IGj5sc/sdc5LJeW1RlV7Sqs5AiznT6yOfetUhkSZnfw3SEoJSCnq57NLZr3QzOaxHyYLlWHsg==
X-Received: by 2002:a05:6e02:2148:b0:39b:3635:e3a with SMTP id
 e9e14a558f8ab-39f37879ed8mr4710055ab.22.1724867268460; 
 Wed, 28 Aug 2024 10:47:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:48 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 02/20] target/riscv: Add zicfilp extension
Date: Wed, 28 Aug 2024 10:47:20 -0700
Message-ID: <20240828174739.714313-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=debug@rivosinc.com; helo=mail-io1-xd35.google.com
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


