Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2581CC531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9xr-0006mI-Lj; Wed, 14 Aug 2024 05:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9xn-0006Ng-Gk
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:06:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9xl-0000rl-Lj
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:06:39 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso598502266b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723626395; x=1724231195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2c0XRHjU0y3cm6Z6eyIislTDkEC9zABvUTWrSeWCGjw=;
 b=eVh4jqt/xFRlje2e6kzP2sUjTyUyn0IY/5FuUkG50Aa3PJks691O8RUBVgn93ELb1J
 0PnVCg7nd7Rwtxm0/KV92zbmE7IvSERXxRylojn3dy2OASbyXKqcGAqOkkpo784Nd++l
 7dcftOGeLGbe3F9+OLh7hhyL4zjZVHUp06MQlb6m7dW8zKWWTawuVB2tmivYPVUeJtGA
 +Lm1zIPEQNOfFl40F8Yez43MmgJuVHufNCu7N0RyAzOE2lkGTRJvFq200tahQ+EZEtWw
 j8d7C9Up6vIwndF/E7HnckMor7Siq//yKZ1D9yqmqEOQ1i7KyWITeVW2LU0wYn0OZ8eY
 Zt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723626395; x=1724231195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2c0XRHjU0y3cm6Z6eyIislTDkEC9zABvUTWrSeWCGjw=;
 b=pPC8HnrCbXh3azS7TfS2jwfcE/vd9t6mGUSpQmbh7SLfxui4bWhB3GSa7anS9JtQE2
 VOyQa0yrAznv2SICP36HIJzYyuBP6ybOfbh1qAQ5Q72B8VQsHWdqYd5sUiJKYS1jEJsX
 i5freVydxTFc6IoWX135F+opf/zecbauqbmRDxhuj7sg7h1GdI1ZbDa42eux+2vX5M1S
 wTpuK2tjC5JjKcm6q1Oqfvp29HSRgy/nBRbvtkDzUQQz0Pz0n3lZc51/tzThzR8QzSDD
 Zmi+jM5EBHbxJBDt7rArWJICicO1OTy1PLVVIr2smU7XUeFnX+luC7uHxl2ZGS4ESeFi
 h0AA==
X-Gm-Message-State: AOJu0Yzml+Q056CLAGbTeB5ltxxyxPnuVdGnXjZpVCM/ovx0kmk44WcP
 U/xKr3AU1otLkP9Sv4JWqGYHGFMa3Pd6YnN+D036F6r+Ei61O+hoL7Gu6ejx+z7sgrxiAgssHaj
 FAYw=
X-Google-Smtp-Source: AGHT+IHq4qL/d5eYhN2Fp+NlLv2g2obI6vIsS6Y1taMn2w782x6PyhFJr5tVEgU6bx5LFyKw8x5a5g==
X-Received: by 2002:a17:907:3ea6:b0:a72:8a62:65e7 with SMTP id
 a640c23a62f3a-a8367047e66mr142634666b.57.1723626395466; 
 Wed, 14 Aug 2024 02:06:35 -0700 (PDT)
Received: from localhost.localdomain (124.170.88.92.rev.sfr.net.
 [92.88.170.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f414e561sm145162166b.169.2024.08.14.02.06.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 02:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v4 3/3] target/mips: Load PTE as DATA
Date: Wed, 14 Aug 2024 11:04:52 +0200
Message-ID: <20240814090452.2591-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814090452.2591-1-philmd@linaro.org>
References: <20240814090452.2591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PTE is not CODE so load it as normal DATA access.

Fixes: 074cfcb4da ("Implement hardware page table walker for MIPS32")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 0e94e00a5f..3836137750 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -603,9 +603,9 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
 
     oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
     if (op == MO_64) {
-        *pte = cpu_ldq_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldq_mmu(env, vaddr, oi, 0);
     } else {
-        *pte = cpu_ldl_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldl_mmu(env, vaddr, oi, 0);
     }
 
     return true;
-- 
2.45.2


