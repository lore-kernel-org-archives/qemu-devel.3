Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED70DC624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvL-0006lK-N7; Mon, 02 Mar 2026 03:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005ND-FM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyug-0001x0-LH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux3ZnPMEDtYfBdP2aeSQqPPs5FTXOfyYnyLyR49twAs=;
 b=L3EJBUtcTuWbMltmEQBT3mhuCEdULIukR88VwGAX06OjaFMJq6hPjqmS+BuU1PYWVwh08u
 xo52UgdOgx2wTohbHuOyrm016dbhriNZX7BI1lNGrbtbAyLPgL6zLCZOodtfBjxXzPu2yn
 12RSiT/E8T3nDnwvuXp3E+/w8njp+90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-qDQbRtwfNZGsIcCSL89sqA-1; Mon, 02 Mar 2026 03:45:59 -0500
X-MC-Unique: qDQbRtwfNZGsIcCSL89sqA-1
X-Mimecast-MFC-AGG-ID: qDQbRtwfNZGsIcCSL89sqA_1772441158
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b50320a0so676545f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441156; x=1773045956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ux3ZnPMEDtYfBdP2aeSQqPPs5FTXOfyYnyLyR49twAs=;
 b=Oo9wqoc/4j4apNXoc5mZHXnurPQYpBGPG8GwT3y3i66LDp0YlwmeZjjx31H8002T2b
 cjLvtNl5Akalq4zty0FOgPCz3WLK3T7su02Jlx1Lcgk3wmTOpXdx1F1iEOjOf0XD5/6I
 DhYJjmWOpsru9Wqzs5BBWj0fQGrFcYXPgTTLEhe3e3rbuoTeQF/KtqTd7kbm0vRaLL56
 SYxSNpEqWdd1RdnYhEHrLR+4X7tl+UTP7/lSHDzc/SrsGq7nPPTWSXuIQK0dErXDWOBm
 maLRVoeGx7umGiWXC1MRW4NXNz7Wmp76KpdRbNXusxkLVoN6bxrAG0TXEYhswf+5SEMp
 yxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441156; x=1773045956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ux3ZnPMEDtYfBdP2aeSQqPPs5FTXOfyYnyLyR49twAs=;
 b=KktemO0eX5vxJyhJMJlC7HiyOPAXRh+PkWhzfor+I1F6z/uFykuDGHJH+JeH+mLoKs
 TyUba32DkoLlynuNtfOZKp3THdS22xFePqaMb8ttEo4TBzgpinfJF3aygFDEfXXaagsC
 yhono5EMyfJuSlXk2H5oNKLxfl+2CqkeQTRXJTDeH8LuNvnCy4g1u5hscdevQ5fTmKd+
 l/BfNm3QN6oQdA0fOFEt+qtO6w7weU4/J+xEVYL23AyL97xRb2YbloAAivX4FDHIy3yP
 uLI8eGR5FZccVJ7gWzx0tlhhoRQiId9G9P+/33NtASagFD88sZqimm+NcSK0ZuOU28H5
 E2qg==
X-Gm-Message-State: AOJu0Yxo714zUUqVXFBAdKzY4pALNwkFXNCtgMwKNX7s0HxMN/LKEoAd
 mRRP23uDBOYZk2MmTMsLPdYCrIDcqyxVjIYOrgTHbwCYENSJ3d0qxs82CIdjBg+kaYMUzz3/7Zf
 GMTwVTt0SlS6us1ZSAmwNzoACBkRH9vvJsCyhN4XNQe4hTfi/dqZBTs7G+m3t3sfnZkXKPGQ+cx
 jtZiZmkWbEZjoONJYeM+HnI93xRUoSTS2FovUidb6e
X-Gm-Gg: ATEYQzzEUvV+9Ee7ZQNnUIo2qfaNft+fiKVHCGjilU1im8VebhMs242H6qpRpOaa8AJ
 2o3Dlzzg4EXLVnUDnNRLGclrfX2V/nxn/iSOqB/S2Cq+SassRN+s6ODuiuYTmYpVwD+3beE1lvD
 vrdr+38a2XzO7vqXfqAaD7Ec9mq1X26k21ioe0O2ZOqiQpdbJmh4iLF5klYOHH2qUEEb7gdNqPO
 yTLgr3012OykncuIowEG10pIf419PKyTxiRJnczoEu/9XZbLShCZ5DusRLB8EXJusHdE48xnceS
 FjtZhax3rNDpb0lrod8fZ3DCSKR1RuByQwVYKA+q55evYyGDrbpYe0QOcCm/TsGKYKywUKtl66E
 UReuJJwJwBiNvwSzaiNGKseR/oAKCA0nB/IgPZU3/g8GLft+LTp+bnk1qpNOoAD3+HVzOm/SFF4
 WMOM2rx7TB4GC5yC7ccBi6N9jlf5Q=
X-Received: by 2002:a05:6000:2c06:b0:439:8559:98b with SMTP id
 ffacd0b85a97d-4399d97f826mr18661065f8f.9.1772441156015; 
 Mon, 02 Mar 2026 00:45:56 -0800 (PST)
X-Received: by 2002:a05:6000:2c06:b0:439:8559:98b with SMTP id
 ffacd0b85a97d-4399d97f826mr18661028f8f.9.1772441155513; 
 Mon, 02 Mar 2026 00:45:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm10471900f8f.34.2026.03.02.00.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 051/102] kvm/i386: implement architecture support for kvm file
 descriptor change
Date: Mon,  2 Mar 2026 09:42:46 +0100
Message-ID: <20260302084338.473368-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

When the kvm file descriptor changes as a part of confidential guest reset,
some architecture specific setups including SEV/SEV-SNP/TDX specific setups
needs to be redone. These changes are implemented as a part of the
kvm_arch_on_vmfd_change() callback which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-11-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c        | 49 ++++++++++++++++++++++++++++--------
 target/i386/kvm/trace-events |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8edfbb834c6..40e4b3f1283 100644
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
index 74a6234ff7f..2d213c9f9b6 100644
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
2.53.0


