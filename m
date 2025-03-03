Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967F6C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3tR-0002qd-Le; Mon, 03 Mar 2025 06:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tQ-0002oa-FY; Mon, 03 Mar 2025 06:23:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tO-00076J-Mp; Mon, 03 Mar 2025 06:23:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2234bec7192so57714735ad.2; 
 Mon, 03 Mar 2025 03:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741001004; x=1741605804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Sd3DVVAXD6tqmCQ5NglFT6kDc4plDf6NJTVkHPAxEw=;
 b=FOABHUmuM8mAk7oYpEpSE1fytTt5gJvwUhighZbYYaJ2c+s82sXDwBfXZ03wJOAapo
 FPz/1PZOz5QDN7mvGRIeof344eDxdM+2jWPCWsbr1DIIl3Pi6ITwMNCxYbjtmN/uUxZk
 lTKuV4SkkprQv5rzUCjwbUqQQyaFozpE5c6NJDdgAvSc/QSB4yEN6vuxdVi/4qvOBLtl
 SjB9maHT/0LAs0BYH1ucy97pnbH0uhevRS4uvmRyxH32dNQT3m8MM2TdY2hH2u20hAFL
 7tHrn7jodMO9tZuox8sFLCzI5RvEpMnZYm8+jLlNbBu8t/4LNpL2+TRF7WRg5kZb+7cM
 S8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001004; x=1741605804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Sd3DVVAXD6tqmCQ5NglFT6kDc4plDf6NJTVkHPAxEw=;
 b=iarYa+f9o969To3VJIdgCxR6bfVw0t68xjVtB/Ik0iQ3Ye1Q6MMKg1C1o4FCA8yoCT
 V/zXA4kZw73jcH7XeKfg14diiLurAEBPnPX+wvzoqcJVfu0B9wtG0IjzIUiMF763KdoT
 eZ7qOzFo7DIXjkDYIdqJvUVn3nFgU0reepUhnGIopcz0jHwvqIbeuvLxSeQB28n/Jia5
 fOUYj0qwfBQgnPGfvdm62EafwLoTPzQoO780FQD9zyN+/2pkHNJUxaa+0MTsjvGK8iW8
 6Lhi9oTOixfuKGgm/wvuVLo5vIUgk8OIUXOClHFHCcoAhzr8Xa8bq8ap7YOstNx7LKx6
 V/dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVgWELbBiBXlB/+PG5b0UQXaIsc2SLtKXAqiY/98CuMhYOE8usUpfClgVyKxuHWw//QfjNxvi+NlWS@nongnu.org
X-Gm-Message-State: AOJu0YyjiNauuqkHzSG0rOlcy7LWrIzB2ygI/zA1GXp1VImjDxioSZL9
 p0R1tLrC7WW4mL1l5eYygxE25y7cxPPu8eWn+RgT+5D0pPzk9iu7bNsW+w==
X-Gm-Gg: ASbGncuZJt/NBMaIV/CjzFhDe71V9C06UN8sP7XrE9Dl2OAcWFX1L6nWUmv15w37Rp3
 GuyHQrjciT/RCSV4EGYj0hQzLbxvzVH2Pc4QXiouwT5t+B+OIXWHT/yVJpZSy9CBYNoNUVpMKwI
 10kDfCel/KvhPSiblG6Ii8XkbVjy/rQU3bduuYb39Y/cvU10atIUmq68Jw2d4HxUrnNS794mwZA
 qv9qHFqvup4HaLMHTshXlNv0zqj1B5i4NlqxEEsZlz2lDMY8C0D9twfsYw+MgC0RuFskm8BXL6K
 BlncqrCodVlAfCUG0FB40Sg/ILRJO+2rAWYpT+4y5KbS+TDcTnk=
X-Google-Smtp-Source: AGHT+IH4AFJ2Ae0Ld9F0SzXxZbtEYkhwNpf+03J/yylh5B7tZdZUK2c6IQccTvpQOVPlZ9smAdPjSA==
X-Received: by 2002:a17:903:33cc:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-22368f60ac5mr180058215ad.5.1741001003763; 
 Mon, 03 Mar 2025 03:23:23 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e3bsm75388875ad.82.2025.03.03.03.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 03:23:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/ppc: flush TLB on HRMOR and LPCR SPR updates
Date: Mon,  3 Mar 2025 21:23:12 +1000
Message-ID: <20250303112315.586478-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303112315.586478-1-npiggin@gmail.com>
References: <20250303112315.586478-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

The HRMOR and LPCR registers are involved with MMU translations that
are not tagged in the TLB (i.e., with mmuidx), so the TLB needs to be
flushed when these are changed, e.g., as PIDR, LPIDR already do.
target/ppc: add missing TLB flushes for MMU SPR updates

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h      |  1 +
 target/ppc/spr_common.h  |  1 +
 target/ppc/cpu.c         |  4 ++++
 target/ppc/cpu_init.c    |  2 +-
 target/ppc/misc_helper.c | 23 +++++++++++++++++++++++
 target/ppc/translate.c   | 10 ++++++++++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a77e761bd3..6178ebe138f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -723,6 +723,7 @@ DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_2(store_hrmor, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
 DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 01aff449bcc..8cac82b2dac 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -177,6 +177,7 @@ void spr_write_pidr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpidr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_hior(DisasContext *ctx, int gprn, int sprn);
 void spr_write_hior(DisasContext *ctx, int sprn, int gprn);
+void spr_write_hrmor(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_pcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index d148cd76b47..cdd50cb36d6 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
+#include "exec/exec-all.h"
 #include "exec/log.h"
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
@@ -101,6 +102,9 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
     /* The gtse bit affects hflags */
     hreg_compute_hflags(env);
 
+    /* Various untagged bits affect translation (e.g., TC, HR, etc). */
+    tlb_flush(env_cpu(env));
+
     ppc_maybe_interrupt(env);
 }
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 062a6e85fba..92316b55afd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5496,7 +5496,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_core_write_generic,
+                 &spr_read_generic, &spr_write_hrmor,
                  0x00000000);
 }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b2..179e8b6b4d2 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -169,6 +169,29 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 }
 
 #if defined(TARGET_PPC64)
+void helper_store_hrmor(CPUPPCState *env, target_ulong val)
+{
+    if (env->spr[SPR_HRMOR] != val) {
+        CPUState *cs = env_cpu(env);
+
+        qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, val);
+
+        if (ppc_cpu_lpar_single_threaded(cs)) {
+            env->spr[SPR_HRMOR] = val;
+            tlb_flush(cs);
+        } else {
+            CPUState *ccs;
+
+            THREAD_SIBLING_FOREACH(cs, ccs) {
+                PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+                CPUPPCState *cenv = &ccpu->env;
+                cenv->spr[SPR_HRMOR] = val;
+                tlb_flush(ccs);
+            }
+        }
+    }
+}
+
 void helper_store_ptcr(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_PTCR] != val) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80638ab5359..ac910151cfa 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -909,6 +909,16 @@ void spr_write_hior(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_andi_tl(t0, cpu_gpr[gprn], 0x3FFFFF00000ULL);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPUPPCState, excp_prefix));
 }
+
+void spr_write_hrmor(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
+    gen_helper_store_hrmor(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
 {
     if (!gen_serialize_core(ctx)) {
-- 
2.47.1


