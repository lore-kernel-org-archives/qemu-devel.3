Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49394CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDR2-0006lP-5U; Thu, 21 May 2026 20:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOb-00036v-KS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOY-0004nU-1L
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso44354365ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408340; x=1780013140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvgQ3SIrPPZ8T0yCu4IDyagYFjJlOwUgr4MgN5+Ms4o=;
 b=mEyK5lqteRAjjQM+DMGPbw55N0b5FOz4JzYKl/Bnd2rAdSeaGju7PAW2RxiVjY+cD3
 HUhx5Au01YCDAfcBF+7WtOQSetYKmMfZ/33E9C9Lh/xXKxgcvLZAoVwfT7N8MJiAwQ8p
 eZkfc1xOdczwUWyOZE3cUa7wGTlEHldkFDZVDkTZAiurSiYCNieGnN3nSW12pxnX/gDe
 /QTfuDzbEYyt86bBgil5LXbGxM5306Wb0kQX1PaQsmMuIlO+6ONAJ/NZnGT0m+zYiYJZ
 zZsx7NWzs4DanajOq1wBvh15J6k1WozRUBwWLWEaMoPHZfKdN6t6NxW8yebjEeGZImH0
 VH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408340; x=1780013140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VvgQ3SIrPPZ8T0yCu4IDyagYFjJlOwUgr4MgN5+Ms4o=;
 b=JrdbotB+tseAf+EGjbfPKfQ62+9ppztU3qomQoOtWaMYC6p5D5oVA7O+/Ti7XfeC7A
 oTsZU+b1PCIc7VaD/VuA5qr49lc0dZmKDs0HlGoLXs9FGkt493iCPpA4lLvkIf/oi6mi
 xfTYzPU3hyQNDx9S/FWNhvxrrEeVg8ypex4hsURwfl2swxOrfIK4HNeoWgniVYOo03wx
 Cy9WHayW7jqsg5Y7DGa+FNxRjmBkjZgyF1PC5pD7FzDMh0tGWx9Yb+sL6yiY6YEyaKof
 hZI4zhkp6XK6/WMN84efvXG75mb2Wg9mQoxBrl+VRlmJGVMlIUWtA7Az7zmDBqzDTzyp
 D9ug==
X-Gm-Message-State: AOJu0Yzf2V077vTB7+MZ8S2L46/19/qcvHAn1C97TWWSZiDlOo4PMouP
 JWFduImzp6EdGy9/FztHppZyq+CcHLYaIWfj8YSxc5/PhQBNhAv3DJLOsDeIc+1Y
X-Gm-Gg: Acq92OEqIk511Jz0lXGPRzsJYLnNDq5lp/Ezl5FVyAWjFmqldiVqGhgio5MdNdGHEGK
 ezoJ5InX7T6MxBmPz/I14GGirDeo/4eEN2CBYCz6uVVM2IBHPoTd4jwvuqh+2V59X+6L2DtXvym
 kvdA7cNEpUm++/nBhJ5xwBBJif+ZCXpIrb25TEee4Ml1NGTpoRR1SJuiFlL9AWIduQJAC5D5Od9
 yV+1RG2vyq+YOqV196X39D9Zptv22211lbHGbPECu5fZGPmuPzGpPTSXD+xqbGbuXONL2ddGV8W
 gEhhn3xNJ5XgIsmQgTHiVm5CODt+4UJzd1b0Vi/o7GSL4sNqaSOi9cm/CBaQh2bNEZYNwZsHvlr
 we/6mGw5tjX0azkzAd+58BTR/rr1fOkmaT7rHfgp+DIgf/9YH86K7jKBiz7PZu9ew3t9QG9AGZ+
 Iz1MMwalmUZgLVFP3Gcv0tBce3oLDxnsdj3Pu6Sx7mcA==
X-Received: by 2002:a17:903:17cc:b0:2b9:cd2d:6f13 with SMTP id
 d9443c01a7336-2beb0722d9amr10920965ad.10.1779408340012; 
 Thu, 21 May 2026 17:05:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/48] target/riscv/cpu: remove riscv_cpu_* arrays
Date: Fri, 22 May 2026 10:03:15 +1000
Message-ID: <20260522000324.23255-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

There is no more uses left for these arrays. isa_edata_arr[] is doing
everything we need, making our lives a little easier when adding new
extensions.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-15-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  10 ---
 target/riscv/cpu.c | 159 ---------------------------------------------
 2 files changed, 169 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b1bd69d4a9..7d79c7a5a7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -983,16 +983,6 @@ bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
 
-typedef struct RISCVCPUMultiExtConfig {
-    const char *name;
-    uint32_t offset;
-    bool enabled;
-} RISCVCPUMultiExtConfig;
-
-extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-
 typedef struct isa_ext_data {
     const char *name;
     const char *prop_name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5d3383f335..862834b480 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1252,165 +1252,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
     return val;
 }
 
-#define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
-    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
-     .enabled = _defval}
-
-const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
-    /* Defaults for standard extensions */
-    MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
-    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
-    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
-    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
-    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
-    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
-    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
-    MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
-    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
-    MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
-    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
-    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
-    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
-    MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
-    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
-    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
-    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
-    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
-    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
-    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
-    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
-    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
-    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
-    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
-    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
-    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
-    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
-    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
-    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
-    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
-    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
-    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
-    MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
-    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
-    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
-    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
-
-    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
-    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
-    MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
-    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
-    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
-    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
-    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
-    MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
-    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-    MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
-    MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-    MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
-    MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
-    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
-    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
-
-    MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
-    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
-
-    MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
-    MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
-    MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
-    MULTI_EXT_CFG_BOOL("zbkb", ext_zbkb, false),
-    MULTI_EXT_CFG_BOOL("zbkc", ext_zbkc, false),
-    MULTI_EXT_CFG_BOOL("zbkx", ext_zbkx, false),
-    MULTI_EXT_CFG_BOOL("zbs", ext_zbs, true),
-    MULTI_EXT_CFG_BOOL("zk", ext_zk, false),
-    MULTI_EXT_CFG_BOOL("zkn", ext_zkn, false),
-    MULTI_EXT_CFG_BOOL("zknd", ext_zknd, false),
-    MULTI_EXT_CFG_BOOL("zkne", ext_zkne, false),
-    MULTI_EXT_CFG_BOOL("zknh", ext_zknh, false),
-    MULTI_EXT_CFG_BOOL("zkr", ext_zkr, false),
-    MULTI_EXT_CFG_BOOL("zks", ext_zks, false),
-    MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
-    MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
-    MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
-    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
-
-    MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
-    MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
-    MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
-    MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
-
-    MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
-    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
-    MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
-
-    MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
-
-    MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
-    MULTI_EXT_CFG_BOOL("zcb", ext_zcb, false),
-    MULTI_EXT_CFG_BOOL("zcd", ext_zcd, false),
-    MULTI_EXT_CFG_BOOL("zce", ext_zce, false),
-    MULTI_EXT_CFG_BOOL("zcf", ext_zcf, false),
-    MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
-    MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
-    MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
-    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
-
-    /* Vector cryptography extensions */
-    MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
-    MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
-    MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
-    MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
-    MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-    MULTI_EXT_CFG_BOOL("zvknhb", ext_zvknhb, false),
-    MULTI_EXT_CFG_BOOL("zvksed", ext_zvksed, false),
-    MULTI_EXT_CFG_BOOL("zvksh", ext_zvksh, false),
-    MULTI_EXT_CFG_BOOL("zvkt", ext_zvkt, false),
-    MULTI_EXT_CFG_BOOL("zvkn", ext_zvkn, false),
-    MULTI_EXT_CFG_BOOL("zvknc", ext_zvknc, false),
-    MULTI_EXT_CFG_BOOL("zvkng", ext_zvkng, false),
-    MULTI_EXT_CFG_BOOL("zvks", ext_zvks, false),
-    MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
-    MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
-
-    { },
-};
-
-const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
-    MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
-    MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
-    MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
-    MULTI_EXT_CFG_BOOL("xtheadcmo", ext_xtheadcmo, false),
-    MULTI_EXT_CFG_BOOL("xtheadcondmov", ext_xtheadcondmov, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmemidx", ext_xtheadfmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmv", ext_xtheadfmv, false),
-    MULTI_EXT_CFG_BOOL("xtheadmac", ext_xtheadmac, false),
-    MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
-    MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
-    MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
-    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
-    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
-    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
-    MULTI_EXT_CFG_BOOL("xlrbr", ext_xlrbr, false),
-
-    { },
-};
-
-/* These are experimental so mark with 'x-' */
-const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
-- 
2.53.0


