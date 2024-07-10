Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB552C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpo-00009L-IT; Wed, 10 Jul 2024 02:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpn-0008UB-5x
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpl-0000uv-HK
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1qNKNLHYi6Nd/xVugw2OZb8ZRyjnHbwEiVtGU6tBOc=;
 b=Nc1QlymAQmVGj6XeyYhuiq4ALWAbKqnHP/hWEK2p2OjsA50s1zMX/4uTZdEJsTyn9r6scj
 26ewPQK8ctjI7+NvGKqr48cSuitBAzehvNxDJfIBNKnpx+iBq22O66taCoNDFfJe8FA8PY
 vGCO84Mh227KD2kyzBI7lvNXRW9Y9zY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ozcy-4VbOYuv48zE1hJzMA-1; Wed, 10 Jul 2024 02:29:42 -0400
X-MC-Unique: ozcy-4VbOYuv48zE1hJzMA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36785e6c1e6so4046900f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592980; x=1721197780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1qNKNLHYi6Nd/xVugw2OZb8ZRyjnHbwEiVtGU6tBOc=;
 b=jR2qkDWEdrlQdKImfZd5szQYLVsbK4uPMfqU0/Wcnp+uzDyL29UItPFTwmRdx5xc+Q
 rFKv/HeGw3QNYf7ORB/RubiGIDLyrD7ND5UbSOAVGRUrQm3rDYOXzxg1PgITBXAb/dUZ
 T/XQExwYPizav0fSrExLs3mfsd+6uhzISPOxu0/miAOXEDpvMAvVs8u61K2YDke12pxs
 qMPH4v0msP2nvJqU/xvVIZ9USG34Duh89H3f1QjU+V0cShTj7O37usd9I/QjAhXDe79Y
 mXIehDFZ5BVx71NER6o6rktwjbOZ5SbQYNSGuiPBEr/OHmi0gbjW9wFKB05A4/1IISL0
 lnkw==
X-Gm-Message-State: AOJu0YyZ3UiZjUPCypkat7jlUlpNPl+rfXmq78h2r/DLroOderz4bCoY
 ycHQyvibV0SiAyK5HbgCDcWlsg7F9rEwEYIC2iOp9VQ4ECXZmDb6jTLJbqooP4K5jGBtE9wXfpo
 ujGtx17troagYc/G2AvelhW2Ym2mTsUH4miwjsOdf6KkH/HU5mf0SWMbupOaZSlJRWhDYQENH9v
 8/4WsREpxuwyo9COlS8N5XlNs6A/JulNT74iyh
X-Received: by 2002:a5d:6da9:0:b0:367:9c9e:714d with SMTP id
 ffacd0b85a97d-367cea46772mr4119165f8f.11.1720592979873; 
 Tue, 09 Jul 2024 23:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcFRQTQuTy1RZ3CdXH+/cRSwoq6jXp5qsG2NsJhWORbnOkHMrHjV0xKYi8x3S+we1LZ2833g==
X-Received: by 2002:a5d:6da9:0:b0:367:9c9e:714d with SMTP id
 ffacd0b85a97d-367cea46772mr4119152f8f.11.1720592979536; 
 Tue, 09 Jul 2024 23:29:39 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e07fsm4347771f8f.17.2024.07.09.23.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 06/10] target/i386/tcg: Compute MMU index once
Date: Wed, 10 Jul 2024 08:29:16 +0200
Message-ID: <20240710062920.73063-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the MMU index to the StackAccess struct, so that it can be cached
or (in the next patch) computed from information that is not in
CPUX86State.

Co-developed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 6b3de7a2be4..07e3667639a 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -587,36 +587,37 @@ typedef struct StackAccess
     target_ulong ss_base;
     target_ulong sp;
     target_ulong sp_mask;
+    int mmu_index;
 } StackAccess;
 
 static void pushw(StackAccess *sa, uint16_t val)
 {
     sa->sp -= 2;
-    cpu_stw_kernel_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
-                      val, sa->ra);
+    cpu_stw_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+                      val, sa->mmu_index, sa->ra);
 }
 
 static void pushl(StackAccess *sa, uint32_t val)
 {
     sa->sp -= 4;
-    cpu_stl_kernel_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
-                      val, sa->ra);
+    cpu_stl_mmuidx_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+                      val, sa->mmu_index, sa->ra);
 }
 
 static uint16_t popw(StackAccess *sa)
 {
-    uint16_t ret = cpu_lduw_data_ra(sa->env,
-                                    sa->ss_base + (sa->sp & sa->sp_mask),
-                                    sa->ra);
+    uint16_t ret = cpu_lduw_mmuidx_ra(sa->env,
+                                      sa->ss_base + (sa->sp & sa->sp_mask),
+                                      sa->mmu_index, sa->ra);
     sa->sp += 2;
     return ret;
 }
 
 static uint32_t popl(StackAccess *sa)
 {
-    uint32_t ret = cpu_ldl_data_ra(sa->env,
-                                   sa->ss_base + (sa->sp & sa->sp_mask),
-                                   sa->ra);
+    uint32_t ret = cpu_ldl_mmuidx_ra(sa->env,
+                                     sa->ss_base + (sa->sp & sa->sp_mask),
+                                     sa->mmu_index, sa->ra);
     sa->sp += 4;
     return ret;
 }
@@ -677,6 +678,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
+    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (type == 5) {
         /* task gate */
@@ -858,12 +860,12 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 static void pushq(StackAccess *sa, uint64_t val)
 {
     sa->sp -= 8;
-    cpu_stq_kernel_ra(sa->env, sa->sp, val, sa->ra);
+    cpu_stq_mmuidx_ra(sa->env, sa->sp, val, sa->mmu_index, sa->ra);
 }
 
 static uint64_t popq(StackAccess *sa)
 {
-    uint64_t ret = cpu_ldq_data_ra(sa->env, sa->sp, sa->ra);
+    uint64_t ret = cpu_ldq_mmuidx_ra(sa->env, sa->sp, sa->mmu_index, sa->ra);
     sa->sp += 8;
     return ret;
 }
@@ -982,6 +984,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
+    sa.mmu_index = cpu_mmu_index_kernel(env);
     sa.sp_mask = -1;
     sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
@@ -1116,6 +1119,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = 0xffff;
     sa.ss_base = env->segs[R_SS].base;
+    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (is_int) {
         old_eip = next_eip;
@@ -1579,6 +1583,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
+    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (shift) {
         pushl(&sa, env->segs[R_CS].selector);
@@ -1618,6 +1623,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
     sa.env = env;
     sa.ra = GETPC();
+    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (e2 & DESC_S_MASK) {
         if (!(e2 & DESC_CS_MASK)) {
@@ -1905,6 +1911,7 @@ void helper_iret_real(CPUX86State *env, int shift)
 
     sa.env = env;
     sa.ra = GETPC();
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
     sa.sp_mask = 0xffff; /* XXXX: use SS segment size? */
     sa.sp = env->regs[R_ESP];
     sa.ss_base = env->segs[R_SS].base;
@@ -1976,8 +1983,11 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     target_ulong new_eip, new_esp;
     StackAccess sa;
 
+    cpl = env->hflags & HF_CPL_MASK;
+
     sa.env = env;
     sa.ra = retaddr;
+    sa.mmu_index = x86_mmu_index_pl(env, cpl);
 
 #ifdef TARGET_X86_64
     if (shift == 2) {
@@ -2032,7 +2042,6 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         !(e2 & DESC_CS_MASK)) {
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, retaddr);
     }
-    cpl = env->hflags & HF_CPL_MASK;
     rpl = new_cs & 3;
     if (rpl < cpl) {
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, retaddr);
-- 
2.45.2


