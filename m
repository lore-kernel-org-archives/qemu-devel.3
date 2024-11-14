Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AB8D65C60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvv-0000Cl-I1; Thu, 14 Nov 2024 04:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvM-0008LD-C8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:14:08 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvI-0007ic-If
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3821c5f6eb1so143343f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575633; x=1732180433;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrlqhZAuqzC1HZX4nAGhxZk3V5yhPYxnlkqSF+GjVbk=;
 b=FGgYjlOddPJmjmGg2ut5zlvqjzsQcmOIYrUhhZBWiBH2U2YeO7ZeAtK7ixQL/vI1wx
 1ZIsJqTqazyZNi4MEiajsjlByO+ffuMsFkhBTQyaC5F5t/kI3Sd06d97Opnu4t0aMv2e
 8kTdGAn6/ydQJXJVq/LFfnQSVDHH1GAKocm2Pj97Xs34FWIBFaLLQ6+BXcEpMA8YrenT
 qFzYcLbfwAQ59a9LskAIvGLtctWeSW6MmDk1gURAoPvctsyEJu0aRj8mLerxoFsdF39p
 jIX7Bo2s+Uzzgwce1MSeZ6wR5C1RHnSorRzH/ULeHqfxjfVKqEfP7dng48rquVVsl5BM
 UDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575633; x=1732180433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrlqhZAuqzC1HZX4nAGhxZk3V5yhPYxnlkqSF+GjVbk=;
 b=DJEk41hnrvLXhLDMAXr3bwlurwUpWBaX9qGVsXPR2SMtrd+T4xVbdlfSMsrDboalNY
 YqpXjIz74/h27OwTe49LDLCw3YcklIIw6A0gSnnWZM23qxDpkM/b0DgZFgpnt9+l6LQr
 mByu0v5eS0W41qSHYtMi6jdZIHb4jVY5FrPkM4K7WJJzWJO++pXS0p+zntjBFnIkkDGi
 oro+zFsOqXVqdbRdPUGJy/2v1tyHynn5zb9RMM7p1YuIW5tG606JdPwrQrJ1y0gQp/xF
 OvpnuleDR6hmEiOmtHauuLmrPo/HbamUfK+iYlWricf+mllA+VrCP6U6G0j9qsGER1NM
 9iJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLGfHgml/KqqjJB2TvniA7fUGzyTp8193SUfbwf7GihKOxUgb97r0IeiOZNGnQ2uph9bVLTTF9mVF5@nongnu.org
X-Gm-Message-State: AOJu0YwH2DWQwnsH8Plsx0ngI5WW0Yxh5ksL3MuU98DV89nxwG7+2g9y
 2qywWgUotDJh2tK7C0Ysfw4YmFhqsGBOLilos70hRmE7NBzUzSiSe2cqecIZ5yo=
X-Google-Smtp-Source: AGHT+IFTA47yr4OmHfm+XxAgY9/A2HkbedU2UAoVuiALpJy1/jtwze+NZySWxDEDuSKh5uy6PTOcHA==
X-Received: by 2002:a5d:59a3:0:b0:37d:4fe9:b6a6 with SMTP id
 ffacd0b85a97d-381f186fb71mr18732139f8f.29.1731575633401; 
 Thu, 14 Nov 2024 01:13:53 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:52 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Thu, 14 Nov 2024 10:13:30 +0100
Message-ID: <20241114091332.108811-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x436.google.com
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15b21e4f7d..1323effdae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


