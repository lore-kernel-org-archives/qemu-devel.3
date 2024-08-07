Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372CC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDr-00061c-AZ; Tue, 06 Aug 2024 20:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD4-00034D-U6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD2-0001E4-78
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so9813645ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989238; x=1723594038;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYHDnUNnbJTzV9a+g8+1jTXRfBSkNkA2a9DPEiZa4l8=;
 b=kyXR898oyKmmNq4vdJI+bXUTRW027BTwAL3pLVUnTh74J5Lmgdb1HqSDbp5/QfDP/A
 GJ35IGFOqqZWpEios+HrYWr5LXXxbdfbXmV7LlaX49bCw19a8Dr9xyzbyUhvDj5VZL6x
 npayRBfz2OmdevxnWQZYemMDNPaUrSkVXvR2huR80lN9tQlmwZP+CLVYwVskHeA5mZqr
 zjFgeTue64SZDyvHa1ZczXzwF5062n5KY3M8aOexHsY7+IfWiOPaip39FyJPcTnyIKZp
 Eoj8gA+sz70oV86YPHCG36xRzNUU7nyFaRYJFfFT8ivqaLlWFRRrut7iaqQ8sS/h95qs
 y35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989238; x=1723594038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYHDnUNnbJTzV9a+g8+1jTXRfBSkNkA2a9DPEiZa4l8=;
 b=FZ5yuiChVDxdc0WSdhUy/OXunkHhUV3QtKfD0CcMJEmuEfGq/CqCjk6Q25OhT8e3Kf
 TLjWhsLq0xYFiuZ+4L35PG0sQh8Anzd4V5GhNIadWaPx4BKPVuNlgHd/5gyW4gmX8ppv
 iNs0Zynd7exEiqmwA0m3UawfARdmyng65e1FYhFcUuY0ZSKnH+A37cofgMKMew8AiDzs
 sXnpFvsaegiIuVg8k6OsOAx9s5Yf1KFz/r9CZxLc0WAT1xfrH94/wskOOiUYPJFmY148
 Av5sjrWSzQUDepdcPngA0+aGv5U6pT/RVNodk7FsPd+uThD2ayUpJM9VOvysIuN8SwYO
 SdPQ==
X-Gm-Message-State: AOJu0YzC6RmlZt6UEWNfs7wD+MC63C78Qiv4En3HK+WdqEy1lKXnQa4l
 GIY72CFytrGWQ2Wj3gHJTI7UtUR/kw5GLSe9u3g7N71Lx5csh0pN21aAo3qQK+EjfmkVNR1Y2Z9
 6
X-Google-Smtp-Source: AGHT+IEqthdI+Eq3pPMKgMUi6SfFOl4/6mQZo8YG9y7QrUGeC16S6mO0IhSLCaJ9r2JU/vjrpWNAuA==
X-Received: by 2002:a17:902:e548:b0:1fe:d705:e963 with SMTP id
 d9443c01a7336-1ff574b71a3mr189017775ad.61.1722989238253; 
 Tue, 06 Aug 2024 17:07:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:17 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 18/20] target/riscv: add trace-hooks for each case of
 sw-check exception
Date: Tue,  6 Aug 2024 17:06:49 -0700
Message-ID: <20240807000652.1417776-19-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Violations to control flow rules setup by zicfilp and zicfiss lead to
software check exceptions. To debug and fix such sw check issues in guest
, add trace-hooks for each case.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++--
 target/riscv/op_helper.c                | 24 ++++++++++++++++++++++++
 target/riscv/trace-events               |  6 ++++++
 target/riscv/translate.c                |  2 +-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index cbd7d5c395..0f5d5def60 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -65,7 +65,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
              */
             gen_helper_raise_sw_check_excep(tcg_env,
                 tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                tcg_constant_tl(MISALIGNED_LPAD), tcg_constant_tl(0));
+                tcg_constant_tl(MISALIGNED_LPAD),
+                tcg_constant_tl(ctx->base.pc_next));
             return true;
         }
     }
@@ -81,7 +82,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm_cfi20, skip);
         gen_helper_raise_sw_check_excep(tcg_env,
             tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-            tcg_constant_tl(LABEL_MISMATCH_LPAD), tcg_constant_tl(0));
+            tcg_constant_tl(LABEL_MISMATCH_LPAD),
+            tcg_constant_tl(a->imm_cfi20));
         gen_set_label(skip);
     }
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3b47fb34ea..07990e6589 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "trace.h"
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
@@ -262,6 +263,29 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
 void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code,
                                  target_ulong arg1, target_ulong arg2)
 {
+    switch (swcheck_code) {
+    case RISCV_EXCP_SW_CHECK_FCFI_TVAL:
+        switch (arg1) {
+        case MISSING_LPAD:
+            trace_zicfilp_missing_lpad_instr(arg2);
+            break;
+        case MISALIGNED_LPAD:
+            trace_zicfilp_unaligned_lpad_instr(arg2);
+            break;
+        case LABEL_MISMATCH_LPAD:
+            trace_zicfilp_lpad_reg_mismatch(arg2);
+            break;
+        }
+        break;
+    case RISCV_EXCP_SW_CHECK_BCFI_TVAL:
+        trace_zicfiss_sspopchk_reg_mismatch(arg1, arg2);
+        break;
+    default:
+        /* any other value of swcheck_code is asserted */
+        assert(swcheck_code || (swcheck_code == 0));
+        break;
+    }
+
     env->sw_check_code = swcheck_code;
     riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
 }
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..0e8807f0d4 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -9,3 +9,9 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %"
 
 mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
 mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+
+# zicfiss/lp
+zicfiss_sspopchk_reg_mismatch(uint64_t ssra, uint64_t rs1) "shadow_stack_ra: 0x%" PRIx64 ", rs1: 0x%" PRIx64
+zicfilp_missing_lpad_instr(uint64_t pc_first) "pc_first: 0x%" PRIx64
+zicfilp_unaligned_lpad_instr(uint64_t pc_next) "pc_next: 0x%" PRIx64
+zicfilp_lpad_reg_mismatch(int lpad_label) "lpad_label: 0x%x"
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4772191bd8..9ef1f220e0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1302,7 +1302,7 @@ static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
         tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
         gen_helper_raise_sw_check_excep(tcg_env,
             tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(0));
+            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(ctx->base.pc_first));
         gen_set_label(l);
         /*
          * Despite the use of gen_exception_illegal(), the rest of
-- 
2.44.0


