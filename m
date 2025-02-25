Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C3C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzxU-0002K8-Oj; Tue, 25 Feb 2025 13:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzww-0002B0-MC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzwt-0000Gr-P2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f286b5281so3027024f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509190; x=1741113990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=FOiselbwCHwxQO00iT1MyiVB4lOgO1sL+c3oGg6Hm+hhHY1Lpb3EXEM2oup4VXz3ql
 62xsYVbx9MPlJ1BfMCmlRLRRcgk/QMfXv4eLxrPZdl4iVGtfZ/VLD7K4oLcvC6RR54Gt
 z7XwRR8MDr2lGy+CKAHGG0s4tVKTyvkCItXbfesoVOQ+jB1z1O+1QhcehQ+5su9ZGn4X
 ns5YSrtuw1hSIVyTZAL6bHM+Bw7wzfd1ijCAEYyrKGu2CG7vZ3y8niF78qOZC3pxIoUX
 +ChXCCbvQkIM9gT5r36Iej3FAZEWc/RdqUZBNQO2Ijvv3svfZzLL/nxh5c3XvFiPSPm6
 vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509190; x=1741113990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=GpfPtK1SOHRRc8/wFuasu/9NFBJFwmTfohPPGPHFbTWJktwf8eiRlw3pdbgqRKq+Wr
 rzLfjtyXapZkLN1RAfFjNBxNWck7hkAKFtCWlpWnip9MfHQie6AX1AQItz4FUcEPUW9J
 toOpiqlL6ato5dNIQZzFBn/afd0T+qqnqo85Bq72BzWnuOJNUiwoKpwpu0e9t0b9t6y9
 YV9FUPSwOiQJI4jZY9dioenNftX6vxrXBPZpSChB8hqauowKbk6Ti/tCmbBRW92fmH1d
 C72Qi0o5Zd9RoXutYprW7fsZs+ZGzhqJzSdDlnsNetGE/7hGr17hhF89RVonh655gfGu
 v7SQ==
X-Gm-Message-State: AOJu0YzPOS3znv0GBGemVxGGga9lTPBb8qgrfCFomwgRMuMKr2B3M9sG
 6S31mE6o5ns8lfsFhsQpT2v9N2kHdgqK4DX/K6hvMd+5JNX7qpXuL06UgAhVULo=
X-Gm-Gg: ASbGnctktQXDTMLqjuPUuK4+CFX9hGWRnECEyDg+brci1HWIzCpNdAerQgNuwEkdq6N
 b4bGd1W6Fy7tdmEvdyq2013RkpeFBMHpex2AwLxK6ilKiGxskWy8B92d+SyFXcQITwE5ggkh1WY
 TIX+s5QfVdOQcpRkyyFPsFjprT1k0KcZb3xHP5BuXxWcpwXk46DZj7AgpUykS60mwFe0It5A/z5
 wDIXxPEKOt7ytirz0Bc/g6uSw9uuR0OqwNqsNJI76CZcwzad9MYdmVO1PHYywc58IPDIIttHG75
 OSwcDjqI92Jn9tbl34X50VVhxvfm
X-Google-Smtp-Source: AGHT+IG7LBX5isWh9+nF7DsNMmQlPdiw5XO1qegu9qkEXqvicwVGPGvgkUJxM1uj5zVf61SE11dkxw==
X-Received: by 2002:a5d:5f53:0:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-38f70827f18mr15613618f8f.40.1740509189848; 
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e70c8sm3151125f8f.76.2025.02.25.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 844E95F9D0;
 Tue, 25 Feb 2025 18:46:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] target/ppc: drop ppc_tlb_invalidate_all from cpu_reset
Date: Tue, 25 Feb 2025 18:46:25 +0000
Message-Id: <20250225184628.3590671-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225184628.3590671-1-alex.bennee@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vCPU parent already triggers a tb_flush so this is un-needed:

  #0  tlb_flush_other_cpu (cpu=0x555556df8630) at ../../accel/tcg/cputlb.c:419
  #1  0x0000555555ee38c9 in tcg_cpu_reset_hold (cpu=0x555556df8630) at ../../accel/tcg/tcg-accel-ops.c:88
  #2  0x0000555555bc29e5 in cpu_exec_reset_hold (cpu=0x555556df8630) at ../../system/cpus.c:208
  #3  0x00005555558932c3 in cpu_common_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/cpu-common.c:139
  #4  0x0000555555d480b1 in ppc_cpu_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../target/ppc/cpu_init.c:7200
  #5  0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556df8630, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162
  #6  0x0000555555ef24f4 in resettable_assert_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:58
  #7  0x0000555555ef244c in resettable_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:45
  #8  0x0000555555eef525 in device_cold_reset (dev=0x555556df8630) at ../../hw/core/qdev.c:239
  #9  0x00005555558931ab in cpu_reset (cpu=0x555556df8630) at ../../hw/core/cpu-common.c:114
  #10 0x0000555555d1ec6b in ppce500_cpu_reset (opaque=0x555556df8630) at ../../hw/ppc/e500.c:785
  #11 0x000055555595c410 in legacy_reset_hold (obj=0x555556e6bbc0, type=RESET_TYPE_COLD) at ../../hw/core/reset.c:76
  #12 0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556e6bbc0, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu_init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 062a6e85fb..f987b75c4f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7242,9 +7242,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     if (tcg_enabled()) {
         cpu_breakpoint_remove_all(cs, BP_CPU);
         cpu_watchpoint_remove_all(cs, BP_CPU);
-        if (env->mmu_model != POWERPC_MMU_REAL) {
-            ppc_tlb_invalidate_all(env);
-        }
         pmu_mmcr01a_updated(env);
     }
 
-- 
2.39.5


