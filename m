Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A09E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaL-00045c-KT; Thu, 02 Jan 2025 16:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaK-000459-4J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaI-0001PX-8g
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso77461515e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852704; x=1736457504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIbguNzGlLeMSVI5iz/yTsatznjZcvdQ/dAtnbN8W3c=;
 b=KIWFU74kUx1auKAcj/h6v6VX/DhOumxduc+oBqgMqngumvijiytEr8L2ZL30Niq35+
 7bMRCsZQbgQa1pifoLZBjY4ZOSI5Tr+s3y8gg2xZUlw8wari7lO85ioHUjrpOkW8+LxB
 BUTIXPY5jmCHAe/3amYhz+5ZPMi9lYc1Y9O8DpZLTZGEaSCtfuSV9+nTnrqI97Pon5Xm
 E9E+SRwzqvqSWbZmt4j61sMkHSXl2x7k/UGVeS+9PjQhN2XGo1hfFEUIR8NGiVOP3ZWc
 Y0s+5U4RFMX1XAXlEiOIJPeq8f0f6zvTNsaVrkTz90FYYVSgFjH8OE5Ni7ns8dH+AOoc
 +t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852704; x=1736457504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIbguNzGlLeMSVI5iz/yTsatznjZcvdQ/dAtnbN8W3c=;
 b=UJ92PMLFxtvRkBOx1bp22e3p9vWzVpazpjbRZBPHK1Qy9qO2u+vIn3Ohz89p4yCiy9
 2TDghHkfyaWC1QwzCnOCfvuwvuqwWzT041mqkpoEEbuaQ/c4RvyBimGRNA3VCkc+kDuC
 iHHiuLoECjYW3CHCRvxQfA2ea3wKiuGKznyA2X65+OHdk2r87DlgsSo7WkZzPW2sWKMp
 yG5mIrxbatdqV9RcVa3UAm6V00i+/niBx9+WLKuCDJrQpv+JcVNPyYX6sm8ul9SAOJ/c
 YMAHIct/qhD8KA/mLHZWsrCSl926p7jFgv1ZIJaCtajAzU0rjWEj22CeYjVfStAQU0zl
 7yoA==
X-Gm-Message-State: AOJu0YxKNRqvcM7HKCRv8A9MS4EWkJHfV1AKG7ULf7lBiB3oxj77Ucu5
 bJGKPS8Q5TOjse2XZCehJOzxfg+Yc6o1GqBAdgul5K5PrtU3GiZWQ3KTkqhgJa9ODPD84MP5UVl
 e35YfAQ==
X-Gm-Gg: ASbGncuH3gVYXy6yGgvMQTwrNBj8rJRMnodjLjddOQe6RJF59o9ryzwZh2gfeAv5azb
 uVpAatIRYomPWSIXpW1DTK++qQQaYABhUDg5mQmA2lsXjXYludxKK5dUeNrHOlXUxkqwkXfkzli
 eXoGw1n6NZS3tgfg8QfvsMVSO4wint5vOjh4glr0WHoCTFLCjxmYugCD+nsyBi5HpH8A2L6r+vH
 O4ZtKPv6shCaJsKValZzgmW1Hi8Y3sCW+N+wS9EW01viIl5dy2o3sI6dvKcrJVzFwjLXjl/DgWi
 Dws3ONTTv343mKDjCSLw0/nwkQd03zg=
X-Google-Smtp-Source: AGHT+IFdU+AKQGMhxuE/mm/2/UPcTBOoY/qUZrm5EoNC5Agaz5NHMksitRvlIexe0sgQS0AuRIFBBg==
X-Received: by 2002:a05:600c:1f85:b0:434:f2f4:4c07 with SMTP id
 5b1f17b1804b1-436686464d9mr437207185e9.15.1735852704363; 
 Thu, 02 Jan 2025 13:18:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e528sm39511607f8f.83.2025.01.02.13.18.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 4/8] qdev: Use machine_get_container()
Date: Thu,  2 Jan 2025 22:17:56 +0100
Message-ID: <20250102211800.79235-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Use machine_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-11-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/gpio.c        | 3 +--
 hw/core/qdev.c        | 3 +--
 hw/core/sysbus.c      | 4 ++--
 hw/i386/pc.c          | 4 ++--
 system/ioport.c       | 2 +-
 system/memory.c       | 2 +-
 system/qdev-monitor.c | 6 +++---
 system/vl.c           | 3 +--
 8 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 80d07a6ec99..6e32a8eec61 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -121,8 +121,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
                                      name ? name : "unnamed-gpio-out", n);
     if (input_pin && !OBJECT(input_pin)->parent) {
         /* We need a name for object_property_set_link to work */
-        object_property_add_child(container_get(qdev_get_machine(),
-                                                "/unattached"),
+        object_property_add_child(machine_get_container("unattached"),
                                   "non-qdev-gpio[*]", OBJECT(input_pin));
     }
     object_property_set_link(OBJECT(dev), propname,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9973e029ffa..cfdb7beca24 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -476,8 +476,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
 
-            object_property_add_child(container_get(qdev_get_machine(),
-                                                    "/unattached"),
+            object_property_add_child(machine_get_container("unattached"),
                                       name, obj);
             unattached_parent = true;
             g_free(name);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e64d99c8edf..9355849ff0a 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -65,9 +65,9 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque)
     };
 
     /* Loop through all sysbus devices that were spawned outside the machine */
-    container = container_get(qdev_get_machine(), "/peripheral");
+    container = machine_get_container("peripheral");
     find_sysbus_device(container, &find);
-    container = container_get(qdev_get_machine(), "/peripheral-anon");
+    container = machine_get_container("peripheral-anon");
     find_sysbus_device(container, &find);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 71118765884..9334b033f65 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -463,7 +463,7 @@ static int check_fdc(Object *obj, void *opaque)
 }
 
 static const char * const fdc_container_path[] = {
-    "/unattached", "/peripheral", "/peripheral-anon"
+    "unattached", "peripheral", "peripheral-anon"
 };
 
 /*
@@ -477,7 +477,7 @@ static ISADevice *pc_find_fdc0(void)
     CheckFdcState state = { 0 };
 
     for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
-        container = container_get(qdev_get_machine(), fdc_container_path[i]);
+        container = machine_get_container(fdc_container_path[i]);
         object_child_foreach(container, check_fdc, &state);
     }
 
diff --git a/system/ioport.c b/system/ioport.c
index fd551d0375e..55c2a752396 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -258,7 +258,7 @@ static void portio_list_add_1(PortioList *piolist,
     object_ref(&mrpio->mr);
     object_unparent(OBJECT(&mrpio->mr));
     if (!piolist->owner) {
-        owner = container_get(qdev_get_machine(), "/unattached");
+        owner = machine_get_container("unattached");
     } else {
         owner = piolist->owner;
     }
diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa8..b17b5538ffa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1238,7 +1238,7 @@ static void memory_region_do_init(MemoryRegion *mr,
         char *name_array = g_strdup_printf("%s[*]", escaped_name);
 
         if (!owner) {
-            owner = container_get(qdev_get_machine(), "/unattached");
+            owner = machine_get_container("unattached");
         }
 
         object_property_add_child(owner, name_array, OBJECT(mr));
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f538025..7f4a1f5083b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -348,7 +348,7 @@ static Object *qdev_get_peripheral(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(qdev_get_machine(), "/peripheral");
+        dev = machine_get_container("peripheral");
     }
 
     return dev;
@@ -359,7 +359,7 @@ static Object *qdev_get_peripheral_anon(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(qdev_get_machine(), "/peripheral-anon");
+        dev = machine_get_container("peripheral-anon");
     }
 
     return dev;
@@ -1098,7 +1098,7 @@ static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str)
 {
-    Object *peripheral = container_get(qdev_get_machine(), "/peripheral");
+    Object *peripheral = machine_get_container("peripheral");
     GSList *list, *item;
 
     list = qdev_build_hotpluggable_device_list(peripheral);
diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49b..20e0eaf95ac 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2137,8 +2137,7 @@ static void qemu_create_machine(QDict *qdict)
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
     qemu_create_machine_containers(OBJECT(current_machine));
-    object_property_add_child(container_get(OBJECT(current_machine),
-                                            "/unattached"),
+    object_property_add_child(machine_get_container("unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
 
     if (machine_class->minimum_page_bits) {
-- 
2.47.1


