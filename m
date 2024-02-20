Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB47C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdg-00029R-Ez; Tue, 20 Feb 2024 11:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdc-00027B-I1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:32 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSda-0005FJ-FP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:32 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512cba0f953so583809e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445188; x=1709049988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddKtqyWJkcgxhf/BG7mdQTStu44ETF+Ta3q791Jg39I=;
 b=i7ki35Gg07AFoxj5eJLneHeWqWUoWsDZJiCRzLkRUH4vVKEiF5MYXkAfSuUzPjhc7B
 S9hPqfn+gUU2LcSQy8RilnMl+poszhMEYeiIgdi7xWS7m/6hOVKRNqPElL/e7eLCAxS7
 HT/KIs7P0/kKi5AtLJdm2He/9gxo37m/0aF5UOjyKCD/8dD0VR0u3ncjSO/yxC7TzHSv
 +N5UTOr3E++V8EmprvcFD5S3fnjc9J5+7Wie2UTDJKxZ14eHkIp9z6yXA06TbKyVh5Hz
 Q/0wldsUqAiUQLtGTyW0rlQo1j2iXr4laY0EMVPyeDjBMZLpY1mbtfmXLXpZv+ItAnGF
 3WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445188; x=1709049988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddKtqyWJkcgxhf/BG7mdQTStu44ETF+Ta3q791Jg39I=;
 b=iUHm+3/nGvNum6QLQd3sJr85kraKvU0x8uUbtYQSLd71qmS+8CXSYy8cyXwzWRyQmB
 85fmc1CJHZfkRmAjfWYgubHPDaFBJGDphhiaASMYRC69M6VMlQMftVybEbaf2EmPN67d
 YyC0IUmongU+3QXhRBqsUpFs5k2y/G/iViEGDIMhtOWZQmMdC2RKcgX7g4X2apyo6lim
 w9UuF3IBLmu8ZyK1p7ZRW4K6/XAi3Bnio+7rLWLD087LZ0zn0iCSSik4i5P+TsUCemCV
 SbV3+BphP0yyzvGnHL7BZCMkNmXM5MP/1vTsMGAXq/2ancmQtNO48wkmXZoMRSoJuHLO
 O/Ng==
X-Gm-Message-State: AOJu0YxtYnFchQN8Bpb8CJQsmPh+d+85mCUK4rELvJ9mdztgU5jDYr8y
 phoAOkrUx11vZKdzdgODClBl4374YNfdIyBGdUzXh4YS+eW+66yOulydmnv93an0/JEHS6H3ApV
 n
X-Google-Smtp-Source: AGHT+IErMCe2fH02jbYeG2pO/xVhKdENQOdZQ8KAKyjjSXf7QXft1BX3kKRnDdY85G4R4Bw6+R286w==
X-Received: by 2002:ac2:446d:0:b0:512:bf09:5ea9 with SMTP id
 y13-20020ac2446d000000b00512bf095ea9mr2607364lfl.63.1708445188220; 
 Tue, 20 Feb 2024 08:06:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Date: Tue, 20 Feb 2024 16:06:18 +0000
Message-Id: <20240220160622.114437-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

Implement a ResetContainer.  This is a subclass of Object, and it
implements the Resettable interface.  The container holds a list of
arbitrary other objects which implement Resettable, and when the
container is reset, all the objects it contains are also reset.

This will allow us to have a 3-phase-reset equivalent of the old
qemu_register_reset() API: we will have a single "simulation reset"
top level ResetContainer, and objects in it are the equivalent of the
old QEMUResetHandler functions.

The qemu_register_reset() API manages its list of callbacks using a
QTAILQ, but here we use a GPtrArray for our list of Resettable
children: we expect the "remove" operation (which will need to do an
iteration through the list) to be fairly uncommon, and we get simpler
code with fewer memory allocations.

Since there is currently no listed owner in MAINTAINERS for the
existing reset-related source files, create a new section for
them, and add these new files there also.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                      | 10 +++++
 include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
 hw/core/resetcontainer.c         | 76 ++++++++++++++++++++++++++++++++
 hw/core/meson.build              |  1 +
 4 files changed, 135 insertions(+)
 create mode 100644 include/hw/core/resetcontainer.h
 create mode 100644 hw/core/resetcontainer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d61fb93194..df8a526905b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3667,6 +3667,16 @@ F: hw/core/clock-vmstate.c
 F: hw/core/qdev-clock.c
 F: docs/devel/clocks.rst
 
+Reset framework
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: include/hw/resettable.h
+F: include/hw/core/resetcontainer.h
+F: include/sysemu/reset.h
+F: hw/core/reset.c
+F: hw/core/resettable.c
+F: hw/core/resetcontainer.c
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
diff --git a/include/hw/core/resetcontainer.h b/include/hw/core/resetcontainer.h
new file mode 100644
index 00000000000..23db0c7a880
--- /dev/null
+++ b/include/hw/core/resetcontainer.h
@@ -0,0 +1,48 @@
+/*
+ * Reset container
+ *
+ * Copyright (c) 2024 Linaro, Ltd
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_RESETCONTAINER_H
+#define HW_RESETCONTAINER_H
+
+/*
+ * The "reset container" is an object which implements the Resettable
+ * interface. It contains a list of arbitrary other objects which also
+ * implement Resettable. Resetting the reset container resets all the
+ * objects in it.
+ */
+
+#include "qom/object.h"
+
+#define TYPE_RESETTABLE_CONTAINER "resettable-container"
+OBJECT_DECLARE_TYPE(ResettableContainer, ResettableContainerClass, RESETTABLE_CONTAINER)
+
+/**
+ * resettable_container_add: Add a resettable object to the container
+ * @rc: container
+ * @obj: object to add to the container
+ *
+ * Add @obj to the ResettableContainer @rc. @obj must implement the
+ * Resettable interface.
+ *
+ * When @rc is reset, it will reset every object that has been added
+ * to it, in the order they were added.
+ */
+void resettable_container_add(ResettableContainer *rc, Object *obj);
+
+/**
+ * resettable_container_remove: Remove an object from the container
+ * @rc: container
+ * @obj: object to remove from the container
+ *
+ * Remove @obj from the ResettableContainer @rc. @obj must have been
+ * previously added to this container.
+ */
+void resettable_container_remove(ResettableContainer *rc, Object *obj);
+
+#endif
diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
new file mode 100644
index 00000000000..cd627f16f0e
--- /dev/null
+++ b/hw/core/resetcontainer.c
@@ -0,0 +1,76 @@
+/*
+ * Reset container
+ *
+ * Copyright (c) 2024 Linaro, Ltd
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * The "reset container" is an object which implements the Resettable
+ * interface. It contains a list of arbitrary other objects which also
+ * implement Resettable. Resetting the reset container resets all the
+ * objects in it.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/resettable.h"
+#include "hw/core/resetcontainer.h"
+
+struct ResettableContainer {
+    Object parent;
+    ResettableState reset_state;
+    GPtrArray *children;
+};
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ResettableContainer, resettable_container, RESETTABLE_CONTAINER, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+
+void resettable_container_add(ResettableContainer *rc, Object *obj)
+{
+    g_ptr_array_add(rc->children, obj);
+}
+
+void resettable_container_remove(ResettableContainer *rc, Object *obj)
+{
+    g_ptr_array_remove(rc->children, obj);
+}
+
+static ResettableState *resettable_container_get_state(Object *obj)
+{
+    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
+    return &rc->reset_state;
+}
+
+static void resettable_container_child_foreach(Object *obj,
+                                               ResettableChildCallback cb,
+                                               void *opaque, ResetType type)
+{
+    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
+    unsigned int len = rc->children->len;
+
+    for (unsigned int i = 0; i < len; i++) {
+        cb(g_ptr_array_index(rc->children, i), opaque, type);
+        /* Detect callbacks trying to unregister themselves */
+        assert(len == rc->children->len);
+    }
+}
+
+static void resettable_container_init(Object *obj)
+{
+    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
+
+    rc->children = g_ptr_array_new();
+}
+
+static void resettable_container_finalize(Object *obj)
+{
+}
+
+static void resettable_container_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->get_state = resettable_container_get_state;
+    rc->child_foreach = resettable_container_child_foreach;
+}
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 67dad04de55..e26f2e088c3 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -4,6 +4,7 @@ hwcore_ss.add(files(
   'qdev-properties.c',
   'qdev.c',
   'reset.c',
+  'resetcontainer.c',
   'resettable.c',
   'vmstate-if.c',
   # irq.c needed for qdev GPIO handling:
-- 
2.34.1


