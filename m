Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B0C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynS-0006aB-GW; Tue, 27 Feb 2024 09:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynO-0006Mt-Pk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:02 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynM-0004Uh-Kw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:02 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36B121FD3C;
 Tue, 27 Feb 2024 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/PfuEzuu0V4Eit1yyyghUz61B2y3/Qq7SwoRltnwWY=;
 b=GJul1lVY1kd9eefuCyaCxaB7bEsafY4Pc32Ou4/LSS7xHjKKTq8pI8r80ZLFuxqjdWSkEq
 7GaEBsAA6vnxsQldzKZaM0yHyFTHBTlFz7ktj+GfIUXxcUrvEKgJE6tFHEXZI8J9v03Vcf
 3D5rtXLmb5XxJ3EBTrhRRmY9pNq4MKM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/PfuEzuu0V4Eit1yyyghUz61B2y3/Qq7SwoRltnwWY=;
 b=GJul1lVY1kd9eefuCyaCxaB7bEsafY4Pc32Ou4/LSS7xHjKKTq8pI8r80ZLFuxqjdWSkEq
 7GaEBsAA6vnxsQldzKZaM0yHyFTHBTlFz7ktj+GfIUXxcUrvEKgJE6tFHEXZI8J9v03Vcf
 3D5rtXLmb5XxJ3EBTrhRRmY9pNq4MKM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F17113ABC;
 Tue, 27 Feb 2024 14:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id OO23GNH23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:50:57 +0000
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
Subject: [PATCH 3/9] backends/confidential-guest-support: Add functions to
 support IGVM
Date: Tue, 27 Feb 2024 14:50:09 +0000
Message-ID: <0d5af28ab63f6e4e4089b8b5a11b9fc9c941986f.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=GJul1lVY
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
X-Rspamd-Queue-Id: 36B121FD3C
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
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

In preparation for supporting the processing of IGVM files to configure
guests, this adds a set of functions to ConfidentialGuestSupport
allowing configuration of secure virtual machines that can be
implemented for each supported isolation platform type such as Intel TDX
or AMD SEV-SNP. These functions will be called by IGVM processing code
in subsequent patches.

This commit provides a default implementation of the functions that
either perform no action or generate a warning or error when they are
called. Targets that support ConfidentalGuestSupport should override
these implementations.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 backends/confidential-guest-support.c     | 26 ++++++++
 include/exec/confidential-guest-support.h | 76 +++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index da436fb736..42628be8d7 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "exec/confidential-guest-support.h"
+#include "qemu/error-report.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
@@ -45,8 +46,33 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
+static int check_support(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary)
+{
+    /* Default: no support. */
+    return 0;
+}
+
+static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                                 ConfidentialGuestPageType memory_type,
+                                 uint16_t cpu_index)
+{
+    warn_report("Confidential guest memory not supported");
+    return -1;
+}
+
+static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry)
+{
+    return 1;
+}
+
 static void confidential_guest_support_init(Object *obj)
 {
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+    cgs->check_support = check_support;
+    cgs->set_guest_state = set_guest_state;
+    cgs->get_mem_map_entry = get_mem_map_entry;
 }
 
 static void confidential_guest_support_finalize(Object *obj)
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index b08ad8de4d..c43a1a32f1 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -21,10 +21,46 @@
 #ifndef CONFIG_USER_ONLY
 
 #include "qom/object.h"
+#include "exec/hwaddr.h"
+
+#if defined(CONFIG_IGVM)
+#include "igvm/igvm.h"
+#endif
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
 
+typedef enum ConfidentialGuestPlatformType {
+    CGS_PLATFORM_SEV,
+    CGS_PLATFORM_SEV_ES,
+    CGS_PLATFORM_SEV_SNP,
+    CGS_PLATFORM_TDX,
+} ConfidentialGuestPlatformType;
+
+typedef enum ConfidentialGuestMemoryType {
+    CGS_MEM_RAM,
+    CGS_MEM_RESERVED,
+    CGS_MEM_ACPI,
+    CGS_MEM_NVS,
+    CGS_MEM_UNUSABLE,
+} ConfidentialGuestMemoryType;
+
+typedef struct ConfidentialGuestMemoryMapEntry {
+    uint64_t gpa;
+    uint64_t size;
+    ConfidentialGuestMemoryType type;
+} ConfidentialGuestMemoryMapEntry;
+
+typedef enum ConfidentialGuestPageType {
+    CGS_PAGE_TYPE_NORMAL,
+    CGS_PAGE_TYPE_VMSA,
+    CGS_PAGE_TYPE_ZERO,
+    CGS_PAGE_TYPE_UNMEASURED,
+    CGS_PAGE_TYPE_SECRETS,
+    CGS_PAGE_TYPE_CPUID,
+    CGS_PAGE_TYPE_REQUIRED_MEMORY,
+} ConfidentialGuestPageType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -60,6 +96,46 @@ struct ConfidentialGuestSupport {
      */
     char *igvm_filename;
 #endif
+
+    /*
+     * The following virtual methods need to be implemented by systems that
+     * support confidential guests that can be configured with IGVM and are
+     * used during processing of the IGVM file with process_igvm().
+     */
+
+    /*
+     * Check for to see if this confidential guest supports a particular
+     * platform or configuration
+     */
+    int (*check_support)(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary);
+
+    /*
+     * Configure part of the state of a guest for a particular set of data, page
+     * type and gpa. This can be used for example to pre-populate and measure
+     * guest memory contents, define private ranges or set the initial CPU state
+     * for one or more CPUs.
+     *
+     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
+     * context for a virtual CPU. The format of the data depends on the type of
+     * confidential virtual machine. For example, for SEV-ES ptr will point to a
+     * vmcb_save_area structure that should be copied into guest memory at the
+     * address specified in gpa. The cpu_index parameter contains the index of
+     * the CPU the VMSA applies to.
+     */
+    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                                 ConfidentialGuestPageType memory_type,
+                                 uint16_t cpu_index);
+
+    /*
+     * Iterate the system memory map, getting the entry with the given index
+     * that can be populated into guest memory.
+     *
+     * Returns 1 if the index is out of range.
+     */
+    int (*get_mem_map_entry)(int index,
+                              ConfidentialGuestMemoryMapEntry *entry);
 };
 
 typedef struct ConfidentialGuestSupportClass {
-- 
2.43.0


