Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9782C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexas-0000z0-2z; Tue, 27 Feb 2024 08:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaM-0000kK-HX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaI-0002se-L7
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:28 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d9c3f36c2so2335310f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040805; x=1709645605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ilSh+qPOLb6HK3mUSSVYVVmXM5u7PDBEkPrdcgdTkNQ=;
 b=Ww+SsUrwP7Pjwc0E6rL0ieuKhQPMlKsgoe6+jGglfmoZMEUWPJ3JUrSslvCcapAaIp
 0JOWYJ77XOiMmzK6od/CXvVlaiorUdIuWMOMuQBsROS4F8FQAUNTafUDT2U7l79gxBqm
 naR8F+6ZZaM9rzaytgk8OjzGr/QtbIr8MRwmm+3FioBBlyNEN3TXsFbzxmjcDeqMzfm3
 KMNjmjdPK3MtWC2hLqUKwQv8TnuIabRdnCSWdd5iXLQZRr/glsS1LfznydJIYt9GmA3i
 XTLar/l4x0zrIQ6gyT75HIRVXYsfamPTdy1KiTIv4+8xTzh9sr0BhyurnmeHvdUz6lJI
 RJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040805; x=1709645605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilSh+qPOLb6HK3mUSSVYVVmXM5u7PDBEkPrdcgdTkNQ=;
 b=Y49xTqRrt2jznjInu+Et3vnpYsZ1AuSpal2KsRQHZE61qXR9PzUIMaB8cQ9sgKXjSd
 bhaIWi+kTI0LhCA0YDgnkGJZEUMooMpwB3TB0WSAxsKssaUNl26kciPevAYvth2jdNEt
 RBg3c+qxKc4mfltB9BUTxCgjRUCLW1WlxhWwEGOUU2/zloHOEecdHAxpM1V/+u3MIEAt
 dSx8veKBWIGI7QN2PAeUrIByM+PTePHboaT6amVqvbAcNC6p2rmskzl7NNvGVCTe8C/M
 HiiwHV4+4qbBSVNkSxNiGWHEOhTF9eqEn1xX2xcJnqT9RIx9Wo45EhlRXRwdS0XDbuXd
 or5g==
X-Gm-Message-State: AOJu0YwGSoONjtij97ZHp2QaxXGzIoKyLsR/3wjXpIpBPiVwubPW6LEZ
 +BVJT8cVSnf2lkii+YOFAx2kogkFGHB036O2aa4PbUHv9gDavxtrOTOXrA/4iXhbby/N07Ybfpl
 I
X-Google-Smtp-Source: AGHT+IHAh5DAqaVp8a9vmWGvHvwv5wloT0qFUm1D+8vdiXBK9NmXzLjdQvVB5lmv2IcrXBCVilaKmQ==
X-Received: by 2002:a5d:6e01:0:b0:33d:19fc:c4e9 with SMTP id
 h1-20020a5d6e01000000b0033d19fcc4e9mr6964005wrz.50.1709040805272; 
 Tue, 27 Feb 2024 05:33:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/45] hw/core/reset: Add qemu_{register,
 unregister}_resettable()
Date: Tue, 27 Feb 2024 13:32:46 +0000
Message-Id: <20240227133314.1721857-18-peter.maydell@linaro.org>
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

Implement new functions qemu_register_resettable() and
qemu_unregister_resettable().  These are intended to be
three-phase-reset aware equivalents of the old qemu_register_reset()
and qemu_unregister_reset().  Instead of passing in a function
pointer and opaque, you register any QOM object that implements the
Resettable interface.

The implementation is simple: we have a single global instance of a
ResettableContainer, which we reset in qemu_devices_reset(), and
the Resettable objects passed to qemu_register_resettable() are
added to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240220160622.114437-8-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/sysemu/reset.h | 37 ++++++++++++++++++++++++++++++++++---
 hw/core/reset.c        | 31 +++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 658a7e091e6..ef2c595e296 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -31,6 +31,36 @@
 
 typedef void QEMUResetHandler(void *opaque);
 
+/**
+ * qemu_register_resettable: Register an object to be reset
+ * @obj: object to be reset: it must implement the Resettable interface
+ *
+ * Register @obj on the list of objects which will be reset when the
+ * simulation is reset. These objects will be reset in the order
+ * they were added, using the three-phase Resettable protocol,
+ * so first all objects go through the enter phase, then all objects
+ * go through the hold phase, and then finally all go through the
+ * exit phase.
+ *
+ * It is not permitted to register or unregister reset functions or
+ * resettable objects from within any of the reset phase methods of @obj.
+ *
+ * We assume that the caller holds the BQL.
+ */
+void qemu_register_resettable(Object *obj);
+
+/**
+ * qemu_unregister_resettable: Unregister an object to be reset
+ * @obj: object to unregister
+ *
+ * Remove @obj from the list of objects which are reset when the
+ * simulation is reset. It must have been previously added to
+ * the list via qemu_register_resettable().
+ *
+ * We assume that the caller holds the BQL.
+ */
+void qemu_unregister_resettable(Object *obj);
+
 /**
  * qemu_register_reset: Register a callback for system reset
  * @func: function to call
@@ -44,8 +74,8 @@ typedef void QEMUResetHandler(void *opaque);
  * for instance, device model reset is better accomplished using the
  * methods on DeviceState.
  *
- * It is not permitted to register or unregister reset functions from
- * within the @func callback.
+ * It is not permitted to register or unregister reset functions or
+ * resettable objects from within the @func callback.
  *
  * We assume that the caller holds the BQL.
  */
@@ -81,7 +111,8 @@ void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
  *
  * This function performs the low-level work needed to do a complete reset
  * of the system (calling all the callbacks registered with
- * qemu_register_reset()). It should only be called by the code in a
+ * qemu_register_reset() and resetting all the Resettable objects registered
+ * with qemu_register_resettable()). It should only be called by the code in a
  * MachineClass reset method.
  *
  * If you want to trigger a system reset from, for instance, a device
diff --git a/hw/core/reset.c b/hw/core/reset.c
index d3263b613e6..a9b30e705fe 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -26,8 +26,23 @@
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
 #include "sysemu/reset.h"
+#include "hw/resettable.h"
+#include "hw/core/resetcontainer.h"
 
-/* reset/shutdown handler */
+/*
+ * Return a pointer to the singleton container that holds all the Resettable
+ * items that will be reset when qemu_devices_reset() is called.
+ */
+static ResettableContainer *get_root_reset_container(void)
+{
+    static ResettableContainer *root_reset_container;
+
+    if (!root_reset_container) {
+        root_reset_container =
+            RESETTABLE_CONTAINER(object_new(TYPE_RESETTABLE_CONTAINER));
+    }
+    return root_reset_container;
+}
 
 typedef struct QEMUResetEntry {
     QTAILQ_ENTRY(QEMUResetEntry) entry;
@@ -71,6 +86,16 @@ void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
     }
 }
 
+void qemu_register_resettable(Object *obj)
+{
+    resettable_container_add(get_root_reset_container(), obj);
+}
+
+void qemu_unregister_resettable(Object *obj)
+{
+    resettable_container_remove(get_root_reset_container(), obj);
+}
+
 void qemu_devices_reset(ShutdownCause reason)
 {
     QEMUResetEntry *re, *nre;
@@ -83,5 +108,7 @@ void qemu_devices_reset(ShutdownCause reason)
         }
         re->func(re->opaque);
     }
-}
 
+    /* Reset the simulation */
+    resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD);
+}
-- 
2.34.1


