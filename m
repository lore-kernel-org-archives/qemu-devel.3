Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7DCF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCT-0004Lo-Vo; Tue, 08 Oct 2024 20:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCQ-0004HI-Td
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCO-0002nt-R7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b49ee353cso58170055ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432303; x=1729037103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvwlrMz3Fk2P5q43/JWG8Wh7xLnVWB9wP6XAmMUyGN8=;
 b=vxSzVVqeKiEtpkgnsEzyp53JDmmebK62JIP6+ye7ruN0cRnveuXcbPeqSnlR30qXgP
 YxdpRhZqkKKxnc0lsXkXaPGwZKRSHcKOVEzMDBiCkpHForCKCimsq0bFuc29M/ZC4za1
 OJnrgSKvtpBR6tuT+PELxBN5SeX9YswGfl3bhS4AJy0JpPfK/9SGiCCAmI/kghx7gIzQ
 6xjvebnXS+/Ocg6kxIl9KdH75JJn/Gn4saqa+wnB63DjYAAjJtR+GeY9dKE4xf4oTNUO
 CoRNMEAA8t7CCUEoLOcOTcr4ztHNUjsl38vnmoio4YmGHu0s4wcR3NS0DIiGzR5txpcB
 xh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432303; x=1729037103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvwlrMz3Fk2P5q43/JWG8Wh7xLnVWB9wP6XAmMUyGN8=;
 b=apEaePGClXcPENwePxgnEOSTDX8mxET7ziVI4zGfGUdlEHkfNJcAFyMkOJ/tmXZGxk
 tNfu9ON1VERAHUG3hl3oF6uZWojn/se1Ac0rmz9YsAWfELM8TO/PleSR2pqebH59NKh2
 QXMcqOm5RAyd1k68Z4VH58Fs0tGqSUd8Yo49kOirj+KvrsZVT534L+vbUCgJt610XZ90
 3vRLOiAVK0UyQMdcwC9q9fqWblw7fi8eunmZ12sUuz/GJZmHQobPiScm4OkFpSmBaQZN
 B12P1j8ZxZHx3q68bOcesSV0LFJqjRpGgkY5B15/L+MnIdrn2MMoyxzN4nVA1pzvllO7
 nzQQ==
X-Gm-Message-State: AOJu0Yw/slmfnzedW5ftQMoYQukQjNZtnirwqkiEVJSbGRrSLRcmqRAS
 IyzanmKOZx1yMBYGGCjpikSvyQw4BsQ/EpZ3P5CUTzXmZ5X49ql0MS/EXmVrxzoL2wmCmSDfXPk
 O
X-Google-Smtp-Source: AGHT+IEQN3Rl72pcmgLCTKgbIcOtLba1v+GzwtpoC9AF0fnEDdxLNrxqZqv2s5T7uD+5Iv4bbg/olQ==
X-Received: by 2002:a17:903:2289:b0:20c:5263:247a with SMTP id
 d9443c01a7336-20c637809c9mr15713945ad.38.1728432303433; 
 Tue, 08 Oct 2024 17:05:03 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 08/20] target/hppa: Perform access rights before protection
 id check
Date: Tue,  8 Oct 2024 17:04:41 -0700
Message-ID: <20241009000453.315652-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Data memory access rights trap" in priority order ahead of
"Data memory protection ID trap".

Swap these checks in hppa_get_physical_address.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a386c80fa4..f027c494e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -267,6 +267,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
+    if (unlikely(!(prot & type))) {
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
+        goto egress;
+    }
+
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         int access_prot = (hppa_is_pa20(env)
@@ -281,12 +287,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         prot &= access_prot;
     }
 
-    if (unlikely(!(prot & type))) {
-        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
-        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
-        goto egress;
-    }
-
     /*
      * In priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
-- 
2.43.0


