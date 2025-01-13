Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09EBC02185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONF-0002da-JC; Mon, 13 Jan 2025 12:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMT-00023W-Vv
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMO-0006zd-1M
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436249df846so31978425e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789777; x=1737394577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfFTRmuQecjymNg1z1Zlqe+xEmRGvh9kuRZqED+itwE=;
 b=ZOKvLh+JkRlsluoteN1EmHKMLQzwVivrz/7yL6YLeQUSk6RRmvnztPdqb+ZJEb/XA5
 fv5CIi12lvCZJBqmD02g78AN2yiXSXh8vfL9E9ZxgNOl2uLe84OqloymcS2zi4OJZRLi
 46IcbFOtfSWwf3A7VWo6xuzZqFxd5VjqB4TshbzLXW+5e1xVOoUQYKzZ8mMg3y0p/NN/
 gjB7u4lBb45bcJoA+tUJ6J7BWHtbHTivjdqBhsekWNxcVmubw89sgbt7UHYUwhh0xxaG
 +MHpaZOPPsfd1hXz0qswHv7Lg+NijhTXBPRzALX8CYHt4iPf5c+BDDAWRPagpKjebbOf
 4c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789777; x=1737394577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfFTRmuQecjymNg1z1Zlqe+xEmRGvh9kuRZqED+itwE=;
 b=GABy7RcfIUQMEs2bKyieROM5cTssYccyUFtdHAiBRsgYf+rH1CGKzmLstz1EfetiwO
 y84/BSbguZA2b618kgm+EhZ4SMnnA8BzyrGNW4cwcUHJWqZIUNSRYxRFvsNDlH5W2PBw
 VXLSiKiPUNOB0/SDkkAp7HPhYsQUAIh1tzt6WZLkS9StEWrQOM6SndwgQ56ce+pKSqTt
 ogd8XnI1KCPGZgoxKp1wo0WzcdBBRO3tL2/9c7nNZvZAs6x8wtIQ6ShHuibpbhtrAE2M
 66L2bJ9BYNM+paHQ2ObC2KihjlqZ4sj0NbvXqnhSBFiyTD0RZr6aR5EdcXut7D/CmEsK
 0oBw==
X-Gm-Message-State: AOJu0YwHkVyxp3p64ttWV69FaQofpkEUOVJO9oejUnKJovRO3jDtH4s/
 IVo/+bWHwDrraPJm+SRnkeAhOaS2WVQ9zFkCCMjMItI1O5zAJ4PndTaJiMZMFsbLmIPF9hGoyZP
 xMwY=
X-Gm-Gg: ASbGncsjkQOSMroN526NjI6d71us2PoKiD14HFJR08yjG2my9i6d1L2ynt4JHhLcF7L
 8ddWi2K185uiK38yxWS5Jrf5xoWs5b3ZFZbMZO3px/fXvNL7yIlPl8mCILxaZS+DUIGNYOpMg6B
 J4SXSjBL0NiT+IKyBqRa0PTxCk/n8x1Q3r7721qpN3R4wKmkS9y/YxjN0xZ0mjKZs08BnSJs0PL
 u/HmNaVdqC6Y9QfnCbP3MoKTzH3f283nqkDDiyeQJFmxCLkI8fb3T0WCFbOAIu7aLVCOv/zZ/Hm
 rP3jR+exIy1bmfphdPMgr3/KF2o7Q9A=
X-Google-Smtp-Source: AGHT+IHjjQ93CsEmrN6tlZ4KbqY37GVEjUYPtu4C8QT23GOocDKlT3ofNi0aExjH/hxjEFW5Dr+47A==
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-436e26d946cmr167014235e9.21.1736789776632; 
 Mon, 13 Jan 2025 09:36:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81d7sm12730247f8f.73.2025.01.13.09.36.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 07/55] hw/qdev: Factor qdev_hotunplug_allowed() out
Date: Mon, 13 Jan 2025 18:35:59 +0100
Message-ID: <20250113173604.46931-3-philmd@linaro.org>
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

Factor qdev_hotunplug_allowed() out of qdev_unplug().
Start checking the device is not blocked.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[PMD: Split from bigger patch, part 2/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-3-philmd@linaro.org>
---
 include/hw/qdev-core.h | 1 +
 hw/core/qdev-hotplug.c | 5 +++++
 system/qdev-monitor.c  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 930b00fb09a..530f3da7021 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -541,6 +541,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp);
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
 
 /**
  * qdev_get_hotplug_handler() - Get handler responsible for device wiring
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 19fbb11a316..dc35110e735 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -47,6 +47,11 @@ bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
+{
+    return !qdev_unplug_blocked(dev, errp);
+}
+
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 83388dc0c4a..511d1aa83c2 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -909,7 +909,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
-    if (qdev_unplug_blocked(dev, errp)) {
+    if (!qdev_hotunplug_allowed(dev, errp)) {
         return;
     }
 
-- 
2.47.1


