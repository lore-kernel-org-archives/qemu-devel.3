Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4ACFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwua-0001uP-Vi; Wed, 29 Apr 2026 00:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuY-0001sC-Iz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuW-0001PO-Mg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so72273195ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438342; x=1778043142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGrPe6UgMgduI1+nKODNfEq2uoIm27MS/m9SYo0Xj0U=;
 b=c56JDI28joQ3Ff2VyE35UThTMpcALQkt1ntXyCyizd7yTvBv2P1kP7BUNpeFDMp0N4
 e/24/+aY4lTOIjdjfVlz5GhmYjQ/l9hazpgYM7OJvs29KzvYC87d7WlaKWFkwx297dLl
 UixmvsVKi7HEFWADVfZBT1ysXgTbiqaIfnogF2gnhk1UwkdMeANGaAzodg4xckZceyXc
 xGcfCuu5UtdE2SYf0k0NDOxozpKdgIHOxKik9SIeJtoWTqEDjF6Uom/JtpR/5C61E8AC
 MiAGhDSHN7/m2bjH4NXRCcNleOAhnGGk/DTXhaspwLKaaqeXNjbrz3Rrm2233PrZGgOY
 FMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438342; x=1778043142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VGrPe6UgMgduI1+nKODNfEq2uoIm27MS/m9SYo0Xj0U=;
 b=SNgVGRkCDkNCNQXQlcXvzHbnmYsfdB89yHCNx85rEFBE19WhUZnxFB0acxgcYVWG/7
 g00KM1AzRs6qfkc3gXBg5H3b6bgkskZff+IptK9osvOHNjaFgRKFU70xy4p6T7aJOMkJ
 7uxJvvRDEEb5SKM0xxxM9eamARxzmvHIYVrZBQiftJEcFp4G7PIkEx+a5eF+6jC8Nhox
 bYagLzJzYnt3vyyEtNDNZeOq96mh7lzLvHQ1nakaR8wVsHm79ixtpXyHphnfAT8r/sCY
 +LXgBHReg4sJtFFIBMkpGkGlboE5FWscjMfl1q3X+mOg2ehWPY/FgJpOcYUfiGL1Zh3F
 0Xvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gACmaeHNybWfaSyme0baOFrDTO/4UW8MOWpLHgWjatZRF7bfI+5tD27n4hBt0Ez9tsC48/CdPYZRr@nongnu.org
X-Gm-Message-State: AOJu0YzK4Uh3nEuDcFp0i3+Kdh89CX2a0AftXNuszRGf+J7Z9RxRCxyL
 TvV6TGsLqNvnl/Cx/grg6jn9jXvRYM0mUhCE/Lv6CVGUXOaEgwLPaG/W
X-Gm-Gg: AeBDies9sjJO+RDi4Rk9bklozbsfBCDgVH/0sKRMvyjFuSviUP3LivUb1zycv/1W+J8
 nqhWuI2AvVjxtNRXGv/uJKDbaQlatm0LyakaxDfQ2Kew1IeRDDzcAxEoupxSiHaKojGnWVF1n0L
 TDOamM315oAlxYF6h02qIyUAmQMdD59wVD8KMPslK7E5YN8hmaJdw+QMs61H61lAA+LKr9aGtvZ
 wq3A15zFnvoE3Ot96XHuWXD5RPYpl7zUAJ8J/u38TmqKlkp4F920atUxLAz2Ge9STArCmu41zEj
 3kqIAw72p8EMaw9iAcHYLTnlkYjcy7SYc0HIQ4fySOD3YMNWXYCEOLCs++ExETuU3L21psy6Era
 4Bp1AYwwNmnoe26eG4XTP5QCc/PfZtODS/mSlh1J73Stpg8EBWyJlEJljGafO8HzAAkfoUu+X7n
 CJ95D3xuBrdzbISUf5IixJdXCLVPFIch8I231i/urKgdcZXZyaBCd7
X-Received: by 2002:a17:903:166e:b0:2b4:678c:5f1f with SMTP id
 d9443c01a7336-2b97c1534d6mr61747295ad.0.1777438341690; 
 Tue, 28 Apr 2026 21:52:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/51] target/riscv: Fix pointer masking translation mode check
 bug
Date: Wed, 29 Apr 2026 14:47:51 +1000
Message-ID: <20260429044752.4176397-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When running with virtualization in VS/VU mode, or when executing the
virtual-machine load/store instructions (HLV.* and HSV.*), the type of
address that determines which pointer masking rules apply should be
checked against vsatp rather than satp.

As a result, sign extension also applies to the virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Radim Krčmář <rkrcmar@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-7-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  2 +-
 target/riscv/internals.h   |  4 +---
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 138183e017..81c41e3429 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -888,7 +888,7 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 7eb6edbe90..bac6c8032a 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -219,9 +219,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
         return addr;
     }
 
-    if (!is_virt_addr) {
-        signext = riscv_cpu_virt_mem_enabled(env);
-    }
+    signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
     addr = addr << pmlen;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ef1ff7cb0b..39c3486ae0 100644
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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f7808895..02c98cc2db 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -105,7 +105,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
     uint64_t ext_flags = 0;
-    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
 
     if (cpu->cfg.ext_zve32x) {
         /*
@@ -260,7 +260,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
         return result;
     }
 
-    pm_signext = riscv_cpu_virt_mem_enabled(env);
+    pm_signext = riscv_cpu_virt_mem_enabled(env, false);
     if (pm_signext) {
         return sextract64(result, 0, 64 - pm_len);
     }
-- 
2.53.0


