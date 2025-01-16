Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BDEC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPjo-0001At-H2; Thu, 16 Jan 2025 08:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYPji-0001AT-3r
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:16:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYPjf-0005CA-NR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:16:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso8457475e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737033394; x=1737638194;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DEKcH+07ITLtaX3LyCRJPzZM8cYpZsZqeOdrftJ3fK8=;
 b=KC5Gd7TWGsnkLYdW2LoRC4FAMQRq/NLbjBhVh/JnPzDuFCWGUQmu7V+aqohp++8KLR
 1/scmi5/aLfsqx5R2RTFnB3+FiK4RD7Uaq9BRTA0yQhjfRK3LZm0FgLEgPVcI5kSoulI
 BYbFTJIttQGl7iGhAICbgW6eBk2NyA/bW2SvnhlZbVFvQTq+8wEwxTW6Hbc7/MqoVPKX
 5JVrC9D2UJaJ5np//zj6Xu4sKwq04tjeGsXrS/kPBygxHgG87lpUElk82Pukp/H8TXS2
 2VXYb30AHTG7JESgdrCdxy0ujvzyvnJBssuloEy599HblEAUPXrHyxm55N8Gm3DFIn2L
 28qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737033394; x=1737638194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEKcH+07ITLtaX3LyCRJPzZM8cYpZsZqeOdrftJ3fK8=;
 b=H6JG62QR0G6e4JZyjZZ5red9HJUjHK86LZG6W2kpJTBrF3T1qPjL5nlDh/gZ7uDw7V
 fkRk7UoKqTUldcpfzHc5I9DDaunHt7P98YEEpeYUVLxxGhj97KVsnHlfKpHMhU7JVHrd
 6wN3rEU+wykVsxGeK7Jf9Jhe19adUeRlNK0y3K/Hc35wrWwpfWr/QzeWe/BUdnWEnbaO
 E4LUAiom7z6FPjIIifh/UGKA0XDKORSTr2U8C9zbR3vZ3ZcPXrNpuZ5R3PLObkQN9T06
 WjAMTde7Z9vmbYKrItZAtGd/xOktUXHuYphJEiEuUGtYdZaeloQCekwG2pahv8UspY4Z
 hXnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUceeh2sw3XEL+DbMTDMmITp9piB7mTgjxnjJP3kvau9yhqQ7RfA69q2g3HUfYQP2YnNLWi2bsbFNlO@nongnu.org
X-Gm-Message-State: AOJu0Yxe6iVq5bvrZmEw/Liv1FhpO0AQqePzAbyeI2xFii7cebRWFP5i
 NZzHxj/YQ6EYkH12ex7wHe+IX63EFE3Yf94MmH4dPPpmVw1U/uGnNLCKCovhRas=
X-Gm-Gg: ASbGncs6ETyJ26G+X4A5D+6F/HYCK3cenbrnrhqXIx2jymcep25/A3Iud1Vuv45aQGy
 2I50efACcRiXMJjR62lvI192Tgh6zg2pmMy7zbR6iQEQL6cvKtngmUr4nN5yIAJG4raSoZnv9fp
 5/1OyUe1f8xXLpUfgaUfZaLhbFS1Y23+ngPO2nDowqfiBGiIvpl3ujvpROIX9ducPd5Rai9AcdQ
 zwncxqXvPByoWoXOqFVWwECcvtcrd6J0JWHuVJgR0ALLGFTfA41B4WVDg==
X-Google-Smtp-Source: AGHT+IHQUNqT839BGZITMSuFdzFIwYtLXG0jzioYnqcrUMZWmnOWVacV7t/i8JcUTpKTYgYVwpLKvg==
X-Received: by 2002:a05:600c:1c1a:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-436e26ba95dmr269529165e9.19.1737033393720; 
 Thu, 16 Jan 2025 05:16:33 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749989asm60888995e9.2.2025.01.16.05.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 05:16:33 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Thu, 16 Jan 2025 14:15:36 +0100
Message-ID: <20250116131539.2475785-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32c.google.com
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

Add the switch to enable the Smdbltrp ISA extension and disable it for
the max cpu. Indeed, OpenSBI when Smdbltrp is present, M-mode double
trap is enabled by default and MSTATUS.MDT needs to be cleared to avoid
taking a double trap. OpenSBI does not currently support it so disable
it for the max cpu to avoid breaking regression tests.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
Note: this is a resend of patch 9/9 from the double trap series which
disables this extension for the max cpu. It can be cherry-picked as a
direct replacement of previous commit.

 target/riscv/cpu.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3ed11b0fd..bddf1ba75e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 48be24bbbe..0a137281de 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *obj)
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
         qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
     }
+
+    /*
+     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
+     * avoid generating a double trap. OpenSBI does not currently support it,
+     * disable it for now.
+     */
+    if (cpu->cfg.ext_smdbltrp) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
+        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.47.1


