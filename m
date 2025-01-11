Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAA3E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 13:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWbCh-0006Ne-W3; Sat, 11 Jan 2025 08:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tWbCg-0006NB-Dt; Sat, 11 Jan 2025 08:07:02 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tWbCe-00044y-Qk; Sat, 11 Jan 2025 08:07:02 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so444463866b.1; 
 Sat, 11 Jan 2025 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736600818; x=1737205618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DTL23GNbbRBByuXy/aFHDXRj0rXhaYxBfmQQ9uDFfQc=;
 b=DoMA2ybdoWnGfhI1XwuyhaIqTcCilpKXzHkcBg9VA+r24t6r1jXiRAve7JwJwStfJM
 Fn8/5mVngIOKVIbDcDsIYo0ZmuvFNDlQvkS5znYeF9AMz/kAeOKf7JtX2+OUVUrTq7r7
 0Jl12y/2SQbBuOf/iM7dh/BnyvulijJHI94h0DjXnZXmdWabyh/ZqDEbxvpCcuOOQubk
 y/nQKcuyAC2FYoQ9jSfwX/5Rqjaq14ravG5OtIzNHmQRkBcFBF51LZxVCaGUkMwNtOzk
 L0aZKJ2xIw1OpiCp7YupmUubWsT1ruLdSEfvdxRwCu7PIBpsRdxifdkFPBjDimtqNmrF
 7xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736600818; x=1737205618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTL23GNbbRBByuXy/aFHDXRj0rXhaYxBfmQQ9uDFfQc=;
 b=CfAVKjNBE0/fgAszGMhaoB886dFxp0bkIg3iBebSwKRpRn7hcWrsPrjH98ze8nN7h/
 L078CX9vm5Qcq9B658qv6PHWz9e6wWR4L4q+F0OAN7lKw4h5sRDwp9pBwUqxw2FlvcXG
 OGASEPbOTuzd6lSxu3qjl2+dQri+0FtZurH5Xsqnop0ziOA2xx+Oo/yIEakfktp+xJXB
 opqRFiHZpv2iHOF4Hnr9LFD2MaMZhtsR2y1i3UwoMpyMjXjpH49uQNITMlG9GPShbxnr
 E0Wz+W1lzCAG7bRDT2H8+NPS/emVA5CH1F9L98nNRoIc6cJgJCtsv0dn8dijb6mtoj5D
 d8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuYS4ajy+5Xif3nYQ8I0CuxnG4n746/lMtghaJARbucSejTgIHpol77BBkWlOi8wBW6/zSe8+x+a9n@nongnu.org,
 AJvYcCWW78QLskdlLuOY/epxtWPL4qdnIRFSJ/o306DOZwuXeZqSR6apaMM3m4TY9EN1fEY/U88OhLCz1hYmlA==@nongnu.org
X-Gm-Message-State: AOJu0Yz9bWBGQyVFrHoojSblsRu8tmYflcvE9KI8btYI63y/g3N53El0
 gZnh2+YL8XLYN1Cnx9mPmmRGpW5c1UyS6IaJyOyimRqp3dVITv03
X-Gm-Gg: ASbGnctOIWwn5ynsh3ZewJgR5rLqXrUXb9weU47t+HSCNuMj/NCUhp1P9Kgvkye+OC9
 m22zhrZRElknD5uu0cRRKT7IIpBoBGWBCzQH27PMz1l7KWUFSTBzGt0LCEo1DKQxqm1TnDka1Vt
 QxkLD8sBHHf5/zPQLzwJQdhbn69IsCzCW39MO8NI8GqWqrnAGYoslswtb+uReJ9Jf9+tMCIKJ5p
 7cgTuTl6oZq1vPZ3eJh/nbmu3stTmAfud2iGzEGeLCTNGH6+KzQax9Nitvd
X-Google-Smtp-Source: AGHT+IF6nxv6IIKS/DP3vYyLLcQAV8Ip9d7BnC8LXyJn7sDoLIyYNUBYjAVJy1U9ZZKZcGXdjbYJ8Q==
X-Received: by 2002:a17:907:6d01:b0:aa6:730c:acf with SMTP id
 a640c23a62f3a-ab2ab6fd01fmr1409885366b.13.1736600818207; 
 Sat, 11 Jan 2025 05:06:58 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95624ccsm268088666b.126.2025.01.11.05.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 05:06:57 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, frank.chang@sifive.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv: Support Supm and Sspm as part of Zjpm v1.0
Date: Sat, 11 Jan 2025 16:06:53 +0300
Message-Id: <20250111130653.1239737-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x630.google.com
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

The Zjpm v1.0 spec states there should be Supm and Sspm extensions that are used in profile specification.
Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enables only Smnpm.

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.c     | 23 +++++++++++++++++++++++
 target/riscv/cpu_cfg.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dace670e5e..8c5801b87a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -202,10 +202,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1612,6 +1614,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
+    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
@@ -2756,6 +2760,24 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SUPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_supm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_sspm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2774,6 +2796,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
+    &SUPM_IMPLIED, &SSPM_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ee7c908710..76579b9b95 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -133,6 +133,8 @@ struct RISCVCPUConfig {
     bool ext_ssnpm;
     bool ext_smnpm;
     bool ext_smmpm;
+    bool ext_sspm;
+    bool ext_supm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.39.5


