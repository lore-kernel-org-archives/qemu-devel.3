Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5156DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLJ-0002NY-Ej; Wed, 18 Dec 2024 08:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKb-0001L6-60
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:20 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKX-0005gO-HQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:16 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eba7784112so2534797b6e.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529392; x=1735134192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9uuK3Bi0zd4Ff4jmnl20vwDce29dx6gKCtTc6/W2eI=;
 b=nrndXKItF/MXHbV2uQeq8FXyG4BoQE+jFmPd8P9qhdYnHwVSa51MNRWgYJhD0P1AVi
 YF5ypy0uzbI3TQBhkOtEC8JBj265ktgtY2ogM3sGSa1pg59UgO2pIlDWgUGyFuYAEc6O
 bo/9jLxFa99HPUaAT+jG/vJ0HGutzIJce2Sz9PeqecryB60z7Qyrmllo/y0wAPCb6eYb
 M53iV7e+KaCTw0ljW9HiTt993jPwq5vJ5x5VlPiGFY01F55AvugjmMwrR8ViWckuKxvC
 RPx0BlIf+Uoo2nqdhGfJYmTsIwqAZ8HvehkfdhA7pJqI3fzNJy+L6dCACWCfUSUG1BlS
 HsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529392; x=1735134192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9uuK3Bi0zd4Ff4jmnl20vwDce29dx6gKCtTc6/W2eI=;
 b=pgOplSqnIofjsvhEXIs8+7/bAYBGR7Bwgt5+svZz91OOHpppOpXT57/Iuq+MMPwbhD
 XY4YJFgcb0+XmP3YMTy2ujUwgJBNm2Z+QOat6zVrOD88VGkeczbgDu9qYsMnqeIvGgjG
 1l2wn665WVfZMYAS3FfzJ5NoECbtAuvvGUrMKcZekJeza552i3Nwdo3hWdox48gkab/A
 f4g2kU4Lnhb1PPVApShfPQ/mRzL8+djYIEDqJ/IFhGr2G1Sfuy3wlNgGWw5y3TpzyigB
 T2wau1vxBxeTREwr9daR+AHQ4wBjP9qMxfIFbnly+db7HNCwGpVD1wCNfd29ys/Sw90t
 y1mQ==
X-Gm-Message-State: AOJu0Yzs0gV5josniNKyNJXFgD0UvddZH+FE3b+9iWEXyhFfC68TNOxS
 UsGe/BU4qx647Il59/w48hHeYxiGN9wZLt/SW4JJKZYEs2pbuEi3dhYL8a4pgaTNRPfH05NHKQq
 +zx19RLov
X-Gm-Gg: ASbGncvjyKpw/g7NPR89HBnFHNCSeZw4tAn3I3oh71Pm8Tne1t2rJsqkg5J0BvTbSKk
 dzTTNr8vxms9QMjOfLlXAGCLMXMo7Dx1c9hQHXH5koPI4m4rsUnO7HAGSLUISIo7aSNa8XwGv9g
 Fd7WVTBaQYN54ZdGFgf/Ri9M27uHov5mQX9J2lsCMMObSoTiwmbLi46jmnne34O6IINZLpx+WcI
 q8V1a17PtfdTGcfLCPmY1ezCXs3YFXtpli6xJvNY0uwj4VQEHtdmq8uPol6+96x
X-Google-Smtp-Source: AGHT+IGfpXWL8Db16m9vhNyuIoAW+9MKkMNmbqv9I6nACbioUYuBY85DBlSAWS4GQyTwG8TMu4/Dzw==
X-Received: by 2002:a05:6808:1383:b0:3eb:394b:83f5 with SMTP id
 5614622812f47-3eccc0b9fc9mr1598569b6e.16.1734529392181; 
 Wed, 18 Dec 2024 05:43:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 13/24] hw/core: Introduce device_class_set_props_n
Date: Wed, 18 Dec 2024 07:42:40 -0600
Message-ID: <20241218134251.4724-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Record the size of the array in DeviceClass.props_count_.
Iterate with known count in qdev_prop_walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h    | 18 ++++++++++++++++++
 hw/core/qdev-properties.c | 39 +++++++++++++++++++++++++++++----------
 hw/core/qdev.c            |  1 +
 system/qdev-monitor.c     | 15 +++++++--------
 4 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index cbce3cf0b4..e9b4891f55 100644
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
@@ -960,6 +966,18 @@ void device_class_set_props(DeviceClass *dc, const Property *props);
         (device_class_set_props)((dc), (props));                        \
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
index de618a964a..31e3072b55 100644
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
index 5f13111b77..57c1d9df3a 100644
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
index 03ae610649..6831fffd9d 100644
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
2.43.0


