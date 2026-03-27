Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C4B10ED663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Be-0006Md-8S; Fri, 27 Mar 2026 07:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bc-0006LI-DU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65BZ-0007WQ-K1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b5bded412so1432102f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610224; x=1775215024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YrZovDto6t0FqJWMN8zdd2dG3ackVIujvm5OvxbxII=;
 b=w+4rZU36cxBSdOuKiyZPG6BP273oRmume/ZPlRiGRLvwJWtEHoOpOv7g/BxdierTbk
 bpMFji5hO6xdXFDtYrcqeMm27SyfnnSec8UfDLW87sFnmY8sBsXkGxwz7beaRU19PJVh
 ISbvki48l3wFm34ADYII8HyAx/W7+0GgNkhIoRbMkJoaCIwoPAenH9gloECf6zPifIii
 p0ouKPjz7Klcpkw9UvCQFWIY3y9QcxAKc+mRdnxIlv/G96zL0+XAmjZIXOMHcxYQ3PVX
 Tuvt+P5ijrFwtRNCPSEnPjCGAzgCugucE1wtSzUh4SGxpr5Q7cwwL4LKfmQ59ySZLRoo
 YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610224; x=1775215024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4YrZovDto6t0FqJWMN8zdd2dG3ackVIujvm5OvxbxII=;
 b=gFGQkQaiiwYXBOb9nVX9TH519i/OHmerECcle/HkRPqwsQNBsXcMpOCMrusGGpS/LI
 ddeI0YuUCMSnbzPBHgXx8kB49htmpwxz34ZiWA2TDBXASo9Hk7QD+jEy8eE5dmxAExDp
 /zqCwbGRPyAwQhU6ctMXuCY91tFUK+tEk1bf/I35zbS5jHp/DQKhecukyr5H8xdY06aY
 TZkuJ53KwNnY4cROWtFv95EfEa2uGfo/zUmbhjSbWAaLStv7oEm6hown063V9G+FcIaP
 LUArrJmux1DwyRmD5iNEPKerkZgMBJoc3Le/+yHnSvBIM3hlHIx/A5vPeS6PjAoWQ/O+
 qW0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxt5kzZpDGEXwAD3ce+j1ExdCsBb1kaSuTCZpd3CbAU2Hw4H/Bd+wLjuFmoUGP5WeojO6kdqLX+SvQ@nongnu.org
X-Gm-Message-State: AOJu0YzmrB6Hg3ahhUplg7+ETpOegzuJBpeGAyPYKSntWYO9a6HNNG+P
 KGHQO+CKZmNHQvbv5bz1ywDtem8vidbRtPnA8k1gtK6Au8mWAgDulJJhpO4dDg65oNg=
X-Gm-Gg: ATEYQzwDSlcRJfbN2k3UkQR7/cCNmLV5hDy/jdrSW7ctyhMPzMABSd6XxLnVqHGD4r/
 RSkGS7iwjsIgmEsYwjeUoc5S2zJq4Yt2iSoMFbjwZU0M5ki55BAPowxcP7D32h6EkUA1HzCh0Qd
 LCCngTndugVVK30f6ria1KQcHmgSXFUXcGnVjCLNZ8MqWo7asGM13vYVKcf+SJZ9J+W/lMeZMiK
 bnxqPNgQZUefU1pnjDkJyTqvN3iT27i1cmdvdZxH/1TToIFJksYSWqNgJkqO7yuL+Ij6765LG9Q
 Vt5aOaJB4Ehjep+OsksTLdf5XbYo0b6RRlXAHGwxeumtH/4TQMDqTS0UavO9Ib96SKjK1ORn2TF
 j4WTdR4yJFhy++ZYa+zjCjILYpGoP11GEQ24nvkd84d0CL7NsmltSeRgAPiecrbGvlX2Qyb4hX0
 UW7L9dZoewoomUcptd5VhxnLsqUsfQHsbX1UsFvizAB726RXJJf/wx3Ur/RheYXBm+Ytf1ZAHE0
 j48ETcFNvmoReYC77i6of8RDDVpNi0=
X-Received: by 2002:a05:6000:22c2:b0:439:b3bb:2777 with SMTP id
 ffacd0b85a97d-43b9e9eb148mr3219353f8f.22.1774610223787; 
 Fri, 27 Mar 2026 04:17:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 02/65] hw/core: Permit devices to define an array of link
 properties
Date: Fri, 27 Mar 2026 11:15:57 +0000
Message-ID: <20260327111700.795099-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Currently we allow devices to define "link properties" with
DEFINE_PROP_LINK(): these are a way to give a device a pointer to
another QOM object.  (Under the hood this is done by handing it the
canonical QOM path for the object.)

We also allow devices to define "array properties" with
DEFINE_PROP_ARRAY(): these are a way to give a device a
variable-length array of properties.

However, there is no way to define an array of link properties.  If
you try to do it by passing qdev_prop_link as the arrayprop argument
to DEFINE_PROP_ARRAY() you will get a crash because qdev_prop_link
does not provide the .set and .get methods in its PropertyInfo
struct.

This patch implements a new DEFINE_PROP_LINK_ARRAY(). In
a device you can use it like this:

struct MyDevice {
    ...
    uint32_t num_cpus;
    ARMCPU **cpus;
}

and in your Property array:
    DEFINE_PROP_LINK_ARRAY("cpus", MyDevice, num_cpus, cpus,
                           TYPE_ARM_CPU, ARMCPU *),

The array property code will fill in s->num_cpus, allocate memory in
s->cpus, and populate it with pointers.

On the device-creation side you set the property in the same way as
the existing array properties, using the new qlist_append_link()
function to append to the QList:

    QList *cpulist = qlist_new();
    for (int i = 0; i < cpus; i++) {
        qlist_append_link(cpulist, OBJECT(cpu[i]));
    }
    qdev_prop_set_array(mydev, "cpus", cpulist);

The implementation is mostly in the provision of the .set and
.get methods to the qdev_prop_link PropertyInfo struct. The
code of these methods parallels the code in
object_set_link_property() and object_get_link_property().  We can't
completely share the code with those functions because of differences
in where we get the information like the target QOM type, but I have
pulled out a new function object_resolve_and_typecheck() for the
shared "given a QOM path and a type, give me the object or an error"
code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-properties.c         | 78 +++++++++++++++++++++++++++++++
 include/hw/core/qdev-properties.h | 41 ++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a4..f8181b0d91 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -669,6 +669,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
          * being inside the device struct.
          */
         .offset = (uintptr_t)elem - (uintptr_t)obj,
+        .link_type = parent_prop->link_type,
     };
 }
 
@@ -950,6 +951,12 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
     qobject_unref(values);
 }
 
+void qlist_append_link(QList *qlist, Object *obj)
+{
+    g_autofree char *path = object_get_canonical_path(obj);
+    qlist_append_str(qlist, path);
+}
+
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
@@ -1059,9 +1066,80 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
                                           OBJ_PROP_LINK_STRONG);
 }
 
+/*
+ * The logic in these get_link() and set_link() functions is similar
+ * to that used for single-element link properties in the
+ * object_get_link_property() and object_set_link_property() functions.
+ * The difference is largely in how we get the expected type of the
+ * link: for us it is in the Property struct, and for a single link
+ * property it is part of the property name on the object.
+ */
+static void get_link(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    const Property *prop = opaque;
+    Object **targetp = object_field_prop_ptr(obj, prop);
+    g_autofree char *path = NULL;
+
+    if (*targetp) {
+        path = object_get_canonical_path(*targetp);
+        visit_type_str(v, name, &path, errp);
+    } else {
+        path = g_strdup("");
+        visit_type_str(v, name, &path, errp);
+    }
+}
+
+static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    const Property *prop = opaque;
+    Object **targetp = object_field_prop_ptr(obj, prop);
+    g_autofree char *path = NULL;
+    Object *new_target, *old_target = *targetp;
+
+    ERRP_GUARD();
+
+    /* Get the path to the object we want to set the link to */
+    if (!visit_type_str(v, name, &path, errp)) {
+        return;
+    }
+
+    /* Now get the pointer to the actual object */
+    if (*path) {
+        new_target = object_resolve_and_typecheck(path, prop->name,
+                                                  prop->link_type, errp);
+        if (!new_target) {
+            return;
+        }
+    } else {
+        new_target = NULL;
+    }
+
+    /*
+     * Our link properties are always OBJ_PROP_LINK_STRONG and
+     * have the allow_set_link_before_realize check.
+     */
+    qdev_prop_allow_set_link_before_realize(obj, prop->name, new_target, errp);
+    if (*errp) {
+        return;
+    }
+
+    *targetp = new_target;
+    object_ref(new_target);
+    object_unref(old_target);
+}
+
 const PropertyInfo qdev_prop_link = {
     .type = "link",
     .create = create_link_property,
+    /*
+     * Since we have a create method, the get and set are used
+     * only in get_prop_array() and set_prop_array() for the case
+     * where we have an array of link properties.
+     */
+    .get = get_link,
+    .set = set_link,
 };
 
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65..58527e62d5 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -168,6 +168,32 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
                 .link_type  = _type)
 
+/**
+ * DEFINE_PROP_LINK_ARRAY:
+ * @_name: name of the array
+ * @_state: name of the device state structure type
+ * @_field: uint32_t field in @_state to hold the array length
+ * @_arrayfield: field in @_state (of type '@_arraytype *') which
+ *               will point to the array
+ * @_linktype: QOM type name of the link type
+ * @_arraytype: C type of the array elements
+ *
+ * Define device properties for a variable-length array _name of links
+ * (i.e. this is the array version of DEFINE_PROP_LINK).
+ *
+ * The array is represented as a list of QStrings in the visitor interface,
+ * where each string is the QOM path of the object to be linked.
+ */
+#define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
+                               _linktype, _arraytype)                   \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                .set_default = true,                                    \
+                .defval.u = 0,                                          \
+                .arrayinfo = &qdev_prop_link,                           \
+                .arrayfieldsize = sizeof(_arraytype),                   \
+                .arrayoffset = offsetof(_state, _arrayfield),           \
+                .link_type = _linktype)
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
@@ -219,6 +245,21 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
+/**
+ * qlist_append_link: Add a QOM object to a QList of link properties
+ * @qlist: list to append to
+ * @obj: object to append
+ *
+ * This is a helper function for constructing a QList to pass to
+ * qdev_prop_set_array() when the qdev property array is an array of
+ * link properties (i.e. one defined with DEFINE_PROP_LINK_ARRAY).
+ *
+ * The object is encoded into the list as a QString which is the
+ * canonical path of the object; this is the same encoding that
+ * object_set_link_property() and object_get_link_property() use.
+ */
+void qlist_append_link(QList *qlist, Object *obj);
+
 void *object_field_prop_ptr(Object *obj, const Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
-- 
2.43.0


