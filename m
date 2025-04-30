Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6263FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcj-00060g-Vt; Wed, 30 Apr 2025 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcP-00059u-FA
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcM-0001vA-Sd
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso123161b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031745; x=1746636545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nN+VhF6i+pyNwMFDScdlcKn4qf+d1VgVsfcYGuBPgk=;
 b=N0ckhziHavNlFPS6jTpxvsIJZkPpMd5FSwD4CDBrKLf1opDQjLlm0PY+8Yj+pKQnyO
 a3o4vV93HBFBD0QJRiYSAqFIxc2dzl1FAmBeFv428w1e0fCQE1r6+qknGmi6U5qW/cNf
 3ZJQTfXZdRtVu1pdT30WqczF94QKWhPAVXRH2e3WM+Yz+95d4EijC08NiWG1SvXj2gHi
 DFvD7AHp9SSMyftqF/DdiiVmfQuo/7OlIcx4/qeyyY8WbQwpv54UZAL3uk/Jx/u1bW+W
 BysTyIdPRcSRRRUotEpp0O2fyTop+Zqs9Z6NUJXDoMSeUbI+WutGn8Jvf1bjcUsqvrv0
 FzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031745; x=1746636545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nN+VhF6i+pyNwMFDScdlcKn4qf+d1VgVsfcYGuBPgk=;
 b=gLIozX/oXp69TVEttWj7OFCP5C6P2fJQEmbxUhri7yEMsa7s15TfmUVknfuLt1rTWd
 28SRjzugmeZAxPjFDwrCT7Mt5GCisyGlky1BsJt0cnuQyK+/Va2GwPmqbJ1DkoQt2QwN
 Ix6stuZpdjQRXOH+A71gqqNmEthlJJyzLrlCNPdiVuBRK4wAUGlHClSAuRbw6JA3pmZi
 399DeOnqRRHv2OdUTs+3l68YjdoEjn/mnPx7LipSCQIgRvWTrbhSC1PoqlNtYg0hyyb0
 t7dVW5N46aFmK4D+qqCGKrsVaZsSxJ1ZRrUQ1defoBmbCzRdYjMcZ9sQI47wGAgiKUgt
 Au+Q==
X-Gm-Message-State: AOJu0Yy0NRPGAZ4eNWibE54KaVCsygKulN5AzVPetm0cA3i5NfD0eAmD
 2jO/BB2Y3MNzOp2mE3OtC/q1F5MTvxsrCnS18RqbpjCtZTHsT4yjq8ueN+wldq9wSrl5T0tYDEG
 n
X-Gm-Gg: ASbGncuzExWAol35rG6CTzfEwHbqoej1oY0h3n/rOG7bcAGCY4Zja1ZlHf802DS4hWS
 y/B6tw85EuYiHRtfwQrGAgB6x7ACQ6ZWpFXtj3Tq9Imfj0T0lkPyvbx+W76P5Q3J0NFr+uMkkMs
 T609+OIUD9X5QjGX7cdhs4oRY3oUR2XswLpRxg02l3dcJ+qzEokT3g4GMIBUGVvIocsoq9Xu952
 WotYMfbEc/x0OmOsyGX2JVuA9G8DSP18Ic/QLL2TJn3MtYL/IWJNJjRx71hTzmEvA5Q/3UpetAa
 jXRgKNXoY4a8hc4IDuQZCeeV75m2aq9ZeH25iwY5oocjHB/3WzWyUshB/fJTJqpLCgPndG9NJIJ
 6xUynetVqeA==
X-Google-Smtp-Source: AGHT+IHnOcKwmRXIJF1cFlSqM1U1OBhDPMVLQSl6TTBIThOI/V0/WpobNbEIg39I4G6FsX+aZqTkGQ==
X-Received: by 2002:a05:6a20:cfa4:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-20aa468607fmr5534473637.41.1746031744677; 
 Wed, 30 Apr 2025 09:49:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 11/16] accel/tcg: Pass TCGTBCPUState to tb_lookup
Date: Wed, 30 Apr 2025 09:48:49 -0700
Message-ID: <20250430164854.2233995-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


