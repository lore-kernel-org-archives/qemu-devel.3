Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DD1C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h2-0001wp-LL; Fri, 01 Mar 2024 15:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h1-0001q6-B6
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:19 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9gx-0006wB-8j
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:19 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29a378040daso1799555a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325673; x=1709930473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WvuWRsPJJBj+6VcLIP8dGcQUGFQW1sLwVfjWaSzIi0U=;
 b=G0JXi5dXg5c8UiLW7Z3HewjJ4s5s/ukIA2BEn23bqObz40Fw7gnZaj1a06D6TBKq4h
 pqbUp9SGz3mHn9Rn0hlmMISI2G4eWRUcckjR6uMAyignN0cXBsZAOi/QxH2kmyhyJ+Qs
 pzwpsbEZRwXtqQEXhVU2JerApH0Zz3kdqGLZ7DM4B3FGErQb6tT2WO6VdQy/X9mLfB+J
 14EfILBb4tRoNuzGGl0rAIVbaEsxQF5UAunIR7tdts+PB0ghc9J6c/uLpWjsm2+xypng
 5vjPu2P0vT6lCF8PLt/EQqZbaY38LUrTuL/4q2OF85t/fgOj3BIlnV/th5NBu438HPkn
 I+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325673; x=1709930473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WvuWRsPJJBj+6VcLIP8dGcQUGFQW1sLwVfjWaSzIi0U=;
 b=xJjGgr0D2f3j7cQJTBBrlPlKTs3nVaFPdsQMeyp8roMkw4Q77e6Klz0wvLjj8XOvsM
 VK6waJgvoKGmjpCgVRGTqu/V+Fp8SQ28XCQoZg//ZMdxLZX/yczbpATEaHrYb6Bkal4T
 vPxRmZjHsB+sAsqO+eLF/K1EczybyhdqbPJ5Q/bhC1mnlH47fDZcBO3aSn53iA+OHWVk
 sZ8cCNngZfg6zIkX5RgtkdxGrSnuI9bigRv9rozEl0t9MNSp1IEfs0VslxtspHWWlj+K
 EGDaBokIxPGv+39ayd+hglUkL4102IdUbL2o8vqyRuvui8KYzagk2VPgpKrqv/z6PU++
 Wf/Q==
X-Gm-Message-State: AOJu0YyfiG0Vmo98BGFYGBmbiiVUyYEjn81+gbuTS6c9kkp27Kv777Fm
 n/kkGGpaMNS7N42P7qgZRK93Fa3EMdq5Zy0HUFFhBq/1Nmyt6Jz0mXL0u49LSTT457sprtNHewp
 i
X-Google-Smtp-Source: AGHT+IF4DILoK9U8hPxtHPO5QMddKmyY/rUugVR2TrKrTCn+Csqp+K96ruWWzmB4zc0RChcDCqQkzw==
X-Received: by 2002:a17:90a:bf01:b0:299:d96f:9145 with SMTP id
 c1-20020a17090abf0100b00299d96f9145mr2994139pjs.0.1709325673618; 
 Fri, 01 Mar 2024 12:41:13 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 0/6] target/arm: Do memory alignment check for device memory
Date: Fri,  1 Mar 2024 10:41:04 -1000
Message-Id: <20240301204110.656742-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

v1: https://lore.kernel.org/qemu-devel/20230223204342.1093632-1-richard.henderson@linaro.org/
v2: https://lore.kernel.org/qemu-devel/20230621121902.1392277-1-richard.henderson@linaro.org/

Some of the v2 patch set was merged last June, but the rest languished.
No substantive changes from v2; only fixed rebase conflicts.


r~


Richard Henderson (6):
  target/arm: Support 32-byte alignment in pow2_align
  exec/memattrs: Remove target_tlb_bit*
  accel/tcg: Add tlb_fill_flags to CPUTLBEntryFull
  accel/tcg: Add TLB_CHECK_ALIGNED
  target/arm: Do memory type alignment check when translation disabled
  target/arm: Do memory type alignment check when translation enabled

 include/exec/cpu-all.h     |  4 +++-
 include/exec/memattrs.h    | 12 ------------
 include/hw/core/cpu.h      |  3 +++
 accel/tcg/cputlb.c         | 35 ++++++++++++++++++++++++++++-------
 target/arm/ptw.c           | 32 ++++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c    | 34 ++++++++++++++++++++++++++++++++--
 target/arm/tcg/translate.c |  8 +-------
 target/sparc/mmu_helper.c  |  2 +-
 8 files changed, 100 insertions(+), 30 deletions(-)

-- 
2.34.1


