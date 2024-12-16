Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D38E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4P-0002tq-0y; Mon, 16 Dec 2024 07:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4L-0002rZ-Tu; Mon, 16 Dec 2024 07:19:26 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4J-00009M-Rw; Mon, 16 Dec 2024 07:19:25 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso4725520e87.3; 
 Mon, 16 Dec 2024 04:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351562; x=1734956362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKOV8Cvarsj0AatLWlXPp3sVkwJsjAVxZ2JmaOhsbH0=;
 b=a22eMAVTCCIJeT4RTsA9NtltWUmPCviaDFC6pU/M+QGpcg6HvSNJzhORf5A447+IDc
 5DRYZjW5lpgEGsI8FRAbutveJAcRZFTbCfr6qxfwP+MBBXJmMso0HowQtVxmh0XlLSEB
 hkpmltulL8VjEkOzfTFAXMzxPLAdjGKH9roJXfNd0qW2YQdE2AXoNyf8gMIkfGEDeBW0
 /jOtki5Km3eO+4ZysZr+BwxNxs7YdDOh/L7IIRgR3RU4n+g9Q//49LhXmmBpexmhjNCu
 NYvwI3235SMETLzVQfLiPVInxIiMHmCoOvY5J9/47TXgRHIAewbXP4aa2QY7KmN7cUIZ
 lv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351562; x=1734956362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKOV8Cvarsj0AatLWlXPp3sVkwJsjAVxZ2JmaOhsbH0=;
 b=eUEmHjWvVf+Z/XSYNO6gBj9K5R+gtPQA5YJ+GbcZ0EQ1b/bWkGdfiBb01070DSfTBo
 BV0C3VUT7Ec5FQzuwwBxBrp4qdjtyQuqgbRCJpqBzA7nSt4xe2KEdPNQ5dwzrU7JiTWf
 NZ+HJeN6Bb7icmKruhORcBIjmJupJjSY8u27+W3FTM8wAzvaa5eNh+bmn1/TB/LdOFKc
 dbjjqzdXL+6x82ZoOk+x5Ej7vcYaXqrZwwmd7qGIg0rzvAdstFpllKXpfeiaCcWjwDvF
 7rpw5KV+jxRA82tH7/RjNAFXckXq8lO6I0/TZq6SFo4zZ5b4+EUxSv9hD9QrBcMRHKiQ
 gk0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdshQQ0gM0ULeIBXepIf0dNtGbThfSuhkNvw2G+RItRD6DyF346FxZyJJ8dGXsFVxNctEkfaV2TsQ0cw==@nongnu.org,
 AJvYcCWDdlcWpPX+mfZ/7btB1u3vlM5wHm/03Af2CBWpIWASV9CsT6FnVjIhhPrRSqq9t//gC411FMU1Ixm5@nongnu.org
X-Gm-Message-State: AOJu0Yz8zEWfyIKkjWe1yZT0CKAC/MY5rdSsiNaafK6PcReCxqZUG3Mm
 OkSJanTrA1jNlGS8cRvgVNSSLTG23mpY+pqc4g6lNOWrc9oYIud3
X-Gm-Gg: ASbGncvnZBCqG5czFMmhea3fMks6N1SFtAvkWGYzUE4T5zHszFa7fzrBXWqc0v4pVSk
 rLgWuN78OiOyF+xVqehF4ypAiDDp3XAJXcDs3OpHuoGm52bZAqEJm/xl5haGmOiRvGPoWUrZJBM
 73ItOsbXA6rLLB0yL6CMZ9YZTkdwewVnpmE5Ilj6kOlW9lHg2FthvpTaJDKPPvVoB0ucunUu30i
 ExBFriCx85px8Z9tllFUaZ3YkpKMC91hPp8ERV5fV1Dd3TZOICsSa7YEQ01kg==
X-Google-Smtp-Source: AGHT+IHrVxhlsprlpCpImkayxUPaKRZQzfHCQLejo530aBeyXpdKh/TW/PBba0a5mMdhSVeO5TfW8Q==
X-Received: by 2002:a05:6512:3b0a:b0:53e:3a7c:c19e with SMTP id
 2adb3069b0e04-5409055e408mr4076331e87.29.1734351561620; 
 Mon, 16 Dec 2024 04:19:21 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:20 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v13 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Mon, 16 Dec 2024 15:19:06 +0300
Message-Id: <20241216121907.660504-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216121907.660504-1-baturo.alexey@gmail.com>
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x136.google.com
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
---
 target/riscv/cpu.h           |  1 +
 target/riscv/cpu_helper.c    | 18 +++++++++++++++
 target/riscv/internals.h     | 44 ++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c     | 16 ++++++-------
 target/riscv/vector_helper.c | 21 -----------------
 5 files changed, 71 insertions(+), 29 deletions(-)

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
index 480d2c2c8b..471d8d40a1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -260,6 +260,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     return pmm;
 }
 
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    if (priv_mode == PRV_U) {
+        pmm = get_field(env->hstatus, HSTATUS_HUPMM);
+    } else {
+        if (get_field(env->hstatus, HSTATUS_SPVP)) {
+            pmm = get_field(env->henvcfg, HENVCFG_PMM);
+        } else {
+            pmm = get_field(env->senvcfg, SENVCFG_PMM);
+        }
+    }
+#endif
+    return pmm;
+}
+
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
 {
     bool virt_mem_en = false;
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ddbdee885b..017f33af1f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,4 +142,48 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
 /* Our implementation of CPUClass::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
 
+/* Zjpm addr masking routine */
+static inline target_ulong adjust_addr_body(CPURISCVState *env,
+                                            target_ulong addr,
+                                            bool is_virt)
+{
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+    if (is_virt) {
+        pmm = riscv_pm_get_virt_pmm(env);
+    } else {
+        pmm = riscv_pm_get_pmm(env);
+    }
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+    uint32_t pmlen = riscv_pm_get_pmlen(pmm);
+    bool signext = false;
+    if (!is_virt) {
+        signext = riscv_cpu_virt_mem_enabled(env);
+    }
+    addr = addr << pmlen;
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
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


