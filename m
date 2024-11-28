Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4860D69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfGz-0005Bf-7D; Thu, 28 Nov 2024 09:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGw-0005BT-FW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:34 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGv-0005yO-2h
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:34 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21290973bcbso8034015ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803212; x=1733408012;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J00ybbkLhRDty+/Gfb3TMi/46nhNnKAwTkyfG+1+1qM=;
 b=xsyJ/0ujN7fH0r7Umy8shncY1nZFb5C+QqC37GxM3UiZBjPQcwLIFWqiqOcNYGCIS3
 34TGXOS0CAAAYkDhCougiqSTkaOt0kKDuztQe1lz9yvZKVpOaOHSdb8BKx+Dv3MgtV9m
 E82FO3+kgZ5eemRaUrMzmLj2mapAXqZxgR2UIoMclRASL4oc7vrVmXkw0W9eht926xs3
 MCP0hMm9CvXuo6nGRxjTqjnscdBxUkIsla7vHNtbRHIv7CTtdXaPuwfnQJO8jhcd/60F
 CqQ0wlthuOUVW1ItuaZ0ZsytfrYbaPkLA5m3LASBu5LTF5Z8dtN8eEMr2eXRNQXRs15n
 ch1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803212; x=1733408012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J00ybbkLhRDty+/Gfb3TMi/46nhNnKAwTkyfG+1+1qM=;
 b=dOOW181q+iRu6Scha8QEdjW3Jeyw60f0tfq2xHbCrDOHnWE9YOAs3IZGrdadjpSH9U
 HMNVPNMWF9yY8qAmHZrOpVE94AyfwQe8dBFfBdzFnlZt2rGllnZEObX9Hyg0DUE1Zrr1
 31MAUrUwJhlt17on9GinWD+5azFM8lx2HTs2Y3bEjjtBOoN/8eOLscpww5s0uDWPDI8W
 atNsboFcoNss0HfSzsX/BWcw+2UTd/0tZUPb/0SRRrRzv7O2zoAR0E5oQBacX7/uaZlB
 pOhVFyFuLHvdaxwU5xIVUFk3AOgDFnJh+3+sygqbAJwZLpa735PDPZPbXLNAHUeiJ8lv
 Ru5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Fza9JmyXc2zrOfP9KxuRchZdOPX4E3DwD+PttLS02Y+zZPtl2hU9FEk8ZB3QoR61wU3y5MpDSDDg@nongnu.org
X-Gm-Message-State: AOJu0YzFG1pKcqnYwku+vbV7blrEW6frIDjLoC5ZPtUBvf7k9uJ1jNqm
 S5MYAxMcYesMQpzNuOH+gIZPFHEQMaRvr4Q2Cn33LehO2zroaRq8ggwBK/UTZ8g=
X-Gm-Gg: ASbGncveaZXuCeYXu0gSruMbv7nL14nr+9MDrhWUbAv4jZUvDPLD4Tdm38CzrPlZyk6
 3BypbrN5OhaR8wohAZQDJfVIlp9a/bQ0zzkbX5qSASBfSG/81GIhbgapV23YqX7+D17ClCQyDqC
 orTA3J9xhMRrJcRgW5MiPum79cQilHEWv7qT6qrBTbkyncjK090PfNXc1kP4kqYG626/HRNUa8i
 dpKzzRvLAH78Dv7A32KONZjzDfZXRET67B/rfDNX8Du077y50c=
X-Google-Smtp-Source: AGHT+IEhICvooZzv2eRBI5RAoMQRNxLm9tM3vBudt4iPE1qdfsB7SOrrMNcvd8MN6Lhe/i8nydhRtg==
X-Received: by 2002:a17:903:22ce:b0:20c:9c2b:c40 with SMTP id
 d9443c01a7336-215010853d4mr101064715ad.12.1732803211744; 
 Thu, 28 Nov 2024 06:13:31 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:31 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 5/9] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Thu, 28 Nov 2024 15:12:25 +0100
Message-ID: <20241128141230.284320-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x631.google.com
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1fac03ca99..f30630e947 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1586,6 +1587,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.45.2


