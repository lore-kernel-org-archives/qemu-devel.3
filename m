Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09417D75BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0Rd-0004a0-GR; Thu, 21 Nov 2024 01:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RJ-0004Wg-U6; Thu, 21 Nov 2024 01:13:19 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RI-0006L3-A9; Thu, 21 Nov 2024 01:13:17 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539e63c8678so480782e87.0; 
 Wed, 20 Nov 2024 22:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169594; x=1732774394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6HdRUuJyp9OYDKzo9dzY5iwJdwxmVhNSExq7zJVpB8=;
 b=W2ikawEWgGkS8pbPqS8EiJv5Rie0aocfPvbj4Y8QNM0rtdxoo15w0NMgUR5QZ0uV2l
 Sa7nRF1A2kD4SSAc596oz0unowFT8EwmPlFX4uBKof3/YjWOyiM2JAYhTFYZ06Mo1Bn6
 qf1lJo/HLqezyxMteZhncNEFH4SbuOQ1wieI2f+3sqlVZeXRInpNkvCyLy4e7RZCVE1F
 BnXc8d40uPxs3gRptq/mELCbzG4mrjNpXhPcHbmq2gjlb9S7Hhl+j1FFNgk1V7Yr9Exp
 VsG8/gNFY5yCH/XOOBac3o86ZYeRlh04k2EA4FxXUAwwu6NlKb+qvXIX1oS1aMRyIljm
 bTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169594; x=1732774394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6HdRUuJyp9OYDKzo9dzY5iwJdwxmVhNSExq7zJVpB8=;
 b=BTeoDlY0p55Wley2ORRx8aBKrvmxdpew9FaUG01Y6GVdNLlTk4krc9OqkdLVpoUSxR
 MmUNSE9ZHYQwFUpPmGZUuLJfTXBW/HH7DIp2uaih8WyaBe2YjvVFE+yPAtPKFFNydTUQ
 SYXB//4Gnk2cVlz2Z3caED6AzVPxtbwXQEmsP8kFMu7fNf6OqNmftUbp9NUUA8mkvl1d
 v4faLr0z6dFrfxXeGxsmx0ZnaUvnSykjgx7Cf/QzMwtuqfahmhjFtp/ZZKnUF2v1JeiT
 Wifi3m0Ernjlw4WeMoUwH0gowOcFeYNLtcYI9Z8imS9mtQGU2gRQhC+qBkVbnES1idGy
 pfwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcd7ttjGqoyEdXC7PIZ/FoxCxeozJ48WrIMgUIWW6lQcgcPHNUqGf+y89l5okakH1Sx6trya919qybRQ==@nongnu.org,
 AJvYcCW3pIO8aiF8y9UA7T7EngMhnEVZiQe+ggZ0MG32CWcVeMsmXJhbBKwlr/WhVjBLUxMQ3g1hMYwm4bmB@nongnu.org
X-Gm-Message-State: AOJu0Yxoaz8c6l6K9DI08IGPQP6mY6ZStVsYSLbF2uNMWR8dBXSBmR5/
 gvcaKAe1FyiWNoCLgiik7HPpeWnBybLDL1D/LXEqGvdFNWZNnQ9p
X-Gm-Gg: ASbGncvOQ+4b4snFHVjV8IKrwqyeo0XzpswDoCzZpJQIxRnncsryPx7uUW9OjrTjk68
 YHCy8BzLG+HsYdSsJllW7+NPFaWgOQag1pWMa0AjM+uIItWi5p8c7ysNn/X+kK/6S3a8un6NlMh
 RwxS+4B1PZS8qlgOi+TfwqGB5xKi2vzV8pxnePQaCBPm20FRpdgugfSjum+6sp51SWAize+F7hn
 e3/C3mC0drMpNohdJWuk+rAT5hy+voKw9y16ij9J1T7TWT+K8Kvtr8=
X-Google-Smtp-Source: AGHT+IEi+AFFK9IFW7gPtXc1LGze8DKHyshV+/0QdB+nGrBOO8QhbZmEEFZu4r5vK+Q3UhBXOTJoUA==
X-Received: by 2002:a05:6512:3054:b0:53d:a549:6eb7 with SMTP id
 2adb3069b0e04-53dc13435cbmr2849546e87.30.1732169593845; 
 Wed, 20 Nov 2024 22:13:13 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:12 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Thu, 21 Nov 2024 09:12:59 +0300
Message-Id: <20241121061259.4043177-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x132.google.com
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


