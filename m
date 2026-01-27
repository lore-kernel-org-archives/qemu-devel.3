Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AD2D25939
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRy-0006sj-Ie; Tue, 27 Jan 2026 00:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRv-0006pX-TT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRu-0008Mo-AZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuzXnGtIe5+ocaB4DlBWBC8HhEPJq9yVKADc+BsREeM=;
 b=XEhG8HDPUAkIrsYm1ILC/nwTVQ/RsM+4CPP6OinWYz1ZIyi+bD2jmIjWR3dGjRixwZWUG7
 OzgVYO/WrxFgxk/NQoeEI06CghrakVIRd/91EQxS5pG81UqK74x+j+s9HSE6rSCT5Hdn9H
 sSUY/l3jRS7uBwWC5YaEUOVk8a2SOv0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-B1_prFv6MFCiN5Cfup8-sw-1; Tue, 27 Jan 2026 00:17:07 -0500
X-MC-Unique: B1_prFv6MFCiN5Cfup8-sw-1
X-Mimecast-MFC-AGG-ID: B1_prFv6MFCiN5Cfup8-sw_1769491027
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34ab8693a2cso708565a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491026; x=1770095826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuzXnGtIe5+ocaB4DlBWBC8HhEPJq9yVKADc+BsREeM=;
 b=aouQumPuNJUsBRX01bSQHznDYfmb6LX7qMIUhGzg2s8M4bfhs6hPNT6KVX50O3KJAP
 dmdF0qV0Htd2i7hVKpeI6DNDL/rGKM1spIJeDWK5KrzrEdih2kDTZKNFTaZZQeQfw0Nr
 gpjvf8KHhq7OkN1hNuZn916fWp5WqBpLnByytqmz+Ie4zQHKvhgcu6y/R/LpbIMNR7P1
 aDpJhmfR20BM7nIgoGEndLtRSv029dMIqKL6Yitet8hCcTkLdhDbaR/xVQO/Y4RsKimg
 ApfDhnAjVCLtB/UI7wJNMJ0pU2Yf45LSmiyZBqJ+96Eb2fZVkfCVh72nEK8V2hhKYiqV
 yIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491027; x=1770095827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YuzXnGtIe5+ocaB4DlBWBC8HhEPJq9yVKADc+BsREeM=;
 b=ApQAR9biO9t30xnEWwaEtjaoUl5vVOtAwz245PrhuY6lKimKQAt6FfhB8z9vJhqv1f
 kKtr66DkHd4Cz0SFnz+GRadfO3UTumtaR4mhE3zUYnDqOsd/C1EMvdre4GuGsws8V+m2
 Yz0SX8WVqXn5wt/k+oS2yPbfZCoTWvlhtd1SeLuUS2zC6sMBdiW7HjPl00LKKMwOnSr/
 nqM3MhmVy4uRUa8mvDsuPj0EYuYldN/1Y0/mpMkVDOUbYfEHEkPErQyWKa8vzWJCMVz6
 xAeWmXTTi0QRIRL37fH4c4zK+Jg0zo8mdIqF/BwWYrlk9MeoBFvGw//31Gesc5w7JIFa
 DeYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7/dNtbmBQkcp5srBlE/x9SGZiE4siPKTf+2SrBml5x13vL8X4jq9M17w41R072FUZQozKdGNtcogQ@nongnu.org
X-Gm-Message-State: AOJu0YyR5V++8ZnOuNTp+6M1dZzZgijiduF477goiX8AQm8i8Mh58M/9
 CjknqXIBmIXoMJJ9kgMvTsUKV4/Vu/x3kz9DhE4EANRc0XUMy8CAGxvDmcaZjXNpValSSYkZMsZ
 AQSmfN/R3ENT023meAI6PI/DKwPX1mWTyU7kgslgPrfmq99rHjMiocwvX
X-Gm-Gg: AZuq6aIcpRYj/yR9hxci5tEFlemjgjA8zwSPentIxAp7KcTOrCVAbmqzCs0PjOaIAF8
 bcQ4RYV/Phlmkjr1LU4brqBAWYYSaKNvnjMKCv6KItKhNVSaZgzet5GDr+qjGsEwanXzxTuB5L4
 8yKAl/TpXnNaXRphHRRZu64mLe08YAf8yigRAm12ccvGHTy8zWJ71OqvoCwQctyApdF0c93CTtC
 R6EC8ZAqIUnqJI6iJUJ4rmaWYv5YP6lw9wQVFjxJeElQ/pK9IFKvqUFdm7fjbWGtuR1KgkIzIll
 Wk1AavX6LXwwVw3fyCXjY7FG5i6QA0bOeGr03tdNfljSamTiQHx2+oz4yZmWbnNd3EZQP5G5W2t
 YLNOdJT2unscrcSJ4xqI3j0jKtLSZX5PRUhmAqhnJnQ==
X-Received: by 2002:a17:90a:d603:b0:34a:b4a2:f0c8 with SMTP id
 98e67ed59e1d1-353feda7c73mr651591a91.30.1769491026566; 
 Mon, 26 Jan 2026 21:17:06 -0800 (PST)
X-Received: by 2002:a17:90a:d603:b0:34a:b4a2:f0c8 with SMTP id
 98e67ed59e1d1-353feda7c73mr651570a91.30.1769491026174; 
 Mon, 26 Jan 2026 21:17:06 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 10/33] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Tue, 27 Jan 2026 10:45:38 +0530
Message-ID: <20260127051612.219475-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

When the kvm file descriptor changes as a part of confidential guest reset,
some architecture specific setups including SEV/SEV-SNP/TDX specific setups
needs to be redone. These changes are implemented as a part of the
kvm_arch_on_vmfd_change() callback which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c        | 82 ++++++++++++++++++++++++++----------
 target/i386/kvm/trace-events |  1 +
 2 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e28ab18a14..e27ccff7a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3269,14 +3269,52 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int xen_init_wrapper(MachineState *ms, KVMState *s);
+
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
+}
+
+static int xen_init_wrapper(MachineState *ms, KVMState *s)
+{
+    int ret = 0;
+#ifdef CONFIG_XEN_EMU
+    if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
+        error_report("kvm: Xen support only available in PC machine");
+        return -ENOTSUP;
+    }
+    /* hyperv_enabled() doesn't work yet. */
+    uint32_t msr = XEN_HYPERCALL_MSR;
+    ret = kvm_xen_init(s, msr);
+#else
+    error_report("kvm: Xen support not enabled in qemu");
+    return -ENOTSUP;
+#endif
+    return ret;
 }
 
 bool kvm_arch_supports_vmfd_change(void)
 {
-    return false;
+    return true;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3284,6 +3322,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
+    static bool first = true;
 
     /*
      * Initialize confidential guest (SEV/TDX) context, if required
@@ -3312,21 +3351,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (s->xen_version) {
-#ifdef CONFIG_XEN_EMU
-        if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
-            error_report("kvm: Xen support only available in PC machine");
-            return -ENOTSUP;
-        }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = xen_init_wrapper(ms, s);
         if (ret < 0) {
             return ret;
         }
-#else
-        error_report("kvm: Xen support not enabled in qemu");
-        return -ENOTSUP;
-#endif
     }
 
     ret = kvm_get_supported_msrs(s);
@@ -3353,16 +3381,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
@@ -3409,15 +3438,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
-    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+    if (first) {
+        kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+    }
+
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


