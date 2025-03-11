Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E296C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJr-00062S-CP; Tue, 11 Mar 2025 09:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEp-0005km-Up; Tue, 11 Mar 2025 09:01:42 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEn-0000JK-JF; Tue, 11 Mar 2025 09:01:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so7177610a91.1; 
 Tue, 11 Mar 2025 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698094; x=1742302894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHowS6P5BYg/rSJVbmvQ3akSwNj1ZtWnh45h27uLxQY=;
 b=DJlEHgGy+IAt8cQ90xUY0eIbcMW/wqlTV1fxtDucSmHEH0G99LpjiBjJyaDszrxutZ
 eNiZJ8pvEEqZZCRS3jOdh3ShuWOAiWI1PxbK5TsG9KegtcXDjJZIEy+Uv+Gg2Bl8+IHo
 jUn4t2GApMD2SIeqky6hRzwBvpbK3yM8p0MPi9YoioiZhhwoHqS3q55N8X7lGvqpybSk
 NraKvyVUaOw2yYe2tmFuUpuc4QMWdjQfuE++8jhRBenzBY/OV55BG0iCiNVNB6Ufnu6S
 k8Wo/ncGbubpWzxaLJGNlBXnWxGlz6nSIezHRcFcj/uVtL87Vv+eRkxVdkIcra35o1xW
 0FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698094; x=1742302894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHowS6P5BYg/rSJVbmvQ3akSwNj1ZtWnh45h27uLxQY=;
 b=nILcny2kp2WrKjRu0tUBm4XHTvv3q3+cjVooxT3Gd9hDm8+eH04rJ5+ImCkRflQcvT
 tQ8B3dvFxFw7WTwW17ccCRGkjMlwS4l4NtIlIF8BfDUzGpzA7nbkpF1t6/hbjnFzPPaw
 ns1T8t4YqN1H/TD28mxoCRml9pJBbV0O0PyLNyCP3J+OSNR+nCGa43eP2Bhk8rXnYdWQ
 P5XE0On2RjalXr4j2dxkSVm3YC5WFrlaC8Q2Pd/N5mlCw76vwyF+37lsW9nQ9VNKTok9
 v7r+n8C4qW+oyvxL2pzBgnTU2EeSbvRpyv2ffm1NOPOWc/DN5DdVuT9KPsWNRwU/YtVb
 6oLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7onlPN5mntk1em+WeCaKZhzaCOdDRAJHv4WKAStKtWaY8MEuG+YDGF8ym1lagMjFN5bBbamnxyw==@nongnu.org
X-Gm-Message-State: AOJu0YzZOEFf7z/1N2a1w/DTCcafM97GRiZiyS1zbwzHmyWQl6boO0/J
 OA57TXQUGT+FuaAmpycEGcSTnLp/GP59Dnl6w0Cf+JAoZkwk7/tAkHcJvg==
X-Gm-Gg: ASbGncvfwZsy3CTwqNEMO+TsxOVckna/TEk5SInSkZOSYpNltmK+Kt5aDD4M1mPOM+o
 BgRYMLE31qn6B+2AzxVPAhwVngExw1/y6xFqyVVyzEXLBaE8/VQRqa3XZiMZn6pqyzAfkM4TS37
 7Ckw5Xv1i9lrC/72lULrSQpJ9+DBv18+YIOGOumzt6mwtlEW09J1/zM4qo0xawo7tfhzkWzDMKF
 6Hrf03TRRdn48/6F4/6zyHdP8gc+RNnjo3eRDBXUl8T3/V1Its5G1/MnLL3DTdm0h4hbfLJD2Nx
 /OVJaRhzwWdquGrtLFnr733OvGX3mJQaSOHwDXW1+t1WOvg15wI=
X-Google-Smtp-Source: AGHT+IEjE+5Z6cbs5WrPYTixKQE7tCPH4wzNRS834rYetiR6W7zxy28+Jn33fTdnxmTDagXM7abGuA==
X-Received: by 2002:a17:90a:e70e:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-300ff10c978mr5414489a91.17.1741698093784; 
 Tue, 11 Mar 2025 06:01:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PULL 61/72] ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine
Date: Tue, 11 Mar 2025 22:57:55 +1000
Message-ID: <20250311125815.903177-62-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

As per the PAPR, bit 0 of byte 64 in pa-features property
indicates availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
whether kvm supports 2nd DAWR or not. If it's supported, allow user to set
the pa-feature bit in guest DT using cap-dawr1 machine capability.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <173708681866.1678.11128625982438367069.stgit@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         |  7 ++++++-
 hw/ppc/spapr_caps.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   | 27 +++++++++++++++++---------
 include/hw/ppc/spapr.h |  6 +++++-
 target/ppc/kvm.c       | 12 ++++++++++++
 target/ppc/kvm_ppc.h   | 12 ++++++++++++
 6 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0acf3c53dc..fcd2ca515c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -246,7 +246,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
         /* 54: DecFP, 56: DecI, 58: SHA */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
-        /* 60: NM atomic, 62: RNG */
+        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
         /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
         0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
@@ -295,6 +295,9 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
          * in pa-features. So hide it from them. */
         pa_features[40 + 2] &= ~0x80; /* Radix MMU */
     }
+    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
+        pa_features[66] |= 0x80;
+    }
 
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
 }
@@ -2163,6 +2166,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_rpt_invalidate,
         &vmstate_spapr_cap_ail_mode_3,
         &vmstate_spapr_cap_nested_papr,
+        &vmstate_spapr_cap_dawr1,
         NULL
     }
 };
@@ -4680,6 +4684,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_DAWR1] = SPAPR_CAP_ON;
 
     /*
      * This cap specifies whether the AIL 3 mode for
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 904bff87ce..9f4fd0cb5e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -696,6 +696,34 @@ static void cap_ail_mode_3_apply(SpaprMachineState *spapr,
     }
 }
 
+static void cap_dawr1_apply(SpaprMachineState *spapr, uint8_t val,
+                               Error **errp)
+{
+    ERRP_GUARD();
+
+    if (!val) {
+        return; /* Disable by default */
+    }
+
+    if (!ppc_type_check_compat(MACHINE(spapr)->cpu_type,
+                               CPU_POWERPC_LOGICAL_3_10, 0,
+                               spapr->max_compat_pvr)) {
+        error_setg(errp, "DAWR1 supported only on POWER10 and later CPUs");
+        error_append_hint(errp, "Try appending -machine cap-dawr1=off\n");
+        return;
+    }
+
+    if (kvm_enabled()) {
+        if (!kvmppc_has_cap_dawr1()) {
+            error_setg(errp, "DAWR1 not supported by KVM.");
+            error_append_hint(errp, "Try appending -machine cap-dawr1=off");
+        } else if (kvmppc_set_cap_dawr1(val) < 0) {
+            error_setg(errp, "Error enabling cap-dawr1 with KVM.");
+            error_append_hint(errp, "Try appending -machine cap-dawr1=off");
+        }
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -831,6 +859,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_ail_mode_3_apply,
     },
+    [SPAPR_CAP_DAWR1] = {
+        .name = "dawr1",
+        .description = "Allow 2nd Data Address Watchpoint Register (DAWR1)",
+        .index = SPAPR_CAP_DAWR1,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_dawr1_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -841,6 +878,11 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
 
     caps = smc->default_caps;
 
+    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_10,
+                               0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_DAWR1] = SPAPR_CAP_OFF;
+    }
+
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
@@ -975,6 +1017,7 @@ SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
 SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
 SPAPR_CAP_MIG_STATE(ail_mode_3, SPAPR_CAP_AIL_MODE_3);
+SPAPR_CAP_MIG_STATE(dawr1, SPAPR_CAP_DAWR1);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4f1933b8da..406aea4ecb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -822,11 +822,12 @@ static target_ulong h_set_mode_resource_set_ciabr(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong mflags,
-                                                  target_ulong value1,
-                                                  target_ulong value2)
+static target_ulong h_set_mode_resource_set_dawr(PowerPCCPU *cpu,
+                                                 SpaprMachineState *spapr,
+                                                 target_ulong mflags,
+                                                 target_ulong resource,
+                                                 target_ulong value1,
+                                                 target_ulong value2)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -839,8 +840,15 @@ static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
         return H_P4;
     }
 
-    ppc_store_dawr0(env, value1);
-    ppc_store_dawrx0(env, value2);
+    if (resource == H_SET_MODE_RESOURCE_SET_DAWR0) {
+        ppc_store_dawr0(env, value1);
+        ppc_store_dawrx0(env, value2);
+    } else if (resource == H_SET_MODE_RESOURCE_SET_DAWR1) {
+        ppc_store_dawr1(env, value1);
+        ppc_store_dawrx1(env, value2);
+    } else {
+        g_assert_not_reached();
+    }
 
     return H_SUCCESS;
 }
@@ -919,8 +927,9 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                             args[3]);
         break;
     case H_SET_MODE_RESOURCE_SET_DAWR0:
-        ret = h_set_mode_resource_set_dawr0(cpu, spapr, args[0], args[2],
-                                            args[3]);
+    case H_SET_MODE_RESOURCE_SET_DAWR1:
+        ret = h_set_mode_resource_set_dawr(cpu, spapr, args[0], args[1],
+                                           args[2], args[3]);
         break;
     case H_SET_MODE_RESOURCE_LE:
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a6c0547e31..d227f0b94b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -83,8 +83,10 @@ typedef enum {
 #define SPAPR_CAP_AIL_MODE_3            0x0C
 /* Nested PAPR */
 #define SPAPR_CAP_NESTED_PAPR           0x0D
+/* DAWR1 */
+#define SPAPR_CAP_DAWR1                 0x0E
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_DAWR1 + 1)
 
 /*
  * Capability Values
@@ -406,6 +408,7 @@ struct SpaprMachineState {
 #define H_SET_MODE_RESOURCE_SET_DAWR0           2
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE     3
 #define H_SET_MODE_RESOURCE_LE                  4
+#define H_SET_MODE_RESOURCE_SET_DAWR1           5
 
 /* Flags for H_SET_MODE_RESOURCE_LE */
 #define H_SET_MODE_ENDIAN_BIG    0
@@ -1003,6 +1006,7 @@ extern const VMStateDescription vmstate_spapr_cap_fwnmi;
 extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
 extern const VMStateDescription vmstate_spapr_cap_ail_mode_3;
 extern const VMStateDescription vmstate_spapr_wdt;
+extern const VMStateDescription vmstate_spapr_cap_dawr1;
 
 static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 216638dee4..992356cb75 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -92,6 +92,7 @@ static int cap_large_decr;
 static int cap_fwnmi;
 static int cap_rpt_invalidate;
 static int cap_ail_mode_3;
+static int cap_dawr1;
 
 #ifdef CONFIG_PSERIES
 static int cap_papr;
@@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
     cap_fwnmi = kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
+    cap_dawr1 = kvm_vm_check_extension(s, KVM_CAP_PPC_DAWR1);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2114,6 +2116,16 @@ int kvmppc_set_fwnmi(PowerPCCPU *cpu)
     return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
 }
 
+bool kvmppc_has_cap_dawr1(void)
+{
+    return !!cap_dawr1;
+}
+
+int kvmppc_set_cap_dawr1(int enable)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_DAWR1, 0, enable);
+}
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 1d8cb76a6b..a8768c1dfd 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -68,6 +68,8 @@ bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
 bool kvmppc_has_cap_xive(void);
+bool kvmppc_has_cap_dawr1(void);
+int kvmppc_set_cap_dawr1(int enable);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
@@ -377,6 +379,16 @@ static inline bool kvmppc_has_cap_xive(void)
     return false;
 }
 
+static inline bool kvmppc_has_cap_dawr1(void)
+{
+    return false;
+}
+
+static inline int kvmppc_set_cap_dawr1(int enable)
+{
+    abort();
+}
+
 static inline int kvmppc_get_cap_safe_cache(void)
 {
     return 0;
-- 
2.47.1


