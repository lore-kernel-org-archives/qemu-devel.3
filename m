Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EBC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo0-0006lz-5q; Wed, 12 Feb 2025 17:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKny-0006ko-92
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:02 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnv-0004Rx-Pe
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:01 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so379610a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397718; x=1740002518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvOAkVfZMQwTxcmtw611EOoijp2EWfBDBUZbU+MYgKI=;
 b=sxcqB+IzwLkpkHSnHH8Y3h6MW4CsADl5Vk4QAoONftrs8zFwJd8djlETXm5wES9xhM
 nRAiE1JBEy1BH2yzNDrd/vfDHI4XhMFxiCzQdlTBj2SW+NmXkgZyN9J8l70d0jsEVwlT
 iAVtiAvGLruupCxrI+LYnrUY9nxu3bwfivbtQo6OCRYCJeeYuKVHfHuX+WeV7bU0YyFP
 61d7U6Y3KtcO2amrGkUQJydAuoHu3eq0BO+HXhRTGvsZDoWkd4pbrtAg/ZtOWdVz/0us
 fkhNqyMvNXgXBBvYwXTKpTIj0TyjybUdpLf5EQU+GbLR0Tw+2gf03mUqTFvpGPqNv63S
 RymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397718; x=1740002518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvOAkVfZMQwTxcmtw611EOoijp2EWfBDBUZbU+MYgKI=;
 b=o24bqifQEo+FHxuxZaHS00ERN1Y7RRg5A3hlw+cQI74yzFo6+h9ywDYjC4X95IoBqC
 mQd9nAALmXSgnAOJeAL9wSHz2ZsNPPzZl3gKl0KPI8D6sNhWsXn6DlFJR4lO9XCihqru
 mRdOSGtl9wmiYfzYSNGg36a7ZeOUldXQAvC2Djfuu9WxRphuhvHlw4X4JuQIySrFb0Xt
 rf3CZxs42f54moOMDNKnOgyWIs3BQqDoW8+2FbsN/B9emGy6lRKdIIQjZRBfcV3VcDri
 IoGAfSDDP2ICFTiruMOpdWZm2XHNQjXnnICKeeDaYnj1yzy8Meu007c5/HUKMrtkipT7
 Ingg==
X-Gm-Message-State: AOJu0YzooZm7R4Ke+KZh08a2Xfvu+hHYgnS2SzfZHyLogTx3mvE/mteI
 IdS7LT4scXvFG7KagkvnLdpQfVYLOWha9NyEWPxMwaGVw89kvuK++8+1jagPf4efB7tvYeClEbG
 W
X-Gm-Gg: ASbGncu/gXkALbLG3OpVXfIDxeaEH0LEYOsSQKwW04Zh2uVe2KfImyVvGF9NN8jLtS1
 0CKMHHIh5EDyxF+TWaCQerrGt+rguZU942tqyiaqjXVvJL8hPGZsRbyaxV96H4E5ty38xiIyKqu
 +Y/OSGhaIKb/HWxYhBi2rImXPsgVw1e9JdObzszHPIJ0z7LyhByidmgfvly11UAFQ6FeAvZm+XC
 HtyDadGj17sBprdfZSFrpVETzjIVWhxvmVacopaotvpuySp4HFey18PZMxN1cHhQY4vsPeGbDSN
 Q5A5XPGM9BYIlp94yu313Wqg8ciwF0oJQlLuobHlHcGDk14=
X-Google-Smtp-Source: AGHT+IE/ET8zmMFq7C1KXsLy2mZG1wUQMPbXoTQjFvvZWonhB6k4AmNZN1Ywmuuwur38Bp0Pg+ixGg==
X-Received: by 2002:a17:90b:1913:b0:2fa:20f4:d27f with SMTP id
 98e67ed59e1d1-2fbf91358d2mr5471672a91.32.1739397718327; 
 Wed, 12 Feb 2025 14:01:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:01:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 2/9] target/microblaze: Split out
 mb_transaction_failed_internal
Date: Wed, 12 Feb 2025 14:01:48 -0800
Message-ID: <20250212220155.1147144-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Use an explicit 64-bit type for the address to store in EAR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 70 +++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f6378030b7..6019c5b2eb 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -394,38 +394,52 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
     mmu_write(env, ext, rn, v);
 }
 
+static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
+                                           uint64_t addr, unsigned size,
+                                           MMUAccessType access_type,
+                                           uintptr_t retaddr)
+{
+    CPUMBState *env = cpu_env(cs);
+    MicroBlazeCPU *cpu = env_archcpu(env);
+    const char *access_name = "INVALID";
+    bool take = env->msr & MSR_EE;
+    uint32_t esr = ESR_EC_DATA_BUS;
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        access_name = "INST_FETCH";
+        esr = ESR_EC_INSN_BUS;
+        take &= cpu->cfg.iopb_bus_exception;
+        break;
+    case MMU_DATA_LOAD:
+        access_name = "DATA_LOAD";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    case MMU_DATA_STORE:
+        access_name = "DATA_STORE";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "Transaction failed: addr 0x%" PRIx64
+                  "physaddr 0x" HWADDR_FMT_plx " size %d access-type %s (%s)\n",
+                  addr, physaddr, size, access_name,
+                  take ? "TAKEN" : "DROPPED");
+
+    if (take) {
+        env->esr = esr;
+        env->ear = addr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+}
+
 void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                unsigned size, MMUAccessType access_type,
                                int mmu_idx, MemTxAttrs attrs,
                                MemTxResult response, uintptr_t retaddr)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
-
-    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
-                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
-                  addr, physaddr, size,
-                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
-                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
-
-    if (!(env->msr & MSR_EE)) {
-        return;
-    }
-
-    if (access_type == MMU_INST_FETCH) {
-        if (!cpu->cfg.iopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_INSN_BUS;
-    } else {
-        if (!cpu->cfg.dopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_DATA_BUS;
-    }
-
-    env->ear = addr;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, retaddr);
+    mb_transaction_failed_internal(cs, physaddr, addr, size,
+                                   access_type, retaddr);
 }
 #endif
-- 
2.43.0


