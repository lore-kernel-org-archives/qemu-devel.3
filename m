Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD2C04FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3N-0001Wq-In; Tue, 16 Apr 2024 15:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo32-00019D-2C
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:54 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2h-0005eg-NI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:48 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso607604466b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294029; x=1713898829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDu2aZ9r50YKxf+dNaxDqKUjAn6DYpDYAzbmilk8iWY=;
 b=m5i35H+mtunEze2FUlynMSiXOwtwgt1mn7mHer+VSwXqBikJHdoDa6P3SngIb8pHJD
 EAKHGlqhYfinaCTT4wxgHGCOUhiedu/NmTasBFwnDm7Mr7CCIvdxKziWChbPX0uSHJqZ
 AhDUK3L6268Mr2AUDpwJuLSa9XaZjKlJNvPgAMpQ+7jqoJipTXL2bzNVaWImzkSwylKQ
 7Tud2/+2FT3lVVRnkPGeUawX8CbKHHVpL6CtMDW2adGUJXd4UT0SBJD+COeIFVVJSU26
 M6x6qBlh38p27F6KI1NNFfarqVlzDnm8pCH7dNOh38Ggs6kDbU7Z2d3HIJk88nmXw83P
 AjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294029; x=1713898829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDu2aZ9r50YKxf+dNaxDqKUjAn6DYpDYAzbmilk8iWY=;
 b=p779rd2YUbm4EBIASOosi8Fr9Npzmec4Khnzd92x1fNLABv6LSGjYdTNVkq4sDLsGu
 QWUNAI7A62Oi7kWD0oMvD72nwqp5gVI/VNcjCE+TUzlefXQG+u5yTo1qOa4mc3jBbxS7
 P85e/kdC+f8/HMAgY5oGUWAxDR6OCguAB8aRerLEZKxPeDTBwRkgWTqxuA7PhucoWmfU
 M0cu4ph4SHkQxO894+AJQELzKse4fiz6lCVzE7JfzbKCPuw5lqXgj5s2O/DZVPXHIDmI
 9efFSpCwNGN+fXvXU34ro3qyY4ZXggF5pkSLQuVCpQ5hxgGS/vzjEUFlU5C2jqsOSN51
 QvFg==
X-Gm-Message-State: AOJu0Yxha+yNIyg3T0jlBs1tE12ekFoMGZ0JC4fHYqU3bqaxoGptvhWV
 D043vTPlVIkwoMxirhhM6Rx+Lyhio0Y2/ttPMry8sJxQpsiZZlXY8oeeOJP6bxvRShT8xwug6N9
 L
X-Google-Smtp-Source: AGHT+IEc0M7W+KyDB0aQ8QUm+zC7hkHWbLtW7gtPPIqf8ccsUyI98Px0KPtH3uOffjFEYOIbTwSX0w==
X-Received: by 2002:a17:907:1b1d:b0:a52:2b39:879b with SMTP id
 mp29-20020a1709071b1d00b00a522b39879bmr10404824ejc.46.1713294029119; 
 Tue, 16 Apr 2024 12:00:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 em3-20020a170907288300b00a5180d5b31asm7161409ejc.32.2024.04.16.12.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 07/22] hw/acpi/ich9: Remove dead code related to
 'acpi_memory_hotplug'
Date: Tue, 16 Apr 2024 20:59:23 +0200
Message-ID: <20240416185939.37984-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

acpi_memory_hotplug::is_enabled is set to %true once via
ich9_lpc_initfn() -> ich9_pm_add_properties(). No need to
check it, so remove now dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/acpi/ich9.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 9b605af21a..02d8546bd3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -153,17 +153,10 @@ static int ich9_pm_post_load(void *opaque, int version_id)
      .offset     = vmstate_offset_pointer(_state, _field, uint8_t),  \
  }
 
-static bool vmstate_test_use_memhp(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    return s->acpi_memory_hotplug.is_enabled;
-}
-
 static const VMStateDescription vmstate_memhp_state = {
     .name = "ich9_pm/memhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_memhp,
     .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
@@ -335,11 +328,9 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
-    if (pm->acpi_memory_hotplug.is_enabled) {
-        acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
-                                 &pm->acpi_memory_hotplug,
-                                 ACPI_MEMORY_HOTPLUG_BASE);
-    }
+    acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
+                             &pm->acpi_memory_hotplug,
+                             ACPI_MEMORY_HOTPLUG_BASE);
 }
 
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
@@ -460,12 +451,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
-        !lpc->pm.acpi_memory_hotplug.is_enabled) {
-        error_setg(errp,
-                   "memory hotplug is not enabled: %s.memory-hotplug-support "
-                   "is not set", object_get_typename(OBJECT(lpc)));
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
         if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
@@ -509,8 +495,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_request_cb(hotplug_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
@@ -545,8 +530,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
-- 
2.41.0


