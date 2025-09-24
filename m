Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E909DCAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Uqm-0002wC-Uu; Wed, 24 Sep 2025 15:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmB-00070v-N1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkB-0007uR-9M
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3304a57d842so129072a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740485; x=1759345285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhvyGjhjUkCNEHZh1gnQZUsirw8YiHVeIFO9VlHtSAY=;
 b=ZHq/XuD3WWxnR6ABsumUMdILeKingyufwZt2140jjoph+C/s56dcf+EWujQWiW7HrT
 GZ0uzxJD4Q7SdJXIcoycji593KrT5jxJTnURNToRkXPyCcPhF0PzgzFFHDzrRunF+yvh
 KwxPMjY/lgM/RzvtflHUt4NSBYolZT8QYcabpgj10WzKDPNVzK+1V0cjxQq9RHrm4NLd
 dOJmWyTXLvRI6Me8lTOeXNy4wUWzIlB5ayU0fIvXsgXPmtXiogI4ioVklG0dP8vCcKTQ
 vK/x7Rz1YB9+senWkb56ICaFb2/yWIEEVBUNCxys2NmnspP55a4CK7t84Wru6mQD21WQ
 VEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740485; x=1759345285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhvyGjhjUkCNEHZh1gnQZUsirw8YiHVeIFO9VlHtSAY=;
 b=garDq0ktxN8xvs+dWfWQngbb8PHHvBHC4qrlcsxbjiiJnMgBhnTFbJDIgMsPuDltnO
 zXMtuZJKxnk0hWTJWnXE67zXC5Oduz+2uOLser5pnG4LxhGJ4wlZX01FTnAW8fNoB4Wt
 Ln3a3sehe8Vw/yajBlwY8USTUQwmSPjqrqlM0ePdQNB2oYw721GRKn8HX563Do1wf7HJ
 515Pnx6z9PqcTvm5PjiA6MlA92HDCO/cku7xIma2W3jDcRSOzwlqUbladKpdzGmmG04F
 TZi9kxmKctOC49US9lCmq43FUwN0lnzOJ2aWd6IRHSSoNUF0TX5yYnskb5Br8TDErJOw
 oGQw==
X-Gm-Message-State: AOJu0YzBdXosjH/2Q+gfUgPZtOvKN8Ta5NWdFnl0gkY58VYYCVUPK6Mp
 2Wm0y0q7RupIaOdxYqU+q/oypyBjWKXMgF1xrMIl7WAY1ApjO+klVn1ypJy3NRe3TRiil2Bnnmi
 e2Ob/
X-Gm-Gg: ASbGncsjySJA41f3fgsW9apPTK5v/UkqB/OMlk7OgGogwasD1uzs8AJuHojXnTyoci+
 qy3s5Ad+l+6iTp474gxfAEHC6gvzxpIz5mAI9K1uQkLHM4hcqc4DKepKYtWz+wRFH8lj3QlAlY3
 NDBADDIvA+pxMP6Vhv2YKGAPTzx5IwAQNJliT57YNokCaRDZCBweYAnH8EMaw2ALNhSg+b48fiQ
 sp9YaMOiRab6erWx0h89V5h0UOwc0AHFVV1/yFfMP53KNoXY/yeLyAG5savcpGn1KKOD5GJM3Z+
 prC9pKnCVc18sO5CFgPnzKD6lcqkeFBc1q/1V+bA5BKFJ1yGEojXm3r20cwRieSn0/YSVPzyDI0
 NVoG/Ob2hiwmqcGytCfd+ao/Yo2Iy
X-Google-Smtp-Source: AGHT+IEcz36kYNF6iolo9Zk5zAr0PB+ICTYJJpytomdFKyVytRF0RvmWxyVXxWCTEjCliVIYYKzYxA==
X-Received: by 2002:a17:90a:d886:b0:32f:469:954c with SMTP id
 98e67ed59e1d1-3342a2f9276mr637787a91.34.1758740484847; 
 Wed, 24 Sep 2025 12:01:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/32] target/riscv: Record misa_ext in TCGTBCPUState.cs_base
Date: Wed, 24 Sep 2025 12:00:56 -0700
Message-ID: <20250924190106.7089-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

The tb_flush within write_misa was incorrect.  It assumed
that we could adjust the ISA of the current processor and
discard all TB and all would be well.  But MISA is per vcpu,
so globally flushing TB does not mean that the TB matches
the MISA of any given vcpu.

By recording misa in the tb state, we ensure that the code
generated matches the vcpu.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c         | 3 ---
 target/riscv/tcg/tcg-cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8842e07a73..3c8989f522 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -25,7 +25,6 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "exec/cputlb.h"
-#include "exec/tb-flush.h"
 #include "exec/icount.h"
 #include "accel/tcg/getpc.h"
 #include "qemu/guest-random.h"
@@ -2173,8 +2172,6 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
         env->mstatus &= ~MSTATUS_FS;
     }
 
-    /* flush translation cache */
-    tb_flush(env_cpu(env));
     env->xl = riscv_cpu_mxl(env);
     return RISCV_EXCP_NONE;
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..143ab079d4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -191,7 +191,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
-        .flags = flags
+        .flags = flags,
+        .cs_base = env->misa_ext,
     };
 }
 
-- 
2.43.0


