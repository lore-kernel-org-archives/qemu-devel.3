Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC197E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7PB-000745-PU; Wed, 18 Dec 2024 22:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7PA-00072A-4x; Wed, 18 Dec 2024 22:40:52 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7P8-0004IR-Ek; Wed, 18 Dec 2024 22:40:51 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166f1e589cso3871365ad.3; 
 Wed, 18 Dec 2024 19:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579648; x=1735184448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wq3Jl1AW0pq6Ra+sjmnRZba6A1rNlSx3/9ckGBwUM5k=;
 b=N1I6fBynfxunFEfO3agZjbvaAIghid4dFT0XZW/G2zKld0C5XyFp9fizZaOWaFKsQe
 pPFB25OZBgy/PBVra1JO0Udp02zRI3pggtpSGZBToTJ8wcgx9tFqORELJg+YoK4hSJAM
 cyMObqymc1bkbtnIDQlEVknpreZQYK1+sd9wj1uamyLc+Bt6E/8hE6dV0tT9fv8wEBhk
 6Yuif5zOcWAbQq/HeRYI3QFJymEjt20lj8LWqJLlezXC1t3yjUlGUHy87jDvctQyDMKF
 CTJ3cPeo9kH/CmBQUtbsW09v8CGAI7kuAqQUJIagIoC2HW8aCTNFZJmktoSvlEQNcusx
 6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579648; x=1735184448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wq3Jl1AW0pq6Ra+sjmnRZba6A1rNlSx3/9ckGBwUM5k=;
 b=JrWJsWRPyiZZfZDAnUg1CyqweZKjGrG5du6FZlVhaB1WjH2Nm8WVQVqFN9B+xOPEDp
 oL8R6RmAqeQQgvSYlovt/OXyVbTwvtjSq1gGfNKtAPLh2Rq3ta6KTIwAB0qHEWukUQyi
 agGebiensHjegHJzCqaLKre1eB92WbnVNN+yW9eNf9pwKC8bk6vDcs/fru+QzxM4rXxr
 vu6rxqKngydnHHFMjz5/rKbBoSwJJ1u/ZnRt9Op7l5QuB+EYPSPJSPT9uXhuLcv6PL2B
 INU6J4SYQ6vwOQFKl1w2wxajAa7A12tdzka3wfTNsVz+NJMy6/3+xvaiv4VgoeBTigqN
 UGGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO545UsORJXuqKRiQc+lkAk9tqHFjrxftTbOghPbcXcBAiQqksAum8CjABZjppcNgDSXSa2WYFUmb0@nongnu.org
X-Gm-Message-State: AOJu0YyIDsR+c4yd+HlTAvtSTVqZik2vdZfw9slWoJQDj8XawKg4GZJs
 iS9uAEJOB72yQWHg8GKkhtQherxtEMT78exsYgiODyh6+6d7e+CLVAmWjA==
X-Gm-Gg: ASbGncuRGhLZNgvFFvAOfLe8gOuK+sU6BkA3/d+bA06lCkJtnzzRiSAgG91awwfAY2h
 slbmEvHYByloXol9p2UMeW7G6+bxc+ojIf+NaRkGgvVLmkHYny4PIno71H5M+8SRKx6K2labmVw
 J/TmEmPe8aI4tLg8SYoGtbUzR0DmH+lAVpLnPOJ1nKrwRmJNdQh1Tpv4dAsL+tB+Y/cS/7In+rQ
 e2aY7mNIleVOqfMZpr60kwiL0mQAAIzo6pOA5UnYJKzch4sw+TtI/vO3IAy3nr2i9rWqj4uvxn/
 FTaAGnngmw==
X-Google-Smtp-Source: AGHT+IEgl+l2kBLREVhNKE/n+rGiSiHtu/ZEc+oamSnL8zzqkTbnPmWbsC76IBjrhuScDNDKLkwelA==
X-Received: by 2002:a17:902:db0f:b0:217:89da:fd54 with SMTP id
 d9443c01a7336-218d722f88fmr88039025ad.33.1734579648472; 
 Wed, 18 Dec 2024 19:40:48 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/5] spapr: Fix vpa dispatch count for record-replay
Date: Thu, 19 Dec 2024 13:40:32 +1000
Message-ID: <20241219034035.1826173-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219034035.1826173-1-npiggin@gmail.com>
References: <20241219034035.1826173-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

The dispatch count is a field in guest memory that the hypervisor
increments when preempting and dispatching the guest. This was not
being done deterministically with respect to icount, because tcg
exec exit is not deterministic (e.g., an async event could cause it).

Change vpa dispatch count increment to keep track of whether the
vCPU is considered dispatched or not, and only consider it preempted
when calling cede / confer / join / stop-self / etc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_cpu_core.h |  3 +++
 hw/ppc/spapr.c                  | 36 ++-------------------------------
 hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c             |  1 +
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 68f70834832..feba3446194 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
+    bool dispatched; /* for vpa dispatch counter tracking */
     bool prod; /* not migrated, only used to improve dispatch latencies */
     struct ICPState *icp;
     struct XiveTCTX *tctx;
@@ -60,4 +61,6 @@ static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
     return (SpaprCpuState *)cpu->machine_data;
 }
 
+void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch);
+
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3b022e8da9e..fa05e0c5156 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4519,47 +4519,15 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
-    /* These are only called by TCG, KVM maintains dispatch state */
-
     spapr_cpu->prod = false;
-    if (spapr_cpu->vpa_addr) {
+    if (!spapr_cpu->dispatched) {
         CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 0) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "dispatched partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+        vpa_dispatch(cs, spapr_cpu, true);
     }
 }
 
 static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 1) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "preempted partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
-    }
 }
 
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5e1d020e3df..907e09c2c36 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return ret;
 }
 
+void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch)
+{
+    uint32_t counter;
+
+    if (!dispatch) {
+        assert(spapr_cpu->dispatched);
+    } else {
+        assert(!spapr_cpu->dispatched);
+    }
+    spapr_cpu->dispatched = dispatch;
+
+    return;
+
+    if (!spapr_cpu->vpa_addr) {
+        return;
+    }
+
+    /* These are only called by TCG, KVM maintains dispatch state */
+    counter = ldl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+    counter++;
+    if ((counter & 1) != dispatch) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "VPA: incorrect dispatch counter value for "
+                      "%s partition %u, correcting.\n",
+                      dispatch ? "preempted" : "running", counter);
+        counter++;
+    }
+    stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, counter);
+}
+
 static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -505,6 +535,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
+        vpa_dispatch(cs, spapr_cpu, false);
         cs->exception_index = EXCP_HLT;
         cs->exit_request = 1;
         ppc_maybe_interrupt(env);
@@ -531,6 +562,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     cs->exit_request = 1;
     ppc_maybe_interrupt(&cpu->env);
 
+    vpa_dispatch(cs, spapr_cpu, false);
+
     return H_SUCCESS;
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index f329693c554..8ce42302234 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -216,6 +216,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
      */
     env->spr[SPR_PSSCR] |= PSSCR_EC;
     cs->halted = 1;
+    vpa_dispatch(cs, spapr_cpu_state(cpu), false);
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
-- 
2.45.2


