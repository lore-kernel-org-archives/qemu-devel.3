Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628ECC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLv-00016C-Nl; Thu, 01 May 2025 17:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLm-00010a-QL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLk-0001Zj-6o
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c277331eso2479937b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134503; x=1746739303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4pHptChpTg8JmP9JZXmpp1i8GS4hyZpnC7DzMw80NY=;
 b=HfPFFBu7agSOh1/mFjqBu3aKlsQg/cnynqxtGXNvoYDmgpzDX0xq5p6sV3fM7fPLzZ
 EYrKZw9QzDoBxBMYmDqa4kUAZQwLvD6UPALznsTry5HEBKL1nmA645ZwIRCMd8DFZIjC
 8Z68/AAWASyBkeeaL/hJBKChB5VhpcUfZpGlZygTBVMR5I6PN6aQ9poOtfbx/0EPblEw
 tt964NHeL8Q51QA3Nd6+Udw+7txmfdOggW7iq3JOcbJ8fgyNWutCaBMaH+VseVWTjOgK
 ClEwrsEfK7EyvY2Cm4EnSgPb3gfStSx1hZgfpkG4L24Isr1OKm0brtO/4sBgW4CPDpFd
 dbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134503; x=1746739303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4pHptChpTg8JmP9JZXmpp1i8GS4hyZpnC7DzMw80NY=;
 b=YNYbCMVOx4qP2NybLnkyo7UgHD3815y4JJW1M9h3k8PB9qNaoyeMKTEOALTPLt/bza
 crJhU2xeQf2qNjqDqJ4JxB6nm8rtShMDw41BDIQnMrSZG+GxYVzcIgsJ9CxX7q+thX3E
 UszahH8kxe9kndiL9/ndR9ZiuPHnVYb8Xt8L4buFiI5iAFEMjbGLHTmruNZtV8c9sm4W
 iRwDyOez2DS73Jb/AE3vyUZUjrq5X0canB4ScBma/1a7SGsbJZo2HauaciIAydIqolgJ
 lIJZ1+RJ8QDp7+dRJGPsOe75nk/Ka3IZa+J7328hxluqseOsF0Z1g17kpv0ivqJdF1BZ
 4gAg==
X-Gm-Message-State: AOJu0YyLPbT0Jr1JsJ7MZ6mVH+JWCLjUv0fljAU2SVdo/xSrysJLeyrj
 EuUXdnAw1ZNsFxsbQhFOu7MTjsjMbHtqezSmGktY9FK8PXSpV242ns3LBpvHg28xygEPvc6WoAG
 x
X-Gm-Gg: ASbGncs38ObZ5h7fryKB4Ol35DerH2RWxbHiv/lIBYEhNNXN/nQXQrC+5qDDeZoSFz1
 05ok245/xIYIoCyKeLSwyBE7vBhnqNHY4RoeRBiCRku1NWebYSUFtFOFvr7q/ljymJtbHpgZ11d
 s2FsKdI1mLL+/g1r2dRWnJJEaVZA21XBh9Qw9IYpC2DD15Ec8uucuiHINvFnyL6fAhfuDz0L25F
 MdbUKDFicQ2+Y9629eqjTRl77sseA6guCh8wDrbZuzIJSxKVjo5M3aEDL6moDUYq3bLNoQpwulI
 /q52jKM69KjrQM7+8owwoIy6X/0c8LayaxidMwhVAyfNLqbuVM04+T1XVEdq53nNuQGAujVFDco
 =
X-Google-Smtp-Source: AGHT+IEBRTgJzJMmSrFiUEx1YE3mPX2zXQBX5nW24KqOdsKe/bc14Lx3+QDLdiewRWA0aP32tB1ejA==
X-Received: by 2002:a17:90b:2cc5:b0:2fa:1d9f:c80 with SMTP id
 98e67ed59e1d1-30a42fe44eamr5881267a91.17.1746134502705; 
 Thu, 01 May 2025 14:21:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 34/59] accel/tcg: Pass TCGTBCPUState to tb_lookup
Date: Thu,  1 May 2025 14:20:48 -0700
Message-ID: <20250501212113.2961531-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4a405d7b56..808983e461 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -232,35 +232,33 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
  *
  * Returns: an existing translation block or NULL.
  */
-static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
-                                          uint64_t cs_base, uint32_t flags,
-                                          uint32_t cflags)
+static inline TranslationBlock *tb_lookup(CPUState *cpu, TCGTBCPUState s)
 {
     TranslationBlock *tb;
     CPUJumpCache *jc;
     uint32_t hash;
 
     /* we should never be trying to look up an INVALID tb */
-    tcg_debug_assert(!(cflags & CF_INVALID));
+    tcg_debug_assert(!(s.cflags & CF_INVALID));
 
-    hash = tb_jmp_cache_hash_func(pc);
+    hash = tb_jmp_cache_hash_func(s.pc);
     jc = cpu->tb_jmp_cache;
 
     tb = qatomic_read(&jc->array[hash].tb);
     if (likely(tb &&
-               jc->array[hash].pc == pc &&
-               tb->cs_base == cs_base &&
-               tb->flags == flags &&
-               tb_cflags(tb) == cflags)) {
+               jc->array[hash].pc == s.pc &&
+               tb->cs_base == s.cs_base &&
+               tb->flags == s.flags &&
+               tb_cflags(tb) == s.cflags)) {
         goto hit;
     }
 
-    tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
+    tb = tb_htable_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
     if (tb == NULL) {
         return NULL;
     }
 
-    jc->array[hash].pc = pc;
+    jc->array[hash].pc = s.pc;
     qatomic_set(&jc->array[hash].tb, tb);
 
 hit:
@@ -268,7 +266,7 @@ hit:
      * As long as tb is not NULL, the contents are consistent.  Therefore,
      * the virtual PC has to match for non-CF_PCREL translations.
      */
-    assert((tb_cflags(tb) & CF_PCREL) || tb->pc == pc);
+    assert((tb_cflags(tb) & CF_PCREL) || tb->pc == s.pc);
     return tb;
 }
 
@@ -402,7 +400,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
         cpu_loop_exit(cpu);
     }
 
-    tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+    tb = tb_lookup(cpu, s);
     if (tb == NULL) {
         return tcg_code_gen_epilogue;
     }
@@ -581,7 +579,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
          * Any breakpoint for this insn will have been recognized earlier.
          */
 
-        tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+        tb = tb_lookup(cpu, s);
         if (tb == NULL) {
             mmap_lock();
             tb = tb_gen_code(cpu, s.pc, s.cs_base, s.flags, s.cflags);
@@ -955,7 +953,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 break;
             }
 
-            tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+            tb = tb_lookup(cpu, s);
             if (tb == NULL) {
                 CPUJumpCache *jc;
                 uint32_t h;
-- 
2.43.0


