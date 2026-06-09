Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514D3CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D3-0007ei-Qz; Tue, 09 Jun 2026 13:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cn-0007WL-C9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ch-0001rr-6t
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RIIsjklWbcutayG6SOK/nSI0TGaNMIJ0fYUtITssro=;
 b=RjcvIJ0W5gENpcMLmHupCaUTcbiPaWKn4Q5JF8gx7EMGnouNz6bSXMqYpaQWDe+CpAO+b4
 6xsOo6T+//8hvkBrxBX5AbrG8O4HMMZA4MqOjfrttZ6JFhw82RzekUjDlqTyeyK+xIrqY3
 FhknczvEd/KqJKQlweSA1SHhxlfMuZE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-6QdCOea9MDWMIPA4fy0Dqw-1; Tue, 09 Jun 2026 13:25:28 -0400
X-MC-Unique: 6QdCOea9MDWMIPA4fy0Dqw-1
X-Mimecast-MFC-AGG-ID: 6QdCOea9MDWMIPA4fy0Dqw_1781025928
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517615db531so155818581cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025928; x=1781630728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RIIsjklWbcutayG6SOK/nSI0TGaNMIJ0fYUtITssro=;
 b=ZR7tPvI+8WqwWzUkRSlaYUJf9Wig8GKff9UK5D1vdHIhVTTtYoYebtWrbtiRHUXKC1
 zqQ3gNGb6TPVP/bSu8QWJxBd0kPvoe34eLqY353cf7GVdwI9OO2NAp9X1gCG6P+KhuXM
 wfKfKah3kHhcBGiw+UrJ/OeJ0sgyBz6CJJYz7TDvfaU2IAG78jeKGQRTg3luea33VdQg
 d5hjNYliiQKszj0l+xiam+dbBXX1hiQrC3YbNtrwPo3yp0uuJFhIMESA6l0Tgpg+Bo17
 Uo0v5LFE96UZ8vNrWT8FXgvpggcWiFXC56sO+elh987XYGSWz+xVkib5DhiLLRjMLF9r
 pLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025928; x=1781630728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+RIIsjklWbcutayG6SOK/nSI0TGaNMIJ0fYUtITssro=;
 b=qhVZifiBeV/lxlYQXW4Ex490jHIWDV5LW9dY4IbN0NDzAa1WeukDimSV/IvBdiGujv
 CrePZ1BOdyhfLBSQUnU4M1d+jqUfvzki0IougLDvsLrY0LTujIbxQ0WGeMj8DLYVU7ZG
 Kc183a0Vc2SfvOU6BjOVHWhfj99L8/hS2/xI71lqOM/9d8IfycLHotbQtZiIisK4lTiZ
 DEB2YR3KqjVuIYGIA+1ptdrjm/7LFwuIuDgBL1zRHJe91LwqUkpetARiP+IrG5esxJDA
 b/Um/7yYXRJQNn3m/NrTFlFOdNNVm73ZB9ggZRIN6ov1E6njbjisnF8uMLE3vvl3wolS
 StsQ==
X-Gm-Message-State: AOJu0YyCIbBvI2YKrfyaU4P/msOToRIkzuHXv5ubWvadZr3lG6aGRQUg
 vAYRFS/Oq3T0Umqf95atTu8At2Ow5CuEWzrMwUdOy+atz7FkVDQgk2INuFlV9xY9rP5gHoOFreK
 3ZN5ez7n/1GIsmuphKEpnwnAxnkJBngHHxrZpFsVytUnC3FgvMcKcKgPy3WEVPMCYtEjFCAs8bu
 5WlldqPAzHmbuy0V60ApLxlX42+cTmxq/ueGP+VQ==
X-Gm-Gg: Acq92OGZSCuXEEck7WSDSZmtTDl44EM9ehIaLGdzbHAWy9uLDmkRxh1D7Wv4QGEBhr5
 aqSbHcg79eebuKLlu4TZEr2xLBISt8B8smdOYYt1z5HKPJv4EBBKWUeiS2BSyzcbp+7KimUAQ78
 2YP6Dl3diXLcdw+M7vsrzx3rILhiUC3u+IhoDx8WewmCSIY2CkwNjkQdhQuBsmSKHhLXSW/N8nN
 eg+pdsnQ5Sroww88RvJa+JpXLf/x8fBsMd7ApoluTym/RIHnm/lE4pNAFxDdI7LhgWMQr2DHLIX
 OrWFbYYIDXe8eIpZA/jO8k4ZhQ4OeWQQKh0yPFHSfm+T4iOtme3oIz4zVOGptn79S2tqt19s5pP
 cb6GO4hr6upcioN6uwde+TvA=
X-Received: by 2002:a05:622a:1808:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-51796f06eadmr297342271cf.14.1781025927452; 
 Tue, 09 Jun 2026 10:25:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1808:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-51796f06eadmr297341161cf.14.1781025926446; 
 Tue, 09 Jun 2026 10:25:26 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Date: Tue,  9 Jun 2026 13:25:09 -0400
Message-ID: <20260609172514.2037645-6-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create object-property-ptr.[ch] files to include all the helpers for
object_property_add*_ptr().

These set of helpers are handy because they look extremely familiar with
qdev-properties, allowing the caller to provide a pointer and it will
manage all the setters and getters.

The follow up patches may introduce more of such helpers.  Since object.c
has been already too big, split that part out.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object-property-ptr.h | 103 +++++++++++++
 include/qom/object.h              |  99 +-----------
 qom/object-property-ptr.c         | 248 ++++++++++++++++++++++++++++++
 qom/object.c                      | 240 -----------------------------
 qom/meson.build                   |   1 +
 5 files changed, 358 insertions(+), 333 deletions(-)
 create mode 100644 include/qom/object-property-ptr.h
 create mode 100644 qom/object-property-ptr.c

diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
new file mode 100644
index 0000000000..6066c377fb
--- /dev/null
+++ b/include/qom/object-property-ptr.h
@@ -0,0 +1,103 @@
+/*
+ * Object property helpers to operate on a pointer.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_OBJECT_PROPERTY_PTR_H
+#define QEMU_OBJECT_PROPERTY_PTR_H
+
+typedef enum {
+    /* Automatically add a getter to the property */
+    OBJ_PROP_FLAG_READ = 1 << 0,
+    /* Automatically add a setter to the property */
+    OBJ_PROP_FLAG_WRITE = 1 << 1,
+    /* Automatically add a getter and a setter to the property */
+    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
+} ObjectPropertyFlags;
+
+/**
+ * object_property_add_uint8_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
+                                              const uint8_t *v,
+                                              ObjectPropertyFlags flags);
+
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         const uint8_t *v,
+                                         ObjectPropertyFlags flags);
+
+/**
+ * object_property_add_uint16_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
+                                    const uint16_t *v,
+                                    ObjectPropertyFlags flags);
+
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                          const char *name,
+                                          const uint16_t *v,
+                                          ObjectPropertyFlags flags);
+
+/**
+ * object_property_add_uint32_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
+                                    const uint32_t *v,
+                                    ObjectPropertyFlags flags);
+
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                          const char *name,
+                                          const uint32_t *v,
+                                          ObjectPropertyFlags flags);
+
+/**
+ * object_property_add_uint64_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
+                                    const uint64_t *v,
+                                    ObjectPropertyFlags flags);
+
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                          const char *name,
+                                          const uint64_t *v,
+                                          ObjectPropertyFlags flags);
+
+#endif
diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..6ea569d580 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1931,99 +1931,6 @@ ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
                             void (*get)(Object *, struct tm *, Error **));
 
-typedef enum {
-    /* Automatically add a getter to the property */
-    OBJ_PROP_FLAG_READ = 1 << 0,
-    /* Automatically add a setter to the property */
-    OBJ_PROP_FLAG_WRITE = 1 << 1,
-    /* Automatically add a getter and a setter to the property */
-    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
-} ObjectPropertyFlags;
-
-/**
- * object_property_add_uint8_ptr:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
- *
- * Add an integer property in memory.  This function will add a
- * property of type 'uint8'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
-                                              const uint8_t *v,
-                                              ObjectPropertyFlags flags);
-
-ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
-                                         const char *name,
-                                         const uint8_t *v,
-                                         ObjectPropertyFlags flags);
-
-/**
- * object_property_add_uint16_ptr:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
- *
- * Add an integer property in memory.  This function will add a
- * property of type 'uint16'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v,
-                                    ObjectPropertyFlags flags);
-
-ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
-                                          const char *name,
-                                          const uint16_t *v,
-                                          ObjectPropertyFlags flags);
-
-/**
- * object_property_add_uint32_ptr:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
- *
- * Add an integer property in memory.  This function will add a
- * property of type 'uint32'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v,
-                                    ObjectPropertyFlags flags);
-
-ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
-                                          const char *name,
-                                          const uint32_t *v,
-                                          ObjectPropertyFlags flags);
-
-/**
- * object_property_add_uint64_ptr:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
- *
- * Add an integer property in memory.  This function will add a
- * property of type 'uint64'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v,
-                                    ObjectPropertyFlags flags);
-
-ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
-                                          const char *name,
-                                          const uint64_t *v,
-                                          ObjectPropertyFlags flags);
-
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2141,4 +2048,10 @@ char *object_property_help(const char *name, const char *type,
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
 
+/*
+ * Object property ptr helpers cannot be included at the beginning of the
+ * file, because it depends on QOM definitions in current header.
+ */
+#include "qom/object-property-ptr.h"
+
 #endif
diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
new file mode 100644
index 0000000000..02c01ed7f0
--- /dev/null
+++ b/qom/object-property-ptr.c
@@ -0,0 +1,248 @@
+/*
+ * Object property helpers to operate on a pointer.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qapi/visitor.h"
+
+static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    uint8_t value = *(uint8_t *)opaque;
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    uint8_t *field = opaque;
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint16_t value = *(uint16_t *)opaque;
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint16_t *field = opaque;
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint32_t value = *(uint32_t *)opaque;
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint32_t *field = opaque;
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint64_t value = *(uint64_t *)opaque;
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint64_t *field = opaque;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+ObjectProperty *
+object_property_add_uint8_ptr(Object *obj, const char *name,
+                              const uint8_t *v,
+                              ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint8_ptr;
+    }
+
+    return object_property_add(obj, name, "uint8",
+                               getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    const uint8_t *v,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_property_add_uint16_ptr(Object *obj, const char *name,
+                               const uint16_t *v,
+                               ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint16_ptr;
+    }
+
+    return object_property_add(obj, name, "uint16",
+                               getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+                                     const uint16_t *v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint16_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint16",
+                                     getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_property_add_uint32_ptr(Object *obj, const char *name,
+                               const uint32_t *v,
+                               ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint32_ptr;
+    }
+
+    return object_property_add(obj, name, "uint32",
+                               getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     const uint32_t *v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_property_add_uint64_ptr(Object *obj, const char *name,
+                               const uint64_t *v,
+                               ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint64_ptr;
+    }
+
+    return object_property_add(obj, name, "uint64",
+                               getter, setter, NULL, (void *)v);
+}
+
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+                                     const uint64_t *v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint64_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint64",
+                                     getter, setter, NULL, (void *)v);
+}
diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c..fc738549dc 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2673,246 +2673,6 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t value = *(uint8_t *)opaque;
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t *field = opaque;
-    uint8_t value;
-
-    if (!visit_type_uint8(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t value = *(uint16_t *)opaque;
-    visit_type_uint16(v, name, &value, errp);
-}
-
-static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t *field = opaque;
-    uint16_t value;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t value = *(uint32_t *)opaque;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t *field = opaque;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t value = *(uint64_t *)opaque;
-    visit_type_uint64(v, name, &value, errp);
-}
-
-static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t *field = opaque;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-ObjectProperty *
-object_property_add_uint8_ptr(Object *obj, const char *name,
-                              const uint8_t *v,
-                              ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint8_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint8_ptr;
-    }
-
-    return object_property_add(obj, name, "uint8",
-                               getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                    const uint8_t *v,
-                                    ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint8_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint8_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint8",
-                                     getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_property_add_uint16_ptr(Object *obj, const char *name,
-                               const uint16_t *v,
-                               ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint16_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint16_ptr;
-    }
-
-    return object_property_add(obj, name, "uint16",
-                               getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                     const uint16_t *v,
-                                     ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint16_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint16_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint16",
-                                     getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_property_add_uint32_ptr(Object *obj, const char *name,
-                               const uint32_t *v,
-                               ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint32_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint32_ptr;
-    }
-
-    return object_property_add(obj, name, "uint32",
-                               getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                     const uint32_t *v,
-                                     ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint32_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint32_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint32",
-                                     getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_property_add_uint64_ptr(Object *obj, const char *name,
-                               const uint64_t *v,
-                               ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint64_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint64_ptr;
-    }
-
-    return object_property_add(obj, name, "uint64",
-                               getter, setter, NULL, (void *)v);
-}
-
-ObjectProperty *
-object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                     const uint64_t *v,
-                                     ObjectPropertyFlags flags)
-{
-    ObjectPropertyAccessor *getter = NULL;
-    ObjectPropertyAccessor *setter = NULL;
-
-    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
-        getter = property_get_uint64_ptr;
-    }
-
-    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
-        setter = property_set_uint64_ptr;
-    }
-
-    return object_class_property_add(klass, name, "uint64",
-                                     getter, setter, NULL, (void *)v);
-}
-
 typedef struct {
     Object *target_obj;
     char *target_name;
diff --git a/qom/meson.build b/qom/meson.build
index bd6f4aadd7..2c746aaa9c 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -3,6 +3,7 @@ qom_ss.add(files(
   'container.c',
   'object.c',
   'object_interfaces.c',
+  'object-property-ptr.c',
   'qom-qobject.c',
 ))
 if have_system
-- 
2.53.0


