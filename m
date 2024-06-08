Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14BCC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrX8-0000Wi-2f; Sat, 08 Jun 2024 04:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX4-0000UF-8w
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX2-0008G7-3u
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZXg5/L7nPPJRmwWi/bRL++Ow5ed1vgkGFx1Ql7WL3I=;
 b=jCvdx4o3SrXnjZduAyePVYW++kdiQ0pLqk41HoRnL/DLaeTtUlsDEdoQYHcSktYCyKYRto
 wHSjnzFljnpNPFAGS8bxTUDQHsEHoBO7zryGSWdo5OFRpuqDOwlNU3usoYyZUrwEMcaVxT
 aDuwMqdDT68rHTmp/aZDcJUgJllN5U8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-GKuY5RmpMXakumNlVb2lfQ-1; Sat, 08 Jun 2024 04:34:30 -0400
X-MC-Unique: GKuY5RmpMXakumNlVb2lfQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c5216e486so816695a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835669; x=1718440469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZXg5/L7nPPJRmwWi/bRL++Ow5ed1vgkGFx1Ql7WL3I=;
 b=F7Maaw7mxd5wL2Rya4aRL/6sfExF1CSklNVbYyyn/XBk2/O121+DK9JoRNhVECCE8d
 MNYKuNmGX5/NAG+nXSWGw3EFnyeA9puaY+C9/SdQ5yqVKteLpdMxvN4XYl6O25qGB/6m
 SAROuv54BAGGFiSs01RD4OOj8Z009leDFQcamIE30Pfxk6WIh7FVZxd9QmOpBGzsVENj
 hvkTqqkGi4P8ZH7Y284nUqkmZBf71nxI0NIwetzitVTQF+yqVo5qSfIQdOpdnvpa293K
 LZzoffPUySl+CQn1vdHP/uuElEmOEMNuKMaUS2sLg78lFtGSHjO32IoOkXGiBIBnachA
 HGKw==
X-Gm-Message-State: AOJu0YzS8cwByLAtHI7d7McIayF5vvwb8+QNKBU8gnlSNlYDCwgGVcjc
 GMyt72bahBXpMMl/Jkoekz9jNiTjXFC5Db6c+93zZP382uJ3VKw6QkqDVxp/ikxL+ZnbOi9TYBv
 0xWq9q+AH7Qh32LX6Nci+hYe0SYDn/5GpwdyPED+ZNCQsTMmZ4odJw9Dc0sNRSvmwkeg3uEuJVD
 Ohgvweqn5Y9tnslJGE8ETcn2HTutlHWrZJW5HX
X-Received: by 2002:a50:d61b:0:b0:57c:41e1:6e59 with SMTP id
 4fb4d7f45d1cf-57c50924b9bmr3004373a12.23.1717835668909; 
 Sat, 08 Jun 2024 01:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF335a0HmK8kKOQbYU2x9BhmnyqUpOUwWyWpPBso3bkWBahxyny/BxxU7UnFdNGtHIwSkEB2w==
X-Received: by 2002:a50:d61b:0:b0:57c:41e1:6e59 with SMTP id
 4fb4d7f45d1cf-57c50924b9bmr3004362a12.23.1717835668432; 
 Sat, 08 Jun 2024 01:34:28 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae102c7esm3930956a12.45.2024.06.08.01.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/42] target/i386: cleanup PAUSE helpers
Date: Sat,  8 Jun 2024 10:33:37 +0200
Message-ID: <20240608083415.2769160-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use decode.c's support for intercepts, doing the check in TCG-generated
code rather than the helper.  This is cleaner because it allows removing
the eip_addend argument to helper_pause(), even though it adds a bit of
bloat for opcode 0x90's new decoding function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                 |  2 +-
 target/i386/tcg/helper-tcg.h         |  1 -
 target/i386/tcg/misc_helper.c        | 10 +---------
 target/i386/tcg/sysemu/misc_helper.c |  2 +-
 target/i386/tcg/decode-new.c.inc     | 15 ++++++++++++++-
 target/i386/tcg/emit.c.inc           | 20 ++++++++------------
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index c244dbb4812..2f46cffabd8 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -53,7 +53,7 @@ DEF_HELPER_1(sysenter, void, env)
 DEF_HELPER_2(sysexit, void, env, int)
 DEF_HELPER_2(syscall, void, env, int)
 DEF_HELPER_2(sysret, void, env, int)
-DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index eb6a4926a43..15d6c6f8b4f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -91,7 +91,6 @@ extern const uint8_t parity_table[256];
 
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
-G_NORETURN void do_pause(CPUX86State *env);
 
 /* sysemu/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index b0f0f7b893b..8316d42ffcd 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -88,7 +88,7 @@ G_NORETURN void helper_rdpmc(CPUX86State *env)
     raise_exception_err(env, EXCP06_ILLOP, 0);
 }
 
-G_NORETURN void do_pause(CPUX86State *env)
+G_NORETURN void helper_pause(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -97,14 +97,6 @@ G_NORETURN void do_pause(CPUX86State *env)
     cpu_loop_exit(cs);
 }
 
-G_NORETURN void helper_pause(CPUX86State *env, int next_eip_addend)
-{
-    cpu_svm_check_intercept_param(env, SVM_EXIT_PAUSE, 0, GETPC());
-    env->eip += next_eip_addend;
-
-    do_pause(env);
-}
-
 uint64_t helper_rdpkru(CPUX86State *env, uint32_t ecx)
 {
     if ((env->cr[4] & CR4_PKE_MASK) == 0) {
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index e41c88346cb..093cc2d0f90 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -547,7 +547,7 @@ G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
 
     /* XXX: not complete but not completely erroneous */
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
-        do_pause(env);
+        helper_pause(env);
     } else {
         helper_hlt(env);
     }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 376d2bdabe1..c2d8da8d14e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1359,6 +1359,19 @@ static void decode_group11(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     }
 }
 
+static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static X86OpEntry pause = X86_OP_ENTRY0(PAUSE, svm(PAUSE));
+    static X86OpEntry nop = X86_OP_ENTRY0(NOP);
+    static X86OpEntry xchg_ax = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v);
+
+    if (REX_B(s)) {
+        *entry = xchg_ax;
+    } else {
+        *entry = (s->prefix & PREFIX_REPZ) ? pause : nop;
+    }
+}
+
 static const X86OpEntry opcodes_root[256] = {
     [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
     [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
@@ -1441,7 +1454,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
-    [0x90] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x90] = X86_OP_GROUP0(90),
     [0x91] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
     [0x92] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
     [0x93] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2e94e8ec56f..f90f3d3c589 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2350,6 +2350,14 @@ static void gen_PANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
                       decode->op[1].offset, vec_len, vec_len);
 }
 
+static void gen_PAUSE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_next(s);
+    gen_helper_pause(tcg_env);
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
 static void gen_PCMPESTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -4014,18 +4022,6 @@ static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (decode->b == 0x90 && !REX_B(s)) {
-        if (s->prefix & PREFIX_REPZ) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
-        }
-        /* No writeback.  */
-        decode->op[0].unit = X86_OP_SKIP;
-        return;
-    }
-
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_xchg_tl(s->T0, s->A0, s->T1,
                                s->mem_index, decode->op[0].ot | MO_LE);
-- 
2.45.1


