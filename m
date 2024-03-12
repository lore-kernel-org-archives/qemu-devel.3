Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D545EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxPc-0005Y0-O8; Tue, 12 Mar 2024 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPb-0005X5-0y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPV-000180-Oy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4131b1f8c91so25233775e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231775; x=1710836575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQcWJI75CPaIFG8vmumDb+g+fNolR8s7hw2KDmVIUrw=;
 b=M3Pg9GYY5zeHZIfB2JOqZw0cgsCYptnE8nXtlz6qMVNfS18uiuxKxK2+S3uE+vhRT2
 DbV9axU6dJmyqFVD7TWaRn+0pVNTcs+3NEMVLKMWv5KOv4YcLtatlnPqd4Y8oSk4PJB6
 y9yG8YmIKJFOgyYFhwgywaUWTqHdTylDS0pdlIf7ZAO3R9gVNltik4cv9H9NBRTYU0Xa
 XFQkIuuwh9zCEN0O2F7+kd4KaQlsJEQmP6sA/GlRQimOnXFOqGtK4e/YtmB34+nmDKgI
 pSAURIi6fCX5Y+Vf1AVofqS9Rc4hODCt/yx/O7aWEH9bjRVjiTgM0xoyYvwu2Gle9zhb
 Pb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231775; x=1710836575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQcWJI75CPaIFG8vmumDb+g+fNolR8s7hw2KDmVIUrw=;
 b=NSanGSRNN3I9rA55lz0WGwR1RXx9pfrnIev2IACa6H9D1xt4b5tCARQCfxd20NdNJk
 7K8UdOFgEtk2HMMpWP5/00f7KqDsErnEB+8OtMO7x4qdUY+cFh+sXKERz/1JCMW79OGz
 8zM5ZmI3IXCIm/6MgOHCEJDqdQOjvAIrw4kcix1CZLlWEKCx2QLSc39Hp/rU645Bx+p4
 6hrViKyq+rjy9hwmV7UaeEkxUGmQxpVHKeeLBwwZh9+ud5OU+Rs5KrAOLiz2qpMVRhBG
 kv8J5fNhxlQUwLIxFhw398gcL1irfsmTmptZkModHSihJOLCaFS8qgTAxZcC86n0F/eE
 3r6A==
X-Gm-Message-State: AOJu0YypcIa2GJqf+kLcbIQL93eYZBXQgjtK7oatPFt7+kaigQCm5xo6
 c7sPMU2LdP6aqvHKEzDQtSm/Zju+X99tqHrv6LViyJ6HeHo/W3DnlayEBQUM+Y1j4RcAuNueQue
 V
X-Google-Smtp-Source: AGHT+IE+tiMGizSQ5pBwrTTgDAO6Tn9GqzxSGVM9+jsthDpGm/WETdutKghDipVhbr/XMUB51kLKWg==
X-Received: by 2002:a05:600c:4e8e:b0:413:1d7b:1cc4 with SMTP id
 f14-20020a05600c4e8e00b004131d7b1cc4mr6251516wmq.0.1710231775582; 
 Tue, 12 Mar 2024 01:22:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0033e767cac6csm8415301wrx.115.2024.03.12.01.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:22:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 02/13] hw/pci: add some convenient trace-events for pcie and
 shpc hotplug
Date: Tue, 12 Mar 2024 09:22:27 +0100
Message-ID: <20240312082239.69696-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add trace-events that may help to debug problems with hotplugging.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240301154146.761531-2-vsementsov@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pcie.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/shpc.c       | 46 +++++++++++++++++++++++++++++++++++++
 hw/pci/trace-events |  6 +++++
 3 files changed, 108 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..f56079acf5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_port.h"
 #include "qemu/range.h"
+#include "trace.h"
 
 //#define DEBUG_PCIE
 #ifdef DEBUG_PCIE
@@ -45,6 +46,23 @@ static bool pcie_sltctl_powered_off(uint16_t sltctl)
         && (sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_OFF;
 }
 
+static const char *pcie_led_state_to_str(uint16_t value)
+{
+    switch (value) {
+    case PCI_EXP_SLTCTL_PWR_IND_ON:
+    case PCI_EXP_SLTCTL_ATTN_IND_ON:
+        return "on";
+    case PCI_EXP_SLTCTL_PWR_IND_BLINK:
+    case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
+        return "blink";
+    case PCI_EXP_SLTCTL_PWR_IND_OFF:
+    case PCI_EXP_SLTCTL_ATTN_IND_OFF:
+        return "off";
+    default:
+        return "invalid";
+    }
+}
+
 /***************************************************************************
  * pci express capability helper functions
  */
@@ -735,6 +753,28 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
     *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 }
 
+static void find_child_fn(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    PCIDevice **child = opaque;
+
+    if (!*child) {
+        *child = dev;
+    }
+}
+
+/*
+ * Returns the plugged device or first function of multifunction plugged device
+ */
+static PCIDevice *pcie_cap_slot_find_child(PCIDevice *dev)
+{
+    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+    PCIDevice *child = NULL;
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus), find_child_fn, &child);
+
+    return child;
+}
+
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len)
@@ -779,6 +819,22 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
                         sltsta);
     }
 
+    if (trace_event_get_state_backends(TRACE_PCIE_CAP_SLOT_WRITE_CONFIG)) {
+        DeviceState *parent = DEVICE(dev);
+        DeviceState *child = DEVICE(pcie_cap_slot_find_child(dev));
+
+        trace_pcie_cap_slot_write_config(
+            parent->canonical_path,
+            child ? child->canonical_path : "no-child",
+            (sltsta & PCI_EXP_SLTSTA_PDS) ? "present" : "not present",
+            pcie_led_state_to_str(old_slt_ctl & PCI_EXP_SLTCTL_PIC),
+            pcie_led_state_to_str(val & PCI_EXP_SLTCTL_PIC),
+            pcie_led_state_to_str(old_slt_ctl & PCI_EXP_SLTCTL_AIC),
+            pcie_led_state_to_str(val & PCI_EXP_SLTCTL_AIC),
+            (old_slt_ctl & PCI_EXP_SLTCTL_PWR_OFF) ? "off" : "on",
+            (val & PCI_EXP_SLTCTL_PWR_OFF) ? "off" : "on");
+    }
+
     /*
      * If the slot is populated, power indicator is off and power
      * controller is off, it is safe to detach the devices.
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index d2a5eea69e..aac6f2d034 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -8,6 +8,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/msi.h"
+#include "trace.h"
 
 /* TODO: model power only and disabled slot states. */
 /* TODO: handle SERR and wakeups */
@@ -123,6 +124,34 @@
 #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
 #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
 
+static const char *shpc_led_state_to_str(uint8_t value)
+{
+    switch (value) {
+    case SHPC_LED_ON:
+        return "on";
+    case SHPC_LED_BLINK:
+        return "blink";
+    case SHPC_LED_OFF:
+        return "off";
+    default:
+        return "invalid";
+    }
+}
+
+static const char *shpc_slot_state_to_str(uint8_t value)
+{
+    switch (value) {
+    case SHPC_STATE_PWRONLY:
+        return "power-only";
+    case SHPC_STATE_ENABLED:
+        return "enabled";
+    case SHPC_STATE_DISABLED:
+        return "disabled";
+    default:
+        return "invalid";
+    }
+}
+
 static uint8_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
 {
     uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
@@ -302,6 +331,23 @@ static void shpc_slot_command(PCIDevice *d, uint8_t target,
         shpc_set_status(shpc, slot, state, SHPC_SLOT_STATE_MASK);
     }
 
+    if (trace_event_get_state_backends(TRACE_SHPC_SLOT_COMMAND)) {
+        DeviceState *parent = DEVICE(d);
+        int pci_slot = SHPC_IDX_TO_PCI(slot);
+        DeviceState *child =
+            DEVICE(shpc->sec_bus->devices[PCI_DEVFN(pci_slot, 0)]);
+
+        trace_shpc_slot_command(
+            parent->canonical_path, pci_slot,
+            child ? child->canonical_path : "no-child",
+            shpc_led_state_to_str(old_power),
+            shpc_led_state_to_str(power),
+            shpc_led_state_to_str(old_attn),
+            shpc_led_state_to_str(attn),
+            shpc_slot_state_to_str(old_state),
+            shpc_slot_state_to_str(state));
+    }
+
     if (!shpc_slot_is_off(old_state, old_power, old_attn) &&
         shpc_slot_is_off(state, power, attn))
     {
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 42430869ce..19643aa8c6 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -16,3 +16,9 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
 sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
+
+# pcie.c
+pcie_cap_slot_write_config(const char *parent, const char *child, const char *pds, const char *old_pic, const char *new_pic, const char *old_aic, const char *new_aic, const char *old_power, const char *new_power) "%s > %s: pds: %s, pic: %s->%s, aic: %s->%s, power: %s->%s"
+
+# shpc.c
+shpc_slot_command(const char *parent, int pci_slot, const char *child, const char *old_pic, const char *new_pic, const char *old_aic, const char *new_aic, const char *old_state, const char *new_state) "%s[%d] > %s: pic: %s->%s, aic: %s->%s, state: %s->%s"
-- 
2.41.0


