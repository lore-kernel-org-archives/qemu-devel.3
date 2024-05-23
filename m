Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb6-0000gK-VC; Thu, 23 May 2024 19:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaQ-0006Qw-NK; Thu, 23 May 2024 19:11:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaO-0006Gg-EW; Thu, 23 May 2024 19:11:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8eaa14512so305581b3a.3; 
 Thu, 23 May 2024 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505858; x=1717110658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0OIGWXGUbgVeZfHYAO7jVYpw/01X/ceVaPnQiECOqQ=;
 b=MSUCjLR5TC5lCMypSic6FB0omyMGORJo/lbNphnXjzub1i8dQ8rH2qFME6jtDxz7iu
 a4tUhPE/wuJA+Op4XnFWqVlXQzsLYisShHWurvOP5Dw1fWTYYMCniox/KZBSAgM0Kw+O
 ZNWUd20BJ1aSovce+v0b+dFHA/YQZE7f1OPrMmrAr2gQWS0OzZoaur9rPEhCcLZ+2xjq
 1sYf/4DlfoQh2Kaz25UOxHHMbVZSd7Jxblx8jLN47/LtEao323qKDyj1KUXswe6gtNnX
 V9oqivFkYW6oKm/ca0aOIh25dpo2lazvsGmZicamV2G78Lb9Nllu9J1xaQlmPfuWy4N6
 d7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505858; x=1717110658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0OIGWXGUbgVeZfHYAO7jVYpw/01X/ceVaPnQiECOqQ=;
 b=vu3447G0E3vz66kjeWABp+m6n5wIbeOIh/BASbW2eRfbZCz+tpLeY3AZEk8tk1Mhmp
 KmH1VxyfRWNqzlT3wZre0+whrJ9GtI8iuADaQvI4jQwrZS3muzuOw/58TnFazNxf9Nxa
 FMzmcxKUMTumZBvdINexYZJSFxCX5upmZviu5e2EFRQsWj4o7dSVo0b6y1k37N6cv94Q
 RCrwwZa3E0vimhW5vlYxskvHoZqj7+c9yxn3WYeCLahdssRUJGLFV+kOzjVA44ki8jt5
 3u4zoodN66heUUXYw1s22LiKinWmM6D7qg1hTdRDpj+052Mxe+DDwNlLihdZxh3uV8lb
 zNcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuh4jp63c2kJby9PCc0/1WPITHRD+RB+XH5BML/P7k9+PMdGNxnKwJv2wJR/Y9xBxQNEuGtvsJp2HvKVA/jVPMTyAD
X-Gm-Message-State: AOJu0YwoT2wc6X4bfp/yFopvzvv/RvD5fAiHJ/W9nOR0ahLzWNPzqdOH
 ue2jHOhTyPD5fQjTWYBiQLuLyY31KZ5MCB1+YVsgv/VWgRxdUx797T4Q0g==
X-Google-Smtp-Source: AGHT+IG/7cN/LaMJM6BEXAd8Q+9ADj9aDoBOKRU5TyyKEpeIFDyLfbwjIoBCdi0cPrkO4RTjur7Jwg==
X-Received: by 2002:a05:6a00:4c12:b0:6f3:ea67:48c3 with SMTP id
 d2e1a72fcca58-6f8f1a66df5mr802438b3a.0.1716505857713; 
 Thu, 23 May 2024 16:10:57 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 59/72] target/ppc/mmu_common.c: Split off BookE handling from
 ppc_jumbo_xlate()
Date: Fri, 24 May 2024 09:07:32 +1000
Message-ID: <20240523230747.45703-60-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Introduce ppc_booke_xlate() to handle BookE and BookE 2.06 cases to
reduce ppc_jumbo_xlate() further.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 146 ++++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 50 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6c6c7c55b6..09a780bb7a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1117,21 +1117,9 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    bool real_mode;
-
-    if (env->mmu_model == POWERPC_MMU_BOOKE) {
-        return mmubooke_get_physical_address(env, &ctx->raddr, &ctx->prot,
-                                             eaddr, access_type);
-    } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        return mmubooke206_get_physical_address(env, &ctx->raddr, &ctx->prot,
-                                                eaddr, access_type, mmu_idx);
-    }
-
-    real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-                                      : !FIELD_EX64(env->msr, MSR, DR);
-    if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
-                      env->mmu_model == POWERPC_MMU_SOFT_4xx ||
-                      env->mmu_model == POWERPC_MMU_REAL)) {
+    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
+                                           : !FIELD_EX64(env->msr, MSR, DR);
+    if (real_mode) {
         ctx->raddr = eaddr;
         ctx->prot = PAGE_RWX;
         return 0;
@@ -1205,6 +1193,93 @@ static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
     env->spr[SPR_BOOKE_MAS0] |= env->last_way << MAS0_NV_SHIFT;
 }
 
+static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                            MMUAccessType access_type,
+                            hwaddr *raddrp, int *psizep, int *protp,
+                            int mmu_idx, bool guest_visible)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    hwaddr raddr;
+    int prot, ret;
+
+    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        ret = mmubooke206_get_physical_address(env, &raddr, &prot, eaddr,
+                                               access_type, mmu_idx);
+    } else {
+        ret = mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
+                                            access_type);
+    }
+    if (ret == 0) {
+        *raddrp = raddr;
+        *protp = prot;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (!guest_visible) {
+        return false;
+    }
+
+    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
+    if (access_type == MMU_INST_FETCH) {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_ITLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            env->error_code = 0;
+            break;
+        case -3:
+            /* No execute protection violation */
+            cs->exception_index = POWERPC_EXCP_ISI;
+            env->spr[SPR_BOOKE_ESR] = 0;
+            env->error_code = 0;
+            break;
+        }
+    } else {
+        switch (ret) {
+        case -1:
+            /* No matches in page tables or TLB */
+            switch (env->mmu_model) {
+            case POWERPC_MMU_BOOKE206:
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
+                /* fall through */
+            case POWERPC_MMU_BOOKE:
+                cs->exception_index = POWERPC_EXCP_DTLB;
+                env->error_code = 0;
+                env->spr[SPR_BOOKE_DEAR] = eaddr;
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+        case -2:
+            /* Access rights violation */
+            cs->exception_index = POWERPC_EXCP_DSI;
+            env->error_code = 0;
+            env->spr[SPR_BOOKE_DEAR] = eaddr;
+            env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
+            break;
+        }
+    }
+    return false;
+}
+
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
@@ -1257,15 +1332,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_DEAR] = eaddr;
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_ITLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
             case POWERPC_MMU_REAL:
                 cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
@@ -1276,23 +1342,12 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         case -2:
             /* Access rights violation */
             cs->exception_index = POWERPC_EXCP_ISI;
-            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                env->error_code = 0;
-            } else {
-                env->error_code = 0x08000000;
-            }
+            env->error_code = 0x08000000;
             break;
         case -3:
             /* No execute protection violation */
-            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                env->spr[SPR_BOOKE_ESR] = 0x00000000;
-                env->error_code = 0;
-            } else {
-                env->error_code = 0x10000000;
-            }
             cs->exception_index = POWERPC_EXCP_ISI;
+            env->error_code = 0x10000000;
             break;
         case -4:
             /* Direct store exception */
@@ -1333,15 +1388,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                /* fall through */
-            case POWERPC_MMU_BOOKE:
-                cs->exception_index = POWERPC_EXCP_DTLB;
-                env->error_code = 0;
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
-                break;
             case POWERPC_MMU_REAL:
                 cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
@@ -1358,10 +1404,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 if (access_type == MMU_DATA_STORE) {
                     env->spr[SPR_40x_ESR] |= 0x00800000;
                 }
-            } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                       (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
             } else {
                 env->spr[SPR_DAR] = eaddr;
                 if (access_type == MMU_DATA_STORE) {
@@ -1440,6 +1482,10 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_32B:
         return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_BOOKE:
+    case POWERPC_MMU_BOOKE206:
+        return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
+                               psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
-- 
2.43.0


