Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A135BC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfx-0006E8-3Q; Thu, 21 Mar 2024 11:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfs-000634-9m
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfq-0001SO-FJ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4146e9e45c8so10115745e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036184; x=1711640984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixdOqShX9KqafF5GwQuaCwGyEwXeRiDzckfnzkN3U94=;
 b=UnID0Ae5MKyY/fyy2cT6RVtXoxlZIiT1eHYasi+L/YHRmrlqdj0FlTcA20DE5NiKkn
 YTpJeDk7uEOjqFQWqcLHdmLRVwFx4OiXzqUjgxxDsIfuqjTMNrkbLVfKokjZp9nZ/Gsg
 ybg60pfuoJK4V9nH1+roAteeBwDReeBVQJ5DDo0LdtZd1x46D0ZDzqdFBDaWBH4OzQPB
 oCiiIWP3ebeTz9A9ut9YeFjwAyxQnGA+V4UEvJhzkwT+MzL45hAkmXKsOHuNup1d1N9V
 iE+NvN0II3+7hSaGUskMbCbs8vX8ygDZVJW9e+Rwb399yyFjNnZ4S952QZOVbUK/TH60
 jlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036184; x=1711640984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixdOqShX9KqafF5GwQuaCwGyEwXeRiDzckfnzkN3U94=;
 b=Rj8mnlCoofCudkCFmMuW09eYcDWJsU1XHcoUz/d2617hvDxChejLJ3xHN25iY/ZCZ9
 snHm3U6xbeiORdS2EasazAzpAEhJvubghg2k82iw4hd7ovwlrM5qyVfQwDpnsu89WesV
 Tmd60mxj1jpPOiBomUCsTYLVRYuBtrxuaZFDWcPt2e182Y5hyBmIQ8z3AYODfsTcmzyv
 NhINQajiyEfjxmVLOURZz5Tn8O41viU/FGVrFaOrcxJjpaNOrV3KvzsyQngpIQmaw4JU
 Ocj/s6rfFI6aweJX4AheKEoEyGSSL7Z8YK9FStuziqkBrOBsUXLir26NMnnhJXmM1WD2
 ltEA==
X-Gm-Message-State: AOJu0YzsqLy5fxB6L9HbqkGo31ENoQtdFSZwkQey3h4N/PoMXIAzUpOL
 aAc5ol3ohEzENUReoBU4srOBHYrMXVZEuS/KC48SWhKioY8YtwBVQOb9e6OhFjAQAL45vY43cVX
 8ObU=
X-Google-Smtp-Source: AGHT+IH1e8ZCLVrNBKv4WDP5qrb8VyO1+oOpzNQpMrOCWQd/FkIrDa1qMU/yHh886xDnLuyjt3Sv0A==
X-Received: by 2002:a5d:52d1:0:b0:33e:6a81:d8b9 with SMTP id
 r17-20020a5d52d1000000b0033e6a81d8b9mr2590546wrv.20.1711036184109; 
 Thu, 21 Mar 2024 08:49:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 o9-20020adfe809000000b0033ec6ebf878sm17419893wrm.93.2024.03.21.08.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 08/21] target/microblaze: Prefix MMU API with 'mb_'
Date: Thu, 21 Mar 2024 16:48:24 +0100
Message-ID: <20240321154838.95771-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

MicroBlaze MMU API is exposed in "mmu.h". In order to avoid
name clashing with other targets, prefix the API with 'mb_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/mmu.h       | 10 +++++-----
 target/microblaze/cpu.c       |  2 +-
 target/microblaze/helper.c    |  4 ++--
 target/microblaze/mmu.c       | 14 +++++++-------
 target/microblaze/op_helper.c |  4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52..5b51e0a9c6 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -85,10 +85,10 @@ typedef struct {
     } err;
 } MicroBlazeMMULookup;
 
-unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
-uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
-void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
-void mmu_init(MicroBlazeMMU *mmu);
+unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
+                              target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+uint32_t mb_mmu_read(CPUMBState *env, bool ea, uint32_t rn);
+void mb_mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
+void mb_mmu_init(MicroBlazeMMU *mmu);
 
 #endif
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 96c2b71f7f..59bfb5c45d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -205,7 +205,7 @@ static void mb_cpu_reset_hold(Object *obj)
     mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM);
 #else
     mb_cpu_write_msr(env, 0);
-    mmu_init(&env->mmu);
+    mb_mmu_init(&env->mmu);
 #endif
 }
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index d25c9eb4d3..961687bae7 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -57,7 +57,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return true;
     }
 
-    hit = mmu_translate(cpu, &lu, address, access_type, mmu_idx);
+    hit = mb_mmu_translate(cpu, &lu, address, access_type, mmu_idx);
     if (likely(hit)) {
         uint32_t vaddr = address & TARGET_PAGE_MASK;
         uint32_t paddr = lu.paddr + vaddr - lu.vaddr;
@@ -238,7 +238,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
 
     if (mmu_idx != MMU_NOMMU_IDX) {
-        hit = mmu_translate(cpu, &lu, addr, 0, 0);
+        hit = mb_mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
             vaddr = addr & TARGET_PAGE_MASK;
             paddr = lu.paddr + vaddr - lu.vaddr;
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 234006634e..5fb8ee8418 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -74,8 +74,8 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 }
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
-unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
+                              target_ulong vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
@@ -175,7 +175,7 @@ done:
 }
 
 /* Writes/reads to the MMU's special regs end up here.  */
-uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
+uint32_t mb_mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 {
     MicroBlazeCPU *cpu = env_archcpu(env);
     unsigned int i;
@@ -228,7 +228,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
     return r;
 }
 
-void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
+void mb_mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
 {
     MicroBlazeCPU *cpu = env_archcpu(env);
     uint64_t tmp64;
@@ -304,8 +304,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
                 return;
             }
 
-            hit = mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
-                                0, cpu_mmu_index(env_cpu(env), false));
+            hit = mb_mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
+                                   0, cpu_mmu_index(env_cpu(env), false));
             if (hit) {
                 env->mmu.regs[MMU_R_TLBX] = lu.idx;
             } else {
@@ -319,7 +319,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
    }
 }
 
-void mmu_init(MicroBlazeMMU *mmu)
+void mb_mmu_init(MicroBlazeMMU *mmu)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(mmu->regs); i++) {
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f6378030b7..58475a3af5 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -386,12 +386,12 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
 /* Writes/reads to the MMU's special regs end up here.  */
 uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
-    return mmu_read(env, ext, rn);
+    return mb_mmu_read(env, ext, rn);
 }
 
 void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
 {
-    mmu_write(env, ext, rn, v);
+    mb_mmu_write(env, ext, rn, v);
 }
 
 void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
-- 
2.41.0


