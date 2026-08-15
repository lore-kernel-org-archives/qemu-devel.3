Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD3FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8p-0008Ol-VY; Sat, 15 Aug 2026 16:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8n-0008MP-Vs
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8d-0008Qy-Gi
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1815479a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826274; x=1787431074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UiJE2cy3VM0yzojjkpva8OpyZQEIaPJNd78PgCz97dQ=;
 b=kjUHhpDoNom1aFKmas2yO7qMvwwIrqrTkqEkVxSe0mq6Bfm0J/4IEPW5V6gcCVix99
 ZK4BWcUdhrOGVH/6y0RspgHE1K78OETGPJzdZBlJINQTJ41zWrjRqRwWMUdyJLnob34O
 jAOsQhj3ND7g2d1TSgsC6CQmJvS/O/MJ27WNk+nxHH76MYgG8ETLb/qs35Hjfph6OkWn
 xP2rRLxZmEfoFGPTVffU9d3NcRUlpW3RKIUi52q8gXb4VeU3WLupP6RiYfsUMbx0RD71
 GStB2klTdf5O1cJg2QhnEJkYNe8eKf8Zer5aM4uPjHDOGBXMyUEBKSNagWeZH0Ilqyjf
 3ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826274; x=1787431074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UiJE2cy3VM0yzojjkpva8OpyZQEIaPJNd78PgCz97dQ=;
 b=iyOBZ+AA3bv7zSdi5fuB9eib3z4R5bBXs5SVQ/9GcITXwRNIFTOQLxqHdEr89djwK+
 aZ8JCQW7eauK+KA4yr+LBHGPdT5lNTPqOPyBv+nEjKyBu73GevMtuHrAbioUyUxq241q
 kz2WQxGdZz9k+8VBklQQI5p3sNeZlBgW91/apBh5F7D8+wbY3bqAQr8pONpwg+3k9e48
 8VZGSKVYYJj5uACe/wkaZWgIaWraNQcvPdJ0eKVeKhmXK1XRH6CAUJsrJOFVhB6oDsOj
 T4zUUOAiliwNODN4WtKFcvrTDCxj3RR9TZ+AkvnJVgDiR0D0CvlQw0EJx5qhamvRiv7R
 n0GQ==
X-Gm-Message-State: AOJu0YwSJLxC4N0u84ExXrGVaWf6WkY2N2Vgz+vyVt8UsYnt44uVsViC
 kJW8Qr+9aukqM/iuXG5G8UucfIurvUUmcRhvauit9xPqdg9C7FYUJcAcbJ8seq7HcEwN1V4+60A
 1SUZ0
X-Gm-Gg: AR+sD10hrVCz1RRQLlcKnRuQx5FLAbv/MDsdAwLIOjLXPHJZ9xpXY3TuAcSn2ww3T7+
 ro1rstcJmvdNVbZOKCx/F6zPADPitbv3KjVnRW/CsffduyNJfM+DeBKJEKjska5XoiKDDgNo/gf
 UCZOxPr8L0YgRPltAcBRfPatndvbJxfAbMWNkUYM4aTkumdxcQ3TA76svHe6//2Ck6xZOzix6nR
 m5TtpIA1jVXhuhICm795wNcZJUdnuxwpuxFdPe16otWmVgtP3FzNEKmTPfe5lE8rL8+eTOIzMTC
 Fw8e4vCZIiuQq7XizpnQDd/fPrl7tkuIW2qNrc5eDQtyHcVhF7mvg/G4uPnUB+ljfpwDIXEJf5j
 bJzBbvAL1S5Ba9mHKLRLdLlfH/kOQ98VQ4lvu8gVjaGbLy2cIm3xRLmMEmpLQiCN1nQ2GR88HiQ
 jOxjUevZDmX2akC218fADdKL9aaadZQKw4V5Awl0RnYw5BeWzJFui1INeYX+fM5eRupWuwbelNF
 B7Z51YdrnMVVaLXQRPeHH31UrmRAn4=
X-Received: by 2002:a17:90a:da8f:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3933b95e327mr15644282a91.14.1786826273885; 
 Sat, 15 Aug 2026 13:37:53 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 17/18] target/riscv: Pass first/last to
 get_physical_address_pmp
Date: Sat, 15 Aug 2026 13:37:29 -0700
Message-ID: <20260815203730.1468365-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/cpu_helper.c | 48 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 3318e82ea7..fb1250a4b8 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -899,12 +899,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
  *
  * @env: CPURISCVState
  * @prot: The returned protection attributes
- * @addr: The physical address to be checked permission
+ * @first, @last: The physical address range to be permission checked
  * @access_type: The type of MMU access
  * @mode: Indicates current privilege level.
  */
-static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
-                                    int size, MMUAccessType access_type,
+static int get_physical_address_pmp(CPURISCVState *env, int *prot,
+                                    hwaddr first, hwaddr last,
+                                    MMUAccessType access_type,
                                     privilege_mode_t mode)
 {
     pmp_priv_t pmp_priv;
@@ -915,8 +916,8 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
         return TRANSLATE_SUCCESS;
     }
 
-    pmp_has_privs = pmp_hart_has_privs(env, addr, size, 1 << access_type,
-                                       &pmp_priv, mode);
+    pmp_has_privs = pmp_hart_has_privs(env, first, last - first + 1,
+                                       1 << access_type, &pmp_priv, mode);
     if (!pmp_has_privs) {
         *prot = 0;
         return TRANSLATE_PMP_FAIL;
@@ -1142,6 +1143,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     base = base_root;
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
+        int pmp_prot, pmp_ret;
+
         if (i == 0) {
             idx = (addr >> (PGSHIFT + ptshift)) &
                            ((1 << (ptidxbits + widened)) - 1);
@@ -1174,10 +1177,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             pte_addr = base + idx * ptesize;
         }
 
-        int pmp_prot;
-        int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
-                                               sxlen_bytes,
-                                               MMU_DATA_LOAD, PRV_S);
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                           pte_addr + sxlen_bytes - 1,
+                                           MMU_DATA_LOAD, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
         }
@@ -1425,7 +1427,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
-                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+                                           pte_addr + sxlen_bytes - 1,
+                                           MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
         }
@@ -1655,8 +1658,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    int size = last - address + 1;
-    vaddr im_address;
     hwaddr pa = 0;
     int prot, prot2, prot_pmp;
     bool pmp_pma_violation = false;
@@ -1676,7 +1677,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address,
+        ret = get_physical_address(env, &pa, &prot, first,
                                    &env->guest_phys_fault_addr, access_type,
                                    mmu_idx, true, true, false, probe);
         /*
@@ -1692,11 +1693,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
         qemu_log_mask(CPU_LOG_MMU,
                       "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
                       HWADDR_FMT_plx " prot %d\n",
-                      __func__, address, ret, pa, prot);
+                      __func__, first, ret, pa, prot);
 
         if (ret == TRANSLATE_SUCCESS) {
             /* Second stage lookup */
-            im_address = pa;
+            vaddr im_address = pa;
 
             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, MMUIdx_U, false, true,
@@ -1711,8 +1712,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
             prot &= prot2;
 
             if (ret == TRANSLATE_SUCCESS) {
-                ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                               size, access_type, mode);
+                ret = get_physical_address_pmp(env, &prot_pmp,
+                                               pa, pa + (last - first),
+                                               access_type, mode);
                 tlb_size = pmp_get_tlb_size(env, pa);
 
                 qemu_log_mask(CPU_LOG_MMU,
@@ -1736,18 +1738,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
         }
     } else {
         /* Single stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address, NULL,
+        ret = get_physical_address(env, &pa, &prot, first, NULL,
                                    access_type, mmu_idx, true, false, false,
                                    probe);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
                       HWADDR_FMT_plx " prot %d\n",
-                      __func__, address, ret, pa, prot);
+                      __func__, first, ret, pa, prot);
 
         if (ret == TRANSLATE_SUCCESS) {
-            ret = get_physical_address_pmp(env, &prot_pmp, pa,
-                                           size, access_type, mode);
+            ret = get_physical_address_pmp(env, &prot_pmp,
+                                           pa, pa + (last - first),
+                                           access_type, mode);
             tlb_size = pmp_get_tlb_size(env, pa);
 
             qemu_log_mask(CPU_LOG_MMU,
@@ -1764,7 +1767,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+        tlb_set_page(cs, address & ~(tlb_size - 1),
+                     (pa + (address - first)) & ~(tlb_size - 1),
                      prot, mmu_idx, tlb_size);
         return true;
     } else if (probe) {
-- 
2.43.0


