Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D5DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRmR-0003dk-14; Tue, 04 Mar 2025 07:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhu-0004wl-Fc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhr-0007VM-9S
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSA53h4Tq1ld+EUgLayekMHRu0q1zKVUKG7i9WfYbL0=;
 b=fXFfBe1gLaz2JfJKjTBoQmY7MRyqnTW/H5sSER+kqwae0K/mpektldxF7QRuLR9RQNVxC+
 xejJ4DMlu9QDyBakrNTQ4v8O8HqPEWEPD3Hpqyu2I0zrMWywfjTI6oy8tMvZFFAcCkfNJe
 kYQfHeDayFdP7VOwQEeW6y0cBdM1RUI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-R3YktBr-NUe4Q2yq612kWw-1; Tue,
 04 Mar 2025 07:48:48 -0500
X-MC-Unique: R3YktBr-NUe4Q2yq612kWw-1
X-Mimecast-MFC-AGG-ID: R3YktBr-NUe4Q2yq612kWw_1741092527
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2F051800873; Tue,  4 Mar 2025 12:48:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C565219560AA; Tue,  4 Mar 2025 12:48:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2631818003BB; Tue, 04 Mar 2025 13:48:16 +0100 (CET)
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
Subject: [PULL 14/24] hw/uefi: add var-service-json.c + qapi for NV vars.
Date: Tue,  4 Mar 2025 13:48:02 +0100
Message-ID: <20250304124815.591749-15-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define qapi schema for the uefi variable store state.

Use it and the generated visitor helper functions to store persistent
(EFI_VARIABLE_NON_VOLATILE) variables in JSON format on disk.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250225163031.1409078-15-kraxel@redhat.com>
[ incremental fix squashed in ]
Message-ID: <pji24p6oag7cn2rovus7rquo7q2c6tokuquobfro2sqorky7vu@tk7cxud6jw7f>
---
 hw/uefi/var-service-json.c | 243 +++++++++++++++++++++++++++++++++++++
 qapi/meson.build           |   1 +
 qapi/qapi-schema.json      |   1 +
 qapi/uefi.json             |  64 ++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/uefi/var-service-json.c
 create mode 100644 qapi/uefi.json

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
new file mode 100644
index 000000000000..761082c11fc1
--- /dev/null
+++ b/hw/uefi/var-service-json.c
@@ -0,0 +1,243 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - serialize non-volatile varstore from/to json,
+ *                    using qapi
+ *
+ * tools which can read/write these json files:
+ *  - https://gitlab.com/kraxel/virt-firmware
+ *  - https://github.com/awslabs/python-uefivars
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+#include "qobject/qobject.h"
+#include "qobject/qjson.h"
+
+#include "qapi/dealloc-visitor.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/qapi-types-uefi.h"
+#include "qapi/qapi-visit-uefi.h"
+
+static char *generate_hexstr(void *data, size_t len)
+{
+    static const char hex[] = {
+        '0', '1', '2', '3', '4', '5', '6', '7',
+        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
+    };
+    uint8_t *src = data;
+    char *dest;
+    size_t i;
+
+    dest = g_malloc(len * 2 + 1);
+    for (i = 0; i < len * 2;) {
+        dest[i++] = hex[*src >> 4];
+        dest[i++] = hex[*src & 15];
+        src++;
+    }
+    dest[i++] = 0;
+
+    return dest;
+}
+
+static UefiVarStore *uefi_vars_to_qapi(uefi_vars_state *uv)
+{
+    UefiVarStore *vs;
+    UefiVariableList **tail;
+    UefiVariable *v;
+    QemuUUID be;
+    uefi_variable *var;
+
+    vs = g_new0(UefiVarStore, 1);
+    vs->version = 2;
+    tail = &vs->variables;
+
+    QTAILQ_FOREACH(var, &uv->variables, next) {
+        if (!(var->attributes & EFI_VARIABLE_NON_VOLATILE)) {
+            continue;
+        }
+
+        v = g_new0(UefiVariable, 1);
+        be = qemu_uuid_bswap(var->guid);
+        v->guid = qemu_uuid_unparse_strdup(&be);
+        v->name = uefi_ucs2_to_ascii(var->name, var->name_size);
+        v->attr = var->attributes;
+
+        v->data = generate_hexstr(var->data, var->data_size);
+
+        if (var->attributes &
+            EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
+            v->time = generate_hexstr(&var->time, sizeof(var->time));
+            if (var->digest && var->digest_size) {
+                v->digest = generate_hexstr(var->digest, var->digest_size);
+            }
+        }
+
+        QAPI_LIST_APPEND(tail, v);
+    }
+    return vs;
+}
+
+static unsigned parse_hexchar(char c)
+{
+    switch (c) {
+    case '0' ... '9': return c - '0';
+    case 'a' ... 'f': return c - 'a' + 0xa;
+    case 'A' ... 'F': return c - 'A' + 0xA;
+    default: return 0;
+    }
+}
+
+static void parse_hexstr(void *dest, char *src, int len)
+{
+    uint8_t *data = dest;
+    size_t i;
+
+    for (i = 0; i < len; i += 2) {
+        *(data++) =
+            parse_hexchar(src[i]) << 4 |
+            parse_hexchar(src[i + 1]);
+    }
+}
+
+static void uefi_vars_from_qapi(uefi_vars_state *uv, UefiVarStore *vs)
+{
+    UefiVariableList *item;
+    UefiVariable *v;
+    QemuUUID be;
+    uefi_variable *var;
+    uint8_t *data;
+    size_t i, len;
+
+    for (item = vs->variables; item != NULL; item = item->next) {
+        v = item->value;
+
+        var = g_new0(uefi_variable, 1);
+        var->attributes = v->attr;
+        qemu_uuid_parse(v->guid, &be);
+        var->guid = qemu_uuid_bswap(be);
+
+        len = strlen(v->name);
+        var->name_size = len * 2 + 2;
+        var->name = g_malloc(var->name_size);
+        for (i = 0; i <= len; i++) {
+            var->name[i] = v->name[i];
+        }
+
+        len = strlen(v->data);
+        var->data_size = len / 2;
+        var->data = data = g_malloc(var->data_size);
+        parse_hexstr(var->data, v->data, len);
+
+        if (v->time && strlen(v->time) == 32) {
+            parse_hexstr(&var->time, v->time, 32);
+        }
+
+        if (v->digest) {
+            len = strlen(v->digest);
+            var->digest_size = len / 2;
+            var->digest = g_malloc(var->digest_size);
+            parse_hexstr(var->digest, v->digest, len);
+        }
+
+        QTAILQ_INSERT_TAIL(&uv->variables, var, next);
+    }
+}
+
+static GString *uefi_vars_to_json(uefi_vars_state *uv)
+{
+    UefiVarStore *vs = uefi_vars_to_qapi(uv);
+    QObject *qobj = NULL;
+    Visitor *v;
+    GString *gstr;
+
+    v = qobject_output_visitor_new(&qobj);
+    if (visit_type_UefiVarStore(v, NULL, &vs, NULL)) {
+        visit_complete(v, &qobj);
+    }
+    visit_free(v);
+    qapi_free_UefiVarStore(vs);
+
+    gstr = qobject_to_json_pretty(qobj, true);
+    qobject_unref(qobj);
+
+    return gstr;
+}
+
+void uefi_vars_json_init(uefi_vars_state *uv, Error **errp)
+{
+    if (uv->jsonfile) {
+        uv->jsonfd = qemu_create(uv->jsonfile, O_RDWR, 0666, errp);
+    }
+}
+
+void uefi_vars_json_save(uefi_vars_state *uv)
+{
+    GString *gstr;
+    int rc;
+
+    if (uv->jsonfd == -1) {
+        return;
+    }
+
+    gstr = uefi_vars_to_json(uv);
+
+    lseek(uv->jsonfd, 0, SEEK_SET);
+    rc = ftruncate(uv->jsonfd, 0);
+    if (rc != 0) {
+        warn_report("%s: ftruncate error", __func__);
+    }
+    rc = write(uv->jsonfd, gstr->str, gstr->len);
+    if (rc != gstr->len) {
+        warn_report("%s: write error", __func__);
+    }
+    fsync(uv->jsonfd);
+
+    g_string_free(gstr, true);
+}
+
+void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
+{
+    UefiVarStore *vs;
+    QObject *qobj;
+    Visitor *v;
+    char *str;
+    size_t len;
+    int rc;
+
+    if (uv->jsonfd == -1) {
+        return;
+    }
+
+    len = lseek(uv->jsonfd, 0, SEEK_END);
+    if (len == 0) {
+        return;
+    }
+
+    str = g_malloc(len + 1);
+    lseek(uv->jsonfd, 0, SEEK_SET);
+    rc = read(uv->jsonfd, str, len);
+    if (rc != len) {
+        warn_report("%s: read error", __func__);
+    }
+    str[len] = 0;
+
+    qobj = qobject_from_json(str, errp);
+    v = qobject_input_visitor_new(qobj);
+    visit_type_UefiVarStore(v, NULL, &vs, errp);
+    visit_free(v);
+
+    if (!(*errp)) {
+        uefi_vars_from_qapi(uv, vs);
+        uefi_vars_update_storage(uv);
+    }
+
+    qapi_free_UefiVarStore(vs);
+    qobject_unref(qobj);
+    g_free(str);
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..eadde4db307f 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -65,6 +65,7 @@ if have_system
     'pci',
     'rocker',
     'tpm',
+    'uefi',
   ]
 endif
 if have_system or have_tools
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..2877aff73d0c 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -81,3 +81,4 @@
 { 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'uefi.json' }
diff --git a/qapi/uefi.json b/qapi/uefi.json
new file mode 100644
index 000000000000..bdfcabe1df4d
--- /dev/null
+++ b/qapi/uefi.json
@@ -0,0 +1,64 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# = UEFI Variable Store
+#
+# The qemu efi variable store implementation (hw/uefi/) uses this to
+# store non-volatile variables in json format on disk.
+#
+# This is an existing format already supported by (at least) two other
+# projects, specifically https://gitlab.com/kraxel/virt-firmware and
+# https://github.com/awslabs/python-uefivars.
+##
+
+##
+# @UefiVariable:
+#
+# UEFI Variable.  Check the UEFI specifification for more detailed
+# information on the fields.
+#
+# @guid: variable namespace GUID
+#
+# @name: variable name, in UTF-8 encoding.
+#
+# @attr: variable attributes.
+#
+# @data: variable value, encoded as hex string.
+#
+# @time: variable modification time.  EFI_TIME struct, encoded as hex
+#     string.  Used only for authenticated variables, where the
+#     EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute bit
+#     is set.
+#
+# @digest: variable certificate digest.  Used to verify the signature
+#     of updates for authenticated variables.  UEFI has two kinds of
+#     authenticated variables.  The secure boot variables ('PK',
+#     'KEK', 'db' and 'dbx') have hard coded signature checking rules.
+#     For other authenticated variables the firmware stores a digest
+#     of the signing certificate at variable creation time, and any
+#     updates must be signed with the same certificate.
+#
+# Since: 10.0
+##
+{ 'struct' : 'UefiVariable',
+  'data' : { 'guid'  : 'str',
+             'name'  : 'str',
+             'attr'  : 'int',
+             'data'  : 'str',
+             '*time' : 'str',
+             '*digest' : 'str'}}
+
+##
+# @UefiVarStore:
+#
+# @version: currently always 2
+#
+# @variables: list of UEFI variables
+#
+# Since: 10.0
+##
+{ 'struct' : 'UefiVarStore',
+  'data' : { 'version'   : 'int',
+             'variables' : [ 'UefiVariable' ] }}
-- 
2.48.1


