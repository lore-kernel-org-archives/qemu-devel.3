Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907FBD111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 22:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOkuH-0001gz-Qd; Thu, 27 Nov 2025 17:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkuG-0001gn-6r
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:56:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkuE-0001V2-CM
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:56:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWwV1VPszJ467Q;
 Fri, 28 Nov 2025 06:55:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id C2D751402E9;
 Fri, 28 Nov 2025 06:56:03 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:56:02 +0000
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>, 
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 1/7] hw/mem: Add tagged memory backend object
Date: Thu, 27 Nov 2025 22:55:19 +0000
Message-ID: <20251127225526.700-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20251127225526.700-1-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.72.83]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a new memory-backend-tagged supports a tag property where you can
find it based on tag. This is useful for scenarios where you want to add
a piece of memory for a particular purpose to be passed for another
device.

At the moment, this only supports a ram-backed object where we add a tag
to it, and it temporary. However, we are planning for a generalized
approach. The plan is to have a shim object where we add a tag to it,
and then it can be later linked to any BACKEND object types.

Example use QMP API:
{

    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-tagged",
        "id": "tm0",
        "size": 1073741824,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

Tags are assumed to be UUID. But this is something for debate maybe.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/meson.build          |   1 +
 hw/mem/tagged_mem.c         | 116 ++++++++++++++++++++++++++++++++++++
 include/hw/mem/tagged_mem.h |  31 ++++++++++
 qapi/qom.json               |  15 +++++
 4 files changed, 163 insertions(+)
 create mode 100644 hw/mem/tagged_mem.c
 create mode 100644 include/hw/mem/tagged_mem.h

diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 1c1c6da24b..529d86f840 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_MEM_DEVICE', if_false: files('memory-device-stubs.c'
 system_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
 system_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
+system_ss.add(files('tagged_mem.c'))
diff --git a/hw/mem/tagged_mem.c b/hw/mem/tagged_mem.c
new file mode 100644
index 0000000000..27b88e845e
--- /dev/null
+++ b/hw/mem/tagged_mem.c
@@ -0,0 +1,116 @@
+/*
+ * Tagged memory backend. Temporary implementation for testing purposes and
+ * only supports RAM based.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/mem/tagged_mem.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qom/object.h"
+#include "qom/qom-qobject.h"
+
+static int check_property_equals_test(Object *obj, void *opaque)
+{
+    Error *err = NULL;
+    struct TagSearchContext *ctx = opaque;
+    g_autofree char *value;
+
+    if (!object_dynamic_cast(OBJECT(obj), TYPE_MEMORY_BACKEND_TAGGED)) {
+        return 0;
+    }
+
+    value = object_property_get_str(obj, "tag", &err);
+    if (err) {
+        error_report_err(err);
+        return 0;
+    }
+
+    if (strcmp(value, ctx->tag_value) == 0) {
+        ctx->result = MEMORY_BACKEND(obj);
+        return 1;
+    }
+
+    return 0;
+}
+
+HostMemoryBackend *memory_backend_tagged_find_by_tag(const char *tag,
+                                                     Error **errp)
+{
+    struct TagSearchContext ctx = {
+        .tag_value = tag,
+        .result = NULL,
+    };
+
+    object_child_foreach_recursive(object_get_objects_root(),
+                                   check_property_equals_test, &ctx);
+
+    if (!ctx.result) {
+        qemu_log("didn't find any results!\n");
+        return NULL;
+    }
+
+    return ctx.result;
+}
+
+static void tagged_mem_set_tag(Object *obj, const char *value, Error **errp)
+{
+    MemoryBackendTagged *tm = MEMORY_BACKEND_TAGGED(obj);
+    g_free(tm->tag);
+    tm->tag = g_strdup(value);
+}
+
+static char *tagged_mem_get_tag(Object *obj, Error **errp)
+{
+    MemoryBackendTagged *tm = MEMORY_BACKEND_TAGGED(obj);
+    return g_strdup(tm->tag);
+}
+
+static bool ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    g_autofree char *name = NULL;
+    uint32_t ram_flags;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return false;
+    }
+
+    name = host_memory_backend_get_name(backend);
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
+    ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    return memory_region_init_ram_flags_nomigrate(
+        &backend->mr, OBJECT(backend), name, backend->size, ram_flags, errp);
+}
+
+static void memory_backend_tagged_class_init(ObjectClass *oc, const void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = ram_backend_memory_alloc;
+    object_class_property_add_str(oc, "tag", tagged_mem_get_tag,
+                                  tagged_mem_set_tag);
+    object_class_property_set_description(oc, "tag",
+        "A user-defined tag to identify this memory backend");
+}
+
+static const TypeInfo memory_backend_tagged_info = {
+    .name = TYPE_MEMORY_BACKEND_TAGGED,
+    .parent = TYPE_MEMORY_BACKEND,
+    .instance_size = sizeof(MemoryBackendTagged),
+    .class_init = memory_backend_tagged_class_init,
+};
+
+static void memory_backend_tagged_register_types(void)
+{
+    type_register_static(&memory_backend_tagged_info);
+}
+
+type_init(memory_backend_tagged_register_types);
diff --git a/include/hw/mem/tagged_mem.h b/include/hw/mem/tagged_mem.h
new file mode 100644
index 0000000000..4f3b033597
--- /dev/null
+++ b/include/hw/mem/tagged_mem.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Tagged Memory backend
+ *
+ * Copyright (c) 2025 Alireza Sanaee <alireza.sanaee@huawei.com>
+ */
+#ifndef HW_TAGGED_MEM_H
+#define HW_TAGGED_MEM_H
+
+#include "hw/qdev-core.h"
+#include "system/memory.h"
+#include "system/hostmem.h"
+
+#define TYPE_MEMORY_BACKEND_TAGGED "memory-backend-tagged"
+OBJECT_DECLARE_SIMPLE_TYPE(MemoryBackendTagged, MEMORY_BACKEND_TAGGED)
+
+typedef struct MemoryBackendTagged {
+    HostMemoryBackend parent_obj;
+
+    char *tag;
+} MemoryBackendTagged;
+
+struct TagSearchContext {
+    const char *tag_value;
+    HostMemoryBackend *result;
+};
+
+HostMemoryBackend *memory_backend_tagged_find_by_tag(const char *tag,
+                                                     Error **errp);
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index 830cb2ffe7..96d0184864 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -687,6 +687,19 @@
             'size': 'size',
             '*x-use-canonical-path-for-ramblock-id': 'bool' } }
 
+##
+# @MemoryBackendTaggedProperties:
+#
+# Properties for objects of classes derived from memory-backend.
+#
+# @tag: Memory tag
+#
+# Since: 11.0
+##
+{ 'struct': 'MemoryBackendTaggedProperties',
+  'base': 'MemoryBackendProperties',
+  'data': { '*tag': 'str' } }
+
 ##
 # @MemoryBackendFileProperties:
 #
@@ -1218,6 +1231,7 @@
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
+    'memory-backend-tagged',
     { 'name': 'memory-backend-shm',
       'if': 'CONFIG_POSIX' },
     'pef-guest',
@@ -1296,6 +1310,7 @@
       'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
                                       'if': 'CONFIG_LINUX' },
       'memory-backend-ram':         'MemoryBackendProperties',
+      'memory-backend-tagged':      'MemoryBackendTaggedProperties',
       'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
                                       'if': 'CONFIG_POSIX' },
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
-- 
2.43.0


