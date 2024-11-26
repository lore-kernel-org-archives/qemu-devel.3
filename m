Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F8AD65531
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7l-0007AG-SE; Tue, 26 Nov 2024 12:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7a-00076h-Lr; Tue, 26 Nov 2024 12:13:07 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7Z-0004Gv-1q; Tue, 26 Nov 2024 12:13:06 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7252b5d7b1dso398564b3a.0; 
 Tue, 26 Nov 2024 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641182; x=1733245982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsqoIQj9JODnX97WlmZNc/233c/fmCNEOp8SnAPre+k=;
 b=gb63PHwdJrrWh1FFKgYoF3HGdKB8a59uKgDllElqnQiio6Jn+Zx6QwS+AbCBUwWrRQ
 dlZfiCExUu2MCp5Acus7WuKK3V6Yoe5fHUi6wNDxBrK0E6cb426McMbtwdfHDYPfIaKs
 JWq4Qal+4JCbX3D6XJZBx4SIGTSDRbyL1W9qcsc7qQpmcrbnS1K2yAJoDLdmJgxTiRqp
 0H4EeAkRkCMXri9QH3/1cAfWVeq/K9KfbO8CldrvrKpA5KwFr1Lzjump4/9d5T9EsXGD
 DOl+Fk8BTclRb8LEW2wRVxKcEu+1MsJbVBVfdJxHiDmBYX58vFCW8t7NVM5RbBfu7eSZ
 QmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641182; x=1733245982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsqoIQj9JODnX97WlmZNc/233c/fmCNEOp8SnAPre+k=;
 b=eaT9R376JEz7kmxwd9MCKQSiGqeTHfOtr/GaF9tIc4pF+BktG9bqLAyq64L99sFF6b
 p6i8zjR/jG08tN9SNODIRMr2+FR42ZVOJXuDcZK4xYWBvmK35GsnOhJ9h4lhfkuORdPL
 4fWPHUaThQaQFjdFGRSdTj18AJjFnC8Q3uCBKGt+Ky1JM611LX+w3Bfst/WUMZ8F24l/
 qHTRwojze+j+tW1s6Sy7LJZHsP+c330BI/BhU2POm9xngvnb7nx1wyGX/H96gadLpTlP
 4Kg0RVnYqhpsydzSO1qywFB9EyuHeawP2CIUDXDbmT1y046iiC12XqHTvouFaTh7161U
 ibvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD1QCTvdQ92RvTUVzBmMImpSACWmg2zXtF4LjJWihJ0/bPWdRm72JIVfWV5cs+TWYCvAtAi8yyow==@nongnu.org
X-Gm-Message-State: AOJu0YwrPqECNiDEEfFmO6ap10hUIoMm7DiR9lHFTO8wrA6ePaMj1Heg
 QOb1ZnLKRmpfE3mRefd15GQqbYMDcZpd5VmvGO8eOZ5BEVIH38KNj2mMjA==
X-Gm-Gg: ASbGncthCAtJCsgfyMMthri6ok+UMuHeNBcQm22wB1wtTqqGawUgJxJF5WmrCqOetJq
 k7QZC4gFLM9P1OzGr1wxuwhMwvpUbUAGns/uiZ0xBlORvA80ahF1pNbMkXDcJIRB54mqA+ASJNJ
 Php5aW8FAp6QQYsDhtpji4wyJEPamYJRSAXG+xUz7lrxM7qoF5TQGesqlbpcnzV2fkuA5MtrpEI
 DdfVWtwrA2ZQZB56JxSOyl8nPoWSk8R4ozhsYUV/+yAwo59KL1fUmbKYqMmepZBxPeFV0AP0NUj
 1nkeRg==
X-Google-Smtp-Source: AGHT+IE2lYA53utzLTjXEQsS15gOtScxgjGz09dKdolIMw12r+4+ceXY7V+egsNtbVdxZCvi8Jy4FA==
X-Received: by 2002:a17:902:d507:b0:20c:5d5a:af6f with SMTP id
 d9443c01a7336-21500f5a535mr538635ad.10.1732641182055; 
 Tue, 26 Nov 2024 09:13:02 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:13:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 3/6] target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket
Date: Wed, 27 Nov 2024 03:12:32 +1000
Message-ID: <20241126171235.362916-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

The THREAD_SIBLING_FOREACH macro wasn't excluding threads from other
chips. Add chip_index field to the thread state and add a check for the
new field in the macro.

Fixes: b769d4c8f4c6 ("target/ppc: Add initial flags and helpers for SMT support")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
[npiggin: set chip_index for spapr too]
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c       | 2 ++
 hw/ppc/spapr_cpu_core.c | 1 +
 target/ppc/cpu.h        | 7 +++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cbfac49862..e6b02294b1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -322,6 +322,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
+    env->chip_index = pc->chip->chip_id;
+
     if (pc->big_core) {
         /* 2 "small cores" get the same core index for SMT operations */
         env->core_index = core_hwid >> 1;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ada439e831..135f86a622 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -313,6 +313,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
         return NULL;
     }
 
+    env->chip_index = sc->node_id;
     env->core_index = cc->core_id;
 
     cpu->node_id = sc->node_id;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b4f1013b8..2ffac2ed03 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1253,6 +1253,7 @@ struct CPUArchState {
     /* For SMT processors */
     bool has_smt_siblings;
     int core_index;
+    int chip_index;
 
 #if !defined(CONFIG_USER_ONLY)
     /* MMU context, only relevant for full system emulation */
@@ -1412,8 +1413,10 @@ struct CPUArchState {
 
 #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
     CPU_FOREACH(cs_sibling)                                     \
-        if (POWERPC_CPU(cs)->env.core_index ==                  \
-            POWERPC_CPU(cs_sibling)->env.core_index)
+        if ((POWERPC_CPU(cs)->env.chip_index ==                 \
+             POWERPC_CPU(cs_sibling)->env.chip_index) &&        \
+            (POWERPC_CPU(cs)->env.core_index ==                 \
+             POWERPC_CPU(cs_sibling)->env.core_index))
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
 do {                                            \
-- 
2.45.2


