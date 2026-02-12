Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD76EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9T-0007gZ-SB; Thu, 12 Feb 2026 01:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9Q-0007c7-KP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9P-0005EY-0x
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22GpwhOlGGm3YDWl4oHQuQsIgR+l63T6jAvu0DmCDfs=;
 b=ObSIu7yjUx/8JCQPKCZZHwJLv2P+iCCksa/EJtsC6Q1V65MWavoniiMdJs/WjAmSNaZFTR
 7n4r4bmqnjW+zhWSSyYfcV++6iCw4AZGXII/fEiKQGNPtzdQagO3zcZgO6yZh0WwSA7m4w
 Ie3tty4cAUnkAOok7COLUUHPt2N2LiY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-hT-A8krOOgCRENulYDsmfA-1; Thu, 12 Feb 2026 01:26:04 -0500
X-MC-Unique: hT-A8krOOgCRENulYDsmfA-1
X-Mimecast-MFC-AGG-ID: hT-A8krOOgCRENulYDsmfA_1770877563
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so4137199a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877563; x=1771482363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22GpwhOlGGm3YDWl4oHQuQsIgR+l63T6jAvu0DmCDfs=;
 b=Hc2r0PcAO9nPq36oicNoIJuISr3e3QYXDgYQNd6iZg/1FSRM1Gqv9gvVGc13uBvqEE
 xu5Y8n1J60b93/dRneAifVy+tgplS842sGXas5tcLpJpi2ndsGUNXWakDNQUg4zd7Kh+
 c/x/8RChtPNQxar+XIi6LcJpT8Nt+IONJKUubEHH0F3c0ZnpXfkM5C69pTrKJugi12LY
 j8Lzdt/VweTRSqAVK4XPDjvLki9XvBDsD3OuLlmaXVlB5uTL7Rp+SEWW4ZAr77IItWga
 +JpggVmKEbtM0vGcttJVNtpILHr2o58fJaYE2TeN4fnrQy0y0EC+SzlkmbkycwqOkKzR
 iZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877563; x=1771482363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=22GpwhOlGGm3YDWl4oHQuQsIgR+l63T6jAvu0DmCDfs=;
 b=A7jT1d/lHGe9JIeOdwGvzBYCYS7/yIg0uKFuKwxwMaoT+hj0UHUJDGENiDBpukiE25
 gZGAFXEnSYaVReSSb93TRJkJTFdsJhYzymPOSnnyFpwGUx4v50w4P2YxWBB6TX36FZBA
 aqyY8hdUX1EXh/1b0js4uduZzkkvEDGfBvBgZuJsuZyJVKqSbdPSF5dTJ9hjIfiTCR2I
 fYNMuLT4V6B8YbHRS1bwVxrpW7WXepvTUIOkCFaPqR9pFWsvLDdV9LGRNv4sOqGTQnas
 mxBLwsS7qBaLBRrQ7WjSuoRvJfQ8OG1gjP1B3TR9NHqMWj4ZOL6vGVUn3SFepDHUq0/D
 Nz9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVry81shMM+1K6bCtDHb2O7MMwx6oYFZFz6DjS3AlJZ47+sv6+8IPBDetJIflUIGLjm9VDvBV6zd3oJ@nongnu.org
X-Gm-Message-State: AOJu0YxiDqUlJVqNCpfBpQAznVl17UoeJ783fKkshpKgsY2hq7m/0bqE
 z7aAc9zPY+yRZxK2vur2hB5ZBptjKhp28MIRsBArh6tzOPXkG7Sh5OA2lHOCYgI3zetb5I1lFUQ
 FCFYL8s86TiMbwGjZrt+7RN7ZxJe9Kfatns0R25w4gx50BqaRxCFhs5Xf
X-Gm-Gg: AZuq6aLFxTr7qp+Sn9Z6CncjnthoCvwQtCg9gqzlRrauoG0NeEQqHXYur9Yl6LKdNbi
 GjbR6jHGiryb/0JCtAzlHeKhW18mfxUjorvzoT0O8YNWPGY4bNogWQnT05qXnM7/gwBI+f4gDQW
 zfHS6fkxnaPJ4mOdH9tfWZwglf2/LWe4oDapLIi/sw6GRrXHhfIt0nYG0u/wQ04uiHzWd5sxCK8
 ZoEPGGAGHnAGz+0XV4rkpV4DRCJIdVr32wshZBi3i6jHTdwcHGNShgs+/+hUIZn6SGPq7jc0SX2
 37u40EfiNug/OV/DmKBaGmahhxJSAnw59gxt0S3fgMpm+fnF1D6yB6ZUJRf9mDOumXxxbQRbBok
 PTU80qtXm7IlCAuxqephwEsJkZUGjmWEQEO5OyLAdz21FZ3cGy4wW4pA=
X-Received: by 2002:a05:6a20:9f05:b0:33b:5a3f:3cbe with SMTP id
 adf61e73a8af0-394488554a9mr1595686637.54.1770877563432; 
 Wed, 11 Feb 2026 22:26:03 -0800 (PST)
X-Received: by 2002:a05:6a20:9f05:b0:33b:5a3f:3cbe with SMTP id
 adf61e73a8af0-394488554a9mr1595668637.54.1770877563001; 
 Wed, 11 Feb 2026 22:26:03 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 09/31] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Thu, 12 Feb 2026 11:54:53 +0530
Message-ID: <20260212062522.99565-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 5d9b79529f..e82a6e9eda 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3268,14 +3268,52 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
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
@@ -3283,6 +3321,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
+    static bool first = true;
 
     /*
      * Initialize confidential guest (SEV/TDX) context, if required
@@ -3311,21 +3350,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
@@ -3352,16 +3380,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
@@ -3408,15 +3437,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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


