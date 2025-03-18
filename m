Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC70C35FFA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuebE-0008BC-Mp; Tue, 18 Mar 2025 17:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueb9-0007nJ-2u
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:43 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueb7-0001PO-9o
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:42 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so4945865a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333739; x=1742938539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHfKPAV4txpIA6DabBRkgaflv6NwjVJFAo4bciu0CZ4=;
 b=YmSOZCcaXjSShsG9AglN95SH+gOrjcFx0tXi+SXjt1GuNtIFKJ1A/oAqJYgSyjzOKI
 5q4SYfkT3ypVon9RFpooxLLE3SZr99HwLVBywRR3rsQ3Yhy1vRiG4/pnuHt0XUmt4Uio
 og5My7b+AMNCO8zXKLmerLIQmhWtita/iDWHkJa8x0hzMy9dyTuK3uXk88OMKIh9b0XO
 wczaPWGa1/+KOsifuReYeetv4UpZ5DotouDMKYc/8kvgBloPaq+E0muWgOW2neV3BzPB
 APKYijLloaad0RVJx1hjDRHDKIex0hZS9bq7oQcykcHLO5DbrxMnhBAJCoIUa1uVtgaa
 24nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333739; x=1742938539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHfKPAV4txpIA6DabBRkgaflv6NwjVJFAo4bciu0CZ4=;
 b=kVzWi5zxG0Eg0QUWJQ4+A0DGP2gJphIWFDJWfbtfYvpnAA4NOBS52pffP0SWCX/iN7
 4oEIvARveRBDO8wup8mpiWYE0bObfEeyA/r/+iSkvZiQjJb7zdGDEibQQVXF2NWOsHR6
 OEatTSCyT/ywBmG8d9f0laforGdBp57ZFHL52CxyuV4tlf7D3HfFXFRQ2a1il2yU2mro
 sS+vD+YA0dyfA+95QfIdATsYJ8P2TBdFrbHbzlCE4WgGooYhdevoVCtxN1Hw/RJiNB+P
 OUDCENwr5OXtWvmLfoAWvIvE0g4+8Bm09/yDzBDVmAc3gN7mcYzzcLntXO9at1PTv3Ca
 F1LA==
X-Gm-Message-State: AOJu0Yycq6IDKmZQLrIdp6+70BUKQ7gPYOTpe/ue+cNvWJARFI1NuhSk
 BJo418h5LcksLh445NxocGhhNGfYx5T1F1svjGTggTslttfQ3NPiiUDmztP6u31Hu1/SeJHmlHo
 Q
X-Gm-Gg: ASbGnctUKo3z59T78CNRZKpGof1MTNmLO0CPBTGLhpa2eMEhpeozDG/yGnwMkjOKO6r
 jEE0LxU4rx0WbfDe4xz+ymolwu0BU8bQcHIVpOp6cDM9QoOPNji2BYFtcWflUjbdUoCPnqJp/wp
 lPYXoxzNqMeT1ZsBWsYLiqOPgCz6THSnP9eWn+FedY2RYV0ESBZ8O3oQc4SFUeeHI+WXgAGQlPN
 rvXXLIk6PO+9/h6XWWz1TjHCpb+yIe2Buxyf38HeI/iOBySKfN4kQf5B4yMFlaoPZ9oUIrh+xxx
 fODmMvgOToSTvVULm9PGZn+YeGcXtl1+xK63SN5OZpzfkcMgFrwpddZOKjtvl43cnD3xvhsbp6m
 b
X-Google-Smtp-Source: AGHT+IEVKxLbLLwy5CmQZpK7HWsOk1ho2oSI8ebcRvyODL5/RkAJ1ky7mfk6eKTesWFhPaYOScOUUg==
X-Received: by 2002:a17:90b:2f84:b0:2fe:afa7:eaf8 with SMTP id
 98e67ed59e1d1-301bde5b0damr352211a91.13.1742333739651; 
 Tue, 18 Mar 2025 14:35:39 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539e9ab7sm8678072a91.11.2025.03.18.14.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:35:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 41/42] target/riscv: Remove ifndef CONFIG_USER_ONLY from
 cpu_cfg.h
Date: Tue, 18 Mar 2025 14:32:06 -0700
Message-ID: <20250318213209.2579218-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

While RISCVCPUConfig.satp_mode is unused for user-only,
this header is used from disas/riscv.h, whose users are
only built once.  The savings of 4 bytes isn't worth it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_cfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..cfe371b829 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,9 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
-#ifndef CONFIG_USER_ONLY
     RISCVSATPMap satp_mode;
-#endif
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
-- 
2.43.0


