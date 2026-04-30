Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC02CCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6o-00058C-Kj; Thu, 30 Apr 2026 13:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6m-00057g-Oa
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6k-0004Wa-Qj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrrYi2ue+3bTKCPt5d+oRdeOWzgvkw8aVoum6MvS2Ls=;
 b=Ajlpz0WwgGARkbzP98Tf46z60HSosYEWYhhkHEi9fVUy1Ifcnuvxk/HJi5al5pxPvfynM/
 7D0jQjAHQgOnPlg73eqHsCX0bDhAwI5T/a4hmyr3D5beKxxlD72UWgPRjHUdunNhMgnt+9
 UUuMjMkdrtuLCd1z7sYBjVo+NsTNR1E=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-gkelx9nAM-2pV7srHrDviA-1; Thu, 30 Apr 2026 13:23:24 -0400
X-MC-Unique: gkelx9nAM-2pV7srHrDviA-1
X-Mimecast-MFC-AGG-ID: gkelx9nAM-2pV7srHrDviA_1777569804
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6102a8e6eb0so818348137.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569803; x=1778174603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrrYi2ue+3bTKCPt5d+oRdeOWzgvkw8aVoum6MvS2Ls=;
 b=MKKf12B5XeEqkLGX/st7nkFvU4k0yG+JoRhgpi5xuGPVFGH0kqgnXi0ALujlZsAt87
 HxtP/eIfyDilsLhbiFInAJim+bmL1/2nMjAo+ZnJ5MoHu179Fagk+eX04ogKkcTmMwKI
 Q/uzbIunmWodXAKkbk1ux+gsZL5ZPVCdfvoaWF1tLsfxTFWuJnDZj0L3gXW4GJ+nFFsk
 kZ7mtHoNOm4psO6kZtW+6iodySz/kpzD+deMkVe2tAZblFOrpRRPQDas2WVeTfMtWCqC
 CHMKZD/fLCOZxjphuQhYamDPyNax3p0VajajHl7Y8agIS2SJFr1RfA3//xAkipZfwZKQ
 OIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569803; x=1778174603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZrrYi2ue+3bTKCPt5d+oRdeOWzgvkw8aVoum6MvS2Ls=;
 b=cEZmGlq4ntvlyGOiV0cXsAjG65qk7u/2fWbEm2Mjggx3CNgwnWXIyrmYfRmUX4+WjF
 vx1bymMsyqqkfHj8UPDefG9gtkijCoFc5+fLr0a5Cgvkx7q0uSfeynztdCB1k9+VjxoD
 cfKWvn2HcqQZNl9GH7PDtLTHM0vhB5XsSdkRu/pW94xZCGqU2DEIsv+RHlgmji0kR8sa
 N2ZMIgJfMVvxvbja8tK4W0ccz4G8dRuLF5ng2KRq7HMXxqzkby3kA1HxwK6syDUb6mVv
 hJPWYSHE3mOukDg7eZ6lPBUXd/pCOUlZhg5JHKmyhasOpx7Ccjt8ejLZ3wgoyA385evO
 +kKg==
X-Gm-Message-State: AOJu0YzOqnHLE3XTmYlzmlEfTXuLxFw/TpXE/1JoaFlugdrkcym0N1Uc
 m/eacvxKZNeGC7AGTTGxrKfhH9vRc10uzisNzB9F7tdTF5nvES98i1ZZFXAJ8bMqbgBvkCQIg2h
 RM/W8kZM6QWMzi60UJxXF09I/2Oqnj9AyChQ5vLT931xYiI7wrjjhVLG/as9v2RaUgoMUaNvo27
 x9WwpGFtwtUy6Bz/oNFuWT8asjjaMjWPeWjFIjwV9j
X-Gm-Gg: AeBDiet+HQb6d13NRGJF5XftYTK8IjMXbuMtzLHRrJj+csQ1rWx2ZA9Sit26c8NtMd1
 3FRFCd2glJubPKvq+jEwDJZLH0sVtHiA/nTKvBs+JfJ07kMTc40hIibCw64O8/00y9Vo6N3F4Yc
 KaATG2J10r+/XSLQnt1Xrr3OpCBlv5iAATp1vaHI6Tq4+XL3SRQwzaqhN2J+HgTGEvociUmGzGJ
 Jhn82MSCQH8xLWNvYp5wr9ITJmcfNhl68/XpodXRmxHpREtaYP6tK7ALSR1izcf3hs4sVK/zY1A
 ghhJmpgTOlUq9YeG41ivfB56NSAcecm2D7il4pd2oqhOzkkU2fYyn8hCt7UZMl1/Sq7DFQGANqD
 0a9mKN0gCL7Jh96tEYCbdeazumNqqRG9Yxrh0ocB8ctPQxwJ7+Pxs0EsGMxUTbetbhX+yhzApCG
 Os3M7wjQ7qK5qN12aCq72igErJnS11vyQvkwA=
X-Received: by 2002:a05:6102:38d0:b0:618:3503:5663 with SMTP id
 ada2fe7eead31-62ad233dd89mr2006057137.8.1777569803522; 
 Thu, 30 Apr 2026 10:23:23 -0700 (PDT)
X-Received: by 2002:a05:6102:38d0:b0:618:3503:5663 with SMTP id
 ada2fe7eead31-62ad233dd89mr2006001137.8.1777569802945; 
 Thu, 30 Apr 2026 10:23:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff30903fsm24231016d6.3.2026.04.30.10.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 24/58] whpx: i386: x2apic emulation
Date: Thu, 30 Apr 2026 19:21:30 +0200
Message-ID: <20260430172204.1006673-25-pbonzini@redhat.com>
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

Add x2apic emulation to WHPX for the kernel-irqchip=off case.

Unfortunately, it looks like there isn't a workaround available
for proper behavior of PIC interrupts when kernel-irqchip=on
for Windows 10. The OS is out of support outside of extended
security updates so this will not be addressed.

The performance boost is quite visible for multicore guests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 134 +++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e56ae2b3433..4127440c0ca 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1082,6 +1082,8 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
+    prop.ExtendedVmExits.X64CpuidExit = 1;
+
     if (exceptions != 0) {
         prop.ExtendedVmExits.ExceptionExit = 1;
     }
@@ -1898,6 +1900,18 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            uint64_t val;
+
+            if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                val = ((uint32_t)vcpu->exit_ctx.MsrAccess.Rax) |
+                    ((uint64_t)(vcpu->exit_ctx.MsrAccess.Rdx) << 32);
+            } else {
+                /*
+                 * Workaround for [-Werror=maybe-uninitialized]
+                 * with GCC. Not needed with Clang.
+                 */
+                val = 0;
+            }
 
             reg_names[0] = WHvX64RegisterRip;
             reg_names[1] = WHvX64RegisterRax;
@@ -1911,7 +1925,47 @@ int whpx_vcpu_run(CPUState *cpu)
                 && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
                 && !whpx_irqchip_in_kernel()) {
                 is_known_msr = 1;
-                reg_values[1].Reg32 = (uint32_t)X86_CPU(cpu)->env.apic_bus_freq;
+                val = X86_CPU(cpu)->env.apic_bus_freq;
+            }
+
+            if (!whpx_irqchip_in_kernel() &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
+                is_known_msr = 1;
+                if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                    /* Read path unreachable on Hyper-V */
+                    abort();
+                } else {
+                    WHV_REGISTER_VALUE reg = {.Reg64 = val};
+                    int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
+                }
+            }
+
+            if (!whpx_irqchip_in_kernel() &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber >= MSR_APIC_START &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber <= MSR_APIC_END) {
+                int index = vcpu->exit_ctx.MsrAccess.MsrNumber - MSR_APIC_START;
+                int msr_ret;
+                is_known_msr = 1;
+                if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                    bql_lock();
+                    msr_ret = apic_msr_read(X86_CPU(cpu)->apic_state, index, &val);
+                    bql_unlock();
+                    reg_values[1].Reg64 = val;
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                } else {
+                    bql_lock();
+                    msr_ret = apic_msr_write(X86_CPU(cpu)->apic_state, index, val);
+                    bql_unlock();
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                }
             }
             /*
              * For all unsupported MSR access we:
@@ -1921,6 +1975,11 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
+            if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                reg_values[1].Reg32 = (uint32_t)val;
+                reg_values[2].Reg32 = (uint32_t)(val >> 32);
+            }
+
             if (!is_known_msr) {
                 trace_whpx_unsupported_msr_access(vcpu->exit_ctx.MsrAccess.MsrNumber,
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
@@ -1939,6 +1998,47 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = 0;
             break;
         }
+        case WHvRunVpExitReasonX64Cpuid: {
+            WHV_REGISTER_VALUE reg_values[5] = {0};
+            WHV_REGISTER_NAME reg_names[5];
+            UINT32 reg_count = 5;
+            X86CPU *x86_cpu = X86_CPU(cpu);
+            CPUX86State *env = &x86_cpu->env;
+
+            reg_names[0] = WHvX64RegisterRip;
+            reg_names[1] = WHvX64RegisterRax;
+            reg_names[2] = WHvX64RegisterRcx;
+            reg_names[3] = WHvX64RegisterRdx;
+            reg_names[4] = WHvX64RegisterRbx;
+
+            reg_values[0].Reg64 =
+                vcpu->exit_ctx.VpContext.Rip +
+                vcpu->exit_ctx.VpContext.InstructionLength;
+
+            reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+            reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+            reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+            reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
+                if (cpu_has_x2apic_feature(env)) {
+                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                }
+            }
+
+            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+                whpx->partition,
+                cpu->cpu_index,
+                reg_names, reg_count,
+                reg_values);
+
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to set CpuidAccess state "
+                             " registers, hr=%08lx", hr);
+            }
+            ret = 0;
+            break;
+        }
         case WHvRunVpExitReasonException:
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
@@ -2136,6 +2236,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     bool is_legacy_os = false;
+    UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
 
@@ -2354,6 +2455,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
+    prop.ExtendedVmExits.X64CpuidExit = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
@@ -2366,6 +2468,36 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.X64MsrExitBitmap.UnhandledMsrs = 1;
+    if (!whpx_irqchip_in_kernel()) {
+        prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeX64MsrExitBitmap,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set MSR exit bitmap, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeCpuidExitList,
+        cpuidExitList,
+        RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
+                     hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /*
      * We do not want to intercept any exceptions from the guest,
      * until we actually start debugging with gdb.
-- 
2.54.0


