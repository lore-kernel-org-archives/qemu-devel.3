Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA7ED58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzH-0005Yd-Hq; Mon, 02 Mar 2026 03:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxt-0003ia-Dq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxr-0002Jc-SK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQ0pJ2GkmExCaSdV0O5zvgfrDynBvwwWk9QdKJSzqkA=;
 b=DQ0v/VJsU08+4zo/MDJ6PpjwWDSnWzDt3YdGVLuRjcUOEk6cc0IvWeg8W64OrIjDYkJqqz
 dPv3yMG85JdwWFvCiohCnqyvCQYjae4KaOCr8XJlYj/jigCYz0IveuQxHDJHQAnvJ3BcMf
 QQH7ul8/9aIaghVxMvIwT+u9hK5rv8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-UmNky7RkM3ySi29Od0Ux3A-1; Mon, 02 Mar 2026 03:49:18 -0500
X-MC-Unique: UmNky7RkM3ySi29Od0Ux3A-1
X-Mimecast-MFC-AGG-ID: UmNky7RkM3ySi29Od0Ux3A_1772441357
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso34929555e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441356; x=1773046156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQ0pJ2GkmExCaSdV0O5zvgfrDynBvwwWk9QdKJSzqkA=;
 b=qgmbqRjwy0kJ2HXRwEfflIPlVjGdTy0HhMevV/6hIr3nCU5k5r3Us6Olt6e7tRuC6a
 TRtNFWHM4yLqr7VjU5F39/jKXevnwwSnWbhDRhgV9eGI9+yyjvfSij8IagHVYPvAoysD
 s2bAsiNmPgcZofpqJk09xuwG6Cjkj2f59z3kbitcJKNf9+83seZRVTV+LYlY8/Rg9J1s
 srHlwfglN7S59CzI+hHxMMZh5QpQfwzkP1Vjf6Q4pQqLlGW3l7KmDg6KDOVo0V578gwf
 8vrgScuEGE9uDGQ0whSBd7C0lNav+IeWhTo0qKcxHFZ5a1b8V/d0vfIxIxr79342NVi2
 pBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441356; x=1773046156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FQ0pJ2GkmExCaSdV0O5zvgfrDynBvwwWk9QdKJSzqkA=;
 b=j7Y4uRJJ6RG4BOYVIO+oO+waRjJraiNUzHb+AM/Yh3bvvwyG3hQMbpNt8bb347d1eB
 Md7YljnKLYiJzBCrnfWeQ4hvrwth6FZqEBw8EMO6HwyqxANGJwRO2eI/12mV5CPprYpr
 X2ulokk2qgnaqqZHJ8DPiSVuOJEDhRdaSTIWWTvItJsxY0CNBt/NVXZYzWkgzoHvgSjr
 qDJo0yMhjGOOmoYfVTdVCFQz9TQNwpaQfyyP2II02E4dK0c0noqOfduLOg5aglfk8y9y
 2842aI9P9qo/CLziSdBageoljlnyeieLXqLRu6wR5aIb8gn/EaaST6u5hSX1JFGbzGEr
 4n+A==
X-Gm-Message-State: AOJu0YyihTas2zshpNFXbQlc37YoqUUCZz7qVsfpZnt8lWYENG1Lq8py
 +LYlfyQjAb2uZvMMZ9+S/LZsrPj+Y7tLiukHO9cRoP/82PymmvFNr2a6vaR87bNK66JOaEYw/VG
 y5H8+Olhk6EGvcckMQJSrg31lH5eSz90mgRpFXyxhv2u+73gLzVSfzlPWTon4yMGe+5CDzSkdUZ
 4Cg0O8vU8c/W7Z5UqRBecrU3+JyaSYvfSLY117hSp7
X-Gm-Gg: ATEYQzxCjg7sJF2Jd3GTIpf01W9AQQ2MqVabPaVZeU5dxam9A61h3gt+nSYTYg5f7nZ
 bnXviHj+i4uFVGLcX9wv/NZ0NSYXgp0UnMaKqtOIzHFHKEhaGo5s0jrHI01W6tTLQT459Nt2rN7
 oZBAlmg/rmtqNhVHQxAFWDU3TPjE5V26VhWz6PDfimyHfAVfCTKWIerWXKAgWj/ytNxA/XIEl7W
 4PeFiGYfu2zG5IopFsmswU/wjxSgLYjw1ijUFiDHF4qUWSdr/YbiN4ldYhamA5Gw8C8+0KFjgrO
 7YqJu7NWlNtmCOJmMp976dbolJmLIgC2cIifSHtTCuYD+nsbgpKnG/doXgTZQePFZ1JTbdc2Hmb
 8+raVUUpM0gLZ0RO3AxhO/Sg1LwNftXTXPsl+0aVFXGBeEVH2VLDXaHVeMk1+dM4r6gXLJvqq57
 Ar44J7+on63EJRSDrpao6eGWZ+LYc=
X-Received: by 2002:a05:600c:6215:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483c9becbc1mr207229705e9.15.1772441356391; 
 Mon, 02 Mar 2026 00:49:16 -0800 (PST)
X-Received: by 2002:a05:600c:6215:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483c9becbc1mr207229395e9.15.1772441355934; 
 Mon, 02 Mar 2026 00:49:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm413760335e9.7.2026.03.02.00.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 101/102] whpx: i386: expose HV_X64_MSR_APIC_FREQUENCY when
 kernel-irqchip=off
Date: Mon,  2 Mar 2026 09:47:47 +0100
Message-ID: <20260302084749.474955-35-pbonzini@redhat.com>
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

Now that we expose AccessFrequencyRegs, expose HV_X64_MSR_APIC_FREQUENCY as well for the case when the Hyper-V LAPIC is not used.

If the Hyper-V LAPIC is used, this will be handled by the hypervisor instead of the VMM, hence gating it on !whpx_irqchip_in_kernel().

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-8-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7ccf92e4d11..c172e86886b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -45,6 +45,8 @@
 #include <winhvplatform.h>
 
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
+/* for kernel-irqchip=off */
+#define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -1802,6 +1804,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[3] = {0};
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
+            bool is_known_msr = 0; 
 
             reg_names[0] = WHvX64RegisterRip;
             reg_names[1] = WHvX64RegisterRax;
@@ -1811,6 +1814,12 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_APIC_FREQUENCY
+                && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()) {
+                is_known_msr = 1;
+                reg_values[1].Reg32 = (uint32_t)X86_CPU(cpu)->env.apic_bus_freq;
+            }
             /*
              * For all unsupported MSR access we:
              *     ignore writes
@@ -1819,8 +1828,10 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
-            warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
+            if (!is_known_msr) {
+                warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
                 vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+            }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
@@ -1988,6 +1999,10 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
+    /* When not using the Hyper-V APIC, the frequency is 1 GHz */
+    if (!whpx_irqchip_in_kernel()) {
+        env->apic_bus_freq = 1000000000;
+    }
 
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
@@ -2201,7 +2216,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.Hv1 = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
-    /* if kernel-irqchip=off, HV_X64_MSR_APIC_FREQUENCY = 0. */
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
-- 
2.53.0


