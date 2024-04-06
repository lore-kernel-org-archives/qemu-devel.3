Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F9AC67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEb3-0003Pp-R9; Sat, 06 Apr 2024 18:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEb0-0003PO-Cb
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEay-0006mR-0U
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecf406551aso2317933b3a.2
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442787; x=1713047587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCcliQok5xWZ0STL9q8OCOy2kMXMLfgS8Bx/eIbiktU=;
 b=yW315/ndvN1TQiyQFXoffBOE6QtOh6i8LXzq55Ghum6MBqbyAkSzO/cV9nrJ0AQ+Ao
 hnEbRzsAOMjRO/muwdgRYJf2ZvqPxYmFC0b31P0mxoI+uJcbi7PQazVE+N/qPSeL8vZl
 j18+fjvdsry+5kwEyetiSdfDLcxmVRKptwC+MJcc42bkPVhMamETZu0CHJ+pWbF/lRal
 b+TjvzQLfN43OETYRTTCL9ay8/m4FwBOwF1x5eKNToZJNLx8LhC2BLkb5QbyV4jBni/5
 6c39lZ8jzpRYaTStvrKZMSJa+WpAqlKjQpwLP2UMXOMvCqvat+dmJQN6oM2gcEO0pawA
 IBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442787; x=1713047587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCcliQok5xWZ0STL9q8OCOy2kMXMLfgS8Bx/eIbiktU=;
 b=ZCewJefSvejz9ri7LydgyBwkcX2oWuyW88h0bPAI63JKCfzY3AzBM8vmo0ALDOWtvs
 gEbT+tlRlmR+0A1cbXe55qOLy7kaQ9uvZbVjnf6t7XgneDDKmefC1CQJIVStHCe3sIVe
 Ecwwyy1JHPdlk7YCikWxP6GNlBjNlSg06ifibDHNIQhSr1nRkDfv5WgfPNR6d/7ExOGR
 yCmeNWB4rSqFX/xQar9SRJ975IHF7inWazqicg0SpdtlkkSo92pWhZxXCN+J5OfItM9Q
 NRivpTRQG6ei+eZM0I/2PJO0Sx66Rd7lc90AqLRVqK8G/wnhI1xgIMHFZhQmj2a+WTn4
 dzow==
X-Gm-Message-State: AOJu0YzOvqM+mGEYvwJ8/QzNM9ch97IX6I7O+D2Y8gsiAQRubqZYlG/p
 9tMQjpXZqT/rFD3Mwl/L+JbiB7xVep008H4IQQcHCk/lJhSgveJuMZIMTELFKv0Jo8wVpDiJ2oo
 8
X-Google-Smtp-Source: AGHT+IE3AVR0/+mC7iIHHm48lOL1fFr3ZCxMScSe1UR5cKptDMhugGenVanhfxi8QfNUctRI3pzpeQ==
X-Received: by 2002:a05:6a20:158c:b0:1a7:1c26:f9ac with SMTP id
 h12-20020a056a20158c00b001a71c26f9acmr6020296pzj.62.1712442786698; 
 Sat, 06 Apr 2024 15:33:06 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:33:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 9/9] accel/tcg: Improve can_do_io management
Date: Sat,  6 Apr 2024 12:32:48 -1000
Message-Id: <20240406223248.502699-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

We already attempted to set and clear can_do_io before the first
and last insns, but only used the initial value of max_insns and
the call to translator_io_start to find those insns.

Now that we track insn_start in DisasContextBase, and now that
we have emit_before_op, we can wait until we have finished
translation to identify the true first and last insns and emit
the sets of can_do_io at that time.

This fixes case of a translation block which crossed a page boundary,
and for which the second page turned out to be mmio.  In this case we
truncate the block, and the previous logic for can_do_io could leave
a block with a single insn with can_do_io set to false, which would
fail an assertion in cpu_io_recompile.

Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  1 -
 accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index ceaeca8c91..2c4fb818e7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -87,7 +87,6 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
-    int8_t saved_can_do_io;
     bool plugin_enabled;
     struct TCGOp *insn_start;
     void *host_addr[2];
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ae61c154c2..9de0bc34c8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,20 +18,14 @@
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    if (db->saved_can_do_io != val) {
-        db->saved_can_do_io = val;
-
-        QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
-        tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
-                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                        offsetof(ArchCPU, env));
-    }
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
+    tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
+                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
+                    offsetof(ArchCPU, env));
 }
 
 bool translator_io_start(DisasContextBase *db)
 {
-    set_can_do_io(db, true);
-
     /*
      * Ensure that this instruction will be the last in the TB.
      * The target may override this to something more forceful.
@@ -84,13 +78,6 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
                          - offsetof(ArchCPU, env));
     }
 
-    /*
-     * cpu->neg.can_do_io is set automatically here at the beginning of
-     * each translation block.  The cost is minimal, plus it would be
-     * very easy to forget doing it in the translator.
-     */
-    set_can_do_io(db, db->max_insns == 1);
-
     return icount_start_insn;
 }
 
@@ -129,6 +116,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
+    TCGOp *first_insn_start = NULL;
     bool plugin_enabled;
 
     /* Initialize DisasContext */
@@ -139,7 +127,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
-    db->saved_can_do_io = -1;
     db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
@@ -159,6 +146,9 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
         db->insn_start = tcg_last_op();
+        if (first_insn_start == NULL) {
+            first_insn_start = db->insn_start;
+        }
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
@@ -171,10 +161,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
          * done next -- either exiting this loop or locate the start of
          * the next instruction.
          */
-        if (db->num_insns == db->max_insns) {
-            /* Accept I/O on the last instruction.  */
-            set_can_do_io(db, true);
-        }
         ops->translate_insn(db, cpu);
 
         /*
@@ -207,6 +193,21 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
+    /*
+     * Manage can_do_io for the translation block: set to false before
+     * the first insn and set to true before the last insn.
+     */
+    if (db->num_insns == 1) {
+        tcg_debug_assert(first_insn_start == db->insn_start);
+    } else {
+        tcg_debug_assert(first_insn_start != db->insn_start);
+        tcg_ctx->emit_before_op = first_insn_start;
+        set_can_do_io(db, false);
+    }
+    tcg_ctx->emit_before_op = db->insn_start;
+    set_can_do_io(db, true);
+    tcg_ctx->emit_before_op = NULL;
+
     if (plugin_enabled) {
         plugin_gen_tb_end(cpu, db->num_insns);
     }
-- 
2.34.1


