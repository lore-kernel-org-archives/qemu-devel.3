Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E27AD232C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 23:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdz3V-0007GD-DE; Thu, 08 Jan 2026 18:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3U-0007FP-CK
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3S-0003Vb-N6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767913471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cv1t496rtiOvHFcgquBJQKTEpYow9+MipYjH+vSBpgk=;
 b=L0P7aJX1AtO3LifTgyJku1M8FFCYoKo4XAG82NsE3Bup53wp6fynB86LskSyGxEJAceO6L
 utRFQQLWY0/zF1h3PED6WIZfX7VgcFIy4OPHS0jVSV8RTOUvQ0R1iLN3yAt+LZvuAAZTzg
 oPYh2VlNs6ihyf07S76pAuA2uqRotSs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-uADfvPngPpKTFMw-hvP7qg-1; Thu, 08 Jan 2026 18:04:30 -0500
X-MC-Unique: uADfvPngPpKTFMw-hvP7qg-1
X-Mimecast-MFC-AGG-ID: uADfvPngPpKTFMw-hvP7qg_1767913470
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b8738fb141so691103285a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767913470; x=1768518270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cv1t496rtiOvHFcgquBJQKTEpYow9+MipYjH+vSBpgk=;
 b=MlPydl4WcxSSfmAhYh1TZCstCKoK6npa7+IjG1+VY2kJaXDfdqtlim7AdPdih/gz9M
 CjFMCjc3HGEmxc19snMNFmuwDtrHQAvULJGFk7Lu3HI6AA45fiG35KulqoORvToPNiZs
 kNPuc6cv4+b/i9uWkds/U41hjJVdhS4QGMxEthEX0CFD6914ci7YDsmr74QGTr7Wfc1/
 /Qw4fq5eFzvCln4eg7miMheGHvgsWUvjj1VvqOR2l1joIEVx90H2ydTxJQ2s7SSI+PRf
 wL1bq63ivQJOUC6UvDyzvwWb77o8JPpPT/F/BH17wE0BC8wfy3gRXu8NfyiyrHRBfHcS
 2wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767913470; x=1768518270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cv1t496rtiOvHFcgquBJQKTEpYow9+MipYjH+vSBpgk=;
 b=ktdSdf0Vl+CYoP8x5+cKHcfmKKs35nB5cGPJ11xlkgujE4gpmUai9N19ythrhOpfkF
 CZmPiIYjxL4R3XsLlK5WHtRI6T0U5XCGTg4Ik7dsDEJrozJrlxGqwWbiSEMtCAnWAHA7
 8E5bpSwR+lxQwx+1+3GflTwR3YoxDvyuVTGbXra7ZplZPy4HsHIbgVc0hf8tf4l75qJI
 4og1jPtsq/pfEmheVCplkQJEyozNaSnNc5qlBufmoUii4auwcmpxAyx5fqUo0Q3HBZ7y
 uj1DpKm9A0YU5SU71aJLJQzysv4q8Z+6nOrp1v34sm7+wtZqsqgQwevHoW/f2YDXWJvV
 urJQ==
X-Gm-Message-State: AOJu0Yz8LdI6NZ7oUmCSeCiS5OKUvntxMJKM/UQ/osoxgbIsroWilgzn
 kl2EuCxWTMWSUW/K4C1KOaVXMFpoC++WT3YlGMNTd53UwM0qayWa1R2KqOXbKm9e8CTVn6VT+9A
 VtopxLaBTbPhHsjjXTJ9Ax1KxJUXJJDPwHd3FMKgG2x36Y2esfjg3G0Lu+GAnuUsWtkscRyJ5VJ
 Qoa2xnVtc3nUDneFv/B1f0Wzfa6sxYkJQLg2rdeGA=
X-Gm-Gg: AY/fxX5P1hsDCOhvP6bz3Cz2ddfwz7tQ0omRoS533QnmCNTxCBNbA/QLU68R40AqnWq
 MzuuAlUuyjVA2J2wbUN7y9LJzlBA6t2Ic1uKoruM6pVDNG0qwl58mEFymSnipU/d+y4ZoeVdGLk
 2kSxX1IFHykCHvFp6nzTWei6sG4WTLJXdD7/A8JJWriUF1SUNcHkS0VeirTtdAG6G/pEA4APCiR
 fuUGGYt9JruN2jaY9UnGHlgYcQq0ptA/RrQZ7Tnt2jATcIJYC2xDVjpj0ieu0Zn5v5yCSDCpvkg
 DxUm5/P7ZMdA6MlmhungJIFa72LWz6Sqm+u+7GIsZ1tlkI7DI/Tz7dXcQNAgN67/CsOSHfYnwV/
 tmO37JysPAn8IolpUJEY54qjucMmkUQovETtwNNk=
X-Received: by 2002:a05:620a:7004:b0:8b2:e177:ddb0 with SMTP id
 af79cd13be357-8c388bd8d6emr965150785a.23.1767913469910; 
 Thu, 08 Jan 2026 15:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzL2AJ6ZodN/dLEOhjkEmnGrR7OpZAqsq3O/8QBb+eL89B+9yPGgRYwg9ZIFVmQeOEiFIYOA==
X-Received: by 2002:a05:620a:7004:b0:8b2:e177:ddb0 with SMTP id
 af79cd13be357-8c388bd8d6emr965146585a.23.1767913469427; 
 Thu, 08 Jan 2026 15:04:29 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm680000685a.29.2026.01.08.15.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 15:04:29 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 5/5] tests: add /qdev/free-properties test
Date: Thu,  8 Jan 2026 15:03:11 -0800
Message-ID: <20260108230311.584141-6-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
References: <20260108230311.584141-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
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

Add a simple qdev test to check that allocated properties get freed with
the object. This test exhibited array leaks before the fixes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20250429140306.190384-6-marcandre.lureau@redhat.com>
---
 tests/unit/meson.build |  1 +
 tests/unit/test-qdev.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tests/unit/test-qdev.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index bd58029060..41e8b06c33 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -156,6 +156,7 @@ if have_system
       'test-qdev-global-props': [qom, hwcore]
     }
   endif
+  tests += {'test-qdev': [qom, hwcore]}
 endif
 
 if have_ga and host_os == 'linux'
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
new file mode 100644
index 0000000000..20eae38e03
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
-- 
2.51.1


