Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77707C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnS-0001Qi-Ut; Mon, 29 Jan 2024 11:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmP-0007O1-FT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmM-0003yy-VB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ef6c471d5so10101295e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546793; x=1707151593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fRIZrJNpcnOiODb5mhhkKtvMpcISUpGajS0aMN6lEM=;
 b=gku0dkQMgLTlxeDCD6S7HS+yJM2k1H2BFXwRNKUkkEATbXMbz+9Pp25VTCACbOTRq7
 hFSvymlv32/0JFTWDSztrcgaJM9xfXsun8TvvCr9wAsCW7ist7vUOLDugdbfUa5pmnm2
 uqAxn1q3Ff9SCX26Jcvo1TfyvwXyF4oT0Zc6LGEK2xCdr6CRMODAQO6T64OgcWKvo1mj
 4A0sJeQf87AKslF2twT3lpTm9hz3a2FUN6VVy79zAzOrAnFeyTzZqBCgbQtSQOAgGXOF
 0nUOMZzsiqGKuMd9USxjwGzlTBnwXj+wH1qhSO2ktQUAV/E/fMwrOi3Ad2/NxnI13z0S
 nV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546793; x=1707151593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fRIZrJNpcnOiODb5mhhkKtvMpcISUpGajS0aMN6lEM=;
 b=Xez1OC7vaj4wwvpXI4IHGrB20/vINbwEPSbRWi5s+wclrs2VfJST5COdx3uile+3Bb
 Rgo3smmn1jY37h/kBQO0MN0+fvKP4J36d3IiglqmeTYcEPbt0VVfb+M3XWK/HUGXFj3i
 N34UYiAkIch5/IHkbeeUiWZKsQ+klo5Oul0o7Aqn2kjUHhU9qljSGViiR76Oy5a1471J
 flD6KvuGFn91eni55m6m1g11GX3uoIiz2zoa5M+igNqlzwhrdUUDc8ZfB18UjoJSMjVy
 fEazZKp0O67jn6KdgKdhu6GycIT6hVG/OkEZP9KzmIJd3KgofbfijkLrNxNtKTuDccDA
 2Pmg==
X-Gm-Message-State: AOJu0Yy1pOu/YCOw36MQXa0pbql2RUOADuQEZq5+7GzV03FEYrx6u35S
 BSXHksPSbgveBGnbXd8IHF2bmTA3wW/Ne5S5yCuO57YI0D4cjSwgnNNlLvt1I/InCwCoyzf3lmH
 Z
X-Google-Smtp-Source: AGHT+IH/9F8cyyKVNSFyJK/XuxhMwJqDVtIMy6daRNXg1ZJWGMneBXNSLk4RtK2/569lG7qwYgQxgQ==
X-Received: by 2002:a05:600c:1986:b0:40e:e97c:e71 with SMTP id
 t6-20020a05600c198600b0040ee97c0e71mr6257966wmq.1.1706546793662; 
 Mon, 29 Jan 2024 08:46:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a05600c475200b0040e9f7308f4sm10656778wmo.10.2024.01.29.08.46.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/29] target/hppa: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:44:54 +0100
Message-ID: <20240129164514.73104-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
---
 target/hppa/cpu.c        | 8 ++------
 target/hppa/int_helper.c | 8 ++------
 target/hppa/mem_helper.c | 3 +--
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 14e17fa9aa..3200de0998 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -106,11 +106,8 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                   MMUAccessType access_type, int mmu_idx,
                                   uintptr_t retaddr)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-
     cs->exception_index = EXCP_UNALIGN;
-    hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
+    hppa_set_ior_and_isr(cpu_env(cs), addr, MMU_IDX_MMU_DISABLED(mmu_idx));
 
     cpu_loop_exit_restore(cs, retaddr);
 }
@@ -145,8 +142,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 static void hppa_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    HPPACPU *cpu = HPPA_CPU(obj);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(CPU(obj));
 
     cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index efe638b36e..d072ad2af7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -99,8 +99,7 @@ void HELPER(write_eiem)(CPUHPPAState *env, target_ulong val)
 
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     int i = cs->exception_index;
     uint64_t old_psw;
 
@@ -268,9 +267,6 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
 bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-
     if (interrupt_request & CPU_INTERRUPT_NMI) {
         /* Raise TOC (NMI) interrupt */
         cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
@@ -280,7 +276,7 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
 
     /* If interrupts are requested and enabled, raise them.  */
-    if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((cpu_env(cs)->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
         cs->exception_index = EXCP_EXT_INTERRUPT;
         hppa_cpu_do_interrupt(cs);
         return true;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index bb85962d50..7e73b80788 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -357,8 +357,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                        MMUAccessType type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     HPPATLBEntry *ent;
     int prot, excp, a_prot;
     hwaddr phys;
-- 
2.41.0


