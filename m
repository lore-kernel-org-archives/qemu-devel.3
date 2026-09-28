Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0b-0005BL-A6; Mon, 28 Sep 2026 09:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0M-00058u-Ft
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0K-0004LN-MJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2k0RAE3yH+mAPkRgnnTbNxJVn8C+UzA/xz4iFbpNNAI=;
 b=UbeU2t1TI0ZhDJbQHsD7WIcWRAYuri6GwZI8VImRj/m4zglMiXmFQgTDuvrcKOvy4BOehn
 k1cF+yAda0qdiNe0du9qgDAV/9P4CiWda8nO80O3t5pf0Fhj1HeOVLIGr8bNV/zvjNzqoD
 BNnLbOu1lnnYNeu4mXn4isVn/CV1WHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-dCZhl_fINRCq7Y4RWjp4CQ-1; Mon, 28 Sep 2026 09:02:44 -0400
X-MC-Unique: dCZhl_fINRCq7Y4RWjp4CQ-1
X-Mimecast-MFC-AGG-ID: dCZhl_fINRCq7Y4RWjp4CQ_1790600563
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c293e9cd02fso311432066b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600562; x=1791205362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2k0RAE3yH+mAPkRgnnTbNxJVn8C+UzA/xz4iFbpNNAI=;
 b=shzZx13owRM0nDCEy90Td256kIRdECO7b75yf2iqm2ymv4MNoo4wl1sZSOpCOtgNLt
 JaI2XbJFAM4dnS0AuyXLjlBU33KITtH2331mwsQyAZ4TrHGAiBoCsLIYe+nGre19bz9X
 3NuCBus7QjbxSK2b4KfHxpn2IPCw8NpNfkpHF0IQuvSfKOhnjrEG9Fw7F9gDiLgmqAGl
 3tWxtVB3n7xxmVwN1/0blzEHw6GHClhOUK6NW8XuvssEAQ83LQLXYutinPCS6nixnDDp
 r3H0XHzCHqxVwpCVi9i3QyKfc6uXbctMBj3mTgGy5CqVW7t4juWgOiH0x1mUN108Ww3Z
 HbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600562; x=1791205362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2k0RAE3yH+mAPkRgnnTbNxJVn8C+UzA/xz4iFbpNNAI=;
 b=Okv3Ssc8zpvaEeizbfI+O67bDXWSNAjzQ6WDFrmVJ/NIV2NR2uH9Xi/NmtguVTuMUO
 XdGLR40zpcyR0mN4m/pcNgRG/95ear97IEUP7YNtjGgq7HGrU8qROByhBk730yY7u1US
 PgTgRxW6HP3yVf+x9nDE1r93WhUMd96CrKEd7Frx9eyCliGioHXRTgPjf3TykK8MVbPh
 Dg5BoWcVu9SYw2XJ0FQ9b4AiVBS74zXGjxYqt0Isy0RzVsmd8cBpZGiNUYDj3/oDpNP6
 mKU1I9yZnwS22MjZLlncvTK1f92Ns7tyiHld29xUsylSOiLwzmqtrICbjug7sAqbnuTE
 3bIg==
X-Gm-Message-State: AFq9FYKu51a7iyE2ZI1s2aE3U1hCNl52tr4MGlpL4ccxRTzsEbNe09Ie
 3ro7q6Vz9cLgWicoYbZQRceaQzgJiYTBORgy7CEV0mNYwRkmCkW6x8VvqArf5TVoocAoHq/VgiE
 nuqKrJ0PiyKTEVoaUbtv1MZMFJOD3z73k1P37k2cjDJq/mnBBCsVtvpWevrXkvXiGv9P7853shR
 Pey3dVd4qdrq7Sm5SqUOWss7WQQBtNsgCHKQ04qo6/
X-Gm-Gg: AYBFou2uVbf04QFFS1LVFFZtIwDguIgI2iRhAEtTBxi6MCLUk2C/adhxdqb3Jjn4yIb
 7fR2sGOzwy+4KSsfKtHowUF3JXD2L7778EgptjytLoLgIJmEtPzdE0iTbeyWDYMtqv4zITTyCA7
 jceF4d1wVpPoFN/aBaak2YlzLh2isfd86YPqPEB46fYvgEDKuHd+nnL3TXMYCh6STvGMylvnriF
 dDdLRg5rnj0Y77O5aYa0GsxqHhoaStxFXQu2SD716H56YI7dFd08FVA9/wJXVpERgYeJL9Mk2v8
 czb52ueh8rClVEVPu9Fc3ABPfRt4JGeGoaQzQA6OVvJXO8Wuo88oUf18P9VhdOnKztjRgO6W5vx
 KERsbqbTC+GcU5/Ai6OB4sjzM+0JyLPOj1V6xSLFrYlU+rQSBcrDQSiGtWYZqH33sQIJb9EVswp
 lYNq0V
X-Received: by 2002:a17:907:9447:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c2ac250ec3emr1052752266b.35.1790600562642; 
 Mon, 28 Sep 2026 06:02:42 -0700 (PDT)
X-Received: by 2002:a17:907:9447:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c2ac250ec3emr1052748766b.35.1790600562159; 
 Mon, 28 Sep 2026 06:02:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2defb6613csm1615866b.58.2026.09.28.06.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/30] target/i386: fix EFLAGS reads in TCG plugin callbacks
Date: Mon, 28 Sep 2026 15:02:02 +0200
Message-ID: <20260928130228.877003-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Artemii Mashanov <ralerrdirsardx@gmail.com>

The plugin register API reads env->eflags through the gdbstub.
During TCG execution, arithmetic flags are kept in the lazy CC state
and DF in env->df, so this can return incorrect EFLAGS values.

Add eflags_in_tcg, set on TCG entry and cleared on exit, to select
cpu_compute_eflags() while the flags are split. Also synchronize cc_op
with gen_update_cc_op() before instruction callbacks when plugins are
enabled, since the current value may still be in the translator context.

Outside TCG execution, keep reading env->eflags, which holds the
complete flags. Unconditional reconstruction can use stale lazy state
and break GDB readback: in testing, writing 0x0202 through GDB was
followed by a readback of 0x0203.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1047061.html
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260913173801.96942-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 1 +
 target/i386/gdbstub.c       | 3 +++
 target/i386/tcg/tcg-cpu.c   | 2 ++
 target/i386/tcg/translate.c | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4b9df1d3329..3f69b0a066a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2357,6 +2357,7 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUX86State env;
+    bool eflags_in_tcg;
     VMChangeStateEntry *vmsentry;
 
     uint64_t ucode_rev;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 5c5fa727216..e636ca0f4ae 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -151,6 +151,9 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         case IDX_IP_REG:
             return gdb_get_reg(env, mem_buf, env->eip);
         case IDX_FLAGS_REG:
+            if (cpu->eflags_in_tcg) {
+                return gdb_get_reg32(mem_buf, cpu_compute_eflags(env));
+            }
             return gdb_get_reg32(mem_buf, env->eflags);
 
         case IDX_SEG_REGS:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..2402608fe90 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -38,6 +38,7 @@ static void x86_cpu_exec_enter(CPUState *cs)
     env->df = 1 - (2 * ((env->eflags >> 10) & 1));
     CC_OP = CC_OP_EFLAGS;
     env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+    cpu->eflags_in_tcg = true;
 }
 
 static void x86_cpu_exec_exit(CPUState *cs)
@@ -46,6 +47,7 @@ static void x86_cpu_exec_exit(CPUState *cs)
     CPUX86State *env = &cpu->env;
 
     env->eflags = cpu_compute_eflags(env);
+    cpu->eflags_in_tcg = false;
 }
 
 static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d13e8cdf3f0..3cdc458f95b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3484,6 +3484,9 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    if (dcbase->plugin_enabled) {
+        gen_update_cc_op(dc);
+    }
     dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
-- 
2.55.0


