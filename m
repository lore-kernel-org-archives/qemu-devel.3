Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2327C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdh-00029k-41; Tue, 20 Feb 2024 11:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdf-00028f-Ew
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:35 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdc-0005Fj-8U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:34 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d22fa5c822so37841111fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445189; x=1709049989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfb6LK3pNRRXWdJpN9nL5H3Sn5ptvJuNMXpqXvwtbCQ=;
 b=OBWbDMUqHZ09vRof42SCvr0BYOfBDS8v06Rv4wH7uIlf3bjJDGAR1ne4JkoVvvIKqP
 Po0/nOQcxvS/Pr56UlxW76Q2wBRPQ7z8CTynWZp3zWQdn4LGkbM+G7DqNImbzHdRnD48
 r6ylyJjuhryh+ZnUNpYNRA2IvURFMGUzS3rIV+kHScgDNFfmshoT5Qj6J/yE92zGVXZO
 cYaagk7xbzgVocqsYGA4gZQTRkdYboGBXQ8KC7v+xC5Im+04rsgb1bbe0eYjv/Szdd1j
 4Y4bIiH6KE7ro8bWZTi8BepCabXJ7UY2lyxWgHOMZqYcH3JCPHhvrPPL7Mf0eAW6Q/kB
 CIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445189; x=1709049989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfb6LK3pNRRXWdJpN9nL5H3Sn5ptvJuNMXpqXvwtbCQ=;
 b=QMd1+pLksUvMkYOGnwB97zzuvz4YRLS+hW5KnBaB0lhkXRK358V1zAGQMY+dweKeJ3
 FxWFP4Mkp0vdbNdIs+zCsUWCiOTeKg+I00lp7tuCE1fd71rp6AMPEbTF4r10B8hzFs5h
 9q0vtHBo/GNlXPHTKhpoSNrVVWaZzrNXIKQhXnxfVY1LiDAZa/ST2d6zEvYCFzCEEK6K
 cMoijwdSP4C6bqqBBDGfbhLLOi4F0NHQO0cyjTj5jw9VQ7Ad+6kyVS0+pbArJTKWiK7b
 rypksySz6IagqzC6VzDNSoej7WB43WwzspO8dMDVQLP5qZv/0vT/zd/y1l1W/axVS41h
 GNuA==
X-Gm-Message-State: AOJu0YzHuqEXmnzw/2f7hIKYnQfDE5r9qgjq0eSDPQne4Lln+8t5EjDl
 xJyzjtwRRycuQawNPbHF0fq7vTsLJytGSUPCR1MJSSoXZkrgSo1C615kj2F9ktPdfpvPE2meTNM
 E
X-Google-Smtp-Source: AGHT+IHLbyca7SNk5UfhFX0gGCZagNHJL8z+9i5Mr/w55acm6ld04jsNt29vr1rAHd9ufySAtJjr2Q==
X-Received: by 2002:a05:6512:3a83:b0:512:b04a:aa56 with SMTP id
 q3-20020a0565123a8300b00512b04aaa56mr7055557lfu.24.1708445189424; 
 Tue, 20 Feb 2024 08:06:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 08/10] hw/core/reset: Implement qemu_register_reset via
 qemu_register_resettable
Date: Tue, 20 Feb 2024 16:06:20 +0000
Message-Id: <20240220160622.114437-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

Reimplement qemu_register_reset() via qemu_register_resettable().

We define a new LegacyReset object which implements Resettable and
defines its reset hold phase method to call a QEMUResetHandler
function.  When qemu_register_reset() is called, we create a new
LegacyReset object and add it to the simulation_reset
ResettableContainer.  When qemu_unregister_reset() is called, we find
the LegacyReset object in the container and remove it.

This implementation of qemu_unregister_reset() means we'll end up
scanning the ResetContainer's list of child objects twice, once
to find the LegacyReset object, and once in g_ptr_array_remove().
In theory we could avoid this by having the ResettableContainer
interface include a resettable_container_remove_with_equal_func()
that took a callback method so that we could use
g_ptr_array_find_with_equal_func() and g_ptr_array_remove_index().
But we don't expect qemu_unregister_reset() to be called frequently
or in hot paths, and we expect the simulation_reset container to
usually not have many children.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The way that a legacy reset function needs to check the ShutdownCause
and this doesn't line up with the ResetType is a bit awkward; this
is an area we should come back and clean up, but I didn't want to
tackle that in this patchset.
---
 include/sysemu/reset.h |   7 ++-
 hw/core/reset.c        | 137 +++++++++++++++++++++++++++++++----------
 2 files changed, 110 insertions(+), 34 deletions(-)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index a3de48cb9cf..ada4527e67e 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -67,8 +67,11 @@ void qemu_unregister_resettable(Object *obj);
  * @opaque: opaque data to pass to @func
  *
  * Register @func on the list of functions which are called when the
- * entire system is reset. The functions are called in the order in
- * which they are registered.
+ * entire system is reset. Functions registered with this API and
+ * Resettable objects registered with qemu_register_resettable() are
+ * handled together, in the order in which they were registered.
+ * Functions registered with this API are called in the 'hold' phase
+ * of the 3-phase reset.
  *
  * In general this function should not be used in new code where possible;
  * for instance device model reset is better accomplished using the
diff --git a/hw/core/reset.c b/hw/core/reset.c
index a9b30e705fe..d50da7e3041 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/queue.h"
 #include "sysemu/reset.h"
 #include "hw/resettable.h"
 #include "hw/core/resetcontainer.h"
@@ -44,45 +43,128 @@ static ResettableContainer *get_root_reset_container(void)
     return root_reset_container;
 }
 
-typedef struct QEMUResetEntry {
-    QTAILQ_ENTRY(QEMUResetEntry) entry;
+/*
+ * Reason why the currently in-progress qemu_devices_reset() was called.
+ * If we made at least SHUTDOWN_CAUSE_SNAPSHOT_LOAD have a corresponding
+ * ResetType we could perhaps avoid the need for this global.
+ */
+static ShutdownCause device_reset_reason;
+
+/*
+ * This is an Object which implements Resettable simply to call the
+ * callback function in the hold phase.
+ */
+#define TYPE_LEGACY_RESET "legacy-reset"
+OBJECT_DECLARE_SIMPLE_TYPE(LegacyReset, LEGACY_RESET)
+
+struct LegacyReset {
+    Object parent;
+    ResettableState reset_state;
     QEMUResetHandler *func;
     void *opaque;
     bool skip_on_snapshot_load;
-} QEMUResetEntry;
+};
 
-static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
-    QTAILQ_HEAD_INITIALIZER(reset_handlers);
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(LegacyReset, legacy_reset, LEGACY_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+
+static ResettableState *legacy_reset_get_state(Object *obj)
+{
+    LegacyReset *lr = LEGACY_RESET(obj);
+    return &lr->reset_state;
+}
+
+static void legacy_reset_hold(Object *obj)
+{
+    LegacyReset *lr = LEGACY_RESET(obj);
+
+    if (device_reset_reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
+        lr->skip_on_snapshot_load) {
+        return;
+    }
+    lr->func(lr->opaque);
+}
+
+static void legacy_reset_init(Object *obj)
+{
+}
+
+static void legacy_reset_finalize(Object *obj)
+{
+}
+
+static void legacy_reset_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->get_state = legacy_reset_get_state;
+    rc->phases.hold = legacy_reset_hold;
+}
 
 void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
+    Object *obj = object_new(TYPE_LEGACY_RESET);
+    LegacyReset *lr = LEGACY_RESET(obj);
 
-    re->func = func;
-    re->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+    lr->func = func;
+    lr->opaque = opaque;
+    qemu_register_resettable(obj);
 }
 
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
+    Object *obj = object_new(TYPE_LEGACY_RESET);
+    LegacyReset *lr = LEGACY_RESET(obj);
 
-    re->func = func;
-    re->opaque = opaque;
-    re->skip_on_snapshot_load = true;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+    lr->func = func;
+    lr->opaque = opaque;
+    lr->skip_on_snapshot_load = true;
+    qemu_register_resettable(obj);
+}
+
+typedef struct FindLegacyInfo {
+    QEMUResetHandler *func;
+    void *opaque;
+    LegacyReset *lr;
+} FindLegacyInfo;
+
+static void find_legacy_reset_cb(Object *obj, void *opaque, ResetType type)
+{
+    LegacyReset *lr;
+    FindLegacyInfo *fli = opaque;
+
+    /* Not everything in the ResettableContainer will be a LegacyReset */
+    lr = LEGACY_RESET(object_dynamic_cast(obj, TYPE_LEGACY_RESET));
+    if (lr && lr->func == fli->func && lr->opaque == fli->opaque) {
+        fli->lr = lr;
+    }
+}
+
+static LegacyReset *find_legacy_reset(QEMUResetHandler *func, void *opaque)
+{
+    /*
+     * Find the LegacyReset with the specified func and opaque,
+     * by getting the ResettableContainer to call our callback for
+     * every item in it.
+     */
+    ResettableContainer *rootcon = get_root_reset_container();
+    ResettableClass *rc = RESETTABLE_GET_CLASS(rootcon);
+    FindLegacyInfo fli;
+
+    fli.func = func;
+    fli.opaque = opaque;
+    fli.lr = NULL;
+    rc->child_foreach(OBJECT(rootcon), find_legacy_reset_cb,
+                      &fli, RESET_TYPE_COLD);
+    return fli.lr;
 }
 
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re;
+    Object *obj = OBJECT(find_legacy_reset(func, opaque));
 
-    QTAILQ_FOREACH(re, &reset_handlers, entry) {
-        if (re->func == func && re->opaque == opaque) {
-            QTAILQ_REMOVE(&reset_handlers, re, entry);
-            g_free(re);
-            return;
-        }
+    if (obj) {
+        qemu_unregister_resettable(obj);
+        object_unref(obj);
     }
 }
 
@@ -98,16 +180,7 @@ void qemu_unregister_resettable(Object *obj)
 
 void qemu_devices_reset(ShutdownCause reason)
 {
-    QEMUResetEntry *re, *nre;
-
-    /* reset all devices */
-    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
-        if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
-            re->skip_on_snapshot_load) {
-            continue;
-        }
-        re->func(re->opaque);
-    }
+    device_reset_reason = reason;
 
     /* Reset the simulation */
     resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD);
-- 
2.34.1


