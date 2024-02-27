Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F474C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexau-00013x-Sz; Tue, 27 Feb 2024 08:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaJ-0000jo-QU
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:28 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaH-0002s6-DI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d36736d4eso2665450f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040804; x=1709645604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jxc8/xw8HbL3/iKLwnbteK+6UR1x1Co6Kq8B2A/9ru8=;
 b=j7ePvglteQFwOBPZXaNmDDoG7AqqZl5kZ31zqH0HlsbMe1MD0n9vo0bkk+6kDIU8um
 loexIIaReHIsfj2vvEPoy0oqkhrX4GikS3NUdIqD6/vbbMNDbKDV1llrxrVQ7GmoNxh7
 vMd6S11y4Aome2tvdLpGxgOKJxTMGJQwk7Q+ZR0QB8uLIu1sh9sZEQyEy3XQkEMMkS7+
 wpzWU5ZAAvsETFJ8nnhAPB7C309FrV0+rWXTVO1Fh4ryat7soVbwLFuAe9gG5oouq7CZ
 mgMZ5IXafYHHxkcVv2TLM7I2lGwL7g65BCQM30Nd+L5oQvimZrAGt1iwW9iT7ykN7JVW
 xI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040804; x=1709645604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxc8/xw8HbL3/iKLwnbteK+6UR1x1Co6Kq8B2A/9ru8=;
 b=fJx1aXAZZDbTjenXenQDx7rzjXd9MdfREwjDIOeyykENJeUkqgVxIH6g9bne+I73Oj
 ouTdMnRQwZ1hIYdK6MhWD1ilM4bP7o+Tsry9qvdm3IqOiM/0lEEKqeoEwwqjrY3+hD0i
 CtqjeMyuvIyIpVVz3eOLPRuQi+wi/PmDc5V4kOcNnHKEHq5R5/jcEpcqp7yOp4XfYiFC
 g5zaeOcCqlvalvf9qpNxXL6x/gcTEP90wKtZpQG7kbNIiuZeM4zi8s/z0jvAEXQKYv+B
 TxbkPoYtF+2+N08j+/EqniinSDI/owt/lWTi+s6nhwVHry5YSwzdrxyK4IBAD2Q1fKug
 fKtQ==
X-Gm-Message-State: AOJu0Yz38Zh2ODo6rZ8hJunwsa/66UJuQjLd8l80AOFQcb4LPh8C4IsF
 psCMwcNiT8ukAHKt0/jHd6By8TTuoG+cwFoXFsgA/3SMPIfVdL3qCPH7Y8ToHZHh2zy65bahqHE
 I
X-Google-Smtp-Source: AGHT+IGSUIuAvzhErovmFhVrCQcPWe3guiwZO+LMVvimdHAPyKc4Nbq/EjDKWgrps961B6blFDZ3hA==
X-Received: by 2002:adf:ffcd:0:b0:33d:887c:fe04 with SMTP id
 x13-20020adfffcd000000b0033d887cfe04mr6512152wrs.19.1709040803925; 
 Tue, 27 Feb 2024 05:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/45] include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{,
 _WITH_INTERFACES} macros
Date: Tue, 27 Feb 2024 13:32:43 +0000
Message-Id: <20240227133314.1721857-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We have an OBJECT_DEFINE_TYPE_EXTENDED macro, plus several variations
on it, which emits the boilerplate for the TypeInfo and ensures it is
registered with the type system.  However, all the existing macros
insist that the type being defined has its own FooClass struct, so
they aren't useful for the common case of a simple leaf class which
doesn't have any new methods or any other need for its own class
struct (that is, for the kind of type that OBJECT_DECLARE_SIMPLE_TYPE
declares).

Pull the actual implementation of OBJECT_DEFINE_TYPE_EXTENDED out
into a new DO_OBJECT_DEFINE_TYPE_EXTENDED which parameterizes the
value we use for the class_size field.  This lets us add a new
OBJECT_DEFINE_SIMPLE_TYPE which does the same job as the various
existing OBJECT_DEFINE_*_TYPE_* family macros for this kind of simple
type, and the variant OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES for
when the type will implement some interfaces.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240220160622.114437-5-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/devel/qom.rst   |  34 +++++++++++--
 include/qom/object.h | 114 +++++++++++++++++++++++++++++++++----------
 2 files changed, 117 insertions(+), 31 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 9918fac7f21..0889ca949c1 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -348,12 +348,14 @@ used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
 the 'struct MyDeviceClass' definition.
 
 To implement the type, the OBJECT_DEFINE macro family is available.
-In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
+For the simplest case of a leaf class which doesn't need any of its
+own virtual functions (i.e. which was declared with OBJECT_DECLARE_SIMPLE_TYPE)
+the OBJECT_DEFINE_SIMPLE_TYPE macro is suitable:
 
 .. code-block:: c
    :caption: Defining a simple type
 
-   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DEFINE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
 
 This is equivalent to the following:
 
@@ -370,7 +372,6 @@ This is equivalent to the following:
        .instance_size = sizeof(MyDevice),
        .instance_init = my_device_init,
        .instance_finalize = my_device_finalize,
-       .class_size = sizeof(MyDeviceClass),
        .class_init = my_device_class_init,
    };
 
@@ -385,13 +386,36 @@ This is sufficient to get the type registered with the type
 system, and the three standard methods now need to be implemented
 along with any other logic required for the type.
 
+If the class needs its own virtual methods, or has some other
+per-class state it needs to store in its own class struct,
+then you can use the OBJECT_DEFINE_TYPE macro. This does the
+same thing as OBJECT_DEFINE_SIMPLE_TYPE, but it also sets the
+class_size of the type to the size of the class struct.
+
+.. code-block:: c
+   :caption: Defining a type which needs a class struct
+
+   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+
 If the type needs to implement one or more interfaces, then the
-OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
-This accepts an array of interface type names.
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES() and
+OBJECT_DEFINE_TYPE_WITH_INTERFACES() macros can be used instead.
+These accept an array of interface type names. The difference between
+them is that the former is for simple leaf classes that don't need
+a class struct, and the latter is for when you will be defining
+a class struct.
 
 .. code-block:: c
    :caption: Defining a simple type implementing interfaces
 
+   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(MyDevice, my_device,
+                                             MY_DEVICE, DEVICE,
+                                             { TYPE_USER_CREATABLE },
+                                             { NULL })
+
+.. code-block:: c
+   :caption: Defining a type implementing interfaces
+
    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
                                       MY_DEVICE, DEVICE,
                                       { TYPE_USER_CREATABLE },
diff --git a/include/qom/object.h b/include/qom/object.h
index e9ed9550f05..13d3a655ddf 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -258,6 +258,51 @@ struct Object
     DECLARE_INSTANCE_CHECKER(InstanceType, MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)
 
 
+/**
+ * DO_OBJECT_DEFINE_TYPE_EXTENDED:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ * @ABSTRACT: boolean flag to indicate whether the object can be instantiated
+ * @CLASS_SIZE: size of the type's class
+ * @...: list of initializers for "InterfaceInfo" to declare implemented interfaces
+ *
+ * This is the base macro used to implement all the OBJECT_DEFINE_*
+ * macros. It should never be used directly in a source file.
+ */
+#define DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                       MODULE_OBJ_NAME, \
+                                       PARENT_MODULE_OBJ_NAME, \
+                                       ABSTRACT, CLASS_SIZE, ...) \
+    static void \
+    module_obj_name##_finalize(Object *obj); \
+    static void \
+    module_obj_name##_class_init(ObjectClass *oc, void *data); \
+    static void \
+    module_obj_name##_init(Object *obj); \
+    \
+    static const TypeInfo module_obj_name##_info = { \
+        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
+        .name = TYPE_##MODULE_OBJ_NAME, \
+        .instance_size = sizeof(ModuleObjName), \
+        .instance_align = __alignof__(ModuleObjName), \
+        .instance_init = module_obj_name##_init, \
+        .instance_finalize = module_obj_name##_finalize, \
+        .class_size = CLASS_SIZE, \
+        .class_init = module_obj_name##_class_init, \
+        .abstract = ABSTRACT, \
+        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
+    }; \
+    \
+    static void \
+    module_obj_name##_register_types(void) \
+    { \
+        type_register_static(&module_obj_name##_info); \
+    } \
+    type_init(module_obj_name##_register_types);
+
 /**
  * OBJECT_DEFINE_TYPE_EXTENDED:
  * @ModuleObjName: the object name with initial caps
@@ -284,32 +329,10 @@ struct Object
 #define OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
                                     MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
                                     ABSTRACT, ...) \
-    static void \
-    module_obj_name##_finalize(Object *obj); \
-    static void \
-    module_obj_name##_class_init(ObjectClass *oc, void *data); \
-    static void \
-    module_obj_name##_init(Object *obj); \
-    \
-    static const TypeInfo module_obj_name##_info = { \
-        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
-        .name = TYPE_##MODULE_OBJ_NAME, \
-        .instance_size = sizeof(ModuleObjName), \
-        .instance_align = __alignof__(ModuleObjName), \
-        .instance_init = module_obj_name##_init, \
-        .instance_finalize = module_obj_name##_finalize, \
-        .class_size = sizeof(ModuleObjName##Class), \
-        .class_init = module_obj_name##_class_init, \
-        .abstract = ABSTRACT, \
-        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
-    }; \
-    \
-    static void \
-    module_obj_name##_register_types(void) \
-    { \
-        type_register_static(&module_obj_name##_info); \
-    } \
-    type_init(module_obj_name##_register_types);
+    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
+                                   ABSTRACT, sizeof(ModuleObjName##Class), \
+                                   __VA_ARGS__)
 
 /**
  * OBJECT_DEFINE_TYPE:
@@ -368,6 +391,45 @@ struct Object
                                 MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
                                 true, { NULL })
 
+/**
+ * OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ *
+ * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
+ * the case of a non-abstract type, with interfaces, and with no requirement
+ * for a class struct.
+ */
+#define OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, \
+                                                  module_obj_name, \
+                                                  MODULE_OBJ_NAME, \
+                                                  PARENT_MODULE_OBJ_NAME, ...) \
+    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
+                                   false, 0, __VA_ARGS__)
+
+/**
+ * OBJECT_DEFINE_SIMPLE_TYPE:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ *
+ * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
+ * the common case of a non-abstract type, without any interfaces, and with
+ * no requirement for a class struct. If you declared your type with
+ * OBJECT_DECLARE_SIMPLE_TYPE then this is probably the right choice for
+ * defining it.
+ */
+#define OBJECT_DEFINE_SIMPLE_TYPE(ModuleObjName, module_obj_name, \
+                                  MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME) \
+    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, module_obj_name, \
+        MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, { NULL })
+
 /**
  * struct TypeInfo:
  * @name: The name of the type.
-- 
2.34.1


