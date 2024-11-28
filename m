Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99943D69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfHT-000652-FU; Thu, 28 Nov 2024 09:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfHQ-0005xl-UN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:14:05 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfHO-00067T-RV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:14:04 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21262a191a5so7611255ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803241; x=1733408041;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBLCZdqPMxSLYZ2+WYXOjsa9ukGU0ozAUlc/kIVGN5g=;
 b=3EWEO7rJIsg4e20TW6jAHMEWzanmAeMqXDW9pWE0QDuxn/6Z93sIOPdFsZlSkn2Mgz
 6kHwNg1VMEw8DfhtDxZE6yStwPBq/jNbIFCiza4xHiF8QLR7LVIaEMQrlBULgDhkXiv/
 mI0ZyKfNIkk+BPn+ujdntGqlED02G1I/446rXM7bw1ug3N2EJdicA6vK3Y4HGPpIvGHT
 FCiuT9fIlCw4smBGrPHkJabZrbPzXqbPzhPzrrLqDbhO1WqElvd7WSsaSf68GbcnNPX1
 FGSujW4hrbjAypuY+n3vTMroleF8MPIjeCGKYxZ0kQAdWKMX40N0LJxv/nIetq/JmaIc
 R2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803241; x=1733408041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBLCZdqPMxSLYZ2+WYXOjsa9ukGU0ozAUlc/kIVGN5g=;
 b=YWN2i7x1xCryfTQlz9oNugPqynIlIG3UJ4sYi+YJoYjH+CLQ0JdQdGH6TSOO1/4ejz
 iVrZ5aoMUxyG8mmacLvI6zcACB5o4d9TW3UTH3XdkcVlIhYNLM+dUICf+x0jRdx/xYtD
 +H9EBWBWm8HzFe5/yKrzFx4sKkZhkTYlK7bTYgOyqtezQSOd7y2liCEgHV+lG+yEhf0i
 Xz016grgnGc6kUIsElBUo+1TV0VytE7weYRlEICniSKa08TdnLdnLnadfKZz8vX4tPtP
 Q7xYU4ychRNkJ+2KYYLbPc43Tbv+hPEVk2bBlexviid8Vk+aF+6KpFpu56te6ALJZI96
 HkRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWieBIwBzIppyt1N7abIGadzerAIBHuUOXQDbHNxQGlXXSEMXMDIHwIBcftu4dabwrRWOGi/qxAUjBm@nongnu.org
X-Gm-Message-State: AOJu0Yxm93rjzndUW1IM75lycvLKhPjBvNtdkiahdaQjMXV+vOeR3zDl
 s8jBhrBQkfjUpBd62ZCd8HwmQlDbzKpkvtxY2lFXpHwaGD5VX6+4T5JkIzxPvKg=
X-Gm-Gg: ASbGncv0Hl9YFBfD67JJeB7t3fhhZS1VbLfGaYxmDchizO0Jgg7tCYPl2zbjoJnc1fY
 sptYYijrqQ5ThqwY+JS5nI4a8UNio9ytspgcOiYf6GuZql5meq6PM+teC2n31564MaRaJJpH0HW
 xRXN62b9KCf94NfPE9RyzCpC0QI0078PsndhIZ6COhQAmvtUgvxbXvWRH7tW9lZLIgltFqp6Yqo
 vZhJObOloQGEtDxdD33Ig38fvAUBcOC6Gc9mSqCVgUXc0FATb8=
X-Google-Smtp-Source: AGHT+IHQsMuyPDIACOoRN7p7y9HeMOR4wsSBAt8k2FqorI/oK/rRgbuoJYDnLwqrxYE437iD3e0pcw==
X-Received: by 2002:a17:903:32c2:b0:212:12a2:4011 with SMTP id
 d9443c01a7336-215018579bamr84094335ad.27.1732803241463; 
 Thu, 28 Nov 2024 06:14:01 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:14:00 -0800 (PST)
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
Subject: [PATCH v6 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Thu, 28 Nov 2024 15:12:29 +0100
Message-ID: <20241128141230.284320-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x633.google.com
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be7c0475bf..9e2166a810 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,6 +185,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1586,6 +1587,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


