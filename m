Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864ECC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3oq-0003WT-PQ; Wed, 05 Jun 2024 23:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3on-0003WD-Ky
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:37 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003m7-2l
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:37 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6c9d747be82so396814a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644569; x=1718249369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/fb1ARu1zeonQNViIIjN1QoMpopTu8brMfpyhARQ0A=;
 b=H+wr+UGC3MXne2UIad5yifJ75YBUhBBtOOgqOONHDGN0IJ77TKtl+3PybfGYDRnb1r
 hnT8lo4z5Md7yDq/pFN9Xc37DERcMC39HIFRvKBEYiA56252cR8HkjkK8LI/u8DEVf1j
 UzCjDNkPy98rCuSCXr5X5eVDWaKf1f0PX6tDb9mU/gTtz5eIIuFsE2N1x9pLUkgh2qMJ
 cSelIs28GJKdPvxRhTPdSkxwP02CIpQ3sxHaDwShtXVqboCpdcjdwgCLdz5UeoXpKZnN
 BdTs2ukWxJB0t/le5Ayh9qW4L0rWhYHrhRPIeML8LHr8DKnwT0FERkt6M/1yQA5ajUgB
 WszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644569; x=1718249369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/fb1ARu1zeonQNViIIjN1QoMpopTu8brMfpyhARQ0A=;
 b=uJeoTGj8qKfbh56htiyU5mq1Mp0V9LRIxoRPZMYipvxJeI15cvbbhEPXRU/CPJSVQq
 uBG391Oeq/NgbsRpUS/DHsbgIqsF9gjYw2aj/1Cb+KjogImS5l+fjcotB2bjjG3fByPd
 hXdcvxLtPU9LsC/YIwGgEXO/Yb7TN7Gx9wXvtCY1ThftlunO4hyRb/ckBqnTzz1mcZ0D
 hXTURdFvXAdTeI550FJAS17CNt4MF3R28/D1ZP5Tb33klSj2RPgQirjBX4PNzIjQZcRy
 CzO5w0HXyTbd7rw/MUsHcqZ7fplkZLs0FiR9CKDKJwf6YMYknECeTDlzbXH1L39CgxkN
 t4gw==
X-Gm-Message-State: AOJu0YxoHGyfYeiB1G3gFabEZojYvLerVQylL9UbsOTCujQgXa1gx7WN
 He3SXfqtjvuS0Nz0gAwdX4JemuC4RUELHIASmzMtBr3OAfLFLu/Li6uvtah8SIfOphv8DfgOy+Y
 J
X-Google-Smtp-Source: AGHT+IFE2gK9sVC0vmSyL6OjTFYtwAO1buhbd1rBuehc+tSB1mV0Y1IlpauDgaxX9mIwU8vfQ82Fsw==
X-Received: by 2002:a17:90a:f187:b0:2bd:ed7e:b712 with SMTP id
 98e67ed59e1d1-2c27daf9ad0mr5520501a91.9.1717644568841; 
 Wed, 05 Jun 2024 20:29:28 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 1/9] tcg: Introduce INDEX_op_plugin_pc
Date: Wed,  5 Jun 2024 20:29:18 -0700
Message-Id: <20240606032926.83599-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Add an opcode to find a code address within the current insn,
for later use with unwinding.  Generate the code generically
using tcg_reg_alloc_do_movi.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 include/tcg/tcg-opc.h       |  1 +
 tcg/tcg-op.c                |  5 +++++
 tcg/tcg.c                   | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 009e2778c5..a32c88a182 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,6 +76,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
+void tcg_gen_plugin_pc(TCGv_ptr);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 546eb49c11..087d1b82da 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,6 +199,7 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(plugin_pc, 1, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eff3728622..b8ca78cbe4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,6 +322,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
+void tcg_gen_plugin_pc(TCGv_ptr arg)
+{
+    tcg_gen_op1(INDEX_op_plugin_pc, tcgv_ptr_arg(arg));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 34e3056380..b7c28d92a6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4689,6 +4689,13 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_plugin_pc(TCGContext *s, const TCGOp *op)
+{
+    tcg_reg_alloc_do_movi(s, arg_temp(op->args[0]),
+                          (uintptr_t)tcg_splitwx_to_rx(s->code_ptr),
+                          op->life, output_pref(op, 0));
+}
+
 /*
  * Specialized code generation for INDEX_op_dup_vec.
  */
@@ -6196,6 +6203,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
+        case INDEX_op_plugin_pc:
+            tcg_reg_alloc_plugin_pc(s, op);
+            break;
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
-- 
2.34.1


