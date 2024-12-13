Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B5AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2E-0002qD-4R; Fri, 13 Dec 2024 14:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1i-0002VL-SE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:42 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1h-0006Xc-6m
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:38 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e15717a2dso933243a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116916; x=1734721716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMmfxBtIiIXQAk+hQuWMNvOte8CftqHpp2z6mVglAAg=;
 b=PsxB3Kt1Pk8kIaIYCsx4pH3CLcCzmAfQl5wzZhRHjwv2y14bVCXrNxWcztlBvtMqoO
 58jJvPb7Jn0wJeLovvy8kpVuG6To+UpTXbTqbJARQfTNsEcCNgLhnifJX0re/MJDM1nA
 fCXIz5S25ozjGGYHeXg0EbbXMY0kmtD1mOHEuaYN56ZTcdcrhrJ/DWzGGGY5tx8EPTeg
 mSgm0c28nbL4ykBAKfHGLHj+e+Bw//Xoae+2k0itRS2JeFQ/IvN6Ogk9WWkgFZaaUjcv
 VeMmlFfxrtC2O89CqlJeV/cJGWRZjh/FxTOBWkGJKfNgbK0fX/BbXLjVTRW7Pog7KiK2
 mRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116916; x=1734721716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMmfxBtIiIXQAk+hQuWMNvOte8CftqHpp2z6mVglAAg=;
 b=hqjqXjKQocBTGtlYRvCZCOMiXvQsCklesLD8YQvn/2W63dJBW7twQgoNGYWgQUjTp5
 0mUvqfSZIdLD8aslGiwl4Jibb0RS3V7Dv8TYe0meowIdKk/GNfHrqVoF8mhx4SBgw9X7
 bkhe8wUxHsgutnIX5FHut6CaPwTWT2coqkOFgzO6EgH6RPYs7VFYEcTrMVMep4PuoBXa
 5boXxieSZwdq44MNLOPyET+zg6FBXor2QCHRF8LAFMvYDRvU5+DKTUr8w/6k5O87RJQn
 t1NXx5vVidzoKVNJdHvj+zcnXIU81EP+oKbLJpeT1jun78Bfq2SYMuyfBJpRDWeZWESr
 06Fg==
X-Gm-Message-State: AOJu0Ywir1CN7KxDQge4u6a/IeeMBbsrQ9/J1ZQ8f6ZGDAv2N2Uxt+EA
 2xj8OWHLXXlOxrILPUP2VAUE/IIvC7rDpUJEANyyB3H9tUuFn7Ztg74cWUdNumMbXFG/MMz/izG
 MgvWd7Ia4
X-Gm-Gg: ASbGncusHNhXdNjHAk4aY6oDyBf6XfIeCS9TA4msFM2D84JvAHZ10irNABWZwQ04zyA
 HO2SYZKvyE/GbV8ft3kwOgORGFRJz+vL4EO1c755G6ZaJNUKWczeUZabTX2Vfzna+eex5kSS3Ib
 NuY65kBy3i6SuPxeA9bT0sJIwESZnJkCWEBH5ImgcG49JOhj6hvA8sgCFqN0DNE5jVMsmxeZB1N
 S80Oi7iUoRc3Uv5iBbfmnAwdWdjU3HpQ1AbpEvzXFOMYb3Rm6w7olUBVjbJLb3K
X-Google-Smtp-Source: AGHT+IHR9dtrRL4g/E7x0+FRYpPWMzlKYyihfOxPXAT7iSgrm3iYxLMSyRaqRPWEIdZBAwzGSr5TAQ==
X-Received: by 2002:a05:6830:380a:b0:718:a52:e1cc with SMTP id
 46e09a7af769-71e3ba3a182mr2496590a34.25.1734116915785; 
 Fri, 13 Dec 2024 11:08:35 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 08/71] target/riscv: Constify all Property
Date: Fri, 13 Dec 2024 13:06:42 -0600
Message-ID: <20241213190750.2513964-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 80b09952e7..4329015076 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2661,7 +2661,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
-static Property riscv_cpu_properties[] = {
+static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
-- 
2.43.0


