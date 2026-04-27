Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CCBFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAR-0005YR-BA; Mon, 27 Apr 2026 02:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAE-0005Qk-L6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAB-0000qK-Tb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:50 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-358ed696623so4327923a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270186; x=1777874986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26PwWc6Uw9wIukcpyprTDSpNWWjqEPtct/PbwQK4uCs=;
 b=T8xx0fTYvjNRryl387Mr3+AjHD2Pu0yX1cwgJGuptsnrBt9cQrkkRXCQi+o1rVaW5L
 p1FqLqiqyk85PMKCFtvBlC9AkSKMIuh5WUUtlB7iy3ATkD2c6rigqXehYs2tUbgoTnJo
 WDtAOjkZxG19hFpZDJdUMeK2LkQ7vXLvsWvysz+w9HwdcEhtTitRPpN7qcHJ35LNC99k
 q19K0gKUoFl8WASP5DgcPG5D/KLqZ0iL/H51QKdkL2uHONGRI43sYoZjgif3RTjrTf/U
 DWJdpHr9m3qx8Ea73f6YM07AxSoJErNvWBWQWK8L+AStj1XnBLVYax9CLyMW6EBEhCs+
 Hn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270186; x=1777874986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26PwWc6Uw9wIukcpyprTDSpNWWjqEPtct/PbwQK4uCs=;
 b=MmloVkL+F1X5Pm2k8Bq+ShJvGCmHLmCncJyc9LGh920AjO7PX4miRtczNNdENP1bH/
 AsSHAqADgbIxcY/Y6mlH9nac4d8bxsFmXfr2k4RBkdHgTYA3w4k+iqg7a5ffNpiSl70R
 gHDYcDleYGtNSDnrVwDAmvndlzRu5WImMBk6gGXehOnSwZgCahFrvFUulEfyqI6zrKbR
 jrU6ob64/PKCTHZEL2Mnu39ZjMRvshBqgeYd7wFtAp2wurngqUZyr7FwUZ1sz+vffcOq
 ZzcIct6pVM7SnmSil+xQmuogWM9dRhCqkUt2uIelib0HPHqQNUrV3N3lfk1TbhLl1kuE
 0Mgw==
X-Gm-Message-State: AOJu0Yyw3mVKWyd+vCZyeBcnQujFtpyHBE4pHNpB/ogxkyWbYP9Zn2hK
 xmySJxdDghW2UI5jlCfT+dRTnFusYvLVzVdryY7PMMtuGupeRvtMai++XmC6jtGK1dYKczwCSzw
 QNJk7d0ZcU1VyrIYU38sfFBnCwNfTWFK1G2N+vokmrskpjOevXO1Pci1kLOe+m9CGLuEvMQA5Qi
 UPA6x470XXQu1hDoyR0dbRqiR7Pfp56Gy7d15maQM=
X-Gm-Gg: AeBDiet62Z+6bB2h8vYGeq1bOXWhywdl9oJ8GB2eVi3BajfvVz8X5mi5cL1q5G1Ij6u
 dOJ5Gd/HVot0x6IYKDqusmSC45KVQOoNDgWtBYttFKrIPv4QPAUMXvd75mzlmEgDYXHIQ1nrM0Y
 dsBn6X3c3g37Ff6tOgo8Gdq1j2rpQ0wjFYEHNRZ9xthnQDYmBRmBMj9GSKNDbTW+V+aZN3OXkjY
 ry3iC++BfGFWnbYWamAw1NAujQ4nXd/PZkisNba+WBkPEYDVq4M9gXLD/9iJuEybzzag7vSGEbZ
 eyRUrZYjpaj7kBXBtV8ewh1E9dXArI2LJA77sgepMTj+Gu16PQoQNpdnGOL0/SWTvGQOzO4mbZo
 JDN5u9CF3NmomOPT+bYWwlocPYj/6at62OX3UYhqQqA4sMUertzF++qGoWfL/+82pAddBPJ2SRm
 CZLYGVQ6xF/gnPy9CmNdjGQX5d5KO84hvDILgPuLRT8WqlXZb6TNtnv0LIshHrR3eVWGwqvWGQb
 gvGUFwQvwdIP7ogke+4r0A3bzmCQnaOWhMA8Q==
X-Received: by 2002:a17:90b:4e85:b0:35f:bf23:bd78 with SMTP id
 98e67ed59e1d1-36140461d2dmr42140242a91.16.1777270186156; 
 Sun, 26 Apr 2026 23:09:46 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/9] target/riscv: Add implied rules for Zvfofp8min
 extension
Date: Mon, 27 Apr 2026 14:09:22 +0800
Message-ID: <20260427060928.2322570-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add implied rules to enable the implied extensions of Zvfofp8min
extension recursively.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 855c6bd4a9..3746c79b01 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2512,6 +2512,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp8min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2649,8 +2658,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
-- 
2.52.0


