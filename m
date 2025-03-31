Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92E2C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGXQ-000693-5O; Mon, 31 Mar 2025 10:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzGXN-00068k-LX; Mon, 31 Mar 2025 10:54:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzGXL-0001wH-LZ; Mon, 31 Mar 2025 10:54:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227aaa82fafso86610765ad.2; 
 Mon, 31 Mar 2025 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743432889; x=1744037689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=spIhDUx0q4yvuNUpJjFMn7D07djGjIMK54t7neF/TXQ=;
 b=ITdZDKG+ZKt7NKfR4ONMaEl+NpsnVcG0Wdl8Qs9KRMHfV/0VB9Q68RVDoy+39sW/A1
 aoCf0TVvRs/5grHXvc61DdToLgygbWoA0K85CCAZwuZZ2sdljHKtmSCxCthAElR/Z5/x
 4tgsZow9+ihS642kbtLdsMkMqmeXscXuGsTDruDss8oLDuTYjNUcOVWg88R87LsB6sSe
 hCNit+gIwVZ/nv0V7mHj1pLNpia/GSvf5klmMXvsSRlrEUMzSFwZE8ogoDjyZvHFelB/
 BURASiNxmdH7sKYiPiVGSfieD3yJTyDtSy21LMG8sMopG7v7r7oEDVuSRCvh3LIp8z8P
 dpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743432889; x=1744037689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spIhDUx0q4yvuNUpJjFMn7D07djGjIMK54t7neF/TXQ=;
 b=hhuH8PNrQxkjEB9XlBIEEkebE3fvG32aVsR5qHgshByOZh0zipxcguMOV1ZrqT74Mj
 yxE0fXdl1s0iz1MuL/GRHIs0i4xN0D8aLI16mSPXv/wKFksYbep/Z5z6iWvfmRvVojHi
 8BM/8q/r/ADgmVIxrFzBtiSzVjNzxvEfUh+ugYTOxOPYkg1WEzPoDkocHbtvluwSCLtb
 LGDUcGzuQcrwc/yYEz/XregXfYywEoOYRShhipaaVd1jDydrl9YV6YARFonOR4EyUXM4
 SsnitCKTIEY9GR085PelEel1B/SgUc9PXOINZ/DQzxrPm+VCnyHtgiPnQV8hsbSf2DAE
 tJ9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpNsWYWf6Dvgk/e0CljX7uRC8w6KETwwN7E4+Nc3wKdZ1ctr+5mCsykjfYeX7u/rWi/tK69uOHqAH@nongnu.org
X-Gm-Message-State: AOJu0YzgpCXIwqYStvPfmCFdFumaQTY4NXH/SMBRt1AFu99+KMOodLF5
 0qP8lj2bkwZIrhTCz5Lj3jP67CgpHSAN6QSI6NsegteaEvFTlB5LXcgmJg==
X-Gm-Gg: ASbGncsQZDdraYf14Nab6gEn+gVZIj2GbYRciYxBqNkG55g+J9n4V7GabSZk0gk7sXR
 90e41xO7HdUKGw2gPMLnLk7sgN1or82Be9kDzuzgi0IFW5HZezIBIVr3XFeuvTvgLu0A9HKk9RH
 Gt0nAhPqpDfJsQC5H28MnceP4/+JIv4U3lAWaDwYw75VslZZ00r5tHEaJ+NZ4mTTDk02XfgyX9d
 ZtQG6PHJ1tZgjk9n7BoBs0SkMY96cXp8lFt5asbyFmonLPt1x65/o1QsClnGbp0qsyigUJGY0JT
 2/Z1iy2SwVEEeSePqfHvUe04WL6Zk/TlWCkcGR73rhnPi70NgQ==
X-Google-Smtp-Source: AGHT+IHxC6AZc5ShcmSc3xebePukNIHhA9tKadw10FrtHhj+KOBMAVv/l06SzuVkYeQ8CLmWm7TDwg==
X-Received: by 2002:a05:6a00:1395:b0:736:5725:59b4 with SMTP id
 d2e1a72fcca58-7398034e500mr14617089b3a.3.1743432889417; 
 Mon, 31 Mar 2025 07:54:49 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970deecbfsm7033913b3a.33.2025.03.31.07.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:54:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Improve PSSCR SPR modelling
Date: Tue,  1 Apr 2025 00:54:41 +1000
Message-ID: <20250331145442.617678-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

PSSCR aliases to two SPR numbers, one HV only and one where some fields
are available to supervisor. Supervisor also has some restrictions on
where it can execute 'stop' instruction, based on PSSCR field values.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h             |  9 ++++++++-
 target/ppc/helper.h          |  2 ++
 target/ppc/spr_common.h      |  2 ++
 target/ppc/cpu_init.c        | 12 +++++++++---
 target/ppc/misc_helper.c     | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/tcg-excp_helper.c | 27 ++++++++++++++++++++++++---
 target/ppc/translate.c       | 10 ++++++++++
 7 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index dca84ca23cd..74ed28c8dac 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -651,12 +651,16 @@ FIELD(MSR, LE, MSR_LE, 1)
                           LPCR_HR |                \
                           LPCR_TC)
 /* PSSCR bits */
+#define PSSCR_HV_PRIV     PPC_BITMASK(41, 47) /* Hypervisor-only fields */
+#define PSSCR_PLS         PPC_BITMASK(0, 3) /* Power-Saving Level Status */
+#define PSSCR_SD          PPC_BIT(41) /* Status Disable */
 #define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
 #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT_NR(53) /* Privileged Message Send Facilities */
 #define HFSCR_BHRB     PPC_BIT_NR(59) /* BHRB Instructions */
+#define HFSCR_IC_STOP  0x9
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
@@ -1675,6 +1679,8 @@ bool slb_lookup_rmap(CPUPPCState *env, target_ulong va, bool is_1tb,
 #endif
 
 void ppc_store_fpscr(CPUPPCState *env, target_ulong val);
+void helper_raise_hv_fu_exception(CPUPPCState *env, const char *caller,
+                                  uint32_t cause);
 void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
                                  const char *caller, uint32_t cause);
 
@@ -2127,13 +2133,14 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_UDEXCR            (0x32C)
 #define SPR_TAR               (0x32F)
 #define SPR_ASDR              (0x330)
+#define SPR_PSSCR             (0x337)
 #define SPR_DEXCR             (0x33C)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
 #define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
 #define SPR_PMSR              (0x355)
-#define SPR_PSSCR             (0x357)
+#define SPR_HPSSCR            (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
 #define SPR_TRIG1             (0x371)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 53d74a67ffa..3e2a4a46823 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -736,6 +736,8 @@ DEF_HELPER_2(store_tfmr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
 DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(load_psscr, TCG_CALL_NO_RWG_SE, tl, env)
+DEF_HELPER_FLAGS_2(store_psscr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_pmsr, TCG_CALL_NO_RWG_SE, tl, env)
 DEF_HELPER_FLAGS_2(store_pmcr, TCG_CALL_NO_RWG, void, env, tl)
 #endif
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index b57533dfd8e..fcbdf44cb9e 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -207,6 +207,8 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
 void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
+void spr_read_psscr(DisasContext *ctx, int gprn, int sprn);
+void spr_write_psscr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_pmsr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_pmcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 36742136309..1eb6cc10478 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6475,10 +6475,16 @@ static void register_power9_common_sprs(CPUPPCState *env)
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
-    /* FIXME: Filter fields properly based on privilege level */
-    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
-                        spr_read_generic, spr_write_generic,
+    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_psscr, &spr_write_psscr,
+                        &spr_read_psscr, &spr_write_psscr,
                         KVM_REG_PPC_PSSCR, 0);
+    spr_register_hv(env, SPR_HPSSCR, "HPSSCR",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_psscr, &spr_write_psscr,
+                        0);
 
     spr_register_hv(env, SPR_PMSR, "PMSR",
                     SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 641f07eeb7e..d335db1180f 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -113,6 +113,14 @@ static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
 }
 #endif
 
+void helper_raise_hv_fu_exception(CPUPPCState *env, const char *caller,
+                                  uint32_t cause)
+{
+#ifdef TARGET_PPC64
+    raise_hv_fu_exception(env, cause, caller, cause, GETPC());
+#endif
+}
+
 void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
                                  const char *caller, uint32_t cause)
 {
@@ -418,6 +426,32 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
     }
 }
 
+target_ulong helper_load_psscr(CPUPPCState *env)
+{
+    target_ulong val = env->spr[SPR_PSSCR];
+
+    if (val & PSSCR_SD) { /* Status Disable field */
+        val &= ~PSSCR_PLS; /* Mask Power-Saving Level Status field */
+    }
+
+    if (!FIELD_EX64(env->msr, MSR, HV)) {
+        val &= ~PSSCR_HV_PRIV;
+    }
+
+    return val;
+}
+
+void helper_store_psscr(CPUPPCState *env, target_ulong val)
+{
+    if (!FIELD_EX64(env->msr, MSR, HV)) {
+        val &= ~PSSCR_HV_PRIV;
+        val |= env->spr[SPR_PSSCR] & PSSCR_HV_PRIV;
+    }
+
+    env->spr[SPR_PSSCR] = val;
+}
+
+
 target_ulong helper_load_pmsr(CPUPPCState *env)
 {
     target_ulong lowerps = extract64(env->spr[SPR_PMCR], PPC_BIT_NR(15), 8);
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5a189dc3d70..a0e5669c669 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -457,9 +457,30 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
     cs->halted = 1;
 
-    /* Condition for waking up at 0x100 */
-    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
-        (env->spr[SPR_PSSCR] & PSSCR_EC);
+    if (insn == PPC_PM_STOP) {
+        target_ulong psscr = env->spr[SPR_PSSCR];
+
+#ifdef TARGET_PPC64
+        if ((env->msr_mask & MSR_HVB) && !FIELD_EX64(env->msr, MSR, HV)) {
+            target_ulong psll = extract64(psscr, PPC_BIT_NR(47), 4);
+            target_ulong mtl = extract64(psscr, PPC_BIT_NR(59), 4);
+            target_ulong rl = extract64(psscr, PPC_BIT_NR(63), 4);
+
+            /* Supervisor-mode facility check */
+            if ((psscr & PSSCR_EC) || (psscr & PSSCR_ESL) ||
+                (mtl > psll) || (rl > psll)) {
+                helper_raise_hv_fu_exception(env, "STOP insn", HFSCR_IC_STOP);
+            }
+        }
+#endif
+        /* We don't model any power saving levels above 0 */
+        env->spr[SPR_PSSCR] &= ~PSSCR_PLS;
+
+        /* Condition for waking up at 0x100 */
+        env->resume_as_sreset = psscr & PSSCR_EC;
+    } else {
+        env->resume_as_sreset = true;
+    }
 
     /* HDECR is not to wake from PM state, it may have already fired */
     if (env->resume_as_sreset) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 31446dcd78d..7f933537aaa 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1349,6 +1349,16 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_lpcr(tcg_env, cpu_gpr[gprn]);
 }
 
+void spr_read_psscr(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_psscr(cpu_gpr[gprn], tcg_env);
+}
+
+void spr_write_psscr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_psscr(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_read_pmsr(DisasContext *ctx, int gprn, int sprn)
 {
     translator_io_start(&ctx->base);
-- 
2.47.1


