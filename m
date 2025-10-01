Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA15ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQS-0001L7-LE; Wed, 01 Oct 2025 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQ8-00016z-WC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPA-0000g2-Tu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso45788805e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331158; x=1759935958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZDMg8yz9ap9OumTYn6OrEsRwS7EEn+Yq0e/iZiL7js=;
 b=l/IeugX2vv5MdO7zskiLAGkXlqu8K+D1pJhRdtsXVr7bQkIL3W3n8OHTSHcohPjhf2
 pFeargWHQXL8USRCigp3rZ7IziA8qXLODD5FU/n5hqxUMcpndOfp0uu+LKaJSDcKOnzO
 EU/hRJojnv4UPo7LT4nnlldXqzq5gnOuW/0TuEdTBNaERHIDcyhOcUayAvwQULmo/EvK
 8LjEzczqYXln40jCb6ah5Uy06cNixZc84ZR2D7kNjAgOYR/YpB3ST2xCf0hanfmvxBPk
 crfX7xxACj4MHtfbviZ3K9ThTKjG0HNHT0xBoaJ6DpeAXRyv3S3NEe0oMRPZlrbviHbZ
 aOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331158; x=1759935958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZDMg8yz9ap9OumTYn6OrEsRwS7EEn+Yq0e/iZiL7js=;
 b=lDdgnyuXQvEpxw5z+gJXlwndDc/RMe6gC+molNTY+bwHkDJknwVXO1GJtfJx5FEAoJ
 c2ULX1LVCin+T2ALClRt4YP5p1oWKZ4qwYLjlYww8iEXQBUyxTwBo8OLlCGP3gm64BSb
 RxIlwPypIRm5ftp51pxYaTCjdvfAujAKkcpYlmmffr3WyliiLUhWBT+t8Y38NbuczGTZ
 +ib0lS7eQqGQxOAuc2xUyhPqoSTIUJAL5BqPCO+rjZS6T6llRiWJT3RrNqDjfq1hLSqy
 pOs/ziTlXtrlwaNBhQPylmBUr80uYwAQBbfmQLSsTAC8AMORsj5OY/wEmBnYjZvX1b18
 Wtug==
X-Gm-Message-State: AOJu0YwZ6mBOJqmfBJVhrteD6F0VNtQ1fjk8GpDhX1vpNdF3c20jJTyc
 UNPU4DRN4DTmuNRGgenGTib7hgE8B9ld5NQAibSpNMnPp33oiZ7izL5x7fcdYhn4Z+LL8akBLwV
 CkNIQ/79kvQ==
X-Gm-Gg: ASbGncsxVVI63VVP91FVvN2lXJ44mdnG6auH/gmqzfEM5ynU6pkH4vllvqBCZXLyjRC
 TeMLfmlgu3mVaFcXyVMBeHFnE+YMOyZiffdQ4WFQIM8ZrH7aDY9DUuiKDbGXjIIExTL/z96A6y/
 gqkA+71gK4bR+qSEPXC/ymtnXnivdxwqmmKdRtudcky/FrwwmDObIiplNwkkucZiOaDdtnOuv6t
 8fy7tNS3k56HgnHRQfXrm0p0G82Pxea8et6OqtLP22MsZCpKM3bLVOQY2pX8xezFDbZgRv5i8xG
 S7ZTPR2w8c24gZpK2Z4A3deA0BykNBPwupfrihv5RkzLnrfr10D36VtWIK+QBDzQ0wBUQA7FQQE
 9OiPBRu9i9s0+YsYDdHBVAaxpQNGqaynb9hvsj4WvXci8576jmZxZvJgNZE4eb8ulaMlJ/NeSLF
 V4gU91sUesCsi0LP8F0axW
X-Google-Smtp-Source: AGHT+IESajM98h7Ak1tY0MCnBMGr+gpyX2SKXeZl9gH2ut0A/a003ZIMHK8a6IQpnO45kpRT3UEyIg==
X-Received: by 2002:a05:600c:34cb:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46e613dd3cemr36736665e9.36.1759331157660; 
 Wed, 01 Oct 2025 08:05:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602dfdsm27281395f8f.33.2025.10.01.08.05.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 05/22] hw/ppc: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:10 +0200
Message-ID: <20251001150529.14122-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/spapr_xive.c  |  5 ++--
 hw/ppc/pegasos2.c     |  2 +-
 hw/ppc/spapr.c        | 12 +++++-----
 hw/ppc/spapr_hcall.c  | 55 +++++++++++++++++++++++--------------------
 hw/ppc/spapr_iommu.c  |  4 ++--
 hw/ppc/spapr_nested.c | 43 ++++++++++++++++++---------------
 6 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e393f5dcdcc..b68961e1bf5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1391,6 +1391,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
     }
 
     if (qsize) {
+        AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
         hwaddr plen = 1 << qsize;
         void *eq;
 
@@ -1398,14 +1399,14 @@ static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
          * Validate the guest EQ. We should also check that the queue
          * has been zeroed by the OS.
          */
-        eq = address_space_map(CPU(cpu)->as, qpage, &plen, true,
+        eq = address_space_map(as, qpage, &plen, true,
                                MEMTXATTRS_UNSPECIFIED);
         if (plen != 1 << qsize) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to map EQ @0x%"
                           HWADDR_PRIx "\n", qpage);
             return H_P4;
         }
-        address_space_unmap(CPU(cpu)->as, eq, plen, true, plen);
+        address_space_unmap(as, eq, plen, true, plen);
     }
 
     /* "target" should have been validated above */
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index e15cf964278..86c6a73236b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -451,7 +451,7 @@ enum pegasos2_rtas_tokens {
 static target_ulong pegasos2_rtas(PowerPCCPU *cpu, Pegasos2MachineState *pm,
                                   target_ulong args_real)
 {
-    AddressSpace *as = CPU(cpu)->as;
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     uint32_t token = ldl_be_phys(as, args_real);
     uint32_t nargs = ldl_be_phys(as, args_real + 4);
     uint32_t nrets = ldl_be_phys(as, args_real + 8);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 15d09ef9618..b8aa0352ab2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4550,10 +4550,10 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 
     spapr_cpu->prod = false;
     if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
+        AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
         uint32_t dispatch;
 
-        dispatch = ldl_be_phys(cs->as,
+        dispatch = ldl_be_phys(as,
                                spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
         dispatch++;
         if ((dispatch & 1) != 0) {
@@ -4562,7 +4562,7 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
                           "dispatched partition %u, correcting.\n", dispatch);
             dispatch++;
         }
-        stl_be_phys(cs->as,
+        stl_be_phys(as,
                     spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
     }
 }
@@ -4572,10 +4572,10 @@ static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
     if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
         uint32_t dispatch;
 
-        dispatch = ldl_be_phys(cs->as,
+        dispatch = ldl_be_phys(as,
                                spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
         dispatch++;
         if ((dispatch & 1) != 1) {
@@ -4584,7 +4584,7 @@ static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
                           "preempted partition %u, correcting.\n", dispatch);
             dispatch++;
         }
-        stl_be_phys(cs->as,
+        stl_be_phys(as,
                     spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
     }
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8c1e0a4817b..be83b5591b5 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -321,7 +321,7 @@ unmap_out:
 
 static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     uint16_t size;
@@ -337,7 +337,7 @@ static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
     }
     /* FIXME: bounds check the address */
 
-    size = lduw_be_phys(cs->as, vpa + 0x4);
+    size = lduw_be_phys(as, vpa + 0x4);
 
     if (size < VPA_MIN_SIZE) {
         return H_PARAMETER;
@@ -350,9 +350,9 @@ static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 
     spapr_cpu->vpa_addr = vpa;
 
-    tmp = ldub_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET);
+    tmp = ldub_phys(as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET);
     tmp |= VPA_SHARED_PROC_VAL;
-    stb_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
+    stb_phys(as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
 
     return H_SUCCESS;
 }
@@ -375,6 +375,7 @@ static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
 
 static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     uint32_t size;
 
@@ -383,7 +384,7 @@ static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
         return H_HARDWARE;
     }
 
-    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
+    size = ldl_be_phys(as, addr + 0x4);
     if (size < 0x8) {
         return H_PARAMETER;
     }
@@ -413,6 +414,7 @@ static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
 
 static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     uint32_t size;
 
@@ -421,7 +423,7 @@ static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
         return H_HARDWARE;
     }
 
-    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
+    size = ldl_be_phys(as, addr + 0x4);
 
     if (size < 48) {
         return H_PARAMETER;
@@ -579,6 +581,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_long target = args[0];
     uint32_t dispatch = args[1];
     CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     SpaprCpuState *spapr_cpu;
 
     assert(tcg_enabled()); /* KVM will have handled this */
@@ -608,7 +611,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
             return H_SUCCESS;
         }
 
-        target_dispatch = ldl_be_phys(cs->as,
+        target_dispatch = ldl_be_phys(as,
                                   spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
         if (target_dispatch != dispatch) {
             return H_SUCCESS;
@@ -667,22 +670,22 @@ static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
 static target_ulong h_logical_load(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     target_ulong size = args[0];
     target_ulong addr = args[1];
 
     switch (size) {
     case 1:
-        args[0] = ldub_phys(cs->as, addr);
+        args[0] = ldub_phys(as, addr);
         return H_SUCCESS;
     case 2:
-        args[0] = lduw_phys(cs->as, addr);
+        args[0] = lduw_phys(as, addr);
         return H_SUCCESS;
     case 4:
-        args[0] = ldl_phys(cs->as, addr);
+        args[0] = ldl_phys(as, addr);
         return H_SUCCESS;
     case 8:
-        args[0] = ldq_phys(cs->as, addr);
+        args[0] = ldq_phys(as, addr);
         return H_SUCCESS;
     }
     return H_PARAMETER;
@@ -691,7 +694,7 @@ static target_ulong h_logical_load(PowerPCCPU *cpu, SpaprMachineState *spapr,
 static target_ulong h_logical_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                     target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
 
     target_ulong size = args[0];
     target_ulong addr = args[1];
@@ -699,16 +702,16 @@ static target_ulong h_logical_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     switch (size) {
     case 1:
-        stb_phys(cs->as, addr, val);
+        stb_phys(as, addr, val);
         return H_SUCCESS;
     case 2:
-        stw_phys(cs->as, addr, val);
+        stw_phys(as, addr, val);
         return H_SUCCESS;
     case 4:
-        stl_phys(cs->as, addr, val);
+        stl_phys(as, addr, val);
         return H_SUCCESS;
     case 8:
-        stq_phys(cs->as, addr, val);
+        stq_phys(as, addr, val);
         return H_SUCCESS;
     }
     return H_PARAMETER;
@@ -717,7 +720,7 @@ static target_ulong h_logical_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
 static target_ulong h_logical_memop(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                     target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
 
     target_ulong dst   = args[0]; /* Destination address */
     target_ulong src   = args[1]; /* Source address */
@@ -745,16 +748,16 @@ static target_ulong h_logical_memop(PowerPCCPU *cpu, SpaprMachineState *spapr,
     while (count--) {
         switch (esize) {
         case 0:
-            tmp = ldub_phys(cs->as, src);
+            tmp = ldub_phys(as, src);
             break;
         case 1:
-            tmp = lduw_phys(cs->as, src);
+            tmp = lduw_phys(as, src);
             break;
         case 2:
-            tmp = ldl_phys(cs->as, src);
+            tmp = ldl_phys(as, src);
             break;
         case 3:
-            tmp = ldq_phys(cs->as, src);
+            tmp = ldq_phys(as, src);
             break;
         default:
             return H_PARAMETER;
@@ -764,16 +767,16 @@ static target_ulong h_logical_memop(PowerPCCPU *cpu, SpaprMachineState *spapr,
         }
         switch (esize) {
         case 0:
-            stb_phys(cs->as, dst, tmp);
+            stb_phys(as, dst, tmp);
             break;
         case 1:
-            stw_phys(cs->as, dst, tmp);
+            stw_phys(as, dst, tmp);
             break;
         case 2:
-            stl_phys(cs->as, dst, tmp);
+            stl_phys(as, dst, tmp);
             break;
         case 3:
-            stq_phys(cs->as, dst, tmp);
+            stq_phys(as, dst, tmp);
             break;
         }
         dst = dst + step;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index c2432a0c00c..8b0c8bff8ef 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -485,7 +485,7 @@ static target_ulong h_put_tce_indirect(PowerPCCPU *cpu,
     target_ulong npages = args[3];
     target_ulong ret = H_PARAMETER, tce = 0;
     SpaprTceTable *tcet = spapr_tce_find_by_liobn(liobn);
-    CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     hwaddr page_mask, page_size;
 
     if (!tcet) {
@@ -501,7 +501,7 @@ static target_ulong h_put_tce_indirect(PowerPCCPU *cpu,
     ioba &= page_mask;
 
     for (i = 0; i < npages; ++i, ioba += page_size) {
-        tce = ldq_be_phys(cs->as, tce_list + i * sizeof(target_ulong));
+        tce = ldq_be_phys(as, tce_list + i * sizeof(target_ulong));
 
         ret = put_tce_emu(tcet, ioba, tce);
         if (ret) {
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 10cf634da19..0486820e2ce 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -36,6 +36,7 @@ uint8_t spapr_nested_api(SpaprMachineState *spapr)
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     uint64_t patb, pats;
 
     assert(lpid != 0);
@@ -56,8 +57,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     /* Grab entry */
     patb += 16 * lpid;
-    entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
-    entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+    entry->dw0 = ldq_phys(as, patb);
+    entry->dw1 = ldq_phys(as, patb + 8);
     return true;
 }
 
@@ -329,6 +330,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(cs, 0);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     struct nested_ppc_state l2_state;
     target_ulong hv_ptr = args[0];
@@ -345,16 +347,16 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     }
 
     len = sizeof(*hvstate);
-    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, false,
+    hvstate = address_space_map(as, hv_ptr, &len, false,
                                 MEMTXATTRS_UNSPECIFIED);
     if (len != sizeof(*hvstate)) {
-        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, false);
+        address_space_unmap(as, hvstate, len, 0, false);
         return H_PARAMETER;
     }
 
     memcpy(&hv_state, hvstate, len);
 
-    address_space_unmap(CPU(cpu)->as, hvstate, len, len, false);
+    address_space_unmap(as, hvstate, len, len, false);
 
     /*
      * We accept versions 1 and 2. Version 2 fields are unused because TCG
@@ -378,10 +380,10 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     nested_save_state(spapr_cpu->nested_host_state, cpu);
 
     len = sizeof(*regs);
-    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
+    regs = address_space_map(as, regs_ptr, &len, false,
                                 MEMTXATTRS_UNSPECIFIED);
     if (!regs || len != sizeof(*regs)) {
-        address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
+        address_space_unmap(as, regs, len, 0, false);
         g_free(spapr_cpu->nested_host_state);
         return H_P2;
     }
@@ -397,7 +399,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     l2_state.msr = regs->msr;
     l2_state.nip = regs->nip;
 
-    address_space_unmap(CPU(cpu)->as, regs, len, len, false);
+    address_space_unmap(as, regs, len, len, false);
 
     l2_state.cfar = hv_state.cfar;
     l2_state.lpidr = hv_state.lpid;
@@ -460,6 +462,7 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    AddressSpace *as = cpu_get_address_space(cs, 0);
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     struct nested_ppc_state l2_state;
     target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
@@ -492,10 +495,10 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
     spapr_cpu->nested_host_state = NULL;
 
     len = sizeof(*hvstate);
-    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
+    hvstate = address_space_map(as, hv_ptr, &len, true,
                                 MEMTXATTRS_UNSPECIFIED);
     if (len != sizeof(*hvstate)) {
-        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
+        address_space_unmap(as, hvstate, len, 0, true);
         env->gpr[3] = H_PARAMETER;
         return;
     }
@@ -525,13 +528,13 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
     hvstate->ppr = l2_state.ppr;
 
     /* Is it okay to specify write length larger than actual data written? */
-    address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
+    address_space_unmap(as, hvstate, len, len, true);
 
     len = sizeof(*regs);
-    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
+    regs = address_space_map(as, regs_ptr, &len, true,
                                 MEMTXATTRS_UNSPECIFIED);
     if (!regs || len != sizeof(*regs)) {
-        address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
+        address_space_unmap(as, regs, len, 0, true);
         env->gpr[3] = H_P2;
         return;
     }
@@ -556,7 +559,7 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
     }
 
     /* Is it okay to specify write length larger than actual data written? */
-    address_space_unmap(CPU(cpu)->as, regs, len, len, true);
+    address_space_unmap(as, regs, len, len, true);
 }
 
 static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
@@ -1506,6 +1509,7 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
                                          uint64_t vcpuid,
                                          struct guest_state_request *gsr)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     target_ulong rc;
     int64_t len;
     bool is_write;
@@ -1513,7 +1517,7 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
     len = gsr->len;
     /* only get_state would require write access to the provided buffer */
     is_write = (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
-    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
+    gsr->gsb = address_space_map(as, gsr->buf, (uint64_t *)&len,
                                  is_write, MEMTXATTRS_UNSPECIFIED);
     if (!gsr->gsb) {
         rc = H_P3;
@@ -1528,7 +1532,7 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
     rc = getset_state(spapr, guest, vcpuid, gsr);
 
 out1:
-    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
+    address_space_unmap(as, gsr->gsb, len, is_write, len);
     return rc;
 }
 
@@ -1699,6 +1703,7 @@ static void exit_process_output_buffer(SpaprMachineState *spapr,
                                        target_ulong vcpuid,
                                        target_ulong *r3)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     SpaprMachineStateNestedGuestVcpu *vcpu = &guest->vcpus[vcpuid];
     struct guest_state_request gsr;
     struct guest_state_buffer *gsb;
@@ -1709,10 +1714,10 @@ static void exit_process_output_buffer(SpaprMachineState *spapr,
     hwaddr len;
 
     len = vcpu->runbufout.size;
-    gsb = address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, true,
+    gsb = address_space_map(as, vcpu->runbufout.addr, &len, true,
                             MEMTXATTRS_UNSPECIFIED);
     if (!gsb || len != vcpu->runbufout.size) {
-        address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+        address_space_unmap(as, gsb, len, true, len);
         *r3 = H_P2;
         return;
     }
@@ -1734,7 +1739,7 @@ static void exit_process_output_buffer(SpaprMachineState *spapr,
     gsr.flags = 0; /* get + never guest wide */
     getset_state(spapr, guest, vcpuid, &gsr);
 
-    address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+    address_space_unmap(as, gsb, len, true, len);
 }
 
 static
-- 
2.51.0


