Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06685C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbne1-00077A-1c; Wed, 07 Aug 2024 16:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbndz-00073b-9P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:52:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbndw-0001Yq-UJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:52:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7105043330aso305832b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723063943; x=1723668743;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gSqkRbit/j9P+h3aGPtYaf0X2shdRu5dfqJeBm51978=;
 b=dCJyaa85icup5pRKwxqpHp5V1EVs6B0H217enDyR3P0efR5R4GnwSGC67zJhA9Jro+
 bxZT2wA5m3UYqpdkgO+HdgHd4Z5JG8rGkpXENObgLhrq/qV/waOfW0E671zBxTDdiZta
 GbbEu1pXCsZYkaieKtRPOjAvvAnKMMaPA791norQKBfcwnELKdaRlLVWIgAoupFlT6C4
 QmKKSq6r0eDrQY7WcvvPJUrKNABWXUts0mat878L+S3118RZpaJgAMFIoFD11W2dv7k9
 /B0X58cfOWsqYMMuuqa/ZpUXtOP3a9fbwqcqamC+ZBKNBqCg98QrNQ6Fmqt/ioLCQrJx
 5BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063943; x=1723668743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSqkRbit/j9P+h3aGPtYaf0X2shdRu5dfqJeBm51978=;
 b=Wg5UPVh4fwa1m4FM2Gl3kInnmLy+1+/aPiAYDtbakNsTuUTXAioSE2047/bosBQANX
 z+m+PUYx08/WlW1OulOnskNst6jkS+QCx5KWxCGMeSLjL4tdxGnTACQx7M+wegeRWIma
 qX0kHdxB1ojF0U631xuCS0O4B27xF4LcxK/GRWH92Vem1uNhRTQHSpEMusOLWyYBaYCH
 F3ym1PZyLq7s6iGIga/O+MfuSICtgtQEEEwrv4zSG1CeI9O5X/h7fk6uXuUlX0VZd9j0
 2zTpk44cJaDq9pcMIPGgQkXt+XmmGfD/FHsxXfc7C0QfRAEho4nPR/VT+J1wvFSSiPZ+
 SDfA==
X-Gm-Message-State: AOJu0Yxo+1SQtfw8VRAgzfalF0So6L3pBECiWV5fMg3tdGoZNSTv/PKo
 LwJEew269HBGAii1xFwao/KoHxMej04cS/h1FuvHHjvE5NrVGe9pl6vZ6q4acdfpBtQc58CoycO
 Y
X-Google-Smtp-Source: AGHT+IGGY9engU+yqm23B1Gp2NHnIDHwaI1i2NUfwjDQO43dOtcnF3GYOa5iD2ppNXN5musl5n3DUg==
X-Received: by 2002:a05:6a00:10d5:b0:70d:181f:c082 with SMTP id
 d2e1a72fcca58-7106cfcefffmr20955515b3a.11.1723063943059; 
 Wed, 07 Aug 2024 13:52:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b764fba580sm8801236a12.70.2024.08.07.13.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:52:22 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:52:20 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>
Subject: Re: [PATCH v3 18/20] target/riscv: add trace-hooks for each case of
 sw-check exception
Message-ID: <ZrPehKiBFUx4S+UF@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-19-debug@rivosinc.com>
 <a8105f82-9324-478b-960b-b387c261999f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8105f82-9324-478b-960b-b387c261999f@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 01:27:22PM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>Violations to control flow rules setup by zicfilp and zicfiss lead to
>>software check exceptions. To debug and fix such sw check issues in guest
>>, add trace-hooks for each case.
>>
>>Signed-off-by: Jim Shu <jim.shu@sifive.com>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++--
>>  target/riscv/op_helper.c                | 24 ++++++++++++++++++++++++
>>  target/riscv/trace-events               |  6 ++++++
>>  target/riscv/translate.c                |  2 +-
>>  4 files changed, 35 insertions(+), 3 deletions(-)
>>
>>diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
>>index cbd7d5c395..0f5d5def60 100644
>>--- a/target/riscv/insn_trans/trans_rvi.c.inc
>>+++ b/target/riscv/insn_trans/trans_rvi.c.inc
>>@@ -65,7 +65,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>>               */
>>              gen_helper_raise_sw_check_excep(tcg_env,
>>                  tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>>-                tcg_constant_tl(MISALIGNED_LPAD), tcg_constant_tl(0));
>>+                tcg_constant_tl(MISALIGNED_LPAD),
>>+                tcg_constant_tl(ctx->base.pc_next));
>>              return true;
>>          }
>>      }
>>@@ -81,7 +82,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>>          tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm_cfi20, skip);
>>          gen_helper_raise_sw_check_excep(tcg_env,
>>              tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>>-            tcg_constant_tl(LABEL_MISMATCH_LPAD), tcg_constant_tl(0));
>>+            tcg_constant_tl(LABEL_MISMATCH_LPAD),
>>+            tcg_constant_tl(a->imm_cfi20));
>>          gen_set_label(skip);
>>      }
>>diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>index 3b47fb34ea..07990e6589 100644
>>--- a/target/riscv/op_helper.c
>>+++ b/target/riscv/op_helper.c
>>@@ -24,6 +24,7 @@
>>  #include "exec/exec-all.h"
>>  #include "exec/cpu_ldst.h"
>>  #include "exec/helper-proto.h"
>>+#include "trace.h"
>>  /* Exceptions processing helpers */
>>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>>@@ -262,6 +263,29 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>>  void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code,
>>                                   target_ulong arg1, target_ulong arg2)
>>  {
>>+    switch (swcheck_code) {
>>+    case RISCV_EXCP_SW_CHECK_FCFI_TVAL:
>>+        switch (arg1) {
>>+        case MISSING_LPAD:
>>+            trace_zicfilp_missing_lpad_instr(arg2);
>>+            break;
>>+        case MISALIGNED_LPAD:
>>+            trace_zicfilp_unaligned_lpad_instr(arg2);
>>+            break;
>>+        case LABEL_MISMATCH_LPAD:
>>+            trace_zicfilp_lpad_reg_mismatch(arg2);
>>+            break;
>>+        }
>>+        break;
>>+    case RISCV_EXCP_SW_CHECK_BCFI_TVAL:
>>+        trace_zicfiss_sspopchk_reg_mismatch(arg1, arg2);
>>+        break;
>>+    default:
>>+        /* any other value of swcheck_code is asserted */
>>+        assert(swcheck_code || (swcheck_code == 0));
>>+        break;
>>+    }
>
>I think this is a mistake.
>Better to have 4 different helpers and eliminate MISSING_LPAD, etc entirely.

Honestly for raising sw check exception, helper is not needed.

I added a helper for raising sw check exception, because needed to add trace
capability on violations. Helps locate issues in cfi compiled binaries faster.

If you prefer 4 different helpers for 4 different trace needs, I will do that.

>
>>@@ -1302,7 +1302,7 @@ static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>>          tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
>>          gen_helper_raise_sw_check_excep(tcg_env,
>>              tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>>-            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(0));
>>+            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(ctx->base.pc_first));
>
>You certainly don't need to pass pc_first, since if lp_expected is set 
>that is always env->pc in the helper.

noted.

>
>
>r~

