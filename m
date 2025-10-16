Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03661CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PdY-0001KF-Jr; Thu, 16 Oct 2025 11:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PdT-0001IC-Rs
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PdP-0002Gu-8o
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4710683a644so8728295e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627475; x=1761232275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZUSPdwyyhjSMGbZ6how7fllA/2QRSgUHL74b3sTI49U=;
 b=pkRz3SKAcgNIQqueDkpnsejpcQRpy3m5A/iaLEqDS8YZY0vT8mpf09BAAmPvda0Zv8
 Xnlyt40qHNP32YPrA+XT3MhAI+VK82l0H/rCb8qFXp6A452nRnxpDogYCnnHf/sgTZfB
 KZMJlN0dnvWNjqdhfiNPssAOVswH/R/rb7X/9o7vTvJKF6IXEgLGUMNn9O1FIafJivDF
 uJxuWsiL3DjDKg0jB1ewnGtGk8VF1iLwxZDCu43DyDzbcwXARi9SrtYSZmFevyU51D7V
 CW164QPG92nCngGgJS4y17MG6HBWgB+yLBQx5dxmwSuMgVEqJZBaQ61Unl6nIgx7pTHy
 lmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627475; x=1761232275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUSPdwyyhjSMGbZ6how7fllA/2QRSgUHL74b3sTI49U=;
 b=pGBGAkziJDAKBH0BKl7uhaIJ1tTqn3UXD6rtDW/1yXDMz0Ti1rfPmIoaykbb7HfziN
 gFyGT64iPCKvBkNPXBxXEYKzN9Xi8aWOMBP0f+G/kLvQy66Ch5Jh1Am90P5xPkP06eif
 C6zm7N90Eidm3TJ0VuHSNoh53UkyAE3lpHvWIWjFCM5KNd44/LmmoyuBF3FJrBEekeHj
 eYdpVjcVPwwbJwIM/8m14BzONvMALU6lSUQekYhO/Fa9KX72yvMiB5F4vJtpM2j3lUUg
 0rWisgGhlCI6f6XpQZjxp79DlA/zlnBfKRY1JPdFQXPukCQPbCvpYZFbui7bjplu3Bxq
 14rQ==
X-Gm-Message-State: AOJu0YyzrfdUXo3uq+XF0WZ2+VmuC9KfD13vSp9RuIceVEkbm6aeyIb4
 gTmvTqDeb74oeGGONPGSU+F0xh7yiMM8Nl3AYpakJq78pmOaZNB1KNjTF52hJyL/rNYSX+nHxyf
 kC7jMw2c=
X-Gm-Gg: ASbGncu6l7RRVqhKEYuNFrUhDvofV4T87Si6/1DiibGRS76ztontsObeF4N8wry49g2
 wIUfax3sCqfDa8j40Ib/1Qzs5FUL+6U4GLa6ol0LZGcANXcBPm33ryu0jh8RUoA/U1dvdtTJFd3
 mpZ03gXzqr8VyV1lJ4uDH0vA1GJNFGbXIQyRkCzBF9bPQlmreDmaeK24cfGYBsu8SvilNqaweJ1
 BKAniXl3k8K/qsHxT2sIxx3bn3Vla5TGn/kPR7t/otQp6rPBNNRquK7vC0mnDvgoU0hJmqoquiX
 G1FnNkjljnWSynVp5cI1pNeuY50BTFTwdvwqbHkXbCthD40M/3AFGpxGb/hks+ExR9v6S20bzt3
 beWQN6vo8Aunq2al3MsLe9ytAuPEIjTHFx4T3wxtN+5C+np3QDocH6s6ZNoC+X3M9JY7IvH7td/
 nIMthfLuxFbWXah84sSne97B9U4UK8TqqQIprToBeUVLqdPy3cnA==
X-Google-Smtp-Source: AGHT+IFzRpGQ80YVkSLTE4SBs7BRRlK2E7Do20EXwBCX8HTZswABc36RHrBrJ4ETf0udZ33zT+Wkqw==
X-Received: by 2002:a05:600c:6095:b0:45d:dbf0:4831 with SMTP id
 5b1f17b1804b1-47117152c2cmr5400965e9.0.1760627474899; 
 Thu, 16 Oct 2025 08:11:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fb279857sm6481352f8f.20.2025.10.16.08.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 08:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/79] target/i386/monitor: Propagate CPU address space to
 'info mem' handlers
Date: Thu, 16 Oct 2025 17:11:04 +0200
Message-ID: <20251016151108.18442-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016151108.18442-1-philmd@linaro.org>
References: <20251016151108.18442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We want to replace the cpu_physical_memory_read() calls by
address_space_read() equivalents. Since the latter requires
an address space, and these commands are run in the context
of a vCPU, propagate its first address space. Next commit
will do the replacements.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251002145742.75624-2-philmd@linaro.org>
---
 target/i386/monitor.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3c9b6ca62f2..7e7854e6c1b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -68,7 +68,7 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
+static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     unsigned int l1, l2;
     uint32_t pgd, pde, pte;
@@ -96,7 +96,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
     }
 }
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
+static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     unsigned int l1, l2, l3;
     uint64_t pdpe, pde, pte;
@@ -136,7 +136,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
 }
 
 #ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
+static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
         uint64_t l0, uint64_t pml4_addr)
 {
     uint64_t l1, l2, l3, l4;
@@ -197,7 +197,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
     }
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     uint64_t l0;
     uint64_t pml5e;
@@ -208,7 +208,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
         cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
         pml5e = le64_to_cpu(pml5e);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
         }
     }
 }
@@ -217,6 +217,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
+    AddressSpace *as;
 
     env = mon_get_cpu_env(mon);
     if (!env) {
@@ -228,21 +229,22 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "PG disabled\n");
         return;
     }
+    as = cpu_get_address_space(env_cpu(env), X86ASIdx_MEM);
     if (env->cr[4] & CR4_PAE_MASK) {
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(mon, env);
+                tlb_info_la57(mon, env, as);
             } else {
-                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
             }
         } else
 #endif
         {
-            tlb_info_pae32(mon, env);
+            tlb_info_pae32(mon, env, as);
         }
     } else {
-        tlb_info_32(mon, env);
+        tlb_info_32(mon, env, as);
     }
 }
 
@@ -271,7 +273,7 @@ static void mem_print(Monitor *mon, CPUArchState *env,
     }
 }
 
-static void mem_info_32(Monitor *mon, CPUArchState *env)
+static void mem_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     unsigned int l1, l2;
     int prot, last_prot;
@@ -312,7 +314,7 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
     mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
 }
 
-static void mem_info_pae32(Monitor *mon, CPUArchState *env)
+static void mem_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     unsigned int l1, l2, l3;
     int prot, last_prot;
@@ -369,7 +371,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
 
 
 #ifdef TARGET_X86_64
-static void mem_info_la48(Monitor *mon, CPUArchState *env)
+static void mem_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     int prot, last_prot;
     uint64_t l1, l2, l3, l4;
@@ -449,7 +451,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
 }
 
-static void mem_info_la57(Monitor *mon, CPUArchState *env)
+static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
 {
     int prot, last_prot;
     uint64_t l0, l1, l2, l3, l4;
@@ -545,6 +547,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 void hmp_info_mem(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
+    AddressSpace *as;
 
     env = mon_get_cpu_env(mon);
     if (!env) {
@@ -556,21 +559,22 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "PG disabled\n");
         return;
     }
+    as = cpu_get_address_space(env_cpu(env), X86ASIdx_MEM);
     if (env->cr[4] & CR4_PAE_MASK) {
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                mem_info_la57(mon, env);
+                mem_info_la57(mon, env, as);
             } else {
-                mem_info_la48(mon, env);
+                mem_info_la48(mon, env, as);
             }
         } else
 #endif
         {
-            mem_info_pae32(mon, env);
+            mem_info_pae32(mon, env, as);
         }
     } else {
-        mem_info_32(mon, env);
+        mem_info_32(mon, env, as);
     }
 }
 
-- 
2.51.0


