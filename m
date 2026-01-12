Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1034C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuH-0003Th-KB; Mon, 12 Jan 2026 08:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtk-0002ua-9R
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHti-0003k8-G1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl/mQjtvR/EBMVt9nhPm03gwedh0vVVOzpLgcWm0+Gg=;
 b=Lh87aMuDpr4hIju7M+W+3l7hEn0X2DUpn6kTshrXSrI8FU5r5BNeHrclPcHSJQVUv3mY/g
 bi5y09H6/YLcS8Rt/SEF93fLWPxPLXxHezg9z4y30QZDBd4JhUDewUl/GbUWLTSS2MA7Uh
 i+F05GqS36IV/Rfa45NphU3zwcJprlU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-DInrUm2QPBOHu1jivmbWmQ-1; Mon, 12 Jan 2026 08:23:51 -0500
X-MC-Unique: DInrUm2QPBOHu1jivmbWmQ-1
X-Mimecast-MFC-AGG-ID: DInrUm2QPBOHu1jivmbWmQ_1768224231
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c5291b89733so2622030a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224231; x=1768829031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zl/mQjtvR/EBMVt9nhPm03gwedh0vVVOzpLgcWm0+Gg=;
 b=uJgi1QlnFSn2ZXMbA83ZAjbtdSztyTWKxD9qUx2QPxFsmyl49wKupCJWKFoyy8/rpx
 IiWnzTho/6x/q2wkB2sWIa1wVuh2qXOh8i5j/y7Ee/Le+rR5ZVnh3Y6lvObKhKon+kd+
 okvAu5mFNKGo7ge5Ddp98tb5ZoF1XcjGeTxcdg/wuvKjpFLuq1OVTIBZ5bsF/XdVSv1w
 4PmxEMvSYCWNk+SeA4r4Ew0hruPv+ZlFWO84URSTNIVgIDKrXJvtsuWIR/eg40Y/3VYf
 3gk+968eYqHvp1V3BIcUK0Q9Yy1L0Af1FlIroAeln+iU4OqUzbbXYQmIqEPoZe+GLIf3
 VZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224231; x=1768829031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zl/mQjtvR/EBMVt9nhPm03gwedh0vVVOzpLgcWm0+Gg=;
 b=XQ7CP3aJk1+1uCrzmSMMFq9a63ZuOPgNEp3jkhAveshtxV5Lsn9Cm3GTnlT7YoF4PF
 QhDfv9bgGJsVqUW0DltZWDreqGPouLiCVsIDe/9aOh6ekKAoeixeqRk1oH1ULiZ+BByC
 vK0llJQ/kABTME7RKSkmj/Cg+g8/NcBJlfEesScjeo8vc6F4c1zm2KeUGytg9IrxEkci
 B66XlLPj0pzscrYPexiP0Dnm61W/5kedROop/d7zDuKAnhH2/mndlPLWrlJJr05jbZL4
 I0gj6ZL24NR3rSA22TKcuEM1jrpZJlE0RAs432bX7MZRZ34DzzL0efazR3pB5zyUawFE
 5Qfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcr2/r53NXVgg5DaikDAAt11eOlFy7sY04U7aVU6s4C1hwf0Ht2Is3IOjEmT9Oxdfp4m8XMLEk5NXP@nongnu.org
X-Gm-Message-State: AOJu0Ywp4Rt/9os6x0yZ2K+clvlPbDECeUKpVN4SJFLEr0wqsKWtEEM9
 r4Z+OhS/EUim59zyHL8mZpYGJFql4RhGokkF2Gc1ycRovoRG4i9yZoySD8w3Q95ztMTmoCiI+AY
 +csNtSKp9CvbQtVbHu7gjIK80iBCL+KI9rbaS5zLf4D7v98nr8PH2a95p
X-Gm-Gg: AY/fxX47J0xnnnqRjpFYDaK4HFZByqqSKn9BwDZKiYz/PdVImSoTL6SR8FwZgMxXsLc
 eMp3yoebfjFUSCz5wHGZY3WtPBKF9aBxOArFDXJisGGJ7Kjk2Vw2mE3NbvtK2ZfgMsLKH8p/3uu
 6/dgF1lUTF+DekUoPnW5GqGniPYf/uehbG5N5haAV/jAZ1nWEuyKPDqGRIWAldOuyUfChEdXhJ/
 MI1wWwKFDH1N5c8n31wft5UWTRIgCf2GWsqtiWIIMlIJvM0RxvnG8Yqz9FucyYDwXc0B6xihfut
 IuklOSbIN5UvVySi4l+c2UhiB1FdfP//YGfy0R4GI9ljFK1/TCKMSjTdx2upbwxwxnAyf1Aot8c
 NCwafVduUExVnTiyOEv322xBRQwfddyvTq5ts2zuUhLw=
X-Received: by 2002:a05:6a20:7291:b0:342:873d:7e62 with SMTP id
 adf61e73a8af0-3898f907d2dmr16152485637.29.1768224230539; 
 Mon, 12 Jan 2026 05:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNkZpUCKhcs1ijrkrd4+d1SBMbbxDyfcLyQALQcYQ7NIvDrlosKRvZfpN7YcfBYYgnGd4PjA==
X-Received: by 2002:a05:6a20:7291:b0:342:873d:7e62 with SMTP id
 adf61e73a8af0-3898f907d2dmr16152464637.29.1768224230110; 
 Mon, 12 Jan 2026 05:23:50 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:49 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 09/32] kvm/i386: implement architecture support for kvm
 file descriptor change
Date: Mon, 12 Jan 2026 18:52:22 +0530
Message-ID: <20260112132259.76855-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
kvm_arch_vmfd_change_ops() call which was introduced previously.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c        | 135 +++++++++++++++++++++++++++++++----
 target/i386/kvm/trace-events |   1 +
 2 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 89f9e11d3a..4fedc621b8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3265,14 +3265,132 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
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
+    trace_kvm_arch_vmfd_change_ops();
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
@@ -3308,21 +3426,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 74a6234ff7..1f4786f687 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -6,6 +6,7 @@ kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
 kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 kvm_hc_map_gpa_range(uint64_t gpa, uint64_t size, uint64_t attributes, uint64_t flags) "gpa 0x%" PRIx64 " size 0x%" PRIx64 " attributes 0x%" PRIx64 " flags 0x%" PRIx64
+kvm_arch_vmfd_change_ops(void) ""
 
 # xen-emu.c
 kvm_xen_hypercall(int cpu, uint8_t cpl, uint64_t input, uint64_t a0, uint64_t a1, uint64_t a2, uint64_t ret) "xen_hypercall: cpu %d cpl %d input %" PRIu64 " a0 0x%" PRIx64 " a1 0x%" PRIx64 " a2 0x%" PRIx64" ret 0x%" PRIx64
-- 
2.42.0


