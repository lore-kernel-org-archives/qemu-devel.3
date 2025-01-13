Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A5EC02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONF-0002dL-H5; Mon, 13 Jan 2025 12:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMU-00024A-GP
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMR-0006zw-RQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2319849f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789781; x=1737394581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUfr49xKtxGGKC5FU33V2zWTBLM60pMyiEdF047/1BY=;
 b=LnMn1Xx8JAwsyMCgvRVubEuKzZh4g0GdjSr2vkd0Y72Ob6phP9qeGahaSYFx+WnNWG
 wAqcUoOh+zO6SPh8zoeyiWC06W5HcIblr5rOVbY/2ETSroSRp22ksAUv6bTGYHUYd341
 LXacYgwkgyK8tmIhrFZsv0igM1eDMrCisdneRYB+Xu/73/66MhbH5DkrfFDdfIVQRa9T
 H11z7bLb9LeBLcwLnENGMl6oIcPr63ICYx3g5iMlZkhcDoQojZmDYG4DrW7nMEKzoxKv
 jZc4x1hA9TYvzcrX5GaAI2O/9HLVe0wgeoYxDzOaXfgPoMegBZkRRWHWqK7h+dvzsrw2
 fP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789781; x=1737394581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUfr49xKtxGGKC5FU33V2zWTBLM60pMyiEdF047/1BY=;
 b=CWwffBs24uU+2cDQJq7RI90gCBZGWTvNo65xPsgt4Q5CyVm4BkN1uRnVavJTzqpK8P
 ol+5S8fByIsyKVIDhOZqflV2yTrtYXaipCxdXb8LQXNDCN1lL17tC4VGjx/tRByosTui
 XWrQlvyHd5xbhitXvpzB5/43ZguQSIWrU9J0eW15JNpmWuEHqjsER0rOq/sDV/zMwmoY
 Cgl9pvvysVnseClDpUAQMpWQhzbd3OrmAqz9bLhnLe5i93kV1PdbkSEkrwcaLdZ0K9Fm
 bPyWwyHyLSWvjC3BhQQw5di7B6c/Ip35/4V4WK6jjLUzsVea6+UX5MRNxI3YS0XHkFKL
 iJTQ==
X-Gm-Message-State: AOJu0YyKpKYPW4PpPdTC2HhV5WYHz6SOfMNTzARiofoBU1fsIa00Ud3Q
 Ng58a3Asiro9QYV/kn6QRM1NEaQYYAPbAuHVzBa7aoVtfqZ3skX3CzzJfQUR7Y2z9l6/fs89X4F
 /ckM=
X-Gm-Gg: ASbGncuyu/FPfUxCcVIOWStbYLC5GFQs5m5QFzUUkw8t+Zglp7D95MJ5ji/7b+tejy8
 A+XqW4HFATJgqkXgEByERIwpXDUmVREIoSZQIBmCdRela73reyM3zqMfPfhxRJ4vJ8XtvpPF3Vp
 lBrpv4Gs2YWv8u/x/OJhdm1EpO9ApzWowXSbiszu5/82D+0Ro4xIbwhkzy3JCa6odt9MUjQXnoD
 LO30CsEHQsHe+FIOSiOMScw6ehW4aWO0iKjmRBYbAnAQG0xd9uw814xrVEJQ6U2dki8URHWGfG3
 FX7kn4FcpIECJijRt4xIKtT1vozCW/E=
X-Google-Smtp-Source: AGHT+IH7SrMANo6WXpu9S7c3pf2PFlOGus0yX+aOIAdVptDu3GzyGxD8+C0hQyuH5IGoj+nQ+R71XQ==
X-Received: by 2002:a5d:47c4:0:b0:38a:41f8:8abf with SMTP id
 ffacd0b85a97d-38a87312917mr20841540f8f.31.1736789781410; 
 Mon, 13 Jan 2025 09:36:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c3428sm12430145f8f.87.2025.01.13.09.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 08/55] hw/qdev: Introduce
 qdev_hotplug_unplug_allowed_common()
Date: Mon, 13 Jan 2025 18:36:00 +0100
Message-ID: <20250113173604.46931-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Introduce qdev_hotplug_unplug_allowed_common() to hold
common code between checking hot-plug/unplug is allowed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[PMD: Split from bigger patch, part 3/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-4-philmd@linaro.org>
---
 hw/core/qdev-hotplug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index dc35110e735..168d7964740 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -30,12 +30,22 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
+                                               Error **errp)
+{
+    return true;
+}
+
 bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 {
     MachineState *machine;
     MachineClass *mc;
     Object *m_obj = qdev_get_machine();
 
+    if (!qdev_hotplug_unplug_allowed_common(dev, bus, errp)) {
+        return false;
+    }
+
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
         mc = MACHINE_GET_CLASS(machine);
@@ -49,7 +59,8 @@ bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 
 bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
 {
-    return !qdev_unplug_blocked(dev, errp);
+    return !qdev_unplug_blocked(dev, errp) &&
+           qdev_hotplug_unplug_allowed_common(dev, dev->parent_bus, errp);
 }
 
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
-- 
2.47.1


