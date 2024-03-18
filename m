Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F684C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFJO-0001w6-CD; Mon, 18 Mar 2024 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFJK-0001vl-RT
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFJ6-0000V7-I8
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxXLz90XJ66qMz65jA/AYQZCGG6PJSqA6qXuRej7vJs=;
 b=D9PFm9iEAUDjem4iZ8rDbUMwTlsWjKWFwQ0Bfwi+zcUiE3vBl45KMUWFyq56MWrrBO9bV9
 Y5HhbwcHDftc0TCLdB2N05WtRD2VRbhf8MXcsnjQpmi9nVZLLzAWJ+Zoj3WCRQ8Wu5VP8K
 UMkAnk9ToPxxGoFOgH4bIcnW0KFz0jQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-TaExbda8N_2P6bivm3k7Vw-1; Mon, 18 Mar 2024 11:53:42 -0400
X-MC-Unique: TaExbda8N_2P6bivm3k7Vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03A66822492;
 Mon, 18 Mar 2024 15:53:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A130492BD0;
 Mon, 18 Mar 2024 15:53:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95CD41800D5E; Mon, 18 Mar 2024 16:53:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 1/2] kvm: add support for guest physical bits
Date: Mon, 18 Mar 2024 16:53:35 +0100
Message-ID: <20240318155336.156197-2-kraxel@redhat.com>
In-Reply-To: <20240318155336.156197-1-kraxel@redhat.com>
References: <20240318155336.156197-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Query kvm for supported guest physical address bits, in cpuid
function 80000008, eax[23:16].  Usually this is identical to host
physical address bits.  With NPT or EPT being used this might be
restricted to 48 (max 4-level paging address space size) even if
the host cpu supports more physical address bits.

When set pass this to the guest, using cpuid too.  Guest firmware
can use this to figure how big the usable guest physical address
space is, so PCI bar mapping are actually reachable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/cpu.h         |  1 +
 target/i386/cpu.c         |  1 +
 target/i386/kvm/kvm-cpu.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f52..d427218827f6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2026,6 +2026,7 @@ struct ArchCPU {
 
     /* Number of physical address bits supported */
     uint32_t phys_bits;
+    uint32_t guest_phys_bits;
 
     /* in order to simplify APIC support, we leave this pointer to the
        user */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a210d8d9290..c88c895a5b3e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
             /* 64 bit processor */
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
+             *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
         if (cs->nr_cores * cs->nr_threads > 1) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c791b7b0520..5132bb96abd5 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -18,10 +18,33 @@
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
+
+    if (cpu->guest_phys_bits == 0 ||
+        cpu->guest_phys_bits > guest_phys_bits) {
+        cpu->guest_phys_bits = guest_phys_bits;
+    }
+
+    if (cpu->host_phys_bits_limit &&
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
@@ -50,7 +73,13 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
                                                    MSR_IA32_UCODE_REV);
         }
     }
-    return host_cpu_realizefn(cs, errp);
+    ret = host_cpu_realizefn(cs, errp);
+    if (!ret) {
+        return ret;
+    }
+
+    kvm_set_guest_phys_bits(cs);
+    return true;
 }
 
 static bool lmce_supported(void)
-- 
2.44.0


