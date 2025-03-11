Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CF9C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzDC-0003x7-NF; Tue, 11 Mar 2025 08:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCg-00021s-SG; Tue, 11 Mar 2025 08:59:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCc-0007x4-U9; Tue, 11 Mar 2025 08:59:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so8237887a91.0; 
 Tue, 11 Mar 2025 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697961; x=1742302761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1uWfwdoT5PuKunpdf5GL7Jo4UcITHEbOpLA5+y74zY=;
 b=S8xLiHhR/AxOxTKHERJwZy0a9kJvrtf+/pptQh5CURjBXXIbK4/u75exJ3hGRfmueg
 G4Pam2AbGMUkdjJ2wFx08v+Q/Tp3QD1w2h3DKdRMs5oNHFAghJOzHvic0mm4C61GypEg
 /bPk5Zijbzo7q5ibkJw0MFHtl3JjX+kQHHM1XNakQDscVXRztbZFdaaK9c82p7oz+L7d
 qr6jHROTwR/i0w9Ax+zkeXWfpE5/mjNuSWt6KxGXUa/0n8NoR1jRAT3kcEQCFR2RW21v
 AukZrFVqxAqZZcXO8RpY1IIzFdGW3FaD8apzKIbor6GEMFkon/nLv4ABPCzNcF+5pv0q
 NceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697961; x=1742302761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1uWfwdoT5PuKunpdf5GL7Jo4UcITHEbOpLA5+y74zY=;
 b=bG4z4hB/lyiC5gZzs8hNYnMNHlFbZfa9pkxKRG1VxpvDsjN9NpXChPzB2QCV8bTWcU
 zgk8S6VC1OhU02quN6I7Xhi3eina7CSJ3hImKxrQlAx5dM9H2WxHndX6f2TgJzhj+UhC
 1oJUeJJwNbCAJD8Sxx7R7rgz6XsSrhasBhi5xTivnfAHMMgkaYRyPc0T73qilCQRU+vl
 HIYGmhFzCfCosWCQ8DfGsaCMVtp/zSyGc/f5+czcrWH1rqjp8JZun0SqGgT//u4CYokA
 rNsCprWCt74W5lL9u7AqRy3TWdkwYwqNDoPjnsG499lsB8E6UZMUlQpB2n3aq9l/DE+u
 K/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlg5UHPVGVLj+KDQ0MtwX5Cb5ZmWbDoceib1Iiyame9mVaHihT+LP0yWWU5ZnaEOIVWbHbhmrq6A==@nongnu.org
X-Gm-Message-State: AOJu0YwNm2YzJRUfNLo9JSlg9BZOpbOTOhKC5A0+YMiY7D0O3cjdh0U5
 dQfqXCW1k1iBruswKm26CC199DGC5VLvqOMafkdO8A5wtnb8s2FppACRyw==
X-Gm-Gg: ASbGncuiI6JnxCntQeWIUQsLelU3vyNSxeadKEzB20G8WiLmiODA9KJfSAeCBAKzTgn
 a/mGGAran4iz4mBQd2Fcmvh86oD6xRjKV+A/XJXlFbBNfTM33yVAUIBjCrV0m7fhfdzOiQvFHhK
 qBaLJ7y8pt8sepbLLpg1yykElRJI+OFEKh98E7K6Fbk1jwuMb4Pt/yRJthCwvtIVg/9ZfLtFgsj
 xIC+qVBbF3U1ye12ve2vf3wk1LpIRhMsNtj5xWLA7w+02dCOgyY05/4hkIqosnIRyWWsSQL5hLE
 M+62i8QSnTbBfu0bpWR/qshi+cjCC0exVHKoo8tj6v4JuEHBU/w=
X-Google-Smtp-Source: AGHT+IHhK3Xq0p0Gsazf9hC06zEq/EpkSQuUyC5j8Ci91L0KHHOssdLEtZOlVMMajo7ZW5PBpz4NGw==
X-Received: by 2002:a17:90b:3812:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ff7ce7277cmr24565728a91.6.1741697960456; 
 Tue, 11 Mar 2025 05:59:20 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 16/72] target/ppc: Add Power9/10 power management SPRs
Date: Tue, 11 Mar 2025 22:57:10 +1000
Message-ID: <20250311125815.903177-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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
 target/ppc/cpu_init.c    | 11 +++++++++
 target/ppc/helper.h      |  2 ++
 target/ppc/misc_helper.c | 53 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/spr_common.h  |  2 ++
 target/ppc/translate.c   | 16 ++++++++++++
 6 files changed, 86 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c0517..682583d1d1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2091,6 +2091,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_VTB               (0x351)
 #define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
+#define SPR_PMSR              (0x355)
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
@@ -2098,6 +2099,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_INV2          (0x372)
 #define SPR_TRIG2             (0x372)
 #define SPR_440_INV3          (0x373)
+#define SPR_PMCR              (0x374)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
 #define SPR_440_ITV2          (0x376)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1780cabfc6..54035c7bbb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6451,6 +6451,17 @@ static void register_power9_common_sprs(CPUPPCState *env)
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
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a77e761bd..11b914e640 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -733,6 +733,8 @@ DEF_HELPER_2(store_tfmr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
 DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(load_pmsr, TCG_CALL_NO_RWG_SE, tl, env)
+DEF_HELPER_FLAGS_2(store_pmcr, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e379da6010..190e9091fc 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -377,6 +377,59 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
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
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 01aff449bc..8e3117b463 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -204,6 +204,8 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
 void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
+void spr_read_pmsr(DisasContext *ctx, int gprn, int sprn);
+void spr_write_pmcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80638ab535..b0cc8bf283 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1326,6 +1326,22 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
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


