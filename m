Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC896C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnr-0003WK-0l; Mon, 29 Jan 2024 11:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUms-0008Dw-Nq
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:10 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmp-00046X-FN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:10 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d0512f6e32so9054151fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546824; x=1707151624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijxQ2ToounQ2YPXKuEdEzzYCdzKOr5SyszX4l6rPtX0=;
 b=pRUaHsaLfYCa993As447YsVWb8bgI9iiAV1nRGt33cXUVQqRPTTW55OdyNGMhltpTK
 n8sjLXHIYGOGjw8UOVW/yvhDZ+ycuzAIOycs/fKlsRSf5OwbNswjoRxmdpdY0X5W9acq
 BNGJi2BRYyhGHa5EXqvOXCZjOWBMdxpuby+Hyezjk8puvZur0doVFP5Ia33FYLW1V7aI
 UFqrKmAg/x+CEkWjOklBiLgYmEm6ZN0EfxlfMqeFRR/PdaqB0ZZZM8rcPvGiUlNRWBDg
 sPu7Tw2vFVD7Kd3rlckCOEGXayaB5hCT0VcjRcCPzPVHkF/VBPozgr3siasfK0XzGuM2
 SKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546824; x=1707151624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijxQ2ToounQ2YPXKuEdEzzYCdzKOr5SyszX4l6rPtX0=;
 b=EmL6bB156rihzHjn6EYWyfEJvy5DXWvxsUStchQKtXYV8foaYq2UHV2hhqe7/SQnBW
 gjIugzTvOHu2x9f1PMAlp8haA5JzGaPOPupFFAAVHwafaOUYaNzxjxdF9i7C+WF8FD/T
 A/TQNS+1eKCaBf6NeFScB/GTEYAw/P/e/O1MIa3+HQtsJvvLU45+jCLnVywOjUmsNaIY
 z7rg93OHSWiP89kG62qmWulTijFmitD4q/bqIIVVlMhGTSTjtaf7FLF6/+str6oElLi6
 jh5BXDzo/IhXVDWI8Gn2aQQmGbgJPssY7fEPynarEA8P60ve4bjMO6w6rI5xbtbOel/b
 4/Ag==
X-Gm-Message-State: AOJu0Yxz4gv0ckxTaHjjWBcO9hrxIUzDDOEZesZs0RZoUWh3xtKk4qUJ
 c/+jg1pagHZXGXfVs7DYDnHBtsQH3DcHzjHH4le3/ZxXlbsoJSIYmVosyWlKsCBv0cY04mNgkQ0
 H
X-Google-Smtp-Source: AGHT+IGXacHRaZvQM48taNZT74NjPJR9kzPP7y3LZ/4p0pddoEr1gt2fuS3L5Ce3XavmaRSix5iy+w==
X-Received: by 2002:a05:651c:151:b0:2cf:2a82:7871 with SMTP id
 c17-20020a05651c015100b002cf2a827871mr4062986ljd.26.1706546823949; 
 Mon, 29 Jan 2024 08:47:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a5d4806000000b003392ae3aee8sm8502273wrq.97.2024.01.29.08.47.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 17/29] target/microblaze: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Date: Mon, 29 Jan 2024 17:44:59 +0100
Message-ID: <20240129164514.73104-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/gdbstub.c   | 3 +--
 target/microblaze/helper.c    | 3 +--
 target/microblaze/translate.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 29ac6e9c0f..98660ed950 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -113,9 +113,8 @@ int mb_cpu_gdb_read_stack_protect(CPUMBState *env, GByteArray *mem_buf, int n)
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
     uint32_t tmp;
 
     if (n > cc->gdb_num_core_regs) {
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 98bdb82de8..bf955dd425 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -253,8 +253,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
 
     if ((interrupt_request & CPU_INTERRUPT_HARD)
         && (env->msr & MSR_IE)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..354897c4a2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1630,7 +1630,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
-    CPUMBState *env = cpu_env(cs);
     uint32_t ir;
 
     /* TODO: This should raise an exception, not terminate qemu. */
@@ -1641,7 +1640,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = cpu_ldl_code(env, dc->base.pc_next);
+    ir = cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
@@ -1800,8 +1799,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
     uint32_t iflags;
     int i;
 
-- 
2.41.0


