Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4567AC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPI-0005jD-Ty; Thu, 15 Feb 2024 17:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPH-0005im-8y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:39 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPF-0006Au-Bu
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:39 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso1331874b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036835; x=1708641635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CsWvOXHpBr1HttAj6uXJd5rnav59pXwvFvHFD69ko4=;
 b=oN4OeITkuNoXZzF0wCfgv5qGmsS2ewzb92mc2xFjaPebHCtbXBGTOMsHSNUNsIFkLM
 DfkQca7LGP8zKA57O9zOlf5h8kC6w+VqBJfUKb+uQ7M4bIJNWpCN91AFjjiAXqNhSBXo
 pK8Qyykz7vl1/17gGVtaY2m4wZZIUUjLJzLJXqmRGB1fzVRG7zpVtZNqz+nWtHSgiWFm
 B16UmEkza9nQnowkY05Gi4u6stTaoTKx91HOruDmHA+GsM/ewRrIXukr2ir820Mx5VbV
 +Cyh6F6IJPJ6lSsxTKjTGXLbrwCxRvahZfLHdtNtUd5RMMrhn3aWIYkeN6Qwe/3IlNp6
 0nEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036835; x=1708641635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CsWvOXHpBr1HttAj6uXJd5rnav59pXwvFvHFD69ko4=;
 b=EwWALZKNnWX/yma6/d0aZpQ7A91EmqIvNzHm/raibG4akgc0Ny8fgBrcgV0751/Ye6
 se15NggvyP2LqPSKyn11XTXQyivnUiVMixtyjMfToo+8hy8lhNsKyAramwqQAliNrHUB
 cZCP9l+P+QMiw0cv7ENgFpPkWK41FFtmgnb4zUEupFPGJvfz32mpuWLwNPGXFU8p3uTo
 b9rej9X2QbDzWg9BYDh+8knGv33iCpiuUTzkStHq8tQn5NZY8ylMZQyD/kMtNAZI/raV
 W0wXaLSUPcofkb4G4ezgVqtzuvBSabM819sC4Tlrw7aFd7JRoP/9/TwF9sRr/n/YQ8l2
 HgoA==
X-Gm-Message-State: AOJu0YxFqIG6tNeZhllgDPk6+xdUK3tIS8AntqaOrNReblVhrY8qTyui
 W2RfKRc/c5McVz3oZEIDcV+HHspL2EnvuYoD3i25LniwMybobXWhTDSfiqKtsOuW3iedhzr6wXV
 2
X-Google-Smtp-Source: AGHT+IHez7m/a/eYG0URWGpoKTJYiySOdUc8WJ+eK8KJzwktIFJ7N3anedypP4R11z2PXi9e15bIvw==
X-Received: by 2002:a05:6a21:9212:b0:19e:9b8e:8bda with SMTP id
 tl18-20020a056a21921200b0019e9b8e8bdamr3813873pzb.42.1708036835119; 
 Thu, 15 Feb 2024 14:40:35 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 3/6] target/riscv: add remaining named features
Date: Thu, 15 Feb 2024 19:39:52 -0300
Message-ID: <20240215223955.969568-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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

The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
until now, we were implying that they were available.

We can't do this anymore since named features also has a riscv,isa
entry. Let's add them to riscv_cpu_named_features[].

Instead of adding one bool for each named feature that we'll always
implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
named features will point to it. This also means that KVM won't see
these features as always enable, which is our intention.

If any accelerator adds support to disable one of these features, we'll
have to promote them to regular extensions and allow users to disable it
via command line.

After this patch, here's the riscv,isa from a buildroot using the
'rva22s64' CPU:

 # cat /proc/device-tree/cpus/cpu@0/riscv,isa
rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
 target/riscv/cpu_cfg.h     |  6 ++++++
 target/riscv/tcg/tcg-cpu.c |  2 ++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9e66eb61fd..f424751962 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -102,6 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
+    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -110,6 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
@@ -173,8 +178,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
+    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
+    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1567,6 +1576,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#define ALWAYS_ENABLED_FEATURE(_name) \
+    {.name = _name, \
+     .offset = CPU_CFG_OFFSET(ext_always_enabled), \
+     .enabled = true}
+
 /*
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
@@ -1578,6 +1592,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
+    /*
+     * cache-related extensions that are always enabled
+     * in TCG since QEMU RISC-V does not have a cache
+     * model.
+     */
+    ALWAYS_ENABLED_FEATURE("za64rs"),
+    ALWAYS_ENABLED_FEATURE("ziccif"),
+    ALWAYS_ENABLED_FEATURE("ziccrse"),
+    ALWAYS_ENABLED_FEATURE("ziccamoa"),
+    ALWAYS_ENABLED_FEATURE("zicclsm"),
+    ALWAYS_ENABLED_FEATURE("ssccptr"),
+
+    /* Other named features that TCG always implements */
+    ALWAYS_ENABLED_FEATURE("sstvecd"),
+    ALWAYS_ENABLED_FEATURE("sstvala"),
+    ALWAYS_ENABLED_FEATURE("sscounterenw"),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2171,13 +2202,10 @@ static const PropertyInfo prop_marchid = {
 };
 
 /*
- * RVA22U64 defines some 'named features' or 'synthetic extensions'
- * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
- * and Zicclsm. We do not implement caching in QEMU so we'll consider
- * all these named features as always enabled.
- *
- * There's no riscv,isa update for them (nor for zic64b, despite it
- * having a cfg offset) at this moment.
+ * RVA22U64 defines some 'named features' that are cache
+ * related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
+ * and Zicclsm. They are always implemented in TCG and
+ * doesn't need to be manually enabled by the profile.
  */
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e68a4ddb92..be39870691 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -128,6 +128,12 @@ struct RISCVCPUConfig {
     bool ext_svade;
     bool ext_zic64b;
 
+    /*
+     * Always 'true' boolean for named features
+     * TCG always implement/can't be disabled.
+     */
+    bool ext_always_enabled;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2307999387..ea763abb31 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1315,6 +1315,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    cpu->cfg.ext_always_enabled = true;
+
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
-- 
2.43.0


