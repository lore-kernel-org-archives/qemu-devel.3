Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50A9E77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN292-0007Kf-2L; Sun, 15 Dec 2024 22:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN290-0007Jk-5T
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:42 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28y-00060C-GY
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:41 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e36b27b53so1787939a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321099; x=1734925899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tv/4qR29usp6prVX1l510S+9RnhSqicniDiLQuXiAoI=;
 b=BjNoVjvQAlGFlU8Q/9UcvL3rr6Pk93qpHfIKKKpmFfDoOSUBYRM7egn1tm2nMZGz/G
 G6y4P4cVblRhzKGkiWCvdj/ESNTJK7k7iBxZT3y16siFva/CnTMfSzkB+MGeG7xXEDQI
 YTalEg25j7McuiTrYa/vflum95EpuDGKjLT54NyEy4bgYdh3fIiTCKAC8f2WX0A+mgf1
 SolStkJ316gyjTLq85tiDoethcvJOjBwdotKsTYvEQ3bgHvlop0HBw+erKW1PqSfsx1t
 xdofGPl7h/nUtN4XSa0tcI6NZor7aJ8ceVaopXLSBlU9iU9piQZ8dMG7/P0CQKncZ4X2
 IOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321099; x=1734925899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tv/4qR29usp6prVX1l510S+9RnhSqicniDiLQuXiAoI=;
 b=atlfoHQd+fUkzKL9nSlxfzo3YfSxuf1A8UbrWYrMi81FP0BXx+9UwZWfVbckKqQ1Cs
 sGQhbzmie9I4ddpaeLMNWQ/ZJGkj0q3B/JUBb3oZ+k/8c72T6rk669SB9+G9l04Bf2GE
 lmGlyHHsGgFBCmei3+BfXC82phoQ/0PRhnSJjOmoBy2JR8oP84F4lOs0g7wN5dm2gq3v
 NJqXl6sGwjhIk+pnkkNwuTtMwtxWyd5AAuMJToWhpsHN3BrwHiQnCL0wXBDojvtfE0uy
 RioxiJzWwE/OcQ1b7d5WvQIcADob90hKZgSu2uzxvCsi6k9CercFQ/dU2H/vHvGIixD1
 43dQ==
X-Gm-Message-State: AOJu0Yy6R1YpQkteN3WUXRCZKZT5CgBm8aNgGLQ+kF8hzBkOQXsYiYQg
 2bNv4zSAlia2aA1eb/hLueqUvN6Kfk7x8QTEVLIOPI+TsQGNPFGNJVFZ0kxdwP4+3EvKCdcPOoN
 d1iKKtAHX
X-Gm-Gg: ASbGncsuxQdeNK3Icz6yh4Ok2l6ApkmwuvPAVgeHEsY1/UZ93nodY5tzpzAyRwrfDKI
 emxee+opTk0V1o8I9rTb2NB8FYxOg8ILEMtEefcpQRs9+umb3mRZcgDwwKjSGkXMIOPYnlx0CBc
 BeJIOPJMI1x2gi8PNksu3HU8rTfvRru/WRBd1IzzXXok1QVQT0PDhQGW5g+UHOoZICl+qetUluh
 2RFSowy8ca4sgJKGqjFt5rse3tTF1CNgZ/2efEVqrFqPVhzsm9EwS9D/82o+kRVaYx3Hnfa4zgg
 we3QHp6F9mefxchx4iYDeUGLu94wjYgWoAhI/B8PguU=
X-Google-Smtp-Source: AGHT+IF0eNiuIrsmkt2Gi6kH86DMjOSISwpvqC77IA32WA5CHHBWNV9i2obSQtWkPNznFJd1ZK9/9A==
X-Received: by 2002:a05:6830:6e09:b0:71d:eb02:baed with SMTP id
 46e09a7af769-71e3b8576b6mr6642515a34.8.1734321099478; 
 Sun, 15 Dec 2024 19:51:39 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/24] hw/core: Introduce device_class_set_props_n
Date: Sun, 15 Dec 2024 21:50:58 -0600
Message-ID: <20241216035109.3486070-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
index b2859d1e39..cd0ddf84ca 100644
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


