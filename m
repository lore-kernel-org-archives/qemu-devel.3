Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78342E77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6W-0001Gc-Kg; Tue, 03 Dec 2024 18:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6V-0001Fv-ON
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:51 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6S-0001I5-RK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:51 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7256dc42176so3048289b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267687; x=1733872487;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXViAFlbF0a27TZCJ/bkE40evUkFiMFffaowOt3YXOA=;
 b=gEnHvg/0yOz90+1NOCXFDOnhHr8EiCS36/DLKNaRm5MFKUJ9OCwqkzs3xjME2vBhym
 CcCmHutSj7mD4RENPL+Jh/rWT7CAcjcXwRX5jjYQX4mvbLj28cCl7Nl6TkSLIeat1L2a
 G4PSy2Jsgk0GfvOcRhJqteJRElalN2kbe0JbLw67bngoGF2pf2TlwPgffeGLtc/nifJg
 vCIJRI793Bt4BZx67jAa6dbD/WeQmFPjb31R0mranu2cehomfof02RWMhCX+22piIzi5
 AbLqxwEp4a7YFOjg7MszltGMfuc2lEbn3bFu9WHtP1uMWs4Oi+APo9yMWp0zxY843AOI
 z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267687; x=1733872487;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXViAFlbF0a27TZCJ/bkE40evUkFiMFffaowOt3YXOA=;
 b=OwHNUk9bYq32nc2aX4tUkK+SWn27ciMWSYEwuG7elKfCu21MLVkWO7PhLfqVxWC3wE
 L/DG1e4+wpO5nn/AXsFIHx3yxUxgjrUcVczv3LQWetPZLX5EWPtJmSTmb7aDt5k5i8N3
 9Iy7NqDmZofpI4lzZq5BTz3JJLCI/nLGRm9IA4HUXZUjOfkQiY4lbqL+w2E+kWsjiN7/
 GnC5czICZmfbqiHyPOPMPBtPG93a6mP44OhKvOqu+FkQSK6Z9Ks1V1YHVfNBu5eAJB+M
 pKJmYdDWxHaZ3qzO1b6WHHP4OKf/PCI7WnUO0tV6fzNcr59tFfDq8OMswcoZTN0lN/NA
 hUAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq62WkQCo7G4iwSqn72aO3vStCS5rTJdspKSEICYh7TW1RAK4GsTDVAyY/B6mkPuiL//JT39gDa3VL@nongnu.org
X-Gm-Message-State: AOJu0YzruOjWW61NJGWsNcYvGOVUgTgKDqoZZgjiu+lCzaxdbJFyTD0J
 nG2WIUCadtRDQLGOjOx8vpyqUPOz3b0Fwh/G1CqqdE/zTfMZwaxd7cW/K31EM5Q=
X-Gm-Gg: ASbGncsFAbDMu/4bKwZMo9WTtAX1mU/ePwGSB61Kvk1mKCEuZC3daQyhej0JFkxEKIE
 47turpFYyZ6Cwe1M454zB29kpjlRpJaDIJ8WjfD18DKX49ZAYGQ8f08i7KkeahX59DY4revDUE2
 CckV5tkctcUP0jSYzjDXr3P33FbBvec2NLGP3ch4jdxcvEvClgrkbYL0jtupCBxOqHrTXdqGS5h
 BDcr5PvwTz9KibaZ/3VzWYZns0377V4HqRzSVPvgzlSFq+lIc6t9L3Mz1KLvCk=
X-Google-Smtp-Source: AGHT+IHZX6xOmv6RESxSzfIKssM/VKGrdDopGu0PXBGyXwOCheTKh3QGQk4V83wimymBNC0tW+TjFw==
X-Received: by 2002:a05:6a00:92a3:b0:71e:79a9:ec47 with SMTP id
 d2e1a72fcca58-7257fa5708fmr5365792b3a.6.1733267686769; 
 Tue, 03 Dec 2024 15:14:46 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:46 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:39 -0800
Subject: [PATCH v4 01/11] target/riscv: Add properties for Indirect CSR
 Access extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-1-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42e.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for sxcsrind. Definitions of new registers and
implementations will come with future patches.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b527..963f1f3af9ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,12 +185,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d18..8b974255f6fb 100644
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


