Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5722FC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwe-0005zJ-RO; Tue, 04 Jun 2024 02:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvo-0004Zl-D3
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvm-0007d7-LY
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdwuL9IxTqKpuTaLb6wL129nWEIn7FeiWV2X8h+dwIU=;
 b=L6JDV/Bn6A1ezdHf6Q8I89SAvYcB0iQI2OfXiaTgF4FLB6X3RQu3B4avrPzrrXkOfUaOTk
 9FRTweN1puDR3hQzz3FCEU2yoJXtvc7ac1v2Imc2kRKgX7uGpvRb8LeRm5zwXdVJtN6abB
 by3Z+NAYRoKCHSTN4hFxhwBFvu+aaJQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-BNMr9aWOOWqOweRZhr4qnQ-1; Tue, 04 Jun 2024 02:46:00 -0400
X-MC-Unique: BNMr9aWOOWqOweRZhr4qnQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68c5f8f523so118549566b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483558; x=1718088358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdwuL9IxTqKpuTaLb6wL129nWEIn7FeiWV2X8h+dwIU=;
 b=jncF7IoboMFZQK36T/XMHSSpJ0hUq4dz+Sc0zC4Oe4oh6xrr8fGf+h+dczNyNQxkII
 4joRhsV6JIk+YJSn81Ws9nhLv0j59hRassuOVDHBVqb7hoEu/1RJprck5CUO3yq5Kmk0
 G+dsYFVS3yyNyj+S1l9JKvrVOA0bOXsMy/mQeUXaFEym1gI+sx0LAz2Kz+2sDenoXdEz
 iHKtHB91QnFGiyeGobIR6Bj/wd36DE2nvxW2RhUnx696u5f7SsvwI5lIDTXS1xsDagq7
 6ttY1x1uneX+j88NZX3c70sSJJKkeb+CJRY5Efjl34mQJWmj5Idh2Bn1NN3/S04MXC+5
 wJ7w==
X-Gm-Message-State: AOJu0Yzn7W5n43O0fresD/7/SVWbxN9TdeX2LtWLmjxsY3p1FwKe2IKX
 W8m86yDdxLp4Yj8NzTNPUBdpGUIeHlhnbpNMWBuoqa/CE9akjbR4JgIR3hfYnROv1MfbMd44uAa
 bxkHN2b4jHBKJy0Hulp7PmQ5qoxwoc+Imu/c2igfjg8V90dTjcDa95UWYjhUwdyDv6TfNh5Sa1D
 Rymf74T5w+i9Z37m5J1BzjJUWoiOWooFjgHmmP
X-Received: by 2002:a17:906:815:b0:a68:a788:edd3 with SMTP id
 a640c23a62f3a-a68a788ef67mr704938666b.19.1717483558572; 
 Mon, 03 Jun 2024 23:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnKvD8DnvKl0jhoVlIlKCemuYbWXS8NTUxZwhCxjU8n872CPR8JqtodELcmEGjs/KsEkkedQ==
X-Received: by 2002:a17:906:815:b0:a68:a788:edd3 with SMTP id
 a640c23a62f3a-a68a788ef67mr704937266b.19.1717483558142; 
 Mon, 03 Jun 2024 23:45:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68bfe84c67sm428104666b.62.2024.06.03.23.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 38/45] i386/kvm: Add KVM_EXIT_HYPERCALL handling for
 KVM_HC_MAP_GPA_RANGE
Date: Tue,  4 Jun 2024 08:44:02 +0200
Message-ID: <20240604064409.957105-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Michael Roth <michael.roth@amd.com>

KVM_HC_MAP_GPA_RANGE will be used to send requests to userspace for
private/shared memory attribute updates requested by the guest.
Implement handling for that use-case along with some basic
infrastructure for enabling specific hypercall events.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-31-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h   |  1 +
 target/i386/kvm/kvm.c        | 55 ++++++++++++++++++++++++++++++++++++
 target/i386/kvm/trace-events |  1 +
 3 files changed, 57 insertions(+)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 6b44844d95d..34fc60774b8 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
+bool kvm_enable_hypercall(uint64_t enable_mask);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 23a003aaa7e..ede3ef1225f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 
 #include <linux/kvm.h>
+#include <linux/kvm_para.h>
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/xen/interface/arch-x86/cpuid.h"
 
@@ -209,6 +210,13 @@ int kvm_get_vm_type(MachineState *ms)
     return kvm_type;
 }
 
+bool kvm_enable_hypercall(uint64_t enable_mask)
+{
+    KVMState *s = KVM_STATE(current_accel());
+
+    return !kvm_vm_enable_cap(s, KVM_CAP_EXIT_HYPERCALL, 0, enable_mask);
+}
+
 bool kvm_has_smm(void)
 {
     return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
@@ -5322,6 +5330,50 @@ static bool host_supports_vmx(void)
     return ecx & CPUID_EXT_VMX;
 }
 
+/*
+ * Currently the handling here only supports use of KVM_HC_MAP_GPA_RANGE
+ * to service guest-initiated memory attribute update requests so that
+ * KVM_SET_MEMORY_ATTRIBUTES can update whether or not a page should be
+ * backed by the private memory pool provided by guest_memfd, and as such
+ * is only applicable to guest_memfd-backed guests (e.g. SNP/TDX).
+ *
+ * Other other use-cases for KVM_HC_MAP_GPA_RANGE, such as for SEV live
+ * migration, are not implemented here currently.
+ *
+ * For the guest_memfd use-case, these exits will generally be synthesized
+ * by KVM based on platform-specific hypercalls, like GHCB requests in the
+ * case of SEV-SNP, and not issued directly within the guest though the
+ * KVM_HC_MAP_GPA_RANGE hypercall. So in this case, KVM_HC_MAP_GPA_RANGE is
+ * not actually advertised to guests via the KVM CPUID feature bit, as
+ * opposed to SEV live migration where it would be. Since it is unlikely the
+ * SEV live migration use-case would be useful for guest-memfd backed guests,
+ * because private/shared page tracking is already provided through other
+ * means, these 2 use-cases should be treated as being mutually-exclusive.
+ */
+static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
+{
+    uint64_t gpa, size, attributes;
+
+    if (!machine_require_guest_memfd(current_machine))
+        return -EINVAL;
+
+    gpa = run->hypercall.args[0];
+    size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
+    attributes = run->hypercall.args[2];
+
+    trace_kvm_hc_map_gpa_range(gpa, size, attributes, run->hypercall.flags);
+
+    return kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
+}
+
+static int kvm_handle_hypercall(struct kvm_run *run)
+{
+    if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
+        return kvm_handle_hc_map_gpa_range(run);
+
+    return -EINVAL;
+}
+
 #define VMX_INVALID_GUEST_STATE 0x80000021
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
@@ -5417,6 +5469,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_xen_handle_exit(cpu, &run->xen);
         break;
 #endif
+    case KVM_EXIT_HYPERCALL:
+        ret = kvm_handle_hypercall(run);
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index b365a8e8e28..74a6234ff7f 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -5,6 +5,7 @@ kvm_x86_fixup_msi_error(uint32_t gsi) "VT-d failed to remap interrupt for GSI %"
 kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
 kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
+kvm_hc_map_gpa_range(uint64_t gpa, uint64_t size, uint64_t attributes, uint64_t flags) "gpa 0x%" PRIx64 " size 0x%" PRIx64 " attributes 0x%" PRIx64 " flags 0x%" PRIx64
 
 # xen-emu.c
 kvm_xen_hypercall(int cpu, uint8_t cpl, uint64_t input, uint64_t a0, uint64_t a1, uint64_t a2, uint64_t ret) "xen_hypercall: cpu %d cpl %d input %" PRIu64 " a0 0x%" PRIx64 " a1 0x%" PRIx64 " a2 0x%" PRIx64" ret 0x%" PRIx64
-- 
2.45.1


