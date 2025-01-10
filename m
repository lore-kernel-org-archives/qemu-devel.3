Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629F9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBBB-0007IV-GX; Fri, 10 Jan 2025 04:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBB3-0007Hi-LN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBB1-0007Kb-LV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso825785f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500774; x=1737105574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbWTpaNvctHav635rFcNQUuqidCEawKdhGTCRMBGzHE=;
 b=aVSeDlBPoOI3A6W5SQO72hCOE0jkbLLqBNCcuX6vO20JXolLREwQxR7mhtq6EKcXp0
 cpTv0oIJX7vvS80P3OnSymPqPcGzCLUwsWK855EnA31WvEeMdLPnJY3RJqq9527Khldv
 h+bTpbs8Kp7BysU8y4K5KqG3qXuZ+B4HFtF2Pct2BZgyaeE6hOC3NXVjIfEbqUFujOAN
 UUW9NtdfHdrqI583EET4kW7Bhd8hvnMmEYCb9Bf+Qx6iCX1pGr8ZlITEA0h+zlQtAFob
 S6IymRkYCUuBWeaN+z0UBSYEaMkaksUdJwC6ZyJahBTVFnxC9yO98Vd0BZlUxLAdhAWF
 nAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500774; x=1737105574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbWTpaNvctHav635rFcNQUuqidCEawKdhGTCRMBGzHE=;
 b=te1HObNYj78lh5BBx45X5gR6iFmKdVc32xZDj6PxHI6BOPNc33sKGjv0pipOXW1nOz
 VB4TssoROXqcypAcgAArDV7VIsG1Ovia2dvlz0NoIS3cgf7oGxEYstcuhDrJgCVLLgdV
 qYzvoJjotMYLmP/VfzH9l3NXGK0AR2iodPVbeKswaUl9GMp5SQitQtMj/yltSxEXIYJX
 ob4OonufjpCDzl8CP7NoxrZNRgUpGYCXDjUBc+eQzQRP0UNjpj6sfsrxPebYgKnjuyP2
 xHE+ezviJyoFKob+A9NOhWcCXrsafPMCVDgm5xp97quXcFhIoVDUB3F7BGsjFo1wDWWN
 GPJQ==
X-Gm-Message-State: AOJu0Yzy7mFOhVSWhzqk+sDkWFvxloQxt8mlR4ExbVuoSj7E1jOLwj4u
 gzTFsm1xQTyPo/RkdHm6IH7bL866pvcbVoSn3x8CGprjsI1a4GxUGvNeUtqQBLKQ9HU9zgXQsF+
 1NBY=
X-Gm-Gg: ASbGncsOp8aUwGqSUrrzIwl7qHIff+MVo+qggE/Cyuyi4ssoIbGLQ867FMtf4Flk2sR
 yGocOmfT/OuUA42u5VYt2PtbTqkaom1q3R42zQceROMXICJMvVDxihURbCABSk7caE5i6SwxZJI
 4UlxaLaDtJrO0bwqSncJaHWB7N3u210y/3xDTa4rhJvTOOxdIs+l0BemIubmfy3AdzGYrzdK0B6
 9BUtgKonGJCZFft8kQ8HiCE6rpJVQHLWYwn88ivJiolNiKjtiNCbBHm7BNSvhUFiQRx4KJvYYkZ
 5XHy5d69SUXdbVt57jaqyNqKrDXFe9XDZ7bR
X-Google-Smtp-Source: AGHT+IGb2Ks7Gh7PSjO7dUc7vw+VNFMGC+qqU+e2OvmO+84accXktNRmnKWzgRt3dQz+vgrl8Is5hA==
X-Received: by 2002:a5d:47a6:0:b0:385:f195:2a8 with SMTP id
 ffacd0b85a97d-38a87312734mr9184234f8f.30.1736500773832; 
 Fri, 10 Jan 2025 01:19:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd15766fsm55592855e9.2.2025.01.10.01.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 5/6] hw/qdev: Check qbus_is_hotpluggable in
 hotplug_unplug_allowed_common
Date: Fri, 10 Jan 2025 10:19:07 +0100
Message-ID: <20250110091908.64454-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 hw/core/qdev-hotplug.c |  8 ++++++++
 system/qdev-monitor.c  | 11 -----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 1d77fffb5e0..f6422cd0e4e 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -42,6 +42,14 @@ static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
         return false;
     }
 
+    if (bus) {
+        if (!qbus_is_hotpluggable(bus)) {
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index f28b2e95459..99b638c0aca 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -674,11 +674,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, "Bus '%s' does not support hotplugging", bus->name);
-        return NULL;
-    }
-
     if (migration_is_running()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
@@ -909,12 +904,6 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, "Bus '%s' does not support hotplugging",
-                   dev->parent_bus->name);
-        return;
-    }
-
     if (migration_is_running() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
-- 
2.47.1


