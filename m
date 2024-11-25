Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF8D58D41
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ1U-0002Sq-IS; Mon, 25 Nov 2024 08:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1S-0002Rb-TF; Mon, 25 Nov 2024 08:21:02 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1R-0005oC-DP; Mon, 25 Nov 2024 08:21:02 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71d41932d32so597620a34.0; 
 Mon, 25 Nov 2024 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732540859; x=1733145659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6juxhfs2hjCGJ1x2Pzt+pizv6wKE5nSZ+639faHAX3c=;
 b=LaD3nmubdLVkxbHgwlgPvsymamvous3hJZ4pqxeyqSyneyI58aLJO5WOBfIp3Hl9au
 MKON5bc2vYbtsvkuGB7EoTDqWvVnlaMzdM1E/NnvboXEoqWsMrpCgXy7qeWBN0RT96NA
 I1sKY6gSGKZqVeQXSKYkQkigwyr0B3Zmv9V7tskfF6No5duI8s9KdVaJIqjXirbYuIWd
 5rbV9WoY3ePAX+C2OE7mNj2P5ZHqwzYOraHaSpwYcrIba9G4/ur9i4mkjOkXm+oipFcc
 uoSI6XsWhOzuIFw5r1HMlHQUMfastq2HhGC10iQSgkNhDi2Pu1PWy1XwY4N9HAvpCydj
 D5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732540859; x=1733145659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6juxhfs2hjCGJ1x2Pzt+pizv6wKE5nSZ+639faHAX3c=;
 b=scBbUyeaX0aBwd1lrpEql7QNghQfW7c3RYapvr3gh1DM17/ZOEsy3RJLQt7uJCSzPg
 LseSk8/+g1FXLoJstMpqXtS8aLqVIHDG41cYgk1PZnO4jr4SAVmQiy1/bWxAxYJkYu5s
 fTqGV2mEvn1k2FY7JQDC1/5hC9FzIB6PIab/HPMk//1LwOpLvKAHbca6wGveaPrCTOuc
 tlvT8F1bSvJekZNhYpKoKSBdGfEc49wRPWjS1QzCnsFcAfE5oqbex8Cyy28xZkHKus9T
 e+l8GpVIidq5QItcqKiyKLMb2Q7WwS1bokc8ixRpPo3nwHJq3tCUi9wr7YeQHDKcx6Cn
 atMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBLr3x9u6xHighqyTOEP5uBe5EJEcf5PCMZ4OkCLv+KwHwSsEfc5neQ0yof4ILSkLSUiz67NloIzJz@nongnu.org
X-Gm-Message-State: AOJu0YzjNEePrMWjJXVj6o+hunXQsvTxSHvqrrWsMUpeqflC9EPjpFgY
 RSNgI/L28mmCXCurjhGHl3ct+a3RqvBo7595rLlTtyBOq4s2sUhl/DVM3Q==
X-Gm-Gg: ASbGncsnS6ysHek3KwFrWskKaAds/Ck1e8y93v7jXCtwZsBqqMiP3NDIwbVK8aDuD03
 Lu9Gr8rsWdc5Jryp4mLQEd8S5uAsH1E+xRNH30PRcMSuUDGkxfIRmh50xs3Hl0LLSpLujaNslni
 ZDxNm27vYaT0PrnOJBPAuoj3iJtamvbn5ih3V4V2Ty7QCs+UPRDZ9uXS/bQLAIKb13M30YIpQqJ
 IT4VcEgquvpWTIhEJgeZdNHjUGiJ7zsQulXphqWZjkvhOglDmDuGGsxnkbjSTF4y1x1gDiM79xP
 BoLkww==
X-Google-Smtp-Source: AGHT+IFPgY5P6A2xYcOrc4zqUuKqdl4EpTXv5lj2bM4FRV8zaOWb7GQaHmrAmg7hoGk77HKCu/QdTQ==
X-Received: by 2002:a05:6830:6386:b0:718:2302:7560 with SMTP id
 46e09a7af769-71c04b8ad95mr12446146a34.7.1732540859404; 
 Mon, 25 Nov 2024 05:20:59 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc1e44d5sm5616721a12.32.2024.11.25.05.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 05:20:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 3/4] target/ppc: Fix THREAD_SIBLING_FOREACH for mult-socket
Date: Mon, 25 Nov 2024 23:20:40 +1000
Message-ID: <20241125132042.325734-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125132042.325734-1-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32b.google.com
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

The THREAD_SIBLING_FOREACH macro wasn't excluding threads from
other chips. Add chip_index field to the thread state and add
a check for the new field in the macro.

Fixes: b769d4c8f4c6 ("target/ppc: Add initial flags and helpers for SMT support")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
[npiggin: set chip_index for spapr too]
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        | 7 +++++--
 hw/ppc/pnv_core.c       | 2 ++
 hw/ppc/spapr_cpu_core.c | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

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
-- 
2.45.2


