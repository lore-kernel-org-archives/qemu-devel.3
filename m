Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCF4C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexad-0000pI-7b; Tue, 27 Feb 2024 08:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaM-0000kJ-Gv
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaI-0002sX-4E
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so2868729f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040805; x=1709645605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EOihe31CmPAbuzzjsksYd8G0LxILYXs9z7dL8tuuTcw=;
 b=bj1XwZEMZsuU7ZcZZAx2EEnJKi/6l950+9o0dCOc8fQrtutRC2d8T6wW0oNoogS+cC
 57Ey2Dhz+Xi9wqQO194CIBfMx7r25QigCLloX0/RJS1CuLu86+q0IEZp+/k3B8km7bLE
 a2FyLOU3Vv4V6FA3r38+Yx4+OJsFuGZ8uMaUwTFxoICg5q57hjvZSERlg0tOiM+4WqJX
 tixrpTsYoOqtCYoFtlkc37HdnfDUssM1pKRoOu38a+uoYDG8hm8Iq5ycAZ2x8Wn3AVtI
 eJe9aJayrd03hBQ83mIWXy+JcO9p5tuPOnF1jhi4t4yODYSd+VhaPGwYeSxHIN9RUxCJ
 vuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040805; x=1709645605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOihe31CmPAbuzzjsksYd8G0LxILYXs9z7dL8tuuTcw=;
 b=vcLFx7ESgzIYOsF4b0kcITN/cWUcKbMBdQpkIXza/boMv6EDdK0DbgMGsd1Nrbxd+9
 cIiZRroGGIJ95MAEUT04BertBHccm1EyAJF6ReqjdG9qqj1tWKhrJdnRqIxupu1CWpLH
 on8dqHdZl0Aq8GT8p8UwLhEU3sE01i22DVvdc2KYJXogn05jMWu2UbAflTnsyvRZD3LI
 rV6SFsxkcwy8s5fY2nvllS4iWYAfp69dICDKBI/S0a41lK5tU0yO+5ZkZB9UVcLxmXci
 PnJyYOaEDpZw/qS7blqo+pm/goHRXWpCN//C5idl40XivoGAhqN04YtrYA/WF/gIfTnw
 jxPg==
X-Gm-Message-State: AOJu0Yz+C036iXPpTOvB4G8irtSae9B6GbmeEGPsVPm1Jt7xzfEAbS1n
 5z1RwQaKhfMs9/LpR3El+Gu7YMpWwceY4t/WcodgeAcRjt33z53Zoj/oGAmxD1iRklirUSeR/3a
 3
X-Google-Smtp-Source: AGHT+IG9CEdwWTqvYj+VU3vaEFctyvjWeOk0CXQ/tMQrqYJMxHkwtEQ2AMpgTSRa6kCR1VP/PsckcA==
X-Received: by 2002:adf:ef87:0:b0:33d:a011:ae42 with SMTP id
 d7-20020adfef87000000b0033da011ae42mr6830316wro.38.1709040804860; 
 Tue, 27 Feb 2024 05:33:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/45] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Date: Tue, 27 Feb 2024 13:32:45 +0000
Message-Id: <20240227133314.1721857-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240220160622.114437-7-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS                      | 10 +++++
 include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
 hw/core/resetcontainer.c         | 77 ++++++++++++++++++++++++++++++++
 hw/core/meson.build              |  1 +
 4 files changed, 136 insertions(+)
 create mode 100644 include/hw/core/resetcontainer.h
 create mode 100644 hw/core/resetcontainer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ca97b627188..65dfdc9677e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3676,6 +3676,16 @@ F: hw/core/clock-vmstate.c
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
index 00000000000..e4ece68e83a
--- /dev/null
+++ b/hw/core/resetcontainer.c
@@ -0,0 +1,77 @@
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
+    INTERFACE_CHECK(void, obj, TYPE_RESETTABLE_INTERFACE);
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


