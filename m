Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4914E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxw-0004Xr-9b; Thu, 19 Dec 2024 03:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxu-0004XS-Tg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxt-00057r-68
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eJZ4T+6hj0lMuTqdhGtKSNhMjurrg/zB/nnKEWfpPg=;
 b=UGmUiQw6d//Xf6E1pnHVS/5wvuk8BPq8dB/8kqI9zpePGAUBF6SM9HgJOlVaskbFROiCkM
 d5oeoTwH7UWkTZbybjVU/ul/cLY6dRGmuQiL1sdnTd/pxDIS8AFbaVK4C4+IUL7ntKTkJa
 kJw9kDo+2glK2w1RYM/9RpQgKijiHOI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-WaZcAmEbNzqdCRnJP4tLsA-1; Thu, 19 Dec 2024 03:32:58 -0500
X-MC-Unique: WaZcAmEbNzqdCRnJP4tLsA-1
X-Mimecast-MFC-AGG-ID: WaZcAmEbNzqdCRnJP4tLsA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so4474205e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597176; x=1735201976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eJZ4T+6hj0lMuTqdhGtKSNhMjurrg/zB/nnKEWfpPg=;
 b=JvczF4Hd/bclzq7rELk8ikmf+7T0uD/IxMN7TWGjQIFiFXr0w4Br3WEHluYkmfBpC7
 JqQLieGRT1oe+ujIJEs+CHYkXdVwnUCxw5XfnkwER4uQaE9/MPRkfkybh+FHyKb4klh+
 CryftaoPGiG/5+q/ftZ2mYhGwTnojrvYbD7294+UnBaouUViTXnq0DROm1e2/r8jwAar
 G14PIZYFtCe25kjXfwkSRoB7+2Ygy05j3GFlv4EZ28T+p9Rtmv+mj67VODsszwjlKhCu
 /YQHCyXkhfyu7Lfr5NUstV3krWfl2H5Mpdn6hieY4JyYRk2ULBqktkbTyFoHOPB3GoCs
 HY3A==
X-Gm-Message-State: AOJu0YxiO9XQbipd2OxHUdACZMEv2+fJko9u5HI3L0ESAuuVYi8LE6/6
 aUWIjrlf/5ymXSWrBJ9KAwOO4G19/a/4Xdpstrbd6dhKL1l8VkmkQ3kHau4CP/Q9GfLi7Ullfws
 YVl0Kobv189hpUigzDGXhRo3QWTWD3BGxgcVxgKmpoP8hVtjQGv03ofMXzFfQF7hDXZoEDZEZ4+
 nUVfyhicERG080Q8o/n8GMaz4jj0IrVnPQCqvg
X-Gm-Gg: ASbGnctFHy9QUiTYCch5Xw2hL9GYPE/ZXOKRoqsOe158/9HZMBdsELz7wkuh7m9GshK
 pcuuGxrj25IA7MmhXkuOdgbaEWP5cJ6vExo/0v8Tfz8+7Stulb/QXgpoQC6dFCdMGWSvXKFof9d
 Hvk87uRZfN9gYLgs/j75gT48xlXnDXqig7zxn7m4dPVeKGLDzbhakESeXZKFotP+imbQzWZZZwE
 fJUWhUluV+o4c4L5b3oSO5NhgpVMezu7yggXd6fYci3vDdOzF5FHUnUra9G
X-Received: by 2002:a05:6000:4a03:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-388e4d2e302mr6064965f8f.1.1734597175820; 
 Thu, 19 Dec 2024 00:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBBCo0NqcOg5OkGNc3CoJKlOjKzVeYTHrpDTvFIrrn6eIggcXdieSsWJY02Or/BPf0raEkfw==
X-Received: by 2002:a05:6000:4a03:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-388e4d2e302mr6064931f8f.1.1734597175388; 
 Thu, 19 Dec 2024 00:32:55 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8bb4bcsm967160f8f.111.2024.12.19.00.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/41] hw/core: Introduce device_class_set_props_n
Date: Thu, 19 Dec 2024 09:32:00 +0100
Message-ID: <20241219083228.363430-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Record the size of the array in DeviceClass.props_count_.
Iterate with known count in qdev_prop_walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-14-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h    | 18 ++++++++++++++++++
 hw/core/qdev-properties.c | 39 +++++++++++++++++++++++++++++----------
 hw/core/qdev.c            |  1 +
 system/qdev-monitor.c     | 15 +++++++--------
 4 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b2859d1e39e..cd0ddf84ca5 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -138,6 +138,12 @@ struct DeviceClass {
      */
     const Property *props_;
 
+    /**
+     * @props_count_: number of elements in @props_; should only be
+     * assigned by using device_class_set_props().
+     */
+    uint16_t props_count_;
+
     /**
      * @user_creatable: Can user instantiate with -device / device_add?
      *
@@ -951,6 +957,18 @@ void device_class_set_props(DeviceClass *dc, const Property *props);
         (device_class_set_props)(DC, PROPS);                            \
     } while (0)
 
+/**
+ * device_class_set_props_n(): add a set of properties to an device
+ * @dc: the parent DeviceClass all devices inherit
+ * @props: an array of properties, not terminated by DEFINE_PROP_END_OF_LIST.
+ * @n: ARRAY_SIZE(@props)
+ *
+ * This will add a set of properties to the object. It will fault if
+ * you attempt to add an existing property defined by a parent class.
+ * To modify an inherited property you need to use????
+ */
+void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
+
 /**
  * device_class_set_parent_realize() - set up for chaining realize fns
  * @dc: The device class
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index de618a964a9..31e3072b559 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -749,16 +749,13 @@ const PropertyInfo qdev_prop_array = {
 
 /* --- public helpers --- */
 
-static const Property *qdev_prop_walk(const Property *props, const char *name)
+static const Property *qdev_prop_walk(DeviceClass *cls, const char *name)
 {
-    if (!props) {
-        return NULL;
-    }
-    while (props->name) {
-        if (strcmp(props->name, name) == 0) {
-            return props;
+    for (int i = 0, n = cls->props_count_; i < n; ++i) {
+        const Property *prop = &cls->props_[i];
+        if (strcmp(prop->name, name) == 0) {
+            return prop;
         }
-        props++;
     }
     return NULL;
 }
@@ -771,7 +768,7 @@ static const Property *qdev_prop_find(DeviceState *dev, const char *name)
     /* device properties */
     class = object_get_class(OBJECT(dev));
     do {
-        prop = qdev_prop_walk(DEVICE_CLASS(class)->props_, name);
+        prop = qdev_prop_walk(DEVICE_CLASS(class), name);
         if (prop) {
             return prop;
         }
@@ -1064,9 +1061,31 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
 void (device_class_set_props)(DeviceClass *dc, const Property *props)
 {
     const Property *prop;
+    size_t n;
 
     dc->props_ = props;
-    for (prop = props; prop && prop->name; prop++) {
+    for (prop = props, n = 0; prop && prop->name; prop++, n++) {
+        qdev_class_add_legacy_property(dc, prop);
+        qdev_class_add_property(dc, prop->name, prop);
+    }
+
+    /* We used a hole in DeviceClass because that's still a lot. */
+    assert(n <= UINT16_MAX);
+    dc->props_count_ = n;
+}
+
+void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
+{
+    /* We used a hole in DeviceClass because that's still a lot. */
+    assert(n <= UINT16_MAX);
+    assert(n != 0);
+
+    dc->props_ = props;
+    dc->props_count_ = n;
+
+    for (size_t i = 0; i < n; ++i) {
+        const Property *prop = &props[i];
+        assert(prop->name);
         qdev_class_add_legacy_property(dc, prop);
         qdev_class_add_property(dc, prop->name, prop);
     }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77c..57c1d9df3a7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -703,6 +703,7 @@ static void device_class_base_init(ObjectClass *class, void *data)
      * so do not propagate them to the subclasses.
      */
     klass->props_ = NULL;
+    klass->props_count_ = 0;
 }
 
 static void device_unparent(Object *obj)
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 03ae6106497..6831fffd9d5 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -752,19 +752,18 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
-static void qdev_print_props(Monitor *mon, DeviceState *dev, const Property *props,
+static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
                              int indent)
 {
-    if (!props)
-        return;
-    for (; props->name; props++) {
+    for (int i = 0, n = dc->props_count_; i < n; ++i) {
+        const Property *prop = &dc->props_[i];
         char *value;
-        char *legacy_name = g_strdup_printf("legacy-%s", props->name);
+        char *legacy_name = g_strdup_printf("legacy-%s", prop->name);
 
         if (object_property_get_type(OBJECT(dev), legacy_name, NULL)) {
             value = object_property_get_str(OBJECT(dev), legacy_name, NULL);
         } else {
-            value = object_property_print(OBJECT(dev), props->name, true,
+            value = object_property_print(OBJECT(dev), prop->name, true,
                                           NULL);
         }
         g_free(legacy_name);
@@ -772,7 +771,7 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, const Property *pro
         if (!value) {
             continue;
         }
-        qdev_printf("%s = %s\n", props->name,
+        qdev_printf("%s = %s\n", prop->name,
                     *value ? value : "<null>");
         g_free(value);
     }
@@ -812,7 +811,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
     }
     class = object_get_class(OBJECT(dev));
     do {
-        qdev_print_props(mon, dev, DEVICE_CLASS(class)->props_, indent);
+        qdev_print_props(mon, dev, DEVICE_CLASS(class), indent);
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
     bus_print_dev(dev->parent_bus, mon, dev, indent);
-- 
2.47.1


