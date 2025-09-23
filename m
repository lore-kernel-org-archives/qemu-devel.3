Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3708CAC5B2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay5-0006KG-OD; Tue, 23 Sep 2025 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay0-0006Hg-Hn
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axy-0003iB-OT
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-267facf9b58so44832705ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664469; x=1759269269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhvyGjhjUkCNEHZh1gnQZUsirw8YiHVeIFO9VlHtSAY=;
 b=AWk+E3MJVypdb0Q8LFQSvRnrbHSoT61Rg7Rgfs/OSpKa1nHAn8dHKILfurr/S2Mc6Z
 3mIet07bHVU3F4cSuUrgLngi/jferYln0ERyW90k6W0l+NCTqIBZCCfXcdmcbgYEoFMz
 QhOo2H5G6PnLjN6y8Osz0pCXbtTW6OEo/Z4s9szT0xPMyToTgl63DyBS7ffoRLPPVkbZ
 /xf7FJ0TEmZ6Ldv87IBQsiX4TC5JrwIVv8/2V9SfKMjv6lPI0716vsebOJwCtyW7P29f
 2t+ueoMfngFlTrNtpdstFj48yp4b9n15QXqOaC30bSov2lN6SP31qVLEQdF5m4XTA+A3
 pP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664469; x=1759269269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhvyGjhjUkCNEHZh1gnQZUsirw8YiHVeIFO9VlHtSAY=;
 b=F1GmlrzTXvxEhoXcPw+J3a3ngM7tIc5NfD/sEtqcLbeGNos5x+xGPEDZM6C1fh7GHe
 HMvx5H1hX68KHrNTKKqUnX2JKdhtJxbS+taoChQPQ2369uSQKrDovlwKbMTWJ+83u6Ox
 9b30ZkzFbBpEOD6l/5KajIrJeywTvUswRN6wp2I2lvgb1DzzvR4dk8GBeGhzwKUx+Z2X
 VeUbuQREJo4NxZ3TmmeOM/3ItF7WPDc1hMuEGz/5tqX91YMShMenR6e3xYXjPmdQYim2
 tAq7f3ZtKpJizY/eTKFR3dLrnKJsf2TeJNn6QOGSFFqRTksMJQDBYLO7dJFgdt6nvuEL
 fz8w==
X-Gm-Message-State: AOJu0YwCETh13yEJ4s3OrAlRvCzEq0OrIsjWAtGtQJgfYkUR7GMycO0i
 hjFPZ7QPZWIffTVZNsdJmmBw2PU1jw9HURLb8/ThtCF7qoexmaiveiwGqmLjYoGMFLZ6Q4KiovE
 0W0ZR
X-Gm-Gg: ASbGncvyKyd1hup34UliwFWW03eFH3I0xQT0aryOJGUqimCDhjxWkEduAp4lbbgzyeV
 I2Rfr9MGQmciT+XzQyirHELm/Ha8xQi/zXk/EMKnj+8pIaxqpNQXncmtkave9XzsIwnHI/YhSFk
 2zsZrfUL8GJ0+SnF3YSScuSKHRV7/rbTlVrFqoTWUFqandOXyFRODjE1ZlW2s6/iAh5j26N8EsM
 xAoXZMmS5oXkVsOCKajJlZi6SeIpffSAJR6td9xIH1xSbthAwuYFTcuxaGPKBz3W4v/qV1XfM3B
 2hkcm26B6OsIyevdQXqxaSGkDwp+Q60bpjsF7fAWOqblh5DW39c9wU+ZW3pyQG/eU8F3uS65Tmb
 GIv2bs8gjLSKdFZ5H9v1trEZWvq9m
X-Google-Smtp-Source: AGHT+IEn5Oxb4i7FOn1Fa1bspf261Rtx1+QilAne9nm+qkS/xMq3hv8VeYEzqIOg+U/w2wEG5n8rpA==
X-Received: by 2002:a17:902:e84f:b0:26a:589b:cf11 with SMTP id
 d9443c01a7336-27cc678387amr56335895ad.43.1758664469096; 
 Tue, 23 Sep 2025 14:54:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 03/10] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
Date: Tue, 23 Sep 2025 14:54:17 -0700
Message-ID: <20250923215425.3685950-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


