Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C0FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yh-00047v-0t; Thu, 20 Aug 2026 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yZ-00042r-IE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yU-0005Sf-SN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+0fSdxCXRD0zIillt6YuYO8fbIna/EhBj7HGBooRuw=;
 b=EMwwhs02hZMRgAYMly6UISU76q/RAFzn1CIdiBYPRYA7iIVmf3WZwaOUD+tbOgTAcv0MwT
 61gMgl3G4j7ELYBhYCW0wDMhOrkY3uQ/KOtXRJAemX62lmDNT2Bhekp6X2BQIMHUdBTlYQ
 2Yt/MC98N2WJ1I2frQRJdkg1kNKP/5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-FFrWHgPoPDKBoh7goA22nA-1; Thu, 20 Aug 2026 12:50:40 -0400
X-MC-Unique: FFrWHgPoPDKBoh7goA22nA-1
X-Mimecast-MFC-AGG-ID: FFrWHgPoPDKBoh7goA22nA_1787244639
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482bf4da3d5so77787f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244639; x=1787849439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/+0fSdxCXRD0zIillt6YuYO8fbIna/EhBj7HGBooRuw=;
 b=jd2MPPxCbqi3K3FofDk377dU+1oTtYhrpOvAnRPKd5EfJ0vRvEJsHNYOxjaWFCgyq6
 B5PquiTxcC/H2JouTQPYNYapr7xltReOn5wQad2PQITOnDZbo3Di0UgDjwSnk0k0bLku
 v9ogKmWx6cTLVp48SzAEBXCp3P+Fgi+k+wghUPEeIO2anjAlfNBjcSt9puIDhRIywHRa
 YeIfv/6yfjzJ0IXBKB8Y1wWNdlDSygt2IEp7CAzyC6GnkAOPvOpsP4qSns59eLzvF1D9
 n7l9V/bFQY9lwRMe23J6iF4/F4CjVgykaz0ISLjhDVYDMwKeBxwUD7DLWtzVdxFBf8Xv
 hFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244639; x=1787849439;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/+0fSdxCXRD0zIillt6YuYO8fbIna/EhBj7HGBooRuw=;
 b=tK+snDZuaBtzxvduE+3bSMpA9lSFohpzeHtEE155biJjBjmVduejZZzOfxVw3oginu
 s6OFPUuZXKeFRUo1NnEEV4ElSwk2wrhs0uJ3QX7NI1Jsly/ddzQA4eOCqykD8+bPbISZ
 B9qgObql+zF+TvEMGTp5yMwphCmJKG3HKSumWQLtSKUS8svmbQnCE7Uh3lbSRM4LDsEt
 0CppTA83HJHRNdCcMGcAt35wiIvaTyXCEbD2ct3CwFP0yxgq3dWWnMnRZ6Z05R1fSrWT
 8WtzwOY/eifdjRk+q+H2xj6aCFtr6N26ZrpUfbqSdUjO2alpp3lb5zTADyyp+f+6swrw
 w6Cg==
X-Gm-Message-State: AFuF++lJvp4nazHbB3IUqiX68xfbGz8ElSAZAqVJ459sv4+IHN2al6gc
 xXuBEYwaO6VZoj+LZLiPh/eNslhH8tMjNYHIq1nhp22iYV/rk/ssFCvlXseatYxn8CJLZ+m9kKk
 Jc0mvniA8Z8dcJ53AH6Ho4weo86omP/CnxABzr2fAJaLPLWI6lGFg7OldaqoK2dptkM2vBwOcYl
 nqzBG898XXPItDanbwhjq8fjdA9cMEUJ8lfAwwyVBs
X-Gm-Gg: AR+sD117SFX5il3nydhp1K1EXQfNBFOM3jJGedEcmuE4F4Zn2o2AsJIcX3D2ASVNIH8
 2T9DZ5802YU4+/appOHWUgT9Xnj90Za1ebB+0c/98iIjsyB3PR0XdVInxcCjkFlwI+cUAV/W4CB
 rp3n0kNuRpRkykAMoHamwJsXLptv8K0dryqDf7z7F8pTkM1u6mM+ZIaPRskTK/WyZLgKCVmb1pL
 10rHpBJ9AfsZOgoyay5RrPB34GysiZsTcbmEyJhwNuKEhC34acAi24lfy8iZ+Iu/TQzCcXlvlcF
 LvHWr5al4EqUIIvzkQDTHykp42APhq6/u92Wvq84NondRAh3OfVJxe98x98BMhLFrPSSNKmiX5q
 baRbXkU/+IAuBqfQZJNnqQl6y6zEVyFbJ0crJ1+oBHDI9iTmb9kovU1Zo04TjYEZf0p4PhWEXMy
 fdW8I=
X-Received: by 2002:a5d:5886:0:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-482c0b4207emr51602f8f.5.1787244638880; 
 Thu, 20 Aug 2026 09:50:38 -0700 (PDT)
X-Received: by 2002:a5d:5886:0:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-482c0b4207emr51418f8f.5.1787244638240; 
 Thu, 20 Aug 2026 09:50:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14cf0a3sm13601682f8f.32.2026.08.20.09.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 13/53] target/i386/mshv: migrate LAPIC state
Date: Thu, 20 Aug 2026 18:49:16 +0200
Message-ID: <20260820164957.1895963-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This change implements loading and storing the hyperv lapic state as
part of the load/store routines for a vcpu.

The HyperV LAPIC is similar to the the split-irqchip in KVM. MSHV
currently keeps PIC/IOAPIC emulation in userspace, while LAPIC
interrupt injection is handled through hypercalls.

We introduced dedicated apic infra in hw/i386/mshv to handle the
migration and move lapic related functions from target/i386/mshv
there. References have been the WHPX's whpx-apic implemenation and
the mshv-ioctls crate's get_/set_lapic() impl for the mapping
between MSHV/QEMU lapic state.

We are mapping the lapic state that we receive from the hypervisor to
fields in APICCommonState. Common fields are used where feasible, with
an mshv-specific MshvAPICState object that carries mshv-specific
fields.

We have introduced a guard in pic_irq_request() that will early exit
for the mshv accelerator, because mshv cannot take part in the userland
path for legacy PIC interrupt injection.

The TSC_DEADLINE MSR is also migrated as part of LAPIC migration.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-6-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h |   2 +
 include/hw/i386/apic-msidef.h  |   1 +
 include/system/mshv.h          |   2 +
 include/system/mshv_int.h      |   8 +-
 accel/mshv/mshv-all.c          |   1 +
 hw/i386/mshv/apic.c            | 395 +++++++++++++++++++++++++++++++++
 hw/i386/x86-cpu.c              |   6 +
 target/i386/cpu-apic.c         |   3 +
 target/i386/mshv/mshv-cpu.c    | 151 ++++---------
 target/i386/mshv/msr.c         |   2 +
 hw/i386/meson.build            |   2 +-
 hw/i386/mshv/meson.build       |   1 +
 12 files changed, 460 insertions(+), 114 deletions(-)
 create mode 100644 hw/i386/mshv/apic.c

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index f8838a31bbe..0602a7c6cc6 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -168,6 +168,7 @@ typedef enum hv_register_name {
     /* Available */
 
     HV_X64_REGISTER_SPEC_CTRL       = 0x00080084,
+    HV_X64_REGISTER_TSC_DEADLINE    = 0x00080095,
     HV_X64_REGISTER_TSC_ADJUST      = 0x00080096,
 
     /* CET / Shadow Stack */
@@ -930,6 +931,7 @@ struct hv_cpuid {
 #define IA32_MSR_DEBUG_CTL        0x1D9
 #define IA32_MSR_SPEC_CTRL        0x00000048
 #define IA32_MSR_TSC_ADJUST       0x0000003b
+#define IA32_MSR_TSC_DEADLINE     0x000006e0
 
 #define IA32_MSR_MISC_ENABLE 0x000001a0
 
diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
index 420b41167db..6b860b58074 100644
--- a/include/hw/i386/apic-msidef.h
+++ b/include/hw/i386/apic-msidef.h
@@ -13,6 +13,7 @@
 #define  MSI_DATA_VECTOR_MASK           0x000000ff
 
 #define MSI_DATA_DELIVERY_MODE_SHIFT    8
+#define MSI_DATA_DELIVERY_MODE_MASK     7
 #define MSI_DATA_LEVEL_SHIFT            14
 #define MSI_DATA_TRIGGER_SHIFT          15
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index a6f815b822a..f98ddff9b57 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -41,9 +41,11 @@
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
+#define mshv_irqchip_in_kernel() mshv_enabled()
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
+#define mshv_irqchip_in_kernel() mshv_enabled()
 #endif
 
 #define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b91c4d661a3..c2f13c01947 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -105,10 +105,16 @@ void mshv_arch_amend_proc_features(
 void mshv_arch_disable_partition_proc_features(
      union hv_partition_processor_features *disabled_features);
 int mshv_arch_post_init_vm(int vm_fd);
-
+int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
+int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
 typedef struct mshv_root_hvcall mshv_root_hvcall;
 int mshv_hvcall(int fd, const mshv_root_hvcall *args);
 
+/* apic */
+int mshv_init_lint(CPUState *cpu);
+int mshv_set_lapic(const CPUState *cpu);
+int mshv_get_lapic(CPUState *cpu);
+
 /* memory */
 typedef struct MshvMemoryRegion {
     uint64_t guest_phys_addr;
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index f9511ca050a..1516475f34f 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -813,6 +813,7 @@ static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_state = mshv_cpu_synchronize;
     ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
     ops->cpus_are_resettable = mshv_cpus_are_resettable;
+    ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
 }
 
diff --git a/hw/i386/mshv/apic.c b/hw/i386/mshv/apic.c
new file mode 100644
index 00000000000..9188a93b2fe
--- /dev/null
+++ b/hw/i386/mshv/apic.c
@@ -0,0 +1,395 @@
+/*
+ * MSHV in-kernel APIC support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/memalign.h"
+#include "qemu/error-report.h"
+#include "hw/i386/apic_internal.h"
+#include "hw/i386/apic-msidef.h"
+#include "hw/pci/msi.h"
+#include "migration/vmstate.h"
+#include "qemu/typedefs.h"
+#include "system/hw_accel.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+typedef struct hv_local_interrupt_controller_state
+               hv_local_interrupt_controller_state;
+
+#define TYPE_MSHV_APIC "mshv-apic"
+OBJECT_DECLARE_SIMPLE_TYPE(MshvAPICState, MSHV_APIC)
+
+struct MshvAPICState {
+    APICCommonState parent_obj;
+
+    uint32_t apic_version;
+    uint32_t apic_lvt_cmci;
+    uint32_t apic_error_status;
+    uint32_t apic_counter_value;
+    uint32_t apic_remote_read;
+};
+
+static int get_lapic(int cpu_fd,
+                     struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = mshv_get_vp_state(cpu_fd, &mshv_state);
+    if (ret == 0) {
+        memcpy(state, buffer, sizeof(*state));
+    }
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to get lapic");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lapic(int cpu_fd,
+                     const struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    if (!state) {
+        error_report("lapic state is NULL");
+        return -1;
+    }
+    memcpy(buffer, state, sizeof(*state));
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = mshv_set_vp_state(cpu_fd, &mshv_state);
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to set lapic: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static void populate_apic_state(CPUState *cpu,
+                                const hv_local_interrupt_controller_state *hv)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    MshvAPICState *ms = MSHV_APIC(x86cpu->apic_state);
+    APICCommonState *s = &ms->parent_obj;
+    size_t i;
+
+    /*
+     * x2APIC:
+     * - APIC ID is the full 32-bit initial_apic_id
+     * - LDR is read-only, architecturally derived from the ID
+     * - DFR does not exist in x2APIC mode
+     */
+    if (is_x2apic_mode(s)) {
+        s->initial_apic_id = hv->apic_id;
+    } else {
+        s->id        = hv->apic_id  >> 24;
+        s->log_dest  = hv->apic_ldr >> 24;
+        s->dest_mode = hv->apic_dfr >> 28;
+    }
+    ms->apic_version = hv->apic_version;
+    s->spurious_vec = hv->apic_spurious;
+    for (i = 0; i < 8; i++) {
+        s->isr[i] = hv->apic_isr[i];
+        s->tmr[i] = hv->apic_tmr[i];
+        s->irr[i] = hv->apic_irr[i];
+    }
+    s->esr = hv->apic_esr;
+    s->icr[1] = hv->apic_icr_high;
+    s->icr[0] = hv->apic_icr_low;
+
+    s->lvt[APIC_LVT_TIMER]   = hv->apic_lvt_timer;
+    s->lvt[APIC_LVT_THERMAL] = hv->apic_lvt_thermal;
+    s->lvt[APIC_LVT_PERFORM] = hv->apic_lvt_perfmon;
+    s->lvt[APIC_LVT_LINT0]   = hv->apic_lvt_lint0;
+    s->lvt[APIC_LVT_LINT1]   = hv->apic_lvt_lint1;
+    s->lvt[APIC_LVT_ERROR]   = hv->apic_lvt_error;
+    ms->apic_lvt_cmci        = hv->apic_lvt_cmci;
+
+    ms->apic_error_status  = hv->apic_error_status;
+    s->initial_count       = hv->apic_initial_count;
+    ms->apic_counter_value = hv->apic_counter_value;
+    s->divide_conf         = hv->apic_divide_configuration;
+    ms->apic_remote_read   = hv->apic_remote_read;
+}
+
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+int mshv_init_lint(CPUState *cpu)
+{
+    uint32_t *lvt_lint0, *lvt_lint1;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+
+    ret = get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    lvt_lint0 = &lapic_state.apic_lvt_lint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.apic_lvt_lint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    ret = set_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return -1;
+    }
+
+    populate_apic_state(cpu, &lapic_state);
+
+    return 0;
+}
+
+static void populate_hv_lapic_state(hv_local_interrupt_controller_state *hv,
+                                    const CPUState *cpu)
+{
+    uint32_t x2apic_id;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    MshvAPICState *ms = MSHV_APIC(x86cpu->apic_state);
+    APICCommonState *s = &ms->parent_obj;
+    size_t i;
+
+    /*
+     * x2APIC:
+     * - APIC ID is the full 32-bit initial_apic_id
+     * - LDR is read-only, architecturally derived from the ID
+     * - DFR does not exist in x2APIC mode
+     */
+    if (is_x2apic_mode(s)) {
+        x2apic_id = s->initial_apic_id;
+
+        hv->apic_id  = x2apic_id;
+        hv->apic_ldr = ((x2apic_id >> 4) << 16) | (1 << (x2apic_id & 0xf));
+        hv->apic_dfr = 0;
+    } else {
+        hv->apic_id  = s->id << 24;
+        hv->apic_ldr = s->log_dest << 24;
+        hv->apic_dfr = s->dest_mode << 28 | 0x0fffffff;
+    }
+    hv->apic_version = ms->apic_version;
+    hv->apic_spurious = s->spurious_vec;
+    for (i = 0; i < 8; i++) {
+        hv->apic_isr[i] = s->isr[i];
+        hv->apic_tmr[i] = s->tmr[i];
+        hv->apic_irr[i] = s->irr[i];
+    }
+    hv->apic_esr      = s->esr;
+    hv->apic_icr_high = s->icr[1];
+    hv->apic_icr_low  = s->icr[0];
+
+    hv->apic_lvt_timer   = s->lvt[APIC_LVT_TIMER];
+    hv->apic_lvt_thermal = s->lvt[APIC_LVT_THERMAL];
+    hv->apic_lvt_perfmon = s->lvt[APIC_LVT_PERFORM];
+    hv->apic_lvt_lint0   = s->lvt[APIC_LVT_LINT0];
+    hv->apic_lvt_lint1   = s->lvt[APIC_LVT_LINT1];
+    hv->apic_lvt_error   = s->lvt[APIC_LVT_ERROR];
+    hv->apic_lvt_cmci    = ms->apic_lvt_cmci;
+
+    hv->apic_error_status         = ms->apic_error_status;
+    hv->apic_initial_count        = s->initial_count;
+    hv->apic_counter_value        = ms->apic_counter_value;
+    hv->apic_divide_configuration = s->divide_conf;
+    hv->apic_remote_read          = ms->apic_remote_read;
+}
+
+int mshv_set_lapic(const CPUState *cpu)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+
+    populate_hv_lapic_state(&lapic_state, cpu);
+
+    return set_lapic(cpu_fd, &lapic_state);
+}
+
+int mshv_get_lapic(CPUState *cpu)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+
+    ret = get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return -1;
+    }
+
+    populate_apic_state(cpu, &lapic_state);
+
+    return 0;
+}
+
+static int mshv_apic_set_base(APICCommonState *s, uint64_t val)
+{
+    s->apicbase = val;
+
+    return 0;
+}
+
+static void mshv_apic_set_tpr(APICCommonState *s, uint8_t val)
+{
+    s->tpr = (val & APIC_PR_SUB_CLASS) << APIC_PR_CLASS_SHIFT;
+}
+
+static uint8_t mshv_apic_get_tpr(APICCommonState *s)
+{
+    return s->tpr >> APIC_PR_CLASS_SHIFT;
+}
+
+static void mshv_apic_external_nmi(APICCommonState *s)
+{
+}
+
+static void mshv_apic_vapic_base_update(APICCommonState *s)
+{
+}
+
+static void mshv_send_msi(MSIMessage *msi)
+{
+    uint64_t addr;
+    uint32_t data, dest;
+    uint8_t vector, dest_mode, trigger_mode, delivery;
+
+    addr         = msi->address;
+    data         = msi->data;
+    dest         = (addr & MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT |
+                   (addr >> 32);
+    vector       = (data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
+    dest_mode    = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
+    trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
+    delivery     = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) &
+                   MSI_DATA_DELIVERY_MODE_MASK;
+
+    mshv_request_interrupt(mshv_state, delivery, vector, dest, dest_mode,
+                           trigger_mode);
+}
+
+static uint64_t mshv_apic_mem_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    return UINT64_MAX;
+}
+
+static void mshv_apic_mem_write(void *opaque, hwaddr addr,
+                                uint64_t data, unsigned size)
+{
+    MSIMessage msg = { .address = addr, .data = data };
+
+    mshv_send_msi(&msg);
+}
+
+static const MemoryRegionOps mshv_apic_io_ops = {
+    .read = mshv_apic_mem_read,
+    .write = mshv_apic_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mshv_apic_reset(APICCommonState *s)
+{
+    s->wait_for_sipi = 0;
+}
+
+static const VMStateDescription vmstate_mshv_apic = {
+    .name = "mshv-apic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(apic_version, MshvAPICState),
+        VMSTATE_UINT32(apic_lvt_cmci, MshvAPICState),
+        VMSTATE_UINT32(apic_error_status, MshvAPICState),
+        VMSTATE_UINT32(apic_counter_value, MshvAPICState),
+        VMSTATE_UINT32(apic_remote_read, MshvAPICState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void mshv_apic_realize(DeviceState *dev, Error **errp)
+{
+    APICCommonState *s = APIC_COMMON(dev);
+    MshvAPICState *ms = MSHV_APIC(dev);
+
+    memory_region_init_io(&s->io_memory, OBJECT(s), &mshv_apic_io_ops, s,
+                          "mshv-apic-msi", APIC_SPACE_SIZE);
+
+    msi_nonbroken = true;
+
+    /*
+     * We register this state explicity, rather than going via dc->vmsd.
+     * The auto-wiring would register the state with
+     * instance_id == VMSTATE_INSTANCE_ID_ANY, which for the APIC doesn't
+     * work, b/c the ID carries semantic meaning for restoring the state
+     * on the destination (which vcpu it belongs to).
+     */
+    vmstate_register_with_alias_id(NULL,
+                                   s->initial_apic_id, &vmstate_mshv_apic, ms,
+                                   -1, 0, NULL);
+}
+
+static void mshv_apic_unrealize(DeviceState *dev)
+{
+    MshvAPICState *ms = MSHV_APIC(dev);
+
+    vmstate_unregister(NULL, &vmstate_mshv_apic, ms);
+}
+
+static void mshv_apic_class_init(ObjectClass *klass, const void *data)
+{
+    APICCommonClass *k = APIC_COMMON_CLASS(klass);
+
+    k->realize = mshv_apic_realize;
+    k->unrealize = mshv_apic_unrealize;
+    k->reset = mshv_apic_reset;
+    k->set_base = mshv_apic_set_base;
+    k->set_tpr = mshv_apic_set_tpr;
+    k->get_tpr = mshv_apic_get_tpr;
+    k->external_nmi = mshv_apic_external_nmi;
+    k->vapic_base_update = mshv_apic_vapic_base_update;
+    k->send_msi = mshv_send_msi;
+}
+
+static const TypeInfo mshv_apic_info = {
+    .name = TYPE_MSHV_APIC,
+    .parent = TYPE_APIC_COMMON,
+    .instance_size = sizeof(MshvAPICState),
+    .class_init = mshv_apic_class_init,
+};
+
+static void mshv_apic_register_types(void)
+{
+    type_register_static(&mshv_apic_info);
+}
+
+type_init(mshv_apic_register_types)
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 95e08e3c2a0..fba313376c3 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -22,6 +22,7 @@
  */
 #include "qemu/osdep.h"
 #include "system/whpx.h"
+#include "system/mshv.h"
 #include "system/cpu-timers.h"
 #include "trace.h"
 
@@ -44,6 +45,11 @@ static void pic_irq_request(void *opaque, int irq, int level)
     X86CPU *cpu = X86_CPU(cs);
 
     trace_x86_pic_interrupt(irq, level);
+
+    if (mshv_irqchip_in_kernel()) {
+        return;
+    }
+
     if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
         !whpx_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 04b7257ad12..b4cf048a7c0 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -14,6 +14,7 @@
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
+#include "system/mshv.h"
 #include "system/address-spaces.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/i386/apic_internal.h"
@@ -34,6 +35,8 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "xen-apic";
     } else if (whpx_irqchip_in_kernel()) {
         apic_type = "whpx-apic";
+    } else if (mshv_enabled()) {
+        apic_type = "mshv-apic";
     }
 
     return APIC_COMMON_CLASS(object_class_by_name(apic_type));
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index fa15e399cb8..00e948903d9 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -21,7 +21,6 @@
 #include "hw/hyperv/hvgdk.h"
 #include "hw/hyperv/hvgdk_mini.h"
 #include "hw/hyperv/hvhdk_mini.h"
-#include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
 #include "host-cpu.h"
@@ -955,6 +954,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = mshv_get_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = mshv_get_msrs(cpu);
     if (ret < 0) {
         return ret;
@@ -1377,116 +1381,6 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to get partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int get_lapic(const CPUState *cpu,
-                     struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = get_vp_state(cpu_fd, &mshv_state);
-    if (ret == 0) {
-        memcpy(state, buffer, sizeof(*state));
-    }
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to get lapic");
-        return -1;
-    }
-
-    return 0;
-}
-
-static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
-{
-    return ((reg) & ~0x700) | ((mode) << 8);
-}
-
-static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to set partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int set_lapic(const CPUState *cpu,
-                     const struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    if (!state) {
-        error_report("lapic state is NULL");
-        return -1;
-    }
-    memcpy(buffer, state, sizeof(*state));
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = set_vp_state(cpu_fd, &mshv_state);
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to set lapic: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int init_lint(const CPUState *cpu)
-{
-    int ret;
-    uint32_t *lvt_lint0, *lvt_lint1;
-
-    struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu, &lapic_state);
-    if (ret < 0) {
-        return ret;
-    }
-
-    lvt_lint0 = &lapic_state.apic_lvt_lint0;
-    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
-
-    lvt_lint1 = &lapic_state.apic_lvt_lint1;
-    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
-
-    /* TODO: should we skip setting lapic if the values are the same? */
-
-    return set_lapic(cpu, &lapic_state);
-}
-
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
 {
     int ret;
@@ -1511,6 +1405,12 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: special regs (APIC_BASE) must be restored before LAPIC */
+    ret = mshv_set_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = mshv_set_msrs(cpu);
     if (ret < 0) {
         return ret;
@@ -2100,7 +2000,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     ret = mshv_init_msrs(cpu);
     assert(ret == 0);
 
-    ret = init_lint(cpu);
+    ret = mshv_init_lint(cpu);
     assert(ret == 0);
 }
 
@@ -2247,6 +2147,33 @@ static void mshv_cpu_xsave_init(void)
     }
 }
 
+int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to set partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to get partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
 static void mshv_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 8c220a99423..a5f639c3ca6 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -60,6 +60,8 @@ static const MshvMsrEnvMap msr_env_map[] = {
                              offsetof(CPUX86State, tsc_aux) },
     { IA32_MSR_TSC_ADJUST,   HV_X64_REGISTER_TSC_ADJUST,
                              offsetof(CPUX86State, tsc_adjust) },
+    { IA32_MSR_TSC_DEADLINE, HV_X64_REGISTER_TSC_DEADLINE,
+                             offsetof(CPUX86State, tsc_deadline) },
 
     /* Hyper-V per-partition MSRs */
     { HV_X64_MSR_HYPERCALL,     HV_X64_REGISTER_HYPERCALL,
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index f4d31228633..39ac8c9edc0 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -38,8 +38,8 @@ i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
 i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c', 'tdvf-hob.c'))
 
 subdir('kvm')
-subdir('xen')
 subdir('mshv')
+subdir('xen')
 
 i386_ss.add_all(xenpv_ss)
 
diff --git a/hw/i386/mshv/meson.build b/hw/i386/mshv/meson.build
index 0e556851b67..c631ee13027 100644
--- a/hw/i386/mshv/meson.build
+++ b/hw/i386/mshv/meson.build
@@ -1,4 +1,5 @@
 i386_mshv_ss = ss.source_set()
 i386_mshv_ss.add(files('clock.c'))
+i386_mshv_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c'))
 
 i386_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.55.0


