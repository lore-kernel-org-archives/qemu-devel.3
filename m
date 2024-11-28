Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE30D690F7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbux-0008Vi-4r; Thu, 28 Nov 2024 05:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbuv-0008VQ-Qg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:38:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbuu-000663-94
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:38:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a742481aso5762395e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790313; x=1733395113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TP0Ip4Rzdbzg4KxmAGds5CRnBSGPx3UMLoPkVjTmsAI=;
 b=mVjTVCco0qoj+Rters8+MNObTJTN5QUR5QTMhWzzxytWe523OI5y25yciNtDwMEtMb
 YnCDf6VzUSdviSiatlsDElHeJbHkOtBcjt52hz6tCZWmaeL8FUYW3y2NngMPTWJXrA9z
 bNtCUirUbF4Cr04ra6qw33BzJP9B656QLdWfTLloEy//aBMjIKuZgjiwEeTbifl0v89e
 A+oGcV/hQE7kPAfpQhEwROpDJvHA15rB0T5U8c39ZBHlUVbPAyXZ9iVyVujIN/ZsHmez
 3NxnLYxlXA3sEOkbJCEgTxG7IGU/a/6mLybhHPKTn7IpLgQv9iN/CdXCJK8pK7dBLAKL
 SfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790313; x=1733395113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TP0Ip4Rzdbzg4KxmAGds5CRnBSGPx3UMLoPkVjTmsAI=;
 b=bdvGLCOiUkZ73sIbkiSRW3MSPz0WQIrBB+zFXD31exHf8lKzpqEHEVTYe7GbZMK5Y0
 IYTB1NaL08uiyn/8p6jNQAsSUY9DjDsu5jr67aoiMMhdvi47MhTKSBUKPmuSnQl1Py7o
 ZO6qZf7Kxd6ugqwPf1ZH1NOswMefbKYab1ICNpEs+VZjJdBDH06eW8G39etUsnKXF5NC
 I9ZGAF01+KIj4DrDaSgujBoRxyNQkodc1+a6aRVIxrF80+MXTpk5URw7VM9OX3wPyS7C
 6P0ND5DPfhzgzD7lf4k0rGaB9LVSOwD9tBawRMOdomJT5gkRxmxswrxag6AK+ZFLMaFY
 kfSQ==
X-Gm-Message-State: AOJu0YxdrrUGt2Mitpzdc/2tngxsnQ/Gw4FanIQeqWjHXWGH+WgV+lRA
 DRxOn0zZeBphuI4Omx0ZoRsXsDysKBTUX/+3o29NL9odC4L3SSPFQM8v56/EkpxCNmT3/fqxn+m
 u
X-Gm-Gg: ASbGncuo6cSTKoR+ikHv1Hnj9DCdP0WDlIDIs7ezHeCd7Y7DWsLg0cZnDwg66vowjeC
 FLZZCAx0fpOPMPGY/yOvhgS7Ew1FVUNZJXztcw98+scsnxuWzaC6c3UaTyz+S7zP/JFcZ5CvosO
 J8NkAjtzzjjtaQmxOWA30nPsHlj60ZiDPF+Tvs4PSfigS9bwBDrrD8Yj2P1lKLaig80pQTyRhQx
 USvu6dQDQLPHHMJJyBKV50eYh1f216iwuVyKFpad/1vSxPiW/dPedx/
X-Google-Smtp-Source: AGHT+IGA3jW6Edqm5aXqMBYN81KhO8fM4qovl5967vXF+a0VgzWNLA09gieyGZf4xCYdyCfEzHPx3A==
X-Received: by 2002:a05:600c:458d:b0:433:c463:62dd with SMTP id
 5b1f17b1804b1-434a9e0e5femr57951435e9.27.1732790313384; 
 Thu, 28 Nov 2024 02:38:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f7150esm17596885e9.42.2024.11.28.02.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:38:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
Date: Thu, 28 Nov 2024 10:38:31 +0000
Message-Id: <20241128103831.3452572-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
cs->exception as a shift value.  However this value can be larger
than 31, which means that "1 << cause" is undefined behaviour,
because we do the shift on an 'int' type.

This causes the undefined behaviour sanitizer to complain
on one of the check-tcg tests:

$ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
    #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
    #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9

In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.

Use 1ULL instead to ensure that the shift is in range.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/cpu_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69eab..45806f5ab0f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1802,10 +1802,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     uint64_t deleg = async ? env->mideleg : env->medeleg;
-    bool s_injected = env->mvip & (1 << cause) & env->mvien &&
-        !(env->mip & (1 << cause));
-    bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
-        !(env->mip & (1 << cause));
+    bool s_injected = env->mvip & (1ULL << cause) & env->mvien &&
+        !(env->mip & (1ULL << cause));
+    bool vs_injected = env->hvip & (1ULL << cause) & env->hvien &&
+        !(env->mip & (1ULL << cause));
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
-- 
2.34.1


