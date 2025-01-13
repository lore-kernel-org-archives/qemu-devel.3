Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76779C02184
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONJ-0002wX-8b; Mon, 13 Jan 2025 12:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMX-00028D-SV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMV-000719-Sb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so33103825e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789786; x=1737394586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzxOnDYWp3ING3ucvnPH2nA5sMkoderjORmFMdUDMqM=;
 b=baseB0KEmVR2sAa+jAs3CZqY71O0eIxuM1n7KoJ2JiVw/Q594U05vhBFPQa4CVZMIg
 X1smN49ewaxQgdhxGByNnlJBldeslW3mHYhTxe/5Cnp5RXu5cmEfTKIMJuMZqur7ybI6
 zAlo0du+nKsk2JPq3/+XYgMlpZHEAfkkqcEZnSaN+Eg+MheYToR60o805Ne8ZYXuiLh/
 jZ/GL30VvUD9M2kNcJzxOgucIfdfdTK+yUtbos/4uzZMOg05OOoq1yeGgwOlAi+8Uah6
 NOn8E7BF0AwJXToyHnxBjCe/z+YHolLN9s0qjx1MLhTG5m9Uq4ruA6LD5K9QGYrnJ2Q2
 vHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789786; x=1737394586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzxOnDYWp3ING3ucvnPH2nA5sMkoderjORmFMdUDMqM=;
 b=KcEqOLA6zXDx1g+B3fI6PR38fXD6xOuFBIDV8OuRlKOvBqlCPPSfaLLv1o2CfakhYu
 F1e3x2sAhp2fzkFD3j+Gqgvj6nk2RVlQdMa/2xTX+oaWP3qWAeRZ3fcLLozM2HYlY7uB
 KPenMzmAcatLceP+l/TrxUg5VkyK3DkrqQ729UxJ3TEUjxNWLk0K5KAokAoQve9u8fAJ
 utbAwxa6o1vCbcZBxGOSRusWP6IxU8e7ua03tdrAu4MKyaSBg5Mnzyx5mXk1kMGvF+Vb
 HUWCqCJpARRCg9Q7Vh83TQTFQYyo1FhGWHixFJC+h3eUEcbBgR3KonPwS0iLz3h3A1T5
 /lmg==
X-Gm-Message-State: AOJu0Yw9JX8pTqH4+WcYnzL/2ZyNrozyVWKDNYhePWF9wdje3U6PhHuQ
 gg0u/c0MxEH23kpSj1Ua3Y0ZRCuLWXlH3FT7MhLesmMxRkEjTpX6aMyvre5DIl/uwmXG0xEXLCy
 PZF0=
X-Gm-Gg: ASbGncuwLv0SmXapE3G4vd11uvRcCiSV9Nt24D9W5Qp8SG6PnuBQx+x4ReTPts8mxo+
 33166w2yl5entFMGBE/DOSkQeU4GKEmm7MrxJd7naaBPE4EqJtp65LzkneDVmMJpo2iU0VyjKkx
 HDMENlXBWZwjLPbOnJtqZsFrfzkxLkMwkwCr7bQyPe9sfP4XeJXtiAgH2MRR45AxbiJTrQCdV6Q
 tT8QbH1CZuPtO7mu2HsbW8/N46Ne2i81GF9RrOHejHKcyHjC7H/aLtc8+sOPrnHcUzSdDJW8gat
 bS2qH+dN0E128T8fdrgYwVufABe5Y2k=
X-Google-Smtp-Source: AGHT+IE/GB6o8EeF/u9O99TCIXv2Ew6YHg+yaA7eY/BgKZewjf+mmHKfmcpHGwEQtjeffiuY38GhRg==
X-Received: by 2002:a05:600c:4ed3:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-436e26dda8cmr175373635e9.23.1736789786163; 
 Mon, 13 Jan 2025 09:36:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89f29sm184467465e9.28.2025.01.13.09.36.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 09/55] hw/qdev: Check DevClass::hotpluggable in
 hotplug_unplug_allowed_common
Date: Mon, 13 Jan 2025 18:36:01 +0100
Message-ID: <20250113173604.46931-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
[PMD: Split from bigger patch, part 4/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-5-philmd@linaro.org>
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
index 511d1aa83c2..81f747b38fa 100644
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
@@ -904,7 +903,6 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     HotplugHandlerClass *hdc;
     Error *local_err = NULL;
@@ -919,12 +917,6 @@ void qdev_unplug(DeviceState *dev, Error **errp)
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


