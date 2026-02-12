Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354A1EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvU-00064v-7G; Thu, 12 Feb 2026 09:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvK-0005rC-7o
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvI-0006Fd-Er
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oyw3iN4RWS1l74BvVt0dka4bgQPOIP1RWCHgcmGGEsI=;
 b=TLD1nKhIKpoQiJJzz+dVY6ZBXWEhYACVUsgkGA897mBFaFIN/fW8Ot7euMGLwSYsNcuM+H
 Ytc7+AQQSR9w7WJdKpW648yKMBCjNGUhd4jCm6JnMlIHL8YJSlSGLgUWYRYaBk2Ymru0mL
 bYocyvUii1QGzI0sqr0GqVGtYTMel18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Noa7-BAwNUijNRC2-rdDOw-1; Thu, 12 Feb 2026 09:44:02 -0500
X-MC-Unique: Noa7-BAwNUijNRC2-rdDOw-1
X-Mimecast-MFC-AGG-ID: Noa7-BAwNUijNRC2-rdDOw_1770907441
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48070c21420so15036885e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907440; x=1771512240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oyw3iN4RWS1l74BvVt0dka4bgQPOIP1RWCHgcmGGEsI=;
 b=PONsv9bj8DwgwmgHnXhnFiJ7Je9zGQFzFdnq8HGZeVF9ijV7Q6tV5O7o8s5VrM7HHi
 +KE7/CNTpjaUib6reW5EPPKeWyEIAW44ts2NFmyn2vWzZxAqRC5BEXYh2tTdmvJtMq9R
 5Hm9fKyug21usBrsldZ9dwQINfXBW5fozIGcOcYk2urcdjCU96jDL4RQyGynFsOLsitD
 QKY39bLR78oA/wtuLzQeC9oCGinpStrMzceEcQUWGx8LCY9aslBHjtDFuf+2SZH/+CAd
 xbPCBe2CRq7uTs99FENU82QteYUhieFWhSIJ88eQ4E8LLIkPfFTXICyNaHTakgPX6o+w
 r7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907440; x=1771512240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oyw3iN4RWS1l74BvVt0dka4bgQPOIP1RWCHgcmGGEsI=;
 b=DjYoog4CTfnrLdgSaFxuFmBUSYX4Ui/7YGY8pTDka/KxMaK+Ewa79bE06QF4He3jGI
 3IBMa+2WR/xbwtiW4TLh2+XptF/swQgYa6ww11pzcJ431rM9/0QyciKDIMJUWkUD6di1
 3CIYA7+/MNAZ4wEgi+p/ysWBL1NpMHC3tOVq8E1rcNlfoElJQi4l8b9yAkEEn7UaHNCY
 lIFb2bUlIlqhDSFgQMEcxm9XCMpXABpmNH6+qGJv2syzuxcpGlcWxtJT+FT+iM2PzKMA
 4fgQoINDulLrcr2SWGS4lVObE+VPENNCmIS2+NQTlCxo1odhxOOtMk6a/rmyoGl6jFEx
 jq3Q==
X-Gm-Message-State: AOJu0Yx5jqzRDeHHTUX3djyb97yUR/nHDhIv4s1+7kgnqOsjVMvXazwe
 mL/kinOZDvzerDyKAIelE4BJalkoayu59a10rGlzCmD6u0J7q0C9ojrbhw0W4hULLp6KJ0YivDf
 z6tSV2XSRDR7aIqUHTYhbWBeEPPfsSx+sOVi19ypBKuKzQ0KkytTSpADdDnb3ul9Mfvsow3l4FR
 uSlRxKq6KQq9zu2ZVYwQ0gwlkeprP8EiGvgTGWQRrt
X-Gm-Gg: AZuq6aIUiVFS3DZl5v3EJzIZNQDTnhhG8vs9xhVUAT1L2c10NlzePIw69MiaSufGggV
 34lxqYmzExWPa05jbiHIri9VTzhhYnI9eTic0U7FZr37qv2PgfGe3E98HNvkqri8sD7sSKio4K/
 VZ9WpXfbp5fZyfMuAUcpRZ+7wWD9f1l2qtGiYO/7ajGlkE+5SJu3By6dAv83gyvDdj59OhsMhdr
 /M0TkHeNSsI22cOZElpVhLTxv+xeWu43bw/63KSEjvVKbLahbZQHg9cCUFpktanaibhNb5zm30K
 0zSvWHCFZYtifrhu/7puSahXrrKlNkm2ji6nTPTjoZ6Fs+oXayKwtWeD3jFPEYWWxBEs7e+mTWk
 Wo9Pfc693iMXO4elnj3W/SYRRTiTJQb4hFWWh6w2iXpuyZ28P7mIsCEIRICpfknsBRvbNjplbm6
 tlxY3hisY+Yc9fGNsXX1fcUhVbGyAxQUvM1CJffXYNZ9TaJNzOCdg=
X-Received: by 2002:a05:600c:896:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-48365fdec0dmr29466305e9.3.1770907439915; 
 Thu, 12 Feb 2026 06:43:59 -0800 (PST)
X-Received: by 2002:a05:600c:896:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-48365fdec0dmr29465795e9.3.1770907439327; 
 Thu, 12 Feb 2026 06:43:59 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835b958b6csm134434425e9.1.2026.02.12.06.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>
Subject: [PULL 32/41] target/i386/kvm: rename architectural PMU variables
Date: Thu, 12 Feb 2026 15:42:34 +0100
Message-ID: <20260212144244.22579-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dongli Zhang <dongli.zhang@oracle.com>

AMD does not have what is commonly referred to as an architectural PMU.
Therefore, we need to rename the following variables to be applicable for
both Intel and AMD:

- has_architectural_pmu_version
- num_architectural_pmu_gp_counters
- num_architectural_pmu_fixed_counters

For Intel processors, the meaning of pmu_version remains unchanged.

For AMD processors:

pmu_version == 1 corresponds to versions before AMD PerfMonV2.
pmu_version == 2 corresponds to AMD PerfMonV2.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20260109075508.113097-4-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31e8ef87aab..8faba7e471e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -166,9 +166,16 @@ static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
 static bool has_msr_hwcr;
 
-static uint32_t has_architectural_pmu_version;
-static uint32_t num_architectural_pmu_gp_counters;
-static uint32_t num_architectural_pmu_fixed_counters;
+/*
+ * For Intel processors, the meaning is the architectural PMU version
+ * number.
+ *
+ * For AMD processors: 1 corresponds to the prior versions, and 2
+ * corresponds to AMD PerfMonV2.
+ */
+static uint32_t pmu_version;
+static uint32_t num_pmu_gp_counters;
+static uint32_t num_pmu_fixed_counters;
 
 static int has_xsave2;
 static int has_xcrs;
@@ -2098,24 +2105,24 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid)
         return;
     }
 
-    has_architectural_pmu_version = c->eax & 0xff;
-    if (has_architectural_pmu_version > 0) {
-        num_architectural_pmu_gp_counters = (c->eax & 0xff00) >> 8;
+    pmu_version = c->eax & 0xff;
+    if (pmu_version > 0) {
+        num_pmu_gp_counters = (c->eax & 0xff00) >> 8;
 
         /*
          * Shouldn't be more than 32, since that's the number of bits
          * available in EBX to tell us _which_ counters are available.
          * Play it safe.
          */
-        if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
-            num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+        if (num_pmu_gp_counters > MAX_GP_COUNTERS) {
+            num_pmu_gp_counters = MAX_GP_COUNTERS;
         }
 
-        if (has_architectural_pmu_version > 1) {
-            num_architectural_pmu_fixed_counters = c->edx & 0x1f;
+        if (pmu_version > 1) {
+            num_pmu_fixed_counters = c->edx & 0x1f;
 
-            if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
-                num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+            if (num_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                num_pmu_fixed_counters = MAX_FIXED_COUNTERS;
             }
         }
     }
@@ -4086,25 +4093,25 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
-        if (has_architectural_pmu_version > 0) {
-            if (has_architectural_pmu_version > 1) {
+        if (pmu_version > 0) {
+            if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             }
 
             /* Set the counter values.  */
-            for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
+            for (i = 0; i < num_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
                                   env->msr_fixed_counters[i]);
             }
-            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
+            for (i = 0; i < num_pmu_gp_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
                                   env->msr_gp_counters[i]);
                 kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
                                   env->msr_gp_evtsel[i]);
             }
-            if (has_architectural_pmu_version > 1) {
+            if (pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
                                   env->msr_global_status);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
@@ -4621,17 +4628,17 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
-    if (has_architectural_pmu_version > 0) {
-        if (has_architectural_pmu_version > 1) {
+    if (pmu_version > 0) {
+        if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
         }
-        for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
+        for (i = 0; i < num_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
-        for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
+        for (i = 0; i < num_pmu_gp_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
-- 
2.52.0


