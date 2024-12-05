Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2075AE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9x5-0008JR-2E; Thu, 05 Dec 2024 06:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x4-0008J7-Ag; Thu, 05 Dec 2024 06:23:22 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x2-0005K1-R2; Thu, 05 Dec 2024 06:23:22 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53de8ecafeeso953444e87.1; 
 Thu, 05 Dec 2024 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397799; x=1734002599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y1XlOG6HQ68XRyS1PvaWBt+8Ja5xTcf4QFaElkAjVs=;
 b=EyIOAUzAsTyAuKh7A3WLTIwMJ0YmJZj5XMF6dkXxopzIPz7ar46gJ7YHYeHmbVO4KA
 uB8y2l9CHzNGusITgmDc0IzDWI6M7JFHnnjkWPe+we0EDBmi+m6di5YcVYD4n95k/N4W
 BqHpjHQK4oYtHpbK9tuSlsQuLaRqz0/iKX2xUG/ayUnySiLfZnNvsYWqUJiK06JWuWXi
 QtRKw3cK6lgfCqoGwwjj1Z9a7WUoYB6zgYpK2PhxH/CA1ZWzILcaRC1gWvz4cDPXRYWS
 p8GuUNp28OtSu7MQita6z5PTaCb4xLnbAk6wJxQIfIZqC9WqaK8GckuaM9uCqHvex951
 mSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397799; x=1734002599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y1XlOG6HQ68XRyS1PvaWBt+8Ja5xTcf4QFaElkAjVs=;
 b=GMLB+uyjav4VnCJ79v6LdjZMs2dWGSDwbuUJLYRO3cIRVpP1t7EU/mplB9J2QyAcKk
 gAilHi5H7RP5mb40vhUbMCpM9bB4ok6W3HNJFPON8pWOEUtSS3A2uLz+X3NZJd5TcFBW
 jd1Rdd+7hDYVSVIdDBUI3sif91lkB8MWSL+gllyaFRG84fDlKgaZ3Ex5bTA0HNNCM2v1
 2x334O36RLRe1Nrh/SBnY10QtjwA6Eg5MviuUajskBkqwp/zwVaVJiUcQn9heF19kVu0
 CWAjtJC5+OzKK2ZVe9blln2S3hwIBUt8j2whvkGYR3bVdwCB9UifZ5T/N7PMS6dhzEz7
 jr7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgeTwzcm2txIuqVS4dB2RvO5qq1CYyZ8r7LR6Ct6UzQy2h2rI3HEhiReeSbAXr4Chsx3WiBKVc5gDr@nongnu.org,
 AJvYcCX6hO6GPp7VrgjRe+DADOEt14gGtvq8qiNuLrv+OYx8Tcwq9KcAU5Bl1VT+jKRpRgWy17ToHLvOv5HPBw==@nongnu.org
X-Gm-Message-State: AOJu0YyoBjfg1TGSIECxSW6DzervroKOLCOD6mVfGDeyIn/ze85qCIpj
 9yLIiTJZHR/x4TwCmfxFfjXpS94zMq3qWlHnF18p8UuDW1ObX6Wa
X-Gm-Gg: ASbGncs+p8lAYbqzmafFHaWfEfRdr07IP/Jwcnj6gbmHHWNANCmMeizQscAyu44wnKH
 YEfS0uxq+xzAAFhtHXEnfjTKgridAeGZibjx9eHHoOonhTWzYlm7+mz7wywCGWtzD9Ro28XFa+7
 NZog9CkzFwIaE/SfkO/RZxck2BiDAGzZwrL0UZOxBHRiUguTQa4RQBX+PyJCrVmcEHFo37dg21Y
 KdkTHNm6xG0K+xWrAuNrZlHasVzVmLjfqiT8Zlq4AbTACQ0W46QRQk=
X-Google-Smtp-Source: AGHT+IGVsvI0Du9IUYVt/G9wToPsDtm7XaPMN8TaYvC6Ro0UJXiZ8jEAd+Og0bacC8K5bjQjMdnCAw==
X-Received: by 2002:a05:6512:3b9e:b0:53d:a24b:db0f with SMTP id
 2adb3069b0e04-53e12a392ebmr4332734e87.57.1733397798684; 
 Thu, 05 Dec 2024 03:23:18 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:17 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Thu,  5 Dec 2024 14:23:04 +0300
Message-Id: <20241205112304.593204-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205112304.593204-1-baturo.alexey@gmail.com>
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12a.google.com
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


