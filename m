Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5AEC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHay-0007vz-Mw; Thu, 23 May 2024 19:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHan-0007BK-3I; Thu, 23 May 2024 19:11:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHae-0006Ig-TG; Thu, 23 May 2024 19:11:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so315682b3a.0; 
 Thu, 23 May 2024 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505873; x=1717110673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/vQy1AEw3bNJxbewjOw5vei/7FsE9zjD016urKfNOo=;
 b=eVcVDmjG12txo1O4pD2QcZDu9QzsAiIpI+hb2tbxPO/bo5wQeGJWHe6leNwyt50KOV
 NuAceMsWhq4W5vWfFEKCf/7dpPpnhUFfI5UPJmmXVo4srDIs0fvhuNzcXpGrdC4DcJjf
 AqocR8wcRK2KuU/z3e7Uwrf39bHVdaGhQ1DnCGLnmv57lwRi5UmiKiwinVfxP1kxqHy2
 URgoSJY4yX6XtRNuyY32z8c9tpvzAOoBlBsqJc+6Q4VsgUjSk2FIVl0TTKRqoT6bpkoY
 7yhTX5/KdddglsSr5wdcn6+Tnnyke0jgru26Na4W+vIaBgS/HBG4L2T5JIgFk8iBYKi4
 eZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505873; x=1717110673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/vQy1AEw3bNJxbewjOw5vei/7FsE9zjD016urKfNOo=;
 b=jGHGo+y4Sqjgjr9fwsxYFO8b6yjfUAUvRE4c+OzOrgmH7vTvDv1txRrHAzwC/mONIS
 xNS0zSECrqT4sz+jqz81776q7eRtV3m59FTcAM3htDRX72gEfyYW5tcPzcPSGcEoGB0Q
 ZDAVCWgSM3TOo1lhbqNv1kJoakZwa4GImdhoWFYKy8nFZxJ8dghShS/3s7tKq78ASU8O
 gZizqh6DtK9Aer5WGWjmP+KmOyogbyv6NZxyghAKtZl4JSY8RjnCaqV71+hdCmGDiL3m
 YjGJcvHt2d6jwatzfQNzsmJrUYrYHs7eoDcWeNyfMw6c5Bj8GDARtvhA2rNOpAq+qF1m
 htww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZxKZHPZwiqxw6Jmx3ZdnEQ74e85hM9BaCPh9e9HePnFEnxRmZMv1fFdv57gq2jMWQ5wdzRPGQMbuWWwxDx0+ph7SQ
X-Gm-Message-State: AOJu0YxBrTEhLisjf4pQXxcxOvWsqq2FsqgaYbMFjru2B6bhGHbCkXr1
 sJoysc6X58M/3S9DHRUijOTub88CwiXTW4G/tnvyofWOd3S8tf4SL/Em3w==
X-Google-Smtp-Source: AGHT+IHFqKRE25e3jSOgFh5Chb9DQMYUv9RzqKMDOjaKicDFovbfxReQp8ByKttU01rZedDfVFp7eA==
X-Received: by 2002:a05:6a00:f09:b0:6ed:41f3:cd06 with SMTP id
 d2e1a72fcca58-6f8f2a49069mr704976b3a.7.1716505873376; 
 Thu, 23 May 2024 16:11:13 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 64/72] target/ppc/mmu_common.c: Transform ppc_jumbo_xlate()
 into ppc_6xx_xlate()
Date: Fri, 24 May 2024 09:07:37 +1000
Message-ID: <20240523230747.45703-65-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that only 6xx cases left in ppc_jumbo_xlate() we can change it
to ppc_6xx_xlate() also removing get_physical_address_wtlb().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/internal.h   |  5 +----
 target/ppc/mmu_common.c | 38 ++++++++++++--------------------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 98b41a970c..4a4f9b9ec8 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -262,10 +262,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx);
+
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ddb014e0aa..961062bca1 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1112,22 +1112,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx)
-{
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
-    case POWERPC_MMU_SOFT_4xx:
-        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
-                                           access_type);
-    default:
-        cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
-    }
-}
-
 static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
                                          MMUAccessType access_type, int mmu_idx)
 {
@@ -1326,12 +1310,10 @@ static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
-/* Perform address translation */
-/* TODO: Split this by mmu_model. */
-static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                            MMUAccessType access_type,
-                            hwaddr *raddrp, int *psizep, int *protp,
-                            int mmu_idx, bool guest_visible)
+static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                          MMUAccessType access_type,
+                          hwaddr *raddrp, int *psizep, int *protp,
+                          int mmu_idx, bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -1353,8 +1335,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ret = get_physical_address_wtlb(env, &ctx, eaddr, access_type,
-                                    type, mmu_idx);
+    ctx.prot = 0;
+    ctx.hash[0] = 0;
+    ctx.hash[1] = 0;
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
@@ -1498,14 +1482,16 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_SOFT_4xx:
         return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
                              psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_SOFT_6xx:
+        return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
+                             psizep, protp, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
         return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
                                    protp);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
-        return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
-                               psizep, protp, mmu_idx, guest_visible);
+        cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
     }
 }
 
-- 
2.43.0


