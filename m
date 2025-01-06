Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B05E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHd-00077y-PM; Mon, 06 Jan 2025 05:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHc-00077I-L6; Mon, 06 Jan 2025 05:24:28 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHa-0008Ra-TU; Mon, 06 Jan 2025 05:24:28 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53ff1f7caaeso15322082e87.0; 
 Mon, 06 Jan 2025 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159065; x=1736763865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/1QUzYLgz99PchUz3PElGeEu7NEU5K+UpMZKTS1KkA=;
 b=PjFfEv23kvhtMH7fWxMp6+rxMM0BTKBtyuArZ9xJFg5IdCIyaPgdOI6f2uHeBGMYgQ
 PkhDMz1XrqrQXSyQEN54UChjkuNPtS2SagF7PV/v6lITEpX3mdrZtHfJFqnJdvhdppBG
 F/NgAIjHpHxpXDLOdRBhhM4OOJkstO8yFBnlORu2dS0eLkTB/r2Wr/xg5oPQrkB2X1ss
 oYpRnXE0mnruSGGnKGgnhrKl6ojh6NMq6zLhavX9fMPHZSpHfmUr2LcfqT5aTbIMSVN7
 ARY6yrut8J5Wz+Qk+8hgzSJ0J//3aM2mL/DShIaMoq+zlTjBh49oZmEt4L4NklGwgzw9
 69iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159065; x=1736763865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/1QUzYLgz99PchUz3PElGeEu7NEU5K+UpMZKTS1KkA=;
 b=oExF6IxVx9OjKAQx54zjqKPTAsNYIPK6d4UF42p/Iqm79xc0Vecs3hHqNG7lc1RnlV
 1cXY/aIusKc6ukamSdrKW0AZUp3EE60xIWuMBoi7vTTpnPi5lnhkX+zL1Vx8ieZKhbBI
 hLeFuC9bD1uJsl8jo19nwENuh8Awvln+5HqR58pITmbwqhI/IHcNGuhqUfit9WbSDpMu
 nje00jn3edIsJx7LSTdF0SiuajzGmGDw55j0PTuLgJrJBOi9EE0szOrb5sCeIxjBRnOv
 rUmE0iuUw2n9iYMKYVB0zp0tSCkGG6Psyn30mM+VCMGhMocxi7w6M/ib96Hfuw8WKn8v
 KJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOTOk7XX40t3U+RIo5xJ6lruikofPfhLgVOpxrFFdLbkCgCY/tIMsEzLZpRSgRCmik+KU5ZdS0/XlC@nongnu.org,
 AJvYcCXlpdc/9L2vq6SGBphlL1agtSOaS1dfFiQ1oGYGTRKHxnfPYyhJjNo2OGLKzMMXRsnljV5VKvu5Un3Jvg==@nongnu.org
X-Gm-Message-State: AOJu0YxOWF5aKr0c+TJBbyFBOIoYRfM2rDTw8S40jwyK66B9aJFbKHUS
 p8uzmgLtJ4HOvBt4wis1rwkpaJ1YU5CCxY3RCWkD8TcVz2/yDOtj
X-Gm-Gg: ASbGncvMAcKqK2QAT23372fJvLAuNFmEZXFOJjWqmdv8rlt1YZzLHRWAKet45mbjbdT
 +7Qj+QWnnM6sdb0lTnmlcM/xkv8vehcDA6OwTtvE5vSJppi+jflfM5AIRb77b8i75rCw7Ghf3Cq
 VE3ObEMbzlPHWY9E9oHPpeX7OK+VUEJlEXqj4wekrZVvIGDpQsySD3LheqH/YpGpCesliC1X/2I
 YvXFQFToT6wIaw1Z+j/yqPwkZoW7/vveAOIkQHOFrcDZ+Y4qtNUQeU13YwL
X-Google-Smtp-Source: AGHT+IETR/VpwelHyMxRHDRGUKBB/4d0DdgG9AOoWN/EqbncbWRKIsQTaMAfgRmdev/sVr2QRzqEOQ==
X-Received: by 2002:a05:6512:3f26:b0:53e:39b7:54a3 with SMTP id
 2adb3069b0e04-5422953ac26mr17852675e87.24.1736159064644; 
 Mon, 06 Jan 2025 02:24:24 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:23 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Mon,  6 Jan 2025 13:23:46 +0300
Message-Id: <20250106102346.1100149-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x135.google.com
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
index 99588e219e..d9eb2c04c3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,11 +193,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
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
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1595,9 +1598,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
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


