Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTfX-0002fw-P5; Thu, 18 Jul 2024 12:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sUTfW-0002dU-Gg
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:07:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sUTfT-0004ZE-BB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:07:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so643397f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721318861; x=1721923661;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9nAbe/02zA9mz1wYH+8wmMjMKPwaYzPtSWtf+2dkuv8=;
 b=GoST5e69kPK86pvfcFq/gajwZyQEHjgitjpy9Y3sWQjgow/T2GMGuafwUKcZv4BgUj
 4c+pMDsbYm37RnOLOHcYZMp/s7lMa+mvjRmtrAnGMNyZCOpvilFChX29D3TElU1czIY4
 I1KutUT4L3JTXKPOHj/kp6i3YUsbRxyivT7N/GAFts4DO2qZFFFB/fEek65a8xm2g8zY
 Z6dZRaseTe0R0bdYoQAUcyVlpM7ya0H6p9IukbrUV3Nui/PpdlLcjOOzZOP7mSqGTrcs
 dZUBwF/ws1q9we3wH0SK+WsXI6y8xKBHXJArYoq6MPlVY70DBU54tawlXGqbYBtWtsKL
 Vg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721318861; x=1721923661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9nAbe/02zA9mz1wYH+8wmMjMKPwaYzPtSWtf+2dkuv8=;
 b=epEQBwOphVWdSft+52BEhcE/Djr/JFoLvJ0H2MlQiFEhzKp6kg2b5c6KM54eBW08WZ
 1b3U/IDcRtB2dcIkhq0LeQSY7zbIEN3o/PC72MqwiJz+caH97nboF6iu/6fTEfHJx8mf
 tiJlnN34x2nNcpGpmxSjEZOMk1sW/3uQ+eIXg88cIZNRp0cDVFfOGsGPuMn9Ye7yIB7a
 NpltMmFdaERbmjmL/eTiJ4mqrsDiNvP3G4UlIxlBzH+Fz6xgGfQA6j+thhqn0MBD/k2B
 l0fAGzlxv081j5oCmqWHjNQlu5eOuVVVzoPz4m/Vz/NfyXTb208Jdf/AGPl5TYdtZ4C3
 BZXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4XyRxczche6Ma0PaZ4vCXEcL/14ZTQb0TXxVZqqp6sMED4RiMINhC1jrgbhvQQ6HH1trRuLTcS1/u3ormGzWUgEBfILw=
X-Gm-Message-State: AOJu0YxSos95VugFLFzwF0CxlpRI26nfAzjFlf5mFfwP3y2IMd1wJahQ
 PR8I+uyPD18BQXa2hwA16494dN93wA6I8hvKhxLfENGhjRnHjhVpbSNxp7kKI+s=
X-Google-Smtp-Source: AGHT+IHWkYUPYJO3hf5o4Dtt5vr2cpazEtJff75gHVbv1MeThDBmyW9PmbbEUc4IykzX8StdWpoTqA==
X-Received: by 2002:a5d:47a2:0:b0:368:6f64:3072 with SMTP id
 ffacd0b85a97d-3686f643190mr368146f8f.7.1721318860939; 
 Thu, 18 Jul 2024 09:07:40 -0700 (PDT)
Received: from localhost.localdomain
 (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368727f1d61sm4377f8f.54.2024.07.18.09.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 09:07:40 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] target: riscv: Add Svvptc extension support
Date: Thu, 18 Jul 2024 18:07:37 +0200
Message-Id: <20240718160737.211285-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alexghiti@rivosinc.com; helo=mail-wr1-x436.google.com
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

The Svvptc extension describes a uarch that does not cache invalid TLB
entries: that's the case for qemu so there is nothing particular to
implement other than the introduction of this extension.

Since qemu already exposes Svvptc behaviour, let's enable it by default
since it allows to drastically reduce the number of sfence.vma emitted
by S-mode.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Changes in v2:
- Rebase on top of master
- Enable Svvptc by default

 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c53b0d5b40..19421c8a45 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_12_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1499,6 +1500,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fb7eebde52..62612ae348 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,7 @@ struct RISCVCPUConfig {
     bool ext_svinval;
     bool ext_svnapot;
     bool ext_svpbmt;
+    bool ext_svvptc;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.39.2


