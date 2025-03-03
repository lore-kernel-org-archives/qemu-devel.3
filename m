Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC3C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3tY-0002wY-40; Mon, 03 Mar 2025 06:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tU-0002vX-Qp; Mon, 03 Mar 2025 06:23:32 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tS-00077K-RS; Mon, 03 Mar 2025 06:23:32 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2feb9076a1cso6586048a91.0; 
 Mon, 03 Mar 2025 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741001008; x=1741605808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TI7o/qEAGPSuly/owjhhS2EmzO3Fc7cBJEztAx9lX1I=;
 b=SUc6FVKVk8JsMVp2Dweb0ELJJsXnV7aFvU0qMkN5Fmh+f4Fxt0bbIupjo+KyTbjaFO
 p0LvlREUEQQ4SdC+mW77yskTdIF/Vs/WwTdnfno44K9tn8oDeE3Qb3XdUqdl+K5s/upq
 3TRM1J4f3YEH9TThdyQozIECBW7N+Ms9PqaU+1FIQxc5ZVjC/atK5dlqt+sYUR+OCiAm
 Yq1Ox26jP7QJkytMClpSwe3mv6DVBTBWgM/hn/zqCQnXP95LLXF9wabM0Mlxc7ZE2QEV
 VOR8e9VWL/1k+V2nXzpPf+W3p512sKT5UXS1umgjofh0JLjbM4W5yNSfN6Ft62Da9WbI
 /x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001008; x=1741605808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TI7o/qEAGPSuly/owjhhS2EmzO3Fc7cBJEztAx9lX1I=;
 b=Qr0wO3MMWEpuP4L7gaYC1k1wmsBn4FqEVxGBUaeuFiMRcJwCsOmD3fmw7h4HDqxYKt
 CezNCLBtTZxPRXks6dLDbxlro4aEZ7TFUbnXObcObtuTouR/eCTkg8a3u/8qxY9ZrrAc
 3C7CGTggr40/cfnSOvw2y0jypitc3NvFNEYAtNhIpAVN36kJDxrAeSrMK22nSsOy6I6n
 RT6GqCn8xwH8OWN/x5SOOqLQbONN/UQ9TGJ2si12ZxhR4V+mp7gikm7KD8KJjgLBL3M/
 f3qwtorX6ndClg8p6jLC73HAEse9uk1M3u0NJh+5PSuJKmh6xwN8T6n025etYUm2QXFh
 ak4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfPW6yo/bDhJivhPdA9LBs8Oqflb6AMrdO9uqraHX8FzOGqyRrVSjUGf+LjfAjiM9MpqOUfZEGMKK@nongnu.org
X-Gm-Message-State: AOJu0YyBSPvnEBXVpIcD4CKsdo+0a9Vt2SL15CG0PHpPessZUANbc//Z
 Q/x0f2JO3Dn3w0ZcXxj2rWwaaMjmDem7VxcKx1Xeo6JXXfBA4Bv6376oqQ==
X-Gm-Gg: ASbGnctj+TM0CqkMTweIPf6MPSfuLGGEg3maUyvCfZnvsdANxAktBOASaG+E/ugF64E
 79gpa3Lx5uFDCAM5C3rHCRm0l73zWZLEoBiwd1lqpXPyWhQkJ0pl9ulh+J+fDuc/r0JGccOxpYH
 p3R5OLELgGn6RvPuM+GiCONhVG0xhxRjn80btTIjs/O1eaMZfgPSrFtBgqgyuDiqdQtDSFTS7qA
 fhIy18DyR6OYU2fwOezQ4ngxQ1d59Mywt9fP5ZtCR12itLZ5GqeYILsCBtBYPTMth9izl+Naj7n
 rd41OXlb76Ea//Y8cn4YyQArKBQMwYgpUlrkyAXAk9yryTGtGOw=
X-Google-Smtp-Source: AGHT+IEKO7rqC9gDjctM1FehSt5U9EYkDcUll1IwzNQTGcDajBJMU1A5VOGM/MDNL0T6yQrpdNF0pA==
X-Received: by 2002:a17:90b:4c11:b0:2ee:a4f2:b307 with SMTP id
 98e67ed59e1d1-2febab2ebcfmr19902859a91.4.1741001008575; 
 Mon, 03 Mar 2025 03:23:28 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e3bsm75388875ad.82.2025.03.03.03.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 03:23:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/ppc: add missing TLB flushes for memory protection
 key SPR updates
Date: Mon,  3 Mar 2025 21:23:14 +1000
Message-ID: <20250303112315.586478-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303112315.586478-1-npiggin@gmail.com>
References: <20250303112315.586478-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

The IAMR and AMR registers are involved with MMU translations that
are not tagged in the TLB (i.e., with mmuidx), so the TLB needs to be
flushed when these are changed, e.g., as PIDR, LPIDR already do.

This moves AMR and IAMR write to helpers rather than use tlb_need_flush
because they can be written in problem state where tlb_need_flush is not
checked.

XXX: As far as I can tell this is needed for correct memory protection
key operation, however it seems to be causing slowdowns when booting
Linux, enough to cause failures due to timeouts, so I will not merge it
at the moment. I have been considering possible ways to speed this up
e.g., with mmu indexes, but that's not entirely trivial and needs a bit
more work.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h      |  2 ++
 target/ppc/cpu_init.c    |  4 ++--
 target/ppc/misc_helper.c | 48 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 52 ++--------------------------------------
 4 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6178ebe138f..e8de4f95581 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -723,6 +723,8 @@ DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_2(store_amr, void, env, tl)
+DEF_HELPER_2(store_iamr, void, env, tl)
 DEF_HELPER_2(store_hrmor, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
 DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 92316b55afd..43af471ae64 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -238,7 +238,7 @@ static void register_amr_sprs(CPUPPCState *env)
     spr_register_kvm_hv(env, SPR_AMR, "AMR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_amr,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_amr,
                      KVM_REG_PPC_AMR, 0);
     spr_register_kvm_hv(env, SPR_UAMOR, "UAMOR",
                      SPR_NOACCESS, SPR_NOACCESS,
@@ -259,7 +259,7 @@ static void register_iamr_sprs(CPUPPCState *env)
     spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_iamr,
-                        &spr_read_generic, &spr_write_generic,
+                        &spr_read_generic, &spr_write_iamr,
                         KVM_REG_PPC_IAMR, 0);
 #endif /* !CONFIG_USER_ONLY */
 }
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index ac439e00326..dfc9d806b30 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -169,6 +169,54 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 }
 
 #if defined(TARGET_PPC64)
+void helper_store_amr(CPUPPCState *env, target_ulong val)
+{
+    target_ulong old, new, mask;
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        mask = env->spr[SPR_UAMOR];
+    } else if (FIELD_EX64(env->msr, MSR, HV)) {
+        mask = (target_ulong)-1;
+    } else {
+        mask = env->spr[SPR_AMOR];
+    }
+
+    old = env->spr[SPR_AMR];
+    /* Replace controllable bits with those in val */
+    new = (old & ~mask) | (val & mask);
+
+    if (old != new) {
+        CPUState *cs = env_cpu(env);
+        env->spr[SPR_AMR] = new;
+        /* AMR is involved in MMU translations so must flush TLB */
+        tlb_flush(cs);
+    }
+}
+
+void helper_store_iamr(CPUPPCState *env, target_ulong val)
+{
+    target_ulong old, new, mask;
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        g_assert_not_reached(); /* mtIAMR is privileged */
+    } else if (FIELD_EX64(env->msr, MSR, HV)) {
+        mask = (target_ulong)-1;
+    } else {
+        mask = env->spr[SPR_AMOR];
+    }
+
+    old = env->spr[SPR_IAMR];
+    /* Replace controllable bits with those in val */
+    new = (old & ~mask) | (val & mask);
+
+    if (old != new) {
+        CPUState *cs = env_cpu(env);
+        env->spr[SPR_IAMR] = new;
+        /* IAMR is involved in MMU translations so must flush TLB */
+        tlb_flush(cs);
+    }
+}
+
 void helper_store_hrmor(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_HRMOR] != val) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ac910151cfa..c5fe3de64e9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1080,33 +1080,7 @@ void spr_write_excp_vector(DisasContext *ctx, int sprn, int gprn)
 #ifndef CONFIG_USER_ONLY
 void spr_write_amr(DisasContext *ctx, int sprn, int gprn)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-
-    /*
-     * Note, the HV=1 PR=0 case is handled earlier by simply using
-     * spr_write_generic for HV mode in the SPR table
-     */
-
-    /* Build insertion mask into t1 based on context */
-    if (ctx->pr) {
-        gen_load_spr(t1, SPR_UAMOR);
-    } else {
-        gen_load_spr(t1, SPR_AMOR);
-    }
-
-    /* Mask new bits into t2 */
-    tcg_gen_and_tl(t2, t1, cpu_gpr[gprn]);
-
-    /* Load AMR and clear new bits in t0 */
-    gen_load_spr(t0, SPR_AMR);
-    tcg_gen_andc_tl(t0, t0, t1);
-
-    /* Or'in new bits and write it out */
-    tcg_gen_or_tl(t0, t0, t2);
-    gen_store_spr(SPR_AMR, t0);
-    spr_store_dump_spr(SPR_AMR);
+    gen_helper_store_amr(tcg_env, cpu_gpr[gprn]);
 }
 
 void spr_write_uamor(DisasContext *ctx, int sprn, int gprn)
@@ -1138,29 +1112,7 @@ void spr_write_uamor(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_iamr(DisasContext *ctx, int sprn, int gprn)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-
-    /*
-     * Note, the HV=1 case is handled earlier by simply using
-     * spr_write_generic for HV mode in the SPR table
-     */
-
-    /* Build insertion mask into t1 based on context */
-    gen_load_spr(t1, SPR_AMOR);
-
-    /* Mask new bits into t2 */
-    tcg_gen_and_tl(t2, t1, cpu_gpr[gprn]);
-
-    /* Load AMR and clear new bits in t0 */
-    gen_load_spr(t0, SPR_IAMR);
-    tcg_gen_andc_tl(t0, t0, t1);
-
-    /* Or'in new bits and write it out */
-    tcg_gen_or_tl(t0, t0, t2);
-    gen_store_spr(SPR_IAMR, t0);
-    spr_store_dump_spr(SPR_IAMR);
+    gen_helper_store_iamr(tcg_env, cpu_gpr[gprn]);
 }
 #endif
 #endif
-- 
2.47.1


