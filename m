Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3331E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOX-0006Bt-UV; Tue, 17 Dec 2024 03:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOV-0006B2-Dj; Tue, 17 Dec 2024 03:57:31 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOS-00007s-AG; Tue, 17 Dec 2024 03:57:30 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53e3a90336eso623965e87.3; 
 Tue, 17 Dec 2024 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425846; x=1735030646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RlXcA1GXaEMNW19Gm6NquX5KIRiIqbjX3akucB1Zs4=;
 b=b+80Os2cOsaHKeknPAfwQGRoqm+VFNCiQSwcscL0Q/KhHalcSYM0XNYWiS891r9SCF
 UH/J1CwxjuGSeryQ7mBVMqKE7v9p6BRtSMHtkMmAx9BQXgJcze9kdz+GyWnEfJgNtPSb
 jcsBw3Oy0NFi3yJCPPu7f9+Cw49QiqoTkx/PkNN1olAEeQ/h6cPKYS4uPWRF7tM6EDFk
 b4MLjNyfpyGHlXSg1lmPCwruu4xsaW9MGHPee3G72zBgACzAUAW+xo9ATeYLaBxJJkqX
 SkmM7/kVhTGNOaDQ/BBR/54ETJRwGq9iWvEGti6rEUCRygQMJw34PqTsEjyXjOa/O4mb
 0YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425846; x=1735030646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RlXcA1GXaEMNW19Gm6NquX5KIRiIqbjX3akucB1Zs4=;
 b=Zn2sLAKNmNAIaHhBgdf5GCqWY/x34WvthW/cdjYBGLXbjigBqth/54JBD57DxUnkeP
 FZ4qk8AYAiGLtXHCu13rDsKR5iUgSXDTcv1321ci7UTBvBFfcJWcX4SJYHroQIQd+Xh0
 j1vOCyt1JZe4pEkOikHzv+JKLMF3nvw2BSkNGOfbl4R+ImZTSxmEHcxDZkCG+SbnSo6T
 Cy+EU7cYU5wzAdfY64/IhWuGOlTUqhy3uk5a4wZCZfhyvcvhG8yhD8qyn3RkzB/xRKgF
 97OKmo/dmS9MrzxMJsLBrtnTgmdmzm8/4cO0NKLWbMZL8sqT4YlLoR+ljyFGamwzY1lU
 F2Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk2j1pQ36TgFvKJluJHvQ01zV7foYYhgw31LB45rTv+7J4eh7jL1pbU6xrblZlqqJTN7NFarwZTJnjUg==@nongnu.org,
 AJvYcCX6vgdOthjJe9RunD6F5/4hNg+bbsXHLZW8n4aX1b97Z17RxBZaWDvdQ8UtdUTzaFikHRoV8wrdRW71@nongnu.org
X-Gm-Message-State: AOJu0Yzh93EwiyuRuxCvIiFquHquJlufOq+HF/AJfNKeZBT3ib1UP4ts
 ZWKW1Ij5eJI6lhXKQJv7Q0aUw6jG3TsDdCl+e3rY5oq505Epo2Ac
X-Gm-Gg: ASbGncuVj5MN+lAEoPyFn9RvBgH6x4KjqAKZAnCHMpRB09XjPoAzVqqEScAx8A3EjEh
 JUfweJemtaIfNqWmldJsnbzqTV3sWlpsz1aJ/mz8ZnWuEgqF97as7sMzlhoIr3dopm7BwnoMUf7
 NptpNGzLUMsS137XHME7QFyBMEEqpvXZqfF3lSAMhG707BazInt9afLrBDWGuMjcztY1vzRtVI+
 xUKHwqGRLo9lSmlaLXmHRgW82fWUcnNWVrppbKb3A18sJWeFAcImzBRlf3T
X-Google-Smtp-Source: AGHT+IHT1qtq+hcZn8ee1iHBwWbul8zN7upxilsptBMbrFN8q/qTtKfVJnGOXmcY4zo4NNVOOS9O+w==
X-Received: by 2002:a05:6512:158f:b0:540:1fcd:1d8d with SMTP id
 2adb3069b0e04-5409a226354mr5784941e87.57.1734425846230; 
 Tue, 17 Dec 2024 00:57:26 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:24 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Tue, 17 Dec 2024 11:57:09 +0300
Message-Id: <20241217085709.679823-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x133.google.com
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
index 0a00be66f1..144ce822d5 100644
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
@@ -1492,9 +1495,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
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


