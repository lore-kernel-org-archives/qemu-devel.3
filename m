Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6BBC5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu2G-0003ew-QF; Fri, 30 May 2025 03:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx4-0002ub-EM
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx2-00070N-Nk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jmpDw1T1/5I4f6wdS2/NdtGMFfIeFlvGVbgUNgbSXk=;
 b=OanKvnVieYz6jmsT/EjTQ/ybmhXhF0Ae5tQ85XfXuLCzR5ICfXUXm4FVprjT9AkjlrdSlX
 OLpfnjxbpn8eVVHNxb+WkZI7AzT5p+o8tdlSgo50+ub9vLv5kfG7hUKipdHnoFB8zdCtG5
 wnElefp7e7dt63iQ+qaQDYeASmZ+csg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-H-3VEmHoNfCEXVEdF_9zLQ-1; Fri, 30 May 2025 03:14:46 -0400
X-MC-Unique: H-3VEmHoNfCEXVEdF_9zLQ-1
X-Mimecast-MFC-AGG-ID: H-3VEmHoNfCEXVEdF_9zLQ_1748589285
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad9a8a5ecc6so186401066b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589285; x=1749194085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jmpDw1T1/5I4f6wdS2/NdtGMFfIeFlvGVbgUNgbSXk=;
 b=eMNlA+5j1saJhH+l+URRBA07qepOvpTcbTBlha4G+llnJih25MeYpDEY3LIuoQlnOq
 /M1EAWs3IFnFVUJxT9MXRt6H0D2CewYnNRD0xmHwx2/fN6rkc1BV0LvJPzMpNt/rqjWw
 600TXwDFhWFgdfLZuIY2l252sf8/RTCSC3PiCPuXUA+Ky+jwPcql2Ka3q07JnZuJ1DyA
 ciBDZ1bu55I7NjYZssooFAGRWeN+6M5eKVUWnwmdmXAML7/MDDtLoOJaPYYvllGqbMMn
 B0wfAvyj+vgicwaDMqlH2/nOagrjiXo+dgTc398LiKNLKlAMjgrXHGYojIeQwSY8Zg5B
 pt4g==
X-Gm-Message-State: AOJu0YwjUWpHEJIc9fYZ1OGRrItXxGcpBqY4XhmsyM21qyTN0q0KtZa9
 PvkxV60fJFONXSQ1fbk2ZrG2ct6ylQIZf+SOHpDhoZ4WbJLjO2QIB39jXWD3G4I4Lm7E92jW7Je
 2kE2H5PaU+LAkH1Icdgu/BzpCJQlq4e0dW32hmHb18PGl2LHGrid42RwirZP0izshyvWMfHPzS1
 fjSHjkdsRySf4pPc5fQWktgFqV+ZaYqkyehAo75wLA
X-Gm-Gg: ASbGnctdmmKnMTF/kj87MDNyTjwN/yY9SNcIK+xAZzHzY4c8TiiratZ1RZtEaijTZw5
 /AHcL3C0nVg7H/0Hnk5ZPWyhcI1UHtUcYWz/iPuYJIhOdT+zouxAD3lz0BaYrbZN0KHUKpjS/AV
 VOcCHEHfvKAiBfmREIbVikBhGwZAULJcgk8GUksKCmSa0LcLaIcxZZo6Z4mqGlTIYd6EI/mtPGw
 LZis3WM9yJ6kGLvzMIz1k7D9CWO7whUXG32qKtx9Od4nrGrq869lufvtGG/ZHB4WFWcumQQXW+5
 5t9bvZ5Ud7ZNyg==
X-Received: by 2002:a17:907:db03:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-adb322afc23mr207488966b.29.1748589284892; 
 Fri, 30 May 2025 00:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhK+xQk3IGoLZNgj0ymm9p8V1QG0tfJRBkQ0GYryzyjlZXCKC6dN+ESg0GGrQQDqsWNUJ3aA==
X-Received: by 2002:a17:907:db03:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-adb322afc23mr207485766b.29.1748589284349; 
 Fri, 30 May 2025 00:14:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84d1f7sm276103266b.74.2025.05.30.00.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 45/77] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Date: Fri, 30 May 2025 09:12:15 +0200
Message-ID: <20250530071250.2050910-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
when topology level that cannot be enumerated by leaf 0xB, e.g., die or
module level, are configured for the guest, e.g., -smp xx,dies=2.

However, TDX architecture forces to require CPUID 0x1f to configure CPU
topology.

Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
requires CPUID leaf 0x1f to be exposed to guest.

Introduce a new function x86_has_cpuid_0x1f(), which is the wrapper of
cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
to enable cpuid leaf 0x1f for the guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-34-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 9 +++++++++
 target/i386/cpu.c     | 4 ++--
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c51e0a43d0b..ad0e3d8cdd0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2239,6 +2239,9 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Force to enable cpuid 0x1f */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -2500,6 +2503,12 @@ void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
 
+static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
+{
+    return cpu->enable_cpuid_0x1f ||
+           x86_has_extended_topo(cpu->env.avail_cpu_topo);
+}
+
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4a7c319bb9a..6a97d7549ec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7045,7 +7045,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_cpuid_0x1f(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7909,7 +7909,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if (x86_has_cpuid_0x1f(cpu) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c5c692a0345..ee33797fdd1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1872,7 +1872,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
                 cpuid_i--;
                 break;
             }
-- 
2.49.0


