Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B21FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7s-0003wE-Tn; Thu, 20 Mar 2025 11:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7a-0003aa-Sw
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:48:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7X-0007pi-UU
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so7100535e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485663; x=1743090463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5mdBkm56vK4L97ihZ1b8SZhbwJ9wIfLMxsKgv4QD5g=;
 b=gmw1NUQ82F2chX0U24J9bPhV27T29dXHEjEbc3Lvh5InLBnrT1TWxHaDo87Z1yyYel
 ZlTH3V3Vs33i5HrmuR+BML0gJzzFT9Ko5fGs6CeKwq1jIE38AR8nq3FpDcRWjLFrHphE
 VqSJ7CNZ3VsQrJgjonzP1ki5nbiJcZJKh0VND5t1xG6Hxo7c1+oXlpymex/oX9bILYNT
 pjzuwTuoY/qngP+k2xYEAjaR5DbJRFvHkiesFxlzxu6n/ZTUM1DIDtoHn5FswQ4cbATX
 I30E2wvBVFx0kiKd0xvGHuuGA/7p4vdFMsAlX/UNrlKRHUxCqVOZNf73JfqvdDwG12jR
 PLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485663; x=1743090463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5mdBkm56vK4L97ihZ1b8SZhbwJ9wIfLMxsKgv4QD5g=;
 b=iCyeX1VYEoGN4RZoquHkz163+GVRkD3llurg7ZimlOekrle2nzcLf0KpF226OHUoJh
 fzC38dxXX2b5zaKOW6oWevVVGXR5XRS2+aZsJupTLSIeiTbOqP8w79YLHoki8LV/lVpf
 C4wn4DJUFaeHa7T1J4DrNvC5ifntjjmasusfEYdRUKT0Z/H7SModX7sMQaO7SCbfCXMd
 N6liG6Ir4MBLaE+VIvbsYUU3wg5yvSlaAUZS/WSqw35tVYoxLyT5N8PAZzJQUQVun8O4
 SVZ0hZ5QJmh8xDmbYghzfje0/7TTDzNmIZ1p1bCDhaXJaE7P2/WyW0fsRdFyILWZ4ONe
 1dtA==
X-Gm-Message-State: AOJu0YwqjzZJg2dhmRGetV+n4GraOZEPzMoyoKTXU8Ar8R5gKmo5QflJ
 0tS5/zchKjI/h2bkt98ZKErEdrGRRj3QDA8WN0gH1lPgOIJCCM9MVclNkod+0KilncLmvqFX0/i
 u
X-Gm-Gg: ASbGncvc+9D3d3aKgnTB1WmLzZCjqnVg6OzMrdbhWB+YqdXZCbsyGD9ilbRkTMk+4u6
 LJFsYu3MrXU0OZE2E9doq6UWudj76VApYuDg+EMSfTpioXCRdgJ7DFdSA6L6PPkjadxdJPszlwe
 XIcyyBkNFAfgz0ym7Kza21o018uTShsb4z64Mj9203SFT9TJpD0WLZx0YuOlW5AAaQcnIGwxOh9
 0ywv1DeL7rYX0beuJr3jZe496aEkPuUNVW4W9LSVj6rbveuFeXm6V6pONWsaJBmWSw6ypchtgj9
 grZXcojnWRhOSf1nPGt6CZv8j+FWZ97mh9yzZM5CGyyxYZywz3F4+Mddblz2emAA4hnMyB4M7c4
 1oXsAG8hrmof2AKJtktoeXNao
X-Google-Smtp-Source: AGHT+IE+kqkp5igri4QLGTSlgyQABCxPT6cQYVP63VFQ7+oyPYIEI6Y2yjS9nlxSJjbdJVspUMkb9w==
X-Received: by 2002:a05:600c:3490:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d495462femr38111865e9.16.1742485662711; 
 Thu, 20 Mar 2025 08:47:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm52583585e9.22.2025.03.20.08.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 4/6] qom: Prefer object_class_implements_type() to
 check type implementation
Date: Thu, 20 Mar 2025 16:47:20 +0100
Message-ID: <20250320154722.27349-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
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

When we only want to check a type is implemented and
are not interested by the returned class, prefer
object_class_implements_type() over object_class_dynamic_cast().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char.c             | 2 +-
 hw/arm/xlnx-versal-virt.c  | 2 +-
 hw/core/cpu-common.c       | 2 +-
 hw/core/machine.c          | 4 ++--
 hw/i386/xen/xen_platform.c | 2 +-
 hw/pci/pci.c               | 6 +++---
 qom/object.c               | 2 +-
 qom/object_interfaces.c    | 2 +-
 qom/qom-qmp-cmds.c         | 4 ++--
 system/qdev-monitor.c      | 4 ++--
 system/tpm.c               | 2 +-
 target/alpha/cpu.c         | 2 +-
 target/rx/cpu.c            | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 5a9e9762adc..b7125e3aebe 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -528,7 +528,7 @@ static const ChardevClass *char_get_class(const char *driver, Error **errp)
     oc = module_object_class_by_name(typename);
     g_free(typename);
 
-    if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
+    if (!object_class_implements_type(oc, TYPE_CHARDEV)) {
         error_setg(errp, "'%s' is not a valid char driver name", driver);
         return NULL;
     }
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0c6f0359e3d..9313780a4c2 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -760,7 +760,7 @@ static void versal_virt_init(MachineState *machine)
             flash_klass = object_class_by_name(s->ospi_model);
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
-                !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
+                !object_class_implements_type(flash_klass, TYPE_M25P80)) {
                 error_report("'%s' is either abstract or"
                        " not a subtype of m25p80", s->ospi_model);
                 exit(1);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 9064dd24f82..89c2dd53599 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -144,7 +144,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
     assert(cc->class_by_name);
     assert(cpu_model);
     oc = cc->class_by_name(cpu_model);
-    if (object_class_dynamic_cast(oc, typename) &&
+    if (object_class_implements_type(oc, typename) &&
         !object_class_is_abstract(oc)) {
         return oc;
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b..712d07e1593 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -735,7 +735,7 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
     for (wl = mc->allowed_dynamic_sysbus_devices;
          !allowed && wl;
          wl = wl->next) {
-        allowed |= !!object_class_dynamic_cast(klass, wl->value);
+        allowed |= object_class_implements_type(klass, wl->value);
     }
 
     return allowed;
@@ -1553,7 +1553,7 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
     if (mc->valid_cpu_types) {
         assert(mc->valid_cpu_types[0] != NULL);
         for (i = 0; mc->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
+            if (object_class_implements_type(oc, mc->valid_cpu_types[i])) {
                 break;
             }
         }
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index dd648a2ee94..761357657f1 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -144,7 +144,7 @@ static void del_nic_peer(NICState *nic, void *opaque)
     ObjectClass *klass = module_object_class_by_name(nc->model);
 
     /* Only delete peers of PCI NICs that we're about to delete */
-    if (!klass || !object_class_dynamic_cast(klass, TYPE_PCI_DEVICE)) {
+    if (!klass || !object_class_implements_type(klass, TYPE_PCI_DEVICE)) {
         return;
     }
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec55560..ff2373b9876 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2244,12 +2244,12 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     /* initialize cap_present for pci_is_express() and pci_config_size(),
      * Note that hybrid PCIs are not set automatically and need to manage
      * QEMU_PCI_CAP_EXPRESS manually */
-    if (object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE) &&
-       !object_class_dynamic_cast(klass, INTERFACE_CONVENTIONAL_PCI_DEVICE)) {
+    if (object_class_implements_type(klass, INTERFACE_PCIE_DEVICE) &&
+       !object_class_implements_type(klass, INTERFACE_CONVENTIONAL_PCI_DEVICE)) {
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
-    if (object_class_dynamic_cast(klass, INTERFACE_CXL_DEVICE)) {
+    if (object_class_implements_type(klass, INTERFACE_CXL_DEVICE)) {
         pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
     }
 
diff --git a/qom/object.c b/qom/object.c
index b9948937935..536308c0553 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -894,7 +894,7 @@ bool object_set_propv(Object *obj,
 
 Object *object_dynamic_cast(Object *obj, const char *typename)
 {
-    if (obj && object_class_dynamic_cast(object_get_class(obj), typename)) {
+    if (obj && object_class_implements_type(object_get_class(obj), typename)) {
         return obj;
     }
 
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1ffea1a7288..333c5f94e19 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -98,7 +98,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    if (!object_class_dynamic_cast(klass, TYPE_USER_CREATABLE)) {
+    if (!object_class_implements_type(klass, TYPE_USER_CREATABLE)) {
         error_setg(errp, "object type '%s' isn't supported by object-add",
                    type);
         return NULL;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e8665476182..1a1f0e1dfd6 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -134,7 +134,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    if (!object_class_dynamic_cast(klass, TYPE_DEVICE)
+    if (!object_class_implements_type(klass, TYPE_DEVICE)
         || object_class_is_abstract(klass)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
                    "a non-abstract device type");
@@ -193,7 +193,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         return NULL;
     }
 
-    if (!object_class_dynamic_cast(klass, TYPE_OBJECT)) {
+    if (!object_class_implements_type(klass, TYPE_OBJECT)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
                    "a QOM type");
         return NULL;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 5588ed2047d..7e4cfe0f0e5 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -246,7 +246,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
         }
     }
 
-    if (!object_class_dynamic_cast(oc, TYPE_DEVICE)) {
+    if (!object_class_implements_type(oc, TYPE_DEVICE)) {
         if (*driver != original_name) {
             error_setg(errp, "'%s' (alias '%s') is not a valid device model"
                        " name", original_name, *driver);
@@ -269,7 +269,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
         return NULL;
     }
 
-    if (object_class_dynamic_cast(oc, TYPE_SYS_BUS_DEVICE)) {
+    if (object_class_implements_type(oc, TYPE_SYS_BUS_DEVICE)) {
         /* sysbus devices need to be allowed by the machine */
         MachineClass *mc = MACHINE_CLASS(object_get_class(qdev_get_machine()));
         if (!device_type_is_dynamic_sysbus(mc, *driver)) {
diff --git a/system/tpm.c b/system/tpm.c
index 8df0f6e72b3..eeb1bd0e27c 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -34,7 +34,7 @@ tpm_be_find_by_type(enum TpmType type)
     oc = object_class_by_name(typename);
     g_free(typename);
 
-    if (!object_class_dynamic_cast(oc, TYPE_TPM_BACKEND)) {
+    if (!object_class_implements_type(oc, TYPE_TPM_BACKEND)) {
         return NULL;
     }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 584c2aa76bd..f9ba199e794 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -136,7 +136,7 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     int i;
 
     oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) != NULL) {
+    if (oc != NULL && object_class_implements_type(oc, TYPE_ALPHA_CPU)) {
         return oc;
     }
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0ba0d55ab5b..2cc4e1df7aa 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -119,7 +119,7 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
     char *typename;
 
     oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL) {
+    if (oc != NULL && object_class_implements_type(oc, TYPE_RX_CPU)) {
         return oc;
     }
     typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
-- 
2.47.1


