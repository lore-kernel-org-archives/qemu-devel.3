Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235DC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSV-0001GR-TF; Fri, 02 Feb 2024 00:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSK-0001FM-GL
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:19 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSH-0001k4-S4
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:16 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6daf694b439so1369188b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853072; x=1707457872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voMoBx+DmSX4jwUUR+hNTm+Nb2/rGq7GF3Qy4EBDmqw=;
 b=N05zfNNWmVD7zurq195LhbXtXMayMfUJ1KME1DyFJk8NAjE0Bcm4CDVoX2w2LlCqDQ
 ophazy0uruAH1YBAaj/i2lfSl83tNgKp6c8HALU0RYwkUJisrFgcZcEFi8cfGMwjUVoM
 fG3bnLj+u62FYRjb5FCHyc0yJPYq6vnFBSQSnkAzV7DJbPybNQiUd4mlUi4/4d04KKWi
 AqeaMGtz4yjukf/gJ4/pSxuTUmWgrn1xXx2E74HuBZsPOwHXoR5Iw4vt47s8hok7+I9b
 Ibk61lBedKDRGK0E2TWoDIPa/xRLSjF0fCZOx0NKLH4FYbKKIs3TgC2TYKZulr32Wuyd
 299g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853072; x=1707457872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voMoBx+DmSX4jwUUR+hNTm+Nb2/rGq7GF3Qy4EBDmqw=;
 b=RH6sQN/y0Wruq3MXIizEm5NFewKC3OZSYEgCibUUPnL49nme8o96i8J9Jqd5N/BtiA
 pbb4bWLz0ZHHc4U+QYDjrBUb8eiwThiVV09V/xT3IIzQfMeyDQtLGLOaF4mqM8AW7zsn
 TL673bhlo9MW5dd1Zq1rpijK54Eck31+foxI2ymr2Wd4L331C8bZZMRh8NDMU+feUAF0
 V33SUGCexEIWvCrE5tY3sv7n91td3kOQi4QymJE8+fQTlG5nyTiy57xT1vCf5UIom8wU
 drWEspNd9S3yckrRcwErHa/pOzLiSUchV+X/YgBsHbtpQaBt8RVuRl8j1w/VHzfWorSL
 D5xg==
X-Gm-Message-State: AOJu0Yz2AgK2vvoDKVfB5npsLlYOolyQgALs9nXieZjUbUVP0FfzTyyh
 5qNMLCAMyGc8hmaAXj9HnaWW28J01KrZyAPEK6kXSnts/T6sgPK2AQoGBNobGtqO+U1rCqqENy9
 90h4=
X-Google-Smtp-Source: AGHT+IGKQyGmzzqcCIimDmP8oXYIXHSqdkEPUZ3hmDg2VFDsk2PZ1QTegQpmACAgtEBmHb1pRz7N5A==
X-Received: by 2002:a05:6a00:3d53:b0:6df:f6a2:508d with SMTP id
 lp19-20020a056a003d5300b006dff6a2508dmr1578803pfb.22.1706853071934; 
 Thu, 01 Feb 2024 21:51:11 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/57] target/microblaze: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:53 +1000
Message-Id: <20240202055036.684176-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


