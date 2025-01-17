Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E88C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfM0-0006FK-P0; Fri, 17 Jan 2025 00:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLy-00060s-Mr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLv-000604-8l
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:10 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21636268e43so39492235ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093426; x=1737698226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq4RSLZXDi63xyFocOIIaz34yi65GouxThrjokqGo2Y=;
 b=BvtIF9XAJiLsXZAGA8fcAQgMgy+q3h9px6NHGG/Dx++QwtZANR77m0KnCe1NXuVfMu
 sxgQ8JMPZE4QdQWhPDN2npmn4sOXih3djAdfhFgYF9Z8IGEDeQibyMX0PLAJexauEmZj
 N7SCGk73tRfKyE9WtdEwuYzCAd/gL3hU2LQqGBJENdXNAzQu78KLXUewjfAEOnaf8WIs
 +HqNaNmdbaq3/XyKjPXt8W6e3doL5CEex4fjL3qSxTRNzQlh9xj9Jq6TRrfyL5/v55ti
 ReDeWw67vWA1CUARcsUafY5bz1dMySHQw8KFcbnYi6FF3KoCc1wPbx5cafIi2qH2PoyZ
 sq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093426; x=1737698226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yq4RSLZXDi63xyFocOIIaz34yi65GouxThrjokqGo2Y=;
 b=k65DSi0T9wrnp8Ta6diFOlKi8A2wVfxdrJZXy/d5ad9AOjLGLxalf3XRShl4rraFys
 9nqFN14LKhKQFmGxDsewEhuFMqPtb9JkmTsWNntD3d1MrmyFKIWe07BD2Y2IjaoCKLWH
 6wWD75bnATwagYhtGBAVEpF07b6FHVy0de7buODce7LZ2Npq/hl23g6CjbUk9Owuzzkk
 uEevg8XvdJJT4BgZo/uUp3C2z7iQ6ZC/de0f0td6+IfPD3J+hri57WEpfECzEv8QU0ra
 Tpe8Gt6SRT5oIMyTabglWodZ/2TrgCUpyJWr5BY4yMJz/+ZmTsx1mIYQLfuurVhd/KBP
 RdgA==
X-Gm-Message-State: AOJu0YyD/lZqErl7bOlZfQ07Fzd8uQ5RGTcX6p/X/8p1yQuzanPptajj
 VkeIoieLGmNWMI4gqoBCrRWHU6DrYR41jkqQtsoF6b2P87dob18yU+Erxg==
X-Gm-Gg: ASbGncuTmyCzrRK+VUVuemurbXXPVzi3LN4M+BowkHwLAhqnhAoc61Z+EwfTQv5GjSE
 u6rEM7NSFEeGyPJ7Xb+56M9Mzf35etZBYDy4BhBVXstgrJYrfNzlVGqFwsy/E1O4ZxGt2PAPrHd
 WBjYu0VhkA8uIcT+xSf2lOm4DqoNDuC/q3JBMVb+pZDkeY1uSH3LNtLsdq2CnHOuMbUY5De+Y3i
 H+MdzLnTIhbaNAptj2bPxBDk3RloDv+SiMBSKdye6jFKI7XgCw9PPrRSvlFPkcLldhAHnO4HLuB
 fb7tF4Yp95IMFb7CZdVvqQWVha4s+nHqw85fuH0F1eKMxP4RHMOiMvkQbXsE
X-Google-Smtp-Source: AGHT+IEECmNnP+fjmd6CzgNmBMjij9Zu273oSbIFyLhzDcXhR5G++WRUPV8a1bHz3zwoLGRs+FHV1w==
X-Received: by 2002:a17:902:d551:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-21c35562974mr23282575ad.26.1737093425801; 
 Thu, 16 Jan 2025 21:57:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/50] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Fri, 17 Jan 2025 15:55:21 +1000
Message-ID: <20250117055552.108376-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-ID: <20250106102346.1100149-8-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.47.1


