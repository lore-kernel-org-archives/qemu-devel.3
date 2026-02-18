Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F4BE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxp-0003I0-Vn; Wed, 18 Feb 2026 06:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxg-0003E9-Nn
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxd-0007qV-QU
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=XjtOglj0GG7wlbQttPqWLfnAvNQaGBXsvNulnLJ1P3/6FPNA+1QkjR2LGBz/VeV10cNQPw
 GwG3L7FVulAeK2DzxCaPmvb8X1RmkBJVMjU0GSuvkXMc+G7ibIxiy4E3dxWq3ufR5W9vfB
 gYR62MM/gVlYdC78eKtS8asmKCOHfbM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-1UQV6CdpPhiwupY3X3yUzQ-1; Wed, 18 Feb 2026 06:43:14 -0500
X-MC-Unique: 1UQV6CdpPhiwupY3X3yUzQ-1
X-Mimecast-MFC-AGG-ID: 1UQV6CdpPhiwupY3X3yUzQ_1771414994
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad3380076so4965915ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414994; x=1772019794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=Q+C3vlNjS28b5ncwrthqBTeF1OZk4bHHM7i7iNRmN8M39auOw5O6OjgsE10mhTwRrJ
 aLyzPkRjzmahBdiefbYW0bSm8QoXQP7EU61Qwa1L4603ueu8bDGCitkY2D7xy320vqtr
 8lTUU3A5jvs+gl7XIB33XXgJwkTr0tE1hrjO5d2ECtO5eDf8BSL8zVBJcNF752lo95RI
 +MFgZKimABYcOTvbZt4LpRTqU86ihDJ9wSCQQeK0PlN3JKqZDIZVGlon1lU3A7IuSDsf
 nvvrpQ3jXL9g5q5kzGu9nh52BN3eLnCxRhVmiH3736Rnyi6EwfMEPrW8Cufa75BQy5Oc
 wAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414994; x=1772019794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EBAMm0+61u9Fn6aJibmSGLnXTBDJJJE91zdBC7Xh+k=;
 b=YafyuyOsrEEVmRC8uG7AxkDxrgkpoasyjUrioK/5LE9ymGsmrbFEOoQLwtViCZNdXV
 /+E1SP3lM1GwFyRLUdQoe6bljnvl2R1eRBx4oOJzX4LC533KXwqitz/NVgxSN6ItJZiu
 z9RFsYKMrNgC3SqTuPyAJZEz0/gzFlM5YbhG47soydQUD1td1DP7KXfB41N2T1vWCSmK
 ESOnkn8Z/DLV9hAFjlRgmp7ki169a+o7StZOsabgnvZsDvWEyd1O66i5aRbyedf088Md
 vL73I5/nA7i6sP1LSwhRRN4QH+aMio5ApI6rO/jdNq8J47NLf/P0i3s7se1WgXxe/Hsk
 gg6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXthwwQ7zev1N8pf3E5vok3x5k1BNjIlyFlAh6KuXcc0HUdDJzyBtPCPihdIxXZq1Rw3dxnjhs7w1rX@nongnu.org
X-Gm-Message-State: AOJu0YzE1EzTlhTgran0fmclNWgw0LyIknwwdN9fzdlPTmwLFmzZLtr9
 ar3lwG2sSShLqeDVDKDogIYN0lNxIfQrzrmCtFDvQYePoqa1ZcLfC94FyeJT6UC5zkHfQjHnHXT
 gU63ORsyeCXaTh/0AQzbLy8w/IrkrRYae0ypO5U2bECL3hXRQ1Bu9YzZr
X-Gm-Gg: AZuq6aIV2NQBDC7aDuVBQ3ECwyhDZ+ZS85GlsihS+UfKm4NRWEQlvRyTxEEWsc9tLff
 peFXLgBXWOtoXtDjZWK13MDGcpizYV/JOfQBZY58N7LksEddtW7iFkGwC3mBhtKaEjYpDZvzPeM
 kPBxg4fYylu+64NCddrOf6QTaRgshEtwuY9cJ1eDmRo9PEqp/6Tc9YcI72JKST9WM1LyLQVGFjb
 D9CI1+wNsf7564lutX5NFJF0r/GJdZ18/XXZ+eXDTYEuPZXc+t07RVsAGGekMZbfSOOTXMlGTtq
 hv1yoqNyu4fp+yBh7We61zIwISfUEixXdrXLtPUHbL/H34+oihO3mVNKgk5qf+XNvbAaaEJC60y
 DDlQU73lqjhnOiDbMJ4344gggHer6tOoQ6AkZZ0QkKneFmXCob6R0
X-Received: by 2002:a17:902:d4d0:b0:2aa:e817:1bda with SMTP id
 d9443c01a7336-2ad50b980dcmr15409665ad.12.1771414993680; 
 Wed, 18 Feb 2026 03:43:13 -0800 (PST)
X-Received: by 2002:a17:902:d4d0:b0:2aa:e817:1bda with SMTP id
 d9443c01a7336-2ad50b980dcmr15409535ad.12.1771414993250; 
 Wed, 18 Feb 2026 03:43:13 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 09/34] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Wed, 18 Feb 2026 17:12:02 +0530
Message-ID: <20260218114233.266178-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

When the kvm file descriptor changes as a part of confidential guest reset,
some architecture specific setups including SEV/SEV-SNP/TDX specific setups
needs to be redone. These changes are implemented as a part of the
kvm_arch_on_vmfd_change() callback which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c        | 49 ++++++++++++++++++++++++++++--------
 target/i386/kvm/trace-events |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 83657fe832..8679e7d3fa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3407,12 +3407,30 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 {
-    abort();
+    int ret;
+
+    ret = kvm_arch_init(ms, s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+        X86MachineState *x86ms = X86_MACHINE(ms);
+
+        if (x86_machine_is_smm_enabled(x86ms)) {
+            memory_listener_register(&smram_listener.listener,
+                                     &smram_address_space);
+        }
+        kvm_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
+    trace_kvm_arch_on_vmfd_change();
+    return 0;
 }
 
 bool kvm_arch_supports_vmfd_change(void)
 {
-    return false;
+    return true;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3420,6 +3438,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
+    static bool first = true;
 
     /*
      * Initialize confidential guest (SEV/TDX) context, if required
@@ -3489,16 +3508,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
-
+    if (first) {
+        /* Tell fw_cfg to notify the BIOS to reserve the range. */
+        e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
+    }
     ret = kvm_vm_set_nr_mmu_pages(s);
     if (ret < 0) {
         return ret;
     }
 
     if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        x86_machine_is_smm_enabled(X86_MACHINE(ms)) && first) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
@@ -3545,16 +3565,23 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
                 return ret;
             }
 
-            ret = kvm_msr_energy_thread_init(s, ms);
-            if (ret < 0) {
-                error_report("kvm : error RAPL feature requirement not met");
-                return ret;
+            if (first) {
+                ret = kvm_msr_energy_thread_init(s, ms);
+                if (ret < 0) {
+                    error_report("kvm : "
+                                 "error RAPL feature requirement not met");
+                    return ret;
+                }
             }
         }
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
-    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+
+    if (first) {
+        kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+    }
+    first = false;
 
     return 0;
 }
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 74a6234ff7..2d213c9f9b 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -6,6 +6,7 @@ kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
 kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 kvm_hc_map_gpa_range(uint64_t gpa, uint64_t size, uint64_t attributes, uint64_t flags) "gpa 0x%" PRIx64 " size 0x%" PRIx64 " attributes 0x%" PRIx64 " flags 0x%" PRIx64
+kvm_arch_on_vmfd_change(void) ""
 
 # xen-emu.c
 kvm_xen_hypercall(int cpu, uint8_t cpl, uint64_t input, uint64_t a0, uint64_t a1, uint64_t a2, uint64_t ret) "xen_hypercall: cpu %d cpl %d input %" PRIu64 " a0 0x%" PRIx64 " a1 0x%" PRIx64 " a2 0x%" PRIx64" ret 0x%" PRIx64
-- 
2.42.0


