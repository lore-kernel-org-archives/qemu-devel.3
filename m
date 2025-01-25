Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892EDC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfa-0008Au-1G; Sat, 25 Jan 2025 13:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfR-0008AA-KT
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfP-0004DF-G7
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso22053825e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828836; x=1738433636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+D9ecSNssEoyInsTWPhPYbcbkHeV5ELbKuxuFIHXnAU=;
 b=rU78N+B3vpdOV7osTi+XpxaA6bjXEzDEr/je2nB74xXl3TnF5P2XtlZQ4TBO8QFtfA
 31YpqYzjmnGqCCOUhgA61ZoBcx3gX+7lyJ8UptDJx619CySHHOu11bOn3u1HZQkrpJJd
 B0UzOrjJpjVZ3Q+mq5MKJoX7GdTTATLhob5SghfVersmcPGtf+bhmTWGoqWH3U7y7hVh
 sNWcEa2IahFd9HYckNqPt17Peb92NMfvQrLo4NjczElYJwjjJ7EGzX/ZK8RImgyvN/28
 BUs3XsE/f9I4fbQZGcrIxECUj/cc+TAdzkHDNTjtGxQA6Q5uBBmiXFg+aN0BHuJKqcPH
 80hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828836; x=1738433636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+D9ecSNssEoyInsTWPhPYbcbkHeV5ELbKuxuFIHXnAU=;
 b=Y1mR4txbkgbOmJK8NBcfU96JAoB7d9evHLucEPWzWm+hyYnzAiMVujbzqLRpCHO4cX
 DYli3U5dTpRdbIdNga12PnJK+TSixQul3mt75FjAH6f0pxDfxorShzrQO4zQ2xD/Dmoj
 KzUKj8N7k8V6ejn9FdePa5KanEmGwyGzOscrlo5Vp9pr621Nl0a9//ofUjCboEkrvUQz
 6YGiITRy1oite8LEeNXnste1xI5L4JHGVr29DYaHC4xMxWP4vsPnGuUbXqNwrJa07+eF
 LKOu6vWYim8lMDD1sa+HHFz1wyzJ9bX5bcS0tpvsQENA1i+hJSA3BTzW3bXFYvaF8Bm6
 wfUw==
X-Gm-Message-State: AOJu0Ywl7WhmbX9tW3Y14SkmhWzruhTYuOc/Omx8BNj/LDr/sBW0aw+0
 tRMjqLDJmrOPFTqQvtwjPhjs3VQi/8yULOngE42S6dNRNBjX4ykRmWBrELtvTsAcaxtNIcmoMsA
 Adjo=
X-Gm-Gg: ASbGncs1rGCfL5zi8zIrs/ZFzitnw8TuxFGk8xNL4/03VuTMau4JCFR+sp7/LFDUbvu
 ppNmBEWZkw8tNext834lpdMMGCk74RKsw8fDSbOLQTZXCkZrQDPpoBvP2ATbrIFGgBxXst3KV96
 cMTdJ9td6/fbCiqDLda2UxPqcG1m5jArf3c2IF3Xh4eKWuKHgqW1hp4P0+Rf3E2H2QU1ryMAmrX
 AaJlns2pJwApD8Rg09sNsWXdZjERZ0CNECk/ezx4ve8s4bJg6nngtYcV3XlcUmoF6aNYeDFRd23
 R6ddtw3HkuzrOIRTn0BkaYADHa8TBkAyAhk/U9NmDgzBrt7bWYpckRLltH5U
X-Google-Smtp-Source: AGHT+IH3gG9oDbH+Yt++6e9axdywvxazaykwi7sr/Zo0cY2/uHyHOw51lxlnycmePra8xEH0EQ/Sbw==
X-Received: by 2002:a05:600c:3b94:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438913e02f8mr395787785e9.16.1737828836350; 
 Sat, 25 Jan 2025 10:13:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4c75c0sm68201815e9.31.2025.01.25.10.13.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:13:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
Date: Sat, 25 Jan 2025 19:13:36 +0100
Message-ID: <20250125181343.59151-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index f713bbfe04f..306f98406c0 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -80,13 +80,6 @@ static void system_bus_class_init(ObjectClass *klass, void *data)
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
 }
 
-static const TypeInfo system_bus_info = {
-    .name = TYPE_SYSTEM_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(BusState),
-    .class_init = system_bus_class_init,
-};
-
 /* Check whether an IRQ source exists */
 bool sysbus_has_irq(SysBusDevice *dev, int n)
 {
@@ -306,15 +299,6 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
     k->user_creatable = false;
 }
 
-static const TypeInfo sysbus_device_type_info = {
-    .name = TYPE_SYS_BUS_DEVICE,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(SysBusDevice),
-    .abstract = true,
-    .class_size = sizeof(SysBusDeviceClass),
-    .class_init = sysbus_device_class_init,
-};
-
 static BusState *main_system_bus;
 
 static void main_system_bus_create(void)
@@ -337,10 +321,21 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
-static void sysbus_register_types(void)
-{
-    type_register_static(&system_bus_info);
-    type_register_static(&sysbus_device_type_info);
-}
+static const TypeInfo sysbus_types[] = {
+    {
+        .name           = TYPE_SYSTEM_BUS,
+        .parent         = TYPE_BUS,
+        .instance_size  = sizeof(BusState),
+        .class_init     = system_bus_class_init,
+    },
+    {
+        .name           = TYPE_SYS_BUS_DEVICE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(SysBusDevice),
+        .abstract       = true,
+        .class_size     = sizeof(SysBusDeviceClass),
+        .class_init     = sysbus_device_class_init,
+    },
+};
 
-type_init(sysbus_register_types)
+DEFINE_TYPES(sysbus_types)
-- 
2.47.1


