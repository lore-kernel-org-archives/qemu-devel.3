Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqO-00035f-GH; Fri, 10 Jan 2025 09:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqN-00034u-14
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqK-0005CF-P9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/277w1S0kscb0eXMhlutgklQ1d5FuYHAxacfqURKqA=;
 b=hUg/u7sgC2r+gIpNfUNFLVDvP3l/Fp2OvN9E4FOONZmvEDBI5hfU0wPhdw4yOer6dgPlz+
 V1ZW1ut0ppkjA4lDYDc4+Re4uiXTM6b3Z1W1C7PIbLm03OmrfXF+Xr8EAVFbXHoyWLq6cr
 qzINABkylwPAP7GfQHV8u5FQ0pN+RXo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-1Dpd49lBNUCDon6yVztVTw-1; Fri,
 10 Jan 2025 09:18:28 -0500
X-MC-Unique: 1Dpd49lBNUCDon6yVztVTw-1
X-Mimecast-MFC-AGG-ID: 1Dpd49lBNUCDon6yVztVTw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23DDE19560B0; Fri, 10 Jan 2025 14:18:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B1EC195E3DE; Fri, 10 Jan 2025 14:18:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 9/9] ppc/ppc405: Remove POWERPC_MMU_SOFT_4xx MMU model
Date: Fri, 10 Jan 2025 15:18:00 +0100
Message-ID: <20250110141800.1587589-10-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Since the 405 CPU family was phased out, this MMU model has no users
anymore.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu.h         |  6 ----
 target/ppc/mmu-booke.h   |  3 --
 target/ppc/excp_helper.c |  3 --
 target/ppc/mmu-booke.c   | 63 -----------------------------------
 target/ppc/mmu_common.c  | 71 ----------------------------------------
 target/ppc/mmu_helper.c  | 16 ---------
 6 files changed, 162 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6850d67b6875..8056c917efb1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -232,8 +232,6 @@ typedef enum powerpc_mmu_t {
      * keywords: tlbld tlbli TLBMISS PTEHI PTELO)
      */
     POWERPC_MMU_SOFT_74xx  = 0x00000003,
-    /* PowerPC 4xx MMU with software TLB                       */
-    POWERPC_MMU_SOFT_4xx   = 0x00000004,
     /* PowerPC MMU in real mode only                           */
     POWERPC_MMU_REAL       = 0x00000006,
     /* Freescale MPC8xx MMU model                              */
@@ -2146,7 +2144,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_7XX_UPMC3         (0x3AD)
 #define SPR_7XX_UPMC4         (0x3AE)
 #define SPR_USDA              (0x3AF)
-#define SPR_40x_ZPR           (0x3B0)
 #define SPR_BOOKE_MAS7        (0x3B0)
 #define SPR_74XX_MMCR2        (0x3B0)
 #define SPR_7XX_PMC5          (0x3B1)
@@ -2181,13 +2178,10 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_ICDBDR      (0x3D3)
 #define SPR_TLBMISS           (0x3D4)
 #define SPR_IMISS             (0x3D4)
-#define SPR_40x_ESR           (0x3D4)
 #define SPR_PTEHI             (0x3D5)
 #define SPR_ICMP              (0x3D5)
-#define SPR_40x_DEAR          (0x3D5)
 #define SPR_PTELO             (0x3D6)
 #define SPR_RPA               (0x3D6)
-#define SPR_40x_EVPR          (0x3D6)
 #define SPR_L3PM              (0x3D7)
 #define SPR_403_CDBCR         (0x3D7)
 #define SPR_L3ITCR0           (0x3D8)
diff --git a/target/ppc/mmu-booke.h b/target/ppc/mmu-booke.h
index f972843bbb7b..dcbfac2caefe 100644
--- a/target/ppc/mmu-booke.h
+++ b/target/ppc/mmu-booke.h
@@ -4,9 +4,6 @@
 #include "cpu.h"
 
 int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
-int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *prot,
-                                target_ulong address,
-                                MMUAccessType access_type);
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
                      target_ulong address, uint32_t pid);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1a4c0ae5c0f0..b795d1969d01 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3040,9 +3040,6 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     insn = ppc_ldl_code(env, env->nip);
 
     switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_4xx:
-        env->spr[SPR_40x_DEAR] = vaddr;
-        break;
     case POWERPC_MMU_BOOKE:
     case POWERPC_MMU_BOOKE206:
         env->spr[SPR_BOOKE_DEAR] = vaddr;
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b0c..3bb721c3d2c6 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -68,69 +68,6 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
     return -1;
 }
 
-int mmu40x_get_physical_address(CPUPPCState *env, hwaddr *raddr, int *prot,
-                                target_ulong address,
-                                MMUAccessType access_type)
-{
-    ppcemb_tlb_t *tlb;
-    int i, ret, zsel, zpr, pr;
-
-    ret = -1;
-    pr = FIELD_EX64(env->msr, MSR, PR);
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, raddr, address,
-                              env->spr[SPR_40x_PID], i)) {
-            continue;
-        }
-        zsel = (tlb->attr >> 4) & 0xF;
-        zpr = (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
-                      __func__, i, zsel, zpr, access_type, tlb->attr);
-        /* Check execute enable bit */
-        switch (zpr) {
-        case 0x2:
-            if (pr != 0) {
-                goto check_perms;
-            }
-            /* fall through */
-        case 0x3:
-            /* All accesses granted */
-            *prot = PAGE_RWX;
-            ret = 0;
-            break;
-
-        case 0x0:
-            if (pr != 0) {
-                /* Raise Zone protection fault.  */
-                env->spr[SPR_40x_ESR] = 1 << 22;
-                *prot = 0;
-                ret = -2;
-                break;
-            }
-            /* fall through */
-        case 0x1:
-check_perms:
-            /* Check from TLB entry */
-            *prot = tlb->prot;
-            if (check_prot_access_type(*prot, access_type)) {
-                ret = 0;
-            } else {
-                env->spr[SPR_40x_ESR] = 0;
-                ret = -2;
-            }
-            break;
-        }
-    }
-    qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
-                  HWADDR_FMT_plx " %d %d\n",  __func__,
-                  ret < 0 ? "refused" : "granted", address,
-                  ret < 0 ? 0 : *raddr, *prot, ret);
-
-    return ret;
-}
-
 static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
                                hwaddr *raddr, target_ulong addr, int i)
 {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index fb62b947f1d9..1748d088ac15 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -599,74 +599,6 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
-static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                          MMUAccessType access_type,
-                          hwaddr *raddrp, int *psizep, int *protp,
-                          int mmu_idx, bool guest_visible)
-{
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
-    int ret;
-
-    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
-        return true;
-    }
-
-    ret = mmu40x_get_physical_address(env, raddrp, protp, eaddr, access_type);
-    if (ret == 0) {
-        *psizep = TARGET_PAGE_BITS;
-        return true;
-    } else if (!guest_visible) {
-        return false;
-    }
-
-    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
-    if (access_type == MMU_INST_FETCH) {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_ITLB;
-            env->error_code = 0;
-            env->spr[SPR_40x_DEAR] = eaddr;
-            env->spr[SPR_40x_ESR] = 0x00000000;
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_ISI;
-            env->error_code = 0x08000000;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        switch (ret) {
-        case -1:
-            /* No matches in page tables or TLB */
-            cs->exception_index = POWERPC_EXCP_DTLB;
-            env->error_code = 0;
-            env->spr[SPR_40x_DEAR] = eaddr;
-            if (access_type == MMU_DATA_STORE) {
-                env->spr[SPR_40x_ESR] = 0x00800000;
-            } else {
-                env->spr[SPR_40x_ESR] = 0x00000000;
-            }
-            break;
-        case -2:
-            /* Access rights violation */
-            cs->exception_index = POWERPC_EXCP_DSI;
-            env->error_code = 0;
-            env->spr[SPR_40x_DEAR] = eaddr;
-            if (access_type == MMU_DATA_STORE) {
-                env->spr[SPR_40x_ESR] |= 0x00800000;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-    return false;
-}
-
 static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
                           MMUAccessType access_type,
                           hwaddr *raddrp, int *psizep, int *protp,
@@ -832,9 +764,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_BOOKE206:
         return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
-    case POWERPC_MMU_SOFT_4xx:
-        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
-                             psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_SOFT_6xx:
         return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
                              psizep, protp, mmu_idx, guest_visible);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index faa4522ec8b0..36e06de0e36c 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -107,19 +107,6 @@ static void ppc6xx_tlb_store(CPUPPCState *env, target_ulong EPN, int way,
     env->last_way = way;
 }
 
-/* Helpers specific to PowerPC 40x implementations */
-static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
-{
-    ppcemb_tlb_t *tlb;
-    int i;
-
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        tlb->prot &= ~PAGE_VALID;
-    }
-    tlb_flush(env_cpu(env));
-}
-
 static void booke206_flush_tlb(CPUPPCState *env, int flags,
                                const int check_iprot)
 {
@@ -258,9 +245,6 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
     case POWERPC_MMU_SOFT_6xx:
         ppc6xx_tlb_invalidate_all(env);
         break;
-    case POWERPC_MMU_SOFT_4xx:
-        ppc4xx_tlb_invalidate_all(env);
-        break;
     case POWERPC_MMU_REAL:
         cpu_abort(env_cpu(env), "No TLB for PowerPC 4xx in real mode\n");
         break;
-- 
2.47.1


