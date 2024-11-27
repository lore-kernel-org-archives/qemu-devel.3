Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC0D609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAiL-0006D7-1e; Wed, 27 Nov 2024 00:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiJ-0006BW-7C; Wed, 27 Nov 2024 00:35:47 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiH-0000r0-Im; Wed, 27 Nov 2024 00:35:46 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53df1e0641fso50924e87.1; 
 Tue, 26 Nov 2024 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685744; x=1733290544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y1XlOG6HQ68XRyS1PvaWBt+8Ja5xTcf4QFaElkAjVs=;
 b=J7+3TQVJLLSP31KDMRSA3YJgqsgo1WQmWZouenm1iPFOVgtZB/GPNhxdFCwNho1Rk/
 uNWNWurttMHOYxMW3pgvWOXuCdEmRDgMTvlR7Q0dlmcXu/m4XY1cK7/1p/JoP/mIWKml
 YCW8tU1/bes26nzK0iLHiWdBk5M/+Gsomq59gjLGd1Fu6qc6YyXiBUnFPmy4eILoJ1hh
 6+PjKF9vPsXcbuUYFVbgni3dpE6vhXKUhNUv0ZoS0pwdFsEHgOegYIj9cDFue5avMdWz
 +hhKt2PECLijfB/V3YylUAEJOptwPKIfTPK5z+/UW3dXYl8Vl4K2qu7FkA+ahzvPen8e
 kV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685744; x=1733290544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y1XlOG6HQ68XRyS1PvaWBt+8Ja5xTcf4QFaElkAjVs=;
 b=SMHAx4KllBEaDbyNq5SdN3J2t+s4gVOfyVJup1zahAGPkFfcKIvdW6TbvU1nxDQ5yA
 7FK38GLP0156j2o2xJtPo9DVzan9bQJFm2T6+BOBjjv190hOu+u4BhWIazT+REe2CdTI
 iGRZCnvk6VYfxlb9kUyozHJf46AlunjHTL/c676NDvxpU7TRnOzi7RrlPFFZNE+fJtge
 6yoyU4lygORqkmRV5tYLE3E8HhAkKLcPgBmiDCNH2gTZsGpr/D3TdWwWspr9VlFK3m09
 56y8ai1IhIWul+HyiltZxd9roJ25hIaWIf7iTv1an0exuxmgRbSAVBdPYjtdaqq2rj/L
 RlwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMm6yW4t9xO9npUUbe/rz5mBSRR4yrUvC42lO71VA8THknEkmgLYkiBfTxA+Na5aaFRtCkrH3L2jAH@nongnu.org,
 AJvYcCXwRp+Ca5w9klH/EpJ74VfyWWXKOVdnWkigux61ukZBDOfBHWliGUxGiAcKPEtKy2ZMIUeauA3iaTQ2ug==@nongnu.org
X-Gm-Message-State: AOJu0YzJyrLO6K4iPnvLAAWr7RN/esrJpiE9Ygz833QS6ZizzyXQ6zmH
 Jgs1zrgf85jGV4e8oL2sX/h3Siu9OnaUSR7DdHM5lPx2Pi0tHT+A
X-Gm-Gg: ASbGncuJteT2T5WTOf8C6bru3PDBLDmL2nLXjM3AeGwFjZJG+M2No9k+Uw5D6Mmc7L4
 CrIgLJNmmsN9sm2t+yvZAFt/CYrl8Uyd3lkEzWYONvwnJl0wpLIjZaTCX87ILWml+0l0/C0Iy0M
 2lFjm605qtDEMMjdocwWDeDmPZGk2kCezraFl2RELk1pH7FBkQrP7eirOR+2t+pIbEQuH0qLTpL
 LrhF4RrbJB0hSyxavYYSBxmWoaALpFH9wBaYufTuGg/3yMQgwvzLW8=
X-Google-Smtp-Source: AGHT+IHdCHeyd23uuM8JSLlBCldfFf69tK2/fUNSizUHAFUEujFkU+F/STVrEkUwa6yRTFPZEB0ZHw==
X-Received: by 2002:a05:6512:3181:b0:53d:a4f9:6141 with SMTP id
 2adb3069b0e04-53df00d1b1cmr604040e87.14.1732685743578; 
 Tue, 26 Nov 2024 21:35:43 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53de0c3ce8bsm1211799e87.116.2024.11.26.21.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 21:35:42 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Wed, 27 Nov 2024 08:35:23 +0300
Message-Id: <20241127053523.397378-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127053523.397378-1-baturo.alexey@gmail.com>
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e80dcd2e6..fd3ea9ce76 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
+    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
+    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.39.5


