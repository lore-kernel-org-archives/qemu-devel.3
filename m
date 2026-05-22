Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03644CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxw-0007jr-VJ; Fri, 22 May 2026 18:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxg-0007hE-Jj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:21 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxe-0007sV-Mo
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-369002b26f4so4442980a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487397; x=1780092197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzaEhs95KOVdosdksX5QP/p2B/VwIujPaKiRxVIOAHQ=;
 b=IcFpxQWiSN+Al6G5YwxfG1WbzrFL3G5KMjYFTY50P1+iVPpV/haCo/zh7SUY6UAc8I
 swFlYxAhIBzHiz22l9TR3PgK1qlU6FMT0MSOYsfWzu4IL6VpTes+5Iu+MNDjeWev6io9
 1b4fp5JQ0ylPnamshINwNbrbgMd/p1LvxDZx/LRdv4+dYGDAMsivmBBjJ3iV4NzOz/Ep
 cSC8DkxPDOkVDK7WDZQk/uHfmebrBB2YLvWjAN5Ewt9YopXLaOFe2fnEm7MwFCBiDcDj
 YGyc2KPiO6lsKj9WZ65sZvEBpChl9cXIH2YWpvopVyH62ybDfeSZFfXgBt/seRvV3L6g
 EpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487397; x=1780092197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mzaEhs95KOVdosdksX5QP/p2B/VwIujPaKiRxVIOAHQ=;
 b=Xy9d2s970FjMSg9IuMCuctJf+ix0Ov75WWvUxFSJDTImLLtHceoKeAF9AQ6ElzpwV1
 YeB8yFgNnTshNCixP1xFeSOyZDb6RU9jKOfwKLthfhk8pNTycJz+gzwbA0JO7zDAuZPy
 iN7tqqQHkOwN9WG5feW7eNnZD3csbrxOHMcHJnJzDciFYwKDieIThyOH2ZDm98/vV/wB
 kFsgIq1ly9DtNDLX02DKzIRVaLBmRm7Gl4fyRkLt/qGkDCtv7nrnGncqtw17n1B6f0z6
 +J3ks2z88a616wJQr3/i4p1vMzQxCzBlN9zAIZ/S9/GtdBhUfrPz73eUYNoebd4/RIZq
 wjzg==
X-Gm-Message-State: AOJu0Yz0xMX/buJA20oTiW8yeoXI0r1HNysidE2VRgCvwzk8NDrvuQLg
 OpsIBJO+07iYHgq4wSjIXFJTP9Cs/9ARBkHcCnXXn5TIWaiPiHkbgcG+4/d3WfegCFrJrwFYYX/
 DmlXa
X-Gm-Gg: Acq92OHlSc/umdty/b2BmEXQ1UNz3e+XrBa0nQ0IQtykZRBjFeuJEootBBO4Uwd1EuX
 eaa8dznaLVJbbS48XiI6F8iHfEmUnI4jNa65vL755yCmRyutyxSBqpeIHMe3Ih/bEKWPqkRWEvi
 wwNazj9hZGYDIyBtM2yzCgpEQb4jD06tU17aJQ9bVCW5hVIo8du1gYPaPfmCLMPYmFGJ29dXkEp
 N2AvbD6LGkVQ5VRL4Yv86fUIcTZOuJTI3Rryz+ZKeiai3aQGF5YYqn40deXfUzu/FfRguLHq0F5
 edC0C2Q1fDgH1zR6AOV94YpTZwomd7/+/VCL16EPFXyq9yfEPozIgQ7YH8eDwd24DnJuHbDW2o5
 2L8V9F3KBWo/pLlAH8EcdkE+/vBWIvRhen5sQf6E648IJoyhq3ntHGuUVqOCkK0IoJFQksLGFVU
 UW1HEPbK1P+ZcXvzaeS/YUMIhuN61+
X-Received: by 2002:a17:90b:33c1:b0:368:6998:b49d with SMTP id
 98e67ed59e1d1-36a6772d18emr4896766a91.10.1779487397063; 
 Fri, 22 May 2026 15:03:17 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 09/64] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Fri, 22 May 2026 15:02:11 -0700
Message-ID: <20260522220306.235200-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a549a50b7d..e9e261eb2a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1485,6 +1485,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


