Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD5FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmtZ-0001NJ-F8; Thu, 26 Sep 2024 07:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt9-0000pw-6I
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:28 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt4-0005l9-VP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 273E21F853;
 Thu, 26 Sep 2024 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qu3NMv7mRx+JAg73lkrv+ZrjdBbyQMXtjIMs80Ls/qQ=;
 b=aTEaacq4rFSn4WZYXbzP+LpKz0/c3kaKoR5N14yRrqQhi5Zm+Zdw4JrUqaf0AVeENYr7+A
 blmD6cXSmElyd9XRq25+x7t+LMEczO8THfJOaBYXm2aKQsKEhUBPYT+i2cQB8Cu/egJpyx
 2Z6WnkxedfDMT501Un32TZ9dMFipnno=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qu3NMv7mRx+JAg73lkrv+ZrjdBbyQMXtjIMs80Ls/qQ=;
 b=aTEaacq4rFSn4WZYXbzP+LpKz0/c3kaKoR5N14yRrqQhi5Zm+Zdw4JrUqaf0AVeENYr7+A
 blmD6cXSmElyd9XRq25+x7t+LMEczO8THfJOaBYXm2aKQsKEhUBPYT+i2cQB8Cu/egJpyx
 2Z6WnkxedfDMT501Un32TZ9dMFipnno=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68C8D13ABC;
 Thu, 26 Sep 2024 11:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gISOF5xI9WbcRAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Thu, 26 Sep 2024 11:42:20 +0000
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
Subject: [PATCH v6 03/16] backends/igvm: Add IGVM loader and configuration
Date: Thu, 26 Sep 2024 12:41:52 +0100
Message-ID: <e535218a7084bfff97cddcfe9d2ec26e8bf103b3.1727341768.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727341768.git.roy.hopkins@suse.com>
References: <cover.1727341768.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds an IGVM loader to QEMU which processes a given IGVM file and
applies the directives within the file to the current guest
configuration.

The IGVM loader can be used to configure both confidential and
non-confidential guests. For confidential guests, the
ConfidentialGuestSupport object for the system is used to encrypt
memory, apply the initial CPU state and perform other confidential guest
operations.

The loader is configured via a new IgvmCfg QOM object which allows the
user to provide a path to the IGVM file to process.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm-cfg.c       |  52 +++
 backends/igvm.c           | 808 ++++++++++++++++++++++++++++++++++++++
 backends/igvm.h           |  23 ++
 backends/meson.build      |   2 +
 include/sysemu/igvm-cfg.h |  47 +++
 qapi/qom.json             |  17 +
 6 files changed, 949 insertions(+)
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 backends/igvm.h
 create mode 100644 include/sysemu/igvm-cfg.h

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
new file mode 100644
index 0000000000..63f8856c7b
--- /dev/null
+++ b/backends/igvm-cfg.c
@@ -0,0 +1,52 @@
+/*
+ * QEMU IGVM interface
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
+#include "sysemu/igvm-cfg.h"
+#include "igvm.h"
+#include "qom/object_interfaces.h"
+
+static char *get_igvm(Object *obj, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return g_strdup(igvm->filename);
+}
+
+static void set_igvm(Object *obj, const char *value, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    g_free(igvm->filename);
+    igvm->filename = g_strdup(value);
+}
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
+                                   { TYPE_USER_CREATABLE }, { NULL })
+
+static void igvm_cfg_class_init(ObjectClass *oc, void *data)
+{
+    IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
+
+    object_class_property_add_str(oc, "file", get_igvm, set_igvm);
+    object_class_property_set_description(oc, "file",
+                                          "Set the IGVM filename to use");
+
+    igvmc->process = qigvm_process_file;
+}
+
+static void igvm_cfg_init(Object *obj)
+{
+}
+
+static void igvm_cfg_finalize(Object *obj)
+{
+}
diff --git a/backends/igvm.c b/backends/igvm.c
new file mode 100644
index 0000000000..4dfc9b0c67
--- /dev/null
+++ b/backends/igvm.c
@@ -0,0 +1,808 @@
+/*
+ * QEMU IGVM configuration backend for guests
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
+#include "igvm.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "hw/core/cpu.h"
+
+#include <igvm/igvm.h>
+#include <igvm/igvm_defs.h>
+
+typedef struct QIgvmParameterData {
+    QTAILQ_ENTRY(QIgvmParameterData) next;
+    uint8_t *data;
+    uint32_t size;
+    uint32_t index;
+} QIgvmParameterData;
+
+/*
+ * QIgvm contains the information required during processing
+ * of a single IGVM file.
+ */
+typedef struct QIgvm {
+    IgvmHandle file;
+    ConfidentialGuestSupport *cgs;
+    ConfidentialGuestSupportClass *cgsc;
+    uint32_t compatibility_mask;
+    unsigned current_header_index;
+    QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+
+    /* These variables keep track of contiguous page regions */
+    IGVM_VHS_PAGE_DATA region_prev_page_data;
+    uint64_t region_start;
+    unsigned region_start_index;
+    unsigned region_last_index;
+    unsigned region_page_count;
+} QIgvm;
+
+static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
+                                     Error **errp);
+static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp);
+static int qigvm_directive_parameter_area(QIgvm *ctx,
+                                          const uint8_t *header_data,
+                                          Error **errp);
+static int qigvm_directive_parameter_insert(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp);
+static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp);
+static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
+                                    Error **errp);
+static int qigvm_directive_environment_info(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp);
+static int qigvm_directive_required_memory(QIgvm *ctx,
+                                           const uint8_t *header_data,
+                                           Error **errp);
+
+struct QIGVMHandler {
+    uint32_t type;
+    uint32_t section;
+    int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+};
+
+static struct QIGVMHandler handlers[] = {
+    { IGVM_VHT_PAGE_DATA, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_page_data },
+    { IGVM_VHT_VP_CONTEXT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_vp_context },
+    { IGVM_VHT_PARAMETER_AREA, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_parameter_area },
+    { IGVM_VHT_PARAMETER_INSERT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_parameter_insert },
+    { IGVM_VHT_MEMORY_MAP, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_memory_map },
+    { IGVM_VHT_VP_COUNT_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_vp_count },
+    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_environment_info },
+    { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_required_memory },
+};
+
+static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
+{
+    size_t handler;
+    IgvmHandle header_handle;
+    const uint8_t *header_data;
+    int result;
+
+    for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
+        if (handlers[handler].type != type) {
+            continue;
+        }
+        header_handle = igvm_get_header(ctx->file, handlers[handler].section,
+                                        ctx->current_header_index);
+        if (header_handle < 0) {
+            error_setg(
+                errp,
+                "IGVM file is invalid: Failed to read directive header (code: %d)",
+                (int)header_handle);
+            return -1;
+        }
+        header_data = igvm_get_buffer(ctx->file, header_handle) +
+                      sizeof(IGVM_VHS_VARIABLE_HEADER);
+        result = handlers[handler].handler(ctx, header_data, errp);
+        igvm_free_buffer(ctx->file, header_handle);
+        return result;
+    }
+    error_setg(errp,
+               "IGVM: Unknown header type encountered when processing file: "
+               "(type 0x%X)",
+               type);
+    return -1;
+}
+
+static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
+                                  int region_identifier, Error **errp)
+{
+    ERRP_GUARD();
+    MemoryRegion *igvm_pages = NULL;
+    Int128 gpa_region_size;
+    MemoryRegionSection mrs =
+        memory_region_find(get_system_memory(), addr, size);
+    if (mrs.mr) {
+        if (!memory_region_is_ram(mrs.mr)) {
+            memory_region_unref(mrs.mr);
+            error_setg(
+                errp,
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX due to existing non-RAM region",
+                addr);
+            return NULL;
+        }
+
+        gpa_region_size = int128_make64(size);
+        if (int128_lt(mrs.size, gpa_region_size)) {
+            memory_region_unref(mrs.mr);
+            error_setg(
+                errp,
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX: region size exceeded",
+                addr);
+            return NULL;
+        }
+        return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+    } else {
+        /*
+         * The region_identifier is the is the index of the IGVM directive that
+         * contains the page with the lowest GPA in the region. This will
+         * generate a unique region name.
+         */
+        g_autofree char *region_name =
+            g_strdup_printf("igvm.%X", region_identifier);
+        igvm_pages = g_new0(MemoryRegion, 1);
+        if (ctx->cgs && ctx->cgs->require_guest_memfd) {
+            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+                                                    region_name, size, errp)) {
+                return NULL;
+            }
+        } else {
+            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+                                        errp)) {
+                return NULL;
+            }
+        }
+        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
+        return memory_region_get_ram_ptr(igvm_pages);
+    }
+}
+
+static int qigvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
+                                  bool zero)
+{
+    switch (memory_type) {
+    case IGVM_PAGE_DATA_TYPE_NORMAL: {
+        if (unmeasured) {
+            return CGS_PAGE_TYPE_UNMEASURED;
+        } else {
+            return zero ? CGS_PAGE_TYPE_ZERO : CGS_PAGE_TYPE_NORMAL;
+        }
+    }
+    case IGVM_PAGE_DATA_TYPE_SECRETS:
+        return CGS_PAGE_TYPE_SECRETS;
+    case IGVM_PAGE_DATA_TYPE_CPUID_DATA:
+        return CGS_PAGE_TYPE_CPUID;
+    case IGVM_PAGE_DATA_TYPE_CPUID_XF:
+        return CGS_PAGE_TYPE_CPUID;
+    default:
+        return -1;
+    }
+}
+
+static bool qigvm_page_attrs_equal(IgvmHandle igvm, unsigned header_index,
+                                   const IGVM_VHS_PAGE_DATA *page_1,
+                                   const IGVM_VHS_PAGE_DATA *page_2)
+{
+    IgvmHandle data_handle1, data_handle2;
+
+    /*
+     * If one page has data and the other doesn't then this results in different
+     * page types: NORMAL vs ZERO.
+     */
+    data_handle1 = igvm_get_header_data(igvm, IGVM_HEADER_SECTION_DIRECTIVE,
+                                        header_index - 1);
+    data_handle2 =
+        igvm_get_header_data(igvm, IGVM_HEADER_SECTION_DIRECTIVE, header_index);
+    if ((data_handle1 == IGVMAPI_NO_DATA ||
+         data_handle2 == IGVMAPI_NO_DATA) &&
+         data_handle1 != data_handle2) {
+        return false;
+    }
+    return ((*(const uint32_t *)&page_1->flags ==
+             *(const uint32_t *)&page_2->flags) &&
+            (page_1->data_type == page_2->data_type) &&
+            (page_1->compatibility_mask == page_2->compatibility_mask));
+}
+
+static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
+                                    uint64_t gpa_start, unsigned page_count,
+                                    const IgvmPageDataFlags *flags,
+                                    const IgvmPageDataType page_type,
+                                    Error **errp)
+{
+    uint8_t *region;
+    IgvmHandle data_handle;
+    const void *data;
+    uint32_t data_size;
+    unsigned page_index;
+    bool zero = true;
+    const uint64_t page_size = flags->is_2mb_page ? 0x200000 : 0x1000;
+    int result;
+    int cgs_page_type;
+
+    region = qigvm_prepare_memory(ctx, gpa_start, page_count * page_size,
+                                  start_index, errp);
+    if (!region) {
+        return -1;
+    }
+
+    for (page_index = 0; page_index < page_count; page_index++) {
+        data_handle = igvm_get_header_data(
+            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + start_index);
+        if (data_handle == IGVMAPI_NO_DATA) {
+            /* No data indicates a zero page */
+            memset(&region[page_index * page_size], 0, page_size);
+        } else if (data_handle < 0) {
+            error_setg(
+                errp,
+                "IGVM file contains invalid page data for directive with "
+                "index %d",
+                page_index + start_index);
+            return -1;
+        } else {
+            zero = false;
+            data_size = igvm_get_buffer_size(ctx->file, data_handle);
+            if (data_size < page_size) {
+                memset(&region[page_index * page_size], 0, page_size);
+            } else if (data_size > page_size) {
+                error_setg(errp,
+                           "IGVM file contains page data with invalid size for "
+                           "directive with index %d",
+                           page_index + start_index);
+                return -1;
+            }
+            data = igvm_get_buffer(ctx->file, data_handle);
+            memcpy(&region[page_index * page_size], data, data_size);
+            igvm_free_buffer(ctx->file, data_handle);
+        }
+    }
+
+    /*
+     * If a confidential guest support object is provided then use it to set the
+     * guest state.
+     */
+    if (ctx->cgs) {
+        cgs_page_type =
+            qigvm_type_to_cgs_type(page_type, flags->unmeasured, zero);
+        if (cgs_page_type < 0) {
+            error_setg(errp,
+                       "Invalid page type in IGVM file. Directives: %d to %d, "
+                       "page type: %d",
+                       start_index, start_index + page_count, page_type);
+            return -1;
+        }
+
+        result = ctx->cgsc->set_guest_state(
+            gpa_start, region, page_size * page_count, cgs_page_type, 0, errp);
+        if (result < 0) {
+            return result;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_process_mem_page(QIgvm *ctx,
+                                  const IGVM_VHS_PAGE_DATA *page_data,
+                                  Error **errp)
+{
+    if (page_data) {
+        if (ctx->region_page_count == 0) {
+            ctx->region_start = page_data->gpa;
+            ctx->region_start_index = ctx->current_header_index;
+        } else {
+            if (!qigvm_page_attrs_equal(ctx->file, ctx->current_header_index,
+                                        page_data,
+                                        &ctx->region_prev_page_data) ||
+                ((ctx->region_prev_page_data.gpa +
+                  (ctx->region_prev_page_data.flags.is_2mb_page ? 0x200000 :
+                                                                  0x1000)) !=
+                 page_data->gpa) ||
+                (ctx->region_last_index != (ctx->current_header_index - 1))) {
+                /* End of current region */
+                if (qigvm_process_mem_region(
+                        ctx, ctx->region_start_index, ctx->region_start,
+                        ctx->region_page_count,
+                        &ctx->region_prev_page_data.flags,
+                        ctx->region_prev_page_data.data_type, errp) < 0) {
+                    return -1;
+                }
+                ctx->region_page_count = 0;
+                ctx->region_start = page_data->gpa;
+                ctx->region_start_index = ctx->current_header_index;
+            }
+        }
+        memcpy(&ctx->region_prev_page_data, page_data,
+               sizeof(ctx->region_prev_page_data));
+        ctx->region_last_index = ctx->current_header_index;
+        ctx->region_page_count++;
+    } else {
+        if (ctx->region_page_count > 0) {
+            if (qigvm_process_mem_region(
+                    ctx, ctx->region_start_index, ctx->region_start,
+                    ctx->region_page_count, &ctx->region_prev_page_data.flags,
+                    ctx->region_prev_page_data.data_type, errp) < 0) {
+                return -1;
+            }
+            ctx->region_page_count = 0;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
+                                     Error **errp)
+{
+    const IGVM_VHS_PAGE_DATA *page_data =
+        (const IGVM_VHS_PAGE_DATA *)header_data;
+    if (page_data->compatibility_mask & ctx->compatibility_mask) {
+        return qigvm_process_mem_page(ctx, page_data, errp);
+    }
+    return 0;
+}
+
+static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp)
+{
+    const IGVM_VHS_VP_CONTEXT *vp_context =
+        (const IGVM_VHS_VP_CONTEXT *)header_data;
+    IgvmHandle data_handle;
+    uint8_t *data;
+    int result;
+
+    if (!(vp_context->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    /*
+     * A confidential guest support object must be provided for setting
+     * a VP context.
+     */
+    if (!ctx->cgs) {
+        error_setg(
+            errp,
+            "A VP context is present in the IGVM file but is not supported "
+            "by the current system.");
+        return -1;
+    }
+
+    data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
+                                       ctx->current_header_index);
+    if (data_handle < 0) {
+        error_setg(errp, "Invalid VP context in IGVM file. Error code: %X",
+                   data_handle);
+        return -1;
+    }
+
+    data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    result = ctx->cgsc->set_guest_state(
+        vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
+        CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
+    igvm_free_buffer(ctx->file, data_handle);
+    if (result < 0) {
+        return result;
+    }
+    return 0;
+}
+
+static int qigvm_directive_parameter_area(QIgvm *ctx,
+                                          const uint8_t *header_data,
+                                          Error **errp)
+{
+    const IGVM_VHS_PARAMETER_AREA *param_area =
+        (const IGVM_VHS_PARAMETER_AREA *)header_data;
+    QIgvmParameterData *param_entry;
+
+    param_entry = g_new0(QIgvmParameterData, 1);
+    param_entry->size = param_area->number_of_bytes;
+    param_entry->index = param_area->parameter_area_index;
+    param_entry->data = g_malloc0(param_entry->size);
+
+    QTAILQ_INSERT_TAIL(&ctx->parameter_data, param_entry, next);
+    return 0;
+}
+
+static int qigvm_directive_parameter_insert(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp)
+{
+    const IGVM_VHS_PARAMETER_INSERT *param =
+        (const IGVM_VHS_PARAMETER_INSERT *)header_data;
+    QIgvmParameterData *param_entry;
+    int result;
+    void *region;
+
+    if (!(param->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
+                                          ctx->current_header_index, errp);
+            if (!region) {
+                return -1;
+            }
+            memcpy(region, param_entry->data, param_entry->size);
+            g_free(param_entry->data);
+            param_entry->data = NULL;
+
+            /*
+             * If a confidential guest support object is provided then use it to
+             * set the guest state.
+             */
+            if (ctx->cgs) {
+                result = ctx->cgsc->set_guest_state(param->gpa, region,
+                                                    param_entry->size,
+                                                    CGS_PAGE_TYPE_UNMEASURED, 0,
+                                                    errp);
+                if (result < 0) {
+                    return -1;
+                }
+            }
+        }
+    }
+    return 0;
+}
+
+static int qigvm_cmp_mm_entry(const void *a, const void *b)
+{
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_a =
+        (const IGVM_VHS_MEMORY_MAP_ENTRY *)a;
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_b =
+        (const IGVM_VHS_MEMORY_MAP_ENTRY *)b;
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
+static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    int max_entry_count;
+    int entry = 0;
+    IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
+    ConfidentialGuestMemoryMapEntry cgmm_entry;
+    int retval = 0;
+
+    if (!ctx->cgs) {
+        error_setg(errp,
+                   "IGVM file contains a memory map but this is not supported "
+                   "by the current system.");
+        return -1;
+    }
+
+    /* Find the parameter area that should hold the memory map */
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            max_entry_count =
+                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+
+            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
+            while (retval == 0) {
+                if (entry > max_entry_count) {
+                    error_setg(
+                        errp,
+                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
+                    return -1;
+                }
+                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
+                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
+
+                switch (cgmm_entry.type) {
+                case CGS_MEM_RAM:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
+                    break;
+                case CGS_MEM_RESERVED:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_ACPI:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_NVS:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
+                    break;
+                case CGS_MEM_UNUSABLE:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                }
+                retval =
+                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
+            }
+            if (retval < 0) {
+                return retval;
+            }
+            /* The entries need to be sorted */
+            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
+                  qigvm_cmp_mm_entry);
+
+            break;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
+                                    Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    uint32_t *vp_count;
+    CPUState *cpu;
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
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
+    return 0;
+}
+
+static int qigvm_directive_environment_info(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    IgvmEnvironmentInfo *environmental_state;
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            environmental_state =
+                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+            environmental_state->memory_is_shared = 1;
+            break;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_required_memory(QIgvm *ctx,
+                                           const uint8_t *header_data,
+                                           Error **errp)
+{
+    const IGVM_VHS_REQUIRED_MEMORY *mem =
+        (const IGVM_VHS_REQUIRED_MEMORY *)header_data;
+    uint8_t *region;
+    int result;
+
+    if (!(mem->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    region = qigvm_prepare_memory(ctx, mem->gpa, mem->number_of_bytes,
+                                  ctx->current_header_index, errp);
+    if (!region) {
+        return -1;
+    }
+    if (ctx->cgs) {
+        result =
+            ctx->cgsc->set_guest_state(mem->gpa, region, mem->number_of_bytes,
+                                       CGS_PAGE_TYPE_REQUIRED_MEMORY, 0, errp);
+        if (result < 0) {
+            return result;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
+{
+    int32_t header_count;
+    unsigned header_index;
+    IgvmHandle header_handle;
+    IGVM_VHS_SUPPORTED_PLATFORM *platform;
+    uint32_t compatibility_mask_sev = 0;
+    uint32_t compatibility_mask_sev_es = 0;
+    uint32_t compatibility_mask_sev_snp = 0;
+    uint32_t compatibility_mask = 0;
+
+    header_count = igvm_header_count(ctx->file, IGVM_HEADER_SECTION_PLATFORM);
+    if (header_count < 0) {
+        error_setg(errp,
+                   "Invalid platform header count in IGVM file. Error code: %X",
+                   header_count);
+        return -1;
+    }
+
+    for (header_index = 0; header_index < (unsigned)header_count;
+         header_index++) {
+        IgvmVariableHeaderType typ = igvm_get_header_type(
+            ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
+            header_handle = igvm_get_header(
+                ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+            if (header_handle < 0) {
+                error_setg(errp,
+                           "Invalid platform header in IGVM file. "
+                           "Index: %d, Error code: %X",
+                           header_index, header_handle);
+                return -1;
+            }
+            platform =
+                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
+                                                                header_handle) +
+                                                sizeof(
+                                                    IGVM_VHS_VARIABLE_HEADER));
+            if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
+                ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV_ES, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev_es = platform->compatibility_mask;
+                }
+            } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
+                       ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev = platform->compatibility_mask;
+                }
+            } else if ((platform->platform_type ==
+                        IGVM_PLATFORM_TYPE_SEV_SNP) &&
+                       ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV_SNP, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev_snp = platform->compatibility_mask;
+                }
+            } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
+                compatibility_mask = platform->compatibility_mask;
+            }
+            igvm_free_buffer(ctx->file, header_handle);
+        }
+    }
+    /* Choose the strongest supported isolation technology */
+    if (compatibility_mask_sev_snp != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev_snp;
+    } else if (compatibility_mask_sev_es != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev_es;
+    } else if (compatibility_mask_sev != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev;
+    } else if (compatibility_mask != 0) {
+        ctx->compatibility_mask = compatibility_mask;
+    } else {
+        error_setg(
+            errp,
+            "IGVM file does not describe a compatible supported platform");
+        return -1;
+    }
+    return 0;
+}
+
+static IgvmHandle qigvm_file_init(char *filename, Error **errp)
+{
+    IgvmHandle igvm;
+    g_autofree uint8_t *buf = NULL;
+    unsigned long len;
+    g_autoptr(GError) gerr = NULL;
+
+    if (!g_file_get_contents(filename, (gchar **)&buf, &len, &gerr)) {
+        error_setg(errp, "Unable to load %s: %s", filename, gerr->message);
+        return -1;
+    }
+
+    igvm = igvm_new_from_binary(buf, len);
+    if (igvm < 0) {
+        error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
+        return -1;
+    }
+    return igvm;
+}
+
+int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+                       Error **errp)
+{
+    int32_t header_count;
+    QIgvmParameterData *parameter;
+    int retval = -1;
+    QIgvm ctx;
+
+    memset(&ctx, 0, sizeof(ctx));
+    ctx.file = qigvm_file_init(cfg->filename, errp);
+    if (ctx.file < 0) {
+        return -1;
+    }
+
+    /*
+     * The ConfidentialGuestSupport object is optional and allows a confidential
+     * guest platform to perform extra processing, such as page measurement, on
+     * IGVM directives.
+     */
+    ctx.cgs = cgs;
+    ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
+
+    /*
+     * Check that the IGVM file provides configuration for the current
+     * platform
+     */
+    if (qigvm_supported_platform_compat_mask(&ctx, errp) < 0) {
+        goto cleanup;
+    }
+
+    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
+    if (header_count <= 0) {
+        error_setg(
+            errp, "Invalid directive header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup;
+    }
+
+    QTAILQ_INIT(&ctx.parameter_data);
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type = igvm_get_header_type(
+            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup_parameters;
+        }
+    }
+
+    /*
+     * Contiguous pages of data with compatible flags are grouped together in
+     * order to reduce the number of memory regions we create. Make sure the
+     * last group is processed with this call.
+     */
+    retval = qigvm_process_mem_page(&ctx, NULL, errp);
+
+cleanup_parameters:
+    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
+    {
+        g_free(parameter->data);
+        parameter->data = NULL;
+    }
+
+cleanup:
+    igvm_free(ctx.file);
+
+    return retval;
+}
diff --git a/backends/igvm.h b/backends/igvm.h
new file mode 100644
index 0000000000..436408c539
--- /dev/null
+++ b/backends/igvm.h
@@ -0,0 +1,23 @@
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
+#ifndef BACKENDS_IGVM_H
+#define BACKENDS_IGVM_H
+
+#include "exec/confidential-guest-support.h"
+#include "sysemu/igvm-cfg.h"
+#include "qapi/error.h"
+
+int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
+                      Error **errp);
+
+#endif
diff --git a/backends/meson.build b/backends/meson.build
index b092a19efc..3b07471993 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -34,6 +34,8 @@ system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 if igvm.found()
   system_ss.add(igvm)
+  system_ss.add(files('igvm-cfg.c'), igvm)
+  system_ss.add(files('igvm.c'), igvm)
 endif
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
diff --git a/include/sysemu/igvm-cfg.h b/include/sysemu/igvm-cfg.h
new file mode 100644
index 0000000000..21fadfe5b7
--- /dev/null
+++ b/include/sysemu/igvm-cfg.h
@@ -0,0 +1,47 @@
+/*
+ * QEMU IGVM interface
+ *
+ * Copyright (C) 2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@suse.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_IGVM_CFG_H
+#define QEMU_IGVM_CFG_H
+
+#include "qom/object.h"
+
+typedef struct IgvmCfg {
+    ObjectClass parent_class;
+
+    /*
+     * filename: Filename that specifies a file that contains the configuration
+     *           of the guest in Independent Guest Virtual Machine (IGVM)
+     *           format.
+     */
+    char *filename;
+} IgvmCfg;
+
+typedef struct IgvmCfgClass {
+    ObjectClass parent_class;
+
+    /*
+     * If an IGVM filename has been specified then process the IGVM file.
+     * Performs a no-op if no filename has been specified.
+     *
+     * Returns 0 for ok and -1 on error.
+     */
+    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+                   Error **errp);
+
+} IgvmCfgClass;
+
+#define TYPE_IGVM_CFG "igvm-cfg"
+
+OBJECT_DECLARE_TYPE(IgvmCfg, IgvmCfgClass, IGVM_CFG)
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index 321ccd708a..223ac804d3 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -893,6 +893,19 @@
   'data': { '*filename': 'str' },
   'if': 'CONFIG_POSIX' }
 
+##
+# @IgvmCfgProperties:
+#
+# Properties common to objects that handle IGVM files.
+#
+# @file: IGVM file to use to configure guest
+#
+# Since: 9.2
+##
+{ 'struct': 'IgvmCfgProperties',
+  'if': 'CONFIG_IGVM',
+  'data': { 'file': 'str' } }
+
 ##
 # @SevCommonProperties:
 #
@@ -1063,6 +1076,8 @@
     'filter-redirector',
     'filter-replay',
     'filter-rewriter',
+    { 'name': 'igvm-cfg',
+      'if': 'CONFIG_IGVM' },
     'input-barrier',
     { 'name': 'input-linux',
       'if': 'CONFIG_LINUX' },
@@ -1137,6 +1152,8 @@
       'filter-redirector':          'FilterRedirectorProperties',
       'filter-replay':              'NetfilterProperties',
       'filter-rewriter':            'FilterRewriterProperties',
+      'igvm-cfg':                   { 'type': 'IgvmCfgProperties',
+                                      'if': 'CONFIG_IGVM' },
       'input-barrier':              'InputBarrierProperties',
       'input-linux':                { 'type': 'InputLinuxProperties',
                                       'if': 'CONFIG_LINUX' },
-- 
2.43.0


