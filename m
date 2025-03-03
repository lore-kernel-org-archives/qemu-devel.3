Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31348C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2px-00068w-2T; Mon, 03 Mar 2025 05:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2pq-000679-Qe; Mon, 03 Mar 2025 05:15:43 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2po-0004D1-4z; Mon, 03 Mar 2025 05:15:42 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22356471820so64445105ad.0; 
 Mon, 03 Mar 2025 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740996938; x=1741601738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YhHDXTMj4mBPvRzRPZdvjBQsq5i/QpxHZ825A0GYM2I=;
 b=P5431ToiczDkD2g9X1SIUPiYzBXzD1YmdIykPilNtC4+ia8CHi7XhAgLawNn1+pTHA
 RtJ1fKmkBO/mWcBISIxIs8ULB0tkGY/iisgSudJnVdy+BTnwR6iiMUZJ0WTXQzpGpWZL
 QxnShLg6Kl/FKCl3GnKHGfxGQ3neHxK7QjlEBV9qo22vMYwg7GQR5PWp4vcOocbUS4zz
 wCQAcntn35BfSC00LZ560R6LTYGrabUtADvDi3IylewbNYj3MXkTeUVxIlAWwVLBP7Jl
 XRsaVnAESnUu/hldIiTYdyqwaFd/xkF+DZrmpEORbnkYISD/TWCYPkaIyhvphLR+k+lm
 Ss8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996938; x=1741601738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhHDXTMj4mBPvRzRPZdvjBQsq5i/QpxHZ825A0GYM2I=;
 b=jRl1EkgZXXQlXUFLwFGlx9m8k1ztcj3yDMKpTUWRA0SjRvbKEa4Jy/nsZCW5ZVzjxz
 I7ndUvNIublM0+rP4c4mICpg8hyki/8i1D/DBSgl86oQq0lPlzxkEOyNm1lmnqV+hUdK
 f7DgkLz2RcVwV8892rTPP3/AzM3lGZjEXVn1Ux5smazaEQA443gODS2k1MEi7/wPyM0f
 51q5jGk6Zc3rnlAumgtdnohyWZn1tOKfKzfcRJViXKqehkCNpqQFIjgLrdpJ0d6K5iPW
 k/3w2aSITBkNq3eEyRY24WLfPjKD/fKmQ7zwQDidy7mEDAobtslhRbGNIyRwYXeABZkT
 2WcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHTJT+cCyvfZucMqjO+tBSCD6WI/nhyVqFdmQYPbrKFX8RKh2LGTYI9TPGTGDafn4ZsZI3seLTsEdP@nongnu.org
X-Gm-Message-State: AOJu0Yz/N4I/+oN70qQkchpDbtbH4rdNWl1k1G6vb9uZ0N91S01h9O0Z
 yM4PbktBRjZA6o7FF/zf0H+KqtCAIDCx5cd7/vXIn3/4E6Fts55xPRqgiQ==
X-Gm-Gg: ASbGncuXAdReamGbJC2S/avajVQdppFMOoczEa7F65gDeF5ocFT2lBokVgjtZaz9sGA
 8o6jgvKNfb85L3s8CN9ZzAdjeFPyQoCQfdo30nQZnTypyFQ9qIE5GkBIqsZ4+fWpvCc0L6YJjZF
 /MOghlf0pGhzG+ZLDg0tGwcauebWSRHJ4u6Eehz6bqkDyTgpeYyUNk1JrM5ob4JecwZpljD0WYE
 vu9stiAzQPYx0h+p7qqHdPxeaanCSNl6uEQ00p33rMTB3AcRijlVP39sSHazap5Fcp2vkBg0x0u
 UFkOFvMyqtVmEQTb95uRtGXbfgl2+OMW9yh5WsTWCU7D5wgltKk=
X-Google-Smtp-Source: AGHT+IELID7Vd8zuCP1zgLUvZGiX7HMezDX5+ahHI2JLTWm376BeFRqIrMYylXlFJ3oFUzqLBMO4Ug==
X-Received: by 2002:a05:6a20:a10c:b0:1f0:e368:adff with SMTP id
 adf61e73a8af0-1f2f4e01a1amr16517955637.39.1740996937856; 
 Mon, 03 Mar 2025 02:15:37 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de19c14sm7846801a12.20.2025.03.03.02.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:15:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH] target/ppc: Add Power9/10 power management SPRs
Date: Mon,  3 Mar 2025 20:15:30 +1000
Message-ID: <20250303101531.577569-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

Linux power management code accesses these registers for pstate
management. Wire up a very simple implementation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
After OCC fixes in QEMU pnv model and skiboot (since they have suffered
some bitrot), Linux will start performing PM SPR accesses. This is a
very simple implementation that makes it a bit happier.

Thanks,
Nick
---
 target/ppc/cpu.h         |  2 ++
 target/ppc/helper.h      |  2 ++
 target/ppc/spr_common.h  |  2 ++
 target/ppc/cpu_init.c    | 11 +++++++++
 target/ppc/misc_helper.c | 53 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 16 ++++++++++++
 6 files changed, 86 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ff527e49b73..4ce812613e2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2092,6 +2092,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_VTB               (0x351)
 #define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
+#define SPR_PMSR              (0x355)
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
@@ -2099,6 +2100,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_INV2          (0x372)
 #define SPR_TRIG2             (0x372)
 #define SPR_440_INV3          (0x373)
+#define SPR_PMCR              (0x374)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
 #define SPR_440_ITV2          (0x376)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e8de4f95581..4d25fa216b8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -736,6 +736,8 @@ DEF_HELPER_2(store_tfmr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
 DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(load_pmsr, TCG_CALL_NO_RWG_SE, tl, env)
+DEF_HELPER_FLAGS_2(store_pmcr, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 8cac82b2dac..cfe725a5292 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -205,6 +205,8 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
 void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
+void spr_read_pmsr(DisasContext *ctx, int gprn, int sprn);
+void spr_write_pmcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7d4aad505d7..91c1ca4f9d9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6468,6 +6468,17 @@ static void register_power9_common_sprs(CPUPPCState *env)
                         spr_read_generic, spr_write_generic,
                         KVM_REG_PPC_PSSCR, 0);
 
+    spr_register_hv(env, SPR_PMSR, "PMSR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_pmsr, SPR_NOACCESS,
+                    0);
+    spr_register_hv(env, SPR_PMCR, "PMCR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_generic, &spr_write_pmcr,
+                    PPC_BIT(63)); /* Version 1 (POWER9/10) */
+
 }
 
 static void init_proc_POWER9(CPUPPCState *env)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 397bae12fe3..80177143170 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -459,6 +459,59 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
         break;
     }
 }
+
+target_ulong helper_load_pmsr(CPUPPCState *env)
+{
+    target_ulong lowerps = extract64(env->spr[SPR_PMCR], PPC_BIT_NR(15), 8);
+    target_ulong val = 0;
+
+    val |= PPC_BIT(63); /* verion 0x1 (POWER9/10) */
+    /* Pmin = 0 */
+    /* XXX: POWER9 should be 3 */
+    val |= 4ULL << PPC_BIT_NR(31); /* Pmax */
+    val |= lowerps << PPC_BIT_NR(15); /* Local actual Pstate */
+    val |= lowerps << PPC_BIT_NR(7); /* Global actual Pstate */
+
+    return val;
+}
+
+static void ppc_set_pmcr(PowerPCCPU *cpu, target_ulong val)
+{
+    cpu->env.spr[SPR_PMCR] = val;
+}
+
+void helper_store_pmcr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+
+    /* Leave version field unchanged (0x1) */
+    val &= ~PPC_BITMASK(60, 63);
+    val |= PPC_BIT(63);
+
+    val &= ~PPC_BITMASK(0, 7); /* UpperPS ignored */
+    if (val & PPC_BITMASK(16, 59)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Non-zero PMCR reserved bits "
+                      TARGET_FMT_lx"\n", val);
+        val &= ~PPC_BITMASK(16, 59);
+    }
+
+    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
+    if (ppc_cpu_lpar_single_threaded(cs)) {
+        ppc_set_pmcr(cpu, val);
+        return;
+    }
+
+    /* Does iothread need to be locked for walking CPU list? */
+    bql_lock();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        ppc_set_pmcr(ccpu, val);
+    }
+    bql_unlock();
+}
+
 #endif /* defined(TARGET_PPC64) */
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c5fe3de64e9..a73afe600de 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1288,6 +1288,22 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
     translator_io_start(&ctx->base);
     gen_helper_store_lpcr(tcg_env, cpu_gpr[gprn]);
 }
+
+void spr_read_pmsr(DisasContext *ctx, int gprn, int sprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_load_pmsr(cpu_gpr[gprn], tcg_env);
+}
+
+void spr_write_pmcr(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
+    translator_io_start(&ctx->base);
+    gen_helper_store_pmcr(tcg_env, cpu_gpr[gprn]);
+}
+
 #endif /* !defined(CONFIG_USER_ONLY) */
 
 void spr_read_tar(DisasContext *ctx, int gprn, int sprn)
-- 
2.47.1


