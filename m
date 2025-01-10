Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DE6E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBB6-0007Hw-U3; Fri, 10 Jan 2025 04:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAy-0007HG-Om
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAw-0007K8-Pt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so13149875e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500769; x=1737105569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD0YeZytB7UERXH+U1/WTkP8VblNUjv1vSiXUSIDBr4=;
 b=KrWfHecWM6fwME10tI/1QODDVMLXbrmHi3JhU9nN3fK4ATV16BDUvpebTUCCIXqFRP
 5qpMQiBjG7FG5yhSwErkb7N67DlT6Rbd0SOmsWpfHGWET6+dK+FeqfQ9x8PzTo53HAJr
 jxmE7NF/MI6fCeJBkOjznXhQzXmhTYDRF3F4500sqnajOhcMKZzB5ftkK4VtW994NvCq
 G88a2u4qQgZ81BLAlRVA2z+Df3tNejHm2DSDQu9tjjpHndJxu3LvbsUFpitUPOxlnhtn
 9INikQfyU1Rd2yIVFspI355ivLZnBC7xuXmsU66U7u6VX9FUtJQLoMi7FPI//LJjA+9H
 ftZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500769; x=1737105569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kD0YeZytB7UERXH+U1/WTkP8VblNUjv1vSiXUSIDBr4=;
 b=A6jf47ftnZalpDXmL+plBXDGXAXn9wf7s3+vMrShi3rlkYVIcIbR1+Gh1/pZnqrEd6
 HxMQ48GtWIJXThiloVgjV6N5l6psl95SYAU4pEvpDG5ekF0A4BFDa6slMgQ+MO4CJPIa
 +lLohNY7HdIVPuqza9DMu4POHjK83mR379L70Te7HV7PaDY4dxhRRiCTc+nZzjc/Kg+g
 JaIIBu4bgetxbqVLVtliMu4Rgr2xtu6OI8eYmYu5eQGuKKSg4OGvwgOsegWU1z0dz2pZ
 l0IXJI8ocW19hLT6pj2mYGWUZMuLFZqTtCtSaN8XVIu2M/bSOYWr0D6UjUmlqQaItf+1
 tfIg==
X-Gm-Message-State: AOJu0YypApD9+c6xO+B7mdz65F+kCEgIY6Fs23/hTQ0QpWJdGbfft4lR
 52hOLNfzJK7xPqvgIG+1D27FsxAnmpVe632SszXi+RVqJtxeVm1oixyZ2WqDhZc5pJsug80BTiX
 6hHM=
X-Gm-Gg: ASbGncuo5D7Fr1MLmPl1ClpFWlOb4JP9OAEDmosWu34O2tYLYY2HA0HIQAw+mPbQum4
 mi6vUne96/5tneQ5gYTlz8XK7HhrBh4/3kYBx793D86HGia1JiXprQQd7t1zkLcvsFWoFFXLF3R
 V8Vp5B5K9yUtusJ0COZK9vyX/YwLzrEMz90+0ydnRzT3a3NlGhUPph/QMBTC2HjQ+ZyFpsSCVYr
 wE7AmiN5se2hWjYd/eGaSXg6aF+eoH/EIxnqir2IZ4YDMLBKAxeUJJJE8QBbSu7d2b3UblV8Y4t
 JkDpCzPrBx0w+9Gpm9zJ7aqj9lS2FsIHvbF0
X-Google-Smtp-Source: AGHT+IEWG2C+cIBMaC/KDdpwpFvJBIWizBRY1Fb6pmxUMZ3G9mPNCvA3uDlXIlVwP1eIo61G7AnJYg==
X-Received: by 2002:a05:6000:471c:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38a8730e0b8mr10424243f8f.38.1736500769016; 
 Fri, 10 Jan 2025 01:19:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08eesm81989005e9.10.2025.01.10.01.19.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 4/6] hw/qdev: Check DevClass::hotpluggable in
 hotplug_unplug_allowed_common
Date: Fri, 10 Jan 2025 10:19:06 +0100
Message-ID: <20250110091908.64454-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Check the same code once in the common helper.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-hotplug.c |  9 +++++++++
 system/qdev-monitor.c  | 10 +---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 168d7964740..1d77fffb5e0 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
@@ -33,6 +34,14 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
                                                Error **errp)
 {
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->hotpluggable) {
+        error_setg(errp, "Device '%s' does not support hotplugging",
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
     return true;
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e1c8e847d1f..f28b2e95459 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -263,8 +263,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     }
 
     dc = DEVICE_CLASS(oc);
-    if (!dc->user_creatable ||
-        (phase_check(PHASE_MACHINE_READY) && !dc->hotpluggable)) {
+    if (!dc->user_creatable) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
                    "a pluggable device type");
         return NULL;
@@ -902,7 +901,6 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     HotplugHandlerClass *hdc;
     Error *local_err = NULL;
@@ -917,12 +915,6 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!dc->hotpluggable) {
-        error_setg(errp, "Device '%s' does not support hotplugging",
-                   object_get_typename(OBJECT(dev)));
-        return;
-    }
-
     if (migration_is_running() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
-- 
2.47.1


