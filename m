Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F504E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOW-0006Bn-Pm; Tue, 17 Dec 2024 03:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOT-00069H-HE; Tue, 17 Dec 2024 03:57:29 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOQ-00007T-K7; Tue, 17 Dec 2024 03:57:29 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so5147140e87.2; 
 Tue, 17 Dec 2024 00:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425844; x=1735030644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ih4O+GffRmieNzSZLokibPPnjCAbRooLcVshH1yLz4=;
 b=D1cYqyNVm6TVr/qoVU5qWVMunblgo8ePe6x6yd9ZcGoxicCxF5WCHWWgeVTMCAjvVw
 eSs7ylWhluQ7PZxoIn9DTCsRL0HjEA+6vZAhssTBtaj6ppoPpApFGBGDNMS27vLbZrKK
 KxHMeO2wO68KRwXhgbvI4I51LHmERk/ZNTJ/sqQdrq76dDQKNMSPLTlGlX/ff73A69YP
 Jc+uP0DyJqq+qHbKmFRkxQOaOQXzwjRw7BrcMtPfDfNLIcG8Ui4mZxFwFpJvmlXW7cYR
 7Emw8EjrUHQYm5cLOp6UAD1Emt6/ZjPZRI+pl/j1+NYvhpl4APC1kspiVPTea3aDD8nj
 9DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425844; x=1735030644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ih4O+GffRmieNzSZLokibPPnjCAbRooLcVshH1yLz4=;
 b=uYK83Te/8+q9El/AIj8Qufv089YrCrv6dKA3XTDfgwiTobksLw6ginoc8ys45VQpLg
 URQrRfGKvbUmqYYeQNNPAOY7F7m1vMv0uGCECrzIEB8whnNTcvaPJHyaWrYyDlNHzhhf
 lE8tqsUXYBxetRr4DCJi4W5sACB+uNwj9g5oTPcMTVy9rvYIrHBFghLavzCnjUFi6Uz0
 xlIPCKv8BbT0NZC0G+7mZ3tDdPF5OtN76NPjuGJFQUYZwtBuzxnH3Sie6oSOFF1TTQZR
 1oA/k20gspLOFrRAfX51qIOszc3eWQVIpL103LaGn/RieJpM6jOStkLt4XZKCFUlFs/y
 D84g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU72oQ/QGjrwVt8d5ZP+HWY2Onwlg2O7jCridRMjL7MiqbJxJFWI3/zymZh9n4Pfb6b+PfCn31gFF+p/A==@nongnu.org,
 AJvYcCXlpPGtA4IDBoxJ0VPQfhV9cfcdu0I40ApfCjuDfCQt5uvh+R8byfbMRVDOCFMAifRwBXOwGJHtFw/e@nongnu.org
X-Gm-Message-State: AOJu0Yzxr5lcniSMQ6c9bKeXnSvbQZRVje7tFJ9HhBBBMAExyo1P/h71
 Fc0+sgPJtHMMTY4/aM4z9QfESgHqcx8miQk7lHsa3Lh1yNx9qOnB
X-Gm-Gg: ASbGncteQjwNig3BRpt+c8X4xy8G93Zi5jl+fFRpOMqXoaNdSCvpC9JlBnN3u3gOGif
 t9s32d//3TFKwlBn6c18MFKg40cU12BrGqyBBQiWXHavOe+zJk9jaYDtQa3Wh+otEfjXy0NTcWZ
 trETWRQPC1R2j1c2F/EPurbBCJPohAKrGMZ13bMCud32hMX8RSuIcJEECYJPHvz0yZwpBD9EhNP
 1RWDYHDdlY4/xQkWJZRJ0Et1c2Cj/PwvsR3oHpqdfYy8TiXDix+8Nx+tXl5
X-Google-Smtp-Source: AGHT+IFKMvn1d5k7Pve26KSMPEsK5LbIgmPeAPzry7FAASDg6dKZDP/dhgqk2J7uk5lOzRjZV2YWTw==
X-Received: by 2002:a05:6512:4010:b0:53e:2c74:d657 with SMTP id
 2adb3069b0e04-540905a6fc8mr4616812e87.36.1734425844285; 
 Tue, 17 Dec 2024 00:57:24 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:23 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Tue, 17 Dec 2024 11:57:08 +0300
Message-Id: <20241217085709.679823-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x130.google.com
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

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/cpu_helper.c    | 19 +++++++++++++
 target/riscv/internals.h     | 54 ++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c     | 16 +++++------
 target/riscv/vector_helper.c | 21 --------------
 5 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 38231fe21e..536ad20fdd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 30fa475c0f..d76cae99d4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -263,6 +263,25 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+
+    if (priv_mode == PRV_U) {
+        return get_field(env->hstatus, HSTATUS_HUPMM);
+    } else {
+        if (get_field(env->hstatus, HSTATUS_SPVP)) {
+            return get_field(env->henvcfg, HENVCFG_PMM);
+        } else {
+            return get_field(env->senvcfg, SENVCFG_PMM);
+        }
+    }
+#else
+    return PMM_FIELD_DISABLED;
+#endif
+}
+
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ddbdee885b..f86765ab78 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,4 +142,58 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
 /* Our implementation of CPUClass::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
 
+/* Zjpm addr masking routine */
+static inline target_ulong adjust_addr_body(CPURISCVState *env,
+                                            target_ulong addr,
+                                            bool is_virt_addr)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+    uint32_t pmlen = 0;
+    bool signext = false;
+
+    /* do nothing for rv32 mode */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
+
+    /* get pmm field depending on whether addr is */
+    if (is_virt_addr) {
+        pmm = riscv_pm_get_virt_pmm(env);
+    } else {
+        pmm = riscv_pm_get_pmm(env);
+    }
+
+    /* if pointer masking is disabled, return original addr */
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+
+    if (!is_virt_addr) {
+        signext = riscv_cpu_virt_mem_enabled(env);
+    }
+    addr = addr << pmlen;
+    pmlen = riscv_pm_get_pmlen(pmm);
+
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
+
+    return addr;
+}
+
+static inline target_ulong adjust_addr(CPURISCVState *env,
+                                       target_ulong addr)
+{
+    return adjust_addr_body(env, addr, false);
+}
+
+static inline target_ulong adjust_addr_virt(CPURISCVState *env,
+                                            target_ulong addr)
+{
+    return adjust_addr_body(env, addr, true);
+}
+
 #endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..20e5bd5088 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -472,7 +472,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
-    return cpu_ldb_mmu(env, addr, oi, ra);
+    return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
@@ -481,7 +481,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
 
-    return cpu_ldw_mmu(env, addr, oi, ra);
+    return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
@@ -490,7 +490,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
 
-    return cpu_ldl_mmu(env, addr, oi, ra);
+    return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
@@ -499,7 +499,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
 
-    return cpu_ldq_mmu(env, addr, oi, ra);
+    return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
 void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -508,7 +508,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
-    cpu_stb_mmu(env, addr, val, oi, ra);
+    cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -517,7 +517,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
 
-    cpu_stw_mmu(env, addr, val, oi, ra);
+    cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -526,7 +526,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
 
-    cpu_stl_mmu(env, addr, val, oi, ra);
+    cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
@@ -535,7 +535,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
     int mmu_idx = check_access_hlsv(env, false, ra);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
 
-    cpu_stq_mmu(env, addr, val, oi, ra);
+    cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
 /*
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 37c6c198a5..a0093bcc9c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
     return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
-static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
-{
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        return addr;
-    }
-    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
-    if (pmm == PMM_FIELD_DISABLED) {
-        return addr;
-    }
-    int pmlen = riscv_pm_get_pmlen(pmm);
-    bool signext = riscv_cpu_virt_mem_enabled(env);
-    addr = addr << pmlen;
-    /* sign/zero extend masked address by N-1 bit */
-    if (signext) {
-        addr = (target_long)addr >> pmlen;
-    } else {
-        addr = addr >> pmlen;
-    }
-    return addr;
-}
-
 /*
  * This function checks watchpoint before real load operation.
  *
-- 
2.39.5


