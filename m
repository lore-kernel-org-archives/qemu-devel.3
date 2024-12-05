Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B62E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9x6-0008KB-RF; Thu, 05 Dec 2024 06:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x3-0008Is-NF; Thu, 05 Dec 2024 06:23:21 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x1-0005Jm-No; Thu, 05 Dec 2024 06:23:21 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53de6b7da14so871575e87.0; 
 Thu, 05 Dec 2024 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397797; x=1734002597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94fSHaUGyassQGMKDG6ZXhg6oLNmXhLz5E8Njs+vBcE=;
 b=g9Kz5LKMLxAkeLRtbryVl5/KscjrUWge+Vhkay+mHboKXwfGrUZ+cldVzJMrKbFsYG
 AzsKHKSHkN/lWprkhXLDxiCucTphQt64baZh61kInYDXDFJ1pPFRUBfpSJnWeBnGApTm
 exF9yN4unsHn5nvK83nGd4zGJT+k7ZbVPMGS+fJ1vvi1SMFVkAFQOvOIRoSD1KgdkqjC
 iUcQaBLEXUWNlfnDIvKQ6T2Mcv9d0EmW4TRfsEv6+ODFqsccpKM6f1I5GhjOASCd4uN5
 QO0v4KWBHWSSy+pKERzwMfBs7lppuuDwIeOeaexYoYwNeIPwcgnrJlnSTag2aehxEUkH
 7Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397797; x=1734002597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94fSHaUGyassQGMKDG6ZXhg6oLNmXhLz5E8Njs+vBcE=;
 b=vhU2NVa+zRIYxlE//EAdcnPoqyl5Kbi/OIagJUehQ50FzlwLTuhDxrRzIWLNyPCTfa
 UArF33YFSKv08m491R309l+CX4A9BtBdYcGNewllvNPfK/BUhUmWNDdvmzvcYwl/3uWc
 kJiJ31122Q7N+fEUFYUoRGoJ5G46koohYFgDZRG2anlW8Eyd2xOmbPOzJvaCwghID08h
 SzpGU52NzQVpXeRSOv/stbmyLT3IO2SMkRagleLKHKenIRu7isUoNvI87JMHhL6J7kX5
 lumPyE6r2G3VWX5jwI4jYlz+lygjH1XaDIf4QJ8s91szbGb0dgY+AmH+rppYnT7OSX9I
 Zdpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpeBfLS46LoOPnHkwRcEUOi7eVyGjFMI0x+uI+f1ggvZT484eNSl+daKF1dd/F5gWwgr6nXV/NMCA0A==@nongnu.org,
 AJvYcCXecydBIFpTlej+5JhZyuqsoV/JjAfcuk7sp3c0mpp8O7q9oTvBPrNiv2L4Ru8RTOaZLmO8beQENLel@nongnu.org
X-Gm-Message-State: AOJu0Yx3YmX2J2uJ0rDEvnAoDNgzhIDK8iw//nC5u2DJBcRY4302mmyb
 ZnC2wd+iQStdX6i0cy0NmVpCZRV78+m5o6PVlcRBSdIMz+D4Nav4
X-Gm-Gg: ASbGncuOw/a34ELT8Inily+OxgrM89kvG+LRrcTO1VS9LaFxp1cWBhzmdNEiZLn/cCY
 uwQSNUKBdow5wfqqkuRnKIrKbwstw6ZRVYv16yZHWVl1W51eVTVWsVPosB4U6DihWOFPPK7D7Xm
 2C3J43upND6BZePwKfRcEMw5vz+z1Ydc0DVDm1hN5z/lo6g6lktqHiAHYk0rfSD4OOAVQ3YR6q7
 QaK8G53xHVmfcCP40kwRmIwwiSIA0QGVC1+W79IVhuTc8m+89RHVrs=
X-Google-Smtp-Source: AGHT+IFlkCtOP1eBR6uBShfYzMu8xxUy3jSotuELXuD8kqX8eJKwGSjA615zcG7mDFcVd3ab9z1xaQ==
X-Received: by 2002:a05:6512:2821:b0:53e:1b6a:60f2 with SMTP id
 2adb3069b0e04-53e1b88ff93mr2939621e87.24.1733397797169; 
 Thu, 05 Dec 2024 03:23:17 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:16 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v12 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Thu,  5 Dec 2024 14:23:03 +0300
Message-Id: <20241205112304.593204-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205112304.593204-1-baturo.alexey@gmail.com>
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12a.google.com
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
index 11e3a6d647..2d27c804d5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 int riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ea342fde18..1f2cca82e8 100644
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
index ddbdee885b..bc0f892f8a 100644
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
+    int pmlen = riscv_pm_get_pmlen(pmm);
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


