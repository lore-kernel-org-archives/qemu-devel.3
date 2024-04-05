Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A88CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgm4-0006Wf-PM; Fri, 05 Apr 2024 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglT-0006BF-AJ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:43 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglQ-0004pd-Hr
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:41 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-22ed72b0082so188991fac.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312739; x=1712917539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWAgZQ2Av7FDttaOMf2pMnb78RnsfEKN51tfHvsHtMU=;
 b=Jh96cOyaUYr9+888YUF9hEhiGr0hOwqr5XxYvDfBzFoqTu2NFM4EPmgxXS2WUOadIJ
 MHDW6n+6G0G9gCoRDr/x20XaoSlhk9uJYUili1gidNl2wIAl68M4CXTOaLak4S9WDwCd
 QX/B+GkS4UP2fLd/6ilqc+LWDYcYXA0Zx7Nu02/A+nMsbtpkL/jTTRLaLZM5cVdPZ6NI
 Tk2dGXvSgYFeiRMUFf/ur2SHQJ0Uj36fld/gqbQyqx+CheYKKXhli0NP1f3tsNwMjWes
 fYLhLCfql1+ESW9co331Ojz5g2lnAnWXLSCg+yFn+5tnKMNe7wYgc1n7EQr6lF1mB/kn
 H7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312739; x=1712917539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWAgZQ2Av7FDttaOMf2pMnb78RnsfEKN51tfHvsHtMU=;
 b=KtLG4gVDpfE8pLzMUYkmPa2r392wqxsgIoqHStyKgQhgdre8vNeYb8U2WxtJ214N1Y
 wlg21SGNuhfqJOdH55mu/mIPujNrFt/Py/7HCdukljTywK+GnVt4wcWf2QpuKv0MtFub
 iS1p2dbwQOvHvVzsSE+4NxDlQBO3/+EF6pCjd43krJ4fbDxoGIOV5UV+F1dJywiurxsF
 qZzeV0hhcP+vXydwxxHvap50xBSph29krZ15y2EW/DR3uADfYswuZkZLAix9l8gpMWDZ
 P8wlJYS7ey6/a4uicrWz+ApZntDqC2Aj+H4MDUqShJO0yVCREoZBGcfqX4hy0fou40+V
 sKjw==
X-Gm-Message-State: AOJu0YzeCEjRjIYcFAM1461PUFwsnok/GwiYWvv/xwkCbw7Vik8vV1h+
 sPcl1tguR0XIgFsDi0l5oFc3XMlKa9ElYV9lbKj6yPhxXureHL0R+17FWcRoLy4bgevfiRkySDY
 s
X-Google-Smtp-Source: AGHT+IHUAFbH6VpBDfp2Ue+oCb8Ce0tSInbYio+bUwGm0jHxI4y6d9QMLdi9CxUmMrcESquTdxyiWw==
X-Received: by 2002:a05:6870:5b07:b0:221:8a03:6de7 with SMTP id
 ds7-20020a0568705b0700b002218a036de7mr937273oab.32.1712312739483; 
 Fri, 05 Apr 2024 03:25:39 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 29/32] target/riscv: Use translator_ld* for everything
Date: Fri,  5 Apr 2024 00:24:56 -1000
Message-Id: <20240405102459.462551-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Cc: qemu-riscv@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9fd1ac1d60..9a4a68b955 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -1083,7 +1082,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return cpu_ldl_code(env, pc);
+    return translator_ldl(env, &ctx->base, pc);
 }
 
 /* Include insn module translation function */
@@ -1244,7 +1243,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
 
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
-                uint16_t next_insn = cpu_lduw_code(env, ctx->base.pc_next);
+                uint16_t next_insn =
+                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
                 int len = insn_len(next_insn);
 
                 if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.34.1


