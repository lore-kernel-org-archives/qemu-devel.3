Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B4CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7e-0006lM-35; Thu, 30 Apr 2026 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6y-0005ZJ-KT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6w-0004cm-KQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cl5a3vj9rnwbfPX/dYSVMjKJHNNMYrzpW3sXgWpfcTE=;
 b=hlDF4LoAY+syJ+Z9KqDplemjAvv+USPv4kkX3vgQ7Ft9TuD/0nI1Z5BjMiBFeMet7TV1Ih
 HHgUTL9jYwAiKhAKT3unFoiJtuHiAi2edEAWIsMA7fiO/Bm3KU6CzP3Unv0cm9tLiiuTbB
 SDKmTdAP1nSV8wdDsl2jE34+/OgO8mc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-XuUWmEiHMo6D22x66pFAMw-1; Thu, 30 Apr 2026 13:23:36 -0400
X-MC-Unique: XuUWmEiHMo6D22x66pFAMw-1
X-Mimecast-MFC-AGG-ID: XuUWmEiHMo6D22x66pFAMw_1777569816
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a22dbeeb96so25824296d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569815; x=1778174615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl5a3vj9rnwbfPX/dYSVMjKJHNNMYrzpW3sXgWpfcTE=;
 b=PDjvzOR/Vo4S3etgFeUjmcvuDtKbIxF7kvt07Zt+Hx+n2y0zQpUJ4McaxefWeoTt7L
 LWJ89h65nMbLSlP+Ovd2xjTnnm/CH4TKUv8kZ3lEevhSNBWZOg2Lcg4SaOaHSve/o6A5
 dzjRXti/c3nGQGlmVETEMYHXQE3IADZughT2tDTfxcDr01Q8SZNeXjwNdH9JTR2Yr5M7
 vCGGSiI5nEAaaUN8pDs8ZiHvJE5k/K9lFk4LWsqgn7IRZsexLZ+myguScYMC23tOvhg6
 gUIA8h5tHJcT+SVoV9S5MwtUc5HkmENMOCask3lUJd9AnqQCwUeD3CNzFZnBbXBTInkO
 IRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569815; x=1778174615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cl5a3vj9rnwbfPX/dYSVMjKJHNNMYrzpW3sXgWpfcTE=;
 b=FCah4Rs482ImeRlaTxPSrBnJblvZedM45ybOVil5nITHBmm2d/yq9zf6YZ4spzTzHT
 8e5jjlskKkfEo6YrKS/5/IjiHiRUFSWPU806iu0v0oLkvq/edX1QUcvHwLWaCxIm0Mo2
 Q9JqS+VLuv4PVM6rivwEA7RB5TC/q0UMIFeNwQXY3B7tWcvo4ct4sAg06CjpbLbvsxoH
 /yaTjOKCgH3XsHs4lfDE0Ddrwo8dV5nJBSeDGaV7kd6+WrSRfoI2148fbNI99lhSRNaM
 3CALYT2jkCZimG+E1bTx1N+F9liqpuKNdJWRtXVAayw3nn34m7a6QbEX7YygpH5ujgAR
 eErw==
X-Gm-Message-State: AOJu0YwwU8V5o2+EGDqKW3G6hzhHlM9xsGjVw0+f2rCM72PqK9GhY4cw
 bleVlSMLUtnx88svv1BVB6cnefhCYKQjU89tOHNuwyqCZvluF9KY6L+ggZtBLVl0fXOrG00Zn9a
 aOKZ6zF5gifZgJ/81gQIFq+aH1sdkPOw7RL1YPXlvtTTUPATBMf1F/FLcQT4Eb9ej+QdkzROL/f
 YFNogpkpkbkk9WpXl7dW571WKmpeYjs+/phfkeFz25
X-Gm-Gg: AeBDietBuCL0a+lhTh7ZKcHp3jF0EkLbmbaF31HV2zFFbNGiBc6eP3dkzhQMPTBwCuE
 Z8/s3wa3MaDiZA5gfxaFcgfbe0WFyr+6Fd5raNpv77HXo45FCiKEVCNSlwqu0kT7hGaRSdy1Yh6
 umSrQSAxRSO+7yUVobT7C00V9S5BW15cJL5xtKQTPcvYYJptX9tIi7rZaatyt2XYTCFiJ3a/NMf
 bi6ZSGPP23umhN2VVaYeXHVKNWE8jTfh9g8EJq/dQDQwq2EPEIa/F/ToWXV/nbNjmb0H2a5UsyR
 jVCtn28VZu3Gm2tS9Ff7yjIf6taKFJlXtUdMe38mX0Gk+RRdmjRneFLFOG80IcQwq0t50a1XYZa
 k56lSxEm8ot5EkTPBUIAsCDDaotf7+8kiIabgbJ7+E7/ARjNFmaLbOTF2LI3jqrZfBrOWPx09AX
 w3eWgoy1MhmL8+zjQtkJE6XqL4I749D9NoPVc=
X-Received: by 2002:a05:6214:600c:b0:8ac:801d:c3dc with SMTP id
 6a1803df08f44-8b3fe6f7050mr51807866d6.9.1777569815179; 
 Thu, 30 Apr 2026 10:23:35 -0700 (PDT)
X-Received: by 2002:a05:6214:600c:b0:8ac:801d:c3dc with SMTP id
 6a1803df08f44-8b3fe6f7050mr51807256d6.9.1777569814646; 
 Thu, 30 Apr 2026 10:23:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff307a48sm23204516d6.8.2026.04.30.10.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 28/58] whpx: i386: reintroduce enlightenments for Windows 10
Date: Thu, 30 Apr 2026 19:21:34 +0200
Message-ID: <20260430172204.1006673-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Was removed in 2c08624 but it's still useful for
Windows 10 so reintroduce it there.

And this time, actually make it work by reporting
the hypervisor bit in CPUID.

Pretend to be vmware to be able to use vmport's functionality.

If the vmware frequency leaf is disabled, pretend to be
KVM, with the only capability reported being X2APIC support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h |  1 +
 accel/whpx/whpx-common.c       |  2 ++
 target/arm/whpx/whpx-all.c     |  1 +
 target/i386/whpx/whpx-all.c    | 61 +++++++++++++++++++++++++++++-----
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 5902124b637..cf782cf5f89 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -45,6 +45,7 @@ struct whpx_state {
 
     bool hyperv_enlightenments_allowed;
     bool hyperv_enlightenments_required;
+    bool hyperv_enlightenments_enabled;
 
 };
 
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b813a5d9d25..59be996aefc 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -550,6 +550,8 @@ static void whpx_accel_instance_init(Object *obj)
 
     whpx->hyperv_enlightenments_allowed = true;
     whpx->hyperv_enlightenments_required = false;
+    /* Value determined at whpx_accel_init */
+    whpx->hyperv_enlightenments_enabled = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be961..4019a513aa7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -968,6 +968,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
      * as they're not needed for performance.
      */
     if (whpx->hyperv_enlightenments_required) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4954e0557a7..f9f330c038f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2168,14 +2168,57 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-            reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-            reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-            reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+            if (whpx_is_legacy_os()) {
+                reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+            } else {
+                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
+                    vcpu->exit_ctx.CpuidAccess.Rcx,
+                    (UINT32 *)&reg_values[1].Reg32,
+                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                    (UINT32 *)&reg_values[3].Reg32);
+            }
 
-            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
-                if (cpu_has_x2apic_feature(env)) {
-                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+            if (!whpx->hyperv_enlightenments_enabled) {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 1:
+                    reg_values[2].Reg64 |= CPUID_EXT_HYPERVISOR;
+                    break;
+                case 0x40000000:
+                    /*
+                     * Use vmware_cpuid_freq as a proxy to report VMware.
+                     * This is to get the TSC/APIC frequency query functionality
+                     * provided through vmport, as Linux doesn't use leaf
+                     * 0x40000010 for getting those frequencies.
+                     */
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = 0x40000010;
+                        reg_values[4].Reg64 = 0x61774d56;
+                        reg_values[2].Reg64 = 0x4d566572;
+                        reg_values[3].Reg64 = 0x65726177;
+                    } else {
+                        /* report KVM otherwise if that's disabled */
+                        reg_values[1].Reg64 = 0x40000001;
+                        reg_values[4].Reg64 = 0x4b4d564b;
+                        reg_values[2].Reg64 = 0x564b4d56;
+                        reg_values[3].Reg64 = 0x4d;
+                    }
+                    break;
+                case 0x40000001:
+                    if (!x86_cpu->vmware_cpuid_freq) {
+                        /* KVM reporting of X2APIC support */
+                        reg_values[1].Reg64 = reg_values[4].Reg64 =
+                            reg_values[2].Reg64 = 1 << 15;
+                    }
+                    break;
+                case 0x40000010:
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = env->tsc_khz;
+                        reg_values[4].Reg64 = env->apic_bus_freq / 1000; /* Hz to KHz */
+                    }
+                    break;
                 }
             }
 
@@ -2396,6 +2439,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2601,6 +2645,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2653,7 +2698,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
+        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.54.0


