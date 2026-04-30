Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C3CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7e-0006ll-6v; Thu, 30 Apr 2026 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV79-0005h3-G0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV73-0004fx-MD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrlgUVmKIcklvlQ6VrV7ja7cgjXTrKMc+MR7Zp/wym4=;
 b=MJfL/tLKM5JwxTSGPr2W0fRx5Y6mky1GmqHsdirApIIdDIzOFZy7IZDoP4zXCbD48QH/bH
 C/XB9GsFswDQvwL9omKAifhRckKh3GFf1loGQ8/D+ugVwLU+QfWMgmyzMj3QJ7rzVHpm5b
 G3+8dveRqcIe+tikWHdWBUzAKa6Mggo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-baDTZ2i6Nfqe6y5b_hIO0g-1; Thu, 30 Apr 2026 13:23:40 -0400
X-MC-Unique: baDTZ2i6Nfqe6y5b_hIO0g-1
X-Mimecast-MFC-AGG-ID: baDTZ2i6Nfqe6y5b_hIO0g_1777569820
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-612ef4e6c54so2136658137.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569820; x=1778174620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrlgUVmKIcklvlQ6VrV7ja7cgjXTrKMc+MR7Zp/wym4=;
 b=k2lulUoXo4cupVEjMXfQT4GnWxutyml3BKPSc0Xx6SYIfamAntx7I3JDj//kb/SbaO
 /XAHrfXyqIrC0rLD6R7Htjigs1kJoBRdKXLwtXhMZjD4O3dG0JzM7JCaOIjh6+FobsPL
 jn1VbKEI5tBxT4q0KyKizDzXvURloOZjO2ygZAtvLABgS/GdKGagmTtYIje9SlQa2Du6
 GYFwBL7tjXi7pH0qUc2Nmhbj5WZOLeU3ANpRm9RoD2aZQ1AxSDBoyTxRzXsNgjHUDnJj
 QiHGi5qVWv+93EYK0wcz+BXtd0MgX9/+VfHwta/GV+opfSvPbkQPM18mmAIzopVYhKBl
 xE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569820; x=1778174620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xrlgUVmKIcklvlQ6VrV7ja7cgjXTrKMc+MR7Zp/wym4=;
 b=Zb1m/nFB2mmV/mnO45LkmE4oIoK6sr6+osjrct1plSh+oNi+RMaWQ+pd5f9kxux35s
 9M4WGPznWtXo6VD5YJEa5/CYo6F72j5HGX5qcfQex6tbj48lUXHNpe1yDoAQODnyeWoQ
 qXo6f18wWiyXCUbgTsMWJY1CuRuebyhu3XXucsm6Iz8jgI7Sch/jRw4b07FJQlTzoGrk
 twf3bBkOgdUyrqMZLRDEPmwJre9hjVj9QW1x0uGPGDNQsbbLgk0hi7YcYrzbEUXwigw0
 /Ec3OfkdIqsEGAL9aqGalT7sRR/IN1US7acRQ0TMO4MLT6ZCuxDhx9x36yL7Vvlft25O
 nPuw==
X-Gm-Message-State: AOJu0Yzd6GTDz9WHu0vwvcsFrr9vH6d1K1tvilR0AOnjB/6aHR5ySO/2
 rFEQB11zZGjUQlvsgaqNQOmpFsfrGopgF4ArUVB/0m9vtd5SLbhvQnA++d0b6QfTz5vnZnRZuTA
 EIZKa39BimIYfgKxqt6x/YsEOxD7dTRxh8BP/eqPYyh+O2xtJUw6PKGr2uz7cSdI6rEoCIPNdmo
 808LLyCUvd32zEcZaceW9Vy878WmpE35/T3WL5qWFJ
X-Gm-Gg: AeBDies1GGG0sKaFTKuJb1omY0m9oct8EHyxNf5pZyincxPQgfiljr2LCE5PTyYELQU
 VK1sitbm1VBvFpauK7A8tP3qOL6Z56fGvCqeFhkPbOKDIx5cI0ZXn3zG5zI8UTxJtMvaC/17Yyh
 hKF6B1kDYQ2aRSM/SSyXkYu2YMhFHFjkCRpM5Fro0ZrwXS2S0Y+Qr3Btkj3oYdslni/Og2UodzP
 lJTaz0WcNNVXc3zBOwj1jJ0zvsSErOhG+xgNyQIniteeVft8UpeBODa/NwSZsPLmPsFEpB5OuI5
 e6daGRzzqRQQZiXrh+cXFg61j6/h9Lm7se3UnvLrpzsbtGOfueFHAwpXy/UzT70RIqbWHJHQJ57
 cVDlow8PeAlrG2ziNrSb4Tolc50DoLPg7U77R2FFyRbqSljCgTcuNiMC77uwp+2C1cAsOZvsBl5
 M2ybOs8EvkO09CJRzgThwRcYVoJJ6YXE3f28w=
X-Received: by 2002:a05:6102:2b83:b0:607:a215:5b7e with SMTP id
 ada2fe7eead31-62ad233d0c3mr2606631137.7.1777569819577; 
 Thu, 30 Apr 2026 10:23:39 -0700 (PDT)
X-Received: by 2002:a05:6102:2b83:b0:607:a215:5b7e with SMTP id
 ada2fe7eead31-62ad233d0c3mr2606398137.7.1777569817452; 
 Thu, 30 Apr 2026 10:23:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff32ee6asm22974816d6.19.2026.04.30.10.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 29/58] whpx: i386: introduce proper cpuid support
Date: Thu, 30 Apr 2026 19:21:35 +0200
Message-ID: <20260430172204.1006673-30-pbonzini@redhat.com>
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

Unlike the implementation in QEMU 10.2, this one works.

It's not optimal though as it doesn't use the Hyper-V support for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-8-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c        | 136 +++++++++++++++++++++++++----
 target/i386/whpx/whpx-cpu-legacy.c |  15 +---
 2 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f9f330c038f..73e351d895d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2168,18 +2168,11 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            if (whpx_is_legacy_os()) {
-                reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-                reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-            } else {
-                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
-                    vcpu->exit_ctx.CpuidAccess.Rcx,
-                    (UINT32 *)&reg_values[1].Reg32,
-                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
-                    (UINT32 *)&reg_values[3].Reg32);
-            }
+             cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
+                vcpu->exit_ctx.CpuidAccess.Rcx,
+                (UINT32 *)&reg_values[1].Reg32,
+                (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                (UINT32 *)&reg_values[3].Reg32);
 
             if (!whpx->hyperv_enlightenments_enabled) {
                 switch (vcpu->exit_ctx.CpuidAccess.Rax) {
@@ -2220,6 +2213,68 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                     break;
                 }
+            } else {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 0x40000000:
+                case 0x40000001:
+                case 0x40000010:
+                    reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                    reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                    reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                    break;
+                }
+            }
+
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x1) {
+                if (cpu_has_x2apic_feature(env)) {
+                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_EXT_X2APIC;
+                }
+            }
+
+            /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x07
+                && vcpu->exit_ctx.CpuidAccess.Rcx == 0) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRdx
+                    & CPUID_7_0_EDX_CET_IBT) {
+                    reg_values[3].Reg32 |= CPUID_7_0_EDX_CET_IBT;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_7_0_EDX_CET_IBT;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_CET_SHSTK) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_CET_SHSTK;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_CET_SHSTK;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_OSPKE) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_OSPKE;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_OSPKE;
+                }
+            }
+
+            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                }
+            }
+
+            /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_EXT_OSXSAVE) {
+                    reg_values[2].Reg32 |= CPUID_EXT_OSXSAVE;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_EXT_OSXSAVE;
+                }
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -2409,6 +2464,45 @@ error:
     return ret;
 }
 
+static void whpx_cpu_xsave_init(void)
+{
+    static bool first = true;
+    int i;
+
+    if (!first) {
+        return;
+    }
+    first = false;
+
+    /* x87 and SSE states are in the legacy region of the XSAVE area. */
+    x86_ext_save_areas[XSTATE_FP_BIT].offset = 0;
+    x86_ext_save_areas[XSTATE_SSE_BIT].offset = 0;
+
+    for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+        ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+        if (esa->size) {
+            int sz = whpx_get_supported_cpuid(0xd, i, R_EAX);
+            if (sz != 0) {
+                assert(esa->size == sz);
+                esa->offset = whpx_get_supported_cpuid(0xd, i, R_EBX);
+            }
+        }
+    }
+}
+
+static void whpx_cpu_max_instance_init(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->cpuid_min_level =
+        whpx_get_supported_cpuid(0x0, 0, R_EAX);
+    env->cpuid_min_xlevel =
+        whpx_get_supported_cpuid(0x80000000, 0, R_EAX);
+    env->cpuid_min_xlevel2 =
+        whpx_get_supported_cpuid(0xC0000000, 0, R_EAX);
+}
+
 static PropValue whpx_default_props[] = {
     { "x2apic", "on" },
     { NULL, NULL },
@@ -2418,9 +2512,18 @@ static PropValue whpx_default_props[] = {
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
     x86_cpu_apply_props(cpu, whpx_default_props);
+
+    if (xcc->max_features) {
+        whpx_cpu_max_instance_init(cpu);
+    }
+
+    if (whpx_has_xsave()) {
+        whpx_cpu_xsave_init();
+    }
 }
 
 /*
@@ -2438,8 +2541,11 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    UINT32 cpuidExitList[] = {1};
-    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
+
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0xd, 0x14, 0x24, 0x29, 0x1E,
+        0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
+        0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
+        0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
 
     whpx = &whpx_global;
 
@@ -2698,7 +2804,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
+        cpuidExitList,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
index 477429b460f..d341e6f4fd1 100644
--- a/target/i386/whpx/whpx-cpu-legacy.c
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -4,20 +4,7 @@
  *  Copyright (c) 2003 Fabrice Bellard
  *  Copyright (c) 2017 Google Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * cpuid
+ * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
 #include "qemu/osdep.h"
-- 
2.54.0


