Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E14C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynt-0007M4-Sl; Tue, 27 Feb 2024 09:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynS-0006bt-7O
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:06 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynP-0004VX-RC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:05 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 637F32274A;
 Tue, 27 Feb 2024 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXBdzxjXS/YjshgYtenwA8mSTKK5/z7GQIu3Oa2N0pY=;
 b=WCMCMBMqlp1shnVGs4/MnvRdhD1PMuIBhiQN1ZFCp7qjxXTvaYe0MjduNaBRi9giX8G1eC
 Yg5YraJC6AXicaOnBWVlEQx150GuEPJhF+XSzCUlrDPqv3IEsSMRF5ucLSEduk3F5SbljT
 9Ey2stGhcxPpy68rT5PVCzXK0U2Qvro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXBdzxjXS/YjshgYtenwA8mSTKK5/z7GQIu3Oa2N0pY=;
 b=WCMCMBMqlp1shnVGs4/MnvRdhD1PMuIBhiQN1ZFCp7qjxXTvaYe0MjduNaBRi9giX8G1eC
 Yg5YraJC6AXicaOnBWVlEQx150GuEPJhF+XSzCUlrDPqv3IEsSMRF5ucLSEduk3F5SbljT
 9Ey2stGhcxPpy68rT5PVCzXK0U2Qvro=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AABF13419;
 Tue, 27 Feb 2024 14:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0A0nI9X23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:51:01 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH 8/9] i386/sev: Implement ConfidentialGuestSupport functions
 for SEV
Date: Tue, 27 Feb 2024 14:50:14 +0000
Message-ID: <f581ca6901700238557a92baefaaa0f822fc9f71.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=WCMCMBMq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.com:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 637F32274A
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The ConfidentialGuestSupport object defines a number of virtual
functions that are called during processing of IGVM directives to query
or configure initial guest state. In order to support processing of IGVM
files, these functions need to be implemented by relevant isolation
hardware support code such as SEV.

This commit implements the required functions for SEV-ES and adds
support for processing IGVM files for configuring the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 target/i386/sev.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d6902432fd..b85ccff9db 100644
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
@@ -447,6 +459,65 @@ static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
     return 0;
 }
 
+static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                               ConfidentialGuestPageType memory_type,
+                               uint16_t cpu_index)
+{
+    SevGuestState *sev = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    int ret = 1;
+
+    if (!sev_enabled()) {
+        error_report("%s: attempt to configure guest memory, but SEV "
+                     "is not enabled",
+                     __func__);
+    } else if (memory_type == CGS_PAGE_TYPE_VMSA) {
+        if (!sev_es_enabled()) {
+            error_report("%s: attempt to configure initial VMSA, but SEV-ES "
+                         "is not supported",
+                         __func__);
+        } else {
+            ret = sev_set_cpu_context(cpu_index, ptr, len, gpa);
+        }
+    } else if ((memory_type != CGS_PAGE_TYPE_REQUIRED_MEMORY) &&
+               (memory_type != CGS_PAGE_TYPE_UNMEASURED)) {
+        ret = sev_launch_update_data(sev, ptr, len);
+    } else {
+        error_report(
+            "%s: attempted to configure guest memory to use memory_type %d, "
+            "but this type is not supported by SEV-ES",
+            __func__, (int)memory_type);
+    }
+    return ret;
+}
+
+static int cgs_get_mem_map_entry(int index,
+                                  ConfidentialGuestMemoryMapEntry *entry)
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
@@ -538,6 +609,7 @@ static void
 sev_guest_instance_init(Object *obj)
 {
     SevGuestState *sev = SEV_GUEST(obj);
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
 
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
@@ -550,6 +622,11 @@ sev_guest_instance_init(Object *obj)
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


