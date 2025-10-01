Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFe-0005OW-Kz; Tue, 30 Sep 2025 21:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFS-0005Lj-Q2
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEz-00085O-AU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4448019f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280560; x=1759885360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KLKg1dYtstrbAJPk1FfINsXop7TJ4OcNXkn8NSh+1U=;
 b=YD8fFwxrnhA/DmSuF/GXZXZwE8WHsv2nq16wNNCTihgR1NIIHF+aMRWKStcH38b3kB
 6SrkH3OM5i48F3qj3E+bwHwlyRjLNz12paZyU4bFoJWB4rAIIP+DH4/mDsukfN7Ah/VW
 mJTMWlihV39VpibLIhmS/ZBbhv/Iu1bzaznboUX5hU90AKzS4Wlym6AGktJPuDlxOtu3
 LF9jyzb/ObpkLrNze9sAlvYm2uaogUZqBO1C0daGTg0YYRCN2MDPHuqlVqApzLsgu78r
 kxdVsOLsZN4Mr7+dPaV4vqMZpEkn4S/VbbwPMwRmco59M7Di5QxWEOfXIjNunG1onl8a
 irng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280560; x=1759885360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KLKg1dYtstrbAJPk1FfINsXop7TJ4OcNXkn8NSh+1U=;
 b=n2nHPTgdZuncn63QARmEDFbRDU/sz0jeOsCIusQtOWgkaoJkQA+YX1u8Fuy2XUiwNk
 hUxSylbo9TKXQjo7vxM8PRnGCeRZaOK9uXG+622rZtpMX4BrHblYOBoAXwobmthFkxZs
 21KPRn7HVbxBcG6cAVrITzPfmeSDEi+PD4ESt8F0HIbbY81XnopAcZ1g8uvmC/Rsikpa
 zaXcMN2IDZ2O0LaUvF3Abce9Pmp6zcn4caDmLYq1Ua0/nrJcIXykBsLlGCSO+O2YJOjq
 bL3rLAqZ2d+r7wnkSpTTFBgwLL3r48QoDPxt/0ssrGC/GkDnlzkOc3GtN7CdOQHNiqIs
 9O/A==
X-Gm-Message-State: AOJu0YxwYqpxhuoU7bMsvI0cmSjocxEuAxi1ChKm2iZ4qoSDinZ8B5Mk
 ZGE6Eoe9pGzZtSWIdw2S0bGVgpvDmaII7rp46OJ96R60/mWi+8S5Q693mK6g/tLjUEVlQ9BJIbk
 uydEFy52IPQ==
X-Gm-Gg: ASbGncsR8amqt0xM+GpbyvggqnOuGIh7IfiknuJze1/m5R8dsfLGQWCru7aqaA3mNte
 1nHUwSYZCvMSdlbtWACiRy+t6k7iH2OlIGGGe1ceh8Zh33Ku81uvftIkaqselMpHiS+oSDbaVxO
 nNJjEJ1c9XIg/DeJmq2i/7eDRnKVeX87+y8UPkJ/GnsdI/SWF5WhSFsB6IJoOt9Sza3ny5diJ1A
 kb9rGThjvZcH9OTJITsHfbJ/JbyzClE6/L7oesBwIDdevpRJSwfvh/BrPZZCIVaMXJyjxmLGLd9
 HO/PS3p0iDCPGoKKfiJCOw6JS8yHYiFbE9Uml7pgZ1wFhIXc61dE+F6r7eAot9rGnowG5kTEsnw
 UDIreRNef/3K8h4aKnvMTaKLBCqhLx/KcHIomya8c/7mf2vBeJe5M0oMSsBV8jzfJRoMnZCKUmj
 R9zntF+aWnoICEVM67mQnoC3Bov0jUKRy5Ws+Va3XDE4mwZ6ewYLkwuQ==
X-Google-Smtp-Source: AGHT+IEOa1mZRIiEXaGp9MtU8lnJshhWrjQdcEIYtIFQ8APD4eiEb81HC4qUqKb3ooyAax2ioj3igg==
X-Received: by 2002:a05:6000:240c:b0:3ea:6680:8f97 with SMTP id
 ffacd0b85a97d-425577ed8a3mr1099336f8f.2.1759280559992; 
 Tue, 30 Sep 2025 18:02:39 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:39 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 12/24] hw/core: Introduce generic device power-state
 handler interface
Date: Wed,  1 Oct 2025 01:01:15 +0000
Message-Id: <20251001010127.3092631-13-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x433.google.com
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

From: Salil Mehta <salil.mehta@huawei.com>

Device power-state transitions such as powering on, powering off, or entering
standby may be triggered by administrative state changes (enable to disable or
disable to enable), guest OSPM requests in response to workload or policy, or
platform-specific control flows (e.g. ACPI, firmware, or machine hooks). These
varied triggers require coordinated handling to ensure consistent behavior
across devices.

Without a common interface, each device type must implement ad-hoc logic,
making it harder to manage and extend power-state control in QEMU.

This patch introduces a generic PowerStateHandler QOM interface that allows
devices to expose callbacks for operational power-state transitions. The model
distinguishes between administrative state (enable/disable, host-driven) and
operational state (on/off/standby, runtime). An administrative transition may
trigger an operational change, with QEMU signaling the guest through platform
interfaces and OSPM coordinating the transition. Some platforms may enforce
transitions directly, without OSPM involvement.

Key features:
 - New TYPE_POWERSTATE_HANDLER QOM interface.
 - PowerStateHandlerClass with optional callbacks for operational transitions:
      device_request_poweroff() – notify guest of internal logic to begin a
                                  graceful shutdown sequence.
      device_post_poweroff()    – complete disable after OSPM has powered off
                                  operationally; device is inactive and freed.
      device_pre_poweron()      – prepare for activation on administrative
                                  enable; reinit state and notify guest/OSPM.
      device_request_standby()  – request a standby state without full poweroff,
                                  retaining sufficient state for resume.
 - Helper functions in hw/core/powerstate.c to:
      - Retrieve a device’s PowerStateHandler from the machine.
      - Invoke the registered callbacks if present.
 - Intended for use by any device type (CPU or non-CPU) that supports controlled
   power transitions, regardless of whether it supports architectural hotplug.

High-level flow:
 QMP/HMP
   |    user issues: {"execute":"device-set", ...} (in later patches)
   v
 QDEV (Prop: admin-power-state) (Administrative State Handling)
   |    invokes PowerStateHandler callbacks via interface
   v
 Machine (PowerStateHandler) (Operational State Handling)
   |    coordinates platform policy and may call firmware handler
   v
 ACPI GED (PowerStateHandler, firmware)
   |    signals events/notifications to the guest
   v
 ACPI SCI (System Control Interrupt) to guest OS
   |  SCI is delivered on GSI N (GED Interrupt() _CRS = N, with FADT
   |  designating N as SCI)
   |  OSPM receives SCI/GSI IRQ
   v
 OSPM (in-guest house keeping) evaluates ACPI methods from firmware tables
        (e.g. _EJ0, _STA, _OST) and completes the transition

Integration model:
Both Machine and ACPI GED implement the PowerStateHandler interface.
QDEV calls the handler hooks; Machine applies platform policy and can invoke
GED to coordinate with OSPM. This keeps Qdev generic while arch-specific logic
resides in Machine and firmware.

This interface will be used in later patches to coordinate CPU administrative
enable/disable operations on architectures that lack native CPU hotplug, and
can also be adopted by other device classes requiring similar control.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/core/meson.build      |   1 +
 hw/core/powerstate.c     | 100 +++++++++++++++++++++++
 include/hw/boards.h      |   2 +
 include/hw/powerstate.h  | 171 +++++++++++++++++++++++++++++++++++++++
 stubs/meson.build        |   1 +
 stubs/powerstate-stubs.c |  47 +++++++++++
 6 files changed, 322 insertions(+)
 create mode 100644 hw/core/powerstate.c
 create mode 100644 include/hw/powerstate.h
 create mode 100644 stubs/powerstate-stubs.c

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..d9d716ce55 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -40,6 +40,7 @@ system_ss.add(files(
   'numa.c',
   'qdev-fw.c',
   'qdev-hotplug.c',
+  'powerstate.c',
   'qdev-properties-system.c',
   'reset.c',
   'sysbus.c',
diff --git a/hw/core/powerstate.c b/hw/core/powerstate.c
new file mode 100644
index 0000000000..0e1d12b3f6
--- /dev/null
+++ b/hw/core/powerstate.c
@@ -0,0 +1,100 @@
+/*
+ * Device Power State transition handler interface
+ *
+ * An administrative request to 'enable' or 'disable' a device results in a
+ * change of its operational status. The transition may be performed either
+ * synchronously or asynchronously, with OSPM assistance where required.
+ *
+ * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
+ *
+ * Author: Salil Mehta <salil.mehta@huawei.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include "qemu/osdep.h"
+#include "hw/powerstate.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+
+PowerStateHandler *powerstate_handler(DeviceState *dev)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+   if (mc->get_powerstate_handler) {
+        return (PowerStateHandler *)mc->get_powerstate_handler(machine, dev);
+   }
+
+    return NULL;
+}
+
+DeviceOperPowerState qdev_get_oper_power_state(DeviceState *dev)
+{
+    PowerStateHandler *h = powerstate_handler(dev);
+    PowerStateHandlerClass *pshc = h ? POWERSTATE_HANDLER_GET_CLASS(h) : NULL;
+
+    if (pshc && pshc->get_oper_state) {
+        return pshc->get_oper_state(dev, &error_warn);
+    }
+
+    return DEVICE_OPER_POWER_STATE_UNKNOWN;
+}
+
+void device_request_poweroff(DeviceState *dev, Error **errp)
+{
+    PowerStateHandler *h = powerstate_handler(dev);
+    PowerStateHandlerClass *pshc = h ? POWERSTATE_HANDLER_GET_CLASS(h) : NULL;
+
+    if (pshc && pshc->request_poweroff) {
+        pshc->request_poweroff(h, dev, errp);
+    }
+}
+
+void device_post_poweroff(DeviceState *dev, Error **errp)
+{
+    PowerStateHandler *h = powerstate_handler(dev);
+    PowerStateHandlerClass *pshc = h ? POWERSTATE_HANDLER_GET_CLASS(h) : NULL;
+
+    if (pshc && pshc->post_poweroff) {
+        pshc->post_poweroff(h, dev, errp);
+    }
+}
+
+void device_pre_poweron(DeviceState *dev, Error **errp)
+{
+    PowerStateHandler *h = powerstate_handler(dev);
+    PowerStateHandlerClass *pshc = h ? POWERSTATE_HANDLER_GET_CLASS(h) : NULL;
+
+    if (pshc && pshc->pre_poweron) {
+        pshc->pre_poweron(h, dev, errp);
+    }
+}
+
+void device_request_standby(DeviceState *dev, Error **errp)
+{
+    PowerStateHandler *h = powerstate_handler(dev);
+    PowerStateHandlerClass *pshc = h ? POWERSTATE_HANDLER_GET_CLASS(h) : NULL;
+
+    if (pshc && pshc->request_standby) {
+        pshc->request_standby(h, dev, errp);
+    }
+}
+
+static const TypeInfo powerstate_handler_info = {
+    .name          = TYPE_POWERSTATE_HANDLER,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(PowerStateHandlerClass),
+};
+
+static void powerstate_handler_register_types(void)
+{
+    type_register_static(&powerstate_handler_info);
+}
+
+type_init(powerstate_handler_register_types)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fe51ca58bf..161505911f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -332,6 +332,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    void *(*get_powerstate_handler)(MachineState *machine,
+                                                 DeviceState *dev);
     bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
                             Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
diff --git a/include/hw/powerstate.h b/include/hw/powerstate.h
new file mode 100644
index 0000000000..c16da0f24d
--- /dev/null
+++ b/include/hw/powerstate.h
@@ -0,0 +1,171 @@
+/*
+ * Device Power State transition handler interface
+ *
+ * An administrative request to 'enable' or 'disable' a device results in a
+ * change of its operational status. The transition may be performed either
+ * synchronously or asynchronously, with OSPM assistance where required.
+ *
+ * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
+ *
+ * Author: Salil Mehta <salil.mehta@huawei.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef POWERSTATE_H
+#define POWERSTATE_H
+
+#include "qom/object.h"
+
+#define TYPE_POWERSTATE_HANDLER "powerstate-handler"
+
+typedef struct PowerStateHandlerClass PowerStateHandlerClass;
+DECLARE_CLASS_CHECKERS(PowerStateHandlerClass, POWERSTATE_HANDLER,
+                       TYPE_POWERSTATE_HANDLER)
+#define POWERSTATE_HANDLER(obj) \
+     INTERFACE_CHECK(PowerStateHandler, (obj), TYPE_POWERSTATE_HANDLER)
+
+typedef struct PowerStateHandler PowerStateHandler;
+
+/**
+ * DeviceOperPowerState:
+ *
+ * Enumeration of operational power states for devices. These represent runtime
+ * states controlled through platform interfaces (e.g. ACPI, PSCI, or other
+ * OSPM mechanisms), and are distinct from administrative presence or enable/
+ * disable state.
+ *
+ * Transitions may be initiated by the guest OSPM in response to workload or
+ * policy, or triggered by administrative actions due to policy change. Please
+ * check PowerStateHandlerClass for more details on these.
+ *
+ * Platforms may optionally implement a callback to fetch the current state.
+ * That callback must map internal platform state to one of the values here.
+ *
+ * @DEVICE_OPER_POWER_STATE_UNKNOWN: State reporting unsupported, or state
+ *                                   could not be determined. If @errp is set,
+ *                                   this indicates an error. Platform firmware
+ *                                   may also enforce state changes directly;
+ *                                   the callback must return the resulting
+ *                                   state.
+ *
+ * @DEVICE_OPER_POWER_STATE_ON:      Device is powered on and fully active.
+ *
+ * @DEVICE_OPER_POWER_STATE_OFF:     Device is powered off and inactive. It
+ *                                   should not consume resources and may
+ *                                   require reinitialization on power on.
+ *
+ * @DEVICE_OPER_POWER_STATE_STANDBY: Device is in a low-power standby state.
+ *                                   It retains enough state to allow fast
+ *                                   resume without full reinitialization.
+ *
+ * See also: PowerStateHandlerClass, powerstate_get_fn
+ */
+typedef enum DeviceOperPowerState {
+    DEVICE_OPER_POWER_STATE_UNKNOWN = -1,
+    DEVICE_OPER_POWER_STATE_ON = 0,
+    DEVICE_OPER_POWER_STATE_OFF,
+    DEVICE_OPER_POWER_STATE_STANDBY,
+    DEVICE_OPER_POWER_STATE_MAX
+} DeviceOperPowerState;
+
+/**
+ * powerstate_fn:
+ * @handler: Power state handler for the device performing the transition.
+ * @dev: The device being transitioned as a result of an administrative
+ *       state change (e.g. enable-to-disable or disable-to-enable), which
+ *       in turn affects its operational state (on, off, standby).
+ * @errp: Pointer to return an error if the function fails.
+ *
+ * Generic function signature for device power state transitions. An
+ * administrative state change triggers the corresponding operational
+ * transition, which may be implemented synchronously or asynchronously.
+ */
+typedef void (*powerstate_fn)(PowerStateHandler *handler, DeviceState *dev,
+                              Error **errp);
+
+/**
+ * powerstate_get_fn:
+ * @dev:  The device whose operational state is being queried.
+ * @errp: Pointer to an error object, set on failure.
+ *
+ * Callback type to query the current operational power state of a device.
+ * Platforms may optionally implement this to expose their internal power
+ * management status. When present, the callback must map the platform’s
+ * internal state into one of the DeviceOperPowerState values.
+ *
+ * Returns: A DeviceOperPowerState value on success. If the platform does not
+ * support state reporting, returns DEVICE_OPER_POWER_STATE_UNKNOWN without
+ * setting @errp. If the state could not be determined due to an error, sets
+ * @errp and also returns DEVICE_OPER_POWER_STATE_UNKNOWN. In this case, the
+ * return value must be ignored when @errp is set.
+ */
+typedef DeviceOperPowerState (*powerstate_get_fn)(DeviceState *dev,
+                                                  Error **errp);
+
+/**
+ * PowerStateHandlerClass:
+ *
+ * Interface for devices that support transitions of their operational power
+ * state (on, off, standby). These transitions may be driven by changes in the
+ * device’s administrative state (enable to/from disable), or initiated by the
+ * guest OSPM based on runtime policy.
+ *
+ * Administrative changes are host-driven (e.g. 'device_set') and can trigger
+ * corresponding operational transitions. QEMU may signal the guest via platform
+ * interfaces (such as ACPI) so that OSPM coordinates the change. Some platforms
+ * may also enforce transitions directly, without OSPM involvement.
+ *
+ * @parent: Opaque parent interface.
+ *
+ * @get_oper_state: Optional callback to query the current operational state.
+ *                  Implementations must map the internal state to the
+ *                  'DeviceOperPowerState' enum.
+ *
+ * @request_poweroff: Optional callback to notify the guest of internal logic
+ *                    that the device is about to be disabled. Used to initiate
+ *                    graceful shutdown or cleanup within OSPM.
+ *
+ * @post_poweroff: Callback invoked after OSPM has powered off the device
+ *                 operationally. Completes the administrative transition to
+ *                 'disabled', ensuring the device is fully inactive and not
+ *                 consuming resources.
+ *
+ * @pre_poweron: Callback to prepare a device for re-activation after an
+ *               administrative 'enable'. May reinitialize state and notify the
+ *               guest that the device is available. Guest of internal OSPM may
+ *               or may not make the device become operationally active.
+ *
+ * @request_standby: Optional callback to place the device into a standby state
+ *                   without full power-off. The device is expected to retain
+ *                   sufficient state for efficient resume, e.g. CPU_SUSPEND.
+ */
+struct PowerStateHandlerClass {
+    /* <private> */
+    InterfaceClass parent;
+
+    /* <public> */
+    powerstate_get_fn get_oper_state;
+
+    powerstate_fn request_poweroff;
+    powerstate_fn post_poweroff;
+    powerstate_fn pre_poweron;
+    powerstate_fn request_standby;
+};
+
+PowerStateHandler *powerstate_handler(DeviceState *dev);
+
+DeviceOperPowerState qdev_get_oper_power_state(DeviceState *dev);
+
+void device_request_poweroff(DeviceState *dev, Error **errp);
+
+void device_post_poweroff(DeviceState *dev, Error **errp);
+
+void device_pre_poweron(DeviceState *dev, Error **errp);
+
+void device_request_standby(DeviceState *dev, Error **errp);
+#endif /* POWERSTATE_H */
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e685..f38cdd1947 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -95,5 +95,6 @@ if have_system or have_user
 
   # Also included in have_system for tests/unit/test-qdev-global-props
   stub_ss.add(files('hotplug-stubs.c'))
+  stub_ss.add(files('powerstate-stubs.c'))
   stub_ss.add(files('sysbus.c'))
 endif
diff --git a/stubs/powerstate-stubs.c b/stubs/powerstate-stubs.c
new file mode 100644
index 0000000000..01c615cda2
--- /dev/null
+++ b/stubs/powerstate-stubs.c
@@ -0,0 +1,47 @@
+/*
+ * Device Power State handler interface Stubs.
+ *
+ * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
+ *
+ * Author: Salil Mehta <salil.mehta@huawei.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include "qemu/osdep.h"
+#include "hw/powerstate.h"
+#include "hw/qdev-core.h"
+
+PowerStateHandler *powerstate_handler(DeviceState *dev)
+{
+    return NULL;
+}
+
+DeviceOperPowerState qdev_get_oper_power_state(DeviceState *dev)
+{
+    return DEVICE_OPER_POWER_STATE_UNKNOWN;
+}
+
+void device_request_poweroff(DeviceState *dev, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void device_post_poweroff(DeviceState *dev, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void device_pre_poweron(DeviceState *dev, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void device_request_standby(DeviceState *dev, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.34.1


