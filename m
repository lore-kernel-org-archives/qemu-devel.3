Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC94C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONL-00038H-Nj; Mon, 13 Jan 2025 12:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMe-0002Dm-CK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMb-00071m-IK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso52677665e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789791; x=1737394591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9K5rXE6D64Zw+S58ipW/6GTsDDRWIpLeh+hDNnJwfH8=;
 b=pa8XMhZuQryc7Yv0MpNGgdb2FGiLGzIkyls63oDyRSUYyTde5S8o/tzXx0S35/Eup9
 yRtere6zhIWrs3GDXDyBNcr8//Q4Xo1lhDTPr7v6+8RKYqpGMRZkHpDfLBRFucyuupDf
 iijectX/HJ7z5Zv4GmmxLDyoAfcKtlBucu+GoGyrlP32VspuQKOn6QYx7IXIKxTjK/3r
 JeMCpQ8XB6dcPvtdHn3xvLMBNBPpjI9Whnv/DW3KWO1iIzZnrzZYEfsyK6BGpFeYGuIi
 DBBoUwp4p2/hWFf5PF/bkbWu57tGYvkWraNMtkP3gIsdUYkBWS+e147hnjOxWKC7//Ad
 2rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789791; x=1737394591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9K5rXE6D64Zw+S58ipW/6GTsDDRWIpLeh+hDNnJwfH8=;
 b=mHq58KqdFyOP2i+qQj7P+ATMext0QYwcHV7AbSc+dBZzUaakeXy5BT84EM0F0o+F+T
 eUWP3tOccgjo06J/nxbfD2SccYCoPeUeodBBtPwlEITB+vfzexHCB/OtOsAUBwS+Xyim
 IGcqR78PQmBvMiTMntOpfYWqIr5oCDsrOzxAh9apagTWDTeFvZkQ7Sdf7JFjrWaHqfH1
 4YErCooJ178i2+CjMsl3XM8pGfX7BxQCIxg2BEX6kvIXXargL8pKsd84uqqgvhebdcYO
 G+bfQt5imHyJ/9792XHVIvk9E5K1BwJubKukK2jU/uI/+sTOyBnj41AOg8+tqYkpo0wT
 nY8A==
X-Gm-Message-State: AOJu0Yz3LSmKwUUWKahvhCapa8327yNvPYi34fveB2Yinf+RcL9sAXym
 3A5rT+O0V241pkp+UGLBMwYE3YfbczMr+F/w8sHsCv2favyVXc7iVPpMN3NMEwfmtVhmwUlr9E3
 umfs=
X-Gm-Gg: ASbGncstrfkXXliEnCapXhurC9Tj0KqvDdLFKKqlm3LQ7rB927grTQqPfhVuaTW24Z0
 94VFxGlW/R1JFsIKqeM/vM91DzvZ1aLJhEi2Bk6vAOW/cGG1DMbznP6oxqDseKxk/wjP3aBH+sq
 ZwAh3Rtg7Z9AK2490cUgBue3mQwEEdeF9Jm38YE5IuauhrT8suk5M98SifI9aWCzHmzB/6Co5D/
 FbxJ1+7epfigg3XznAR29pzi0Cm456qK3nDTT+t7xLb4auSeksEju70DB1xqDkeb+J9pxyG/vfB
 i3T1V6us4N3ndzObV/Y4NpD5Z/oC5l0=
X-Google-Smtp-Source: AGHT+IFglCJm+RC9BMBQdNoTlgTdPDqruK/UM0Z74DCSW+z1+KuqHRY+QlTZIoH5I4iq99XezX/5+g==
X-Received: by 2002:a05:600c:354e:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-436e269c42dmr223133295e9.10.1736789790784; 
 Mon, 13 Jan 2025 09:36:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc860bsm150457005e9.9.2025.01.13.09.36.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 10/55] hw/qdev: Check qbus_is_hotpluggable in
 hotplug_unplug_allowed_common
Date: Mon, 13 Jan 2025 18:36:02 +0100
Message-ID: <20250113173604.46931-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
[PMD: Split from bigger patch, part 5/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-6-philmd@linaro.org>
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
index 81f747b38fa..e27d25c5859 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -675,11 +675,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
@@ -911,12 +906,6 @@ void qdev_unplug(DeviceState *dev, Error **errp)
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


