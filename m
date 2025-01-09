Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F3FE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCq-0002e2-5U; Thu, 09 Jan 2025 12:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCn-0002aB-Tw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCl-0000qz-Sy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso9691785e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443221; x=1737048021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUzVGKeluHJTwIU2Bj0/kdJ+NUb+Ue/QhX3Ykfr1q8Q=;
 b=ObO1+5a3632bwJPaPsV/KFWDbt8YCS/4gZgYwcFtIKEaQaYlo/KSjr7zqBPbg9yCTv
 7o8yBEB44nf2mCN8LMjkaOeEkinqiDOJuGmbCYEmjSTWJQivnOcrmaWL2DFxW9dYE7Yg
 /C+hTkVal8ZbrvYZncj8Hwkf69kg9qcnsyBSZbbK7rPpPBXVpIqP4fu0igHXC12QBY4k
 zkzWqL5tpaAZDpHFKHSdcje2N78BHlUc1RVXYysYFWAwxIcEwNhmzcHfVNhOuWdsLuXI
 K1YrQni7Bk5SQ0sH5Ce5wkKhzYQSMuI4pqc5OG1L9CDbeRrwcm8kZRh4aPNLkU3iqKm7
 Njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443221; x=1737048021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUzVGKeluHJTwIU2Bj0/kdJ+NUb+Ue/QhX3Ykfr1q8Q=;
 b=NL6FgoPib4KxZvvYQjk8imuS6YHyxxgejbFmSjHdXBDKoIlm5NQ3E8PorOl1pskBsq
 +K+ew30eTdKAEdZBFA90qUUCXwCZY1YIDqFCYQnk56xyTpIuOJUbNhN76RKfqIhs9dpJ
 +cuDf7DqV0GQNfUbsIlcuvrNmbYdboljhSQ10xR0J3WATu+5Br6+wtj6Sr+hcw7qIMxm
 cI09aAh4UMWHLH8bthBDWkKpm91+l7Xmag+QHFTdfD268JcRyYHF9UhlxDlV2Odxt6oA
 V7fRkou3QTifKUp9RcCFxUIf94Cjif64AmAvWvIi0mgM41bHwx54GI4JLlxLu7hungsp
 dKNg==
X-Gm-Message-State: AOJu0YzrUpm+X8bZGyrLP8gau67464aUYilrehfZPTlIrZ4RmWUSVEQL
 IDLbq+ktBXQeaVwrA9FYT5wxRTXzmj6bA6D+8rLWeZg/XJZz6AoxBp4GmE/7miy/yTDO09Zdvb9
 L1R0=
X-Gm-Gg: ASbGncsSGf4JKf4c7+4abE9a9UmN/IUz7ON9KFlXIaY4nk5PvF9XPy6q35LJAOEInhD
 2pLsXXC+TW0mUaJE/ycvc/UbA+uwvMX1opvUZKZeCOMTUp6JxVJz2sW7e0ovHp2dRT17v5Z1ICa
 IGqAPz5NJqwAbeoH47b3Bq8t6olc0JaAV4gYxwzyk4C5RPbcXoRiHw5qSclA6X3nccmKKGsXHsN
 j3oNpIGX6S45HVHVx8qhsdXENrxJMa8HviU8DUbpo55HgyhJF/q6lDu4yW2sd3o9dleXnT8m5r0
 AyyBRmc/XP7MnuzI4xaShKK4Myd9qoza3+9b
X-Google-Smtp-Source: AGHT+IGq17mk+DRbE/b7puYLM34oZnYM6v8TQ1zLKxxYmh+xXfaQreWcYNM48rSqtLiMLFue9EbP2g==
X-Received: by 2002:a05:600c:a08b:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-436e26dda73mr60242025e9.24.1736443221145; 
 Thu, 09 Jan 2025 09:20:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b2asm2272284f8f.89.2025.01.09.09.20.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/11] qdev: Use machine_get_container()
Date: Thu,  9 Jan 2025 18:19:43 +0100
Message-ID: <20250109171948.31092-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Peter Xu <peterx@redhat.com>

Use machine_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-11-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 9abc4e8322f..82bbdcb654e 100644
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
index 6a38b567876..23043b1e0d5 100644
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
@@ -1100,7 +1100,7 @@ static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str)
 {
-    Object *peripheral = container_get(qdev_get_machine(), "/peripheral");
+    Object *peripheral = machine_get_container("peripheral");
     GSList *list, *item;
 
     list = qdev_build_hotpluggable_device_list(peripheral);
diff --git a/system/vl.c b/system/vl.c
index 3c5bd36d7d7..ed1623b26b9 100644
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


