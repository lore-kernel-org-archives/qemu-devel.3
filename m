Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C8C109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMM-000565-W4; Wed, 25 Mar 2026 12:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RML-00050m-2N
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMH-0004g8-1A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ta7T0mi+8d9DVcASb2OtQTo0e14u/mzL90h8oJVlsXE=;
 b=bIni7stUK+EOdfY7yi7cHhl3eCCgfiQbuDhXs7YbV/1rfD9n+Km28uzQz6Dpj62gU/nq3H
 wsgUjLUU3rytwCF4suvb4Hq7+4Yll7tlTIqWOThyH56hEiEyqgvTtrjp1uHV55vdomz9ZP
 XB4RDpLtaniJFDfesHfx4tzilp0BwLU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-x8it0dRNNW6rF6HlvQfCHg-1; Wed, 25 Mar 2026 12:45:26 -0400
X-MC-Unique: x8it0dRNNW6rF6HlvQfCHg-1
X-Mimecast-MFC-AGG-ID: x8it0dRNNW6rF6HlvQfCHg_1774457126
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b42eee946so1017117f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457125; x=1775061925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ta7T0mi+8d9DVcASb2OtQTo0e14u/mzL90h8oJVlsXE=;
 b=mfqW6lTQ4UQ0fYOLJnYu9tD0N4XXetRusAD5d18A3YNfIm390unN/70QLVBtUUe4Cq
 SrgrH8RratF89osCqNk/aJDkc1n6lP90/C+OwPdK+sQI7VjnoxIocXa+NvzuJ1qkwZ70
 d/NxPDZsE1Ayq6Iyw/tU9/C6u1P1AVbXbGzoXviUVMTvPFJRkC1CDZuCNTyAKBiO+jQ9
 W6BCeoVeaascLMkPA4o8cMdWdXU9VDCuDJ7WYz7Mtsl/jhIoejIpPeeDfObwZExJOZm9
 NCQGnk/wcJNnuc6Q0X5dXVU2K9p8DtDOqYLjYpaOFhDMopT6J/BSm2HIuF+aW9LNMVbV
 3C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457125; x=1775061925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ta7T0mi+8d9DVcASb2OtQTo0e14u/mzL90h8oJVlsXE=;
 b=cCFK8zshpUAsC+kZOUrYZNjDLonl5QQgz0/NvY5i8N6y+OjhOVZQ1QHjXLnzdAyJb/
 hg8YUjSgaJrR6M7io+/mim2Nj5OT3DkCgtI6NxOBTZj/x2ob0RfN/U1DZUrTTMr9BOc6
 eGbLHRckUwqP+uWOEw4YL14sS9Hwhk9X+1M4xumAAlgElZ7plHQ6QJ7RVYM4ir2gOPzB
 XX5p0l/81W29JjVGc0CxYrwK+ToKHoXI+DDwPVclLvfNsIUXFQXleYtKUQFxVfv6GkL5
 vQ5BYC+fiCd6nUQ5qvb5dKDDI3p/2YMlc2KzFnpl1y84HVQCPOHc3pHFQWLQU31nCDU6
 FqNA==
X-Gm-Message-State: AOJu0YxUwp/iLE8RfTyHcRez8Q0O+EwQvdZ4XPrIPKqZMP1djDwOFyTK
 YUVEv1+aAnM2WWhvdTJS9VUDKonkkcVGbdm1se3Ncec/S1c9u5l6xwBC7yd3OI8mmDbvDtRJgLo
 9pJr3ZDdBkWzwSiW2wWIQXXkg444ZJo5sDdw26946RFXI1foJyoUxPRBvJvRJl4enx0xTZCqUSJ
 O7fHiVcKEq9Ih0CMVGhJe9qYcKaPdEd8mSR/60sjd2
X-Gm-Gg: ATEYQzxwYaox9WQeW6P+xsEjPq4fES3SieJ9CeKZ1XURmKsotlSjJ2nppxblIoTkORC
 0BmPWMgn36ErnhKm0dqWTMgmKzlWlNS7I6KqhA/tFlC4c5DMN1hq6y9L19eyBuhAa/3fv53QVBC
 MnaSP+rvqPoYgNg3o/G16zedchuhsydT3D4P77OAGurEtmwyyUxlfBMwjWnaiBQgl1/JFbYoQQt
 /dif46vj8u6D1KgA71ymNzXA6AC2ScmtePmKK2p50E1haROUUxzNGQIrpv01Aw3ebgnua2W/P0H
 Ap3h6cyhpYnzzGSDN5bOLkmyAE1m5pmnLxkJXas6VY8Rz2MBRSI3cKzU7Qyc7RV5Wg3zXPfkFi2
 B2qo//MC+6rlhvampGgepq/kD/P1cQnCYhPodT0DT8A9cYVVng6nUjG0HdBMYWNvqojev6mPRWj
 SYul+q7IG5v8e0Mr+5cc7TYslY
X-Received: by 2002:a05:600c:8708:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-487160241b4mr59526735e9.7.1774457125085; 
 Wed, 25 Mar 2026 09:45:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8708:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-487160241b4mr59526435e9.7.1774457124415; 
 Wed, 25 Mar 2026 09:45:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711764509sm142682835e9.13.2026.03.25.09.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 15/19] whpx: i386: fast runtime state reads
Date: Wed, 25 Mar 2026 17:44:49 +0100
Message-ID: <20260325164453.72127-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Now that there's an on-demand interface for fetching CRs
and segments, only query GPRs and query everything else
on-demand for vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-13-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 77 +++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6f232786422..acae61e089d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -156,6 +156,26 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
      */
 };
 
+static const WHV_REGISTER_NAME whpx_register_names_for_vmexit[] = {
+    /* X64 General purpose registers */
+    WHvX64RegisterRax,
+    WHvX64RegisterRcx,
+    WHvX64RegisterRdx,
+    WHvX64RegisterRbx,
+    WHvX64RegisterRsp,
+    WHvX64RegisterRbp,
+    WHvX64RegisterRsi,
+    WHvX64RegisterRdi,
+    WHvX64RegisterR8,
+    WHvX64RegisterR9,
+    WHvX64RegisterR10,
+    WHvX64RegisterR11,
+    WHvX64RegisterR12,
+    WHvX64RegisterR13,
+    WHvX64RegisterR14,
+    WHvX64RegisterR15,
+};
+
 struct whpx_register_set {
     WHV_REGISTER_VALUE values[RTL_NUMBER_OF(whpx_register_names)];
 };
@@ -593,6 +613,47 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
+static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    AccelCPUState *vcpu = cpu->accel;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int idx;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_for_vmexit,
+        RTL_NUMBER_OF(whpx_register_names_for_vmexit),
+        &vcxt.values[0]);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    idx = 0;
+
+    /* Indexes for first 16 registers match between HV and QEMU definitions */
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
+        env->regs[idx] = vcxt.values[idx].Reg64;
+    }
+    idx = idx_next;
+
+    env->eip = vcpu->exit_ctx.VpContext.Rip;
+    env->eflags = vcpu->exit_ctx.VpContext.Rflags;
+    rflags_to_lflags(env);
+
+    assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
+
+    x86_update_hflags(env);
+}
+
 void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -608,7 +669,11 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
+    if (level == WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        return whpx_get_registers_for_vmexit(cpu, level);
+    }
+
+    if (!env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
@@ -623,7 +688,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
+    if (whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -680,7 +745,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[4] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr8);
     tpr = vcxt.values[idx++].Reg64;
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && tpr != vcpu->tpr) {
+    if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
     }
@@ -691,9 +756,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      * Extended control registers needs to be handled separately depending
      * on whether xsave is supported/enabled or not.
      */
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
-        whpx_get_xcrs(cpu);
-    }
+    whpx_get_xcrs(cpu);
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
@@ -768,7 +831,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
+    if (whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
-- 
2.53.0


