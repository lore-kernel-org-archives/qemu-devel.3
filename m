Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D781BE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwBN-0003Wd-00; Wed, 18 Dec 2024 10:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwBL-0003WP-KF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:41:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwBJ-0001zk-PY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:41:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4988378f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734536507; x=1735141307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w6Tv2Ao+uXbOtOiwAHMBKbTEAK/IemogTgtgVIeb2UI=;
 b=Gnp5/eRIG9DAJvyBfHFa/4fkKyB72YC15mhkgrHopz3inQbH/Fg3NA38jOy43RjNWY
 EqkdI3WxjqFg/fPVKYeNycgb932zNldrxk4JxIRRfG6Cy0YNXcTp1C7Fa+SuTgMNKmjh
 2bkxsdEa7pyEg+Gdq7ySOfd84MdkffkMDdVMOPhtS1mnkO/lid1+naXQepULqYW0KPNf
 KqVeKgsIqjXGJ0bRs0dPg43erSwBhNNmCpNuJeiAojKs7lCGOgrgjmgeBUi80ZGigaoS
 kUh+xJtGattTuy2NsmL4l12l4VD/RolbPNNjgPjvy95oHifFDJ/GCpFZbv3r1B8xkWVC
 34Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734536507; x=1735141307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w6Tv2Ao+uXbOtOiwAHMBKbTEAK/IemogTgtgVIeb2UI=;
 b=rUtkp20zKlfnKoYWCFIxUw0j9iap+QfGn6b6IkLUfX2OEbxXWWWGGSi431OezmcQxe
 KMUZfK2QHjGnOwC5b4JLuHK5j+lGjAQIFwqbO+GSAIreRWZK602jAEYC5IEk7sLrZ5xQ
 +Yf3ixu+uQCKtiNDSQX0Aj0gsen6XV7+8GOKk2WcvbKOM20WhdbGX8TJMUzoH6m9dZ0Y
 AukmQvnTRwwNpiRVvraod8GImlqeZN0P463Yg3ocLBmSZJwDPiOOTmN3vXGSenBO+fNp
 XB5ZOzdL0YCbTUsC09ZWYYHfh30Hr0VLFBX3GuIS6fmh6i8N9mqyy+clfIDmzD+Yp/qE
 BrmA==
X-Gm-Message-State: AOJu0YzNR5yBhwkpTJwgixHz2ciuKqIx2y3E65gJ6M40SzJWR+a3RpUS
 FhszUnmN9tkv/AK1BCGvkxmbTqH5uK2qfBusIjJx2QQE108nYIKn7svWyhRQOv7BZNb25oD7/Cv
 x
X-Gm-Gg: ASbGncskqnqjRvXBeoH+n7iKfah7vIORvMOLh2NCbln39MfLwClfj/2IVMRJq0zL5J4
 Vv90HMtB/Z6+4Mwy9GukfV92YLgK46EaP6Xdo3jhk9xAXGgB/nTvd3HbK2al4l0Yje1PE9zIU1E
 kWF6zOH+Q0mOnSEJwVOw336XprVAi4Ah3HTBxRDDNIq6kZnF+b3EXQbeY15HxKv193TNrNkxKj7
 oP7pehkwcYwf22KjKG/oqGZIqrIxVb9DUGzUdub4laspMZMux/lG89r0o6HNMWK7g2bpxEAJbRs
 q3OS
X-Google-Smtp-Source: AGHT+IEg0dCrfm9oVvod5GO3xCFfiEIJ0cq+woV2wt0mBC8oG3NTzMf8s++3NS/XS46wXnvNIsckAg==
X-Received: by 2002:a5d:6e87:0:b0:385:f638:c68a with SMTP id
 ffacd0b85a97d-388e4d6437bmr2691335f8f.30.1734536507046; 
 Wed, 18 Dec 2024 07:41:47 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012097sm14420185f8f.18.2024.12.18.07.41.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:41:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Un-inline translator_is_same_page()
Date: Wed, 18 Dec 2024 16:41:45 +0100
Message-ID: <20241218154145.71353-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Remove the single target-specific definition used in
"exec/translator.h" (TARGET_PAGE_MASK) by un-inlining
is_same_page().
Rename the method as translator_is_same_page() and
improve its documentation.
Use it in translator_use_goto_tb().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Richard, I'll merge this myself once reviewed.
---
 include/exec/translator.h    | 15 +++++++--------
 accel/tcg/translator.c       |  7 ++++++-
 target/i386/tcg/translate.c  |  6 +++---
 target/riscv/translate.c     |  4 ++--
 target/s390x/tcg/translate.c |  4 ++--
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index d8dcb77b5f4..41e2a41180f 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -267,16 +267,15 @@ bool translator_st(const DisasContextBase *db, void *dest,
  */
 size_t translator_st_len(const DisasContextBase *db);
 
-#ifdef COMPILING_PER_TARGET
-/*
- * Return whether addr is on the same page as where disassembly started.
+/**
+ * translator_is_same_page
+ * @db: disassembly context
+ * @addr: virtual address within TB
+ *
+ * Return whether @addr is on the same page as where disassembly started.
  * Translators can use this to enforce the rule that only single-insn
  * translation blocks are allowed to cross page boundaries.
  */
-static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
-{
-    return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
-}
-#endif
+bool translator_is_same_page(const DisasContextBase *db, vaddr addr);
 
 #endif /* EXEC__TRANSLATOR_H */
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ce5eae4349e..ef1538b4fcd 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -104,6 +104,11 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
     }
 }
 
+bool translator_is_same_page(const DisasContextBase *db, vaddr addr)
+{
+    return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
@@ -112,7 +117,7 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
     }
 
     /* Check for the dest on the same page as the start of the TB.  */
-    return ((db->pc_first ^ dest) & TARGET_PAGE_MASK) == 0;
+    return translator_is_same_page(db, dest);
 }
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d729e68c98..42fe5d285e4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1511,7 +1511,7 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
 
     /* This is a subsequent insn that crosses a page boundary.  */
     if (s->base.num_insns > 1 &&
-        !is_same_page(&s->base, s->pc + num_bytes - 1)) {
+        !translator_is_same_page(&s->base, s->pc + num_bytes - 1)) {
         siglongjmp(s->jmpbuf, 2);
     }
 
@@ -2225,7 +2225,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
          * no extra masking to apply (data16 branch in code32, see above),
          * then we have also proven that the addition does not wrap.
          */
-        if (!use_goto_tb || !is_same_page(&s->base, new_pc)) {
+        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
@@ -3762,7 +3762,7 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
              * chance to happen.
              */
             dc->base.is_jmp = DISAS_EOB_NEXT;
-        } else if (!is_same_page(&dc->base, dc->base.pc_next)) {
+        } else if (!translator_is_same_page(&dc->base, dc->base.pc_next)) {
             dc->base.is_jmp = DISAS_TOO_MANY;
         }
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bccaf8e89a6..cf48cca7132 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1304,7 +1304,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
@@ -1314,7 +1314,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
                     translator_lduw(env, &ctx->base, ctx->base.pc_next);
                 int len = insn_len(next_insn);
 
-                if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
+                if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
                     ctx->base.is_jmp = DISAS_TOO_MANY;
                 }
             }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bcfff40b255..8a3798f9dff 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6422,8 +6422,8 @@ static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     dc->base.is_jmp = translate_one(env, dc);
     if (dc->base.is_jmp == DISAS_NEXT) {
         if (dc->ex_value ||
-            !is_same_page(dcbase, dc->base.pc_next) ||
-            !is_same_page(dcbase, get_next_pc(env, dc, dc->base.pc_next))) {
+            !translator_is_same_page(dcbase, dc->base.pc_next) ||
+            !translator_is_same_page(dcbase, get_next_pc(env, dc, dc->base.pc_next))) {
             dc->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-- 
2.45.2


