Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9CAC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6D-0005r4-PN; Mon, 29 Jan 2024 18:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb64-0005av-7F
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:24 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb62-00054Y-33
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d746856d85so16089695ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571080; x=1707175880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRmglClgoVHSDx5STL3QfC7K3ahzi83m4KSgoX1Lwpc=;
 b=B8gQYTaCP356ulGZyS3jFeFXnxPJxFM9BMyeGr5c4sYzq0Y5Rn/w3BeRDdAoowfjWk
 s0hOugqtnEj4yNc1or9hsvUA2D97REMoT7YVusnvn8tZuL0jw9FWvt3nVSa0RKAZHeX6
 f0LcHJhin4/pnBattA5UAGsNtqwNUHXWf0h8cElMMxbaQkWeccrbRp31+CZdiE1DA102
 Qi/sbgUHs5Ji0CzwThgRu8zzAfOSh41bnbmM/hcWvLeMKB3MyhWHQOCtnrA2PQlffaOV
 JkDJwzRMWLuNSjd8Ku4XHwTDt9IUwmvuRoQaRVz0KSsM5RmikLl43NSKHBCLZv7sdeID
 QjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571080; x=1707175880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRmglClgoVHSDx5STL3QfC7K3ahzi83m4KSgoX1Lwpc=;
 b=h2UVCnRm+HfoADwNSXe4h9Qqja3Xs4Dlo2ytnbrhjFFhSEAmeuv9Nzie/b0o8U61Zu
 YEzJp6XAuwXuO1jUV+Nqw9vGT8uYaf1s9EaATEIGpFjNcTM8om7CtbNpKs/4MroDNJku
 aaF6muXqTS8apZpoqXSWpUuOi+5sc2JDyoGsEUuz0HcF0e12EsTQvL/DRXUVw8SkYnD5
 RmokYHkhuOHCvXNTm8xihn1J6AANrMqEWoFR8cL9GDO7s1qfW9inytHaLnCebuc+THjg
 RJJb3CFHBYPpdXwoEPiA+AMvUs8Wn+vN+cMrWloNl1j/ppAgh5YqKkYnmVd8evBJYH+4
 oqzg==
X-Gm-Message-State: AOJu0YwXMB4r3H1d06YHnlKiPMF5aM/ymrfROtFS/tSLYPleljbNtm83
 sv/JFjtccvSjeqGEuo4uBp06OWBbPJOU0ebn/KIxMJ4PLC2ZUVp8jXbDKtUW7ei6G+md1DmfwH8
 nuAg=
X-Google-Smtp-Source: AGHT+IEGxNrvkfLBjUIlgKS13paI38/LZglnh0ErvRhE32K/1eEJPprdtwlBH918W5uh2iE6Ab+QKw==
X-Received: by 2002:a17:902:b70a:b0:1d4:e237:2c3f with SMTP id
 d10-20020a170902b70a00b001d4e2372c3fmr3036959pls.28.1706571080205; 
 Mon, 29 Jan 2024 15:31:20 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 14/33] target/microblaze: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:24 +1000
Message-Id: <20240129233043.34558-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 13 ++-----------
 target/microblaze/cpu.c | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b5374365f5..90ab796de9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -434,19 +434,10 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
+int mb_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
 {
-    MicroBlazeCPU *cpu = env_archcpu(env);
-
-    /* Are we in nommu mode?.  */
-    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
-        return MMU_NOMMU_IDX;
-    }
-
-    if (env->msr & MSR_UM) {
-        return MMU_USER_IDX;
-    }
-    return MMU_KERNEL_IDX;
+    return mb_cpu_mmu_index(env_cpu(env), ifetch);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2318ad7013..6dad11905b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -118,6 +118,22 @@ static bool mb_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUMBState *env = cpu_env(cs);
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
+    /* Are we in nommu mode?.  */
+    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->msr & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
+}
+
 #ifndef CONFIG_USER_ONLY
 static void mb_cpu_ns_axi_dp(void *opaque, int irq, int level)
 {
@@ -415,7 +431,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
-
+    cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.34.1


