Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCEE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjS-0005ga-GM; Fri, 20 Dec 2024 11:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjB-00059Q-7Y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfj9-0008JC-Bs
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1272342f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711585; x=1735316385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zb712QFkXMyJHgZrNJU9p7a0+PEvQntNQaexSv2HpdI=;
 b=lRoe73xI8DHMozFx1aDv5Xa1/Q099ipHIb0EcdPK8yY4tUb7BcFuJHTDuujZEQOAo1
 f6ZTiDF5/2qXeqk9xvDACfrMO71VGVkRDoeeauVi+/b743xZ97MG2nPCdiXRTPU+ozPt
 A/CZfnb0sHVpd25Z1uIphWlh6mhx+SdZCHWx+2hCnENv7j8hy5+IRBO06/0VF0ie5Neo
 dHwYUnL5enRcMy4DwSFrobKOhc5g5sLGXRpRHmtYf75XuteMNNVJwdE2quZoO3rYq2hO
 FELX0ExQMKdO6S0WJ9LdnDPbg4/3pCfRgnL8nrruYM4LYo22caat21ySj129WwW/dgLH
 hBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711585; x=1735316385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zb712QFkXMyJHgZrNJU9p7a0+PEvQntNQaexSv2HpdI=;
 b=hkmODOG/PCfHPTi0+GnHC1AkW9wvG2cEmLmWUiYQpIKOGotziGAiJnkGFq62JyrwTh
 sAxxfTdTxdmxzJKU7KCr8dVKcXytfL6w7DPvt8GMhn4qLz0Q4NWZhvAmGjhdmHSWVPxV
 hXOeL+ArOwgC7OOt8AslqW0RLDIRN1Ylby4e3oluKeaTR1GztQW5ogJ6yvtm1i9+5DTi
 pfPl7Zy/iWDpyXFOP3ulTRImlEcR2E6KiuvO4HoaCwfUsz68hdGbKrmXe6AcDXJ8CswQ
 C8D1aNgv8KGHpW0gd8CXiMsah9De1AHxoZiUxzO8qRVQnTda9K7AvH+0tbfOmoocxYHx
 9wUQ==
X-Gm-Message-State: AOJu0YzBxfIGMILIoPzET7VECKmHjChjHWOxGPBFSsxtQTrCvDSOZuSd
 8rYg5mKMSFJRhQOYPv1TNgmG/CoeB/EskKEVbhMe1N00RuDAXlZhJY5BPbUSaElxi2YGudVbvil
 f
X-Gm-Gg: ASbGncttEJkKy8KgNtUGE8m1FcUR4cJH7wuzKV8cl+JSsjx4iLbzlGit/mkebZM3RVs
 /tW+abulICsvhd+YjuPP4MnbWpvhTzrrNS3191v2jAsy+ZwBSpyiFT30dbXy99X+4Lv4Hh+q4Pc
 MdIWdJutvZW3VHM8wrOkvtM+WjTuNYpijqJODi0tqEr/3dq/W7x8KMrNHAquIUhm3Z69bfk7XSG
 Y843E/W33tQL7skWNAlFUffUCj6S+OCi0uFTcr5jjQ+cIHc8xOCeVYf63rHTN9WQLYFms3HpK0=
X-Google-Smtp-Source: AGHT+IE8+2zwMUgwsM0oDS5BETlQG+MfVNhu19iXa6IvhASczAjr9OZeYXdKka+gKotCcHl2W+cQHA==
X-Received: by 2002:adf:8b11:0:b0:38a:2628:2e90 with SMTP id
 ffacd0b85a97d-38a26282ed0mr225996f8f.2.1734711585499; 
 Fri, 20 Dec 2024 08:19:45 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847214sm4381767f8f.46.2024.12.20.08.19.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 51/59] accel/tcg: Un-inline translator_is_same_page()
Date: Fri, 20 Dec 2024 17:15:42 +0100
Message-ID: <20241220161551.89317-52-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241218154145.71353-1-philmd@linaro.org>
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
index 57e83873934..903553dc88e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1512,7 +1512,7 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
 
     /* This is a subsequent insn that crosses a page boundary.  */
     if (s->base.num_insns > 1 &&
-        !is_same_page(&s->base, s->pc + num_bytes - 1)) {
+        !translator_is_same_page(&s->base, s->pc + num_bytes - 1)) {
         siglongjmp(s->jmpbuf, 2);
     }
 
@@ -2226,7 +2226,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
          * no extra masking to apply (data16 branch in code32, see above),
          * then we have also proven that the addition does not wrap.
          */
-        if (!use_goto_tb || !is_same_page(&s->base, new_pc)) {
+        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
@@ -3763,7 +3763,7 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
              * chance to happen.
              */
             dc->base.is_jmp = DISAS_EOB_NEXT;
-        } else if (!is_same_page(&dc->base, dc->base.pc_next)) {
+        } else if (!translator_is_same_page(&dc->base, dc->base.pc_next)) {
             dc->base.is_jmp = DISAS_TOO_MANY;
         }
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5fedde363f7..a76f67c5dd0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1305,7 +1305,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
@@ -1315,7 +1315,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
                     translator_lduw(env, &ctx->base, ctx->base.pc_next);
                 int len = insn_len(next_insn);
 
-                if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
+                if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
                     ctx->base.is_jmp = DISAS_TOO_MANY;
                 }
             }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e78815c4f7f..81554f2ad9d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6423,8 +6423,8 @@ static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
2.47.1


