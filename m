Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885B2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTW-0007Gc-GU; Thu, 02 Oct 2025 23:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTU-0007Fq-04
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:52 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTH-0001Hg-3D
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3305c08d9f6so1180310a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462114; x=1760066914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6zq0GMjs1ON2RCWKkC6XVAySpkrfeoHejqWY2RmSfo=;
 b=m2+ZGKaKsfB9RMyPyIEHEEckaystRWufc5Mfzy3thyyJ/vyX9JxDcmtapxG8kTdLnp
 zXHr9crohdeDh+nMLC5bvFm6GXMbBgi0MFS1HPTLLrrqR3hi5PFFB2qd7DU9w1qK5/hm
 4Y7P42jdUtUH7BsRKxMEGWL9+hcFqwiWV5uwR4zjAqIaxk4LpI5Gdx05UVuhjnwolYgm
 x0JsogvQ5DtjtKPEoXG7XoVQM+03TfcJd9yxVgMU2rX6wwBe+2aKsy2tmcMh7vFiIuJ9
 MYlojmG/GJc1QwaivFAvWMvUjsFq4+pm6x83EE9WP0d6txwNmPPHG+ziyBq8dD0vbzKy
 uf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462114; x=1760066914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6zq0GMjs1ON2RCWKkC6XVAySpkrfeoHejqWY2RmSfo=;
 b=YMXxCB4sn/6Wf/MGqRYQeXMCm3bPVBDcK7boItRzGe3CuQ3WYuzr9r4rNTkl9MZ+tQ
 9i0EAgOoIZKeYnAzy527JfhLCQOysH+X6pDeD263DaqVWv5WYUHADjdt2aS/j/ayuwCp
 Sx64BUbEohOpogyl1p64M7XK0VR8naUkYBbdUXkEziB9lTTxML200WZGNpAnS8pZOFtF
 Dj9w5yrAkG6ErLlMc0lrT0jgZLNtrRV89NPcl4VvI7LH6YJ4SdLjXUuCSpEBKd+l5FRW
 aNGsYr8YyamOFSQhsZlR3Q+FBPPpaa9n8ZyHV+m1OysFDbFok/KWUYOmX1liBIgAKO1H
 BbIw==
X-Gm-Message-State: AOJu0YyDwM1+LY+cLKiq7q2VELMsOO7xC6BwtyoZELuCoNqJr7J/CaNw
 Gz6ehZOuC7Dk0v0CXp5DwFcNTPJ0ci/sCBiNmgJ40n6oryU9xXs9CdiVAgYerw==
X-Gm-Gg: ASbGncuwgSY1q4SslZjeOedC/Z56qpFMC+es4zQmQvxk5Wm8ksAAO49lypXg7uz4zCI
 +7ViBRqE4fDLTYnj1xDiDsSwCdUYT9Hts2uo00JJ9a6DGs1uCuwYeMkti/Eo89lzld0L8fiJFIb
 NQuoaZho0X0y9Qsp/glE0IylHnZqfgOKgpMcw85YegyFF1cYriAJXOHxytHbg1I5LN3RLsbInQv
 uWC2GhL2sNJIQ08+38gUFHFOiiOXh4+e3Mr2MSq8r+WuyvIXMZtNBTZMURJO5GINqr1x/IaQSkX
 7LhZKtYwHCgws1aFJ+UwP37Z6xJ1tvf75O5ATEnnqtupMUW9ogHIOmwXWwymbXSLWiPLSLCdoZS
 5ZBrFgKCLuIg4qIlcdT1KqWlRgNXvcT0/43hBHoth/cPvZJSa+6Yg+G/LPBLXL5pDBp0k3zgsNJ
 fWeKev6nIl9/3I4PbzAauyok305vdtYg5sGbsRb1/mYldqWYfDQOfy
X-Google-Smtp-Source: AGHT+IHeyCSK0s7d7nCvUL9RxbVMVgShhdV/doMRfYRqBJsBcFiLULqaANwbg4iwcdQxycjvPYI97Q==
X-Received: by 2002:a17:90b:17c6:b0:32b:7d35:a7e6 with SMTP id
 98e67ed59e1d1-339c2336746mr2043823a91.18.1759462114473; 
 Thu, 02 Oct 2025 20:28:34 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/26] target/riscv: do not use translator_ldl in opcode_at
Date: Fri,  3 Oct 2025 13:27:09 +1000
Message-ID: <20251003032718.1324734-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Isaev <vladimir.isaev@syntacore.com>

opcode_at is used only in semihosting checks to match opcodes with expected
pattern.

This is not a translator and if we got following assert if page is not in TLB:
qemu-system-riscv64: ../accel/tcg/translator.c:363: record_save: Assertion
`offset == db->record_start + db->record_len' failed.

Fixes: 1f9c4462334f ("target/riscv: Use translator_ld* for everything")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
[ Changes by AF:
 - Fixup header includes after rebase
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..6fc06c71f5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -24,6 +24,7 @@
 #include "exec/helper-gen.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
 #include "semihosting/semihost.h"
@@ -1166,7 +1167,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return translator_ldl(env, &ctx->base, pc);
+    return cpu_ldl_code(env, pc);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
-- 
2.51.0


