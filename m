Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1B9C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cr9-0002JD-M8; Tue, 21 May 2024 23:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9cr6-0002Im-AV; Tue, 21 May 2024 23:41:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9cr1-0003zI-Nx; Tue, 21 May 2024 23:41:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f457853950so375715b3a.0; 
 Tue, 21 May 2024 20:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716349285; x=1716954085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iaOhH5ot2ybhOhs1vr4n0PD+3R0UiVGJjcNX2rUlsHY=;
 b=A3iUmgtT0Spb59z4+8+vj6cDOlyHrhhoM4eyHgdzl2yCpA1QF7ct+aPi/cXmBcZ2Vg
 35hG86Lt0BeI6Doi6FIb93yWfHzcwKxc0Oh7ib3H7W7i6ykh5MnBIz5gurJXXTSlYOSV
 HjKA/Ki5Ex0nUIp1qN+I/Lo6s1h2U63wLA3IOhK3QeFaLVKzUW1FpaBE1y5RYFpPqhnJ
 7TSoa3qkxfRJyfk93mzqKDUWsos3G8eDeut7623jZkQO0rrHCelScodSxXGND5F55xFJ
 JkpVvM+xhB4vARzFZYOc/rmZ469P5UXtE93ZPFKTiP7S0P1Rn4cIKBpSxDDTUQIwGinS
 b1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349285; x=1716954085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaOhH5ot2ybhOhs1vr4n0PD+3R0UiVGJjcNX2rUlsHY=;
 b=iGqtFTyqZ1pMsh+39fIHBs+7dIE27uCD+4UEJvEHDTtiFbLGys/bS9yBlQdot6Dwzk
 KCHQWYhGIVW+cy51kF2XwCEH/uGBdNGvcx5pJfuc1XTDxw+8VV0CYGLgkHmERpxqZMjv
 u0Cw0v9b9D2franI1HkLaZsxp27DPh8YTP9OOgDaeM0aqefeu3XcQBl37GsprJjv5xFz
 VEgyzEhq+NkxUEs4WdaFSZqHjLDYwAEvxoezr21ZcQq5CJ+ftrIy1WRyNSGCN4zmaNaY
 Rd+mGbDNHHFb3vI0Vj4wLWFcZPcmY1bmIgRFZ0gyE8Lj/pnnaP43jbdpBgDjPGxLZCrs
 k0EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCeDXtNjPTyI33tdZuhDOx59qHdE6mblGq64Z+lNimYxQHC/GTa/JEORUEMg3cRZYkgNUbpMifNK9KS1qQ9YTbl3hJdFM=
X-Gm-Message-State: AOJu0Yypmpwh02EIMuzeDnmBbKRxIBzyJb1N43wa+ZAYTjQcqagi1wAB
 lcEevc2nq/ipqBItQmgMljAB81fVPMYN17syvkLocf5WIT6rfIN+jLp+7A==
X-Google-Smtp-Source: AGHT+IH2Sh9jB7qI6l2TQEJMFbKJ0M9PxvNcrjA3TEbv0Qt+r1RzNHvpkysvqqRkCxvdSAsCX7t2FQ==
X-Received: by 2002:a05:6a21:819f:b0:1af:d057:af96 with SMTP id
 adf61e73a8af0-1b1ca3e9f77mr14008823637.13.1716349284687; 
 Tue, 21 May 2024 20:41:24 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6341180dc5csm18751158a12.93.2024.05.21.20.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:41:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH v3] target/ppc: Add PPR32 SPR
Date: Wed, 22 May 2024 13:41:16 +1000
Message-ID: <20240522034117.90603-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

PPR32 provides access to the upper half of PPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v3:
- Don't clobber lower half of PPR.
- Add spr_load_dump_spr (spr_store_dump_spr was already there).

 target/ppc/cpu.h        |  1 +
 target/ppc/spr_common.h |  2 ++
 target/ppc/cpu_init.c   | 12 ++++++++++++
 target/ppc/translate.c  | 24 ++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2532408be0..141cbefb4c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2120,6 +2120,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_POWER_MMCRS       (0x37E)
 #define SPR_WORT              (0x37F)
 #define SPR_PPR               (0x380)
+#define SPR_PPR32             (0x382)
 #define SPR_750_GQR0          (0x390)
 #define SPR_440_DNV0          (0x390)
 #define SPR_750_GQR1          (0x391)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index eb2561f593..9e40b3b608 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -203,6 +203,8 @@ void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 892fb6ce02..7684a59d75 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5623,6 +5623,14 @@ static void register_HEIR64_spr(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power7_common_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_PPR32, "PPR32",
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 0x00000000);
+}
+
 static void register_power8_tce_address_control_sprs(CPUPPCState *env)
 {
     spr_register_kvm(env, SPR_TAR, "TAR",
@@ -6118,6 +6126,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power7_book4_sprs(env);
 
     /* env variables */
@@ -6264,6 +6273,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6431,6 +6441,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6625,6 +6636,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 120858a188..44212192be 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1411,6 +1411,30 @@ void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn)
     gen_load_spr(t0, sprn + 16);
     tcg_gen_ext32u_tl(cpu_gpr[gprn], t0);
 }
+
+/* The PPR32 SPR accesses the upper 32-bits of PPR */
+void spr_read_ppr32(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_load_spr(cpu_gpr[gprn], SPR_PPR);
+    tcg_gen_shri_tl(cpu_gpr[gprn], cpu_gpr[gprn], 32);
+    spr_load_dump_spr(SPR_PPR);
+}
+
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+
+    /*
+     * Don't clobber the low 32-bits of the PPR. These are all reserved bits
+     * but TCG does implement them, so it would be surprising to zero them
+     * here. "Priority nops" are similarly careful not to clobber reserved
+     * bits.
+     */
+    gen_load_spr(t0, SPR_PPR);
+    tcg_gen_deposit_tl(t0, t0, cpu_gpr[gprn], 32, 32);
+    gen_store_spr(SPR_PPR, t0);
+    spr_store_dump_spr(SPR_PPR);
+}
 #endif
 
 #define GEN_HANDLER(name, opc1, opc2, opc3, inval, type)                      \
-- 
2.43.0


