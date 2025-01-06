Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB7E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHd-00077S-D6; Mon, 06 Jan 2025 05:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHa-00076c-Uv; Mon, 06 Jan 2025 05:24:27 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHY-0008RE-T2; Mon, 06 Jan 2025 05:24:26 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3002c324e7eso163970501fa.3; 
 Mon, 06 Jan 2025 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159063; x=1736763863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoGuafrivYOXJ9X+Hyr0yxdy3q2O4Bs5F7fKJPmOWhQ=;
 b=B4kzoi4wfDRWn/zf19klMMS4RFT+o/zlMJC3HtnZccrEt9jwIU+6i5ihMaUAQ5070I
 d37LMNJx/0kW2Ni+wKH7JNp+3SJZInR9yToeFlmJJJhH+W4PCWLxR43DtfYO2QA4xthl
 h7lrHicgEa/gUW6qGkTM/zHT6omAFiIFefdp0ORG2QJBV5PCxcFLzadYOz/d2HaNItr8
 ZQSlC70phrlE4ff5sdtEkWh7jO8lexhlUCtk+tHokWRox+o8AnIvJpx9IOSs2iwc1J37
 7p/uffp9UuwptE4QlQxykTNTXKZdkh1dGbjsRNhZqDDNEVtog68MwcAHHuiziY812zSP
 Q0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159063; x=1736763863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoGuafrivYOXJ9X+Hyr0yxdy3q2O4Bs5F7fKJPmOWhQ=;
 b=tzUwIR+8Kr6od4Y0zJj30X3+AeepSB/08qgBrdwwSrY3OZuFZWX10wh0+JsmpC7cW/
 eYL2vK/wmKzsjrfHMYqaHP02YmyKrrjIgimAZtKOgSZfQCw+EUQhQ1WamNBYcNmspbmj
 Dq429qRSdWpgSmhh5vyBznwd57C8c8++j+ZoSHppE2vnQcXbiSye2PPcqONnPToLSP4U
 /3gx+j26jvXqwtwrEpkIDJcleNQNpFdpJ6x0Zu/JhlgIjlpjoDFXqzsQF1aavrwqVfd+
 crohJEsuDSO18oEkbIVFz/41KQLRPxWdXwPc6zy49A7TOcj8s8u4Q1AkU466zhcopGwW
 ABaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1K/0CpJeGZ6zOsIj+A6FdbxEbLtxazQHOCJ/7W3Yd3vhMH/xbecPsLzp4wSW+OuotUW3HqCgANCJn@nongnu.org,
 AJvYcCX07zVoVXL5lRR7HqraH9JdTy76DNZ9T4I3M03Uhciv8YYiKNt74xrOaNqdMPithodJNQmpAQMGeMR0vA==@nongnu.org
X-Gm-Message-State: AOJu0YzgnK0rDINYk792I3ya1mC1xV4I7tVHTa8DfFuGrmXgouY5Z8XU
 lGqOP8PdWR1z7DkjjrmUKr/pYs3xzu/ct47tuTejzWVfH1CwXdkAbtN/Svtz
X-Gm-Gg: ASbGnct9Udi1lazEfcDZgxT9LFnYczcBYG31trvpa7IgkiZvfnzs9BQ412o2tpV0P4X
 9aadGpwd577VJAN14CBfwBs7AXqBH5x3+CPFKr2V5/9X6zTbsN1wMkV7RLSWgZkD+JeRrIP3SIo
 yLQ+StGGPIUJgDquSuQKeEXiJbKpSTHcEZjqa37KVAT/FebXRmIVToiLf+4RS3ZWWnXvAozRzvG
 drQ8irZBxMLGuWU1cFKq0QnTGE/9uXJQvKnM8GFz/oemWJMu+UCSzvMgsaD
X-Google-Smtp-Source: AGHT+IF4+xKm5o5jUaBYgq0EcH5QTm3PObLnKxj8nOc2kkEiiodVylHJiThAdWGtwlxqD8YBY9rrJQ==
X-Received: by 2002:a05:6512:12d1:b0:540:263a:131f with SMTP id
 2adb3069b0e04-5422957ae4bmr16226481e87.50.1736159062671; 
 Mon, 06 Jan 2025 02:24:22 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:21 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Mon,  6 Jan 2025 13:23:45 +0300
Message-Id: <20250106102346.1100149-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x233.google.com
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
index b7458c40d8..504bab31b1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -776,6 +776,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8728541b99..2e307e4ea5 100644
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
index 76934eaa7b..67291933f8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -145,4 +145,58 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
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
index 0eea124b66..5386e3b97c 100644
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


