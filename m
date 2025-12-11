Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B92D41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgn-0003Bt-Ok; Thu, 11 Dec 2025 11:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgm-00038b-43
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:48 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgk-0003wN-HH
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:47 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29555415c5fso3063355ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471125; x=1766075925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gMOHVXuY6juwq1/G/Cog0GEKPBUSSrmxKitrA4STZk=;
 b=F8mbBDqSitlEn7u3HeakwFraKTkrJcp4JjD2WMsitrmKtk1QYGX50C41GONticcKfO
 ujfEc6kDUmcoUxUCS60ysIguA61Wwzmyrhy2UNEA/gKSvchXUS425xjKpDxUf1vRwfak
 II4B5RwQrqv3B20QqyemlFVaSPkBB6jiBLFfFe3KIzuHhHB9J54ftAypbVRNzGoXf8eA
 r4tRWJStznSvZ/3Q5TKI/p980eGMPtuHocfx5ywiRV9qcRzfmNgAmo2d8mzDauhiOGVk
 g+TV30af/O2lZllRd9DtPE8NCUyBbAID/c9LCQxgm1iyNMCoKt2gcgdPEfhcuxB5W7Fn
 ixGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471125; x=1766075925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8gMOHVXuY6juwq1/G/Cog0GEKPBUSSrmxKitrA4STZk=;
 b=pcH7cN39aOmYC6tAdEtu6Nnr7LdhjhlZetKrZkuJWm85wYJ8e5dlcIizF48tCJNFqt
 Y0LMqNsj8wRgjXwPtoicdpGUZ6A4OOXAXZ/wmI673uDVSp4+a+qXLFkoMgC5qiqZHhta
 9Brwc5dJ4eVqBywhN69PyW66nFt/OXf2Y4eVGeChx+mQCzKRe6mcO3Zn1UOCFMZg4bbG
 +yOYhVV/yQ69vtd54anJuVKQbk2eBfDRTgo0H9eyMp4O6T5gdPIVz+xvsKvjETCy1Xnm
 ey+m6Y82wOgM29JnmoZNtDMFzhcvt6dSInmJgX3M0afVPH5nUr8vSxuNQuJYifT6oIeM
 J73A==
X-Gm-Message-State: AOJu0YzkG6qb91ZA6AIizlhvYqJ7O3h9OFdkf887g4dXmkhPSwqgoVT3
 JaNnNAE4sOxe+fS1Tyi1XY0W/UFuMKYX/uepsg/NHESeR5FJMs1CIwze31qnGlXVGOniJC3mLKb
 /7PK/TDhU87mkJaxHxOpVtZE+hF7bOyAUi4/ofkwEoKtye8uHzs1NLlRwxn1/Me9h73K/iHaDw8
 JF7FBI3Wg49PLvHsPVfJewhdbLgKWVHWwHCV2i2tMe7uY=
X-Gm-Gg: AY/fxX4dXp+7jiH8apkkT7GaIgEmM31mHXhn1ay71FqpHNCXHI22katoyoFFLGv/sxZ
 GZ0ZnfVK8xnvgn9b0TvyyyPYeROOJhm0+Zy7QfHXYug+HeS4wzbfY9V9b9IsIOK/pyn4iczSaHW
 BmE2amIyCmmqWAB+6nOaEyQJnJeMjL3iB9DpHta4IEjB7bC9hB/0eFDFx52RPHt51pDvedXnlBo
 Rz6pQRl3qce03j88w2tjf0hp73FiLcy4/SkKLgGCdHZNY4LfJGBeaut9Ax+shSevF4Eza4nJq9P
 1qJbMy4FMoKgxI4oXVkFBigsaCr/5gmPfyLESKNDg3/H7nP29bHJ3T6Vb/kLrCXVK0VKnazRQrx
 uW7bNMH6aUI5tIUoVloQkXCWfL7paBvLhzH+zaG4umQ8AbVx/XiRGOe6D4xJJOl3LosUwoayAs6
 6T30RyJc8qI+1Tg/hew/mNUoK0pwq6ns7EamCFFj9iUptlitDZ
X-Google-Smtp-Source: AGHT+IH2+yffI0un14sRzQKiXdPZgI2rB6HarL/M5bRWiSB/5EfBGCvgqjsdBycJAu6UiM44i9E3kw==
X-Received: by 2002:a17:902:ce91:b0:29f:f44:cfc4 with SMTP id
 d9443c01a7336-29f0f44d7bdmr7661415ad.47.1765471124430; 
 Thu, 11 Dec 2025 08:38:44 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:43 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: [PATCH v3 6/6] target/riscv: Fix pointer masking translation mode
 check bug
Date: Fri, 12 Dec 2025 00:38:25 +0800
Message-ID: <20251211163826.3998266-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When running with virtualization in VS/VU mode, or when executing the
virtual-machine load/store instructions (HLV.* and HSV.*), the type of
address that determines which pointer masking rules apply should be
checked against vsatp rather than satp.

As a result, sign extension also applies to the virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 target/riscv/cpu.h         |  2 +-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/internals.h   |  4 +---
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b4cf86e4f61..93c837024a0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -881,7 +881,7 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f6856a10bb5..587adaeec73 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -240,16 +240,27 @@ RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 #endif
 }
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
 {
 #ifndef CONFIG_USER_ONLY
     int satp_mode = 0;
-    int priv_mode = cpu_address_mode(env);
+    uint64_t satp;
+    int priv_mode;
+    bool virt = false;
+
+    if (!is_vm_ldst) {
+        riscv_cpu_eff_priv(env, &priv_mode, &virt);
+    } else {
+        priv_mode = get_field(env->hstatus, HSTATUS_SPVP);
+        virt = true;
+    }
+
+    satp = virt ? env->vsatp : env->satp;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        satp_mode = get_field(env->satp, SATP32_MODE);
+        satp_mode = get_field(satp, SATP32_MODE);
     } else {
-        satp_mode = get_field(env->satp, SATP64_MODE);
+        satp_mode = get_field(satp, SATP64_MODE);
     }
 
     return ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b17b661e2a8..38d438fbf93 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -200,9 +200,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
         return addr;
     }
 
-    if (!is_virt_addr) {
-        signext = riscv_cpu_virt_mem_enabled(env);
-    }
+    signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
     addr = addr << pmlen;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 440626ddfad..2b4bcefa0c9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,7 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
-    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
 
     if (cpu->cfg.ext_zve32x) {
         /*
@@ -255,7 +255,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
         return result;
     }
 
-    pm_signext = riscv_cpu_virt_mem_enabled(env);
+    pm_signext = riscv_cpu_virt_mem_enabled(env, false);
     if (pm_signext) {
         return sextract64(result, 0, 64 - pm_len);
     }
-- 
2.43.0


