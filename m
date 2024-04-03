Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AADCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryZ4-0003wA-W4; Wed, 03 Apr 2024 07:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryY8-0003AQ-M2
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:13:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXi-0007Sk-4O
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:13:00 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD0C5CB88;
 Wed,  3 Apr 2024 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1712142751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfbkSVZJfrMR2/YVByx/+8wG9RyEBL2g1dYuJtDDsQw=;
 b=AoyZXJbak3MaxaNfImZip+d3yGfQeCscKfPzWRzT6nR0/U7IlAGnW2PCQS86dq7VhQEhHB
 sHC5CyG7tjmJ7QuGpgp/nBdgM6AyxBK6tr3cap5sggHVCSiwxOkpE9RFDsGkb/T3plTmqK
 RIwuughRSLqOKZd8F9LFdhF5j2s7U90=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 618A213A8B;
 Wed,  3 Apr 2024 11:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KPgaFZ45DWayHQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Apr 2024 11:12:30 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v2 08/10] i386/sev: Implement ConfidentialGuestSupport
 functions for SEV
Date: Wed,  3 Apr 2024 12:11:39 +0100
Message-ID: <2ec365fa84338168164cdaea85050cbb022ab932.1712141833.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712141833.git.roy.hopkins@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLy64u1trr5nq3nwidnuusmct1)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The ConfidentialGuestSupport object defines a number of virtual
functions that are called during processing of IGVM directives to query
or configure initial guest state. In order to support processing of IGVM
files, these functions need to be implemented by relevant isolation
hardware support code such as SEV.

This commit implements the required functions for SEV-ES and adds
support for processing IGVM files for configuring the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 target/i386/sev.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 31dfdc3fe5..46313e7024 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -37,6 +37,7 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/e820_memory_layout.h"
 #include "exec/address-spaces.h"
 
 #define TYPE_SEV_GUEST "sev-guest"
@@ -170,6 +171,9 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
+static int sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr,
+                                  uint64_t len);
+
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
 {
@@ -304,6 +308,14 @@ sev_guest_finalize(Object *obj)
 {
 }
 
+static int cgs_check_support(ConfidentialGuestPlatformType platform,
+                             uint16_t platform_version, uint8_t highest_vtl,
+                             uint64_t shared_gpa_boundary)
+{
+    return (((platform == CGS_PLATFORM_SEV_ES) && sev_es_enabled()) ||
+            ((platform == CGS_PLATFORM_SEV) && sev_enabled())) ? 1 : 0;
+}
+
 static void sev_apply_cpu_context(CPUState *cpu)
 {
     SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
@@ -384,6 +396,54 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
+static int check_vmsa_supported(const struct sev_es_save_area *vmsa)
+{
+    struct sev_es_save_area vmsa_check;
+    size_t i;
+    /*
+     * Clear all supported fields so we can then check the entire structure
+     * is zero.
+     */
+    memcpy(&vmsa_check, vmsa, sizeof(struct sev_es_save_area));
+    memset(&vmsa_check.es, 0, sizeof(vmsa_check.es));
+    memset(&vmsa_check.cs, 0, sizeof(vmsa_check.cs));
+    memset(&vmsa_check.ss, 0, sizeof(vmsa_check.ss));
+    memset(&vmsa_check.ds, 0, sizeof(vmsa_check.ds));
+    memset(&vmsa_check.fs, 0, sizeof(vmsa_check.fs));
+    memset(&vmsa_check.gs, 0, sizeof(vmsa_check.gs));
+    vmsa_check.efer = 0;
+    vmsa_check.cr0 = 0;
+    vmsa_check.cr3 = 0;
+    vmsa_check.cr4 = 0;
+    vmsa_check.xcr0 = 0;
+    vmsa_check.dr6 = 0;
+    vmsa_check.dr7 = 0;
+    vmsa_check.rax = 0;
+    vmsa_check.rcx = 0;
+    vmsa_check.rdx = 0;
+    vmsa_check.rbx = 0;
+    vmsa_check.rsp = 0;
+    vmsa_check.rbp = 0;
+    vmsa_check.rsi = 0;
+    vmsa_check.rdi = 0;
+    vmsa_check.r8 = 0;
+    vmsa_check.r9 = 0;
+    vmsa_check.r10 = 0;
+    vmsa_check.r11 = 0;
+    vmsa_check.r12 = 0;
+    vmsa_check.r13 = 0;
+    vmsa_check.r14 = 0;
+    vmsa_check.r15 = 0;
+    vmsa_check.rip = 0;
+
+    for (i = 0; i < sizeof(vmsa_check); ++i) {
+        if (((uint8_t *)&vmsa_check)[i]) {
+            return 0;
+        }
+    }
+    return 1;
+}
+
 static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
                                uint32_t ctx_len, hwaddr gpa)
 {
@@ -446,6 +506,77 @@ static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
     return 0;
 }
 
+static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                               ConfidentialGuestPageType memory_type,
+                               uint16_t cpu_index, Error **errp)
+{
+    SevGuestState *sev = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    int ret = 1;
+
+    if (!sev_enabled()) {
+        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
+                     "is not enabled",
+                     __func__);
+    } else if (memory_type == CGS_PAGE_TYPE_VMSA) {
+        if (!sev_es_enabled()) {
+            error_setg(errp,
+                       "%s: attempt to configure initial VMSA, but SEV-ES "
+                       "is not supported",
+                       __func__);
+        } else {
+            if (!check_vmsa_supported((const struct sev_es_save_area *)ptr)) {
+                error_setg(errp,
+                           "%s: The VMSA contains fields that are not "
+                           "synchronized with KVM. Continuing would result in "
+                           "either unpredictable guest behavior, or a "
+                           "mismatched launch measurement.",
+                           __func__);
+            } else {
+                ret = sev_set_cpu_context(cpu_index, ptr, len, gpa);
+            }
+        }
+    } else if ((memory_type == CGS_PAGE_TYPE_ZERO) ||
+               (memory_type == CGS_PAGE_TYPE_NORMAL)) {
+        ret = sev_launch_update_data(sev, ptr, len);
+    } else if (memory_type != CGS_PAGE_TYPE_UNMEASURED) {
+        error_setg(
+            errp,
+            "%s: attempted to configure guest memory to use memory_type %d, "
+            "but this type is not supported",
+            __func__, (int)memory_type);
+    }
+    return ret;
+}
+
+static int cgs_get_mem_map_entry(int index,
+                                 ConfidentialGuestMemoryMapEntry *entry,
+                                 Error **errp)
+{
+    if ((index < 0) || (index >= e820_get_num_entries())) {
+        return 1;
+    }
+    entry->gpa = e820_table[index].address;
+    entry->size = e820_table[index].length;
+    switch (e820_table[index].type) {
+    case E820_RAM:
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    case E820_ACPI:
+        entry->type = CGS_MEM_ACPI;
+        break;
+    case E820_NVS:
+        entry->type = CGS_MEM_NVS;
+        break;
+    case E820_UNUSABLE:
+        entry->type = CGS_MEM_UNUSABLE;
+        break;
+    }
+    return 0;
+}
+
 static char *
 sev_guest_get_session_file(Object *obj, Error **errp)
 {
@@ -537,6 +668,7 @@ static void
 sev_guest_instance_init(Object *obj)
 {
     SevGuestState *sev = SEV_GUEST(obj);
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
 
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
@@ -549,6 +681,11 @@ sev_guest_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+
+    cgs->check_support = cgs_check_support;
+    cgs->set_guest_state = cgs_set_guest_state;
+    cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+
     QTAILQ_INIT(&sev->launch_vmsa);
 }
 
-- 
2.43.0


