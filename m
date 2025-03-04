Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7EBC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRhf-0004rv-VQ; Tue, 04 Mar 2025 07:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhT-0004i6-74
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhQ-0006kE-5o
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWDljEzQh9kvu112X/0Kh5HIwOGin4sEZeIN27KQ9sg=;
 b=IOvl9OY5pP0b+mu6q78YvhHiZJNYCule/1U9Ct1sPe2BB/DHBuWXHTW3LhDk97V0SfI8NU
 /RmgPWP+KQLj0EVKqNItaHez+noRMAdSLtUgnuApe7QTC3SCz2jYUyCMWvlm7paQGeIfqM
 0nZUXAGua0ghqU37F3iJTP6OA4rzxM4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-N11TO3MgMAO7nsnphXuBGQ-1; Tue,
 04 Mar 2025 07:48:31 -0500
X-MC-Unique: N11TO3MgMAO7nsnphXuBGQ-1
X-Mimecast-MFC-AGG-ID: N11TO3MgMAO7nsnphXuBGQ_1741092509
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 941AE1944D29; Tue,  4 Mar 2025 12:48:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0759A180087C; Tue,  4 Mar 2025 12:48:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9DD1E18003A3; Tue, 04 Mar 2025 13:48:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/24] hw/uefi: add var-service-vars.c
Date: Tue,  4 Mar 2025 13:47:55 +0100
Message-ID: <20250304124815.591749-8-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

This is the uefi variable service (EfiSmmVariableProtocol), providing
functions for listing, reading and updating variables.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250225163031.1409078-8-kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 725 +++++++++++++++++++++++++++++++++++++
 1 file changed, 725 insertions(+)
 create mode 100644 hw/uefi/var-service-vars.c

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
new file mode 100644
index 000000000000..7f98d77a38d1
--- /dev/null
+++ b/hw/uefi/var-service-vars.c
@@ -0,0 +1,725 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - EfiSmmVariableProtocol implementation
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/dma.h"
+#include "migration/vmstate.h"
+
+#include "hw/uefi/var-service.h"
+#include "hw/uefi/var-service-api.h"
+#include "hw/uefi/var-service-edk2.h"
+
+#include "trace/trace-hw_uefi.h"
+
+#define EFI_VARIABLE_ATTRIBUTE_SUPPORTED                                \
+    (EFI_VARIABLE_NON_VOLATILE |                                        \
+     EFI_VARIABLE_BOOTSERVICE_ACCESS |                                  \
+     EFI_VARIABLE_RUNTIME_ACCESS |                                      \
+     EFI_VARIABLE_HARDWARE_ERROR_RECORD |                               \
+     EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |               \
+     EFI_VARIABLE_APPEND_WRITE)
+
+
+const VMStateDescription vmstate_uefi_time = {
+    .name = "uefi-time",
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(year, efi_time),
+        VMSTATE_UINT8(month, efi_time),
+        VMSTATE_UINT8(day, efi_time),
+        VMSTATE_UINT8(hour, efi_time),
+        VMSTATE_UINT8(minute, efi_time),
+        VMSTATE_UINT8(second, efi_time),
+        VMSTATE_UINT32(nanosecond, efi_time),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+const VMStateDescription vmstate_uefi_variable = {
+    .name = "uefi-variable",
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
+        VMSTATE_UINT32(name_size, uefi_variable),
+        VMSTATE_UINT32(data_size, uefi_variable),
+        VMSTATE_UINT32(attributes, uefi_variable),
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, uefi_variable, 0, NULL, name_size),
+        VMSTATE_VBUFFER_ALLOC_UINT32(data, uefi_variable, 0, NULL, data_size),
+        VMSTATE_STRUCT(time, uefi_variable, 0, vmstate_uefi_time, efi_time),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+uefi_variable *uefi_vars_find_variable(uefi_vars_state *uv, QemuUUID guid,
+                                       const uint16_t *name, uint64_t name_size)
+{
+    uefi_variable *var;
+
+    QTAILQ_FOREACH(var, &uv->variables, next) {
+        if (!uefi_str_equal(var->name, var->name_size,
+                            name, name_size)) {
+            continue;
+        }
+        if (!qemu_uuid_is_equal(&var->guid, &guid)) {
+            continue;
+        }
+        if (!var->data_size) {
+            /* in process of being created/updated */
+            continue;
+        }
+        return var;
+    }
+    return NULL;
+}
+
+static uefi_variable *add_variable(uefi_vars_state *uv, QemuUUID guid,
+                                   const uint16_t *name, uint64_t name_size,
+                                   uint32_t attributes)
+{
+    uefi_variable *var;
+
+    var = g_new0(uefi_variable, 1);
+    var->guid = guid;
+    var->name = g_malloc(name_size);
+    memcpy(var->name, name, name_size);
+    var->name_size = name_size;
+    var->attributes = attributes;
+
+    var->attributes &= ~EFI_VARIABLE_APPEND_WRITE;
+
+    QTAILQ_INSERT_TAIL(&uv->variables, var, next);
+    return var;
+}
+
+static void del_variable(uefi_vars_state *uv, uefi_variable *var)
+{
+    if (!var) {
+        return;
+    }
+
+    QTAILQ_REMOVE(&uv->variables, var, next);
+    g_free(var->data);
+    g_free(var->name);
+    g_free(var->digest);
+    g_free(var);
+}
+
+static size_t variable_size(uefi_variable *var)
+{
+    size_t size;
+
+    size  = sizeof(*var);
+    size += var->name_size;
+    size += var->data_size;
+    size += var->digest_size;
+    return size;
+}
+
+void uefi_vars_set_variable(uefi_vars_state *uv, QemuUUID guid,
+                            const uint16_t *name, uint64_t name_size,
+                            uint32_t attributes,
+                            void *data, uint64_t data_size)
+{
+    uefi_variable *old_var, *new_var;
+
+    uefi_trace_variable(__func__, guid, name, name_size);
+
+    old_var = uefi_vars_find_variable(uv, guid, name, name_size);
+    if (old_var) {
+        uv->used_storage -= variable_size(old_var);
+        del_variable(uv, old_var);
+    }
+
+    new_var = add_variable(uv, guid, name, name_size, attributes);
+    new_var->data = g_malloc(data_size);
+    new_var->data_size = data_size;
+    memcpy(new_var->data, data, data_size);
+    uv->used_storage += variable_size(new_var);
+}
+
+void uefi_vars_clear_volatile(uefi_vars_state *uv)
+{
+    uefi_variable *var, *n;
+
+    QTAILQ_FOREACH_SAFE(var, &uv->variables, next, n) {
+        if (var->attributes & EFI_VARIABLE_NON_VOLATILE) {
+            continue;
+        }
+        uv->used_storage -= variable_size(var);
+        del_variable(uv, var);
+    }
+}
+
+void uefi_vars_clear_all(uefi_vars_state *uv)
+{
+    uefi_variable *var, *n;
+
+    QTAILQ_FOREACH_SAFE(var, &uv->variables, next, n) {
+        del_variable(uv, var);
+    }
+    uv->used_storage = 0;
+}
+
+void uefi_vars_update_storage(uefi_vars_state *uv)
+{
+    uefi_variable *var;
+
+    uv->used_storage = 0;
+    QTAILQ_FOREACH(var, &uv->variables, next) {
+        uv->used_storage += variable_size(var);
+    }
+}
+
+static gboolean check_access(uefi_vars_state *uv, uefi_variable *var)
+{
+    if (!uv->exit_boot_service) {
+        if (!(var->attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)) {
+            return false;
+        }
+    } else {
+        if (!(var->attributes & EFI_VARIABLE_RUNTIME_ACCESS)) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static efi_status check_update(uefi_vars_state *uv, uefi_variable *old_var,
+                               uefi_variable *new_var)
+{
+    efi_status status;
+
+    if (old_var) {
+        if (!check_access(uv, old_var)) {
+            return EFI_ACCESS_DENIED;
+        }
+    }
+
+    if (new_var) {
+        if (new_var->attributes & ~EFI_VARIABLE_ATTRIBUTE_SUPPORTED) {
+            return EFI_UNSUPPORTED;
+        }
+        if (!check_access(uv, new_var)) {
+            return EFI_ACCESS_DENIED;
+        }
+    }
+
+    if (old_var && new_var) {
+        if (old_var->attributes != new_var->attributes) {
+            return EFI_INVALID_PARAMETER;
+        }
+    }
+
+    if (new_var) {
+        /* create + update */
+        status = uefi_vars_policy_check(uv, new_var, old_var == NULL);
+    } else {
+        /* delete */
+        g_assert(old_var);
+        status = uefi_vars_policy_check(uv, old_var, false);
+    }
+    if (status != EFI_SUCCESS) {
+        return status;
+    }
+
+    status = uefi_vars_check_secure_boot(uv, new_var ?: old_var);
+    if (status != EFI_SUCCESS) {
+        return status;
+    }
+
+    return EFI_SUCCESS;
+}
+
+static void append_write(uefi_variable *old_var,
+                         uefi_variable *new_var)
+{
+    uefi_vars_siglist siglist;
+    uint64_t size;
+    void *data;
+
+    uefi_vars_siglist_init(&siglist);
+    uefi_vars_siglist_parse(&siglist, old_var->data, old_var->data_size);
+    uefi_vars_siglist_parse(&siglist, new_var->data, new_var->data_size);
+
+    size = uefi_vars_siglist_blob_size(&siglist);
+    data = g_malloc(size);
+    uefi_vars_siglist_blob_generate(&siglist, data, size);
+
+    g_free(new_var->data);
+    new_var->data = data;
+    new_var->data_size = size;
+
+    uefi_vars_siglist_free(&siglist);
+}
+
+static size_t uefi_vars_mm_error(mm_header *mhdr, mm_variable *mvar,
+                                 uint64_t status)
+{
+    mvar->status = status;
+    return sizeof(*mvar);
+}
+
+static size_t uefi_vars_mm_get_variable(uefi_vars_state *uv, mm_header *mhdr,
+                                        mm_variable *mvar, void *func)
+{
+    mm_variable_access *va = func;
+    uint16_t *name;
+    void *data;
+    uefi_variable *var;
+    uint64_t length;
+
+    length = sizeof(*mvar) + sizeof(*va);
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    if (va->name_size > uv->max_storage ||
+        va->data_size > uv->max_storage) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_OUT_OF_RESOURCES);
+    }
+
+    name = func + sizeof(*va);
+    if (uadd64_overflow(length, va->name_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    if (!uefi_str_is_valid(name, va->name_size, true)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+    }
+
+    uefi_trace_variable(__func__, va->guid, name, va->name_size);
+
+    var = uefi_vars_find_variable(uv, va->guid, name, va->name_size);
+    if (!var) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_NOT_FOUND);
+    }
+
+    /* check permissions etc. */
+    if (!check_access(uv, var)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_ACCESS_DENIED);
+    }
+
+    data = func + sizeof(*va) + va->name_size;
+    if (uadd64_overflow(length, va->data_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (uv->buf_size < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    va->attributes = var->attributes;
+    if (va->data_size < var->data_size) {
+        va->data_size = var->data_size;
+        length -= va->data_size;
+        mvar->status = EFI_BUFFER_TOO_SMALL;
+    } else {
+        va->data_size = var->data_size;
+        memcpy(data, var->data, var->data_size);
+        mvar->status = EFI_SUCCESS;
+    }
+    return length;
+}
+
+static size_t
+uefi_vars_mm_get_next_variable(uefi_vars_state *uv, mm_header *mhdr,
+                               mm_variable *mvar, void *func)
+{
+    mm_next_variable *nv = func;
+    uefi_variable *var;
+    uint16_t *name;
+    uint64_t length;
+
+    length = sizeof(*mvar) + sizeof(*nv);
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    if (nv->name_size > uv->max_storage) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_OUT_OF_RESOURCES);
+    }
+
+    name = func + sizeof(*nv);
+    if (uadd64_overflow(length, nv->name_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    if (!uefi_str_is_valid(name, nv->name_size, true)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+    }
+
+    if (uefi_strlen(name, nv->name_size) == 0) {
+        /* empty string -> first */
+        var = QTAILQ_FIRST(&uv->variables);
+        if (!var) {
+            return uefi_vars_mm_error(mhdr, mvar, EFI_NOT_FOUND);
+        }
+    } else {
+        var = uefi_vars_find_variable(uv, nv->guid, name, nv->name_size);
+        if (!var) {
+            return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+        }
+        do {
+            var = QTAILQ_NEXT(var, next);
+        } while (var && !check_access(uv, var));
+        if (!var) {
+            return uefi_vars_mm_error(mhdr, mvar, EFI_NOT_FOUND);
+        }
+    }
+
+    length = sizeof(*mvar) + sizeof(*nv) + var->name_size;
+    if (uv->buf_size < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    nv->guid = var->guid;
+    nv->name_size = var->name_size;
+    memcpy(name, var->name, var->name_size);
+    mvar->status = EFI_SUCCESS;
+    return length;
+}
+
+static bool uefi_vars_mm_digest_compare(uefi_variable *old_var,
+                                        uefi_variable *new_var)
+{
+    if (!old_var->digest ||
+        !new_var->digest ||
+        !old_var->digest_size ||
+        !new_var->digest_size) {
+        /* should not happen */
+        trace_uefi_vars_security_violation("inconsistent authvar digest state");
+        return false;
+    }
+    if (old_var->digest_size != new_var->digest_size) {
+        trace_uefi_vars_security_violation("authvar digest size mismatch");
+        return false;
+    }
+    if (memcmp(old_var->digest, new_var->digest,
+               old_var->digest_size) != 0) {
+        trace_uefi_vars_security_violation("authvar digest data mismatch");
+        return false;
+    }
+    return true;
+}
+
+static size_t uefi_vars_mm_set_variable(uefi_vars_state *uv, mm_header *mhdr,
+                                        mm_variable *mvar, void *func)
+{
+    mm_variable_access *va = func;
+    uint32_t attributes = 0;
+    uint16_t *name;
+    void *data;
+    uefi_variable *old_var, *new_var;
+    uint64_t length;
+    size_t new_storage;
+    efi_status status;
+
+    length = sizeof(*mvar) + sizeof(*va);
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    if (va->name_size > uv->max_storage ||
+        va->data_size > uv->max_storage) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_OUT_OF_RESOURCES);
+    }
+
+    name = func + sizeof(*va);
+    if (uadd64_overflow(length, va->name_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    data = func + sizeof(*va) + va->name_size;
+    if (uadd64_overflow(length, va->data_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    g_assert(va->name_size < G_MAXUINT32);
+    g_assert(va->data_size < G_MAXUINT32);
+
+    if (!uefi_str_is_valid(name, va->name_size, true)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+    }
+
+    uefi_trace_variable(__func__, va->guid, name, va->name_size);
+
+    old_var = uefi_vars_find_variable(uv, va->guid, name, va->name_size);
+    if (va->data_size) {
+        new_var = add_variable(uv, va->guid, name, va->name_size,
+                               va->attributes);
+        if (va->attributes & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS) {
+            /* not implemented (deprecated in uefi spec) */
+            warn_report("%s: AUTHENTICATED_WRITE_ACCESS", __func__);
+            mvar->status = EFI_UNSUPPORTED;
+            goto rollback;
+        } else if (va->attributes &
+                   EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
+            status = uefi_vars_check_auth_2(uv, new_var, va, data);
+            if (status != EFI_SUCCESS) {
+                mvar->status = status;
+                goto rollback;
+            }
+            if (old_var && new_var) {
+                if (uefi_time_compare(&old_var->time, &new_var->time) > 0) {
+                    trace_uefi_vars_security_violation("time check failed");
+                    mvar->status = EFI_SECURITY_VIOLATION;
+                    goto rollback;
+                }
+                if (old_var->digest_size || new_var->digest_size) {
+                    if (!uefi_vars_mm_digest_compare(old_var, new_var)) {
+                        mvar->status = EFI_SECURITY_VIOLATION;
+                        goto rollback;
+                    }
+                }
+            }
+        } else {
+            new_var->data = g_malloc(va->data_size);
+            memcpy(new_var->data, data, va->data_size);
+            new_var->data_size = va->data_size;
+        }
+        if (!new_var->data) {
+            /* we land here when deleting authenticated variables */
+            del_variable(uv, new_var);
+            new_var = NULL;
+        }
+    } else {
+        new_var = NULL;
+    }
+
+    if (!old_var && !new_var) {
+        /* delete non-existing variable -> nothing to do */
+        mvar->status = EFI_SUCCESS;
+        return sizeof(*mvar);
+    }
+
+    /* check permissions etc. */
+    status = check_update(uv, old_var, new_var);
+    if (status != EFI_SUCCESS) {
+        mvar->status = status;
+        goto rollback;
+    }
+
+    if (va->attributes & EFI_VARIABLE_APPEND_WRITE && old_var && new_var) {
+        /* merge signature databases */
+        if (!uefi_vars_is_sb_any(new_var)) {
+            mvar->status = EFI_UNSUPPORTED;
+            goto rollback;
+        }
+        append_write(old_var, new_var);
+    }
+
+    /* check storage space */
+    new_storage = uv->used_storage;
+    if (old_var) {
+        new_storage -= variable_size(old_var);
+    }
+    if (new_var) {
+        new_storage += variable_size(new_var);
+    }
+    if (new_storage > uv->max_storage) {
+        mvar->status = EFI_OUT_OF_RESOURCES;
+        goto rollback;
+    }
+
+    attributes = new_var
+        ? new_var->attributes
+        : old_var->attributes;
+
+    /* all good, commit */
+    del_variable(uv, old_var);
+    uv->used_storage = new_storage;
+
+    if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+        uefi_vars_json_save(uv);
+    }
+
+    if (new_var && uefi_vars_is_sb_pk(new_var)) {
+        uefi_vars_auth_init(uv);
+    }
+
+    mvar->status = EFI_SUCCESS;
+    return sizeof(*mvar);
+
+rollback:
+    del_variable(uv, new_var);
+    return sizeof(*mvar);
+}
+
+static size_t uefi_vars_mm_variable_info(uefi_vars_state *uv, mm_header *mhdr,
+                                         mm_variable *mvar, void *func)
+{
+    mm_variable_info *vi = func;
+    uint64_t length;
+
+    length = sizeof(*mvar) + sizeof(*vi);
+    if (uv->buf_size < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    vi->max_storage_size  = uv->max_storage;
+    vi->free_storage_size = uv->max_storage - uv->used_storage;
+    vi->max_variable_size = uv->max_storage >> 2;
+    vi->attributes        = 0;
+
+    mvar->status = EFI_SUCCESS;
+    return length;
+}
+
+static size_t
+uefi_vars_mm_get_payload_size(uefi_vars_state *uv, mm_header *mhdr,
+                              mm_variable *mvar, void *func)
+{
+    mm_get_payload_size *ps = func;
+    uint64_t length;
+
+    length = sizeof(*mvar) + sizeof(*ps);
+    if (uv->buf_size < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    ps->payload_size = uv->buf_size;
+    mvar->status = EFI_SUCCESS;
+    return length;
+}
+
+static size_t
+uefi_vars_mm_lock_variable(uefi_vars_state *uv, mm_header *mhdr,
+                           mm_variable *mvar, void *func)
+{
+    mm_lock_variable *lv = func;
+    variable_policy_entry *pe;
+    uint16_t *name, *dest;
+    uint64_t length;
+
+    length = sizeof(*mvar) + sizeof(*lv);
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    name = func + sizeof(*lv);
+    if (uadd64_overflow(length, lv->name_size, &length)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+    if (mhdr->length < length) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
+
+    uefi_trace_variable(__func__, lv->guid, name, lv->name_size);
+
+    pe = g_malloc0(sizeof(*pe) + lv->name_size);
+    pe->version               = VARIABLE_POLICY_ENTRY_REVISION;
+    pe->size                  = sizeof(*pe) + lv->name_size;
+    pe->offset_to_name        = sizeof(*pe);
+    pe->namespace             = lv->guid;
+    pe->min_size              = 0;
+    pe->max_size              = UINT32_MAX;
+    pe->attributes_must_have  = 0;
+    pe->attributes_cant_have  = 0;
+    pe->lock_policy_type      = VARIABLE_POLICY_TYPE_LOCK_NOW;
+
+    dest = (void *)pe + pe->offset_to_name;
+    memcpy(dest, name, lv->name_size);
+
+    uefi_vars_add_policy(uv, pe);
+    g_free(pe);
+
+    mvar->status = EFI_SUCCESS;
+    return length;
+}
+
+uint32_t uefi_vars_mm_vars_proto(uefi_vars_state *uv)
+{
+    static const char *fnames[] = {
+        "zero",
+        "get-variable",
+        "get-next-variable-name",
+        "set-variable",
+        "query-variable-info",
+        "ready-to-boot",
+        "exit-boot-service",
+        "get-statistics",
+        "lock-variable",
+        "var-check-prop-set",
+        "var-check-prop-get",
+        "get-payload-size",
+        "init-runtime-cache-contect",
+        "sync-runtime-cache",
+        "get-runtime-cache-info",
+    };
+    const char  *fname;
+    uint64_t    length;
+
+    mm_header   *mhdr = (mm_header *) uv->buffer;
+    mm_variable *mvar = (mm_variable *) (uv->buffer + sizeof(*mhdr));
+    void        *func = (uv->buffer + sizeof(*mhdr) + sizeof(*mvar));
+
+    if (mhdr->length < sizeof(*mvar)) {
+        return UEFI_VARS_STS_ERR_BAD_BUFFER_SIZE;
+    }
+
+    fname = mvar->function < ARRAY_SIZE(fnames)
+        ? fnames[mvar->function]
+        : "unknown";
+    trace_uefi_vars_proto_cmd(fname);
+
+    switch (mvar->function) {
+    case SMM_VARIABLE_FUNCTION_GET_VARIABLE:
+        length = uefi_vars_mm_get_variable(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME:
+        length = uefi_vars_mm_get_next_variable(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_SET_VARIABLE:
+        length = uefi_vars_mm_set_variable(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO:
+        length = uefi_vars_mm_variable_info(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_LOCK_VARIABLE:
+        length = uefi_vars_mm_lock_variable(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE:
+        length = uefi_vars_mm_get_payload_size(uv, mhdr, mvar, func);
+        break;
+
+    case SMM_VARIABLE_FUNCTION_READY_TO_BOOT:
+        trace_uefi_event("ready-to-boot");
+        uv->ready_to_boot = true;
+        length = 0;
+        break;
+
+    case SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE:
+        trace_uefi_event("exit-boot-service");
+        uv->exit_boot_service = true;
+        length = 0;
+        break;
+
+    default:
+        length = uefi_vars_mm_error(mhdr, mvar, EFI_UNSUPPORTED);
+        break;
+    }
+
+    if (mhdr->length < length) {
+        mvar->status = EFI_BUFFER_TOO_SMALL;
+    }
+
+    uefi_trace_status(__func__, mvar->status);
+    return UEFI_VARS_STS_SUCCESS;
+}
-- 
2.48.1


