Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA4C54750
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 08:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjEAm-0007Nl-Hm; Wed, 28 Aug 2024 04:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sjEAk-0007Mn-TI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 04:36:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sjEAi-0001nE-Jx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 04:36:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso3767985f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724834215; x=1725439015;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rvoMEVosXIPnN0S2N3s9u+CdKtkhPKuGueCmYXiVU0=;
 b=xvLs839X8FB92DgJ3QFPjD0yUEUpSBGoiV3BMZKlzhxM0+6jSPQOdTaJwSVAmgqvhV
 bfb7hbrSq1bJ8BeZmywc/8EGX5LMCj/s7KGa9fwfyYOiXo2FqLnL6wp0Gelpcv2clYHg
 VKdFY/t0/mf1a2F1rJHoJXvxxcbIOd2oO3ychH96CZ8u/zb0XVn+0ZkRfxYBCPhvCo6A
 7ps4zMn3X2Bg8XIVuskWIFWK1EjKYt6RXZTXSLEly7Svsq4rXSEU5Sdqk3Qg99BTebLd
 vx56ODyWd/1wIFu8n7Z53KX9o8THhlQt/uBkTb678lB37a3pqG8iXP/CTjHZgrr0uZHf
 4o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724834215; x=1725439015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0rvoMEVosXIPnN0S2N3s9u+CdKtkhPKuGueCmYXiVU0=;
 b=ZrdzVkvWqEh+0OrN39huHJJm6VNXXwWVGW/BQt6WL+zE8OHv36Cyq+6alv37KZUoS1
 tRQ9rNNjR/dMnEmN4jbUjthip1syCWGW9rIIEEa9IikQBP2h2TA3863M06XijKZJ+FlN
 hAzlC1yKNTk2BmaYgyMy1nMx3jf0j1260QFlIszf9L5VfBz5/UpR2X5rHZJKds/aVzRW
 VE+qm3wxNFL5U+V1SfUjuXs9Amd6VrMPYcqC/kXYZ1kS0JLjn1NPgs9NomZecpSAtSoE
 ufrMc6bL29bX39l9TPtUtuOrecus9ocbZr56zjXhTIkW+JLfLILvguAMh+1/KeODfO12
 TxvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKSd5Xv+igNsxEL8nmc18dTp7nQSZVIue7R/5yesvtLGaygO0/5GrLG1AylJf7YmFItN4QvOCybaM@nongnu.org
X-Gm-Message-State: AOJu0YyaYDx0p1JxdCpCCcoKwsloycJ782CfEH1jd3mwQuYVkocoWYGu
 cJ+xpj1W2EpNlvAfL7gsWpHsjRUMEyVzXwnJ2+98T3XZpWOLyzgmRw7E9ZA4lAw=
X-Google-Smtp-Source: AGHT+IErlDKsOh7F8KGrA/J7dIHCm/7wHsgvFN1dD3E1kxmgM1Ph0rVav39xl2LB4o4mocSbmmJ+9Q==
X-Received: by 2002:a5d:614a:0:b0:371:8dcc:7f9f with SMTP id
 ffacd0b85a97d-3749680af0bmr773691f8f.5.1724834214270; 
 Wed, 28 Aug 2024 01:36:54 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com
 (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d512sm13517745e9.18.2024.08.28.01.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 01:36:53 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3] target: riscv: Add Svvptc extension support
Date: Wed, 28 Aug 2024 10:36:51 +0200
Message-Id: <20240828083651.203861-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alexghiti@rivosinc.com; helo=mail-wr1-x432.google.com
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

The Svvptc extension describes a uarch that does not cache invalid TLB
entries: that's the case for qemu so there is nothing particular to
implement other than the introduction of this extension.

Since qemu already exposes Svvptc behaviour, let's enable it by default
since it allows to drastically reduce the number of sfence.vma emitted
by S-mode.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v3:
- Rebase on top of master
- Change 1.12 to 1.13 spec version (drew)

Changes in v2:
- Rebase on top of master
- Enable Svvptc by default

 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..cabe698f2f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -197,6 +197,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1509,6 +1510,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..7d16048a76 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -81,6 +81,7 @@ struct RISCVCPUConfig {
     bool ext_svinval;
     bool ext_svnapot;
     bool ext_svpbmt;
+    bool ext_svvptc;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.39.2


