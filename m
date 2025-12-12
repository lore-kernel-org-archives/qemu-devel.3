Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E9D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hV-0001yC-E6; Fri, 12 Dec 2025 10:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hT-0001xZ-Qz
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hS-0005hI-87
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEQtRpZIU+af5B0NJVC06k5FBVfVHxHqEV2FPCkoDHk=;
 b=dn6NPvbVyPEcJHFYPW1z4VDF/kLQeM+waU7RDZGsinNkYwzaVaeFz0ds9V2RRFcbAy5WUq
 RSCzFk4aMp2ONH5VYHhxPiad5Poqfj+Yh6kP0OjI7CHIy7hZ07rbmaOOhLgT4yrj443IlV
 t6vzsi3tgQgvigy3FDK5SfC8OHIqmtk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Lvfprj8hOeymQPDVhC2skA-1; Fri, 12 Dec 2025 10:04:50 -0500
X-MC-Unique: Lvfprj8hOeymQPDVhC2skA-1
X-Mimecast-MFC-AGG-ID: Lvfprj8hOeymQPDVhC2skA_1765551889
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f1450189eso10049505ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551889; x=1766156689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEQtRpZIU+af5B0NJVC06k5FBVfVHxHqEV2FPCkoDHk=;
 b=dl/zmL5Q8b5ZqKztLiRugYsWD01tAQ7xyonUU22ovCbY1bRHPAJvGWd/ZhjaGdeyFo
 DYovNy/hMYRg04W2eVtOl7/YlMvyBfx5fgDqAHOR+DthyfmN7n7bd05HRVUJG0CYrEzG
 8nD5VuFJLlP3PyVV6U/RR7yDSiwXK5ftqdeEFbFyqxLfjXbEyj47jfMC3RcphN8CZdAo
 O4eAk109uTPkgURKUb+HdpTebLQcHxS6VDlCSpqyVO0WGeJ/ftx+gQkagcnoCUAOQjPO
 CMuyLeGARop3CKtI8YqO723ocz6S8kDiuKRoHlZb1zFavfPwmnVuC8nE/h1bDgxqBxNK
 Qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551889; x=1766156689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEQtRpZIU+af5B0NJVC06k5FBVfVHxHqEV2FPCkoDHk=;
 b=nV7qiqNmt3X9Y0xEpXPvU7fmH7EmhPIExl78zWhb8KMhPM9JCClSU4Bbgj/osJIrTf
 IJkNp+HoBJV63tz+5hXRTivxfplpj0wgxeytksDnO+FmE63um7jprIsFU08jnNtW33jM
 NXW4VvzohnFhUtBXzHVWEPmXUCI6FimiBBa63D4XPikUmiNrfHT05Td45awCPPCcYQAB
 6r8M4LZQ9A2LYdXEcaEZH1sPUutDvIfrdH2sCdeFb3J3npId5dYMmqU0bDjaG4SpaD7E
 t4lr68VcFKguGjKKhklNdepyZMCV7HqMbQj5/4EvxzLFHPrET1ZelDAncjSSNgjPbol+
 Yn0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2doYy9Mo6+bRXlGSm8S4kd/zcvwkC03oBy85KX4IQ1lOfenXIOuyr64q1RX7zVNvklO6KoZ/Pv55G@nongnu.org
X-Gm-Message-State: AOJu0Yx6EQtNOpLyp+bcGf7oPBxZbmrH3ib0wl/Egl2apE9Mq91XZ1CX
 KvwWl6MC3K4AyP8nvH7Qx1uIAZAwf8YRPBP+bWgHx2xxJe6W2ZpL9zoPPp/IBIrCXDe0WO1iJkd
 oF81jVQ/482zhXTwZzfP3lIozY1X03xzr7axEGGDzZAi1SyTlIysvggI6
X-Gm-Gg: AY/fxX6WmmelpDu+xC4xEihvdI4iydtX1izYtfyRWlWQa4JzNJYOSmVfwOLAmw194Hw
 /Lwb/92omyBatq3c14eJjrsFC7z+MGW6YH4FIkqjkJoXSIad1is/Yjb9/p5KqjI2ulJqWAtGpeV
 6BPTnnEL7TTJfL+xh4ZNaNGqE605QaIc3kKiifXfzFOk4mj0Acrp/6q6Y2T88HdqPCGBYbuNd8q
 mnFMA4+C1yjo3UceGmB+9aDFVlyE7S3FYPjhze0Y70JDPCJ6GO7lYtBDIniwAfQ2UXsHdOKbNBM
 8LfLlDO3Gylq0a2zasbZwvThiqaEM0AnvzwrEjHjNjSE8OvBacfAVoUgiAGWZDUkoQZpLcWKc/d
 Gjs+2Mnq1sMH3C2bHV/r8E8ffqd2Z2ilxR4wROOYKJmU=
X-Received: by 2002:a17:903:8cd:b0:29a:4a5:d688 with SMTP id
 d9443c01a7336-29eeebcedb9mr67342415ad.15.1765551889050; 
 Fri, 12 Dec 2025 07:04:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZBw3cmTdXgss3nJnSVhW4vDvRaSjlwKI3kdKjvhl/302qsw+kjO/S5XkgEuKUu8iYibkyig==
X-Received: by 2002:a17:903:8cd:b0:29a:4a5:d688 with SMTP id
 d9443c01a7336-29eeebcedb9mr67341775ad.15.1765551888392; 
 Fri, 12 Dec 2025 07:04:48 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:48 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 07/28] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Fri, 12 Dec 2025 20:33:35 +0530
Message-ID: <20251212150359.548787-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the kvm file descriptor changes as a part of confidential guest reset,
some architecture specific setups including SEV/SEV-SNP/TDX specific setups
needs to be redone. These changes are implemented as a part of the
kvm_arch_vmfd_change_ops() call which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 132 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 119 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index cdfcb70f40..e971f5f8c4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3252,9 +3252,126 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int xen_init_wrapper(MachineState *ms, KVMState *s);
+
 int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
 {
-    abort();
+    Error *local_err = NULL;
+    int ret;
+
+    /*
+     * Initialize confidential context, if required
+     *
+     * If no memory encryption is requested (ms->cgs == NULL) this is
+     * a no-op.
+     *
+     */
+    if (ms->cgs) {
+        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
+    }
+
+    ret = kvm_vm_enable_exception_payload(s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = kvm_vm_enable_triple_fault_event(s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (s->xen_version) {
+        ret = xen_init_wrapper(ms, s);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    ret = kvm_vm_set_identity_map_addr(s, KVM_IDENTITY_BASE);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = kvm_vm_set_tss_addr(s, KVM_IDENTITY_BASE + 0x1000);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = kvm_vm_set_nr_mmu_pages(s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
+        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        memory_listener_register(&smram_listener.listener,
+                                 &smram_address_space);
+    }
+
+    if (enable_cpu_pm) {
+        ret = kvm_vm_enable_disable_exits(s);
+        if (ret < 0) {
+            error_report("kvm: guest stopping CPU not supported: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+        X86MachineState *x86ms = X86_MACHINE(ms);
+
+        if (x86ms->bus_lock_ratelimit > 0) {
+            ret = kvm_vm_enable_bus_lock_exit(s);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        kvm_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
+    if (kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
+        ret = kvm_vm_enable_notify_vmexit(s);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
+        ret = kvm_vm_enable_userspace_msr(s);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (s->msr_energy.enable == true) {
+            ret = kvm_vm_enable_energy_msrs(s);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
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
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3290,21 +3407,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
-- 
2.42.0


