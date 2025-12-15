Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60135D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYg-0006Uw-Nl; Mon, 15 Dec 2025 15:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYP-0006Ji-Ar
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYN-0005p1-DA
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RU4gCD89I0rnoKneGioT3W3S9tJDhKT//EINbLeoG/g=;
 b=e4O2ZnxJ3d2TW/Keoiepi/1+1im8qhhsCshckfILrVi3mIaLfhFx7Ua6LPGO3jcx2Szdjz
 A03C36F/Neyph1L5cm3q5+xIOlVZdCSue627JRy21ek9JjgmjXzIQQQv0SpCpHfif675IU
 DLIiAevhm4RAVzJDLh9GBhvkVMsPzDc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-U9QumEO9NPOLo3rGkL16tA-1; Mon, 15 Dec 2025 15:52:20 -0500
X-MC-Unique: U9QumEO9NPOLo3rGkL16tA-1
X-Mimecast-MFC-AGG-ID: U9QumEO9NPOLo3rGkL16tA_1765831940
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ee25cd2da3so72500701cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831940; x=1766436740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RU4gCD89I0rnoKneGioT3W3S9tJDhKT//EINbLeoG/g=;
 b=Mpnt/aH/bXMWpfxkj/bFEe95OnXuFLq+GyyQNRMOeozjMuGxWyMQ7v2vDwdlNhc1CR
 kzCxv5UW4K8rqZwuS3xEnZjI3GlvpuxVVqcyUnCGdUb85McKtANbjAOXsIsNB/Fqd18n
 k4seL5H0miw7jVvvDTDqDsCpfaOugZV1K59r3f/cIkRoIM6aWc+TmJjWqBCnxyTvlLaR
 B6WkkXg5XGId8lUUX1MZHPDaU2R4+8oaQuXQBIdJgRF10QBBzdlGEcUPGo21qLOxsfn8
 L7gwY7kUEnKMlclfZ2W6yJR+208lZgQ6GhyYUaoOZY3PLS5cy5OAVJCiAMH+lkyLwcUa
 b1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831940; x=1766436740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RU4gCD89I0rnoKneGioT3W3S9tJDhKT//EINbLeoG/g=;
 b=RVKL9UT3nPTTNgZ7B5WAYbbpl1o4OTtwUiWduBhDxIfM9COkvkjBeZrRCy0IOnazIQ
 SM8ima0KAHZzYz0VHwPpEisksU35IaBjU3Ilf/5eqIoEe1yst8KxweIcZ0/Fy9Cr22dt
 kn6iSaQSvg3qvxRE5S+IY7NdsFU5DCU+4uevBmuTgwH/rPN8t2gNGn5wKD+kSPjVaKq2
 +otVLvXysby+SmfEsD2TkaxjobwT4LV3M9Rr5hIY5XYRJtjK2yOCEk0Ud3bhfrp/iIV3
 2oavr0CcW6SdXfQAN9TL9WVpYd2QMnXqOCtu1SQKTs+78Vifl3ppRzxFMlJjnJpDaU8T
 hB7w==
X-Gm-Message-State: AOJu0Yx8WtFJ+WnVQf+UIo02ttljGC7c+B0eo3yPamjxH3/iSlH8uo6l
 WLU0hvj20HBWIdk3WE320qLNpa2UqOQoxzrxLTdEf5oqG9OJDPE1TbQvAL3rYmCjb14hkuo9I7R
 6DkhAcHwS3uSR+mDNsHX6VLxpoeFj31rnBqHBeg6AyoxtzLp/l3rVPPfiGhJDTrHNlcm0cbcE8u
 5G6Jb0OBjUhQDTU/gvAV6mxDiHvF0n6BmuUjwxwg==
X-Gm-Gg: AY/fxX41vV7Bwtf90GXoznMFwN/cnAbykVHOXBgvMKNLBhN4h13bvBAUhpHiuQgKvu2
 ihj9oy0Hjh6kBAMA9hMi9qzkwgdS9HehjuGyAiT+Q48QZtW4X4f6De/TwU7jISR080gr7Jgoc5d
 L5QAXczzC4d111b8uUhoq1JOA276lGc3vfzBYLd+ET2BpNtdR93+TLOWsUVCIHuyrMrLAGp/WXs
 8FQFChaVi37CauewrsJCe4HEdPPtoBV+wACLd7P66TeiQ9ZtsvyagRGsFWbhBDdv0mGagi4Obwa
 KQOkgTWPTvHD6OuCR9Z9yFPGZprDvovN5k/OF+yMKy5M8OcLmngsm6MbvuaH44hZkAifvE6CKs7
 s
X-Received: by 2002:a05:622a:1195:b0:4ed:e0c1:44d5 with SMTP id
 d75a77b69052e-4f1d04a556amr174108811cf.19.1765831939814; 
 Mon, 15 Dec 2025 12:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdq9CD9YhihSu+Iak3GteAoFJbCIBkYpGjgr7KPytI789B1sZrK9BmbzOvLN1PCaBPUIv5Eg==
X-Received: by 2002:a05:622a:1195:b0:4ed:e0c1:44d5 with SMTP id
 d75a77b69052e-4f1d04a556amr174108471cf.19.1765831939227; 
 Mon, 15 Dec 2025 12:52:19 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 09/12] machine: Rename machine_require_guest_memfd() to
 *_private()
Date: Mon, 15 Dec 2025 15:52:00 -0500
Message-ID: <20251215205203.1185099-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Differenciate it from fully shared guest-memfd use cases.

When at it, add proper brackets in kvm_handle_hc_map_gpa_range() otherwise
checkpatch may complain.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/boards.h   | 2 +-
 backends/hostmem.c    | 2 +-
 hw/core/machine.c     | 2 +-
 hw/i386/pc.c          | 2 +-
 hw/i386/pc_sysfw.c    | 4 ++--
 hw/i386/x86-common.c  | 4 ++--
 target/i386/kvm/kvm.c | 3 ++-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a48ed4f86a..3a0a051d19 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -42,7 +42,7 @@ bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
-bool machine_require_guest_memfd(MachineState *machine);
+bool machine_require_guest_memfd_private(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 70450733db..e2dcae50c4 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd_private = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd_private(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 27372bb01e..3bdce197f7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1376,7 +1376,7 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
-bool machine_require_guest_memfd(MachineState *machine)
+bool machine_require_guest_memfd_private(MachineState *machine)
 {
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8b919cb6c..b2d55ceb5e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -962,7 +962,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-        if (machine_require_guest_memfd(machine)) {
+        if (machine_require_guest_memfd_private(machine)) {
             memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
                                             PC_ROM_SIZE, &error_fatal);
         } else {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a12b635ad..1c37258654 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -52,7 +52,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    if (machine_require_guest_memfd(MACHINE(pcms))) {
+    if (machine_require_guest_memfd_private(MACHINE(pcms))) {
         memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
                                            isa_bios_size, &error_fatal);
     } else {
@@ -71,7 +71,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    if (!machine_require_guest_memfd(current_machine)) {
+    if (!machine_require_guest_memfd_private(current_machine)) {
         memory_region_set_readonly(isa_bios, true);
     }
 }
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c844749900..33ac7fb6e9 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1044,7 +1044,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    if (machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
         if (is_tdx_vm()) {
@@ -1074,7 +1074,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     }
     g_free(filename);
 
-    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
         x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
                           !isapc_ram_fw);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..5d0d02bcaf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6050,8 +6050,9 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
     uint64_t gpa, size, attributes;
     int ret;
 
-    if (!machine_require_guest_memfd(current_machine))
+    if (!machine_require_guest_memfd_private(current_machine)) {
         return -EINVAL;
+    }
 
     gpa = run->hypercall.args[0];
     size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
-- 
2.50.1


