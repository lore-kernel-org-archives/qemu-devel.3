Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FB8C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxCO-0004Dw-Oz; Tue, 25 Feb 2025 10:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmxC8-00048I-3D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:50:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmxC5-0000Hp-RC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:50:03 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so50520965e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740498600; x=1741103400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=R7SgA1uJ9ZyH2wsua3J8g88XXUrkbWB58CQLEcjyAXuOHPF9vt2/xntsIhomLKpVsR
 T8AFOGAHAeW+6krfDO6wSzh/p2VrmbahOvxgE/bUzBGrQEPNrsZ4+Dj3YjoWTUC/7H8u
 mKriau3s45N2spBAnEMHHpGrVZKMTJ895n+7QrCxy3dQzGGejRvaERSpSA4q0cvCN6Sq
 YqhTn04jDH5hXGbim+9QW9OLdGfZN9THBigiTj4688SK7QvXVVtL2CSwK/WJsF03CD1z
 W4sRDNuUeb0IiYAcF/zNMKKLoShY9BfBzWfW9oolEmnHGDlwdQl3DvBkhbkbGegEZmvy
 lNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740498600; x=1741103400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ARpHgUZMwp8raT8BG/xC2iQyd8jk567fSMLDtTYJSPM=;
 b=AnMU2Eugm+yFF12PiqRfFlXUm/juTldBGhl3AfIKWxh8lqC8fmfTX/FJ1EXF9BUBIw
 mlVBet+jbYXeCE6mUVzA2YlQpPcRZYEYxEniffvB31eLaDK1VZkJnquqrXifdBpdWbQU
 jHCNkD02m0vRM6Hpzz75JzB47vq4K6LvB5O3zq6qRLjq50xbYfiCYv2FIEp/sVt5R3xl
 YEzqyiAXB0kt2y9rpuG3U+p+9whkt2q5n7g7qsX386m45YkOz8MQK3kO7YyqChbm4KW0
 tGTS2kRVK2W4j11n2Tg1rhzJZeSgQIJ37fdQkBdgGOxcf4NJNV2fk4On770iovwWEcJX
 1OPA==
X-Gm-Message-State: AOJu0YzW6aKv66O8wNgBeKdvzHei7z8E/K0/gWgbsO3VJ3RhLLvP70w+
 EQImdcwfeEam1HoRPIHYquCEC2yAkSbfEvfL2+7qc3XEEzboGs67A4zY7LPhe5c=
X-Gm-Gg: ASbGncsfSUYUeN6eQZI8AtThwDOEU/8jlPS5iW966cmu7a5viSDmfFKKOgIsyqlGsXv
 CT1Q3InlAgaoa5FeUUKc33DwUSB01yY7Ob8tNYAu5MVhlNjAQQNxxWCOApKE6Z0tkKVW8bykrL3
 Ms2+OBuJDTpaHTz+MkR8uB8uq9MHnGV+0LtlbhbTKOjFGAISBEkrmMjC+ZzKeRiiUdjGJiMzEK1
 udrulyHCSXy5PzUAHgLNAGVU0D1MYPuH1jVnHDyAGwNG7crbBXeDs+phN71dbsz0nyJmGBC6/EQ
 sZKL74e89dVynxaWNqVxfzot+U9o
X-Google-Smtp-Source: AGHT+IF8CIyLJU2TKeaaLuPe1zYOP1z3xih+EOV9gBQi8px1CqUwxvU9FqMgPH5ynlwlrG1dPx+fCw==
X-Received: by 2002:a05:600c:3ca3:b0:439:6a7b:7697 with SMTP id
 5b1f17b1804b1-43ab8fe183fmr527615e9.14.1740498599481; 
 Tue, 25 Feb 2025 07:49:59 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab153dbcdsm29984595e9.15.2025.02.25.07.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 07:49:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F24215F7DC;
 Tue, 25 Feb 2025 15:49:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [RFC PATCH v2] target/ppc: drop ppc_tlb_invalidate_all from cpu_reset
Date: Tue, 25 Feb 2025 15:49:55 +0000
Message-Id: <20250225154955.3544009-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


