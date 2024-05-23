Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHab-0006ow-FP; Thu, 23 May 2024 19:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZl-00037z-33; Thu, 23 May 2024 19:10:21 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZi-000666-VZ; Thu, 23 May 2024 19:10:20 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3737bc62884so870415ab.1; 
 Thu, 23 May 2024 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505816; x=1717110616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BpHgmg8vkBNPqt3TbYQHWcRZAKjdhW0RXAY1aIvRew=;
 b=Zw2HyuU8kReepyiFD/AIEYw3Hsc3x0iP8tv1j9kU+4pOM/J7A+xH7zWv1xqIcExSjv
 FlnQrl3ID7B4AbOmtPZBYexomB186h7T0MY6RAuB2GBQeVOxlDpcMnyd+UmbjE/Gcoey
 cuQdWp4/4u8Trn5CEt28ut76caNACfmmk0FGc9S3k1U52Or+uTb4+X2jxZ9+qQBsO/wl
 PCQMcELsDAQj9fP7vPeCwoXLbP4DXjQHb5T14ACWmAKgnEbV5/LR82N2sekAzRe1KMqb
 tJDEF91Xu3GsXLEh7adIRiKcbChrzjAIO0piIII+bNiVoBeHquMw0GrhvVsRuIb+MT08
 pipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505816; x=1717110616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BpHgmg8vkBNPqt3TbYQHWcRZAKjdhW0RXAY1aIvRew=;
 b=Odi3C895n7ZiRZW7ccy6Ir9+m9lZZvGesYXJJ8ilWt4i0bHJuW5fVp3ZDUYsXu0Npi
 MTzxTSWcBjqh4dKUP/GARH61FJVQ6E/kYBXVt19w0XqnxgH491R7xnRzqSuVfcaxcYod
 f5lbx3emOX9xBgGxMV4N+MtXcK9ZnOiWNNszoAzMobRkLtamzBk/QhwgACmUCsP0rfnu
 GVznK5PNLiNDLBLwV+E1DnydxqW66lG13IeVSMzj27yXXVqqlwVUf+ihAEjMnvTggh/m
 Wq262eZJAOuDAxL8l5w9afQwi44A/7kSOSI6PY3dc1h7S4hx3Ekd4nWTuhNwr6aox6IS
 pHlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODZHrIrkFA0kixJTPfWQ8/kQTtj9y2W5pdQkYewDfuZxsWjKJzi6mQbD+32tAl+K9o6f3RvSdQzT7++480YMo7F7G
X-Gm-Message-State: AOJu0YwF7gHQrGHU2Q3cxWbtZZPk2DDfRaz+TuHQphWvY3aFzVSZ2orT
 t/ZxJT3aamZrFDwpD722fbM3D+OaEq4VQ6UJZFrX4sGO8/Sbpqc7lyed9A==
X-Google-Smtp-Source: AGHT+IF+b3FP70wHEjHg0E2ENeXiX1S++VrIS9/RW7tUA2H1sChjbVAFyhcW/c9Cw7Imz35oyPrNIw==
X-Received: by 2002:a05:6e02:1b02:b0:36d:bbf7:2fd7 with SMTP id
 e9e14a558f8ab-3737b2953cfmr9191175ab.12.1716505816049; 
 Thu, 23 May 2024 16:10:16 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 45/72] target/ppc/mmu_common.c: Introduce
 mmu6xx_get_physical_address()
Date: Fri, 24 May 2024 09:07:18 +1000
Message-ID: <20240523230747.45703-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x133.google.com
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

Repurpose get_segment_6xx_tlb() to do the whole address translation
for POWERPC_MMU_SOFT_6xx MMU model by moving the BAT check there and
renaming it to match other similar functions. These are only called
once together so no need to keep these separate functions and
combining them simplifies the caller allowing further restructuring.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 3391df61cb..b7c07cf515 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -360,19 +360,23 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-/* Perform segment based translation */
-static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                               target_ulong eaddr, MMUAccessType access_type,
-                               int type)
+static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
+                                       target_ulong eaddr,
+                                       MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
-    target_ulong vsid;
+    target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
     bool pr;
     int ret;
-    target_ulong sr, pgidx;
 
+    /* First try to find a BAT entry if there are any */
+    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
+        return 0;
+    }
+
+    /* Perform segment based translation when no BATs matched */
     pr = FIELD_EX64(env->msr, MSR, PR);
     ctx->eaddr = eaddr;
 
@@ -1194,14 +1198,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
         } else {
-            /* Try to find a BAT */
-            if (env->nb_BATs != 0) {
-                ret = get_bat_6xx_tlb(env, ctx, eaddr, access_type);
-            }
-            if (ret < 0) {
-                /* We didn't match any BAT entry or don't have BATs */
-                ret = get_segment_6xx_tlb(env, ctx, eaddr, access_type, type);
-            }
+            ret = mmu6xx_get_physical_address(env, ctx, eaddr, access_type,
+                                              type);
         }
         break;
 
-- 
2.43.0


