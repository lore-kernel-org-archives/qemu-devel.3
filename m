Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA2CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swN-0004EK-Ss; Mon, 22 Sep 2025 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swK-0004Ds-O3
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swE-0003gx-JD
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b553412a19bso1637846a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595167; x=1759199967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtS+tUcTZk2GBqf6yxqhjiU0irGyIDNvqIFdhqaZrSY=;
 b=wwyDa6JkLfuLYwBHIc8zEiL39+DMOFgA8u6f9Y7p/++TqfwKw20od+LOsdtvKh/cOV
 gQp/eSIAGhu8Ssm3+TIwVRKs90Vm05o8Js58buuuAedvLy60LdysavT6l5+5wtTzSIXW
 HlsG4RWAh3hVBfZIYn7VgdnUB8c1xa0wOcwXx3ac0+CtYnzTtkiB2pTZUPIFPHwgrahR
 GOyRuohSFDzpvwGUJG0RQnpEza4L1VWiFIJBuU6ZfcYq9pKhZHoKycesSsBqd+oWGRGW
 OoEljtf4QotrMxOEzonSjKy1Xu4DwEyimbv0QrH2s5G+NoyIDZb+uIGkUPMgjPILc4eK
 u0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595167; x=1759199967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtS+tUcTZk2GBqf6yxqhjiU0irGyIDNvqIFdhqaZrSY=;
 b=PqZjBp/y+A+857FpjiyJYnP6T0zjnNFBVnGaT+0GAMeMvuO+hahNPnPcgIKWWDShHO
 KD8OGwaNCR/2xmeybiA2tASLeAh9nixlZxrWfP75kO0GoTC1t2siicGjRtF+FrW418bX
 vNoe44UsKp8Yozgoc3wL6KlyZ+YZSaxuP8WLFRpgHazMqCKlNo9+4n6I4VLzs8M98+1a
 XDgqVqz+l4UFhIgOa2xxlwxFVd2lNCBpxWQkN43yKbzByt1yz8ShdqbkYZv8GgbkjiWU
 2/puOfHqwboviohtXD9kcaB2QCiNqVDyo6uQ2FMvhQkoB5SeYz5m0JyW3Pg1LnzGM64K
 koyw==
X-Gm-Message-State: AOJu0YwBzq5ITgTldVpmlM8T3dTgN8QcaNywhaIQKkShexm0iptMuXtk
 Et/OaTUGvCJl/bW8PDEcBxzkB0lS1XB9hvy4NlId6GHTH0gPaUiaEjnASWRpsX767WA775YQy3n
 FtfYS
X-Gm-Gg: ASbGncsfctYEk+wgVUVu0rUroYfDEjwIPl1kd6sQymFdBjzj1Ipg8Slhxm+ojT3rmbx
 sZ2nDkkLTThksxDWvH+jzoyJuGtxc+cAzJNR3+4VECDClanueJOTsbw04emNskksKLd1f3uEqWV
 UnmsG3kA7HUrXIR4k6oSmQOYuC/hH88wwgXPnxmIdHQzSPYh+qVA4qVQfEqLOP0qJVqO7TLw6iB
 sFtYE1I3ejPnb4M+IEXZ9ayHy/7VATxhel66Z1/8t+3jTn2MBVkzzwNIm01q2jx9gnWKKzAcamr
 ezubfyBXPQdSI+M+N3bmDxqbViRjacDiIRkslb7wpGUTXq7dTLfrc7iInmTeG9FaKcR7YdPxt9a
 dy8DYuUUTYfEK8fqu1SdKAfkOP/45
X-Google-Smtp-Source: AGHT+IFhdkBYZJ64ekLETcR0+kLRvIW8hmVQeZ3JUqgpSGj4LuHeM+ubYQVBCmKgaFBEgQRM79KwiQ==
X-Received: by 2002:a17:902:ef4c:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-27cc1197880mr10617925ad.4.1758595166932; 
 Mon, 22 Sep 2025 19:39:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 04/12] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
Date: Mon, 22 Sep 2025 19:39:08 -0700
Message-ID: <20250923023922.3102471-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org
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


