Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72178C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnj-0007e1-6T; Tue, 23 Apr 2024 11:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnG-00053p-Qk
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnF-0000Kh-0z
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI+DHKUST1LorYo9iB//kbQZlx8+VMMDkCZPUbhalqA=;
 b=BOQKvaJzOOob+jEI1Y2TL/PFqlNKvCeY5t70rc+r+p7YssNVZXdURipvhOcr27fjEJaJvY
 qeovyMfujWRbdSeZRPWvdAPj48zLuZ8s4WUoet4MX6vsIt4eNMsCAMAp1YGM7BVonTgjxY
 i0VMoIb7hmcIjx2STHa/SCRVS3wsLgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-hNtg1CyWNLGKIe1n6H7dFA-1; Tue, 23 Apr 2024 11:10:45 -0400
X-MC-Unique: hNtg1CyWNLGKIe1n6H7dFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCC53834FB4;
 Tue, 23 Apr 2024 15:10:44 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3422200E290;
 Tue, 23 Apr 2024 15:10:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PULL 52/63] HostMem: Add mechanism to opt in kvm guest memfd via
 MachineState
Date: Tue, 23 Apr 2024 17:09:40 +0200
Message-ID: <20240423150951.41600-53-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Add a new member "guest_memfd" to memory backends. When it's set
to true, it enables RAM_GUEST_MEMFD in ram_flags, thus private kvm
guest_memfd will be allocated during RAMBlock allocation.

Memory backend's @guest_memfd is wired with @require_guest_memfd
field of MachineState. It avoid looking up the machine in phymem.c.

MachineState::require_guest_memfd is supposed to be set by any VMs
that requires KVM guest memfd as private memory, e.g., TDX VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240320083945.991426-8-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/boards.h      | 2 ++
 include/sysemu/hostmem.h | 1 +
 backends/hostmem-file.c  | 1 +
 backends/hostmem-memfd.c | 1 +
 backends/hostmem-ram.c   | 1 +
 backends/hostmem.c       | 1 +
 hw/core/machine.c        | 5 +++++
 7 files changed, 12 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 50e0cf4278e..69c1ba45cf9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -36,6 +36,7 @@ bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
+bool machine_require_guest_memfd(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
@@ -370,6 +371,7 @@ struct MachineState {
     char *dt_compatible;
     bool dump_guest_core;
     bool mem_merge;
+    bool require_guest_memfd;
     bool usb;
     bool usb_disabled;
     char *firmware;
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 0e411aaa29e..04b884bf42a 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -74,6 +74,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
+    bool guest_memfd;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ac3e433cbdd..3c69db79460 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -85,6 +85,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 3923ea9364d..745ead0034d 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -55,6 +55,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index d121249f0f4..f7d81af783a 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,6 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 81a72ce40b7..eb9682b4a85 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -277,6 +277,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
+    backend->guest_memfd = machine_require_guest_memfd(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a92bec23147..582c2df37aa 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1201,6 +1201,11 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
+bool machine_require_guest_memfd(MachineState *machine)
+{
+    return machine->require_guest_memfd;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s = g_string_new(NULL);
-- 
2.44.0



