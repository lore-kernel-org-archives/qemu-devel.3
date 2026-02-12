Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD55EE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXw7-0007Tt-Fp; Thu, 12 Feb 2026 09:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXva-0006Yp-OE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvY-0006IE-DE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODhn/b5AvptlCuVZKL5lyPwHbvz25VOUzIhw6xuP1GI=;
 b=f1wWxqKLoa0jdtV+ZVp4xG6WiC2qJQPaHf6wGAfk8ubCBgmDHlCzngII2R6IdtGXYaZqLD
 8YjuSwlIh0ajish7TdLMQ5LRuomRTeY+61QARPkGmAeul1YgU8BNh+SbPxWIuM4oo9nduq
 Vc5kL0XbOxbpQmx71ACfvXGs+o82rvc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qtX18ST1PV2qGUZBIWarHg-1; Thu, 12 Feb 2026 09:44:18 -0500
X-MC-Unique: qtX18ST1PV2qGUZBIWarHg-1
X-Mimecast-MFC-AGG-ID: qtX18ST1PV2qGUZBIWarHg_1770907457
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso70119045e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907457; x=1771512257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODhn/b5AvptlCuVZKL5lyPwHbvz25VOUzIhw6xuP1GI=;
 b=FtBjML2KSMMk9Bh/rmQetk4NyyVAY1VGgt41rpHtqsGmXW95jseLKXInW7Ax9ZXFgS
 pi/CxNHIryRS9NLW5z4NIkvWMtrd9kt+wD1I4rKl0b4k+iAj8dngxxvUgeFG0DqIfaKH
 d5rUcd4h+CuMhLvdxPCHb4kVqn8pUB923GGYieYqFZ8UkZFwvZFGYdwLbgStjCYosB5U
 VI/HkkEjGHXMjIMnzLthRZxZI94GNYCkkmZz7EoZZYrIJuDA/DsDcX0PQRCfjUfdgGeq
 pabd8P/mmXfS5iUga5T5Q/Bo+hNHfPf8xCVv7xIXGeN09egSFHc96ThkYXNWF6gqvj2g
 xzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907457; x=1771512257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODhn/b5AvptlCuVZKL5lyPwHbvz25VOUzIhw6xuP1GI=;
 b=TAKyCfqcNDsyfXyVnMD0egVqVUXzC9dPNnDhcC01BDRwG1G2zVI59jAxUPEWg3u6/y
 GKLbAkPwj61XGgdy0Yx0Ea8oyofwKOMaitXNvI36uWAvr5YPQGZ5Bgg9xHIo8NoJrMDA
 7HFndvYpW/a3XPJ0vcyIABPBKYe5TgbvOauSCPLag6Cmzqhi8foZKu82QQfEv8HV5u/o
 efIKB8hIlTskKlUpdqQPpuYW+Pz9dtJBE4ZInuNJUWKBCY23dgjTg87EBjfOHNEUJjHa
 dUYMNJ8SRCvpN4+ZJk5GImj8l16ybVVS/n+xPxB6aE63qRYW+pNLzCZ63ZLy2DY3LwfW
 oMkw==
X-Gm-Message-State: AOJu0Yyn14nYQB1VZpPj5S3VQrcD6RYHr5SCfIOniKB4DYks0/gSiT5M
 iuSdTH7ZZGG6mMRAeBz9xnGAmmHF0+7pVtVcsbA+GMLAKt+lsDqfd01kna1V3/9CzCGpiNCcjfm
 XL1ytKsWwq4NizWQCFmLEfNlgIeEv6eoW+Kw9vRKW0a2gGgMtmS1g9jFqzBsOo5G2X9OA2vzZ5g
 lEeVKp3sOnlryMco/ycnOMIHyL4GHAw4otUMVESzYd
X-Gm-Gg: AZuq6aK9hKcCnaFPco8NXx6uuZnaBYuKnCWj5tr0niaCOGNFqcmCaN4LvnNfB4KSsys
 IrrS9zkzc+KHxeHzACS2d5D/wJIhYBK1hfyqSVq78eqasLgfoMYO2kBBVfoNVK+Kj8BW+hgTuGU
 xKIsvE5h5h5JC7g1C8wuR1wT9zOKsWYWefMwqSqyCruhInoLf6WyM6FQFkv+FKX3o55dn4MDtYQ
 j9tg1CNx9KAUsWp6JAMNE0FHU4JkY5QPl03IC49qXBNPWBHWIHPHSA1lUBmhJh+QHnqJZku1Avo
 GbtLsTpBjcG8lQSf7sxG53W/vU3jauM8p2ATx4RbnMKooQNSa+yfROoJYnbFteVjTXyZpzUBdhY
 ZZppvX7qvvIr9G/U47zDUOFzriiuT7h82xJeeL+zqlWn+0zCX48wAP7rjJphWrODdFcZL9XGkl9
 d+48pjoY5lpinlbLZpohKV9KaTCEuC8BuBdVyi990B8q2LZ/nyUw8=
X-Received: by 2002:a05:600c:4e14:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-483656ae432mr41831755e9.2.1770907456879; 
 Thu, 12 Feb 2026 06:44:16 -0800 (PST)
X-Received: by 2002:a05:600c:4e14:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-483656ae432mr41831305e9.2.1770907456373; 
 Thu, 12 Feb 2026 06:44:16 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a66fcf7sm56255795e9.7.2026.02.12.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 39/41] tests: add /qdev/free-properties test
Date: Thu, 12 Feb 2026 15:42:41 +0100
Message-ID: <20260212144244.22579-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Add a simple qdev test to check that allocated properties get freed with
the object. This test exhibited array leaks before the fixes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250429140306.190384-6-marcandre.lureau@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260108230311.584141-6-csomani@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/test-qdev.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 tests/unit/test-qdev.c

diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
new file mode 100644
index 00000000000..20eae38e03f
--- /dev/null
+++ b/tests/unit/test-qdev.c
@@ -0,0 +1,96 @@
+#include "qemu/osdep.h"
+#include "hw/core/qdev-properties.h"
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
+    DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32,
+                     qdev_prop_uint32, uint32_t),
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
index bd580290601..41e8b06c339 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -156,6 +156,7 @@ if have_system
       'test-qdev-global-props': [qom, hwcore]
     }
   endif
+  tests += {'test-qdev': [qom, hwcore]}
 endif
 
 if have_ga and host_os == 'linux'
-- 
2.52.0


