Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ED2C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydm-0001nq-2o; Wed, 05 Jun 2024 17:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydk-0001lj-2i
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydi-0003rs-C8
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70259bdcf7cso261741b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624669; x=1718229469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIX7XK6plrFAu/60k76Lx8FovOSuygKS6nD5tM+w8JA=;
 b=U8yR0Adygoz+2OMobodqDy5ytuqB2BGur3yRNwmQgXIRi714uroQmLQFN7gdKxDRsv
 MJuJmWgPQdB9Zb12nJGS35ie2tn6GW6qzeZSVv8BlLMDr+5JGDGjrPo7bDG7MJhD0yJM
 WGf7V/OW9kDWZWcaBhqZRCTEByI1CCVNmqLos62i9b8P+eCQx2oXlBqIOxOKjyv3XeZ1
 ZsVe4pgxbVPU6r2yGZv1WoX1Am3S8dSzdClPRdJmSO3r/NFB40cfdDSiOVoDvmSp52UJ
 bLzilRFux2KV739TCRsc0JJBuiuXXVgLPAHGEpBbmZCo0q0v1ZSGCFVBGiAwyiNyd7vM
 5sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624669; x=1718229469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIX7XK6plrFAu/60k76Lx8FovOSuygKS6nD5tM+w8JA=;
 b=DjUiS9BsvsXw2423gtV2sftvtdmeSkGqY9vE4wvTAGiLbBTZgMwwkLcN9JfZN1ZVs5
 4Zv46yOw9hShmHNENMVcdPXFMNnDyzTMQemoSUBKIYW/E79wSf+SIeJGqvruzjueoIIK
 Un8C34J7Fjy0gCmEnR0kjQ0Wrp35oPOOkmrc0HA5JtKOdpAnpxrElkqyRKn8i7OzKjvi
 k8kVq8NAvIzA14SJ06EDlWwmVsuZ6XUP4byh0JXdWH59zif2Ujxi+i70+8NCjb58dVdK
 /PpOOe1BhdyPjMHzDV1XDs+iLZ09C0mS0a+8NmX1oB+v3nKB2sc0T8DrtWBh4VlTLGdG
 vF5A==
X-Gm-Message-State: AOJu0Yyp2a+JNY6neOVvUNLPiJbcdO+fKQCd/gZb+Jb5fqL5+ft7edez
 dtuLACo+XckZ0UIbQ33ODO7wlypcAR71GnYA1pD60jpjY9ZkxnqgOVsAqlDYPEUHqqYPnRRh8Z+
 o
X-Google-Smtp-Source: AGHT+IFDKqvo633jd2Otu+yNCu3Fhy2DmRQ9ZPRKHsdH+ANd/eZ6QKU8dKsfU7o8EywQZA16m99mIA==
X-Received: by 2002:a05:6a00:1146:b0:6f3:ea67:48c3 with SMTP id
 d2e1a72fcca58-703e56d308amr4297696b3a.0.1717624668814; 
 Wed, 05 Jun 2024 14:57:48 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 08/10] target/s390x: Use ilen instead in branches
Date: Wed,  5 Jun 2024 14:57:37 -0700
Message-Id: <20240605215739.4758-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Remove the remaining uses of pc_tmp, and remove the variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bce9a0aeb0..3014cbea4f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -141,12 +141,6 @@ struct DisasContext {
     const DisasInsn *insn;
     DisasFields fields;
     uint64_t ex_value;
-    /*
-     * During translate_one(), pc_tmp is used to determine the instruction
-     * to be executed after base.pc_next - e.g. next sequential instruction
-     * or a branch target.
-     */
-    uint64_t pc_tmp;
     uint32_t ilen;
     enum cc_op cc_op;
     bool exit_to_mainloop;
@@ -344,11 +338,6 @@ static void store_freg32_i64(int reg, TCGv_i64 v)
     tcg_gen_st32_i64(v, tcg_env, freg32_offset(reg));
 }
 
-static void update_psw_addr(DisasContext *s)
-{
-    gen_psw_addr_disp(s, psw_addr, 0);
-}
-
 static void per_branch(DisasContext *s, TCGv_i64 dest)
 {
 #ifndef CONFIG_USER_ONLY
@@ -420,7 +409,7 @@ static void gen_program_exception(DisasContext *s, int code)
                    offsetof(CPUS390XState, int_pgm_ilen));
 
     /* update the psw */
-    update_psw_addr(s);
+    gen_psw_addr_disp(s, psw_addr, 0);
 
     /* Save off cc.  */
     update_cc_op(s);
@@ -1179,7 +1168,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
 
     /* Branch not taken.  */
     gen_psw_addr_disp(s, psw_addr, s->ilen);
-    if (use_goto_tb(s, s->pc_tmp)) {
+    if (use_goto_tb(s, s->base.pc_next + s->ilen)) {
         tcg_gen_goto_tb(1);
         tcg_gen_exit_tb(s->base.tb, 1);
         return DISAS_NORETURN;
@@ -2361,7 +2350,7 @@ static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    update_psw_addr(s);
+    gen_psw_addr_disp(s, psw_addr, 0);
     update_cc_op(s);
 
     if (r1 == 0) {
@@ -3085,7 +3074,7 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 
     /* In a parallel context, stop the world and single step.  */
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-        update_psw_addr(s);
+        gen_psw_addr_disp(s, psw_addr, 0);
         update_cc_op(s);
         gen_exception(EXCP_ATOMIC);
         return DISAS_NORETURN;
@@ -4379,7 +4368,7 @@ static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 
     if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
         update_cc_op(s);
-        update_psw_addr(s);
+        gen_psw_addr_disp(s, psw_addr, 0);
         gen_helper_per_store_real(tcg_env, tcg_constant_i32(s->ilen));
         return DISAS_NORETURN;
     }
@@ -4611,7 +4600,7 @@ static DisasJumpType op_svc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 t;
 
-    update_psw_addr(s);
+    gen_psw_addr_disp(s, psw_addr, 0);
     update_cc_op(s);
 
     t = tcg_constant_i32(get_field(s, i1) & 0xff);
@@ -6193,7 +6182,6 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
             g_assert_not_reached();
         }
     }
-    s->pc_tmp = s->base.pc_next + ilen;
     s->ilen = ilen;
 
     /* We can't actually determine the insn format until we've looked up
@@ -6413,7 +6401,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 out:
     /* Advance to the next instruction.  */
-    s->base.pc_next = s->pc_tmp;
+    s->base.pc_next += s->ilen;
     return ret;
 }
 
@@ -6475,7 +6463,7 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        update_psw_addr(dc);
+        gen_psw_addr_disp(dc, psw_addr, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
-- 
2.34.1


