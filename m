Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF5CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKE-0000Ny-5t; Sat, 06 Sep 2025 01:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK6-0000Kx-7g
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-0006oc-Ee
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so18287745e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135906; x=1757740706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLmbMbf+HJtfOJ60NWtJJU5a0jMYYcgPpAt4Vz1/6OI=;
 b=xhdskBiAOKzP2RSK4tZ6Rd9xhsiIcO6PwjnAm3P0XJQaFiotahuTdqWoGbNPDctp1a
 7O1FFJEahTuwQhH9raPX3WJef2AYrm9pYgvRAmRxRYGkLbxipWDKGtt5rEHiNiycSdV6
 ZUvYyaUcCusvW19RsabwbdkdRylAJBwx5g0HaXMYUHuPhQYwTPABly8ndLYb2BBuILHG
 6NDM2+1p4lz4SxzcelDPedJxviUmBM//IoYZH84JruLnu6O7gi/+YevDTsL7/RqYdfDF
 uDij7sLYMbijTpFKmNanEAEHMam8FPJ8mI3RS1Ky1Dxs6LNNWqD4xWLULokqhATDiCqG
 5Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135906; x=1757740706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLmbMbf+HJtfOJ60NWtJJU5a0jMYYcgPpAt4Vz1/6OI=;
 b=QDJsOZnqEq9NGASKCnDMQ3V6061cC+92I88TW++zGuQ7Ol+G1OYgyeh9tNFQRe3+Qr
 4ShBuaRRmwYAMt2pFobppihhVn/7PzIAMLdQWTFdwznX377UM4vFzkSelxvXR8symXMZ
 Fhu7Lfsead7FzKs699s/0Za/566iXfBwIVzBoGV0VdXl0Kydj3jvtLa09hsZCnMq5d6M
 24ZWUdethuAODVUDbNnQrrRNTXtwzREdUq05s3gllEksrlpERDivVz8Teg4D+1tb+xcG
 xKYsWtK+FrrIruwGEyFsoUtF9BfB2NQQOTi4aytv8frIvminfjDYKb0cOpp+jzqFdk0A
 vT+Q==
X-Gm-Message-State: AOJu0YxjRxpiLBnaiEXQJ3qkEVArnX8OQtjBH0/VFWJsyh5cOTVzPVoo
 1JNEZ6RHmf+wbyFi472n9qyhODl4EWtPCZDsLRoJRvI5BEgTdSOc/lNOpb+TV2br/r944SMhoO2
 lAetrkV4=
X-Gm-Gg: ASbGncuKrPM8seP0XEK5xjN15ut5f3kfBDF3wFi3ZzhBUk1QKpX2x/kHD3Dw2WR/iA8
 9QUjKDdgTCdJz2aBXUza4NAQJXtdxMi87oPFi8NX8RYe7UCz4bI/m6WPN5/dYjySmgi2z8SaYei
 OgRIEcTeTLFO60U8aKb9+XnKCvYDWs1DCOfH5Onyi9rVqjBJc0uZiBxWwXtw66E+KxFzNn3MOND
 lGALVpZuq6fCPl4aSq1OAclCmzNTlcrLbzR10ViNw9a8si4MxUBGp8ASo8fazo8bbTP3bPfrnTa
 9s9K+2oyhxVegIEatoGb0tAfwx7u8NTNp3tg8beZkqPbiB/DO4yVBqrvpHo4Zi6s5LSlIlLXGB0
 EJ0i34MMCFX3dYd9BfovoDyacI4MQ3HCCbS6wAM1r10fhhWC8YLduRiS7yUsv7P/kwUYXn1r1
X-Google-Smtp-Source: AGHT+IFSoU+hRjeRNMOJEJ0Faw9Fl/6ZcjIG+5rmIQy6fvKCLvhgeCcq6BmFxfutZ1IC9vRp4cLAQg==
X-Received: by 2002:a05:600c:3b1d:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-45ddde92816mr9450635e9.10.1757135905827; 
 Fri, 05 Sep 2025 22:18:25 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 04/11] target/riscv: Record misa_ext in TCGTBCPUState.cs_base
Date: Sat,  6 Sep 2025 07:18:13 +0200
Message-ID: <20250906051820.160432-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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


