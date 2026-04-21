Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C0FF327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y7-0000C9-C4; Tue, 21 Apr 2026 05:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Y5-00009i-MJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Y3-0007uY-PH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so1142228b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764257; x=1777369057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfwLARxELoq8ANLXoGfCo6a2UvGWGx8gKCesGr9dyns=;
 b=lnhmGP9xOU/KamEMMuk7D6oPtzjtJzX/xfZMKBINaPtmz1WHBmsv9b5fNUkVrOr5sZ
 dzOiOqW7e6w4Ja+Al7HP7Z22Aed0QfIS9AbLrTZvlv0pWgcQeMu6U/r/cA551YTCRcRB
 6MipGkAFXKUUnxRzDb0lZOdz4t2wDcgtJqWKFf+DAjuR3wevUsqrCSUHoe0xTREfq+Gb
 dTOIf3v6s2iwuXpP0pNM5eZLcUv+RI/7enwa2GJB16zz/ez5AtsqECayHvoa9PlN2Dbt
 d0Q1iXAhUxh5IVUGrT5SGK80BdQAB0ERrbRAgbSvzd8VOhcJ2p1QJTMB+FlPbh2qkM26
 AP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764257; x=1777369057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mfwLARxELoq8ANLXoGfCo6a2UvGWGx8gKCesGr9dyns=;
 b=EWfw/41nNkeWlxag++ObOpHtHYkZ9mFh7vc+A9ShvhjrIKoqRRNetmbU2NXmhjvvhK
 BJyF+PcWVwz74BBYhmfFADJAn/QqLa3wQ0gqd9z/ytUIB+5t5zZx3bywKba8S7q9BkVA
 1HCQF3UfKCQgOCYBmkWjaEPCQ/qFhra/enY4Lk9vBVhEqtnR8o3YHtmQoRSKhBA/ezvG
 8QNW2cgVf90c/YwF4jNkrTF3MDXctLUengmDgpRj1+1j/C1djrKfGAUJEoygkaQH/JA8
 nlFC/dR74wb/vEBWDZnGgoxFkNWYBNcBuomtKmgdUZ4FuEUuv9sXJzbqmCfhl4+oWIk3
 hXlw==
X-Gm-Message-State: AOJu0YxzxfliqePrBcpP18dSrdqOwNZzimKWWOWHIabB1x6ubtl8Codd
 4CvJDxlUCIBja6qtsUEE4IJLOx+dDOqZfWH/wIcDSze8zDNFp0N2weuDBa2uY4+BCTsrBqnbIb3
 qg4Ra0JrPkIMWHdVAwY/o5eXNhdbpeHo8gjyt389yWnmEK5rPQbQxylJ0N7EAi8MfTUPHcv+OaO
 FuJGXVPV2CbOPcqtqVG0Fr+Gk1Tdx3i6raWPlU186L4bACXVgE
X-Gm-Gg: AeBDievZuxtdexhX2kvAUNcUqERuPevU2zci6+WkUokk26JFQNk0JLTxnZ6ddVkpiF7
 Q3egicbvdQ6M1KqtvA3YHw4czE2M/OFJREovwzFJ+Gij8EMyq7KfIi5w2G4PLhuTCThBUNAkB/p
 skX2Nt24Wd4RfBBhpeUhIowl0/uNSFkUAvQedH39Z+JyEEq7aVeQj7ZGC5kgu16C7BhYCFLqE6R
 HQJbHodyk1wRkiY7oaVxmvvHArx26ck9xudGqKHHcc32rFdFwgGvNEN7wJ59+rq5jNT3UrB5veJ
 2KYERxDyQ4cVrVWlKNMbrLb+l4mv9AiDntC9AGufqqcIwYclbbZcMt9CMsEkdvtJW/Ez1NDUnpd
 krgmSCcVGlcuwfjymWfG5UyA0Z09wbZd7RpQA3dcz5l2t7wK2no2MP2md4HE+5ZY2QHn0C2eGfg
 w5mrZzWQ8H7pwD8VGlHQ4SckNi2ufuG90gi6gFL6KqeGihzd6W3p8htHW7VCf+
X-Received: by 2002:a05:6a00:e1a:b0:82f:2a78:6302 with SMTP id
 d2e1a72fcca58-82f8c9027b0mr19297692b3a.26.1776764257214; 
 Tue, 21 Apr 2026 02:37:37 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:36 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: [PATCH v4 6/6] target/riscv: Fix pointer masking translation mode
 check bug
Date: Tue, 21 Apr 2026 17:37:15 +0800
Message-ID: <20260421093715.2995067-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/cpu.h         |  2 +-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/internals.h   |  4 +---
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 138183e017c..81c41e34296 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -888,7 +888,7 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ef1ff7cb0bd..39c3486ae0f 100644
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
index 82d24f433dc..683bb3bce3e 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -213,9 +213,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
         return addr;
     }
 
-    if (!is_virt_addr) {
-        signext = riscv_cpu_virt_mem_enabled(env);
-    }
+    signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
     addr = addr << pmlen;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f78088956..02c98cc2dbb 100644
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
2.43.0


