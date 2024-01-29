Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06248C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUpF-0000Pf-Or; Mon, 29 Jan 2024 11:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUno-0003W8-5f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnl-0004Xk-84
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33ae3cc8a6aso1568622f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546883; x=1707151683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rt9340Neq6sQRGPVea3EhCde05ocdRyA3moNLb2tSg=;
 b=YkYFIbp+RF6vD6BxqmFbxv9clqJUDHcfWwZbycTECtd3JwsNYdWLHaxqehocSRGJut
 IaScR5HHFzXSu4uqB4hlbnV4vjiGwd2lA7IjXpRZfwx29CPJzgrI2b0FJGUCAOoclPkx
 H4EB2crXfxPYNKuCZu6TsDTEnhLzLPWaw0rLFPFd+fbEbkeSzcuAjEjn+/UIuLfWQrO8
 xo7H+vQmf2O9titVdq1f32n5P1lfBCnldZUyD5YXL9iNLOGZx6ER1MVsoNFuTRaMs1ez
 MIEE36LcTamZ3Ol/jd6/7WId3YmvgRMFdrY3Jp+tDMd1WCl3xhTglUprcp9FkeEpD2Jo
 eAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546883; x=1707151683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rt9340Neq6sQRGPVea3EhCde05ocdRyA3moNLb2tSg=;
 b=JMwQ/4CjgEbaEhljlp0H48DajX7CDv53UQKXFDJnsmeWJlgprLtdytcAM5q3jIu2oM
 PIk/brqQR4nV099JKrtdExiUcztt3xrgjumy9VW2ghs8pf2qY+p61e8jqKkm2fRLP7M7
 KM4KMnimjcvlE8qf9m8ieaxqh480+DPs1Peu2ggIoDUWcEca6LgFD3EZIhBw6nomS/0F
 zoPWDROy37/AkwYLzcwnjOg8sPt45FTLSv03Mlvdxz1iApY40KEb7ipiBUGo+WyIFeM2
 g8sHSbHI1QwWJOZd+GRD31tUWwFV+KmxygS5U8s31rWUA6aFMVagk2/2wSTZeYb/WQhk
 BIZA==
X-Gm-Message-State: AOJu0YxBLZW3XVIeF72iU2dDDMpx2MuYR1Urwi60qVsAMZv4Suz3fvfO
 RJ8H/ONwmZJYbmpDJKmr3k+mG7FLzx5wLyCPm3Ows3C8VSM8H6vHFetXD1QUSNpINS9+zwiGWvZ
 k
X-Google-Smtp-Source: AGHT+IHwCuq+6yh1m6T7vY3Y2cLEq0q/hPFlPvC2NilRjpgFakRKueneRO9FZiqsXUrqr0KBPgYKVA==
X-Received: by 2002:a5d:510f:0:b0:33a:e7de:aa8b with SMTP id
 s15-20020a5d510f000000b0033ae7deaa8bmr2928268wrt.26.1706546883422; 
 Mon, 29 Jan 2024 08:48:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a05600003c300b0033ae46e0f02sm6350998wrg.75.2024.01.29.08.48.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:48:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v3 27/29] target/tricore: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Date: Mon, 29 Jan 2024 17:45:09 +0100
Message-ID: <20240129164514.73104-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.c       | 24 +++++-------------------
 target/tricore/gdbstub.c   |  6 ++----
 target/tricore/helper.c    |  3 +--
 target/tricore/translate.c |  3 +--
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 9bdaa1593a..7c4a9b41a3 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -36,52 +36,38 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
 
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    env->PC = value & ~(target_ulong)1;
+    cpu_env(cs)->PC = value & ~(target_ulong)1;
 }
 
 static vaddr tricore_cpu_get_pc(CPUState *cs)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    return env->PC;
+    return cpu_env(cs)->PC;
 }
 
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->PC = tb->pc;
+    cpu_env(cs)->PC = tb->pc;
 }
 
 static void tricore_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
-
-    env->PC = data[0];
+    cpu_env(cs)->PC = data[0];
 }
 
 static void tricore_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(obj);
-    CPUTriCoreState *env = &cpu->env;
 
     if (tcc->parent_phases.hold) {
         tcc->parent_phases.hold(obj);
     }
 
-    cpu_state_reset(env);
+    cpu_state_reset(cpu_env(cs));
 }
 
 static bool tricore_cpu_has_work(CPUState *cs)
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index e8f8e5e6ea..f9309c5e27 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -106,8 +106,7 @@ static void tricore_cpu_gdb_write_csfr(CPUTriCoreState *env, int n,
 
 int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
 
     if (n < 16) { /* data registers */
         return gdb_get_reg32(mem_buf, env->gpr_d[n]);
@@ -121,8 +120,7 @@ int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 174f666e1e..d328414c99 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -67,8 +67,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                           MMUAccessType rw, int mmu_idx,
                           bool probe, uintptr_t retaddr)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 66553d1be0..ad314bdf3c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -95,8 +95,7 @@ enum {
 
 void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    TriCoreCPU *cpu = TRICORE_CPU(cs);
-    CPUTriCoreState *env = &cpu->env;
+    CPUTriCoreState *env = cpu_env(cs);
     uint32_t psw;
     int i;
 
-- 
2.41.0


