Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2379E6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECl3-0006Qt-DW; Thu, 21 Nov 2024 14:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl0-0006Q3-Vo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkz-0002Xx-6l
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UK/Elqka/VxSTfGrQ82qaQxK80KUlVn54aM5DoC1EMk=;
 b=LyllM0UfvToLqIsCmDqmGTvo92UJ8svHpj4Ca2a7zM7WP6TfaZmE8+z7IX3Mm4Nw93tcy0
 9B1q7mqGE0GMDyLbHubNvgCykD4EynRBUT2zOyg55bFGVYQ2U6lbZYCnn3WKYNAL5LZ8hb
 9T9Jeil8EsX3QqbjtYx7CQf670aiwG8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Mp_IYnPcOpm__HMpc1YFSw-1; Thu, 21 Nov 2024 14:22:23 -0500
X-MC-Unique: Mp_IYnPcOpm__HMpc1YFSw-1
X-Mimecast-MFC-AGG-ID: Mp_IYnPcOpm__HMpc1YFSw
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83abb901672so141640339f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216942; x=1732821742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK/Elqka/VxSTfGrQ82qaQxK80KUlVn54aM5DoC1EMk=;
 b=rm/zAv8n/Nvdj+8OhUNxt1LVD298flu/mwcoi0QE8mJtm3QDA34wCi/c7I8k85/cgZ
 FxL3Xv3Bmku3B8g3bzP/+VOTBKYdfC3WUXnsXUkAklb7y8rnle8wSHBSk+cjMDMZY1V2
 CWrOtZYvqO74dKFgM2EeJstYVANTqRwrewp8b/evNM4AhXkAySLRLBaDSmEBzr7hUI4k
 zgdHxy6P0dn2Cf6fKIvDK/PQp8vgYxfvhCnNyuSiGHicIieVxeJiFykNzXQTyyVwDfXo
 GYtDmANdOzjLugjN4347T/8zwAc7MbzZL8AyjIOijfMUKpyS5fK4VO/RsbuNIETY1Vvs
 Vcqg==
X-Gm-Message-State: AOJu0Yxdhobxwd+fINaSmRovvbHU4L89XJ4whuBZujm/QfNk1CkAMJjY
 rP/BQLqG7ReopEUvpQ++J3j/H8aFy0CFwPi0TX8U6aT8AUCgPDpm5PBOwLyDTBuJshE1t+cXc7R
 F/RlusHGfyY4B6LedKhh0hYWCeyGYBy4KK7t/OevCPls/Sm13N2g34GuiIXNHLt3a2mhunsbblL
 REMS4kyK8ZyCuudhvxgjCpGrqGG4e0sfJq2w==
X-Gm-Gg: ASbGnct177L288v2ITXC/JPASYy+Kdpt4oVoNBtDEBxdilWVONZV0mhzrHSeIMDVPEP
 12jtgYvTzlbiYKQROBNHvvJZZ0wtfJyFwfteOgoG+1PuXYw1s09kHVx4E4ZmyVVVdXmEU6lYT7M
 XE17t5Y6XJiW379N+KeLEg1fflcti48NDzf2DWKYnPCV6JDNos1LBlIvu3FKglUE7Wkkv/jY1ky
 pbm8ornQdbI5qE+F/LTysgW5eZSIdPgC6DccvWpYJFompRooJ2rHYf+4HFIvO7U/wpc/h7EQT0c
 5rXjR4nzpDKZsblWn8u4VKR5Rw==
X-Received: by 2002:a05:6602:2c8c:b0:83a:acba:887a with SMTP id
 ca18e2360f4ac-83ecdb0dd30mr16250339f.0.1732216941947; 
 Thu, 21 Nov 2024 11:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA0uQlYAqFOdcuBhY/0+U+GBC6yKwfxku5KtRi/qpmWbg80i+ktjindaGwSSHa/iJSPWH2Fg==
X-Received: by 2002:a05:6602:2c8c:b0:83a:acba:887a with SMTP id
 ca18e2360f4ac-83ecdb0dd30mr16246139f.0.1732216941458; 
 Thu, 21 Nov 2024 11:22:21 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 10/13] qom: Use machine_get_container()
Date: Thu, 21 Nov 2024 14:21:59 -0500
Message-ID: <20241121192202.4155849-11-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use machine_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
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
index 80d07a6ec9..6e32a8eec6 100644
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
index fa3bc85d9a..d52b669355 100644
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
index e64d99c8ed..9355849ff0 100644
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
index 317aaca25a..b8ec2506e1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -460,7 +460,7 @@ static int check_fdc(Object *obj, void *opaque)
 }
 
 static const char * const fdc_container_path[] = {
-    "/unattached", "/peripheral", "/peripheral-anon"
+    "unattached", "peripheral", "peripheral-anon"
 };
 
 /*
@@ -474,7 +474,7 @@ static ISADevice *pc_find_fdc0(void)
     CheckFdcState state = { 0 };
 
     for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
-        container = container_get(qdev_get_machine(), fdc_container_path[i]);
+        container = machine_get_container(fdc_container_path[i]);
         object_child_foreach(container, check_fdc, &state);
     }
 
diff --git a/system/ioport.c b/system/ioport.c
index fd551d0375..55c2a75239 100644
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
index 85f6834cb3..fba351b030 100644
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
index 4c09b38ffb..4d46af2c8d 100644
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
@@ -1085,7 +1085,7 @@ static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str)
 {
-    Object *peripheral = container_get(qdev_get_machine(), "/peripheral");
+    Object *peripheral = machine_get_container("peripheral");
     GSList *list, *item;
 
     list = qdev_build_hotpluggable_device_list(peripheral);
diff --git a/system/vl.c b/system/vl.c
index 15e35162c6..cdc0b6e10c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2136,8 +2136,7 @@ static void qemu_create_machine(QDict *qdict)
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
     qemu_create_machine_containers(OBJECT(current_machine));
-    object_property_add_child(container_get(OBJECT(current_machine),
-                                            "/unattached"),
+    object_property_add_child(machine_get_container("unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
 
     if (machine_class->minimum_page_bits) {
-- 
2.45.0


