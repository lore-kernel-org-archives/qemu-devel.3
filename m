Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B287D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytH-0001lw-RZ; Mon, 02 Mar 2026 03:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytB-0001i7-OV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt7-0001Y4-Os
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPx0GudsuJ7+vudVgsrPzB4kl2V8XPk+UFVlv6vuYpE=;
 b=YWG+mAVA4miQXSuCGykbx4nPUNxZ7nXEhauSU9FIWgIH4OJR33PBFCU/T91lwdZVuP8zoB
 acheSmKKUSxeR0lemz//EN6b2ifvwmnOGg/O5YtzRWwPhUCOGypblj6R5Okapy71iv+GVI
 WqPQxmLyMvhViHr3jntrPBOAc6ZmEHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-078gXQzVOK6mdD9ep7cooQ-1; Mon, 02 Mar 2026 03:44:24 -0500
X-MC-Unique: 078gXQzVOK6mdD9ep7cooQ-1
X-Mimecast-MFC-AGG-ID: 078gXQzVOK6mdD9ep7cooQ_1772441063
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so42861685e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441062; x=1773045862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPx0GudsuJ7+vudVgsrPzB4kl2V8XPk+UFVlv6vuYpE=;
 b=OX2b6Easu6uUyU6TBtNPnB5yaJymDiFwq384QYblEclwMnzN0gLX1anJdKvBNYGnvg
 Jv7f6qnpV5/P0a2JiUo5EttSvMNWREwYquawfM5kp5caI4O6oWC0EUSV2r81PP+PIfSX
 Cni4WkDA4ZPwO7glqjAzr6+Mz/5URbnvGi6XDhpwDinTsNZQYFAtxWzCrRcGHEZCSPjm
 XOgf8NNNxF2xj3wWo54oX/BN3zgxIaapji6ihck+sB9f19c1P7GPyYN3lvqdfMkOV2hj
 IDxVO6qdVJy59dbLO6O2rn0Ycje86gJmsIKOv3jVWNQoqESOG9Z0XAWck0Yds2Ii3gvM
 lUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441062; x=1773045862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPx0GudsuJ7+vudVgsrPzB4kl2V8XPk+UFVlv6vuYpE=;
 b=RCQbdIQiM4y8Nj/XwoBLJ3agYlJHadxpI2VES6lZRFCmr7gm/cQZdhcqC3DYE9Ovze
 UyjDCVnxg3EQrnqqaA89EV6MfYofbQrm9C5+NthwdV8PzUmN4A41FVZGziCg7Q9Rd6Om
 Sj0efaX/3cY/fXOJbsm3t34vstLL1fF7Akskxl/qqWKYYdlbdlWsyslGKXDEIOLfnKiw
 SRWHJDKONhzXz+P3FWPd7SN2kVXA4I6FvmFKaLWYM8HDt4pMjkqjNTMyTDOmVtKiYftw
 qhVwmg9FQhthBHe62n3pabnmZineV/SLny33D40qseu3UJr1GjGCMw/bSCiWAgQyRGIB
 g+QA==
X-Gm-Message-State: AOJu0YyjE/qWKq20AeQLxDporDAw0iVO/or2S/tcmWYB+8AZsJMtnyYh
 xhc5G88oKWXb0mv1mQkeVx+Dn8xb8Cvd0TumjOyljMHf2HHmgkGJn1RWdtrgKbF06coRFLbJ1Xp
 YnWd2tffxO4YzM4H9eh3H9u/pAkxk7mv0j8gpoo0WwjralpHfIFqMdaf0PbZB3IcbSKoIBqPOUb
 dsVgeQ5ndVt65aBzwc4b0Fhy7EVfsKD+dQ727LEtG9
X-Gm-Gg: ATEYQzyVCX/M8k5FGQ21luyDypelVYQPecnLSorwjptz2gihE2mpOTYfMe5pV//5LkV
 DSiHjW+bLdN6MCaqJ94eGN024yJPKOoGtcgaNlkbeQodz91yXfVK3lNa0BRZDRLia8TcF83KG9z
 UT2rCLOJqNEkbPTkXrJGoPxIz2rs5hDeVaWM4hWa1K77yxQgLjaCOEZcrKtVhH9Wju8ms+j6RDz
 3H3L/9SQz9PaOA8xvqIVFN0sfubXbmtyJt85KI08He/7Tr0ftt51tcWYONEWYGIkWBwpayU1TVZ
 D5TqeAJKZs/xFOVtUJHJ0xQW1eWylIOzCqhL1FIukMlf0jPY1TrkFc4XwNru+s2pTHwz07/rgOo
 TXooI2dDjZwMgA/qGn5FUBSEDf6fOhYQ8KXWw2KGd6qv9mO736LPg5JFm4+3xJvQtxHW5xPMe8s
 PpA7Q30+HA934K82IWFJMZJBk2crc=
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr143316145e9.7.1772441061756; 
 Mon, 02 Mar 2026 00:44:21 -0800 (PST)
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr143315865e9.7.1772441061270; 
 Mon, 02 Mar 2026 00:44:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55d15besm8961321f8f.30.2026.03.02.00.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 015/102] whpx: i386: remove CPUID trapping
Date: Mon,  2 Mar 2026 09:42:10 +0100
Message-ID: <20260302084338.473368-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Very partial in its current state and results in significantly inconsistent
CPUID data. Remove it until it's reimplemented later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-15-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 104 ------------------------------------
 1 file changed, 104 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2f2c613eda0..baa3169c55c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1795,75 +1795,6 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = 0;
             break;
         }
-        case WHvRunVpExitReasonX64Cpuid: {
-            WHV_REGISTER_VALUE reg_values[5];
-            WHV_REGISTER_NAME reg_names[5];
-            UINT32 reg_count = 5;
-            UINT64 cpuid_fn, rip = 0, rax = 0, rcx = 0, rdx = 0, rbx = 0;
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUX86State *env = &x86_cpu->env;
-
-            memset(reg_values, 0, sizeof(reg_values));
-
-            rip = vcpu->exit_ctx.VpContext.Rip +
-                  vcpu->exit_ctx.VpContext.InstructionLength;
-            cpuid_fn = vcpu->exit_ctx.CpuidAccess.Rax;
-
-            /*
-             * Ideally, these should be supplied to the hypervisor during VCPU
-             * initialization and it should be able to satisfy this request.
-             * But, currently, WHPX doesn't support setting CPUID values in the
-             * hypervisor once the partition has been setup, which is too late
-             * since VCPUs are realized later. For now, use the values from
-             * QEMU to satisfy these requests, until WHPX adds support for
-             * being able to set these values in the hypervisor at runtime.
-             */
-            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx,
-                (UINT32 *)&rcx, (UINT32 *)&rdx);
-            switch (cpuid_fn) {
-            case 0x40000000:
-                /* Expose the vmware cpu frequency cpuid leaf */
-                rax = 0x40000010;
-                rbx = rcx = rdx = 0;
-                break;
-
-            case 0x40000010:
-                rax = env->tsc_khz;
-                rbx = env->apic_bus_freq / 1000; /* Hz to KHz */
-                rcx = rdx = 0;
-                break;
-
-            case 0x80000001:
-                /* Remove any support of OSVW */
-                rcx &= ~CPUID_EXT3_OSVW;
-                break;
-            }
-
-            reg_names[0] = WHvX64RegisterRip;
-            reg_names[1] = WHvX64RegisterRax;
-            reg_names[2] = WHvX64RegisterRcx;
-            reg_names[3] = WHvX64RegisterRdx;
-            reg_names[4] = WHvX64RegisterRbx;
-
-            reg_values[0].Reg64 = rip;
-            reg_values[1].Reg64 = rax;
-            reg_values[2].Reg64 = rcx;
-            reg_values[3].Reg64 = rdx;
-            reg_values[4].Reg64 = rbx;
-
-            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-                whpx->partition, cpu->cpu_index,
-                reg_names,
-                reg_count,
-                reg_values);
-
-            if (FAILED(hr)) {
-                error_report("WHPX: Failed to set CpuidAccess state registers,"
-                             " hr=%08lx", hr);
-            }
-            ret = 0;
-            break;
-        }
         case WHvRunVpExitReasonException:
             whpx_get_registers(cpu);
 
@@ -2017,26 +1948,6 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
-    /*
-     * If the vmware cpuid frequency leaf option is set, and we have a valid
-     * tsc value, trap the corresponding cpuid's.
-     */
-    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
-        UINT32 cpuidExitList[] = {1, 0x80000001, 0x40000000, 0x40000010};
-
-        hr = whp_dispatch.WHvSetPartitionProperty(
-                whpx->partition,
-                WHvPartitionPropertyCodeCpuidExitList,
-                cpuidExitList,
-                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
-
-        if (FAILED(hr)) {
-            error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
-                        hr);
-            ret = -EINVAL;
-            goto error;
-        }
-    }
 
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
@@ -2073,7 +1984,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY whpx_cap;
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
-    UINT32 cpuidExitList[] = {1, 0x80000001};
     WHV_CAPABILITY_FEATURES features = {0};
 
     whpx = &whpx_global;
@@ -2183,7 +2093,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
     if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
@@ -2200,19 +2109,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-        whpx->partition,
-        WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
-        RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
-                     hr);
-        ret = -EINVAL;
-        goto error;
-    }
-
     /*
      * We do not want to intercept any exceptions from the guest,
      * until we actually start debugging with gdb.
-- 
2.53.0


