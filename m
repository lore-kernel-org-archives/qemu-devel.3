Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A652E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHD-0000Lu-KZ; Fri, 10 Jan 2025 03:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHB-0000KX-Ma
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:53 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAH8-0008KJ-5U
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:53 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2156e078563so25526245ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497308; x=1737102108;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=odF38IwFXdegbxuzMWJnAsmwY053l5KG/zZUy/DvHQs=;
 b=05vMNHgP2UT13pAvJnkNL6bFa3UUFAxw8z7BX3h1vtWv42Wv/KkHvyYYG4/o2iUP6K
 KZ70Yj7FSh3YCMCkwIVgNgImcYJTOhezIx1MwmmS1kur8W44RuI0aVLZ/csdO3Sj4J/E
 FeGFnT0cRZdPu4G0ecfGh2tZ+MOTR8o/piWeVzoCEu6UnGyHGD1u5tgbrb0tQnfC51Q3
 hReZCII58qSLysp1h/uaItw1JqEImXpDWEyU54LfVM6VZFSbyFIaew22PIxP4LduVoHb
 HRXYMulS1+hRJgLpZsABimYxcwyMdAzUyx0u/JcJhZr2I1ENY+DIwaxyH/n2C4o+825J
 pXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497308; x=1737102108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odF38IwFXdegbxuzMWJnAsmwY053l5KG/zZUy/DvHQs=;
 b=JhA8JkKSE47BzObld8pqOPTXnLq8VA//Sd9auCVkpMGwIDqU+UD8TDIAazKHNMhEZM
 FjUxfMnY5YBlQvEQhotfuSVOI7egJt161O7KMvnCnWTjIld/VQezUUkC4DvQdjzjjbXj
 KA2g9/XEEk9KS/fnIDTnmg3mO1u/1F14sEIycDOzbSbj4Njmw4OmF9J8SOUD+UsS8go0
 t+pjR3ggTjhRO6nnnnEZKDSMi6QSvGq84RlcOeip1fKiTsYGmVAGH5SR1TXOhIe/3St3
 ZK5xbJDdUQ92G42MWarvn341DqsX68P6AlHoqnf8JyHU3j399SJC9O9swzg0ObdcCYgM
 D1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB1TNy+5yBFHXfOIWD1MRwT+R02msHjYC092ECoPa262RHs3LRX0Nt7I9uwVnQYHr99wEGHQ6OQGIA@nongnu.org
X-Gm-Message-State: AOJu0Yzp4uBt3lvJDuBlMxjEhaHIx5mcbQPDTxqpif65en9evuD1Z5+F
 TX1JD8GfFtoZevpjPvKeHrsFUaIkR6EkUqxNZfuf7lJs5ztOm/MqPZuZPLcF86I=
X-Gm-Gg: ASbGncs/HRP5zfYEVistvxn5Ip+zWPiA69gJ2AEveDzQpIg+VFnsVETUVK6RSGS1IZT
 7QmrOwtIPF18ZXr38iIuSrbM0BF78wNOE9v7EUlJstQAwzOnspUAk7iLYA2g/LCDG5RjhagLHgN
 SQAjC3+MBbvWlDAeRscDfuxmfTT6BJThcVpOyuza1pwxOzgiZPTiwCijdOOEIz4GNS+sdSfDt05
 OY3kP0rQssKaqOYAzXvMel2/DNxpYDbFTQsin0+CP3wm02X0Y4Qqs8MMmfsYEOvtaBYkQ==
X-Google-Smtp-Source: AGHT+IFT9EdCfQbwt1P+JnwS/tb//VBA9Am5V4N7hU/C1Nv1vyfVx+sDwE269Fd9+tWK9RrhO/q7mQ==
X-Received: by 2002:a17:903:2449:b0:216:6f1a:1c77 with SMTP id
 d9443c01a7336-21a83fb0db1mr16171065ad.43.1736497308511; 
 Fri, 10 Jan 2025 00:21:48 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:48 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:29 -0800
Subject: [PATCH v5 01/11] target/riscv: Add properties for Indirect CSR
 Access extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-1-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62a.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for sxcsrind. Definitions of new registers and
implementations will come with future patches.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dace670e5e0f..4f5772ae5b60 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -201,6 +202,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ee7c90871047..4fe2144ec713 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -79,6 +79,8 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_smcsrind;
+    bool ext_sscsrind;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;

-- 
2.34.1


