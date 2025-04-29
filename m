Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB91C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9la9-0002DZ-Q1; Tue, 29 Apr 2025 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZw-0001Wx-Vs
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZv-0005dU-7O
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745935494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrX2PGOCQfJNebdLuXYlBWMYGYH3MoivSKFh1V2a14k=;
 b=UFW318C8GIqv82ipxDNBcGVplzI+adF3+WGVMMtquU0Y39kWUSVPkkuWM7GU05lyTlOcfE
 cdbCqjyfENjjVBK0uzGwDO5CleZeIseo6er/4XcxQrer4TViHFTHUmqXCI0Hq3nojyBJsA
 MWakOYR6AbTQZWxVtcu+YQodq30VmTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-qAKlQEOfM3SpJai0tj8i4Q-1; Tue,
 29 Apr 2025 10:03:42 -0400
X-MC-Unique: qAKlQEOfM3SpJai0tj8i4Q-1
X-Mimecast-MFC-AGG-ID: qAKlQEOfM3SpJai0tj8i4Q_1745935421
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29C511956095; Tue, 29 Apr 2025 14:03:41 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD10819560A3; Tue, 29 Apr 2025 14:03:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/6] tests: add /qdev/free-properties test
Date: Tue, 29 Apr 2025 18:03:05 +0400
Message-ID: <20250429140306.190384-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250429140306.190384-1-marcandre.lureau@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a simple qdev test to check that allocated properties get free with
the object. This test exhibited array leaks before the fixes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/test-qdev.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 tests/unit/test-qdev.c

diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
new file mode 100644
index 0000000000..2b4c9dd643
--- /dev/null
+++ b/tests/unit/test-qdev.c
@@ -0,0 +1,96 @@
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+
+
+#define TYPE_MY_DEV "my-dev"
+typedef struct MyDev MyDev;
+DECLARE_INSTANCE_CHECKER(MyDev, STATIC_TYPE,
+                         TYPE_MY_DEV)
+
+struct MyDev {
+    DeviceState parent_obj;
+
+    uint32_t prop_u32;
+    char *prop_string;
+    uint32_t *prop_array_u32;
+    uint32_t prop_array_u32_nb;
+};
+
+static const Property my_dev_props[] = {
+    DEFINE_PROP_UINT32("u32", MyDev, prop_u32, 100),
+    DEFINE_PROP_STRING("string", MyDev, prop_string),
+    DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32, qdev_prop_uint32, uint32_t),
+};
+
+static void my_dev_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = NULL;
+    device_class_set_props(dc, my_dev_props);
+}
+
+static const TypeInfo my_dev_type_info = {
+    .name = TYPE_MY_DEV,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(MyDev),
+    .class_init = my_dev_class_init,
+};
+
+/*
+ * Initialize a fake machine, being prepared for future tests.
+ *
+ * Realization of anonymous qdev (with no parent object) requires both
+ * the machine object and its "unattached" container to be at least present.
+ */
+static void test_init_machine(void)
+{
+    /* This is a fake machine - it doesn't need to be a machine object */
+    Object *machine = object_property_add_new_container(
+        object_get_root(), "machine");
+
+    /* This container must exist for anonymous qdevs to realize() */
+    object_property_add_new_container(machine, "unattached");
+}
+
+static void test_qdev_free_properties(void)
+{
+    MyDev *mt;
+
+    mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+    object_set_props(OBJECT(mt), &error_fatal,
+                     "string", "something",
+                     "array-u32", "12,13",
+                     NULL);
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+
+    g_assert_cmpuint(mt->prop_u32, ==, 100);
+    g_assert_cmpstr(mt->prop_string, ==, "something");
+    g_assert_cmpuint(mt->prop_array_u32_nb, ==, 2);
+    g_assert_cmpuint(mt->prop_array_u32[0], ==, 12);
+    g_assert_cmpuint(mt->prop_array_u32[1], ==, 13);
+
+    object_unparent(OBJECT(mt));
+    object_unref(mt);
+}
+
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    module_call_init(MODULE_INIT_QOM);
+    type_register_static(&my_dev_type_info);
+    test_init_machine();
+
+    g_test_add_func("/qdev/free-properties",
+                    test_qdev_free_properties);
+
+    g_test_run();
+
+    return 0;
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..99f59f4ceb 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -159,6 +159,7 @@ if have_system
       'test-qdev-global-props': [qom, hwcore]
     }
   endif
+  tests += {'test-qdev': [qom, hwcore]}
 endif
 
 if have_ga and host_os == 'linux'
-- 
2.49.0


