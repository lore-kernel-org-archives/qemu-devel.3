Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083F1C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TgV-0008Di-Lp; Wed, 23 Sep 2026 16:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg3-00089P-31
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg1-0004zD-8T
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:50 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so778375b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195686; x=1790800486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r/EOfq5GSU111ySEUtewdGy4DqHR5fHEKzlTJljRbrI=;
 b=XWGmYP2zysV1KW1yqoMg9QUx40nT86G4XOZQlJUj6TeShoaXX5gSsg6hkBiryUSis0
 cykSJAxCseYAocmI/Olo42/i0UU1spU4CV+IgF3hRMcVBeL+QF/25sFvqZMRA5Zk0B2V
 chf6rALWY5KByM7EOHvzDOJ9t+b2gkkFkXogP6Qo2N5baaAiTd1zBfY5uRROddaSjPt0
 xpLqGWxyC0b4xPbwwbhqxzzKdH6EqQgeoZaUr22RmPNbZNd5QkFJ8gJKU97MhvRpTxoX
 V+h5lHtu2/MDNIOf/duNUdG5K7FaCLTRFLKEifiies3lNplEBq1Lsj2ViqHkpcwW4JBX
 ZDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195686; x=1790800486;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r/EOfq5GSU111ySEUtewdGy4DqHR5fHEKzlTJljRbrI=;
 b=HJ99gB49J9wc6ifVrCFMjRzNB72uXXcTwdY4rBD7PgRxOKCz/7rxyzne+T3Du1x6QT
 Wx3yrmt+LEwn4Y+7r5Ji3wyd6OIoELz7Yb2x7PfvyQRhfdFqG570OvjF2/KzGHCbMLtP
 pzbOjj/EVoy5wxaIM9ErMqo41E4t6fJ0lr1A2WYzg19W1oCwX55UeF+BZB1HyI+MJXzL
 455Bc+LzONMBpfqP7DCvaiiBt/zZdb+YrsEDdFXFcDZkineVb4vAFYi6jk2cEsJg3SqD
 jZ66xsu77zfkThZyhEoY3HJeBa/AEHyOV6QIklQ/m8tT+YODyjxiMBM4RWUO99Dne5lG
 QPyw==
X-Gm-Message-State: AFuF++mAjWzvWrkCy1X2hdZpF18ZvtnmYnoOTF2T2NGNOPayJSYqSNPP
 x1ezdYgO4O6fURRekB1plUnqjWUk6wglkVBATgu2g7H7gIUed5JO9G8QW0SFYcYWQgp7htFk48t
 +lGRi
X-Gm-Gg: AYBFou2qdTE9W2qHIkSkdOIeVF6ZbmI6BFZwpZVwOf4oCBdv8Z9FBiUfTngMhH5Qtsv
 WByWPPn4kZbzkv2uydRNDlc7GkBO+dV6kDhLzKHpYp8pQ1qmXwL9Ak9k4CS22QoJbcbHISNtKXD
 yZWFEI5f2GgMBUTqRjek3Wp6DosbUby8LFjz0w73F630F//vpYi1sutHpEpHWYCrjy3yH+nwGFx
 hebqKQ28y98JJRoUgxbc29TM7mh7uQrCT6/ABXSPxkF66ujhzgjQk/O1Gj9YHB75CIyTTzBkR8/
 dVoFJw9VGFyzXamduQWEO/QBCe4zIBR4A4c1CzNn5Q1V7y9SgGnUERU3MtI3A5wcq4oFhck9rxF
 adir7SxdpnxoH7pgn595qu3m281wINrHTdSBbSQybxQLafKPYhVBDcU4LXKqBw0Mb2RYpaUVmMK
 n0PqUxsBqnZDHxxrN1+94hpKRAF8pPKn7J06UAFyAJ324Tl4kYkAtXOYRS250l6/Y7/khh0csN3
 X3C4ahBWSZrO1Mh8/MbZ3nkFjj518M=
X-Received: by 2002:a05:6a00:2387:b0:874:705d:f63f with SMTP id
 d2e1a72fcca58-87e9b8970b1mr236172b3a.33.1790195686290; 
 Wed, 23 Sep 2026 13:34:46 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 03/16] accel/tcg: Skip the can_do_io stores in user-only builds
Date: Wed, 23 Sep 2026 13:34:28 -0700
Message-ID: <20260923203441.31276-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

From: Matt Turner <mattst88@gmail.com>

Every translation block stores to cpu->neg.can_do_io twice: false before
the first instruction, true before the last one. Nothing reads it in a
user-only build. There is no memory-mapped I/O in linux-user, and every
reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
tcg-accel-ops-icount.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-4-mattst88@gmail.com>
---
 accel/tcg/translator.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 57daded60ff..e9943006947 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -21,12 +21,14 @@
 #include "disas/disas.h"
 #include "tb-internal.h"
 
+#ifndef CONFIG_USER_ONLY
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
     QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
     tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
                     offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
 }
+#endif
 
 bool translator_io_start(DisasContextBase *db)
 {
@@ -125,8 +127,10 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
-    TCGOp *first_insn_start = NULL;
     bool plugin_enabled;
+#ifndef CONFIG_USER_ONLY
+    TCGOp *first_insn_start = NULL;
+#endif
 
     tcg_ctx->addr_type = addr_type;
 
@@ -160,9 +164,11 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
         db->insn_start = tcg_last_op();
+#ifndef CONFIG_USER_ONLY
         if (first_insn_start == NULL) {
             first_insn_start = db->insn_start;
         }
+#endif
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
@@ -207,9 +213,14 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
+#ifndef CONFIG_USER_ONLY
     /*
      * Manage can_do_io for the translation block: set to false before
      * the first insn and set to true before the last insn.
+     *
+     * Nothing reads can_do_io in user-only builds.  There is no MMIO
+     * there, and every reader (cputlb.c, watchpoint.c, icount) is in
+     * system_ss, so skip the two stores per TB entirely.
      */
     if (db->num_insns == 1) {
         tcg_debug_assert(first_insn_start == db->insn_start);
@@ -221,6 +232,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_ctx->emit_before_op = db->insn_start;
     set_can_do_io(db, true);
     tcg_ctx->emit_before_op = NULL;
+#endif
 
     /* May be used by disas_log or plugin callbacks. */
     tb->size = db->pc_next - db->pc_first;
-- 
2.53.0


