Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D7C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFEN-0002l3-LF; Mon, 18 Mar 2024 11:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEL-0002dN-VE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:53 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEG-00088I-0Q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:53 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2218da9620cso2995066fac.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776926; x=1711381726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTDQk3RLtHyV33kSQFz4v+nbGsPMffpe9d1g+nxXpFM=;
 b=j7/t1icY/4Cb2Kg7o3zh+kgsjyfUoQp3cql8OswMCZFoXA6rvwh+ro0NyJzDQekF2l
 HVWsr0VEboBgq87nht1CGgXnLwu2Gyl8g5J1iOPUGDavnrce/f/OwVzEMvLgxo0fp+YB
 WLjrnWmDMEGtHnALAOqQyZhM7/W6X51QG7dPS3LS8YqiRGSU7DJ3fvvmBAiIevMCQggU
 skNplnrFgYvDjl+0B+jLhQdfGyX5wsPP4C6BTFlA2DKkG7RsYdMfTMJxL9I+u5WAMcLK
 zXVTuGcgfytebM3IY+/L1B3U3NtLT8LFASg7kNIj/YZPYWUMasJiyRZqm1HaLEs6q3E6
 zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776926; x=1711381726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTDQk3RLtHyV33kSQFz4v+nbGsPMffpe9d1g+nxXpFM=;
 b=v4CxuuxUJ2HD1AvVQTstr/XVYRLgiCMng9yetPwVexcnsee46wsEjP6azHKhVfVYWu
 eCCjLQyGY4rUUlBah1aObkfEYBwsywRlsKy+vSh2iDZWWicXlIjxB//fRaKAOYfqudSV
 m17hS5amR11YkwAVXtSQJ+lUwjvBsOA22FB4pqav7jPi9moZ1HQQVwgr9NUAxqcdLvYR
 v8yBHrt7ENiY/IpS0gliiZnkpGa2OwhaRrNkYfwaS9yQnDjB92umaIMq3X+m01yyoZAx
 Vj2KGbrGfbHN/yyCW/2gl6iurFliWty8s0YetlpTdthf59zC4KN/l2GJ0uTVxfk2egSa
 44Nw==
X-Gm-Message-State: AOJu0YwLgWHl8Q5w+yJkikIcRut0LfDaip5QlY2bwp7Yf9HJvMokiA8F
 8gaV/1yfyPLWKeBJfEf6KWBRjuQhsKPKHUYtTCe0VSvMvoR8PUjtoIQoCLe38/g=
X-Google-Smtp-Source: AGHT+IHI+iQgsh/X3sQCQ9HRsqIVXN7F0nx3/qr6+/YrX3pUAHYhGkS0o2C1PS9DEebe2jnFB25qXA==
X-Received: by 2002:a05:6870:1ce:b0:21e:ed67:b0f5 with SMTP id
 n14-20020a05687001ce00b0021eed67b0f5mr13637667oad.53.1710776926163; 
 Mon, 18 Mar 2024 08:48:46 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 23/24] spapr: Fix vpa dispatch count for record-replay
Date: Tue, 19 Mar 2024 01:46:20 +1000
Message-ID: <20240318154621.2361161-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 69a52e39b8..5feb0ecc2a 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -47,6 +47,7 @@ typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
+    bool dispatched; /* for vpa dispatch counter tracking */
     bool prod; /* not migrated, only used to improve dispatch latencies */
     struct ICPState *icp;
     struct XiveTCTX *tctx;
@@ -61,4 +62,6 @@ static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
     return (SpaprCpuState *)cpu->machine_data;
 }
 
+void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch);
+
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c417f9dd52..07b004fdec 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4599,47 +4599,15 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
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
index 5e1d020e3d..907e09c2c3 100644
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
index f329693c55..8ce4230223 100644
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
2.42.0


