Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFFFC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPF-0005iH-TS; Thu, 15 Feb 2024 17:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPE-0005hV-9M
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:36 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPC-00068m-C0
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:36 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e1126f57f1so870632b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036832; x=1708641632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLxOAs6WQfZUlgTkvilwCJDAQXlQdmJsupkbv8PC6m0=;
 b=dbXefY8+i71QXXOewQtCGNfvPE8WMSIejlxvVQYX2ydTOfEiUeUm0vRRrzyHe8X/Xe
 AWQjvlWTPiW7VnxiZT47NME7BlAvLirdoQxYu9v5ePfnonWTO0C+/Z85kZRGuHqrZf5O
 P9n/VkGocO1ySgSVFZCpOU72nqxA2d4F7vE/e4F2rvhMumOZWxR/aWLUroVX/Mdiovbw
 OwA0DDskUDWN1qig2PaQpjOkIEemydG1wqJC3+uRmDBwcyp2p4Kb9vNLrDLbRRBRrTi/
 8Ys3DLQ3Ib5s/H4VQfrXggZo3eoY7kVf2PHa9tGTscI72kpTjdncKtEe0BenzEBRfeuM
 QOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036832; x=1708641632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLxOAs6WQfZUlgTkvilwCJDAQXlQdmJsupkbv8PC6m0=;
 b=uhgGG6TrAOqAc7F8oAHiL8fWCrNnaE4lY0FjeZ9wVQGSDlhvPXoU+DeCgoStVLXtJq
 7euN7E5F/7D5eYjCxIJecykb+PMUlPxO6aidSkjN2FPcBtNDK+HGlwEF4NhYeuYxHUgD
 CMM/SNt9vY9qUIsOf1SacLPL66ufdDkfnOVDbB6BIoPQ3JOaztQzsgWoL++M6oVJoGso
 PIEkGMe5NNQeU4PWH0/vhrlluoqJow9h04JuQU6ADOdFnhx3xfJW807+O55EIa5xOBmz
 dtLeqj6KBrqOqB3fAvm0NCCilHzWOxVbhnwSk3BLUBZq3o9htdjkl909Ba3Y4wmPc7/I
 qrJA==
X-Gm-Message-State: AOJu0YxFShPmhUTIQARQnjZpuOKBMw1tM4mXZGngl8ouusNO7xErQHxY
 3kY2gaa2UvXoy8l/GtQtyvOTT9JLxq9KBj+32LCNwfpyFuIJzzSFCXc/l1rQ6dX+12IixH5eB/z
 O
X-Google-Smtp-Source: AGHT+IE7ab5c/gkKDwSMslcc6juE6vWFquZ1klSZzs1JWkHbr5tL0LoK3jD1/KLBFAMqgmeSSc8Reg==
X-Received: by 2002:a17:902:e744:b0:1d9:5d56:9f1f with SMTP id
 p4-20020a170902e74400b001d95d569f1fmr4201739plf.24.1708036832053; 
 Thu, 15 Feb 2024 14:40:32 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:31 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 2/6] target/riscv: add riscv,isa to named features
Date: Thu, 15 Feb 2024 19:39:51 -0300
Message-ID: <20240215223955.969568-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Further discussions after the introduction of rva22 support in QEMU
revealed that what we've been calling 'named features' are actually
regular extensions, with their respective riscv,isa DTs. This is
clarified in [1]. [2] is a bug tracker asking for the profile spec to be
less cryptic about it.

As far as QEMU goes we understand extensions as something that the user
can enable/disable in the command line. This isn't the case for named
features, so we'll have to reach a middle ground.

We'll keep our existing nomenclature 'named features' to refer to any
extension that the user can't control in the command line. We'll also do
the following:

- 'svade' and 'zic64b' flags are renamed to 'ext_svade' and
  'ext_zic64b'. 'ext_svade' and 'ext_zic64b' now have riscv,isa strings and
  priv_spec versions;

- skip name feature check in cpu_bump_multi_ext_priv_ver(). Now that
  named features have a riscv,isa and an entry in isa_edata_arr[] we
  don't need to gate the call to cpu_cfg_ext_get_min_version() anymore.

[1] https://github.com/riscv/riscv-profiles/issues/121
[2] https://github.com/riscv/riscv-profiles/issues/142

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 17 +++++++++++++----
 target/riscv/cpu_cfg.h     |  6 ++++--
 target/riscv/tcg/tcg-cpu.c | 16 ++++++----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b8d001d23..9e66eb61fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -98,6 +98,7 @@ bool riscv_cpu_option_set(const char *optname)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
+    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
@@ -174,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1565,9 +1567,16 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/*
+ * 'Named features' is the name we give to extensions that we
+ * don't want to expose to users. They are either immutable
+ * (always enabled/disable) or they'll vary depending on
+ * the resulting CPU state. They have riscv,isa strings
+ * and priv_ver like regular extensions.
+ */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", svade, true),
-    MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
+    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2185,7 +2194,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
 
         /* mandatory named features for this profile */
-        CPU_CFG_OFFSET(zic64b),
+        CPU_CFG_OFFSET(ext_zic64b),
 
         RISCV_PROFILE_EXT_LIST_END
     }
@@ -2216,7 +2225,7 @@ static RISCVCPUProfile RVA22S64 = {
         CPU_CFG_OFFSET(ext_svinval),
 
         /* rva22s64 named features */
-        CPU_CFG_OFFSET(svade),
+        CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 833bf58217..e68a4ddb92 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -119,13 +119,15 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
-    bool svade;
-    bool zic64b;
 
     uint32_t mvendorid;
     uint64_t marchid;
     uint64_t mimpid;
 
+    /* Named features  */
+    bool ext_svade;
+    bool ext_zic64b;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ee4c349972..2307999387 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -197,12 +197,12 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
 {
     switch (feat_offset) {
-    case CPU_CFG_OFFSET(zic64b):
+    case CPU_CFG_OFFSET(ext_zic64b):
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
-    case CPU_CFG_OFFSET(svade):
+    case CPU_CFG_OFFSET(ext_svade):
         cpu->cfg.ext_svadu = false;
         break;
     default:
@@ -219,10 +219,6 @@ static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
         return;
     }
 
-    if (cpu_cfg_offset_is_named_feat(ext_offset)) {
-        return;
-    }
-
     ext_priv_ver = cpu_cfg_ext_get_min_version(ext_offset);
 
     if (env->priv_ver < ext_priv_ver) {
@@ -322,11 +318,11 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
 static void riscv_cpu_update_named_features(RISCVCPU *cpu)
 {
-    cpu->cfg.zic64b = cpu->cfg.cbom_blocksize == 64 &&
-                      cpu->cfg.cbop_blocksize == 64 &&
-                      cpu->cfg.cboz_blocksize == 64;
+    cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
+                          cpu->cfg.cbop_blocksize == 64 &&
+                          cpu->cfg.cboz_blocksize == 64;
 
-    cpu->cfg.svade = !cpu->cfg.ext_svadu;
+    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.43.0


