Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D6CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfo4-0006v3-3B; Wed, 09 Oct 2024 19:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnw-0006qA-HE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:16 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnu-0000l1-U7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2bd347124so265080a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515353; x=1729120153;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6d6JNNpqypFV+9JaSGoihlcnT/RjodexqM4x572K+eU=;
 b=zxw2m0HNCPVTxYepjPt5dyECnWpjUupcGNGAUnVnIBHAH4EY6gO1r9270H1ftFD/RD
 z7Qyob62o01PMBGF1Lopjz0djGF2w9JNShFVJaJqJ09gbNxK59qqgHpPG+c+aQjhpvfV
 xD/QeW5wCvHF47wbttOTRHScdNjwyXQJ3S+uKMF0IB2tpixFXRuJKuF+RkZzH/tLod8Z
 hvp0b2RsNSN6vXycSZAL+LmL0Xr/p3CaRNhIZEM+0a3RjLs4R5h1Vdl8jILq1XoUa1sS
 CCyNIHvSoxeJkgevT77x1kJNX/cbnvakztbuiXDT+0isPPEhdXNeeo2lLriGcllpUkEI
 zBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515353; x=1729120153;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6d6JNNpqypFV+9JaSGoihlcnT/RjodexqM4x572K+eU=;
 b=m+gAYCzwbA/DnJd1hRF0Ko/q8W66rO5hTJ5McnKZ2YroHVhrCdHshMaEYojSI9cIGo
 YetTcm9g2zH/t08tKb79qsO9ruu82fC4PhL8Kh3xP1194ffzG/bk0llRsnVYC/pkdgJs
 JfYlcEzNAsMm8cGAqbDf0AMrcIMdJ/bmEKib54UfRuGcyXISdBhvGtQmkDyYf0cHCwHH
 5mDWcyoGuyfDSzUytKUKULyGHn8EOH83Szv1aBAaX8Q1C7bUn7Q2tP7uVQtN1v9Fye1q
 DlemSJRg2wVv/zxWk+jr24XqOcnTBg1wLRAYip9FPvTU1HwU0wLecFJzDQaaO41RLJDv
 OgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKN3LiFDa9CMD+QWdixydJiEsliGvomDsNJSCeUGiUDNICs2ynv/Etgu0TrwBHheQkBheLojqHqdj@nongnu.org
X-Gm-Message-State: AOJu0YwiXdFrWyXAsHR1yKQowxSYLok0hBCxMIe7ncoS6RRkk02xB8ys
 jV+bvszcZJHiTDMzgD8TDsWVxX+JFth9ok3o/yUOXMlf5dPjlWiE10B/xPrn6xU=
X-Google-Smtp-Source: AGHT+IFWLLJRVm0Y+Uydiha3gGooMyMtA97UJ/mikC4+VrsGfl89XCOGMb1vzqA8x/bwreMUO4/31g==
X-Received: by 2002:a17:90a:bc92:b0:2e2:8d82:df13 with SMTP id
 98e67ed59e1d1-2e2a21e6d03mr4557518a91.8.1728515353355; 
 Wed, 09 Oct 2024 16:09:13 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:13 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:07 -0700
Subject: [PATCH RFC 09/10] target/riscv : Use the new tlb fill event functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-9-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We have TLB related event call back available now. Invoke
them from generic cpu helper code so that other machines can
implement those as well in the future. The virt machine is
the only user for now though.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu_helper.c | 21 +++++++--------------
 target/riscv/pmu.c        |  2 +-
 target/riscv/pmu.h        |  2 +-
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0f1655a221bd..5161fc86dbfe 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1295,23 +1295,16 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
 {
-    enum virt_pmu_event_idx pmu_event_type;
+    uint64_t event_type = ULONG_MAX;
+    CPURISCVState *env = &cpu->env;
 
-    switch (access_type) {
-    case MMU_INST_FETCH:
-        pmu_event_type = VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
-        break;
-    case MMU_DATA_LOAD:
-        pmu_event_type = VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS;
-        break;
-    case MMU_DATA_STORE:
-        pmu_event_type = VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
-        break;
-    default:
-        return;
+    if (env->pmu_efuncs.get_tlb_access_id) {
+        event_type = env->pmu_efuncs.get_tlb_access_id(cpu, access_type);
     }
 
-    riscv_pmu_incr_ctr(cpu, pmu_event_type);
+    if (event_type != ULONG_MAX) {
+        riscv_pmu_incr_ctr(cpu, event_type);
+    }
 }
 
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 24c2fe82c247..e80f0f911fa3 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -274,7 +274,7 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
     riscv_pmu_icount_update_priv(env, newpriv, new_virt);
 }
 
-int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_idx)
+int riscv_pmu_incr_ctr(RISCVCPU *cpu, uint64_t event_idx)
 {
     uint32_t ctr_idx;
     int ret;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 75a22d596b69..810ac2fae797 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -30,7 +30,7 @@ void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
-int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_idx);
+int riscv_pmu_incr_ctr(RISCVCPU *cpu, uint64_t event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);

-- 
2.34.1


