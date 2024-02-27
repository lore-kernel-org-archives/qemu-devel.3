Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CFEC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynU-0006lA-NV; Tue, 27 Feb 2024 09:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynP-0006SW-VS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynM-0004Ue-Gq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:03 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15F481FB97;
 Tue, 27 Feb 2024 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLrOIpePSpYhcAQDgfywODmAk4PxHOgHDM8Vlmi0yl0=;
 b=ElZEgkC+l0Yj+69HtOckx3uIvVImIdj8t3qDGwgBRmz1CQzlHUtvjot7BQ/lxBkpXqxT1q
 dEKvBFnN5jKw87Q6kuwxu0KMMkEnPtSRZbNbGwylSgXolGcEsHjcR1E7xm6djhGUWJN2hg
 mst2sJxy0WYlfoIM6wAsQIlTCh/mfDo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLrOIpePSpYhcAQDgfywODmAk4PxHOgHDM8Vlmi0yl0=;
 b=ElZEgkC+l0Yj+69HtOckx3uIvVImIdj8t3qDGwgBRmz1CQzlHUtvjot7BQ/lxBkpXqxT1q
 dEKvBFnN5jKw87Q6kuwxu0KMMkEnPtSRZbNbGwylSgXolGcEsHjcR1E7xm6djhGUWJN2hg
 mst2sJxy0WYlfoIM6wAsQIlTCh/mfDo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 48FAB13419;
 Tue, 27 Feb 2024 14:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id WEJbD9L23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:50:58 +0000
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
Subject: [PATCH 4/9] backends/igvm: Implement parsing and processing of IGVM
 files
Date: Tue, 27 Feb 2024 14:50:10 +0000
Message-ID: <57b5139839f0e08c5d7ed35763eb01898506fd3d.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.20 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TAGGED_RCPT(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLy64u1trr5nq3nwidnuusmct1)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWELVE(0.00)[16];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
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

This commit adds an implementation of an IGVM loader which parses the
file specified as a pararameter to ConfidentialGuestSupport and provides
a function that uses the interface in the same object to configure and
populate guest memory based on the contents of the file.

The IGVM file is parsed when a filename is provided but the code to
process the IGVM file is not yet hooked into target systems. This will
follow in a later commit.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 backends/confidential-guest-support.c     |   4 +
 backends/igvm.c                           | 718 ++++++++++++++++++++++
 backends/meson.build                      |   1 +
 include/exec/confidential-guest-support.h |   5 +
 include/exec/igvm.h                       |  35 ++
 5 files changed, 763 insertions(+)
 create mode 100644 backends/igvm.c
 create mode 100644 include/exec/igvm.h

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 42628be8d7..cb7651a8d0 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -15,6 +15,7 @@
 
 #include "exec/confidential-guest-support.h"
 #include "qemu/error-report.h"
+#include "exec/igvm.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
@@ -33,6 +34,9 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
     ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
     g_free(cgs->igvm_filename);
     cgs->igvm_filename = g_strdup(value);
+#if defined(CONFIG_IGVM)
+    igvm_file_init(cgs);
+#endif
 }
 #endif
 
diff --git a/backends/igvm.c b/backends/igvm.c
new file mode 100644
index 0000000000..a6261d796f
--- /dev/null
+++ b/backends/igvm.c
@@ -0,0 +1,718 @@
+/*
+ * QEMU IGVM configuration backend for Confidential Guests
+ *
+ * Copyright (C) 2023-2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@suse.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#if defined(CONFIG_IGVM)
+
+#include "exec/confidential-guest-support.h"
+#include "qemu/queue.h"
+#include "qemu/typedefs.h"
+
+#include "exec/igvm.h"
+#include "qemu/error-report.h"
+#include "hw/boards.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+
+#include <igvm/igvm.h>
+#include <igvm/igvm_defs.h>
+#include <linux/kvm.h>
+
+typedef struct IgvmParameterData {
+    QTAILQ_ENTRY(IgvmParameterData) next;
+    uint8_t *data;
+    uint32_t size;
+    uint32_t index;
+} IgvmParameterData;
+
+static QTAILQ_HEAD(, IgvmParameterData) parameter_data;
+
+static void directive_page_data(ConfidentialGuestSupport *cgs, int i,
+                                uint32_t compatibility_mask);
+static void directive_vp_context(ConfidentialGuestSupport *cgs, int i,
+                                 uint32_t compatibility_mask);
+static void directive_parameter_area(ConfidentialGuestSupport *cgs, int i,
+                                     uint32_t compatibility_mask);
+static void directive_parameter_insert(ConfidentialGuestSupport *cgs, int i,
+                                       uint32_t compatibility_mask);
+static void directive_memory_map(ConfidentialGuestSupport *cgs, int i,
+                                 uint32_t compatibility_mask);
+static void directive_vp_count(ConfidentialGuestSupport *cgs, int i,
+                               uint32_t compatibility_mask);
+static void directive_environment_info(ConfidentialGuestSupport *cgs, int i,
+                                       uint32_t compatibility_mask);
+static void directive_required_memory(ConfidentialGuestSupport *cgs, int i,
+                                      uint32_t compatibility_mask);
+
+struct IGVMDirectiveHandler {
+    uint32_t type;
+    void (*handler)(ConfidentialGuestSupport *cgs, int i,
+                    uint32_t compatibility_mask);
+};
+
+static struct IGVMDirectiveHandler directive_handlers[] = {
+    { IGVM_VHT_PAGE_DATA, directive_page_data },
+    { IGVM_VHT_VP_CONTEXT, directive_vp_context },
+    { IGVM_VHT_PARAMETER_AREA, directive_parameter_area },
+    { IGVM_VHT_PARAMETER_INSERT, directive_parameter_insert },
+    { IGVM_VHT_MEMORY_MAP, directive_memory_map },
+    { IGVM_VHT_VP_COUNT_PARAMETER, directive_vp_count },
+    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, directive_environment_info },
+    { IGVM_VHT_REQUIRED_MEMORY, directive_required_memory },
+};
+
+static void directive(uint32_t type, ConfidentialGuestSupport *cgs, int i,
+                      uint32_t compatibility_mask)
+{
+    size_t handler;
+    for (handler = 0; handler < (sizeof(directive_handlers) /
+                                 sizeof(struct IGVMDirectiveHandler));
+         ++handler) {
+        if (directive_handlers[handler].type == type) {
+            directive_handlers[handler].handler(cgs, i, compatibility_mask);
+            return;
+        }
+    }
+    warn_report("IGVM: Unknown directive encountered when processing file: %X",
+                type);
+}
+
+static void igvm_handle_error(int32_t result, const char *msg)
+{
+    if (result < 0) {
+        error_report("Processing of IGVM file failed: %s (code: %d)", msg,
+                     (int)result);
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void *igvm_prepare_memory(uint64_t addr, uint64_t size,
+                                 int region_identifier)
+{
+    MemoryRegion *igvm_pages = NULL;
+    Int128 gpa_region_size;
+    MemoryRegionSection mrs =
+        memory_region_find(get_system_memory(), addr, size);
+    if (mrs.mr) {
+        if (!memory_region_is_ram(mrs.mr)) {
+            memory_region_unref(mrs.mr);
+            error_report(
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX due to existing non-RAM region",
+                addr);
+            exit(EXIT_FAILURE);
+        }
+
+        gpa_region_size = int128_make64(size);
+        if (int128_lt(mrs.size, gpa_region_size)) {
+            memory_region_unref(mrs.mr);
+            error_report(
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX: region size exceeded",
+                addr);
+            exit(EXIT_FAILURE);
+        }
+        return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+    } else {
+        /*
+         * The region_identifier is the is the index of the IGVM directive that
+         * contains the page with the lowest GPA in the region. This will
+         * generate a unique region name.
+         */
+        char region_name[22];
+        snprintf(region_name, sizeof(region_name), "igvm.%X",
+                 region_identifier);
+        igvm_pages = g_malloc(sizeof(*igvm_pages));
+        memory_region_init_ram(igvm_pages, NULL, region_name, size,
+                               &error_fatal);
+        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
+        return memory_region_get_ram_ptr(igvm_pages);
+    }
+}
+
+static int igvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
+                                 bool zero)
+{
+    switch (memory_type) {
+    case NORMAL: {
+        if (unmeasured) {
+            return CGS_PAGE_TYPE_UNMEASURED;
+        } else {
+            return zero ? CGS_PAGE_TYPE_ZERO :
+                          CGS_PAGE_TYPE_NORMAL;
+        }
+    }
+    case SECRETS:
+        return CGS_PAGE_TYPE_SECRETS;
+    case CPUID_DATA:
+        return CGS_PAGE_TYPE_CPUID;
+    case CPUID_XF:
+        return CGS_PAGE_TYPE_CPUID;
+    default:
+        return CGS_PAGE_TYPE_UNMEASURED;
+    }
+}
+
+static bool page_attrs_equal(const IGVM_VHS_PAGE_DATA *page_1,
+                             const IGVM_VHS_PAGE_DATA *page_2)
+{
+    return ((*(const uint32_t *)&page_1->flags ==
+             *(const uint32_t *)&page_2->flags) &&
+            (page_1->data_type == page_2->data_type) &&
+            (page_1->compatibility_mask == page_2->compatibility_mask));
+}
+
+static void igvm_process_mem_region(ConfidentialGuestSupport *cgs,
+                                    IgvmHandle igvm, int start_index,
+                                    uint64_t gpa_start, int page_count,
+                                    const IgvmPageDataFlags *flags,
+                                    const IgvmPageDataType page_type)
+{
+    uint8_t *region;
+    IgvmHandle data_handle;
+    const void *data;
+    uint32_t data_size;
+    int i;
+    bool zero = true;
+    const uint64_t page_size = flags->is_2mb_page ? 0x200000 : 0x1000;
+    int result;
+
+    region = igvm_prepare_memory(gpa_start, page_count * page_size,
+                                 start_index);
+
+    for (i = 0; i < page_count; ++i) {
+        data_handle = igvm_get_header_data(igvm, HEADER_SECTION_DIRECTIVE,
+                                           i + start_index);
+        if (data_handle == IGVMAPI_NO_DATA) {
+            /* No data indicates a zero page */
+            memset(&region[i * page_size], 0, page_size);
+        } else if (data_handle < 0) {
+            igvm_handle_error(data_handle, "Invalid file");
+        } else {
+            zero = false;
+            data = igvm_get_buffer(igvm, data_handle);
+            data_size = igvm_get_buffer_size(igvm, data_handle);
+            if (data_size < page_size) {
+                memset(&region[i * page_size], 0, page_size);
+            } else if (data_size > page_size) {
+                igvm_handle_error(data_handle, "Invalid page data in file");
+            }
+            memcpy(&region[i * page_size], data, data_size);
+            igvm_free_buffer(igvm, data_handle);
+        }
+    }
+
+    result = cgs->set_guest_state(
+        gpa_start, region, page_size * page_count,
+        igvm_type_to_cgs_type(page_type, flags->unmeasured, zero), 0);
+    if (result != 0) {
+        error_report("IGVM set guest state failed with code %d", result);
+        exit(EXIT_FAILURE);
+    }
+}
+
+static void process_mem_page(ConfidentialGuestSupport *cgs, int i,
+                             const IGVM_VHS_PAGE_DATA *page_data)
+{
+    static IGVM_VHS_PAGE_DATA prev_page_data;
+    static uint64_t region_start;
+    static int last_i;
+    static int page_count;
+
+    if (page_data) {
+        if (page_count == 0) {
+            region_start = page_data->gpa;
+        } else {
+            if (!page_attrs_equal(page_data, &prev_page_data) ||
+                ((prev_page_data.gpa +
+                  (prev_page_data.flags.is_2mb_page ? 0x200000 : 0x1000)) !=
+                 page_data->gpa) ||
+                (last_i != (i - 1))) {
+                /* End of current region */
+                igvm_process_mem_region(cgs, cgs->igvm, i - page_count,
+                                        region_start, page_count,
+                                        &prev_page_data.flags,
+                                        prev_page_data.data_type);
+                page_count = 0;
+                region_start = page_data->gpa;
+            }
+        }
+        memcpy(&prev_page_data, page_data, sizeof(prev_page_data));
+        last_i = i;
+        ++page_count;
+    } else {
+        if (page_count > 0) {
+            igvm_process_mem_region(cgs, cgs->igvm, i - page_count,
+                                    region_start, page_count,
+                                    &prev_page_data.flags,
+                                    prev_page_data.data_type);
+            page_count = 0;
+        }
+    }
+}
+
+static void directive_page_data(ConfidentialGuestSupport *cgs, int i,
+                                uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    const IGVM_VHS_PAGE_DATA *page_data;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    page_data =
+        (IGVM_VHS_PAGE_DATA *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                               sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    if (page_data->compatibility_mask == compatibility_mask) {
+        process_mem_page(cgs, i, page_data);
+    }
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_vp_context(ConfidentialGuestSupport *cgs, int i,
+                                 uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_VP_CONTEXT *vp_context;
+    IgvmHandle data_handle;
+    uint8_t *data;
+    int result;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    vp_context =
+        (IGVM_VHS_VP_CONTEXT *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    if (vp_context->compatibility_mask == compatibility_mask) {
+        data_handle =
+            igvm_get_header_data(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+        igvm_handle_error(data_handle,
+                          "Failed to read directive data from file");
+
+        data = (uint8_t *)igvm_get_buffer(cgs->igvm, data_handle);
+        result = cgs->set_guest_state(vp_context->gpa, data,
+                             igvm_get_buffer_size(cgs->igvm, data_handle),
+                             CGS_PAGE_TYPE_VMSA,
+                             vp_context->vp_index);
+        igvm_free_buffer(cgs->igvm, data_handle);
+        if (result != 0) {
+            error_report(
+                "IGVM: Failed to set CPU context: error_code=%d",
+                result);
+            exit(EXIT_FAILURE);
+        }
+
+    }
+
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_parameter_area(ConfidentialGuestSupport *cgs, int i,
+                                     uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_PARAMETER_AREA *param_area;
+    IgvmParameterData *param_entry;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    param_area =
+        (IGVM_VHS_PARAMETER_AREA *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                    sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    param_entry = g_new0(IgvmParameterData, 1);
+    param_entry->size = param_area->number_of_bytes;
+    param_entry->index = param_area->parameter_area_index;
+    param_entry->data = g_malloc0(param_entry->size);
+
+    QTAILQ_INSERT_TAIL(&parameter_data, param_entry, next);
+
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_parameter_insert(ConfidentialGuestSupport *cgs, int i,
+                                       uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_PARAMETER_INSERT *param;
+    IgvmParameterData *param_entry;
+    int result;
+    void *region;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    param = (IGVM_VHS_PARAMETER_INSERT *)(igvm_get_buffer(cgs->igvm,
+                                                          header_handle) +
+                                          sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    QTAILQ_FOREACH(param_entry, &parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            region = igvm_prepare_memory(param->gpa, param_entry->size, i);
+            if (!region) {
+                error_report(
+                    "IGVM: Failed to allocate guest memory region for parameters");
+                exit(EXIT_FAILURE);
+            }
+            memcpy(region, param_entry->data, param_entry->size);
+            g_free(param_entry->data);
+            param_entry->data = NULL;
+
+            result = cgs->set_guest_state(param->gpa, region,
+                                                param_entry->size,
+                                                CGS_PAGE_TYPE_UNMEASURED, 0);
+            if (result != 0) {
+                error_report(
+                    "IGVM: Failed to set guest state: error_code=%d",
+                    result);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+    }
+}
+
+static int cmp_mm_entry(const void *a, const void *b)
+{
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_a =
+                        (const IGVM_VHS_MEMORY_MAP_ENTRY *)a;
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_b =
+                        (const IGVM_VHS_MEMORY_MAP_ENTRY *)b;
+    if (entry_a->starting_gpa_page_number < entry_b->starting_gpa_page_number) {
+        return -1;
+    } else if (entry_a->starting_gpa_page_number >
+               entry_b->starting_gpa_page_number) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static void directive_memory_map(ConfidentialGuestSupport *cgs, int i,
+                                 uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_PARAMETER *param;
+    IgvmParameterData *param_entry;
+    int max_entry_count;
+    int entry = 0;
+    IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
+    ConfidentialGuestMemoryMapEntry cgmm_entry;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    param = (IGVM_VHS_PARAMETER *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                   sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    /* Find the parameter area that should hold the memory map */
+    QTAILQ_FOREACH(param_entry, &parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            max_entry_count = param_entry->size /
+                              sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+
+            while (cgs->get_mem_map_entry(entry, &cgmm_entry) == 0) {
+                if (entry > max_entry_count) {
+                    error_report(
+                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
+                    exit(EXIT_FAILURE);
+                }
+                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
+                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
+
+                switch (cgmm_entry.type) {
+                case CGS_MEM_RAM:
+                    mm_entry[entry].entry_type = MEMORY;
+                    break;
+                case CGS_MEM_RESERVED:
+                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_ACPI:
+                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_NVS:
+                    mm_entry[entry].entry_type = PERSISTENT;
+                    break;
+                case CGS_MEM_UNUSABLE:
+                    mm_entry[entry].entry_type = PLATFORM_RESERVED;
+                    break;
+                }
+                ++entry;
+            }
+            /* The entries need to be sorted */
+            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
+                  cmp_mm_entry);
+
+            break;
+        }
+    }
+
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_vp_count(ConfidentialGuestSupport *cgs, int i,
+                               uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_PARAMETER *param;
+    IgvmParameterData *param_entry;
+    uint32_t *vp_count;
+    CPUState *cpu;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    param = (IGVM_VHS_PARAMETER *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                   sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    QTAILQ_FOREACH(param_entry, &parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
+            *vp_count = 0;
+            CPU_FOREACH(cpu)
+            {
+                (*vp_count)++;
+            }
+            break;
+        }
+    }
+
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_environment_info(ConfidentialGuestSupport *cgs, int i,
+                                       uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    IGVM_VHS_PARAMETER *param;
+    IgvmParameterData *param_entry;
+    IgvmEnvironmentInfo *environmental_state;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    param = (IGVM_VHS_PARAMETER *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                   sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    QTAILQ_FOREACH(param_entry, &parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            environmental_state =
+                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+            environmental_state->memory_is_shared = 1;
+            break;
+        }
+    }
+
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static void directive_required_memory(ConfidentialGuestSupport *cgs, int i,
+                                      uint32_t compatibility_mask)
+{
+    IgvmHandle header_handle;
+    const IGVM_VHS_REQUIRED_MEMORY *mem;
+    uint8_t *region;
+    int result;
+
+    header_handle = igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+    igvm_handle_error(header_handle,
+                      "Failed to read directive header from file");
+    mem =
+        (IGVM_VHS_REQUIRED_MEMORY *)(igvm_get_buffer(cgs->igvm, header_handle) +
+                                     sizeof(IGVM_VHS_VARIABLE_HEADER));
+
+    if (mem->compatibility_mask == compatibility_mask) {
+        region = igvm_prepare_memory(mem->gpa, mem->number_of_bytes, i);
+        result = cgs->set_guest_state(mem->gpa, region,
+                                            mem->number_of_bytes,
+                                            CGS_PAGE_TYPE_REQUIRED_MEMORY, 0);
+        if (result != 0) {
+            error_report("IGVM: Failed to set guest state: error_code=%d",
+                         result);
+            exit(EXIT_FAILURE);
+        }
+    }
+    igvm_free_buffer(cgs->igvm, header_handle);
+}
+
+static uint32_t supported_platform_compat_mask(ConfidentialGuestSupport *cgs)
+{
+    int32_t result;
+    int i;
+    IgvmHandle header_handle;
+    IGVM_VHS_SUPPORTED_PLATFORM *platform;
+    uint32_t compatibility_mask = 0;
+
+    result = igvm_header_count(cgs->igvm, HEADER_SECTION_PLATFORM);
+    igvm_handle_error(result, "Failed to read platform header count");
+
+    for (i = 0; i < (int)result; ++i) {
+        IgvmVariableHeaderType typ =
+            igvm_get_header_type(cgs->igvm, HEADER_SECTION_PLATFORM, i);
+        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
+            header_handle =
+                igvm_get_header(cgs->igvm, HEADER_SECTION_PLATFORM, i);
+            igvm_handle_error(header_handle,
+                              "Failed to read platform header from file");
+            platform =
+                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(cgs->igvm,
+                                                                header_handle) +
+                                                sizeof(
+                                                    IGVM_VHS_VARIABLE_HEADER));
+            /* Currently only support SEV-SNP. */
+            if (platform->platform_type == SEV_SNP) {
+                /*
+                 * IGVM does not define a platform types of SEV or SEV_ES.
+                 * Translate SEV_SNP into CGS_PLATFORM_SEV_ES and
+                 * CGS_PLATFORM_SEV and let the cgs function implementations
+                 * check whether each IGVM directive results in an operation
+                 * that is supported by the particular derivative of SEV.
+                 */
+                if (cgs->check_support(
+                        CGS_PLATFORM_SEV_SNP, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary) ||
+                    cgs->check_support(
+                        CGS_PLATFORM_SEV_ES, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary) ||
+                    cgs->check_support(
+                        CGS_PLATFORM_SEV, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask = platform->compatibility_mask;
+                    break;
+                }
+            } else if (platform->platform_type == TDX) {
+                if (cgs->check_support(
+                        CGS_PLATFORM_TDX, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask = platform->compatibility_mask;
+                    break;
+                }
+            }
+            igvm_free_buffer(cgs->igvm, header_handle);
+        }
+    }
+    return compatibility_mask;
+}
+
+void igvm_file_init(ConfidentialGuestSupport *cgs)
+{
+    FILE *igvm_file = NULL;
+    uint8_t *igvm_buf = NULL;
+
+    if (cgs->igvm_filename) {
+        IgvmHandle igvm;
+        unsigned long igvm_length;
+
+        igvm_file = fopen(cgs->igvm_filename, "rb");
+        if (!igvm_file) {
+            error_report("IGVM file not found '%s'", cgs->igvm_filename);
+            goto error_out;
+        }
+
+        fseek(igvm_file, 0, SEEK_END);
+        igvm_length = ftell(igvm_file);
+        fseek(igvm_file, 0, SEEK_SET);
+
+        igvm_buf = g_new(uint8_t, igvm_length);
+        if (!igvm_buf) {
+            error_report(
+                "Could not allocate buffer to read file IGVM file '%s'",
+                cgs->igvm_filename);
+            goto error_out;
+        }
+        if (fread(igvm_buf, 1, igvm_length, igvm_file) != igvm_length) {
+            error_report("Unable to load IGVM file '%s'", cgs->igvm_filename);
+            goto error_out;
+        }
+
+        igvm = igvm_new_from_binary(igvm_buf, igvm_length);
+        if (igvm < 0) {
+            error_report("Parsing IGVM file '%s' failed with  error_code %d",
+                         cgs->igvm_filename, igvm);
+            goto error_out;
+        }
+        fclose(igvm_file);
+        g_free(igvm_buf);
+
+        cgs->igvm = igvm;
+    }
+    return;
+
+error_out:
+    free(igvm_buf);
+    if (igvm_file) {
+        fclose(igvm_file);
+    }
+    exit(EXIT_FAILURE);
+}
+
+void igvm_process(ConfidentialGuestSupport *cgs)
+{
+    int32_t result;
+    int i;
+    uint32_t compatibility_mask;
+    IgvmParameterData *parameter;
+
+    /*
+     * If this is not a Confidential guest or no IGVM has been provided then
+     * this is a no-op.
+     */
+    if (!cgs || !cgs->igvm) {
+        return;
+    }
+
+    QTAILQ_INIT(&parameter_data);
+
+    /*
+     * Check that the IGVM file provides configuration for the current
+     * platform
+     */
+    compatibility_mask = supported_platform_compat_mask(cgs);
+    if (compatibility_mask == 0) {
+        error_report(
+            "IGVM file does not describe a compatible supported platform");
+        exit(EXIT_FAILURE);
+    }
+
+    result = igvm_header_count(cgs->igvm, HEADER_SECTION_DIRECTIVE);
+    igvm_handle_error(result, "Failed to read directive header count");
+    for (i = 0; i < (int)result; ++i) {
+        IgvmVariableHeaderType type =
+            igvm_get_header_type(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
+        directive(type, cgs, i, compatibility_mask);
+    }
+
+    /*
+     * Contiguous pages of data with compatible flags are grouped together in
+     * order to reduce the number of memory regions we create. Make sure the
+     * last group is processed with this call.
+     */
+    process_mem_page(cgs, i, NULL);
+
+    QTAILQ_FOREACH(parameter, &parameter_data, next)
+    {
+        g_free(parameter->data);
+        parameter->data = NULL;
+    }
+}
+
+#endif
diff --git a/backends/meson.build b/backends/meson.build
index d550ac19f7..d092850a07 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -32,6 +32,7 @@ system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 if igvm.found()
   system_ss.add(igvm)
+  system_ss.add(files('igvm.c'))
 endif
 
 subdir('tpm')
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index c43a1a32f1..1a017a8fda 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -27,6 +27,10 @@
 #include "igvm/igvm.h"
 #endif
 
+#if defined(CONFIG_IGVM)
+#include "igvm/igvm.h"
+#endif
+
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
 
@@ -95,6 +99,7 @@ struct ConfidentialGuestSupport {
      *                Virtual Machine (IGVM) format.
      */
     char *igvm_filename;
+    IgvmHandle igvm;
 #endif
 
     /*
diff --git a/include/exec/igvm.h b/include/exec/igvm.h
new file mode 100644
index 0000000000..6f40a3239c
--- /dev/null
+++ b/include/exec/igvm.h
@@ -0,0 +1,35 @@
+/*
+ * QEMU IGVM configuration backend for Confidential Guests
+ *
+ * Copyright (C) 2023-2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@suse.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef EXEC_IGVM_H
+#define EXEC_IGVM_H
+
+#include "exec/confidential-guest-support.h"
+
+#if defined(CONFIG_IGVM)
+
+void igvm_file_init(ConfidentialGuestSupport *cgs);
+void igvm_process(ConfidentialGuestSupport *cgs);
+
+#else
+
+static inline void igvm_file_init(ConfidentialGuestSupport *cgs)
+{
+}
+
+static inline void igvm_process(ConfidentialGuestSupport *cgs)
+{
+}
+
+#endif
+
+#endif
-- 
2.43.0


