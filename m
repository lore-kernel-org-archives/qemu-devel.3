Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A15D637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0R-00009o-AA; Wed, 13 Nov 2024 12:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0P-00009M-Nf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:13 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0O-0003kY-7q
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:13 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so5985467b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518290; x=1732123090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxOZ1xHRmyOPMiXb0/ok1USMd7LW6yZMmDme9/JAjGU=;
 b=G33wVJdW/c/ZUP8X8Xa6Nsy2UDU/OAEqh3BQ93vPsodEhjfJGXc+NSX3KGP2rwxKtX
 JwptIwrRgcMuzJ2JMrO2qobLiYcz88E3Xb5SsjNspEkLCJtzts6Fd6cmP18Nr4GU3HmX
 sE5ERZ64HuXWCCJUz87AzdMl9WLMbWEqMffEqBNWnudSVPCt1aOH1RwJo7TeBeKCJnLj
 MwDWuMs0vRxQPaDLs7WYLNA9qk/IOrElFNoqObzNoyljBj654rOokwkR5gH5E7kQsHbo
 xyiMpFay+lRmvM7iUFVJhtzpRwYlWs+wW7vohgHTPDfp7Lmhh17Rfo1aU7m3BLHLeMnU
 TpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518290; x=1732123090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxOZ1xHRmyOPMiXb0/ok1USMd7LW6yZMmDme9/JAjGU=;
 b=ZGdyF5p6itVG6kEbpQTh+2RE0GGpjpguua6S6S6vg+LG6b4jH71L5cUOyobrbK3Y0Z
 rnd/i/RriPZVFQY5eRvZt1LvAZ6DNCsNW9mCwFSze1hPK43PLpEcmgYxKFeDPS0qZGyf
 WPqQikUbV2uZX3WpshQXZFP8Wc/uIwrB0ej36O7TUm3wyd/hjQbjoUz2c8sbVmY73VB7
 p5Lc1CA5Gq6JzDm3fenWmGVbyIJ4bjI4mkzcZFD348vOIImgyjovuwRScdlbL/UJXzXd
 CQYdl/g/GxcHRZjoiHcfL6OpR9guci38Q7CLnPThuH+4QuwWSo7CpLli5cE3OFCFycJj
 Z7Iw==
X-Gm-Message-State: AOJu0Yy8FQAhxRgwrEQ9CJiIqdL0IOE8kmu57KZABCJGdqH+i4eV008L
 m/hsiqfjPdgow1brF99FpuIpF6nIvEwjXmEb/vMy/KGHmAnb4ikfpYWi0WIA+Q+4xnaA8Gjec4O
 G
X-Google-Smtp-Source: AGHT+IEeqllOGf9YcxQRsEgnC36t3oHcOCNhwh+pK1pzVtheB/iMShil1/IAOrcvAJ/gFJV/6cb8NQ==
X-Received: by 2002:a05:6a00:3d55:b0:71e:695:41ee with SMTP id
 d2e1a72fcca58-72413278a86mr27996285b3a.5.1731518290187; 
 Wed, 13 Nov 2024 09:18:10 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 2/9] target/riscv: add ssstateen
Date: Wed, 13 Nov 2024 14:17:48 -0300
Message-ID: <20241113171755.978109-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

ssstateen is defined in RVA22 as:

"Supervisor-mode view of the state-enable extension. The supervisor-mode
(sstateen0-3) and hypervisor-mode (hstateen0-3) state-enable registers
must be provided."

Add ssstateen as a named feature that is available if we also have
smstateen.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..4ad91722a0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1607,6 +1608,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
+    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..c7bf455614 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,6 +139,7 @@ struct RISCVCPUConfig {
     /* Named features  */
     bool ext_svade;
     bool ext_zic64b;
+    bool ext_ssstateen;
 
     /*
      * Always 'true' booleans for named features
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cd83968166..0b9be2b0d3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -204,10 +204,15 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
       * All other named features are already enabled
       * in riscv_tcg_cpu_instance_init().
       */
-    if (feat_offset == CPU_CFG_OFFSET(ext_zic64b)) {
+    switch (feat_offset) {
+    case CPU_CFG_OFFSET(ext_zic64b):
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
+        break;
+    case CPU_CFG_OFFSET(ext_ssstateen):
+        cpu->cfg.ext_smstateen = true;
+        break;
     }
 }
 
@@ -343,6 +348,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
+
+    cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.0


