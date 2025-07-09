Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A2BC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZTwa-00022t-E4; Wed, 09 Jul 2025 08:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uZTwQ-00020z-D8
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uZTwJ-0003bg-TN
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752064215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LOywc7NyngCljHvSWDVBYR9BbaesNqE6f14XE3JehZU=;
 b=PJJiQwcwCwyuXi7rmCZayEbLc+j1LcgeFw3vsMHupk+uvBjNJR1FOaWD42xZRA6j1xIhOH
 1ixRmBrCQN+Junpqk/q2yHKjCd9pDRTkQn5z0nlUIttUGeAhQ0Y2we5QGSBjY4TPMvpCYh
 7+ZgZXXAIq1xRgWhacJ9bPiaffBwsfA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-UD_DTty4N9O5-9lkDbAtHA-1; Wed,
 09 Jul 2025 08:30:12 -0400
X-MC-Unique: UD_DTty4N9O5-9lkDbAtHA-1
X-Mimecast-MFC-AGG-ID: UD_DTty4N9O5-9lkDbAtHA_1752064211
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21DDE19560AD; Wed,  9 Jul 2025 12:30:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 235473000198; Wed,  9 Jul 2025 12:30:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E90B18000B2; Wed, 09 Jul 2025 14:30:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, roy.hopkins@randomman.co.uk,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] igvm: add initial support for non-cc firmware in igvm format
Date: Wed,  9 Jul 2025 14:30:07 +0200
Message-ID: <20250709123007.1039675-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Implement a ConfidentialGuestSupportClass for non-confidential VMs.
This allows the igvm support code work without sev/tdx.

RfC: Not fully sure this is the best way to implement this.
Alternatively we could add this directly into the igvm backend and run
it in case no confidential guest support object is present.

TODO: Implement proper reset.
 - re-initialize memory regions from igvm file content.
 - load initial register state (if present).

Usage:
  qemu-system-x86_64 \
    -object nocc,id=nocc0 \
    -machine confidential-guest-support=nocc0

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/nocc.c      | 283 ++++++++++++++++++++++++++++++++++++++++
 qapi/qom.json           |   1 +
 target/i386/meson.build |   1 +
 3 files changed, 285 insertions(+)
 create mode 100644 target/i386/nocc.c

diff --git a/target/i386/nocc.c b/target/i386/nocc.c
new file mode 100644
index 000000000000..5d92fb0a4033
--- /dev/null
+++ b/target/i386/nocc.c
@@ -0,0 +1,283 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "hw/i386/pc.h"
+#include "hw/i386/e820_memory_layout.h"
+
+#include "cpu.h"
+#include "confidential-guest.h"
+
+#define TYPE_NO_CC "nocc"
+OBJECT_DECLARE_TYPE(NoCCState, NoCCStateClass, NO_CC);
+
+struct IgvmNativeVpContextX64 {
+    uint64_t rax;
+    uint64_t rcx;
+    uint64_t rdx;
+    uint64_t rbx;
+    uint64_t rsp;
+    uint64_t rbp;
+    uint64_t rsi;
+    uint64_t rdi;
+    uint64_t r8;
+    uint64_t r9;
+    uint64_t r10;
+    uint64_t r11;
+    uint64_t r12;
+    uint64_t r13;
+    uint64_t r14;
+    uint64_t r15;
+    uint64_t rip;
+    uint64_t rflags;
+    uint64_t idtr_base;
+    uint16_t idtr_limit;
+    uint16_t reserved[2];
+    uint16_t gdtr_limit;
+    uint64_t gdtr_base;
+
+    uint16_t code_selector;
+    uint16_t code_attributes;
+    uint32_t code_base;
+    uint32_t code_limit;
+
+    uint16_t data_selector;
+    uint16_t data_attributes;
+    uint32_t data_base;
+    uint32_t data_limit;
+
+    uint64_t gs_base;
+    uint64_t cr0;
+    uint64_t cr3;
+    uint64_t cr4;
+    uint64_t efer;
+};
+
+struct NoCCState {
+    X86ConfidentialGuest parent_obj;
+    struct IgvmNativeVpContextX64 regs;
+    bool have_regs;
+};
+
+struct NoCCStateClass {
+    X86ConfidentialGuestClass parent_class;
+};
+
+#define FLAGS_TO_SEGCACHE(flags)                \
+    (((unsigned int)flags) << 8)
+
+static void no_cc_set_regs(NoCCState *nocc)
+{
+    X86CPU *x86 = X86_CPU(first_cpu);
+    CPUX86State *env = &x86->env;
+
+    cpu_load_efer(env, nocc->regs.efer);
+    cpu_x86_update_cr4(env, nocc->regs.cr4);
+    cpu_x86_update_cr0(env, nocc->regs.cr0);
+    cpu_x86_update_cr3(env, nocc->regs.cr3);
+
+    cpu_x86_load_seg_cache(
+        env, R_CS, nocc->regs.code_selector,
+        nocc->regs.code_base, nocc->regs.code_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.code_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_DS, nocc->regs.data_selector,
+        nocc->regs.data_base, nocc->regs.data_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_ES, nocc->regs.data_selector,
+        nocc->regs.data_base, nocc->regs.data_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_FS, nocc->regs.data_selector,
+        nocc->regs.data_base, nocc->regs.data_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_GS, nocc->regs.data_selector,
+        nocc->regs.data_base, nocc->regs.data_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.data_attributes));
+    cpu_x86_load_seg_cache(
+        env, R_SS, nocc->regs.data_selector,
+        nocc->regs.data_base, nocc->regs.data_limit,
+        FLAGS_TO_SEGCACHE(nocc->regs.data_attributes));
+
+    env->gdt.base = nocc->regs.gdtr_base;
+    env->gdt.limit = nocc->regs.gdtr_limit;
+    env->idt.base = nocc->regs.idtr_base;
+    env->idt.limit = nocc->regs.idtr_limit;
+
+    env->regs[R_EAX] = nocc->regs.rax;
+    env->regs[R_ECX] = nocc->regs.rcx;
+    env->regs[R_EDX] = nocc->regs.rdx;
+    env->regs[R_EBX] = nocc->regs.rbx;
+    env->regs[R_ESP] = nocc->regs.rsp;
+    env->regs[R_EBP] = nocc->regs.rbp;
+    env->regs[R_ESI] = nocc->regs.rsi;
+    env->regs[R_EDI] = nocc->regs.rdi;
+#ifdef TARGET_X86_64
+    env->regs[R_R8] = nocc->regs.r8;
+    env->regs[R_R9] = nocc->regs.r9;
+    env->regs[R_R10] = nocc->regs.r10;
+    env->regs[R_R11] = nocc->regs.r11;
+    env->regs[R_R12] = nocc->regs.r12;
+    env->regs[R_R13] = nocc->regs.r13;
+    env->regs[R_R14] = nocc->regs.r14;
+    env->regs[R_R15] = nocc->regs.r15;
+#endif
+    env->eip = nocc->regs.rip;
+    env->eflags = nocc->regs.rflags;
+}
+
+static int no_cc_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    info_report("%s:", __func__);
+    return 0;
+}
+
+static int no_cc_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    NoCCState *nocc = NO_CC(cgs);
+
+    info_report("%s: have regs %s", __func__, nocc->have_regs ? "yes" : "no");
+
+    if (nocc->have_regs) {
+        no_cc_set_regs(NO_CC(cgs));
+    }
+    return 0;
+}
+
+static bool no_cc_check_support(ConfidentialGuestPlatformType platform,
+                                uint16_t platform_version, uint8_t highest_vtl,
+                                uint64_t shared_gpa_boundary)
+{
+    return false;
+}
+
+static int no_cc_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                                 ConfidentialGuestPageType memory_type,
+                                 uint16_t cpu_index, Error **errp)
+{
+    static const char *names[] = {
+        [ CGS_PAGE_TYPE_NORMAL ]          = "normal",
+        [ CGS_PAGE_TYPE_VMSA ]            = "vmsa",
+        [ CGS_PAGE_TYPE_ZERO ]            = "zero",
+        [ CGS_PAGE_TYPE_UNMEASURED ]      = "unmeasured",
+        [ CGS_PAGE_TYPE_SECRETS ]         = "secrets",
+        [ CGS_PAGE_TYPE_CPUID ]           = "cpuid",
+        [ CGS_PAGE_TYPE_REQUIRED_MEMORY ] = "required-mem",
+    };
+
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    NoCCState *nocc = NO_CC(cgs);
+    struct IgvmNativeVpContextX64 *regs;
+
+    switch (memory_type) {
+    case CGS_PAGE_TYPE_VMSA:
+        info_report("%s: %lx +%lx [%s, unsupported]",
+                    __func__, gpa, len, names[memory_type]);
+        regs = (void *)ptr;
+        nocc->regs = *regs;
+        nocc->have_regs = true;
+        /*
+         * FIXME: need some non-hackish way to hook up cgs->kvm_reset() + apply
+         * initial register state in non-CC mode.
+         *
+         * Initial register state is optional.  If not present the platform
+         * default should be used (i.e. real mode entry at f000:fff0 on x86).
+         * In that case we have nothing special to do.
+         *
+         * Throw an error for now if we got some initial register state.
+         */
+        return -1;
+
+    case CGS_PAGE_TYPE_NORMAL:
+    case CGS_PAGE_TYPE_ZERO:
+    case CGS_PAGE_TYPE_UNMEASURED:
+    case CGS_PAGE_TYPE_REQUIRED_MEMORY:
+        info_report("%s: %lx +%lx [%s]",
+                    __func__, gpa, len, names[memory_type]);
+        return 0;
+
+    case CGS_PAGE_TYPE_SECRETS:
+    case CGS_PAGE_TYPE_CPUID:
+        error_report("%s: %lx +%lx [%s, unsupported]",
+                     __func__, gpa, len, names[memory_type]);
+        return -1;
+
+    default:
+        error_setg(errp, "%s: unknown memory type: %d", __func__, memory_type);
+        return -1;
+    }
+}
+
+static int no_cc_get_mem_map_entry(int index,
+                                   ConfidentialGuestMemoryMapEntry *entry,
+                                   Error **errp)
+{
+    struct e820_entry *table;
+    int num_entries;
+
+    num_entries = e820_get_table(&table);
+    if ((index < 0) || (index >= num_entries)) {
+        return 1;
+    }
+    entry->gpa = table[index].address;
+    entry->size = table[index].length;
+    switch (table[index].type) {
+    case E820_RAM:
+        info_report("%s: ram: %lx +%lx", __func__, entry->gpa, entry->size);
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        info_report("%s: reserved: %lx +%lx", __func__, entry->gpa, entry->size);
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    default:
+        return -1;
+    }
+    return 0;
+}
+
+static void
+no_cc_class_init(ObjectClass *oc, const void *data)
+{
+    ConfidentialGuestSupportClass *cgsc =
+        CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    cgsc->kvm_init = no_cc_kvm_init;
+    cgsc->kvm_reset = no_cc_kvm_reset;
+    cgsc->check_support = no_cc_check_support;
+    cgsc->set_guest_state = no_cc_set_guest_state;
+    cgsc->get_mem_map_entry = no_cc_get_mem_map_entry;
+}
+
+static void
+no_cc_instance_init(Object *obj)
+{
+    ConfidentialGuestSupport *cgs =
+        CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    cgs->ready = true;
+}
+
+static const TypeInfo no_cc_info = {
+    .parent = TYPE_X86_CONFIDENTIAL_GUEST,
+    .name = TYPE_NO_CC,
+    .instance_size = sizeof(NoCCState),
+    .instance_init = no_cc_instance_init,
+    .class_size = sizeof(NoCCStateClass),
+    .class_init = no_cc_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+no_cc_register_types(void)
+{
+    type_register_static(&no_cc_info);
+}
+
+type_init(no_cc_register_types);
diff --git a/qapi/qom.json b/qapi/qom.json
index bbdb56dced66..bd5d03916efa 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1184,6 +1184,7 @@
       'if': 'CONFIG_SECRET_KEYRING' },
     'sev-guest',
     'sev-snp-guest',
+    'nocc',
     'thread-context',
     's390-pv-guest',
     'tdx-guest',
diff --git a/target/i386/meson.build b/target/i386/meson.build
index c1aacea61356..d37bc4b567ab 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -5,6 +5,7 @@ i386_ss.add(files(
   'helper.c',
   'xsave_helper.c',
   'cpu-dump.c',
+  'nocc.c',
 ))
 i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
 
-- 
2.50.0


