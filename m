Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857A6C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdf-00028R-AR; Tue, 20 Feb 2024 11:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdd-000282-EB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSda-0005FV-Fp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41272d42297so971095e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445189; x=1709049989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iDhlmBEzf3/xjobdXXs7/XL4KcZXNtIkpWLjY9SBqw=;
 b=nk9txZuTgu3FPyEybvjiLPjw2/+cQ6lI2a4ivr6/bne6iP842lcPDbfFbjERubcptP
 H3ET/Ik6g9wS/JfQiwGF53q79ucLda4728FTH/1ePUjyGJh9dmVic0DwZpA8IsOXTPJy
 px9VZR2jNbwwW7BeOuTUD38wQsLzTLTnWCOeLoVj1Ijwsm+0k+9eBl6k5ZCory6MSPc5
 BlUCJxATNreYYUxOCb8G8PWbnYqEzwTMhMJjV3U7JVoHZDU26jTEqtX4SUG5VgDkMbzD
 uAZFzea+N2tWF4ecqu18I1xzbz6z0bMleUsxNd1OYcTdD6EbJCGwpgvtH4WczW6wZa1L
 9Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445189; x=1709049989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iDhlmBEzf3/xjobdXXs7/XL4KcZXNtIkpWLjY9SBqw=;
 b=hwL7KFY9t5EannQ9slMHQ0J3qiq9PVH7jF90OP6ar3/aNncC0BckyyjJ4oLmd8QkPO
 nWXBpEep8Nk5n+dwFBSKEmAFm+gf2csVKAH4Ck1enw8I0H1vYJTUGbIoyGJ4JB4FbAnk
 w+6CCdUL3BEj6FgSFwi9lviKtZIMymHwTVbBxyXZKFzEQR5MaMnBbn8LtaBqyo31KnXB
 FDFj3OVXkLbP3VpeHCzfAWvyEP9fFSGbJtECM/NZyGDiZbIL1XaOhoXVZ5yrwfGCvGcW
 /qndhawW+flZm5cCtZ1qXaIcvFbnwTIVWalH07eCdOEXDCcQT7dpxWM0C93mwYzeS/b9
 xmYg==
X-Gm-Message-State: AOJu0YyUQC6YI4wEgaRysEpgvyQr+oCNAGcBWzUmYTo2Nzk5b84qu7o6
 sRYn7asVcr0z4hA430rIb/AvZEksi4hOGlp8g+VUhCaGeb8OmZwHRIKPiQyCP7nMYm0T55ffDv0
 4
X-Google-Smtp-Source: AGHT+IFhbp32+urjWmiHk+LhHvhYxqjAeV+S+XjnXe27CZnd9SUUsyGN6hbjafc6lc8LCiOGVIjsaA==
X-Received: by 2002:a05:600c:4746:b0:412:7012:ee14 with SMTP id
 w6-20020a05600c474600b004127012ee14mr1308072wmo.0.1708445188805; 
 Tue, 20 Feb 2024 08:06:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 07/10] hw/core/reset: Add qemu_{register,
 unregister}_resettable()
Date: Tue, 20 Feb 2024 16:06:19 +0000
Message-Id: <20240220160622.114437-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 include/sysemu/reset.h | 37 ++++++++++++++++++++++++++++++++++---
 hw/core/reset.c        | 31 +++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 6aa11846a69..a3de48cb9cf 100644
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
  * for instance device model reset is better accomplished using the
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


