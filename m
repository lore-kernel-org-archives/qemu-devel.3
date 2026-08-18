Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D51C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9Tz-0007VR-VB; Mon, 17 Aug 2026 22:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Ty-0007UU-0v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Ts-0008Ka-1J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so217682a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019791; x=1787624591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pj2T67/7p/2P+wnOytOC2N0z0hs811CESlM1zZEhJ7c=;
 b=Ji9PHXPON74hyfq6KhKCFePitw3oyjeG5TMe2gCZzDH+ljJ6LzN4lHERcMlODFbfQq
 KowZImJYqUEhl1f7NtLlTZEDVBcVxtGV9x71Jl+Z95ROczwMcT2/3C6HGDvnmaFqJw16
 +JOjN+wiTthMWlAdd04C8xeKIj/wr+escOC4zhjD5n8JqnYWipeLzWm+BfN1EFRUkVnF
 IUHZzroD418uuULSah8KezV8vNECSPPnfWLCnV9AOC0ZEjG5CApxnl2hHqVL/al8lWQ8
 MeyD8CYBTUfqb/XpAgR60b0h+1suQozxuicBtRmH0FOnoK/xYrzZ4nIfvZswLVRBUd0X
 wd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019791; x=1787624591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pj2T67/7p/2P+wnOytOC2N0z0hs811CESlM1zZEhJ7c=;
 b=Vb7Pdn2NvIpQg8nIfKMbjMpOPEmEJN9y/z32nxEk/YnF2y4wFGl4cFKpNp2eF/5iEE
 p0ElOnmSEM21VuN/TzRmlIpBlVDWvSAm8z2/ai9val8z8hT8KhlxYq3/bblRbUPdeABX
 4Rk7TdR11wqdRxp1WkG+oEVkjGkOwIf9D+FhrudBSMphirc5WHfIfT5he7joaSh2c5MD
 Y/ltyZWU6MyR0g9XA5E1P8BqfFqwETSgoCf1mohnP7GCcj1fYto8r4b5ibOxOnFjMCCh
 xnT87EQfQigo5AahTm0SIgtbosgn8tgh95NmL+Bu19It5iOziVJ9MBAA5oDv+3iRLy1v
 iWqA==
X-Gm-Message-State: AOJu0Yx1AfzykFsyxKvaBRgfx/C/o8nr1S6ES7UPo+ASBhkf1pVtOWOC
 3rM1f7ZC010k+0nPKbnrckOEvLsp5qh+a9IDgDg4oryj5NPdgjcBRGLxr56gNg==
X-Gm-Gg: AR+sD124jaim3fgGi5OVt62eDqZ1syIPgnRxnC1w3rsN1Rr7hrLJD1KvMvzN+UV0CbW
 XMns+HpmhTPQoTBA9AvUaw8AcLc+RhgAJkZ2v0snE4zWJaNVofXtHiMgv97AcqsEKJz7QbciIlj
 /bhzZYycVjCLxDZGmEmM9GfcZhci5TALV6PU8ChRe8rZ+nROijE6r2UGTZVq0CzGyMdoolNA87O
 +4RkVoqmDc2JV0ofLcl/7RTy8DyVIwFjYYbPx80Y/gUkY96z1g2lSKv7D0XghE22CXgSJuRIA9k
 6pLTJ9DNv2Bd6EAXYcSpk8Z3OEDNGlrovaz2ncnoRQ4wTraAw0irPd1OPhdaKtHK+j/FUXyCoMc
 ATxXrU2tJQvEkUhjE3XP8DVyH5HYuvXvZ/2VHn+czGfwPhOpqwF8llNeIFYTfFMcfXbB+fK1XJg
 N/yBkg0scB6pk015uQRC9diKQ+Qu+MmsAmsPP1Rmap3jLaZ0KrfbFro4qxthE6LWJFvMvCTcKHy
 mQe4Vr1InY/4jA=
X-Received: by 2002:a05:6a21:3382:b0:3bf:a638:4371 with SMTP id
 adf61e73a8af0-3ccda782278mr4683042637.10.1787019790653; 
 Mon, 17 Aug 2026 19:23:10 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:10 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 3/6] target/m68k: Fix NMI pending for Level 7 interrupts
Date: Mon, 17 Aug 2026 19:22:19 -0700
Message-ID: <20260818022225.31801-4-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

High level description:
Level 7 interrupts are Non-Maskable Interrupts (NMI) on the M68k architecture. The hardware asserts an NMI only on the rising edge of the level 7 signal. The current QEMU implementation treats level 7 like a standard level interrupt. This patch ensures proper NMI edge-triggered semantics for level 7, which is strictly required by the Sun-3 keyboard/mouse NMI routing logic.

Impact on existing functionality:
Corrects NMI edge-triggering for all M68k boards, adhering closely to the Motorola specifications. Existing boards will now correctly require an edge transition to trigger consecutive NMIs.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/cpu.h       |  1 +
 target/m68k/helper.c    |  6 ++++++
 target/m68k/op_helper.c | 14 ++++++--------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108..058777b891 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -148,6 +148,7 @@ typedef struct CPUArchState {
 
     int pending_vector;
     int pending_level;
+    bool nmi_pending;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 68f523ea84..93739ccda7 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -949,6 +949,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
     CPUState *cs = CPU(cpu);
     CPUM68KState *env = &cpu->env;
 
+    if (level == 7 && env->pending_level != 7) {
+        env->nmi_pending = true;
+    } else if (level != 7) {
+        env->nmi_pending = false;
+    }
+
     env->pending_level = level;
     env->pending_vector = vector;
     if (level) {
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a68981..30af4a2631 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -522,14 +522,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUM68KState *env = cpu_env(cs);
 
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
-        /*
-         * Real hardware gets the interrupt vector via an IACK cycle
-         * at this point.  Current emulated hardware doesn't rely on
-         * this, so we provide/save the vector when the interrupt is
-         * first signalled.
-         */
+    if (env->nmi_pending) {
+        env->nmi_pending = false;
+        cs->exception_index = env->pending_vector;
+        do_interrupt_m68k_hardirq(env);
+        return true;
+    } else if (((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
         cs->exception_index = env->pending_vector;
         do_interrupt_m68k_hardirq(env);
         return true;
-- 
2.50.1 (Apple Git-155)


