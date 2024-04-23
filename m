Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503B6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnk-0007kQ-Bm; Tue, 23 Apr 2024 11:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnM-0005Wy-KL
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnK-0000Li-Hh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2O+ZUuhThc22InOQCYS16t3F+F+zjm+2+sKco3fT3r0=;
 b=Za1K0a1Eeyp0qvCrVMjCTSqInZQV9N+brPnfhLIXXg7rEYpemCojI21Mrys1f4MJp937Zr
 I5g32Rh2RaS5sQHXtbfgxrQ2MiT2fHitumASTmEGUEAx3va3oXqOo5uneF5WqPBHhRdzSu
 gXx5CGIDPBeDJuntuJZ+M5TCrYIcN44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-iKPHhaxKPvm-7N42wQRzEQ-1; Tue, 23 Apr 2024 11:10:30 -0400
X-MC-Unique: iKPHhaxKPvm-7N42wQRzEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E752811029;
 Tue, 23 Apr 2024 15:10:18 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C9FE200AFA2;
 Tue, 23 Apr 2024 15:10:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/63] kvm: add support for guest physical bits
Date: Tue, 23 Apr 2024 17:09:12 +0200
Message-ID: <20240423150951.41600-25-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Query kvm for supported guest physical address bits, in cpuid
function 80000008, eax[23:16].  Usually this is identical to host
physical address bits.  With NPT or EPT being used this might be
restricted to 48 (max 4-level paging address space size) even if
the host cpu supports more physical address bits.

When set pass this to the guest, using cpuid too.  Guest firmware
can use this to figure how big the usable guest physical address
space is, so PCI bar mapping are actually reachable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240318155336.156197-2-kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm-cpu.c | 50 ++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c791b7b052..f76972e47e6 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -18,10 +18,32 @@
 #include "kvm_i386.h"
 #include "hw/core/accel-cpu.h"
 
+static void kvm_set_guest_phys_bits(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    uint32_t eax, guest_phys_bits;
+
+    eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x80000008, 0, R_EAX);
+    guest_phys_bits = (eax >> 16) & 0xff;
+    if (!guest_phys_bits) {
+        return;
+    }
+    cpu->guest_phys_bits = guest_phys_bits;
+    if (cpu->guest_phys_bits > cpu->phys_bits) {
+        cpu->guest_phys_bits = cpu->phys_bits;
+    }
+
+    if (cpu->host_phys_bits && cpu->host_phys_bits_limit &&
+        cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
+        cpu->guest_phys_bits = cpu->host_phys_bits_limit;
+    }
+}
+
 static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    bool ret;
 
     /*
      * The realize order is important, since x86_cpu_realize() checks if
@@ -32,13 +54,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *
      * realize order:
      *
-     * x86_cpu_realize():
-     *  -> x86_cpu_expand_features()
-     *  -> cpu_exec_realizefn():
-     *            -> accel_cpu_common_realize()
-     *               kvm_cpu_realizefn() -> host_cpu_realizefn()
-     *  -> cpu_common_realizefn()
-     *  -> check/update ucode_rev, phys_bits, mwait
+     * x86_cpu_realizefn():
+     *   x86_cpu_expand_features()
+     *   cpu_exec_realizefn():
+     *      accel_cpu_common_realize()
+     *        kvm_cpu_realizefn()
+     *          host_cpu_realizefn()
+     *          kvm_set_guest_phys_bits()
+     *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
+     *   cpu_common_realizefn() (via xcc->parent_realize)
      */
     if (cpu->max_features) {
         if (enable_cpu_pm && kvm_has_waitpkg()) {
@@ -50,7 +74,17 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
                                                    MSR_IA32_UCODE_REV);
         }
     }
-    return host_cpu_realizefn(cs, errp);
+    ret = host_cpu_realizefn(cs, errp);
+    if (!ret) {
+        return ret;
+    }
+
+    if ((env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) &&
+        cpu->guest_phys_bits == -1) {
+        kvm_set_guest_phys_bits(cs);
+    }
+
+    return true;
 }
 
 static bool lmce_supported(void)
-- 
2.44.0



