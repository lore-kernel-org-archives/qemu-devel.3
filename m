Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BEBCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KlH-0007KQ-4z; Thu, 02 Oct 2025 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kl5-0007JL-SP
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kko-0000Dg-G4
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so11369115e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759417069; x=1760021869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=487RP0R+DawU3cowpH1ljYzt+o5Cuwu3G1Z8g9QHYus=;
 b=OXSZoz5OQcKAwoqbWXZ6NpcfnUPg6+WSKa97EsrKnmc+/F7eB8cgh4XTy26GkpfZ4Y
 8ue+OkJ+//vA+xIHuQnE7VpAV0PkJabt+l0D0Qh7pJBSoSfIGfsfyEHBfYcuIyObkoIM
 c6w0iWYnPUnvcFMMk5GS7+476Raszzy8xr9WxxGIBDn59CqdUGvbYnWx1Q6FPUF9K/Ym
 CrVDoLzOM5P07/uiwGllfWQ5YMlF27q3EzZyTLeig/+2kt0GZJIg/F+rBjy7NLTVP4Uc
 QLKE+OxGbsSAdPkaK1KY4C1jwojXx2b8ityICWXH2SGtBTg33yyGPTD6U6mg7ifs19La
 t0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417069; x=1760021869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=487RP0R+DawU3cowpH1ljYzt+o5Cuwu3G1Z8g9QHYus=;
 b=ThEjoi2um4sOni95j4UVue60M9BlhyF0hgoAEVmLwt8wkX3PZRmBd0PpCLilt4lubn
 OgK9E5MbNE43uA2N0OJIvbyZxRJx8SKTGAmHkKUqs5TQBehCdipFmfMZKE71OTQmGkp7
 5caYOb8S0MGzOBGQ1KwiNPX7+tpwcsbP90YUvfze+nGUm6jJJPkDkWJ/k4WW5fGNFBbu
 wi/VFbaUKof+A7Dray5RUl+lXGTad3T/Chyh3sahFO36qnJsarM89XHNpf7XvrLdyAPN
 fbWJgHcw52hzJrRrtszhaDpbx6oT75l9G5XD9sa/b/AD5uCKynXegpMQW0m4uKUSYz5J
 nSCw==
X-Gm-Message-State: AOJu0YzTetx9Twd93t8z0txCUf7yAZIJ4LhnwQnPMboz8Zatj0DQnXNC
 nL75nYZY+xjXx5z+/iX+R2G8qF4Tx0tZADG3bdPrTQdHSYgdQLqQI8Ucq4f3bJby/p3c0EObXWK
 pcIaPgpRK/A==
X-Gm-Gg: ASbGncs5T9fuCsiXzNZG/8DupuOwtnCCE6sjzNRfg4L4b2P/O+UABtXVKyUmVTFCqve
 QDKuNxSWzZnrgE7cHOYJ4D3cg8XNuau/j2Z7lZEZJOzb2ffo02aNXjHO460YPSGUmsBCdMtzhCu
 J0cL8LO35jYslAWKWxWjQJHJc3ekW6N7ghj+CzmAG5b0ah8vkaw1OUTwnsmctrdwlARrkFz+29L
 d1jjLK7pcToe/DqcpJwiTMhnoYlLVdPF6q8nDg9WG0y6Lff6kBDYSN5sMhD5a+p7bJSvpxWdhAA
 1w6qL+S7/WKm6m2eis+3bl9ymz23MTR+CfMqIj3NmcIyGRMztpEwDeawiESZnLXdU2Pl8WIFSLM
 Gp4vmioqLLCuDHfvFWIQgMeGogyagE37FJqhbIWyAsmQ+62SxvfDudE3nVVmXi4PB6OHLqSMaeh
 1MCg16WXhqSKYq06ThHEEi9vQ2
X-Google-Smtp-Source: AGHT+IHhaoaDmiHVN4FNJv30tpvddcfE1r9Bn2+NXIH4AVmUw1py2n+Hz8AQhfurrAh2ShkbjjyIQA==
X-Received: by 2002:a05:600c:5304:b0:46e:450d:e037 with SMTP id
 5b1f17b1804b1-46e6125d0fdmr63447485e9.5.1759417068833; 
 Thu, 02 Oct 2025 07:57:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a4161bsm92753965e9.16.2025.10.02.07.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 07:57:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] target/i386/monitor: Propagate CPU address space to 'info
 mem' handlers
Date: Thu,  2 Oct 2025 16:57:36 +0200
Message-ID: <20251002145742.75624-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002145742.75624-1-philmd@linaro.org>
References: <20251002145742.75624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


