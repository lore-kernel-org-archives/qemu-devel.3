Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F4BCA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0X-0002ZI-NO; Wed, 30 Sep 2026 11:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0P-0002UD-II
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0N-0000iC-Fk
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soivliGS3V3qOZBKXvbV1mUa7dYCQpqfRa1KAw9iuwc=;
 b=dd6BWahYHUq39rvC3K0Vq/YDBe1URnLOV9JYNzBD9CsPwhfUc5x868qFFDkB6kIFADIJia
 9WsGTGRqZa7ClGRHdW1oqirydyy05zfj1JNxFeM2vengEPJ8nXz3LF5hiaq8kO1Kl+FDKD
 6/B8w6dZNb15sVjLRXGNgI8xAQCUBxw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Cz3ymEkgP7SS1fLA4mgwTg-1; Wed, 30 Sep 2026 11:13:57 -0400
X-MC-Unique: Cz3ymEkgP7SS1fLA4mgwTg-1
X-Mimecast-MFC-AGG-ID: Cz3ymEkgP7SS1fLA4mgwTg_1790781237
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cafdbdb7cso67204085a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781236; x=1791386036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=soivliGS3V3qOZBKXvbV1mUa7dYCQpqfRa1KAw9iuwc=;
 b=BSzlFZbcZdDvdkmHp7kpzO9AkNi/yyRsVSBjjEcWotdWgFqfYagaIROJK7SFaGwF9v
 /jTP/cb5s4Taq/cQbjpPCSvzpdN2ZEEnXN04/u09PTINMcAYBsXLZIT6zsjYD/Xe9xbO
 MEFmF9SAC6uqg4Y1el4hUqFkUzsbSpcMRLjIVPz37j6x2vxkEdMUryH97jB9jFTRxcs9
 aFBOZEWLgz2t5T7SOz1806Y72HfKRtIkdd8oZwAh9mBy8eFjo24Q+e+UAfZDVM7vUtY4
 zk+e1ZCnQKezWb2OpLjp6/CDU3EwvH8h+REuHehqoeqmT+2V8J+zJNEd4QshHeGj1N/4
 9EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781236; x=1791386036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=soivliGS3V3qOZBKXvbV1mUa7dYCQpqfRa1KAw9iuwc=;
 b=ec1mCA4bkaaT0TRf0Ju5Kw4O2FA2GkV34ewRva3Kp43Np//U97D6a3JbYZALBG8rMJ
 rbnnRFRlGAa61DFaWa7mJJt6McXCb+0Rg5nzKurhLk5amnyzlbXEKxOF66ZBQEBJy9Kk
 tPMQl/Mo1T1Mm7FSSXOaCen+JgjqnP+ontjcwtItoRAYRMWK19BAfYnVj1DwkSAAeTLw
 ZXGshbzzpLgkGUDgOu81NBntlqSZsddqz6RGdykmANwEvwzFQVe0WV8JJtEGshf968zV
 GGWaiDZ+et1OPLxvAXNUO+unukZsp/FDs7KXcZrSzrxQ/XunCPLaufBMdnmYJMOE+ccm
 LsuA==
X-Gm-Message-State: AFuF++kCF5CExmjwIAy6cjO22DJ+i9uK6kg/9vPwU3y4xU3bqFUgzmrC
 l2jh4wGInJGrceVElNaUbgB+GPhd/rBQYXsSrSwoABsD2oKkkD7pvXuDrcDMNZBFu+uigKPTGsH
 v9nt/GR173rARwlkLAtVK4qKVmNNUi33rnzG/XcT+8fdgKr7G+Vtq9q4lxw+Lu695CUKsRCkXev
 I6ULZ8u2nC8lAlgW0IdCtQlKL2BGoFSee/tm3QqYMo
X-Gm-Gg: AYBFou0oeQ2sRmm0MZOqYf4XLPtO9dIQiIlwWTM8TZ5YgIVbk4+mMORi0+lsuPe1/zX
 v8gDXNKwKc2pgiHL4WUhpnbr5cKJEnrgroYt2dvkRjYWOj5q386qzyvynhwWpsdrSUbyOEnS/Ch
 +APFHHrkgiKUZLe+vsJnQhktv/s8F6Zl3zUT4ua9QOocTqYdmoa7g9pbtJu+dynSO5//ApFAujl
 5YYxMBK24gbQNgiDRmBqHb+tYqO/hdXoOGoq1E5CnT4+5y4TwFuVPAp6uCOxxHAgFFCL7Wxc2Q2
 R0WBq9q3m2afu8BezWZpPEaZXDDoHW72P2bhLPLO1ar3eKt8JetVtsWZ6IdKW7jDihKoThg=
X-Received: by 2002:a05:620a:489a:b0:93c:60ea:d0b with SMTP id
 af79cd13be357-93ca9744bd1mr289329185a.21.1790781236401; 
 Wed, 30 Sep 2026 08:13:56 -0700 (PDT)
X-Received: by 2002:a05:620a:489a:b0:93c:60ea:d0b with SMTP id
 af79cd13be357-93ca9744bd1mr289318785a.21.1790781235558; 
 Wed, 30 Sep 2026 08:13:55 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca7eb1207sm137644085a.4.2026.09.30.08.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 08/12] machine: Rename machine_require_guest_memfd() to
 *_private()
Date: Wed, 30 Sep 2026 11:13:36 -0400
Message-ID: <20260930151340.2817042-9-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Differentiate it from fully shared guest-memfd use cases.

When at it, add proper brackets in kvm_handle_hc_map_gpa_range()
otherwise checkpatch may complain.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-9-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/core/boards.h | 2 +-
 backends/hostmem.c       | 2 +-
 hw/core/machine.c        | 2 +-
 hw/i386/pc.c             | 2 +-
 hw/i386/pc_sysfw.c       | 4 ++--
 hw/i386/x86-common.c     | 4 ++--
 target/i386/kvm/kvm.c    | 3 ++-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 3b86724cf0..d0e4ad9820 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -43,7 +43,7 @@ bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
-bool machine_require_guest_memfd(MachineState *machine);
+bool machine_require_guest_memfd_private(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index a41540d50d..8782c8b1ea 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -290,7 +290,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd_private = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd_private(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f7be52a1..438624ece3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1337,7 +1337,7 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
-bool machine_require_guest_memfd(MachineState *machine)
+bool machine_require_guest_memfd_private(MachineState *machine)
 {
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b649f184de..2fd90fa739 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -873,7 +873,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-        if (machine_require_guest_memfd(machine)) {
+        if (machine_require_guest_memfd_private(machine)) {
             memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
                                             PC_ROM_SIZE, &error_fatal);
         } else {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 441e777191..b6a56ef1fd 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -51,7 +51,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    if (machine_require_guest_memfd(MACHINE(pcms))) {
+    if (machine_require_guest_memfd_private(MACHINE(pcms))) {
         memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
                                            isa_bios_size, &error_fatal);
     } else {
@@ -70,7 +70,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    if (!machine_require_guest_memfd(current_machine)) {
+    if (!machine_require_guest_memfd_private(current_machine)) {
         memory_region_set_readonly(isa_bios, true);
     }
 }
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index ae58352760..59e92b1a1b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1036,7 +1036,7 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
     ssize_t ret;
 
     /* BIOS load */
-    if (machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
         if (is_tdx_vm()) {
@@ -1106,7 +1106,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     bios_size = get_bios_size(x86ms, bios_name, filename);
     load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
 
-    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
         x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
                           !isapc_ram_fw);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1eeadb99ad..a72b6e6b74 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6488,8 +6488,9 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
     uint64_t gpa, size, attributes;
     int ret;
 
-    if (!machine_require_guest_memfd(current_machine))
+    if (!machine_require_guest_memfd_private(current_machine)) {
         return -EINVAL;
+    }
 
     gpa = run->hypercall.args[0];
     size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
-- 
2.55.0


